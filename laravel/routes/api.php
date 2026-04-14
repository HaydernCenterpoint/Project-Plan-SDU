<?php

use App\Http\Controllers\PlanController;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Artisan;

Route::get('/trigger-migrate', function () {
    Artisan::call('migrate', ['--force' => true]);
    return "Migrated successfully!";
});

Route::get('/seed-demo', function () {
    $depts = \App\Models\Department::all();
    if ($depts->isEmpty()) {
        \App\Models\Department::create(['id' => 1, 'name' => 'Khoa Công nghệ thông tin', 'code' => 'CNTT']);
        \App\Models\Department::create(['id' => 2, 'name' => 'Khoa May và Thời trang', 'code' => 'KMT']);
        \App\Models\Department::create(['id' => 3, 'name' => 'Khoa Cơ khí', 'code' => 'KCK']);
        \App\Models\Department::create(['id' => 4, 'name' => 'Khoa Điện', 'code' => 'KD']);
        \App\Models\Department::create(['id' => 5, 'name' => 'Khoa Ô tô', 'code' => 'KOT']);
        $depts = \App\Models\Department::all();
    }

    $count = 0;
    foreach ($depts as $idx => $dept) {
        $prefix = strtolower($dept->code);
        for ($i = 1; $i <= 5; $i++) {
            $email = "{$prefix}{$i}@saodo.edu.vn";
            $user = \App\Models\User::firstOrCreate(
                ['email' => $email],
                [
                    'name' => "Giảng viên $i ({$dept->name})",
                    'password' => \Illuminate\Support\Facades\Hash::make('password123'),
                    'role' => 'TEACHER',
                    'department_id' => $dept->id,
                    'status' => 'ACTIVE'
                ]
            );
            if ($user->wasRecentlyCreated) {
                $count++;
            }
        }
    }
    return response()->json(['message' => "Seeded $count demo users successfully!"]);
});

// Route for explicitly downloading the file
Route::get('/storage/plans/{filename}', function ($filename) {
    $path = storage_path('app/public/plans/' . $filename);
    if (!file_exists($path)) abort(404);

    $mimeTypes = [
        'pdf'  => 'application/pdf',
        'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'doc'  => 'application/msword',
        'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'xls'  => 'application/vnd.ms-excel',
    ];

    $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
    $contentType = $mimeTypes[$ext] ?? mime_content_type($path);

    return response()->file($path, [
        'Content-Type' => $contentType,
        'Access-Control-Allow-Origin' => '*',
        'Content-Disposition' => 'attachment; filename="' . $filename . '"',
    ]);
});

// Return file as base64 JSON. IDM NEVER intercepts JSON responses.
Route::post('/preview-file', function (\Illuminate\Http\Request $request) {
    try {
        $filePath = $request->input('path');
        if (!$filePath) abort(400);
        
        $path = storage_path('app/public/' . $filePath);
        if (!file_exists($path)) abort(404);

        $data = base64_encode(file_get_contents($path));

        return response()->json([
            'data' => $data,
        ]);
    } catch (\Exception $e) {
        abort(404);
    }
});

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/departments', [AuthController::class, 'departments']);
Route::get('/users/next-code', [AuthController::class, 'getNextCode']);

// Routes that require authentication
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/me', [AuthController::class, 'me']);
    
    // Departments
    Route::post('/departments', [AuthController::class, 'createDepartment']);
    
    // Dept Head Approval Routes
    Route::get('/users/active', [AuthController::class, 'getActiveUsers']);
    Route::get('/users/pending', [AuthController::class, 'getPendingUsers']);
    Route::put('/users/{id}/approve', [AuthController::class, 'approveUser']);
    Route::put('/users/{id}/reject', [AuthController::class, 'rejectUser']);
    
    // User Profile Routes
    Route::post('/users/avatar', [AuthController::class, 'updateAvatar']);
    Route::post('/users/profile-request', [AuthController::class, 'requestProfileUpdate']);
    Route::get('/users/{id}/activities', [AuthController::class, 'getActivities']);
    Route::get('/users/pending-profiles', [AuthController::class, 'getPendingProfiles']);
    Route::put('/users/{id}/approve-profile', [AuthController::class, 'approveProfileUpdate']);
    Route::put('/users/{id}/reject-profile', [AuthController::class, 'rejectProfileUpdate']);

    // Plans Routes
    Route::get('/plans', [PlanController::class, 'index']);
    Route::post('/plans', [PlanController::class, 'store']);
    Route::post('/plans/{plan}', [PlanController::class, 'update']);
    Route::put('/plans/{plan}/status', [PlanController::class, 'updateStatus']);
    Route::put('/plans/{plan}/approve-p1', [PlanController::class, 'approvePhase1']);
    Route::put('/plans/{plan}/submit-report', [PlanController::class, 'submitReport']);
    Route::put('/plans/{plan}/accept-p2', [PlanController::class, 'acceptPhase2']);
    Route::delete('/plans/{plan}', [PlanController::class, 'destroy']);
});
