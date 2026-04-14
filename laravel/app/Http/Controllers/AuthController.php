<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function getNextCode(Request $request)
    {
        $maxCode = User::whereRaw('email REGEXP "^[0-9]+$"')
            ->selectRaw('MAX(CAST(email AS UNSIGNED)) as max_code')
            ->value('max_code');
            
        if ($maxCode && $maxCode >= 1000001) {
            $code = (string)($maxCode + 1);
        } else {
            $code = '1000001';
        }
        
        return response()->json(['code' => $code]);
    }

    public function register(Request $request)
    {
        $validated = $request->validate([
            'email' => 'nullable|string|max:255|unique:users,email', // User code goes here
            'name' => 'required|string|max:255',
            'contact_email' => 'nullable|string|email|max:255',
            'password' => 'required|string|min:6',
            'department_id' => 'nullable|exists:departments,id',
            'role' => 'required|in:TEACHER,DEPT_HEAD,BOARD,QC,ADMIN',
            'gender' => 'nullable|string|max:255',
            'dob' => 'nullable|date',
        ]);

        $code = $validated['email'] ?? null;
        if (!$code) {
            $maxCode = User::whereRaw('email REGEXP "^[0-9]+$"')
                ->selectRaw('MAX(CAST(email AS UNSIGNED)) as max_code')
                ->value('max_code');
            if ($maxCode && $maxCode >= 1000001) {
                $code = (string)($maxCode + 1);
            } else {
                $code = '1000001';
            }
        }

        $user = User::create([
            'name' => $validated['name'],
            'email' => $code, // User code
            'contact_email' => $validated['contact_email'] ?? null,
            'password' => Hash::make($validated['password']),
            'department_id' => $validated['department_id'],
            'role' => $validated['role'],
            'gender' => $validated['gender'] ?? 'Nam',
            'dob' => $validated['dob'] ?? null,
            'status' => 'PENDING', // must be approved
        ]);

        return response()->json([
            'message' => 'Đăng ký thành công. Vui lòng chờ Trưởng khoa duyệt.',
            'user' => $user
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['Thông tin đăng nhập không chính xác.'],
            ]);
        }

        if ($user->status === 'PENDING') {
            return response()->json([
                'message' => 'Tài khoản của bạn đang chờ phê duyệt từ Trưởng khoa.'
            ], 403);
        }
        
        if ($user->status === 'REJECTED') {
            return response()->json([
                'message' => 'Tài khoản của bạn đã bị từ chối.'
            ], 403);
        }

        \App\Models\UserActivity::create([
            'user_id' => $user->id,
            'type' => 'login',
            'description' => 'Đăng nhập thành công'
        ]);

        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'user' => $user->load('department'),
            'token' => $token
        ]);
    }

    public function me(Request $request)
    {
        return response()->json($request->user()->load('department'));
    }

    public function getActiveUsers(Request $request)
    {
        $user = $request->user();
        
        if ($user->role === 'ADMIN' || $user->role === 'BOARD' || $user->role === 'QC') {
            $activeUsers = User::with('department')->where('status', 'ACTIVE')->get();
            return response()->json($activeUsers);
        } else if ($user->role === 'DEPT_HEAD' || $user->role === 'TEACHER') {
            // Include themselves as well
            $activeUsers = User::with('department')->where('department_id', $user->department_id)
                ->where('status', 'ACTIVE')
                ->get();
            return response()->json($activeUsers);
        }

        return response()->json(['message' => 'Không có quyền truy cập.'], 403);
    }

    public function getPendingUsers(Request $request)
    {
        $user = $request->user();
        
        if ($user->role === 'ADMIN') {
            $pendingUsers = User::with('department')->where('status', 'PENDING')->get();
            return response()->json($pendingUsers);
        } else if ($user->role === 'BOARD') {
            $pendingUsers = User::with('department')->where('role', 'DEPT_HEAD')
                ->where('status', 'PENDING')
                ->get();
            return response()->json($pendingUsers);
        } else if ($user->role === 'DEPT_HEAD') {
            $pendingUsers = User::with('department')->where('department_id', $user->department_id)
                ->where('role', 'TEACHER')
                ->where('status', 'PENDING')
                ->get();
            return response()->json($pendingUsers);
        }

        return response()->json(['message' => 'Không có quyền truy cập.'], 403);
    }

    private function canManageUser($head, $userToManage)
    {
        if ($head->role === 'ADMIN') return true;
        if ($head->role === 'BOARD') return $userToManage->role === 'DEPT_HEAD';
        if ($head->role === 'DEPT_HEAD') return $userToManage->department_id === $head->department_id && $userToManage->role === 'TEACHER';
        return false;
    }

    public function approveUser(Request $request, $id)
    {
        $head = $request->user();
        $userToApprove = User::findOrFail($id);

        if (!$this->canManageUser($head, $userToApprove)) {
            return response()->json(['message' => 'Không có quyền truy cập. Bạn chỉ có thể duyệt tài khoản thuộc quyền quản lý của mình.'], 403);
        }

        if ($userToApprove->status !== 'PENDING') {
            return response()->json(['message' => 'Người dùng không ở trạng thái chờ duyệt.'], 400);
        }

        $userToApprove->status = 'ACTIVE';
        $userToApprove->save();

        return response()->json(['message' => 'Đã duyệt tài khoản thành công.']);
    }
    
    public function rejectUser(Request $request, $id)
    {
        $head = $request->user();
        $userToReject = User::findOrFail($id);

        if (!$this->canManageUser($head, $userToReject)) {
            return response()->json(['message' => 'Không có quyền truy cập. Bạn chỉ có thể từ chối tài khoản thuộc quyền quản lý của mình.'], 403);
        }

        if ($userToReject->status !== 'PENDING') {
            return response()->json(['message' => 'Người dùng không ở trạng thái chờ duyệt.'], 400);
        }

        $userToReject->status = 'REJECTED'; 
        // Or could delete: $userToReject->delete();
        $userToReject->save();

        return response()->json(['message' => 'Đã từ chối tài khoản.']);
    }

    public function updateAvatar(Request $request)
    {
        $request->validate([
            'avatar' => 'required|image|max:5120', // Max 5MB
        ]);

        $user = $request->user();

        if ($request->hasFile('avatar')) {
            $path = $request->file('avatar')->store('avatars', 'public');
            $user->avatar = $path;
            $user->save();
            return response()->json([
                'avatar' => $path,
                'message' => 'Cập nhật avatar thành công'
            ]);
        }

        return response()->json(['message' => 'Không tìm thấy file.'], 400);
    }

    public function departments()
    {
        return response()->json(Department::all());
    }

    public function createDepartment(Request $request)
    {
        // Only BOARD can create a new department
        if ($request->user()->role !== 'BOARD') {
            return response()->json(['message' => 'Không có quyền. Chỉ Ban Giám Hiệu mới có thể tạo Khoa mới.'], 403);
        }

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'code' => 'required|string|max:50',
        ]);

        $dept = Department::create([
            'name' => $validated['name'],
            'code' => $validated['code']
        ]);

        return response()->json($dept, 201);
    }

    public function requestProfileUpdate(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'department_id' => 'required|exists:departments,id',
            'email' => 'required|string|max:255|unique:users,email,' . $user->id, // Validate trùng mã GV
            'contact_email' => 'nullable|email|max:255',
            'dob' => 'nullable|date',
            'gender' => 'nullable|string|max:255',
            'current_password' => 'nullable|string',
            'password' => 'nullable|string|min:6',
        ]);

        if (!empty($validated['password'])) {
            if (empty($validated['current_password'])) {
                return response()->json(['message' => 'Vui lòng nhập mật khẩu hiện tại để đổi mật khẩu mới.'], 400);
            }
            if (!Hash::check($validated['current_password'], $user->password)) {
                return response()->json(['message' => 'Mật khẩu hiện tại không đúng.'], 400);
            }
        }

        
        $pendingProfile = [
            'name' => $validated['name'],
            'department_id' => $validated['department_id'],
            'email' => $validated['email'], 
            'contact_email' => $validated['contact_email'],
            'dob' => $validated['dob'],
            'gender' => $validated['gender'],
        ];

        if (!empty($validated['password'])) {
            $pendingProfile['password'] = Hash::make($validated['password']);
        }

        if (in_array($user->role, ['BOARD', 'ADMIN'])) {
            $user->name = $pendingProfile['name'];
            $user->department_id = $pendingProfile['department_id'];
            $user->email = $pendingProfile['email'];
            $user->contact_email = $pendingProfile['contact_email'];
            $user->dob = $pendingProfile['dob'];
            $user->gender = $pendingProfile['gender'];
            if (isset($pendingProfile['password'])) {
                $user->password = $pendingProfile['password'];
            }
            $user->pending_profile = null;
            $user->save();

            \App\Models\UserActivity::create([
                'user_id' => $user->id,
                'type' => 'update_profile',
                'description' => 'Cập nhật hồ sơ tài khoản'
            ]);

            return response()->json([
                'message' => 'Đã lưu thông tin hồ sơ thành công.',
                'user' => $user->load('department')
            ]);
        }

        $user->pending_profile = $pendingProfile;
        $user->save();
        
        \App\Models\UserActivity::create([
            'user_id' => $user->id,
            'type' => 'request_update_profile',
            'description' => 'Gửi yêu cầu cập nhật hồ sơ'
        ]);

        return response()->json([
            'message' => 'Yêu cầu cập nhật đã được gửi cho Trưởng khoa.',
        ]);
    }

    public function getActivities(Request $request, $id)
    {
        $activities = \App\Models\UserActivity::where('user_id', $id)
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get();
        return response()->json($activities);
    }

    public function getPendingProfiles(Request $request)
    {
        $user = $request->user();
        if ($user->role === 'ADMIN' || $user->role === 'QC') {
            $users = User::whereNotNull('pending_profile')->with('department')->get();
            return response()->json($users);
        } else if ($user->role === 'BOARD') {
            $users = User::whereNotNull('pending_profile')->where('role', 'DEPT_HEAD')->with('department')->get();
            return response()->json($users);
        } else if ($user->role === 'DEPT_HEAD') {
            // Get teachers in same dept with pending_profile OR themselves? Only teachers
            $users = User::whereNotNull('pending_profile')->where('department_id', $user->department_id)
                ->where('role', 'TEACHER')->with('department')->get();
            return response()->json($users);
        }

        return response()->json(['message' => 'Không có quyền truy cập.'], 403);
    }

    public function approveProfileUpdate(Request $request, $id)
    {
        $head = $request->user();
        $userToApprove = User::findOrFail($id);

        if (!$this->canManageUser($head, $userToApprove)) {
            return response()->json(['message' => 'Không có quyền truy cập.'], 403);
        }

        $updates = $userToApprove->pending_profile;
        if (!$updates) {
            return response()->json(['message' => 'Không có yêu cầu cập nhật.'], 400);
        }

        foreach (['name', 'department_id', 'email', 'contact_email', 'dob', 'gender', 'password'] as $field) {
            if (isset($updates[$field]) || array_key_exists($field, $updates)) { // check array_key_exists for nulls
                $userToApprove->$field = $updates[$field];
            }
        }
        $userToApprove->pending_profile = null;
        $userToApprove->save();

        return response()->json(['message' => 'Đã phê duyệt cập nhật hồ sơ.', 'user' => $userToApprove->load('department')]);
    }

    public function rejectProfileUpdate(Request $request, $id)
    {
        $head = $request->user();
        $userToReject = User::findOrFail($id);

        if (!$this->canManageUser($head, $userToReject)) {
            return response()->json(['message' => 'Không có quyền truy cập.'], 403);
        }

        $userToReject->pending_profile = null;
        $userToReject->save();

        return response()->json(['message' => 'Đã từ chối cập nhật hồ sơ.']);
    }
}
