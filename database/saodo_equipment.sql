-- ============================================================
-- CSDL: saodo_equipment
-- Hệ thống Quản lý Khai thác Thiết bị - Trường ĐH Sao Đỏ
-- Dữ liệu demo từ: Kế hoạch & Kết quả KTTB tháng 12/2025
-- ============================================================

CREATE DATABASE IF NOT EXISTS saodo_equipment
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE saodo_equipment;

-- ============================================================
-- 1. BẢNG: khoa (Departments / Faculties)
-- ============================================================
CREATE TABLE IF NOT EXISTS khoa (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ma_khoa     VARCHAR(20)  NOT NULL UNIQUE COMMENT 'Mã khoa',
  ten_khoa    VARCHAR(100) NOT NULL COMMENT 'Tên khoa',
  truong_khoa VARCHAR(100) COMMENT 'Tên trưởng khoa',
  created_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB COMMENT='Danh sách khoa / đơn vị';

-- ============================================================
-- 2. BẢNG: giang_vien (Lecturers)
-- ============================================================
CREATE TABLE IF NOT EXISTS giang_vien (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ho_ten     VARCHAR(100) NOT NULL COMMENT 'Họ và tên giảng viên',
  khoa_id    INT UNSIGNED NOT NULL COMMENT 'Thuộc khoa',
  created_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (khoa_id) REFERENCES khoa(id) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='Danh sách giảng viên';

-- ============================================================
-- 3. BẢNG: thiet_bi (Equipment)
-- ============================================================
CREATE TABLE IF NOT EXISTS thiet_bi (
  id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ten_thiet_bi   VARCHAR(200) NOT NULL COMMENT 'Tên thiết bị',
  ma_phong       VARCHAR(50)  COMMENT 'Mã phòng / địa điểm đặt thiết bị',
  nam_dua_vao_su_dung INT COMMENT 'Năm đưa vào sử dụng',
  mo_ta          TEXT         COMMENT 'Mô tả thiết bị',
  khoa_id        INT UNSIGNED COMMENT 'Thuộc khoa quản lý',
  created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (khoa_id) REFERENCES khoa(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Danh sách thiết bị';

-- ============================================================
-- 4. BẢNG: ke_hoach_khai_thac (Equipment Use Plan)
-- ============================================================
CREATE TABLE IF NOT EXISTS ke_hoach_khai_thac (
  id                INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  thang             TINYINT UNSIGNED NOT NULL COMMENT 'Tháng kế hoạch (1-12)',
  nam               SMALLINT UNSIGNED NOT NULL COMMENT 'Năm kế hoạch',
  khoa_id           INT UNSIGNED NOT NULL COMMENT 'Khoa lập kế hoạch',
  so_ke_hoach       VARCHAR(30)  COMMENT 'Số kế hoạch (vd: 12/KH-KĐ)',
  ngay_lap          DATE         COMMENT 'Ngày lập kế hoạch',
  nguoi_lap         VARCHAR(100) COMMENT 'Người lập / Trưởng khoa ký',
  ghi_chu           TEXT,
  created_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (khoa_id) REFERENCES khoa(id)
) ENGINE=InnoDB COMMENT='Kế hoạch khai thác thiết bị theo tháng';

-- ============================================================
-- 5. BẢNG: chi_tiet_ke_hoach (Plan Detail – per lecturer/research topic)
-- ============================================================
CREATE TABLE IF NOT EXISTS chi_tiet_ke_hoach (
  id                    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ke_hoach_id           INT UNSIGNED NOT NULL,
  stt                   TINYINT UNSIGNED COMMENT 'Số thứ tự trong kế hoạch',
  loai_doi_tuong        ENUM('giang_vien','sinh_vien') DEFAULT 'giang_vien' COMMENT 'Loại đối tượng thực hiện',
  giang_vien_id         INT UNSIGNED COMMENT 'Giảng viên thực hiện (nếu có)',
  ten_chu_de            VARCHAR(300) NOT NULL COMMENT 'Tên chủ đề / nội dung nghiên cứu',
  thiet_bi_id           INT UNSIGNED COMMENT 'Thiết bị sử dụng',
  ten_thiet_bi_text     VARCHAR(200) COMMENT 'Tên thiết bị (text dự phòng)',
  dia_diem              VARCHAR(100) COMMENT 'Địa điểm / phòng thực hiện',
  thoi_gian_thuc_hien   TEXT         COMMENT 'Mô tả thời gian thực hiện',
  so_gio_du_kien        TINYINT UNSIGNED COMMENT 'Số giờ dự kiến',
  du_kien_ket_qua       TEXT         COMMENT 'Dự kiến kết quả đạt được',
  danh_gia              ENUM('Đạt','Chưa đạt','Không thực hiện') COMMENT 'Đánh giá kết quả',
  ket_qua_dat_duoc      TEXT         COMMENT 'Kết quả thực tế đạt được',
  created_at            TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at            TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (ke_hoach_id) REFERENCES ke_hoach_khai_thac(id) ON DELETE CASCADE,
  FOREIGN KEY (giang_vien_id) REFERENCES giang_vien(id) ON DELETE SET NULL,
  FOREIGN KEY (thiet_bi_id) REFERENCES thiet_bi(id) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT='Chi tiết kế hoạch khai thác từng chủ đề';

-- ============================================================
-- 6. BẢNG: sinh_vien_tham_gia (Students participating in plan items)
-- ============================================================
CREATE TABLE IF NOT EXISTS sinh_vien_tham_gia (
  id               INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  chi_tiet_kh_id   INT UNSIGNED NOT NULL COMMENT 'Chi tiết kế hoạch',
  ho_ten           VARCHAR(100) NOT NULL COMMENT 'Họ tên sinh viên',
  vai_tro          VARCHAR(50)  DEFAULT 'Thực hiện' COMMENT 'Vai trò: Thực hiện, Hướng dẫn...',
  created_at       TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (chi_tiet_kh_id) REFERENCES chi_tiet_ke_hoach(id) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='Sinh viên tham gia khai thác thiết bị';

-- ============================================================
-- 7. BẢNG: ket_qua_kiem_tra (Monthly Monitoring Report Results)
-- ============================================================
CREATE TABLE IF NOT EXISTS ket_qua_kiem_tra (
  id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  thang           TINYINT UNSIGNED NOT NULL,
  nam             SMALLINT UNSIGNED NOT NULL,
  khoa_id         INT UNSIGNED NOT NULL,
  giang_vien_id   INT UNSIGNED NOT NULL,
  tuan_01_07      TINYINT UNSIGNED DEFAULT 0 COMMENT 'Số giờ tuần 01-07',
  tuan_08_14      TINYINT UNSIGNED DEFAULT 0 COMMENT 'Số giờ tuần 08-14',
  tuan_15_21      TINYINT UNSIGNED DEFAULT 0 COMMENT 'Số giờ tuần 15-21',
  tuan_22_28      TINYINT UNSIGNED DEFAULT 0 COMMENT 'Số giờ tuần 22-28',
  tuan_29_31      TINYINT UNSIGNED DEFAULT 0 COMMENT 'Số giờ tuần 29-31',
  so_gio_ke_hoach TINYINT UNSIGNED DEFAULT 0 COMMENT 'Tổng số giờ kế hoạch (KH)',
  so_gio_thuc_hien TINYINT UNSIGNED DEFAULT 0 COMMENT 'Tổng số giờ thực hiện (TH)',
  ghi_chu         VARCHAR(200) COMMENT 'Phòng/thiết bị sử dụng (vd: 102-X1)',
  created_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (khoa_id) REFERENCES khoa(id),
  FOREIGN KEY (giang_vien_id) REFERENCES giang_vien(id)
) ENGINE=InnoDB COMMENT='Kết quả kiểm tra giám sát hàng tháng';

-- ============================================================
-- 8. BẢNG: bao_cao_tong_hop (Summary Report per Department)
-- ============================================================
CREATE TABLE IF NOT EXISTS bao_cao_tong_hop (
  id                 INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  thang              TINYINT UNSIGNED NOT NULL,
  nam                SMALLINT UNSIGNED NOT NULL,
  khoa_id            INT UNSIGNED NOT NULL UNIQUE,
  so_giang_vien_khai_thac INT UNSIGNED DEFAULT 0,
  tong_so_gio        INT UNSIGNED DEFAULT 0,
  nguoi_xac_nhan     VARCHAR(100),
  ngay_bao_cao       DATE,
  created_at         TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (khoa_id) REFERENCES khoa(id)
) ENGINE=InnoDB COMMENT='Tổng hợp kết quả kiểm tra theo khoa';

-- ============================================================
-- ===========================  DỮ LIỆU DEMO ================
-- ============================================================

-- ------------------------------------------------------------
-- KHOA (5 khoa từ báo cáo kết quả)
-- ------------------------------------------------------------
INSERT INTO khoa (ma_khoa, ten_khoa, truong_khoa) VALUES
('KD',  'Khoa Điện',                   'Nguyễn Phương Ty'),
('KCK', 'Khoa Cơ khí',                 'Lý Văn Hình'),
('KMT', 'Khoa May và Thời trang',       'Tạ Văn Hiền'),
('KCN', 'Khoa Công nghệ thông tin',    'Vũ Bảo Tạo'),
('KOT', 'Khoa Ô tô',                   NULL);

-- ------------------------------------------------------------
-- THIẾT BỊ  (trích từ KH khai thác - Khoa Điện tháng 12/2025)
-- ------------------------------------------------------------
INSERT INTO thiet_bi (ten_thiet_bi, ma_phong, nam_dua_vao_su_dung, mo_ta, khoa_id) VALUES
('Bộ PLC Mitsubishi, hệ thống điều khiển cảm biến khói, hệ thống điều khiển trong phòng chống cháy',
 'P.106X1 / P.104X1 / P.201X1', 2017,
 'Bộ dao tạo PLC + các thiết bị cảm biến phục vụ nghiên cứu hệ thống phòng chống cháy', 1),

('Bộ PLC Mitsubishi, hệ thống điều khiển cảm biến, bảng gia công áp lực',
 'P.102X1 / P.108X1', 2017,
 'Bộ dao tạo PLC co ban; nghiên cứu ứng dụng cảm biến trong hệ thống gia công', 1),

('Bộ PLC Mitsubishi S7-1200, bảng gia công áp lực',
 'P.104X1', 2017,
 'Bộ dao tạo PLC co ban, máy tính – nghiên cứu điều khiển nhiệt độ lò nhiệt sử dụng PLC', 1),

('PLC Mitsubishi, màn hình HMI Winview, bảng gia công áp lực',
 'Không ghi rõ', 2017,
 'Nghiên cứu PC giao diện điều khiển; thiết kế giao diện điều khiển trên HMI Winview', 1),

('PLC Mitsubishi, hệ thống bảng gia công áp lực',
 'Không ghi rõ', 2017,
 'Nghiên cứu thiết kế giao diện điều khiển; khiển, giám sát hệ sản xuất sản phẩm', 1),

('Bộ PLC co ban, máy tính, PLC S7-1200',
 'P.102X1', 2017,
 'Nghiên cứu lập trình, giám sát điều khiển nhiệt độ lò sử dụng PLC S7-1200', 1),

('Bộ PLC co ban, máy tính, PLC Biến tan',
 'P.103X1', 2017,
 'Giao thiệp truyền thông PLC-Biến tan; lập trình điều kiện PID sử dụng', 1),

('PLC Mitsubishi FX3G, phần mềm GX Works2',
 'P.202X1', 2017,
 'Nghiên cứu lập trình, mô phần mềm PLC Mitsubishi; tra cứu câu hình cứng của PLC', 1),

('PLC co ban, PLC S7-1200, Zen, Logo điều khiển',
 'P.102X1 / P.103X1', 2017,
 'Nghiên cứu PLC ứng dụng; tìm hiểu các thiết bị có trong mô hình, lập trình kết nối', 1),

('Bộ QR, Động cơ servo, Máy tính',
 'P.202X1', 2017,
 'Nghiên cứu phân loại sản phẩm theo mã QR sử dụng cánh tay robot; Nghiên cứu cấu hình robot tự hành',
  1);

-- ------------------------------------------------------------
-- GIẢNG VIÊN  – Khoa Điện
-- ------------------------------------------------------------
INSERT INTO giang_vien (ho_ten, khoa_id) VALUES
('Hà Minh Tuân',     1),
('Tạ Thị Mai',       1),
('Phạm Văn Tuấn',    1),
('Nguyễn Trương Huy',1),
('Phạm Đức Khản',    1),
('Phạm Văn Tài',     1),
('Vũ Hồng Phong',    1),
('Dương Thị Hoa',    1),
('Vũ Quang Ngọc',    1);

-- Khoa Cơ khí
INSERT INTO giang_vien (ho_ten, khoa_id) VALUES
('Mạc Văn Giang',       2),
('Đào Văn Kiên',        2),
('Vũ Hoa Kỳ',           2),
('Nguyễn Thị Liễu',     2),
('Nguyễn Thị Hồng Nhung',2),
('Mạc Thị Nguyên',      2),
('Trịnh Văn Cường',     2),
('Nguyễn Hữu Chấn',     2);

-- Khoa May và Thời trang
INSERT INTO giang_vien (ho_ten, khoa_id) VALUES
('Phạm Thị Kim Phúc',  3),
('Nguyễn Thị Hội',     3),
('Đỗ Thị Lân',         3),
('Nguyễn Thị Hằng',    3),
('Nguyễn Quang Thoại', 3),
('Nguyễn Thị Hiền',    3),
('Bùi Thị Loan',       3);

-- Khoa Công nghệ thông tin
INSERT INTO giang_vien (ho_ten, khoa_id) VALUES
('Phạm Thị Hương',        4),
('Hoàng Thị An',          4),
('Nguyễn Thị Ánh Tuyết',  4),
('Hoàng Thị Ngát',        4),
('Nguyễn Thị Bích Ngọc',  4),
('Vũ Bảo Tạo',            4),
('Phạm Thị Tâm',          4),
('Nguyễn Thị Thu',        4);

-- Khoa Ô tô
INSERT INTO giang_vien (ho_ten, khoa_id) VALUES
('Phạm Văn Trọng',    5),
('Nguyễn Ngọc Đàm',   5),
('Phùng Đức Hải Anh', 5),
('Cao Huy Giáp',      5);

-- ------------------------------------------------------------
-- KẾ HOẠCH KHAI THÁC TB tháng 12/2025 – Khoa Điện
-- Số: 12/KH-KĐ, ngày 01/12/2025
-- ------------------------------------------------------------
INSERT INTO ke_hoach_khai_thac
  (thang, nam, khoa_id, so_ke_hoach, ngay_lap, nguoi_lap, ghi_chu)
VALUES
  (12, 2025, 1, '12/KH-KĐ', '2025-12-01',
   'TS. Nguyễn Phương Ty – Trưởng khoa Điện',
   'Khai thác thiết bị tại Trung tâm Thực hành, thực nghiệm điện – Tháng 12/2025');

-- Lấy id vừa insert (1)
-- Mục I: Giảng viên (8 chủ đề)
INSERT INTO chi_tiet_ke_hoach
  (ke_hoach_id, stt, loai_doi_tuong, giang_vien_id, ten_chu_de,
   thiet_bi_id, dia_diem, thoi_gian_thuc_hien, so_gio_du_kien,
   du_kien_ket_qua, danh_gia, ket_qua_dat_duoc)
VALUES
-- 1. Nghiên cứu ứng dụng cảm biến (Phạm Văn Tuấn)
(1, 1, 'giang_vien', 3,
 'Nghiên cứu ứng dụng cảm biến trong hệ thống phòng chống cháy nổ',
 1, 'P.106X1; P.104X1; P.201X1',
 'Tiết 2-4 ngày 01, 02, 05, 08, 09, 12, 15, 16, 17, 18, 19, 22, 24/12',
 39,
 'Viết được chương trình điều khiển, giám sát hệ thống; đầu nối, vận hành được thiết bị',
 'Đạt', 'Viết được chương trình điều khiển điều khiển, giám sát trên HMI; cài đặt được các chế độ cho cảm biến, đầu nối, vận hành được các thiết bị đúng yêu cầu'),

-- 2. Nghiên cứu cảm biến PLC S7-1200 nhiệt độ (Nguyễn Trương Huy)
(1, 2, 'giang_vien', 4,
 'Thiết kế giao diện điện trên HMI điều khiển ổn định nhiệt độ lò nhiệt sử dụng PLC S7-1200',
 3, 'P.102X1',
 'Tiết 2-4 ngày 02, 09, 16, 23/12',
 12,
 'Thiết kế được giao diện điều khiển điện khiển, giám sát, vận hành được hệ thống; tìm hiểu các thiết bị có trong mô hình HMI',
 'Đạt', NULL),

-- 3. Nghiên cứu giao diện HMI điều khiển PLC bảng gia công (Hà Minh Tuân)
(1, 3, 'giang_vien', 1,
 'Nghiên cứu thiết kế giao diện điều khiển PLC, khiển giám sát hệ sản xuất sản phẩm bảng gia công áp lực',
 4, 'Phòng thực hành',
 'Tiết 1-4 ngày 03, 04, 08, 09 10/12',
 20,
 'Viết được chương trình điều khiển điều khiển, giám sát hệ thống; đầu nối, vận hành được thiết bị; thiết kế giao diện điều khiển điện khiển, giám sát; kết nối HMI',
 'Đạt', NULL),

-- 4. Nghiên cứu thiết kế giao diện HMI bảng gia công (Nguyễn Thị Sim)
(1, 4, 'giang_vien', 4,
 'Nghiên cứu thiết kế giao diện điều khiển PLC, khiển, giám sát hệ sản xuất sản phẩm bảng gia công áp lực',
 5, 'Phòng thực hành',
 'Từ 07h30-10h30 ngày 01, 02, 03, 05, 08, 09, 10, 15, 16, 17/12',
 30,
 'Viết được chương trình điều khiển, giám sát hệ thống; đầu nối, vận hành được hệ thiết bị; thiết kế giao diện điều khiển; kết nối HMI',
 'Đạt', NULL),

-- 5. Nghiên cứu PLC Mitsubishi + HMI giao tiếp (Vũ Trí Vỗ)
(1, 5, 'giang_vien', 6,
 'Nghiên cứu PLC Mitsubishi giao tiếp với màn hình HMI',
 4, 'Phòng thực hành',
 'Từ 08h00-10h00 ngày 08, 09, 10, 11, 12, 15, 16, 17, 18, 19, 22, 23, 24, 25, 26, 29, 30, 31/12',
 36,
 'Đầu nối, vận hành được các thiết bị; viết được chương trình điều khiển điện khiển điều thiết bị; thiết kế giao diện điều khiển, giám sát trên HMI',
 'Đạt', NULL),

-- 6. Nghiên cứu lập trình PLC S7-1200 điều khiển nhiệt độ (Phạm Văn Tài)
(1, 6, 'giang_vien', 6,
 'Nghiên cứu lập trình, giám sát điều khiển nhiệt độ lò sử dụng PLC S7-1200 + ổn định nhiệt độ lò',
 6, 'P.104X1',
 'Từ 08h00-10h00 ngày 09, 10, 11, 12, 15, 16, 17, 18, 19, 22, 23, 24, 25, 26, 29, 30, 31/12',
 36,
 'Cài đặt truyền thông được các thiết bị; đầu nối, vận hành được hệ thống điều khiển; viết được chương trình điều khiển điều khiển, giám sát hệ thống',
 'Đạt', NULL),

-- 7. Giao thiệp truyền thông PLC-Biến tần (Vũ Hồng Phong)
(1, 7, 'giang_vien', 7,
 'Giao thiệp truyền thông PLC-Biến tần',
 7, 'P.103X1',
 'Từ 13h30-15h30 ngày 16, 17, 18, 23, 24, 25, 30, 31/12; 08/12 từ 07h20-10h20',
 26,
 'Lập trình điều kiện PID sử dụng PLC S7-1200; viết chương trình điều khiển, giám sát điều thiết bị, giao tiếp thiết bị biến tần; cài đặt biến tần',
 'Đạt', NULL),

-- 8. Nghiên cứu lập trình PLC FX3G (Dương Thị Hoa)
(1, 8, 'giang_vien', 8,
 'Nghiên cứu, lập trình, giám sát điều khiển nhiệt độ lò sử dụng PLC S7-1200; thông phần mềm PLC Mitsubishi, mô phần mềm GX Works2',
 8, 'P.202X1',
 'Tiết 2-4 ngày 01, 02, 03, 04, 05, 08, 09 10, 11/12; tiết 7-9 ngày 01, 02, 03, 08/12',
 45,
 'Giám sát tổng các điều kiện an toàn thiết bị; đầu nối, vận hành hệ thống điều khiển HMI; thiết kế chương trình điều khiển theo yêu cầu công nghệ',
 'Đạt', NULL);

-- Mục II: Sinh viên (chủ đề nghiên cứu cùng GV)
INSERT INTO chi_tiet_ke_hoach
  (ke_hoach_id, stt, loai_doi_tuong, giang_vien_id, ten_chu_de,
   thiet_bi_id, dia_diem, thoi_gian_thuc_hien, so_gio_du_kien,
   du_kien_ket_qua, danh_gia, ket_qua_dat_duoc)
VALUES
-- SV1: Thiết kế giao điện HMI điều khiển ổn định nhiệt độ (GV: Nguyễn Trương Huy)
(1, 1, 'sinh_vien', 4,
 'Thiết kế giao điện HMI điều khiển ổn định nhiệt độ lò nhiệt sử dụng PLC S7-1200',
 3, 'P.102X1',
 'Tiết 2-4 ngày 02, 09, 16, 23/12',
 12,
 'Tìm hiểu các thiết bị có trong mô hình; viết được chương trình điều khiển; đầu nối, vận hành được thiết bị; vận hành HMI',
 'Đạt', NULL),

-- SV2: Nghiên cứu thiết kế PLC giao điện điều khiển bảng gia công (GV: Hà Minh Tuân)
(1, 2, 'sinh_vien', 1,
 'Nghiên cứu thiết kế giao diện điều khiển PLC, khiển, giám sát hệ sản xuất sản phẩm bảng gia công áp lực + Khiển Zenon PLC',
 5, 'P.102X1 / P.103X1',
 'Tiết 1-4 ngày 03, 04, 08, 09, 10/12; tiết 2-4 ngày 02, 03, 04 05, 09, 10, 15, 17, 22/12',
 42,
 'Đầu nối, vận hành được thiết bị, vận hành, lập trình kết nối PLC Zen, đầu nối, vận hành mô hình',
 'Đạt', NULL),

-- SV3: Nghiên cứu PLC S7-1200 (GV: Tạ Thị Mai)
(1, 3, 'sinh_vien', 2,
 'Nghiên cứu PLC S7-1200 ứng dụng; cắt nguồn dự phòng; cài đặt điều khiển ZEN điều khiển động',
 9, 'P.203X1',
 'Tiết 1-4 ngày 03, 04, 08, 09; tiết 7-9 ngày 02, 03, 04; 05, 09, 18, 26/12',
 42,
 'Tìm hiểu các thiết bị, vận hành, lập trình kết nối; đầu nối, vận hành mô hình',
 'Đạt', NULL),

-- SV4: Nghiên cứu phân loại sản phẩm QR + robot (GV: Vũ Quang Ngọc)
(1, 4, 'sinh_vien', 9,
 'Nghiên cứu phân loại sản phẩm theo mã QR sử dụng cánh tay robot',
 10, 'P.202X1',
 'Tiết 2-3 ngày 10, 17, 24/12',
 6,
 'Tổng quan về mô hình robot tự hành, tay robot; Nghiên cứu cấu hình hoạt động của thiết bị',
 'Đạt', NULL);

-- Sinh viên tham gia từng chủ đề
INSERT INTO sinh_vien_tham_gia (chi_tiet_kh_id, ho_ten, vai_tro) VALUES
-- Chi tiết 9 (SV1)
(9,  'Vương Đức Tuấn', 'Thực hiện'),
(9,  'Nguyễn Minh Trí', 'Thực hiện'),
(9,  'Nguyễn Trọng Nhật', 'Thực hiện'),
-- Chi tiết 10 (SV2)
(10, 'Trương Hải Đăng', 'Thực hiện'),
(10, 'Đỗ Văn Hùng', 'Thực hiện'),
-- Chi tiết 11 (SV3) – không có tên cụ thể
-- Chi tiết 12 (SV4) - không có tên cụ thể (GV: Vũ Quang Ngọc)
(12, 'Sinh viên thực hiện 1', 'Thực hiện');

-- ------------------------------------------------------------
-- KẾT QUẢ KIỂM TRA GIÁM SÁT – Tháng 12/2025
-- (Báo cáo của Phòng Quản lý Chất lượng, ngày 31/12/2025)
-- ------------------------------------------------------------

-- === I. Khoa Điện ===
INSERT INTO ket_qua_kiem_tra
  (thang, nam, khoa_id, giang_vien_id,
   tuan_01_07, tuan_08_14, tuan_15_21, tuan_22_28, tuan_29_31,
   so_gio_ke_hoach, so_gio_thuc_hien, ghi_chu)
VALUES
(12, 2025, 1, 1,  3,  3,  3, 3, 0, 12, 12, '102-X1'),
(12, 2025, 1, 2,  8, 12,  0, 0, 0, 10, 20, '203-X1'),
(12, 2025, 1, 3,  9,  9, 15, 6, 0, 39, 39, '104; 106; 201-X1'),
(12, 2025, 1, 4, 12,  9,  9, 0, 0, 30, 30, '102-X1; 108-X1'),
(12, 2025, 1, 5, 24,  6,  6, 6, 0, 42, 42, '103-X1'),
(12, 2025, 1, 6,  0, 10, 10,10, 6, 36, 36, '104-X1'),
(12, 2025, 1, 7,  2,  0,  9, 9, 6, 26, 26, '101-X1'),
(12, 2025, 1, 8, 30, 15,  0, 0, 0, 45, 45, '102-X1'),
(12, 2025, 1, 9,  0,  2,  2, 2, 0,  6,  6, '202-X1');

-- === II. Khoa Cơ khí ===
INSERT INTO ket_qua_kiem_tra
  (thang, nam, khoa_id, giang_vien_id,
   tuan_01_07, tuan_08_14, tuan_15_21, tuan_22_28, tuan_29_31,
   so_gio_ke_hoach, so_gio_thuc_hien, ghi_chu)
VALUES
(12, 2025, 2, 10,  0, 30,  6,  0, 0,  36, 36, '101-X3'),
(12, 2025, 2, 11,  0, 30, 25, 10, 0,  65, 65, 'P.TH CNC-X4'),
(12, 2025, 2, 12,  8,  8,  8,  0, 0,  24, 24, 'P.TH CNC-X4'),
(12, 2025, 2, 13, 10,  0,  0,  0, 0,  10, 10, '305B'),
(12, 2025, 2, 14,  8,  8,  4,  0, 0,  20, 20, '305B'),
(12, 2025, 2, 15,  8, 12,  8,  0, 0,  28, 28, '305B'),
(12, 2025, 2, 16,  6, 12,  6,  0, 0,  24, 24, 'P. làm việc- X3'),
(12, 2025, 2, 17,  3,  6,  3,  0, 0,  12, 12, '101-X3');

-- === III. Khoa May và Thời trang ===
INSERT INTO ket_qua_kiem_tra
  (thang, nam, khoa_id, giang_vien_id,
   tuan_01_07, tuan_08_14, tuan_15_21, tuan_22_28, tuan_29_31,
   so_gio_ke_hoach, so_gio_thuc_hien, ghi_chu)
VALUES
(12, 2025, 3, 18, 0, 0, 6, 6, 0, 12, 12, 'Văn phòng khoa'),
(12, 2025, 3, 19, 0, 6, 6, 6, 0,  9, 18, 'Văn phòng khoa'),
(12, 2025, 3, 20, 0, 0, 6, 3, 3, 12, 12, 'Văn phòng khoa'),
(12, 2025, 3, 21, 0, 6, 6, 6, 0, 18, 18, 'Văn phòng khoa'),
(12, 2025, 3, 22, 0, 3, 3, 3, 0,  9,  9, 'Văn phòng khoa'),
(12, 2025, 3, 23, 0, 3, 3, 6, 0, 12, 12, 'Văn phòng khoa'),
(12, 2025, 3, 24, 0, 3, 3, 3, 0,  9,  9, 'Văn phòng khoa');

-- === IV. Khoa Công nghệ thông tin ===
INSERT INTO ket_qua_kiem_tra
  (thang, nam, khoa_id, giang_vien_id,
   tuan_01_07, tuan_08_14, tuan_15_21, tuan_22_28, tuan_29_31,
   so_gio_ke_hoach, so_gio_thuc_hien, ghi_chu)
VALUES
(12, 2025, 4, 25, 0, 7, 7, 0, 0, 14, 14, 'Kết hợp HD sinh viên'),
(12, 2025, 4, 26, 0, 3, 3, 3, 0,  9,  9, '202-X4'),
(12, 2025, 4, 27, 0, 0, 3, 3, 0,  6,  6, '201-X4'),
(12, 2025, 4, 28, 0, 0, 7, 0, 0,  7,  7, '207-X4'),
(12, 2025, 4, 29, 2, 2, 2, 0, 0,  6,  6, '203-X4'),
(12, 2025, 4, 30, 0, 0, 3, 0, 0,  3,  3, '202-X4'),
(12, 2025, 4, 31, 0, 6, 3, 0, 0,  9,  9, '203-X4'),
(12, 2025, 4, 32, 2, 2, 0, 0, 0,  4,  4, '203-X4');

-- === V. Khoa Ô tô (không thực hiện) ===
INSERT INTO ket_qua_kiem_tra
  (thang, nam, khoa_id, giang_vien_id,
   tuan_01_07, tuan_08_14, tuan_15_21, tuan_22_28, tuan_29_31,
   so_gio_ke_hoach, so_gio_thuc_hien, ghi_chu)
VALUES
(12, 2025, 5, 33, 0, 0, 0, 0, 0, 0, 0, NULL),
(12, 2025, 5, 34, 0, 0, 0, 0, 0, 0, 0, NULL),
(12, 2025, 5, 35, 0, 0, 0, 0, 0, 0, 0, NULL),
(12, 2025, 5, 36, 0, 0, 0, 0, 0, 0, 0, NULL);

-- ------------------------------------------------------------
-- BÁO CÁO TỔNG HỢP (từ phần B – trang 2 báo cáo)
-- ------------------------------------------------------------
INSERT INTO bao_cao_tong_hop
  (thang, nam, khoa_id, so_giang_vien_khai_thac, tong_so_gio, nguoi_xac_nhan, ngay_bao_cao)
VALUES
(12, 2025, 1, 9,  256, 'Nguyễn Phương Ty', '2025-12-31'),
(12, 2025, 2, 8,  219, 'Lý Văn Hình',      '2025-12-31'),
(12, 2025, 3, 7,   90, 'Tạ Văn Hiền',      '2025-12-31'),
(12, 2025, 4, 8,   58, 'Vũ Bảo Tạo',       '2025-12-31'),
(12, 2025, 5, 4,    0, NULL,               '2025-12-31');

-- ============================================================
-- VIEW hữu ích cho ứng dụng
-- ============================================================

-- View: Tổng hợp kết quả theo giảng viên – tháng 12/2025
CREATE OR REPLACE VIEW v_ket_qua_giang_vien AS
SELECT
  k.ten_khoa,
  gv.ho_ten   AS giang_vien,
  kt.tuan_01_07, kt.tuan_08_14, kt.tuan_15_21, kt.tuan_22_28, kt.tuan_29_31,
  kt.so_gio_ke_hoach   AS gio_KH,
  kt.so_gio_thuc_hien  AS gio_TH,
  ROUND(kt.so_gio_thuc_hien * 100.0 / NULLIF(kt.so_gio_ke_hoach,0), 1) AS ty_le_hoanthanh_pct,
  kt.ghi_chu,
  kt.thang, kt.nam
FROM ket_qua_kiem_tra kt
JOIN khoa   k  ON k.id = kt.khoa_id
JOIN giang_vien gv ON gv.id = kt.giang_vien_id
ORDER BY k.id, gv.ho_ten;

-- View: Tổng hợp theo khoa
CREATE OR REPLACE VIEW v_tong_hop_khoa AS
SELECT
  k.ten_khoa,
  bt.so_giang_vien_khai_thac AS so_GV,
  bt.tong_so_gio,
  bt.nguoi_xac_nhan,
  bt.ngay_bao_cao,
  bt.thang, bt.nam
FROM bao_cao_tong_hop bt
JOIN khoa k ON k.id = bt.khoa_id
ORDER BY bt.tong_so_gio DESC;

-- View: Chi tiết kế hoạch Khoa Điện
CREATE OR REPLACE VIEW v_ke_hoach_khoa_dien AS
SELECT
  ct.stt,
  ct.loai_doi_tuong,
  gv.ho_ten          AS nguoi_thuc_hien,
  ct.ten_chu_de,
  tb.ten_thiet_bi,
  ct.dia_diem,
  ct.thoi_gian_thuc_hien,
  ct.so_gio_du_kien,
  ct.du_kien_ket_qua,
  ct.danh_gia,
  ct.ket_qua_dat_duoc
FROM chi_tiet_ke_hoach ct
JOIN ke_hoach_khai_thac kh ON kh.id = ct.ke_hoach_id
LEFT JOIN giang_vien gv ON gv.id = ct.giang_vien_id
LEFT JOIN thiet_bi tb ON tb.id = ct.thiet_bi_id
WHERE kh.khoa_id = 1 AND kh.thang = 12 AND kh.nam = 2025
ORDER BY ct.loai_doi_tuong, ct.stt;
