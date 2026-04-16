<?php
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use App\Models\Department;

// Find a department to assign to
$dept = Department::first();
$deptId = $dept ? $dept->id : null;

$teacher = User::firstOrCreate(
    ['email' => 'giaovien.test@saodo.edu.vn'],
    [
        'name' => 'Giáo Viên Test',
        'password' => Hash::make('password'),
        'role' => 'TEACHER',
        'department_id' => $deptId
    ]
);

$deptHead = User::firstOrCreate(
    ['email' => 'truongkhoa.test@saodo.edu.vn'],
    [
        'name' => 'Trưởng Khoa Test',
        'password' => Hash::make('password'),
        'role' => 'DEPT_HEAD',
        'department_id' => $deptId
    ]
);

$board = User::firstOrCreate(
    ['email' => 'bgh.test@saodo.edu.vn'],
    [
        'name' => 'Ban Giám Hiệu Test',
        'password' => Hash::make('password'),
        'role' => 'BOARD',
        'department_id' => null
    ]
);

echo "Created accounts successfully:\n";
echo "1. TEACHER: " . $teacher->email . " / password\n";
echo "2. DEPT_HEAD: " . $deptHead->email . " / password\n";
echo "3. BOARD: " . $board->email . " / password\n";
