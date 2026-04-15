-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 15, 2026 lúc 01:23 AM
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
(5, 'Khoa Ô tô', 'KOT', '2026-04-13 23:54:34', '2026-04-13 23:54:34');

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
(10, 'App\\Models\\User', 2, 'auth-token', '1ad1e06426fa9db74ce9af58c08c4656acb713cbc2e44dd1b6ed947083125e00', '[\"*\"]', '2026-04-14 01:54:22', NULL, '2026-04-14 01:53:20', '2026-04-14 01:54:22');

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
(3, 'Phạm Thị Kim Phúc', '01002006', NULL, '$2y$12$7d0NaQxLB8eiA2ZS4P5tXOIE0sJFW6wYFUKNtZMXOaKmq.0eedhsG', 'DEPT_HEAD', 3, NULL, '2026-04-13 23:54:35', '2026-04-14 01:51:15', 'ACTIVE', NULL, NULL, 'Nữ', 'ptkphuc@saodo.edu.vn', NULL),
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
(17, 'Nguyễn Thị Hiền', '01002008', NULL, '$2y$12$6RUUyG8qwC5w6Of7XNhucOJX49uSmnOz5ecfQyFZU2mRGZo8bJygO', 'TEACHER', 3, NULL, '2026-04-14 01:55:26', '2026-04-14 01:55:26', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(18, 'Bùi Thị Loan', '01002011', NULL, '$2y$12$oYu//s98/gJP3XdAUslrgOv4ciEhFBieIX2bhVAE6oy9pulP1Gw.2', 'TEACHER', 3, NULL, '2026-04-14 01:55:57', '2026-04-14 01:55:57', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(19, 'Nguyễn Thị Hằng', '01002012', NULL, '$2y$12$wi6e9132uzs/ml8EHI90OuI46QRRqEjNkcopzfxTEIOgGwCxsQ15.', 'TEACHER', 3, NULL, '2026-04-14 01:56:22', '2026-04-14 01:56:22', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(20, 'Nguyễn Quang Thoại', '01002013', NULL, '$2y$12$qImDvB7yZtANPd1EtPNyXuji9Ml5O0A2GCiTFWSa/7/q8O755QgTe', 'TEACHER', 3, NULL, '2026-04-14 01:56:44', '2026-04-14 01:56:44', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(21, 'Đỗ Thị Làn', '01002019', NULL, '$2y$12$XOVWAExwm/iQDn/iB3bRReTuiwWtvEcC1lzF2OCBSmmgMfabrmldu', 'TEACHER', 3, NULL, '2026-04-14 01:57:08', '2026-04-14 01:57:08', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(22, 'Nguyễn Thị Hồi', '01002021', NULL, '$2y$12$QvJbXokUVwUqzlZTI745u.ZgDDtS1OK7b458fPaC7CD2py/kX.Sc6', 'TEACHER', 3, NULL, '2026-04-14 01:57:33', '2026-04-14 01:57:33', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(23, 'Vũ Thành Trung', '01001003', NULL, '$2y$12$1i8A4M1d182I/BurhpfBZ.x77RHb.3/lO/Akn/1LZLbiMJdnSX8EK', 'TEACHER', 5, NULL, '2026-04-14 01:58:40', '2026-04-14 01:58:40', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(24, 'Cao Huy Giáp', '01001004', NULL, '$2y$12$odD56EZnViRKjaPAIDfFHeK.LXhUSEPOmL68vX2iesUBv4GMHhUC6', 'TEACHER', 5, NULL, '2026-04-14 01:59:03', '2026-04-14 01:59:03', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(25, 'Lê Đức Thắng', '1021008', NULL, '$2y$12$Bk5n46Mo6raKKf3BtkYHKevYMQklYsL/JWEaeI/RgZRyv2SumGvAi', 'TEACHER', 5, NULL, '2026-04-14 01:59:24', '2026-04-14 01:59:24', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(26, 'Nguyễn Lương Căn', '01001006', NULL, '$2y$12$Sl/TtmtHuvrsPKIe80/0qOo/vhJ0a7V0ijO52Rt9M2vVRw.mO4pXu', 'TEACHER', 5, NULL, '2026-04-14 01:59:46', '2026-04-14 01:59:46', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(27, 'Phùng Đức Hải Anh', '01001011', NULL, '$2y$12$FNj2TtUXsDtQss3CDH/sF.w0ZbC9pPEK/1lEReVKKrJpms8wfcF7i', 'TEACHER', 5, NULL, '2026-04-14 02:00:07', '2026-04-14 02:00:07', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(28, 'Đỗ Tiến Quyết', '01001014', NULL, '$2y$12$vDVRmSWp23SRft5EfkBou.6cEOF5X1skoPJgKXevLYYXd7y8/w.lq', 'TEACHER', 5, NULL, '2026-04-14 02:00:31', '2026-04-14 02:00:31', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(29, 'Phạm Văn Trọng', '01001018', NULL, '$2y$12$E3NRUXTgLPfaKLmBSZnQ0etoi7o5Yfv9qND3QsiqQKseoOWRgs7sy', 'TEACHER', 5, NULL, '2026-04-14 02:00:56', '2026-04-14 02:00:56', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(30, 'Nguyễn Ngọc Đàm', '01004028', NULL, '$2y$12$8tJSw6P1hJmOhiUKWfW2NeBMLRGlnqneesiC4bPwZHs34jv9A/4G2', 'TEACHER', 5, NULL, '2026-04-14 02:02:37', '2026-04-14 02:02:37', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(31, 'Vũ Hoa Kỳ', '01004011', NULL, '$2y$12$GMLuvIE3F6CLiq.yB2/gZe.K0B7tuQ096WIeKQ34RbJFlIpGruqy2', 'TEACHER', 2, NULL, '2026-04-14 02:04:30', '2026-04-14 02:04:30', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(32, 'Mạc Văn Giang', '01004013', NULL, '$2y$12$bpd7eTJsqfGBhXJ4oRrPWeFeLYseKDuoLkSk8vDag/0QkMNt9ywZ2', 'TEACHER', 2, NULL, '2026-04-14 02:07:27', '2026-04-14 02:07:27', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(33, 'Nguyễn Danh Đạo', '01009014', NULL, '$2y$12$L1a1Oti7yagWInuc7plqzO19EXdZUJh8ObODBhnmk7KFkVMjhu4fC', 'TEACHER', 2, NULL, '2026-04-14 02:07:50', '2026-04-14 02:07:50', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(34, 'Đào Văn Kiên', '01004030', NULL, '$2y$12$9ACe.12vzQX5GHKF.jvLQ.E5p00O09qmXCJN3xtKG20G8dgE5HbRG', 'TEACHER', 2, NULL, '2026-04-14 02:08:11', '2026-04-14 02:08:11', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(35, 'Mạc Thị Nguyên', '01004036', NULL, '$2y$12$fY6ETkfRzymmI0ksHhh5luNf0AVTunX0cEHC3.EyZXjYf69NpD4xu', 'TEACHER', 2, NULL, '2026-04-14 02:08:35', '2026-04-14 02:08:35', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(36, 'Nguyễn Thị Hồng Nhung', '01004037', NULL, '$2y$12$GUQJ3ekt0xzkkQWxUro7cun0MgU0os3cnZJ5aS0FgOVtSN3rWtt3a', 'TEACHER', 2, NULL, '2026-04-14 02:08:58', '2026-04-14 02:08:58', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(37, 'Nguyễn Thị Liễu', '01004040', NULL, '$2y$12$E8zhRGbHgx5rQeU9yU/WMeajvmH6J/p6BTycq0I6LNb5qlh1Sdcmy', 'TEACHER', 2, NULL, '2026-04-14 02:09:19', '2026-04-14 02:09:19', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(38, 'Dương Thị Hà', '01004055', NULL, '$2y$12$CHUIO/FoZllDA5uftKR9v./4KxEKFP1WmOMZDx/filHii4FD.xprK', 'TEACHER', 2, NULL, '2026-04-14 02:09:42', '2026-04-14 02:09:42', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(39, 'Trịnh Văn Cường', '01005030', NULL, '$2y$12$gTI5ZA1jc2DEIBDQu3ySl.6IMwAj25wVEudqQpvhXD6NpgUgPcBnW', 'TEACHER', 2, NULL, '2026-04-14 02:14:28', '2026-04-14 02:14:28', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(40, 'Nguyễn Hữu Chấn', '01014013', NULL, '$2y$12$8rZltkTf8EWjVL80z5jJV.uZKHQp3v17nP462alFR8QyWmM/Iz0Iu', 'TEACHER', 2, NULL, '2026-04-14 02:14:54', '2026-04-14 02:14:54', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(41, 'Nguyễn Thị Tâm', '01006005', NULL, '$2y$12$DvLNbzvqmrynw5foTtHN0.cFARDvxdD.2v6DUPc075sLcHsMtNwPS', 'TEACHER', 1, NULL, '2026-04-14 02:15:44', '2026-04-14 02:15:44', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(42, 'Tạ Thị Mai', '01006007', NULL, '$2y$12$RZykbmkU8abkHO7SwlWPheCrvrNqmEuVZTN0Al8/raemWGB4o0WG6', 'TEACHER', 1, NULL, '2026-04-14 02:16:03', '2026-04-14 02:16:03', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(43, 'Lê Ngọc Hòa', '01006008', NULL, '$2y$12$QhYqqwaASKTd2xPk6KM5YeKb5fFksP6WsxB8lN.qPrY5aSLPfdBUy', 'TEACHER', 1, NULL, '2026-04-14 02:16:24', '2026-04-14 02:16:24', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(44, 'Đỗ Huy tùng', '01006009', NULL, '$2y$12$omA0oLtnbBnjZ7rW6JolWeg5iIorF9hQf0Mro6IaNMlEZtNINtcee', 'TEACHER', 1, NULL, '2026-04-14 02:16:47', '2026-04-14 02:16:47', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(45, 'Phạm Văn Tuấn', '01006020', NULL, '$2y$12$rDBMPeR3k9CSHbVnpCVbfeLR9QB2RXV1Nc1sfiQS8KcYHxAEUKufO', 'TEACHER', 1, NULL, '2026-04-14 02:17:12', '2026-04-14 02:17:12', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(46, 'Phạm Đức Khẩn', '01006021', NULL, '$2y$12$TXxKIjMcrk.hlsN.qf6hY.5C02CHJDV9a3BhQx0wbkGW7.v2ftMJu', 'TEACHER', 1, NULL, '2026-04-14 02:17:32', '2026-04-14 02:17:32', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(47, 'Nguyễn Trương Huy', '01006023', NULL, '$2y$12$STW06CS5x9Z3FSV5.Lh5Qe/O8.K0.k4S3k0fBHn79PqumP2BUgSR6', 'TEACHER', 1, NULL, '2026-04-14 02:17:59', '2026-04-14 02:17:59', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(48, 'Đặng Văn Tuệ', '01006024', NULL, '$2y$12$6ag8UjS50p1irnXxRLkg4eZACp86kCeX/n7lTRvYDnNS6CLYGw6.q', 'TEACHER', 1, NULL, '2026-04-14 02:18:17', '2026-04-14 02:18:17', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(49, 'Phạm Văn Tài', '01006033', NULL, '$2y$12$qvRGM6VbsE7sBBguzlv.OeKU.gtpT/il6z.1/54IXAQ/dkG3azfty', 'TEACHER', 1, NULL, '2026-04-14 02:18:38', '2026-04-14 02:18:38', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(50, 'Phạm Công Tảo', '01006034', NULL, '$2y$12$Vam/W4odL.I.EwfhChAvn.QMIBGjMi5KLVnkqO9Bd1POKNkMCbT1e', 'TEACHER', 1, NULL, '2026-04-14 02:18:57', '2026-04-14 02:18:57', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(51, 'Vũ Hồng Phong', '01006037', NULL, '$2y$12$bKMyy4.1c7K7cYuZFAmmweYLAmTp3EfGT6OLrU8aMGowV54tJXj1G', 'TEACHER', 1, NULL, '2026-04-14 02:19:18', '2026-04-14 02:19:18', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(52, 'Lê Văn Sơn', '01007012', NULL, '$2y$12$VE0ITAdepgeQftZ0O3MCDOU.J8OJdowNq3mZczBOwxRuUD5Progmy', 'TEACHER', 1, NULL, '2026-04-14 02:19:38', '2026-04-14 02:19:38', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(53, 'Vũ Trí Võ', '01007013', NULL, '$2y$12$yvWWfx2/5f.ZfWWQ/QK.heoUFn2G.LLDpuTOmN2JHejFNxE4C0hYC', 'TEACHER', 1, NULL, '2026-04-14 02:19:54', '2026-04-14 02:19:54', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(54, 'Nguyễn Văn Tiến', '01007021', NULL, '$2y$12$jbEXMadyrkIWOcs0CNz0CuRJAMetcK2AYVOp3fSPp.3A8GlnOg0HO', 'TEACHER', 1, NULL, '2026-04-14 02:20:14', '2026-04-14 02:20:14', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(55, 'Nguyễn Tiến Phúc', '01007026', NULL, '$2y$12$BJkzC0rTY2SNZAHDYRyknOv752pjpQQb/09E1jhuP1k8W3MUxNTw6', 'TEACHER', 1, NULL, '2026-04-14 02:20:35', '2026-04-14 02:20:35', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(56, 'Nguyễn Thị Quyên', '01007028', NULL, '$2y$12$mILgBl.X014mHjCYr0o3yuOCU5RrSkn3CKWMoCoHs.tkfzit1hfpi', 'TEACHER', 1, NULL, '2026-04-14 02:20:57', '2026-04-14 02:20:57', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(57, 'Dương Thị Hoa', '01006049', NULL, '$2y$12$4jy6FAP2DmxJ6.PHWQTtNuboUHQWuWob4EAgb7NtFUhW3M1TJt3yK', 'TEACHER', 1, NULL, '2026-04-14 02:21:14', '2026-04-14 02:21:14', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(58, 'Nguyễn Thị Việt Hương', '01006040', NULL, '$2y$12$8txiF1nAGC484JKXNcBtrOGGC8ATRlh57kyhY2oeILiX.MXvbdEuK', 'TEACHER', 1, NULL, '2026-04-14 02:21:35', '2026-04-14 02:21:35', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(59, 'Lương Thị Thanh Xuân', '01006038', NULL, '$2y$12$iXkNdVrfwo925IrylWuBq./73MJzCLHpRBBuEHNSbtjTRdOgAL4eS', 'TEACHER', 1, NULL, '2026-04-14 02:21:58', '2026-04-14 02:21:58', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(60, 'Nguyễn Thị Phưpng Oanh', '01006036', NULL, '$2y$12$pylG7jxdfbmAlc.AeAVEhuji44VOAkAKnhslQs9l81RuozIsHbjxC', 'TEACHER', 1, NULL, '2026-04-14 02:22:25', '2026-04-14 02:22:25', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(61, 'Lê Thị Mai', '1021009', NULL, '$2y$12$./h82SQ1.OlO3Pr5uM1k8.X/XQxRpYYmTTQXO3Zitr37efeWNqjpe', 'TEACHER', 1, NULL, '2026-04-14 02:22:45', '2026-04-14 02:22:45', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(62, 'Nguyễn Thị Phương', '01006029', NULL, '$2y$12$5oPQBT8wxLD8j6LwgTGfbuqxMYRyl6XDdAkCqmSy9bkGXOkFsQuWu', 'TEACHER', 1, NULL, '2026-04-14 02:23:10', '2026-04-14 02:23:10', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(63, 'Phạm Thị Thảo', '01006028', NULL, '$2y$12$pnYSmq6EsjDr.xXs47tKtOM8QDR1WuOM1hvM9FS45grg.henbU.3a', 'TEACHER', 1, NULL, '2026-04-14 02:23:31', '2026-04-14 02:23:31', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(64, 'Nguyễn Thị Thảo', '01006026', NULL, '$2y$12$ivM7DhK4k9onSv/JYRVnXuzTwYWSJutwnr9VPahhrtf2aNRpwXTQy', 'TEACHER', 1, NULL, '2026-04-14 02:23:52', '2026-04-14 02:23:52', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(65, 'Nguyễn Thị Sim', '01006011', NULL, '$2y$12$GJ1MO3VVFUfJY8C2r3jF/uOWHkCTbqRdrQhrX.zmOgdUYl75XdzL6', 'TEACHER', 1, NULL, '2026-04-14 02:24:37', '2026-04-14 02:24:37', 'PENDING', NULL, NULL, 'Nữ', NULL, NULL),
(66, 'Nguyễn Trọng Quỳnh', '01022001', NULL, '$2y$12$OP8WiHOq9foOa4d/uXoyVuxWcug4L5VS1RxEi67Zd1PGpMLIh01gO', 'TEACHER', 1, NULL, '2026-04-14 02:27:13', '2026-04-14 02:27:13', 'PENDING', NULL, NULL, 'Nam', NULL, NULL),
(67, 'Vũ Quang Ngọc', '01015013', NULL, '$2y$12$JsfRPmkrarPWrk5JGxVZWejMqcM6bGl/M3BzeWztP7xKAtgRxfj6C', 'TEACHER', 1, NULL, '2026-04-14 02:27:53', '2026-04-14 02:27:53', 'PENDING', NULL, NULL, 'Nam', NULL, NULL);

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
(14, 2, 'login', 'Đăng nhập thành công', '2026-04-14 01:53:20', '2026-04-14 01:53:20');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `v_ket_qua_giang_vien`
-- (See below for the actual view)
--
CREATE TABLE `v_ket_qua_giang_vien` (
`dummy` int
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `v_ke_hoach_khoa_dien`
-- (See below for the actual view)
--
CREATE TABLE `v_ke_hoach_khoa_dien` (
`dummy` int
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `v_tong_hop_khoa`
-- (See below for the actual view)
--
CREATE TABLE `v_tong_hop_khoa` (
`dummy` int
);

-- --------------------------------------------------------

--
-- Cấu trúc cho view `v_ket_qua_giang_vien`
--
DROP TABLE IF EXISTS `v_ket_qua_giang_vien`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ket_qua_giang_vien`  AS SELECT `k`.`ten_khoa` AS `ten_khoa`, `gv`.`ho_ten` AS `giang_vien`, `kt`.`tuan_01_07` AS `tuan_01_07`, `kt`.`tuan_08_14` AS `tuan_08_14`, `kt`.`tuan_15_21` AS `tuan_15_21`, `kt`.`tuan_22_28` AS `tuan_22_28`, `kt`.`tuan_29_31` AS `tuan_29_31`, `kt`.`so_gio_ke_hoach` AS `gio_KH`, `kt`.`so_gio_thuc_hien` AS `gio_TH`, round(`kt`.`so_gio_thuc_hien` * 100.0 / nullif(`kt`.`so_gio_ke_hoach`,0),1) AS `ty_le_hoanthanh_pct`, `kt`.`ghi_chu` AS `ghi_chu`, `kt`.`thang` AS `thang`, `kt`.`nam` AS `nam` FROM ((`ket_qua_kiem_tra` `kt` join `khoa` `k` on(`k`.`id` = `kt`.`khoa_id`)) join `giang_vien` `gv` on(`gv`.`id` = `kt`.`giang_vien_id`)) ORDER BY `k`.`id` ASC, `gv`.`ho_ten` ASC ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `v_ke_hoach_khoa_dien`
--
DROP TABLE IF EXISTS `v_ke_hoach_khoa_dien`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ke_hoach_khoa_dien`  AS SELECT `ct`.`stt` AS `stt`, `ct`.`loai_doi_tuong` AS `loai_doi_tuong`, `gv`.`ho_ten` AS `nguoi_thuc_hien`, `ct`.`ten_chu_de` AS `ten_chu_de`, `tb`.`ten_thiet_bi` AS `ten_thiet_bi`, `ct`.`dia_diem` AS `dia_diem`, `ct`.`thoi_gian_thuc_hien` AS `thoi_gian_thuc_hien`, `ct`.`so_gio_du_kien` AS `so_gio_du_kien`, `ct`.`du_kien_ket_qua` AS `du_kien_ket_qua`, `ct`.`danh_gia` AS `danh_gia`, `ct`.`ket_qua_dat_duoc` AS `ket_qua_dat_duoc` FROM (((`chi_tiet_ke_hoach` `ct` join `ke_hoach_khai_thac` `kh` on(`kh`.`id` = `ct`.`ke_hoach_id`)) left join `giang_vien` `gv` on(`gv`.`id` = `ct`.`giang_vien_id`)) left join `thiet_bi` `tb` on(`tb`.`id` = `ct`.`thiet_bi_id`)) WHERE `kh`.`khoa_id` = 1 AND `kh`.`thang` = 12 AND `kh`.`nam` = 2025 ORDER BY `ct`.`loai_doi_tuong` ASC, `ct`.`stt` ASC ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `v_tong_hop_khoa`
--
DROP TABLE IF EXISTS `v_tong_hop_khoa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tong_hop_khoa`  AS SELECT `k`.`ten_khoa` AS `ten_khoa`, `bt`.`so_giang_vien_khai_thac` AS `so_GV`, `bt`.`tong_so_gio` AS `tong_so_gio`, `bt`.`nguoi_xac_nhan` AS `nguoi_xac_nhan`, `bt`.`ngay_bao_cao` AS `ngay_bao_cao`, `bt`.`thang` AS `thang`, `bt`.`nam` AS `nam` FROM (`bao_cao_tong_hop` `bt` join `khoa` `k` on(`k`.`id` = `bt`.`khoa_id`)) ORDER BY `bt`.`tong_so_gio` DESC ;

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
  ADD KEY `equipment_location_id_foreign` (`location_id`);

--
-- Chỉ mục cho bảng `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `plans_department_id_foreign` (`department_id`);

--
-- Chỉ mục cho bảng `plan_items`
--
ALTER TABLE `plan_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_items_plan_id_foreign` (`plan_id`),
  ADD KEY `plan_items_location_id_foreign` (`location_id`),
  ADD KEY `plan_items_equipment_id_foreign` (`equipment_id`),
  ADD KEY `plan_items_executor_id_foreign` (`executor_id`),
  ADD KEY `plan_items_mentor_id_foreign` (`mentor_id`);

--
-- Chỉ mục cho bảng `plan_weeks`
--
ALTER TABLE `plan_weeks`
  ADD PRIMARY KEY (`id`),
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT cho bảng `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
