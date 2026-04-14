<?php

namespace App\Http\Controllers;

use App\Models\Plan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PlanController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        
        $query = Plan::with(['teacher', 'department', 'items', 'weeks', 'auditLogs']);

        // Role-based filtering
        if ($user) {
            $query->where(function ($q) use ($user) {
                // Everyone can see their own plans (including DRAFTS)
                $q->where('user_id', $user->id);

                if ($user->role === 'DEPT_HEAD') {
                    // Dept Head can see plans in their department that are NOT drafts
                    $q->orWhere(function ($sub) use ($user) {
                        $sub->where('department_id', $user->department_id)
                            ->where('status', '!=', 'DRAFT');
                    });
                } elseif (in_array($user->role, ['BOARD', 'QC'])) {
                    // Board/QC can see plans that have been submitted to BGH or completed
                    // Or actually, maybe they see any plan that is not a draft. Let's make it not a draft.
                    $q->orWhere('status', '!=', 'DRAFT');
                }
            });
        }

        return response()->json($query->get());
    }

    public function store(Request $request)
    {
        $items = $request->input('items', []);
        if (is_string($items)) $items = json_decode($items, true);

        $weeks = $request->input('weeks', []);
        if (is_string($weeks)) $weeks = json_decode($weeks, true);

        // Handle file upload
        $attachments = [];
        $filePath = null;
        $fileName = null;

        if ($request->hasFile('new_attachments')) {
            foreach ($request->file('new_attachments') as $file) {
                $path = $file->store('plans', 'public');
                $attachments[] = [
                    'name' => $file->getClientOriginalName(),
                    'path' => $path,
                ];
            }
        }
        
        // Legacy fallback
        if ($request->hasFile('attachedFile')) {
            $file = $request->file('attachedFile');
            $path = $file->store('plans', 'public');
            $attachments[] = [
                'name' => $file->getClientOriginalName(),
                'path' => $path,
            ];
        }

        if (count($attachments) > 0) {
            $filePath = $attachments[0]['path'];
            $fileName = $attachments[0]['name'];
        }

        $user = $request->user();

        $plan = Plan::create([
            'code' => 'KH-' . date('Y') . '-' . str_pad((Plan::max('id') ?? 0) + 1, 4, '0', STR_PAD_LEFT),
            'title' => $request->input('title'),
            'month' => $request->input('month'),
            'year' => $request->input('year'),
            'user_id' => $user->id,
            'department_id' => $user->department_id,
            'status' => 'DRAFT',
            'attachments' => $attachments,
            'attached_file_path' => $filePath,
            'attached_file_name' => $fileName,
        ]);

        if (!empty($items)) {
            foreach ($items as $item) {
                $cleanedItemData = $item;
                unset($cleanedItemData['id'], $cleanedItemData['plan_id'], $cleanedItemData['created_at'], $cleanedItemData['updated_at'], $cleanedItemData['expected_result'], $cleanedItemData['expectedResult']);
                
                $plan->items()->create([
                    'topic' => $item['topic'] ?? 'N/A',
                    'planned_hours' => $item['plannedHours'] ?? 0,
                    'expected_result' => json_encode($cleanedItemData),
                ]);
            }
        }

        if (!empty($weeks)) {
            foreach ($weeks as $week) {
                $cleanedWeekData = $week;
                unset($cleanedWeekData['id'], $cleanedWeekData['plan_id'], $cleanedWeekData['user_id'], $cleanedWeekData['created_at'], $cleanedWeekData['updated_at'], $cleanedWeekData['week_label'], $cleanedWeekData['weekLabel']);
                $plan->weeks()->create([
                    'user_id' => $user->id,
                    'week_label' => json_encode($cleanedWeekData),
                    'planned_hours' => $week['plannedHours'] ?? 0,
                ]);
            }
        }
        \App\Models\UserActivity::create([
            'user_id' => $user->id,
            'type' => 'create_plan',
            'description' => 'Tạo kế hoạch ' . $request->input('title') . ' (' . $plan->code . ')'
        ]);

        return response()->json($plan->load(['items', 'weeks', 'teacher', 'department']));
    }

    public function approvePhase1(Request $request, Plan $plan)
    {
        $user = $request->user();
        // Only Dept Head or higher can approve phase 1
        if (!in_array($user->role, ['DEPT_HEAD', 'BOARD', 'ADMIN'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'comment' => 'nullable|string',
        ]);

        $plan->update(['status' => 'DEPT_APPROVED_TO_BGH']);

        $plan->auditLogs()->create([
            'user_id' => $request->user()->id,
            'action' => 'Phê duyệt Phase 1 (Kế hoạch)',
            'comment' => $validated['comment'] ?? 'Đã phê duyệt kế hoạch.',
            'timestamp' => now(),
        ]);

        return response()->json($plan);
    }

    public function submitReport(Request $request, Plan $plan)
    {
        // Only the teacher who owns the plan can submit the report
        if ($request->user()->id !== $plan->user_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'weeks' => 'required|array', // Actual hours for each week
        ]);

        foreach ($validated['weeks'] as $weekData) {
            $week = $plan->weeks()->find($weekData['id']);
            if ($week) {
                $week->update(['actual_hours' => $weekData['actual_hours']]);
            }
        }

        $plan->update(['status' => 'REPORT_SUBMITTED']);

        $plan->auditLogs()->create([
            'user_id' => $request->user()->id,
            'action' => 'Nộp báo cáo thực hiện',
            'timestamp' => now(),
        ]);

        return response()->json($plan->load('weeks'));
    }

    public function acceptPhase2(Request $request, Plan $plan)
    {
        if (!in_array($request->user()->role, ['DEPT_HEAD', 'BOARD', 'ADMIN'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'score' => 'required|integer|min:0|max:100',
            'feedback' => 'nullable|string',
        ]);

        $plan->update([
            'status' => 'ACCEPTED_TO_BGH',
            'score' => $validated['score'],
            'feedback' => $validated['feedback'],
        ]);

        $plan->auditLogs()->create([
            'user_id' => $request->user()->id,
            'action' => 'Nghiệm thu Phase 2 (Hoàn thành)',
            'comment' => "Điểm: {$validated['score']}. Nhận xét: {$validated['feedback']}",
            'timestamp' => now(),
        ]);

        return response()->json($plan);
    }

    public function updateStatus(Request $request, Plan $plan)
    {
        $validated = $request->validate([
            'status' => 'required|string',
            'comment' => 'nullable|string',
        ]);

        $plan->update(['status' => $validated['status']]);

        $plan->auditLogs()->create([
            'user_id' => $request->user()->id,
            'action' => 'Cập nhật trạng thái: ' . $validated['status'],
            'comment' => $validated['comment'] ?? '',
        ]);

        return response()->json($plan->load(['items', 'weeks', 'teacher', 'department']));
    }

    public function update(Request $request, Plan $plan)
    {
        if ($plan->user_id !== $request->user()->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'title' => 'string|max:255',
            'month' => 'integer|min:1|max:12',
            'year' => 'integer|min:2000|max:2100',
        ]);

        $plan->update($validated);

        // Keep existing attachments
        $keptAttachments = json_decode($request->input('kept_attachments', '[]'), true);
        $finalAttachments = is_array($keptAttachments) ? $keptAttachments : [];

        // Upload new attachments
        if ($request->hasFile('new_attachments')) {
            foreach ($request->file('new_attachments') as $file) {
                $path = $file->store('plans', 'public');
                $finalAttachments[] = [
                    'name' => $file->getClientOriginalName(),
                    'path' => $path,
                ];
            }
        }
        $plan->update(['attachments' => $finalAttachments]);

        // Sync items
        if ($request->has('items')) {
            $items = is_string($request->input('items')) ? json_decode($request->input('items'), true) : $request->input('items');
            $plan->items()->delete();
            if (is_array($items)) {
                foreach ($items as $itemData) {
                    $cleanedItemData = $itemData;
                    unset($cleanedItemData['id'], $cleanedItemData['plan_id'], $cleanedItemData['created_at'], $cleanedItemData['updated_at'], $cleanedItemData['expected_result'], $cleanedItemData['expectedResult']);
                    
                    $createPayload = [
                        'topic' => $itemData['topic'] ?? 'N/A',
                        'expected_result' => json_encode($cleanedItemData),
                        'planned_hours' => $itemData['plannedHours'] ?? 0,
                    ];
                    $plan->items()->create($createPayload);
                }
            }
        }

        if ($request->has('weeks')) {
            $weeks = is_string($request->input('weeks')) ? json_decode($request->input('weeks'), true) : $request->input('weeks');
            $plan->weeks()->delete();
            if (is_array($weeks)) {
                foreach ($weeks as $weekData) {
                    $cleanedWeekData = $weekData;
                    unset($cleanedWeekData['id'], $cleanedWeekData['plan_id'], $cleanedWeekData['user_id'], $cleanedWeekData['created_at'], $cleanedWeekData['updated_at'], $cleanedWeekData['week_label'], $cleanedWeekData['weekLabel'], $cleanedWeekData['planned_hours'], $cleanedWeekData['actual_hours']);
                    $createPayload = [
                        'user_id' => $request->user()->id,
                        'week_label' => json_encode($cleanedWeekData),
                        'planned_hours' => $weekData['plannedHours'] ?? 0,
                    ];
                    $plan->weeks()->create($createPayload);
                }
            }
        }

        $plan->auditLogs()->create([
            'user_id' => $request->user()->id,
            'action' => 'Cập nhật kế hoạch',
        ]);

        \App\Models\UserActivity::create([
            'user_id' => $request->user()->id,
            'type' => 'update_plan',
            'description' => 'Cập nhật kế hoạch ' . ($validated['title'] ?? $plan->title) . ' (' . $plan->code . ')'
        ]);

        return response()->json($plan->load(['items', 'weeks', 'auditLogs', 'teacher', 'department']));
    }

    public function destroy(Request $request, Plan $plan)
    {
        // Only the owner can delete their plan
        if ($request->user()->id !== $plan->user_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        // Only allow deleting DRAFT or REJECTED plans
        if (!in_array($plan->status, ['DRAFT', 'DEPT_REJECTED_PHASE1', 'DEPT_REJECTED_PHASE2'])) {
            return response()->json(['message' => 'Cannot delete an active or approved plan'], 400);
        }

        // Delete associated files if any
        if ($plan->attached_file_path) {
            $filePath = storage_path('app/public/' . $plan->attached_file_path);
            if (file_exists($filePath)) {
                unlink($filePath);
            }
        }

        $plan->delete(); // This will cascade delete associated weeks and items if configured, else they are automatically deleted by the DB or left orphaned

        return response()->json(['message' => 'Plan deleted successfully']);
    }
}
