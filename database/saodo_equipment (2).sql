-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 16, 2026 lúc 09:39 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `saodo_equipment`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `departments`
--

INSERT INTO `departments` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, 'Khoa Điện', 'KD', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(2, 'Khoa Cơ khí', 'KCK', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(3, 'Khoa May và Thời trang', 'KMT', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(4, 'Khoa Công nghệ thông tin', 'CNTT', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(5, 'Khoa Ô tô', 'KOT', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(7, 'Phòng Quản lý chất lượng', 'QLCL', '2026-04-14 19:05:06', '2026-04-14 19:05:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `equipment`
--

CREATE TABLE `equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `year_of_use` int(11) DEFAULT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `code`, `year_of_use`, `location_id`, `created_at`, `updated_at`) VALUES
(1, 'Bộ PLC Mitsubishi + cảm biến phòng chống cháy', 'PLC-CB-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(2, 'Bộ PLC Mitsubishi + bảng gia công áp lực', 'PLC-GC-02', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(3, 'Bộ PLC S7-1200 + máy tính điều khiển nhiệt độ lò', 'S71200-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(4, 'PLC Mitsubishi + màn hình HMI Winview', 'HMI-WIN-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(5, 'PLC Mitsubishi + bảng gia công áp lực (2)', 'PLC-GC-03', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(6, 'Bộ PLC S7-1200 điều khiển nhiệt độ lò (2)', 'S71200-02', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(7, 'Bộ PLC Biến tần truyền thông', 'PLC-BT-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(8, 'PLC Mitsubishi FX3G + phần mềm GX Works2', 'FX3G-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(9, 'PLC S7-1200 + Zen + Logo cắt nguồn dự phòng', 'ZEN-01', 2016, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(10, 'Cánh tay Robot + QR scanner + Động cơ Servo', 'ROBOT-01', 2017, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(11, 'Máy CNC (P.TH CNC-X4)', 'CNC-01', 2018, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(12, 'Băng tải + PLC 305B', 'PLC-305B', 2019, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `locations`
--

INSERT INTO `locations` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, '101-X1', '101-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(2, '102-X1', '102-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(3, '103-X1', '103-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(4, '104-X1', '104-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(5, '106-X1', '106-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(6, '108-X1', '108-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(7, '201-X1', '201-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(8, '202-X1', '202-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(9, '203-X1', '203-X1', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(10, '101-X3', '101-X3', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(11, 'P.TH CNC-X4', 'P.TH CNC-X4', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(12, 'P. làm việc-X3', 'P. làm việc-X3', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(13, '305B', '305B', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(14, '201-X4', '201-X4', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(15, '202-X4', '202-X4', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(16, '203-X4', '203-X4', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(17, '207-X4', '207-X4', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(18, 'Văn phòng khoa', 'Văn phòng khoa', '2026-04-13 23:54:34', '2026-04-13 23:54:34'),
(19, 'Phòng thực hành điện', 'Phòng thực hành điện', '2026-04-13 23:54:34', '2026-04-13 23:54:34');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_01_000000_create_system_tables', 1),
(2, '2026_04_11_111733_add_status_to_users_table', 1),
(3, '2026_04_12_000000_add_attachments_to_plans', 1),
(4, '2026_04_12_083900_add_avatar_to_users_table', 1),
(5, '2026_04_12_103200_add_attachments_column_to_plans', 1),
(6, '2026_04_13_124820_add_profile_fields_to_users_table', 1),
(7, '2026_04_13_210000_create_user_activities_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 6, 'auth-token', 'e4ac9a78703c40fdb72b5aab0cdae12e3940f3a1ab3c16b030e2d827cf5cdf8e', '[\"*\"]', '2026-04-14 01:38:20', NULL, '2026-04-14 01:37:35', '2026-04-14 01:38:20'),
(2, 'App\\Models\\User', 3, 'auth-token', '83c177cc1da7542f8b688a7b36b265159a9e5d774606f11946455f86bfccee02', '[\"*\"]', '2026-04-14 01:38:51', NULL, '2026-04-14 01:38:35', '2026-04-14 01:38:51'),
(3, 'App\\Models\\User', 5, 'auth-token', 'c7f57774e87efff5812dd9d4453b3ca756db16316b9167419ccb8eb4b366ae03', '[\"*\"]', '2026-04-14 01:39:38', NULL, '2026-04-14 01:39:03', '2026-04-14 01:39:38'),
(4, 'App\\Models\\User', 4, 'auth-token', '35dfe4b56115650a1d2ebbd872db20e7bee3ce46df091b35c9573c19e677617e', '[\"*\"]', '2026-04-14 01:40:28', NULL, '2026-04-14 01:39:51', '2026-04-14 01:40:28'),
(5, 'App\\Models\\User', 2, 'auth-token', 'fae74c4fdc545d709a58618483667fed6db5e5620a89aa0d0b69bb7679d82c46', '[\"*\"]', '2026-04-14 01:48:15', NULL, '2026-04-14 01:46:04', '2026-04-14 01:48:15'),
(6, 'App\\Models\\User', 12, 'auth-token', '61b1f5cb31a747754464ad811ff1de5dd0280b8269b4596a6d4cb2c766bae598', '[\"*\"]', '2026-04-14 01:49:09', NULL, '2026-04-14 01:48:20', '2026-04-14 01:49:09'),
(7, 'App\\Models\\User', 3, 'auth-token', 'cca41598b422d4def3ce389d8d7edcbfa49ece33e783a3e26526e6a8b24d99e9', '[\"*\"]', '2026-04-14 01:50:38', NULL, '2026-04-14 01:49:24', '2026-04-14 01:50:38'),
(8, 'App\\Models\\User', 2, 'auth-token', '99ebd413688f557574d01bca20e7458fb9866c4bd5adac0e8a1b491b02c06ee3', '[\"*\"]', '2026-04-14 01:51:30', NULL, '2026-04-14 01:50:59', '2026-04-14 01:51:30'),
(9, 'App\\Models\\User', 3, 'auth-token', '2a0f3d3c5675a6eb7379dd7810c715e2f125d138d67020efb443772333283344', '[\"*\"]', '2026-04-14 01:52:58', NULL, '2026-04-14 01:51:41', '2026-04-14 01:52:58'),
(10, 'App\\Models\\User', 2, 'auth-token', '1ad1e06426fa9db74ce9af58c08c4656acb713cbc2e44dd1b6ed947083125e00', '[\"*\"]', '2026-04-14 01:54:22', NULL, '2026-04-14 01:53:20', '2026-04-14 01:54:22'),
(11, 'App\\Models\\User', 13, 'auth-token', 'ae23dd4e3875fcbd4c3aa387cd2e0fd7462f3dd4c6b8d01e3533c0961ce366da', '[\"*\"]', NULL, NULL, '2026-04-14 17:17:27', '2026-04-14 17:17:27'),
(12, 'App\\Models\\User', 6, 'auth-token', '301f63e25d56836388279d9b619445889292e1789ddd8ef69260d756d1724044', '[\"*\"]', '2026-04-14 17:17:52', NULL, '2026-04-14 17:17:51', '2026-04-14 17:17:52'),
(13, 'App\\Models\\User', 2, 'auth-token', '1feff13c6e9adaab7dd59b63eb25881f7a4761e738e57d929d236c43586c7ad2', '[\"*\"]', '2026-04-14 17:19:09', NULL, '2026-04-14 17:18:35', '2026-04-14 17:19:09'),
(14, 'App\\Models\\User', 13, 'auth-token', 'e4aee16e1e6aea38485ecda28dbbdbbb2202a19844ad26c820e67d2a625a7092', '[\"*\"]', '2026-04-14 17:20:00', NULL, '2026-04-14 17:19:21', '2026-04-14 17:20:00'),
(15, 'App\\Models\\User', 14, 'auth-token', '45239708abec97a37cc05b6c44b48e2508eb46f0b724090ef34afb813bffd2d5', '[\"*\"]', '2026-04-14 17:20:22', NULL, '2026-04-14 17:20:06', '2026-04-14 17:20:22'),
(16, 'App\\Models\\User', 16, 'auth-token', '41c1e99e5c49a26d7cd68a64da9af4555c1ee3cc4c96b4f5f360ff56c77ce30f', '[\"*\"]', '2026-04-14 17:20:58', NULL, '2026-04-14 17:20:37', '2026-04-14 17:20:58'),
(17, 'App\\Models\\User', 15, 'auth-token', '19e9c6e63294694be3bb829a47cd04cd590965a757a23b06b698d58be0a4b18c', '[\"*\"]', '2026-04-14 17:21:43', NULL, '2026-04-14 17:21:25', '2026-04-14 17:21:43'),
(18, 'App\\Models\\User', 3, 'auth-token', 'ac1f71bfc286520d4a757d14bfca13968a6172ae5446240cdbfe58a2909d138e', '[\"*\"]', '2026-04-14 17:22:42', NULL, '2026-04-14 17:22:02', '2026-04-14 17:22:42'),
(19, 'App\\Models\\User', 2, 'auth-token', '432aa45f48d3fd409338c880ea0210411c328e69c86840201110e09dc1acdb5e', '[\"*\"]', '2026-04-14 17:24:02', NULL, '2026-04-14 17:23:31', '2026-04-14 17:24:02'),
(20, 'App\\Models\\User', 16, 'auth-token', 'a3d1c8be565131091354c469407403d3a2cd9eb4e129755819acbd768293a5bc', '[\"*\"]', '2026-04-14 17:24:52', NULL, '2026-04-14 17:24:24', '2026-04-14 17:24:52'),
(21, 'App\\Models\\User', 2, 'auth-token', 'e168aee4cf6c7d1a50757b23223778a87fdb0b04f846a5b4bc02c2fef514001a', '[\"*\"]', '2026-04-14 17:25:24', NULL, '2026-04-14 17:25:05', '2026-04-14 17:25:24'),
(22, 'App\\Models\\User', 2, 'auth-token', 'cb2187328821aa3693cb779332aee6ecab6de5752b4f917a7711b049669bcec9', '[\"*\"]', '2026-04-14 17:26:11', NULL, '2026-04-14 17:26:08', '2026-04-14 17:26:11'),
(23, 'App\\Models\\User', 16, 'auth-token', '7295cbb3adf36b2842826a46b63cd3c63d2df9f5b3d5d3c217f96d2bd719352b', '[\"*\"]', '2026-04-14 17:26:41', NULL, '2026-04-14 17:26:25', '2026-04-14 17:26:41'),
(24, 'App\\Models\\User', 16, 'auth-token', '42978b9ed4b6c434daaf8cc2d551cd040dec6619d9aec92ab3e5a40aeed5874e', '[\"*\"]', '2026-04-14 17:29:18', NULL, '2026-04-14 17:29:10', '2026-04-14 17:29:18'),
(25, 'App\\Models\\User', 2, 'auth-token', 'efa7bc761dfb7a47ea59876765523f8aacf5ffffa8646af4458a6d59795d04d1', '[\"*\"]', '2026-04-14 18:36:58', NULL, '2026-04-14 17:29:29', '2026-04-14 18:36:58'),
(26, 'App\\Models\\User', 6, 'auth-token', '13e330933e4d5280f3d50398605f403c32cf3e9b27281c97b5286df508793dab', '[\"*\"]', '2026-04-14 18:44:22', NULL, '2026-04-14 18:39:22', '2026-04-14 18:44:22'),
(27, 'App\\Models\\User', 12, 'auth-token', 'bf9286771fb882c089a4aa85772b7ed90bb2f6953ef76a223d55a5e80a8cb31b', '[\"*\"]', '2026-04-14 19:00:54', NULL, '2026-04-14 19:00:37', '2026-04-14 19:00:54'),
(28, 'App\\Models\\User', 16, 'auth-token', '548f4de308596df2f66b6b6061a848fcb5be3bdd65335f96dd4ca8d8f959e08d', '[\"*\"]', '2026-04-14 19:01:18', NULL, '2026-04-14 19:01:02', '2026-04-14 19:01:18'),
(29, 'App\\Models\\User', 2, 'auth-token', '375b46cf5454fdcfef8c2aaf12448870b6eb380054c41c6ed5154ff64cc115ca', '[\"*\"]', '2026-04-14 19:05:47', NULL, '2026-04-14 19:01:48', '2026-04-14 19:05:47'),
(30, 'App\\Models\\User', 2, 'auth-token', 'a80b8b5c14970607085b9876c391e4ea68e294fc1e547824c29aa48e7dd0c2f4', '[\"*\"]', '2026-04-14 19:04:57', NULL, '2026-04-14 19:04:26', '2026-04-14 19:04:57'),
(31, 'App\\Models\\User', 2, 'auth-token', 'c239f16baebff4dfd559e09eaa733d95b6b9336da3be0033e1b9803a69b8fb07', '[\"*\"]', '2026-04-14 19:10:59', NULL, '2026-04-14 19:10:13', '2026-04-14 19:10:59'),
(32, 'App\\Models\\User', 2, 'auth-token', '2ed5f94b913346fb5465d19a1f8862c8f1a621f88a93b2c23a72257cc03f9976', '[\"*\"]', '2026-04-14 19:23:35', NULL, '2026-04-14 19:20:56', '2026-04-14 19:23:35'),
(33, 'App\\Models\\User', 2, 'auth-token', '77061313bc0a5fb2893fd2a7d5ec8847e859d6fdef7098f261f8c3361aadf5f7', '[\"*\"]', '2026-04-14 19:24:51', NULL, '2026-04-14 19:22:20', '2026-04-14 19:24:51'),
(34, 'App\\Models\\User', 2, 'auth-token', '214f0b4f3c1fa7ca9de41f60d61d93e563c100338e1fd7e8a950ad608cfe91ae', '[\"*\"]', '2026-04-14 19:37:52', NULL, '2026-04-14 19:32:50', '2026-04-14 19:37:52'),
(35, 'App\\Models\\User', 2, 'auth-token', '5b83814de1f952fd59851e770c58f261a82f0327d673205235ee37f2e0132a6c', '[\"*\"]', '2026-04-14 22:35:38', NULL, '2026-04-14 19:37:57', '2026-04-14 22:35:38'),
(36, 'App\\Models\\User', 2, 'auth-token', 'da15f0d8b9f85e9f1a118755817909fdc89c58710533797fdbfd547ee121885a', '[\"*\"]', '2026-04-14 19:39:07', NULL, '2026-04-14 19:38:21', '2026-04-14 19:39:07'),
(37, 'App\\Models\\User', 6, 'auth-token', 'ce14653471acdd588874483a08a7bfe88030af6fa2b4c5dd982eff922c3597b3', '[\"*\"]', '2026-04-14 19:50:04', NULL, '2026-04-14 19:39:25', '2026-04-14 19:50:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'DRAFT',
  `score` int(11) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attached_file_path` varchar(255) DEFAULT NULL,
  `attached_file_name` varchar(255) DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `plan_items`
--

CREATE TABLE `plan_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `topic` varchar(255) NOT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `equipment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `equipment_name_manual` varchar(255) DEFAULT NULL,
  `equipment_year_manual` int(11) DEFAULT NULL,
  `executor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mentor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `time_range` varchar(255) DEFAULT NULL,
  `expected_result` text DEFAULT NULL,
  `planned_hours` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL DEFAULT 'TEACHER',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `plan_weeks`
--

CREATE TABLE `plan_weeks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `week_label` varchar(255) NOT NULL,
  `planned_hours` int(11) NOT NULL DEFAULT 0,
  `actual_hours` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'TEACHER',
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'ACTIVE',
  `avatar` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `pending_profile` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`pending_profile`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `department_id`, `remember_token`, `created_at`, `updated_at`, `status`, `avatar`, `dob`, `gender`, `contact_email`, `pending_profile`) VALUES
(1, 'Quản trị hệ thống', '1000001', NULL, '$2y$12$Up2I2YT9YxN9DYflk9Ss9u9FIaZR9M3KTlfgfI3u6DPmcztCTZtQq', 'ADMIN', NULL, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34', 'ACTIVE', NULL, NULL, NULL, NULL, NULL),
(2, 'Đỗ Văn Đỉnh', '01006030', NULL, '$2y$12$GE.PVZkPL0wMwhGI7PKzSeGJSZpwE3md4wY6eujdEkMmq3jF8nRMi', 'BOARD', NULL, NULL, '2026-04-13 23:54:34', '2026-04-13 23:54:34', 'ACTIVE', NULL, NULL, NULL, NULL, NULL),
(3, 'Test', '01002000', NULL, '$2y$12$7d0NaQxLB8eiA2ZS4P5tXOIE0sJFW6wYFUKNtZMXOaKmq.0eedhsG', 'DEPT_HEAD', 4, NULL, '2026-04-13 23:54:35', '2026-04-14 17:25:22', 'ACTIVE', NULL, NULL, 'Nữ', 'pth@saodo.edu.vn', NULL),
(4, 'Hoàng Thị An', '01007033', NULL, '$2y$12$nEGsUG0OE35Jy4Z9sZcQZ.JwNlBJv7jEoi7CfvwWRIQzE1NsBmRVS', 'TEACHER', 4, NULL, '2026-04-13 23:54:35', '2026-04-14 01:48:54', 'ACTIVE', NULL, NULL, 'Nữ', 'htan@saodo.edu.vn', NULL),
(5, 'Hoàng Thị Ngát', '01007029', NULL, '$2y$12$ewYITzq60dEVjJXbmKfgU.PPuxhyCALb37MFlIs2JeGyycuAx/hU6', 'TEACHER', 4, NULL, '2026-04-13 23:54:35', '2026-04-14 01:48:55', 'ACTIVE', NULL, NULL, 'Nữ', 'htngat@saodo.edu.vn', NULL),
(6, 'Phạm Thị Hường', '01007003', NULL, '$2y$12$RHNH/xE3p1xejnISJLm5DeVmRGc.YKHkD11EMoWKQodRdyWPbhkDW', 'TEACHER', 4, NULL, '2026-04-13 23:54:36', '2026-04-14 01:48:56', 'ACTIVE', NULL, NULL, 'Nữ', 'huongPT@saodo.edu.vn', NULL),
(7, 'Nguyễn Thị Ánh Tuyết', '01007023', NULL, '$2y$12$udoGXJp7gaQy6JRnVjrVoeWnVi9ekBu8eYMHDXb16ifsXWNFtwrdq', 'TEACHER', 4, NULL, '2026-04-14 01:40:47', '2026-04-14 01:48:33', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(8, 'Nguyễn Thị Thu', '01007024', NULL, '$2y$12$pyDwR06D4Pz.YNeEOewQ8eba1wVp7Hg5B7nokH3MXA.RXQ5LGYne2', 'TEACHER', 4, NULL, '2026-04-14 01:41:22', '2026-04-14 01:48:34', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(9, 'Nguyễn Thị Bích Ngọc', '01007039', NULL, '$2y$12$VQPjMuknbH/Wa1Al0mcCQOXeqeXKDSej7dVkzVlC/OdVCbTBFz3vK', 'TEACHER', 4, NULL, '2026-04-14 01:41:54', '2026-04-14 01:48:35', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(10, 'Phạm Thị Tâm', '01021007', NULL, '$2y$12$JXidJJRVa7u4xVhxHH4MzeAKH.g8f.UrSfNzmliDNCWT.pifv1L42', 'TEACHER', 4, NULL, '2026-04-14 01:42:21', '2026-04-14 01:48:36', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(11, 'Vũ Bảo Tạo', '01007027', NULL, '$2y$12$GY/MIpNYnldQvKLZy.NTG.nC0B9CfkQYrdA1i8Mjo1Q4wvHgWjdO6', 'TEACHER', 4, NULL, '2026-04-14 01:43:02', '2026-04-14 01:48:37', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(12, 'Phạm Văn Kiên', '01007002', NULL, '$2y$12$9EwAFqq4sfUUJdvXkPgahO3ks6qE28hFS1acoN9lfiIDudzUY8mma', 'DEPT_HEAD', 4, NULL, '2026-04-14 01:43:32', '2026-04-14 01:46:21', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(13, 'Nguyễn Phương Tỵ', '01016002', NULL, '$2y$12$wgnX4SqVuRFB/lCdDtzzMOOELlRtcshinmrWWV1/gqpjNrAf3Q6wC', 'DEPT_HEAD', 1, NULL, '2026-04-14 01:44:06', '2026-04-14 01:46:22', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(14, 'Nguyễn Văn Hinh', '01004014', NULL, '$2y$12$sPuNUFwp1RFWjxniT67AiOOx7Vw9GtomNFVvDMuOfM2Wfpw7ZZzLG', 'DEPT_HEAD', 2, NULL, '2026-04-14 01:44:34', '2026-04-14 01:46:25', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(15, 'Nguyễn Đình Cương', '01001012', NULL, '$2y$12$W30BiLOSpPn1P08chss/WeNFm7AZwY5ou1Oq6RvFWTXAEflbAnvSe', 'DEPT_HEAD', 5, NULL, '2026-04-14 01:45:04', '2026-04-14 01:46:27', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(16, 'Tạ Văn Hiển', '01002007', NULL, '$2y$12$nU5.SFmIchL2ZecU7xD4xuFW4qy1kCv6hEiBolNNgdyN.uwbM4eQ6', 'DEPT_HEAD', 3, NULL, '2026-04-14 01:45:35', '2026-04-14 01:46:30', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(17, 'Nguyễn Thị Hiền', '01002008', NULL, '$2y$12$6RUUyG8qwC5w6Of7XNhucOJX49uSmnOz5ecfQyFZU2mRGZo8bJygO', 'TEACHER', 3, NULL, '2026-04-14 01:55:26', '2026-04-14 17:20:50', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(18, 'Bùi Thị Loan', '01002011', NULL, '$2y$12$oYu//s98/gJP3XdAUslrgOv4ciEhFBieIX2bhVAE6oy9pulP1Gw.2', 'TEACHER', 3, NULL, '2026-04-14 01:55:57', '2026-04-14 17:20:51', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(19, 'Nguyễn Thị Hằng', '01002012', NULL, '$2y$12$wi6e9132uzs/ml8EHI90OuI46QRRqEjNkcopzfxTEIOgGwCxsQ15.', 'TEACHER', 3, NULL, '2026-04-14 01:56:22', '2026-04-14 17:20:53', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(20, 'Nguyễn Quang Thoại', '01002013', NULL, '$2y$12$qImDvB7yZtANPd1EtPNyXuji9Ml5O0A2GCiTFWSa/7/q8O755QgTe', 'TEACHER', 3, NULL, '2026-04-14 01:56:44', '2026-04-14 17:20:54', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(21, 'Đỗ Thị Làn', '01002019', NULL, '$2y$12$XOVWAExwm/iQDn/iB3bRReTuiwWtvEcC1lzF2OCBSmmgMfabrmldu', 'TEACHER', 3, NULL, '2026-04-14 01:57:08', '2026-04-14 17:20:55', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(22, 'Nguyễn Thị Hồi', '01002021', NULL, '$2y$12$QvJbXokUVwUqzlZTI745u.ZgDDtS1OK7b458fPaC7CD2py/kX.Sc6', 'TEACHER', 3, NULL, '2026-04-14 01:57:33', '2026-04-14 17:20:56', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(23, 'Vũ Thành Trung', '01001003', NULL, '$2y$12$1i8A4M1d182I/BurhpfBZ.x77RHb.3/lO/Akn/1LZLbiMJdnSX8EK', 'TEACHER', 5, NULL, '2026-04-14 01:58:40', '2026-04-14 17:21:34', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(24, 'Cao Huy Giáp', '01001004', NULL, '$2y$12$odD56EZnViRKjaPAIDfFHeK.LXhUSEPOmL68vX2iesUBv4GMHhUC6', 'TEACHER', 5, NULL, '2026-04-14 01:59:03', '2026-04-14 17:21:35', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(25, 'Lê Đức Thắng', '01021008', NULL, '$2y$12$Bk5n46Mo6raKKf3BtkYHKevYMQklYsL/JWEaeI/RgZRyv2SumGvAi', 'TEACHER', 5, NULL, '2026-04-14 01:59:24', '2026-04-14 17:21:36', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(26, 'Nguyễn Lương Căn', '01001006', NULL, '$2y$12$Sl/TtmtHuvrsPKIe80/0qOo/vhJ0a7V0ijO52Rt9M2vVRw.mO4pXu', 'TEACHER', 5, NULL, '2026-04-14 01:59:46', '2026-04-14 17:21:37', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(27, 'Phùng Đức Hải Anh', '01001011', NULL, '$2y$12$FNj2TtUXsDtQss3CDH/sF.w0ZbC9pPEK/1lEReVKKrJpms8wfcF7i', 'TEACHER', 5, NULL, '2026-04-14 02:00:07', '2026-04-14 17:21:38', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(28, 'Đỗ Tiến Quyết', '01001014', NULL, '$2y$12$vDVRmSWp23SRft5EfkBou.6cEOF5X1skoPJgKXevLYYXd7y8/w.lq', 'TEACHER', 5, NULL, '2026-04-14 02:00:31', '2026-04-14 17:21:39', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(29, 'Phạm Văn Trọng', '01001018', NULL, '$2y$12$E3NRUXTgLPfaKLmBSZnQ0etoi7o5Yfv9qND3QsiqQKseoOWRgs7sy', 'TEACHER', 5, NULL, '2026-04-14 02:00:56', '2026-04-14 17:21:40', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(30, 'Nguyễn Ngọc Đàm', '01004028', NULL, '$2y$12$8tJSw6P1hJmOhiUKWfW2NeBMLRGlnqneesiC4bPwZHs34jv9A/4G2', 'TEACHER', 5, NULL, '2026-04-14 02:02:37', '2026-04-14 17:21:41', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(31, 'Vũ Hoa Kỳ', '01004011', NULL, '$2y$12$GMLuvIE3F6CLiq.yB2/gZe.K0B7tuQ096WIeKQ34RbJFlIpGruqy2', 'TEACHER', 2, NULL, '2026-04-14 02:04:30', '2026-04-14 17:20:10', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(32, 'Mạc Văn Giang', '01004013', NULL, '$2y$12$bpd7eTJsqfGBhXJ4oRrPWeFeLYseKDuoLkSk8vDag/0QkMNt9ywZ2', 'TEACHER', 2, NULL, '2026-04-14 02:07:27', '2026-04-14 17:20:11', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(33, 'Nguyễn Danh Đạo', '01009014', NULL, '$2y$12$L1a1Oti7yagWInuc7plqzO19EXdZUJh8ObODBhnmk7KFkVMjhu4fC', 'TEACHER', 2, NULL, '2026-04-14 02:07:50', '2026-04-14 17:20:12', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(34, 'Đào Văn Kiên', '01004030', NULL, '$2y$12$9ACe.12vzQX5GHKF.jvLQ.E5p00O09qmXCJN3xtKG20G8dgE5HbRG', 'TEACHER', 2, NULL, '2026-04-14 02:08:11', '2026-04-14 17:20:13', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(35, 'Mạc Thị Nguyên', '01004036', NULL, '$2y$12$fY6ETkfRzymmI0ksHhh5luNf0AVTunX0cEHC3.EyZXjYf69NpD4xu', 'TEACHER', 2, NULL, '2026-04-14 02:08:35', '2026-04-14 17:20:14', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(36, 'Nguyễn Thị Hồng Nhung', '01004037', NULL, '$2y$12$GUQJ3ekt0xzkkQWxUro7cun0MgU0os3cnZJ5aS0FgOVtSN3rWtt3a', 'TEACHER', 2, NULL, '2026-04-14 02:08:58', '2026-04-14 17:20:14', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(37, 'Nguyễn Thị Liễu', '01004040', NULL, '$2y$12$E8zhRGbHgx5rQeU9yU/WMeajvmH6J/p6BTycq0I6LNb5qlh1Sdcmy', 'TEACHER', 2, NULL, '2026-04-14 02:09:19', '2026-04-14 17:20:16', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(38, 'Dương Thị Hà', '01004055', NULL, '$2y$12$CHUIO/FoZllDA5uftKR9v./4KxEKFP1WmOMZDx/filHii4FD.xprK', 'TEACHER', 2, NULL, '2026-04-14 02:09:42', '2026-04-14 17:20:17', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(39, 'Trịnh Văn Cường', '01005030', NULL, '$2y$12$gTI5ZA1jc2DEIBDQu3ySl.6IMwAj25wVEudqQpvhXD6NpgUgPcBnW', 'TEACHER', 2, NULL, '2026-04-14 02:14:28', '2026-04-14 17:20:18', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(40, 'Nguyễn Hữu Chấn', '01014013', NULL, '$2y$12$8rZltkTf8EWjVL80z5jJV.uZKHQp3v17nP462alFR8QyWmM/Iz0Iu', 'TEACHER', 2, NULL, '2026-04-14 02:14:54', '2026-04-14 17:20:20', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(41, 'Nguyễn Thị Tâm', '01006005', NULL, '$2y$12$DvLNbzvqmrynw5foTtHN0.cFARDvxdD.2v6DUPc075sLcHsMtNwPS', 'TEACHER', 1, NULL, '2026-04-14 02:15:44', '2026-04-14 17:19:28', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(42, 'Tạ Thị Mai', '01006007', NULL, '$2y$12$RZykbmkU8abkHO7SwlWPheCrvrNqmEuVZTN0Al8/raemWGB4o0WG6', 'TEACHER', 1, NULL, '2026-04-14 02:16:03', '2026-04-14 17:19:29', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(43, 'Lê Ngọc Hòa', '01006008', NULL, '$2y$12$QhYqqwaASKTd2xPk6KM5YeKb5fFksP6WsxB8lN.qPrY5aSLPfdBUy', 'TEACHER', 1, NULL, '2026-04-14 02:16:24', '2026-04-14 17:19:30', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(44, 'Đỗ Huy tùng', '01006009', NULL, '$2y$12$omA0oLtnbBnjZ7rW6JolWeg5iIorF9hQf0Mro6IaNMlEZtNINtcee', 'TEACHER', 1, NULL, '2026-04-14 02:16:47', '2026-04-14 17:19:30', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(45, 'Phạm Văn Tuấn', '01006020', NULL, '$2y$12$rDBMPeR3k9CSHbVnpCVbfeLR9QB2RXV1Nc1sfiQS8KcYHxAEUKufO', 'TEACHER', 1, NULL, '2026-04-14 02:17:12', '2026-04-14 17:19:31', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(46, 'Phạm Đức Khẩn', '01006021', NULL, '$2y$12$TXxKIjMcrk.hlsN.qf6hY.5C02CHJDV9a3BhQx0wbkGW7.v2ftMJu', 'TEACHER', 1, NULL, '2026-04-14 02:17:32', '2026-04-14 17:19:32', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(47, 'Nguyễn Trương Huy', '01006023', NULL, '$2y$12$STW06CS5x9Z3FSV5.Lh5Qe/O8.K0.k4S3k0fBHn79PqumP2BUgSR6', 'TEACHER', 1, NULL, '2026-04-14 02:17:59', '2026-04-14 17:19:32', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(48, 'Đặng Văn Tuệ', '01006024', NULL, '$2y$12$6ag8UjS50p1irnXxRLkg4eZACp86kCeX/n7lTRvYDnNS6CLYGw6.q', 'TEACHER', 1, NULL, '2026-04-14 02:18:17', '2026-04-14 17:19:33', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(49, 'Phạm Văn Tài', '01006033', NULL, '$2y$12$qvRGM6VbsE7sBBguzlv.OeKU.gtpT/il6z.1/54IXAQ/dkG3azfty', 'TEACHER', 1, NULL, '2026-04-14 02:18:38', '2026-04-14 17:19:34', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(50, 'Phạm Công Tảo', '01006034', NULL, '$2y$12$Vam/W4odL.I.EwfhChAvn.QMIBGjMi5KLVnkqO9Bd1POKNkMCbT1e', 'TEACHER', 1, NULL, '2026-04-14 02:18:57', '2026-04-14 17:19:34', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(51, 'Vũ Hồng Phong', '01006037', NULL, '$2y$12$bKMyy4.1c7K7cYuZFAmmweYLAmTp3EfGT6OLrU8aMGowV54tJXj1G', 'TEACHER', 1, NULL, '2026-04-14 02:19:18', '2026-04-14 17:19:35', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(52, 'Lê Văn Sơn', '01007012', NULL, '$2y$12$VE0ITAdepgeQftZ0O3MCDOU.J8OJdowNq3mZczBOwxRuUD5Progmy', 'TEACHER', 1, NULL, '2026-04-14 02:19:38', '2026-04-14 17:19:36', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(53, 'Vũ Trí Võ', '01007013', NULL, '$2y$12$yvWWfx2/5f.ZfWWQ/QK.heoUFn2G.LLDpuTOmN2JHejFNxE4C0hYC', 'TEACHER', 1, NULL, '2026-04-14 02:19:54', '2026-04-14 17:19:37', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(54, 'Nguyễn Văn Tiến', '01007021', NULL, '$2y$12$jbEXMadyrkIWOcs0CNz0CuRJAMetcK2AYVOp3fSPp.3A8GlnOg0HO', 'TEACHER', 1, NULL, '2026-04-14 02:20:14', '2026-04-14 17:19:37', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(55, 'Nguyễn Tiến Phúc', '01007026', NULL, '$2y$12$BJkzC0rTY2SNZAHDYRyknOv752pjpQQb/09E1jhuP1k8W3MUxNTw6', 'TEACHER', 1, NULL, '2026-04-14 02:20:35', '2026-04-14 17:19:38', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(56, 'Nguyễn Thị Quyên', '01007028', NULL, '$2y$12$mILgBl.X014mHjCYr0o3yuOCU5RrSkn3CKWMoCoHs.tkfzit1hfpi', 'TEACHER', 1, NULL, '2026-04-14 02:20:57', '2026-04-14 17:19:38', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(57, 'Dương Thị Hoa', '01006049', NULL, '$2y$12$4jy6FAP2DmxJ6.PHWQTtNuboUHQWuWob4EAgb7NtFUhW3M1TJt3yK', 'TEACHER', 1, NULL, '2026-04-14 02:21:14', '2026-04-14 17:19:39', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(58, 'Nguyễn Thị Việt Hương', '01006040', NULL, '$2y$12$8txiF1nAGC484JKXNcBtrOGGC8ATRlh57kyhY2oeILiX.MXvbdEuK', 'TEACHER', 1, NULL, '2026-04-14 02:21:35', '2026-04-14 17:19:40', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(59, 'Lương Thị Thanh Xuân', '01006038', NULL, '$2y$12$iXkNdVrfwo925IrylWuBq./73MJzCLHpRBBuEHNSbtjTRdOgAL4eS', 'TEACHER', 1, NULL, '2026-04-14 02:21:58', '2026-04-14 17:19:40', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(60, 'Nguyễn Thị Phương Oanh', '01006036', NULL, '$2y$12$pylG7jxdfbmAlc.AeAVEhuji44VOAkAKnhslQs9l81RuozIsHbjxC', 'TEACHER', 1, NULL, '2026-04-14 02:22:25', '2026-04-14 17:19:41', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(61, 'Lê Thị Mai', '01021009', NULL, '$2y$12$./h82SQ1.OlO3Pr5uM1k8.X/XQxRpYYmTTQXO3Zitr37efeWNqjpe', 'TEACHER', 1, NULL, '2026-04-14 02:22:45', '2026-04-14 17:19:43', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(62, 'Nguyễn Thị Phương', '01006029', NULL, '$2y$12$5oPQBT8wxLD8j6LwgTGfbuqxMYRyl6XDdAkCqmSy9bkGXOkFsQuWu', 'TEACHER', 1, NULL, '2026-04-14 02:23:10', '2026-04-14 17:19:43', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(63, 'Phạm Thị Thảo', '01006028', NULL, '$2y$12$pnYSmq6EsjDr.xXs47tKtOM8QDR1WuOM1hvM9FS45grg.henbU.3a', 'TEACHER', 1, NULL, '2026-04-14 02:23:31', '2026-04-14 17:19:44', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(64, 'Nguyễn Thị Thảo', '01006026', NULL, '$2y$12$ivM7DhK4k9onSv/JYRVnXuzTwYWSJutwnr9VPahhrtf2aNRpwXTQy', 'TEACHER', 1, NULL, '2026-04-14 02:23:52', '2026-04-14 17:19:45', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(65, 'Nguyễn Thị Sim', '01006011', NULL, '$2y$12$GJ1MO3VVFUfJY8C2r3jF/uOWHkCTbqRdrQhrX.zmOgdUYl75XdzL6', 'TEACHER', 1, NULL, '2026-04-14 02:24:37', '2026-04-14 17:19:46', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(66, 'Nguyễn Trọng Quỳnh', '01022001', NULL, '$2y$12$OP8WiHOq9foOa4d/uXoyVuxWcug4L5VS1RxEi67Zd1PGpMLIh01gO', 'TEACHER', 1, NULL, '2026-04-14 02:27:13', '2026-04-14 17:19:48', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(67, 'Vũ Quang Ngọc', '01015013', NULL, '$2y$12$JsfRPmkrarPWrk5JGxVZWejMqcM6bGl/M3BzeWztP7xKAtgRxfj6C', 'TEACHER', 1, NULL, '2026-04-14 02:27:53', '2026-04-14 17:19:49', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(68, 'Phạm Thị Kim Phúc', '01002006', NULL, '$2y$12$wUBfU41erkEFRjyzSWAKHeDZX0vJtLyBcCvoFmBKbAtu6M0varsma', 'TEACHER', 3, NULL, '2026-04-14 17:25:59', '2026-04-14 17:26:32', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL),
(70, 'Tạ Hồng Phong', '01021005', NULL, '$2y$12$zrFHxpJvyyl2FOXUCFBaDuOqeUzAdpJYW6.e50BpZljOE5FGsu.G2', 'QC', 7, NULL, '2026-04-14 17:28:49', '2026-04-14 19:22:39', 'ACTIVE', NULL, NULL, 'Nam', NULL, NULL),
(72, 'Đỗ Thị Tần', '01002005', NULL, '$2y$12$D3CB/G14iGXADEc022bKIeU15g5Uorr9a/wBaEapm2pEVO3IJq3m6', 'QC', 7, NULL, '2026-04-14 19:09:50', '2026-04-14 19:22:41', 'ACTIVE', NULL, NULL, 'Nữ', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_activities`
--

CREATE TABLE `user_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_activities`
--

INSERT INTO `user_activities` (`id`, `user_id`, `type`, `description`, `created_at`, `updated_at`) VALUES
(1, 6, 'login', 'Đăng nhập thành công', '2026-04-14 01:37:34', '2026-04-14 01:37:34'),
(2, 6, 'request_update_profile', 'Gửi yêu cầu cập nhật hồ sơ', '2026-04-14 01:38:15', '2026-04-14 01:38:15'),
(3, 3, 'login', 'Đăng nhập thành công', '2026-04-14 01:38:35', '2026-04-14 01:38:35'),
(4, 5, 'login', 'Đăng nhập thành công', '2026-04-14 01:39:03', '2026-04-14 01:39:03'),
(5, 5, 'request_update_profile', 'Gửi yêu cầu cập nhật hồ sơ', '2026-04-14 01:39:36', '2026-04-14 01:39:36'),
(6, 4, 'login', 'Đăng nhập thành công', '2026-04-14 01:39:51', '2026-04-14 01:39:51'),
(7, 4, 'request_update_profile', 'Gửi yêu cầu cập nhật hồ sơ', '2026-04-14 01:40:11', '2026-04-14 01:40:11'),
(8, 2, 'login', 'Đăng nhập thành công', '2026-04-14 01:46:04', '2026-04-14 01:46:04'),
(9, 12, 'login', 'Đăng nhập thành công', '2026-04-14 01:48:20', '2026-04-14 01:48:20'),
(10, 3, 'login', 'Đăng nhập thành công', '2026-04-14 01:49:24', '2026-04-14 01:49:24'),
(11, 3, 'request_update_profile', 'Gửi yêu cầu cập nhật hồ sơ', '2026-04-14 01:50:32', '2026-04-14 01:50:32'),
(12, 2, 'login', 'Đăng nhập thành công', '2026-04-14 01:50:59', '2026-04-14 01:50:59'),
(13, 3, 'login', 'Đăng nhập thành công', '2026-04-14 01:51:41', '2026-04-14 01:51:41'),
(14, 2, 'login', 'Đăng nhập thành công', '2026-04-14 01:53:20', '2026-04-14 01:53:20'),
(15, 13, 'login', 'Đăng nhập thành công', '2026-04-14 17:17:27', '2026-04-14 17:17:27'),
(16, 6, 'login', 'Đăng nhập thành công', '2026-04-14 17:17:50', '2026-04-14 17:17:50'),
(17, 2, 'login', 'Đăng nhập thành công', '2026-04-14 17:18:35', '2026-04-14 17:18:35'),
(18, 13, 'login', 'Đăng nhập thành công', '2026-04-14 17:19:21', '2026-04-14 17:19:21'),
(19, 14, 'login', 'Đăng nhập thành công', '2026-04-14 17:20:06', '2026-04-14 17:20:06'),
(20, 16, 'login', 'Đăng nhập thành công', '2026-04-14 17:20:37', '2026-04-14 17:20:37'),
(21, 15, 'login', 'Đăng nhập thành công', '2026-04-14 17:21:25', '2026-04-14 17:21:25'),
(22, 3, 'login', 'Đăng nhập thành công', '2026-04-14 17:22:02', '2026-04-14 17:22:02'),
(23, 3, 'request_update_profile', 'Gửi yêu cầu cập nhật hồ sơ', '2026-04-14 17:22:37', '2026-04-14 17:22:37'),
(24, 2, 'login', 'Đăng nhập thành công', '2026-04-14 17:23:31', '2026-04-14 17:23:31'),
(25, 16, 'login', 'Đăng nhập thành công', '2026-04-14 17:24:24', '2026-04-14 17:24:24'),
(26, 2, 'login', 'Đăng nhập thành công', '2026-04-14 17:25:05', '2026-04-14 17:25:05'),
(27, 2, 'login', 'Đăng nhập thành công', '2026-04-14 17:26:08', '2026-04-14 17:26:08'),
(28, 16, 'login', 'Đăng nhập thành công', '2026-04-14 17:26:25', '2026-04-14 17:26:25'),
(29, 16, 'login', 'Đăng nhập thành công', '2026-04-14 17:29:10', '2026-04-14 17:29:10'),
(30, 2, 'login', 'Đăng nhập thành công', '2026-04-14 17:29:29', '2026-04-14 17:29:29'),
(31, 6, 'login', 'Đăng nhập thành công', '2026-04-14 18:39:22', '2026-04-14 18:39:22'),
(32, 12, 'login', 'Đăng nhập thành công', '2026-04-14 19:00:37', '2026-04-14 19:00:37'),
(33, 16, 'login', 'Đăng nhập thành công', '2026-04-14 19:01:02', '2026-04-14 19:01:02'),
(34, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:01:48', '2026-04-14 19:01:48'),
(35, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:04:26', '2026-04-14 19:04:26'),
(36, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:10:13', '2026-04-14 19:10:13'),
(37, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:20:56', '2026-04-14 19:20:56'),
(38, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:22:20', '2026-04-14 19:22:20'),
(39, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:32:50', '2026-04-14 19:32:50'),
(40, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:37:56', '2026-04-14 19:37:56'),
(41, 2, 'login', 'Đăng nhập thành công', '2026-04-14 19:38:21', '2026-04-14 19:38:21'),
(42, 6, 'login', 'Đăng nhập thành công', '2026-04-14 19:39:25', '2026-04-14 19:39:25');

-- --------------------------------------------------------

--
-- [REMOVED] 3 VIEWs đã bị xóa vì tham chiếu đến bảng không tồn tại:
-- - v_ket_qua_giang_vien (cần: ket_qua_kiem_tra, khoa, giang_vien)
-- - v_ke_hoach_khoa_dien (cần: chi_tiet_ke_hoach, ke_hoach_khai_thac, giang_vien, thiet_bi)
-- - v_tong_hop_khoa (cần: bao_cao_tong_hop, khoa)
-- Các VIEWs này thuộc schema cũ, không tương thích với schema Laravel hiện tại.
--

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_plan_id_foreign` (`plan_id`),
  ADD KEY `audit_logs_user_id_foreign` (`user_id`);

--
-- Chỉ mục cho bảng `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_code_unique` (`code`);

--
-- Chỉ mục cho bảng `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equipment_code_unique` (`code`),
  ADD KEY `equipment_location_id_foreign` (`location_id`);

--
-- Chỉ mục cho bảng `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locations_code_unique` (`code`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plans_code_unique` (`code`),
  ADD KEY `plans_user_id_foreign` (`user_id`),
  ADD KEY `plans_department_id_foreign` (`department_id`),
  ADD KEY `plans_status_index` (`status`),
  ADD KEY `plans_month_year_index` (`month`, `year`);

--
-- Chỉ mục cho bảng `plan_items`
--
ALTER TABLE `plan_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_items_plan_id_foreign` (`plan_id`),
  ADD KEY `plan_items_location_id_foreign` (`location_id`),
  ADD KEY `plan_items_equipment_id_foreign` (`equipment_id`),
  ADD KEY `plan_items_executor_id_foreign` (`executor_id`),
  ADD KEY `plan_items_mentor_id_foreign` (`mentor_id`),
  ADD KEY `plan_items_type_index` (`type`);

--
-- Chỉ mục cho bảng `plan_weeks`
--
ALTER TABLE `plan_weeks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_weeks_unique` (`plan_id`, `user_id`, `week_label`),
  ADD KEY `plan_weeks_plan_id_foreign` (`plan_id`),
  ADD KEY `plan_weeks_user_id_foreign` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- Chỉ mục cho bảng `user_activities`
--
ALTER TABLE `user_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_activities_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT cho bảng `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `plan_items`
--
ALTER TABLE `plan_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `plan_weeks`
--
ALTER TABLE `plan_weeks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT cho bảng `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `plans`
--
ALTER TABLE `plans`
  ADD CONSTRAINT `plans_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `plan_items`
--
ALTER TABLE `plan_items`
  ADD CONSTRAINT `plan_items_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `plan_items_executor_id_foreign` FOREIGN KEY (`executor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `plan_items_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `plan_items_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `plan_items_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `plan_weeks`
--
ALTER TABLE `plan_weeks`
  ADD CONSTRAINT `plan_weeks_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_weeks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `user_activities`
--
ALTER TABLE `user_activities`
  ADD CONSTRAINT `user_activities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
