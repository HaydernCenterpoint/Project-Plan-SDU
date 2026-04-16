-- ============================================================
-- FIX SCRIPT cho CSDL saodo_equipment
-- Ngày tạo: 2026-04-16
-- Mô tả: Sửa tất cả lỗi được phát hiện trong quá trình audit
-- ============================================================

START TRANSACTION;

-- ============================================================
-- 1. XÓA VIEWs tham chiếu bảng không tồn tại
-- ============================================================
-- Các VIEWs này tham chiếu đến schema cũ (tiếng Việt không dấu)
-- mà các bảng tương ứng không có trong database hiện tại.

DROP VIEW IF EXISTS `v_ket_qua_giang_vien`;
DROP VIEW IF EXISTS `v_ke_hoach_khoa_dien`;
DROP VIEW IF EXISTS `v_tong_hop_khoa`;

-- Xóa placeholder tables (nếu tồn tại từ lần import trước)
DROP TABLE IF EXISTS `v_ket_qua_giang_vien`;
DROP TABLE IF EXISTS `v_ke_hoach_khoa_dien`;
DROP TABLE IF EXISTS `v_tong_hop_khoa`;

-- ============================================================
-- 2. SỬA GIỚI TÍNH BỊ SAI
-- ============================================================
-- Các user có tên chứa "Thị" (chỉ nữ) nhưng bị gán gender = 'Nam'

UPDATE `users` SET `gender` = 'Nữ' WHERE `id` = 42 AND `name` = 'Tạ Thị Mai';
UPDATE `users` SET `gender` = 'Nữ' WHERE `id` = 57 AND `name` = 'Dương Thị Hoa';
UPDATE `users` SET `gender` = 'Nữ' WHERE `id` = 58 AND `name` = 'Nguyễn Thị Việt Hương';
UPDATE `users` SET `gender` = 'Nữ' WHERE `id` = 19 AND `name` = 'Nguyễn Thị Hằng';

-- ============================================================
-- 3. SỬA LỖI CHÍNH TẢ TÊN
-- ============================================================
-- "Phưpng" → "Phương"

UPDATE `users` SET `name` = 'Nguyễn Thị Phương Oanh' WHERE `id` = 60 AND `name` = 'Nguyễn Thị Phưpng Oanh';

-- ============================================================
-- 4. CHUẨN HÓA MÃ NHÂN SỰ (email field)
-- ============================================================
-- Thêm '0' đầu cho các mã bị thiếu

UPDATE `users` SET `email` = '01021008' WHERE `id` = 25 AND `email` = '1021008';
UPDATE `users` SET `email` = '01021009' WHERE `id` = 61 AND `email` = '1021009';

-- ============================================================
-- 5. THÊM UNIQUE CONSTRAINT cho equipment.code
-- ============================================================
-- Đảm bảo mã thiết bị không bị trùng

ALTER TABLE `equipment` ADD UNIQUE KEY `equipment_code_unique` (`code`);

-- ============================================================
-- 6. THÊM UNIQUE CONSTRAINT cho locations.code
-- ============================================================
-- Đảm bảo mã vị trí không bị trùng

ALTER TABLE `locations` ADD UNIQUE KEY `locations_code_unique` (`code`);

-- ============================================================
-- 7. THÊM INDEX cho các cột thường dùng để lọc/tìm kiếm
-- ============================================================

ALTER TABLE `plans` ADD KEY `plans_status_index` (`status`);
ALTER TABLE `plans` ADD KEY `plans_month_year_index` (`month`, `year`);
ALTER TABLE `plan_items` ADD KEY `plan_items_type_index` (`type`);

-- ============================================================
-- 8. THÊM UNIQUE CONSTRAINT cho plan_weeks
-- ============================================================
-- Tránh trùng lặp tuần của cùng 1 user trong cùng 1 plan

ALTER TABLE `plan_weeks` ADD UNIQUE KEY `plan_weeks_unique` (`plan_id`, `user_id`, `week_label`);

-- ============================================================
-- 9. GÁN LOCATION CHO EQUIPMENT (dựa trên tên thiết bị)
-- ============================================================
-- Mapping dựa trên thông tin trong tên/mã thiết bị:
-- CNC-01 → location "P.TH CNC-X4" (id=11)
-- PLC-305B → location "305B" (id=13)

UPDATE `equipment` SET `location_id` = 11 WHERE `id` = 11 AND `code` = 'CNC-01';
UPDATE `equipment` SET `location_id` = 13 WHERE `id` = 12 AND `code` = 'PLC-305B';

-- ============================================================
-- 10. DỌN DẸP TOKEN CŨ (giữ lại token mới nhất của mỗi user)
-- ============================================================
-- Xóa các token cũ, chỉ giữ token gần nhất của mỗi user

DELETE t1 FROM `personal_access_tokens` t1
INNER JOIN `personal_access_tokens` t2
WHERE t1.`tokenable_id` = t2.`tokenable_id`
  AND t1.`tokenable_type` = t2.`tokenable_type`
  AND t1.`id` < t2.`id`;

COMMIT;

-- ============================================================
-- VERIFICATION: Chạy các query sau để kiểm tra kết quả
-- ============================================================
-- SELECT id, name, gender FROM users WHERE id IN (19, 42, 57, 58);
-- SELECT id, name FROM users WHERE id = 60;
-- SELECT id, email FROM users WHERE id IN (25, 61);
-- SELECT id, code, location_id FROM equipment;
-- SELECT tokenable_id, COUNT(*) as cnt FROM personal_access_tokens GROUP BY tokenable_id;
-- SHOW TABLES LIKE 'v_%';
