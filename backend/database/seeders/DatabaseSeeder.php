<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Department;
use App\Models\Location;
use App\Models\Equipment;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // ============================================================
        // 1. DEPARTMENTS 
        // ============================================================
        $khoaDien  = Department::create(['name' => 'Khoa Điện',                  'code' => 'KD']);
        $khoaCK    = Department::create(['name' => 'Khoa Cơ khí',                'code' => 'KCK']);
        $khoaMT    = Department::create(['name' => 'Khoa May và Thời trang',     'code' => 'KMT']);
        $khoaCNTT  = Department::create(['name' => 'Khoa Công nghệ thông tin',   'code' => 'CNTT']);
        $khoaOto   = Department::create(['name' => 'Khoa Ô tô',                  'code' => 'KOT']);

        // ============================================================
        // 2. LOCATIONS  (phòng thực hành)
        // ============================================================
        $locs = [];
        $roomNames = [
            '101-X1','102-X1','103-X1','104-X1','106-X1','108-X1',
            '201-X1','202-X1','203-X1',
            '101-X3','P.TH CNC-X4','P. làm việc-X3','305B',
            '201-X4','202-X4','203-X4','207-X4',
            'Văn phòng khoa','Phòng thực hành điện',
        ];
        foreach ($roomNames as $r) {
            $locs[$r] = Location::create(['name' => $r, 'code' => $r]);
        }

        // ============================================================
        // 3. EQUIPMENT  (thiết bị Khoa Điện từ KH PDF)
        // ============================================================
        $equipmentData = [
            ['name' => 'Bộ PLC Mitsubishi + cảm biến phòng chống cháy',       'code' => 'PLC-CB-01', 'year' => 2017],
            ['name' => 'Bộ PLC Mitsubishi + bảng gia công áp lực',             'code' => 'PLC-GC-02', 'year' => 2017],
            ['name' => 'Bộ PLC S7-1200 + máy tính điều khiển nhiệt độ lò',     'code' => 'S71200-01', 'year' => 2017],
            ['name' => 'PLC Mitsubishi + màn hình HMI Winview',                 'code' => 'HMI-WIN-01','year' => 2017],
            ['name' => 'PLC Mitsubishi + bảng gia công áp lực (2)',             'code' => 'PLC-GC-03', 'year' => 2017],
            ['name' => 'Bộ PLC S7-1200 điều khiển nhiệt độ lò (2)',             'code' => 'S71200-02', 'year' => 2017],
            ['name' => 'Bộ PLC Biến tần truyền thông',                          'code' => 'PLC-BT-01', 'year' => 2017],
            ['name' => 'PLC Mitsubishi FX3G + phần mềm GX Works2',             'code' => 'FX3G-01',   'year' => 2017],
            ['name' => 'PLC S7-1200 + Zen + Logo cắt nguồn dự phòng',          'code' => 'ZEN-01',    'year' => 2016],
            ['name' => 'Cánh tay Robot + QR scanner + Động cơ Servo',          'code' => 'ROBOT-01',  'year' => 2017],
            ['name' => 'Máy CNC (P.TH CNC-X4)',                                'code' => 'CNC-01',    'year' => 2018],
            ['name' => 'Băng tải + PLC 305B',                                  'code' => 'PLC-305B',  'year' => 2019],
        ];
        foreach ($equipmentData as $e) {
            Equipment::create([
                'name'        => $e['name'],
                'code'        => $e['code'],
                'year_of_use' => $e['year'],
            ]);
        }

        // ============================================================
        // 4. USERS (Theo yêu cầu)
        // ============================================================
        
        // ADMIN Quyền cao nhất
        User::create([
            'name' => 'Quản trị hệ thống', 'email' => '1000001',
            'password' => Hash::make('123456'), 'role' => 'ADMIN', 'department_id' => null,
        ]);

        // Ban Giám Hiệu
        User::create([
            'name' => 'Đỗ Văn Đỉnh', 'email' => '01006030',
            'password' => Hash::make('123456'), 'role' => 'BOARD', 'department_id' => null,
        ]);

        // Trưởng khoa CNTT - Thêm tạm 1 tài khoản trưởng khoa để test flow duyệt bước 1 vì theo flow yêu cầu phải có
        User::create([
            'name' => 'Trưởng Khoa CNTT', 'email' => '1000003',
            'password' => Hash::make('123456'), 'role' => 'DEPT_HEAD', 'department_id' => $khoaCNTT->id,
            'contact_email' => 'truongkhoa_cntt@saodo.edu.vn'
        ]);

        // 3 Tài khoản Giáo viên (Khoa CNTT)
        User::create([
            'name' => 'Hoàng Thị An', 'email' => '1000004',
            'password' => Hash::make('123456'), 'role' => 'TEACHER', 'department_id' => $khoaCNTT->id,
            'contact_email' => 'anHT@saodo.edu.vn'
        ]);
        
        User::create([
            'name' => 'Hoàng Thị Ngát', 'email' => '1000005',
            'password' => Hash::make('123456'), 'role' => 'TEACHER', 'department_id' => $khoaCNTT->id,
            'contact_email' => 'ngatHT@saodo.edu.vn'
        ]);

        User::create([
            'name' => 'Phạm Thị Hường', 'email' => '1000006',
            'password' => Hash::make('123456'), 'role' => 'TEACHER', 'department_id' => $khoaCNTT->id,
            'contact_email' => 'huongPT@saodo.edu.vn'
        ]);
    }
}
