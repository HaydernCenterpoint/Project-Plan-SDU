<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$users = \App\Models\User::where('name', 'like', 'Giảng viên%')->get();

$firstNames = ['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Huỳnh', 'Phan', 'Vũ', 'Võ', 'Đặng', 'Bùi', 'Đỗ', 'Hồ', 'Ngô', 'Dương', 'Lý'];
$middleNames = ['Văn', 'Thị', 'Đức', 'Hữu', 'Minh', 'Ngọc', 'Quang', 'Hồng', 'Thanh', 'Tuấn', 'Công', 'Xuân', 'Kim', 'Bảo'];
$lastNames = ['Anh', 'Bình', 'Cường', 'Dũng', 'Dương', 'Đạt', 'Hải', 'Hùng', 'Huy', 'Khoa', 'Lâm', 'Long', 'Nghĩa', 'Phong', 'Phúc', 'Quân', 'Sơn', 'Thái', 'Thành', 'Trung', 'Tuấn', 'Việt', 'An', 'Châu', 'Chi', 'Diệp', 'Giang', 'Hà', 'Hân', 'Hương', 'Lan', 'Linh', 'Mai', 'Ngân', 'Nhung', 'Phương', 'Quyên', 'Tâm', 'Thảo', 'Trang', 'Tú', 'Uyên', 'Vân', 'Yến'];

foreach ($users as $user) {
    $name = $firstNames[array_rand($firstNames)] . ' ' . $middleNames[array_rand($middleNames)] . ' ' . $lastNames[array_rand($lastNames)];
    $user->name = $name;
    $user->save();
    echo "Updated {$user->email} to: $name\n";
}
