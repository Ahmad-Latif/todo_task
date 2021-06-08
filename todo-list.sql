-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 29, 2021 at 12:05 AM
-- Server version: 5.7.34-0ubuntu0.18.04.1
-- PHP Version: 7.2.34-21+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todo-list`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(12, '2019_08_19_000000_create_failed_jobs_table', 2),
(13, '2021_05_28_182423_create_tests_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('3ff250b66d4faab0253f664fa044aa42d5180acd616c8ab85093d7d5532f92c7992cdd8cd3e737f2', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 12:37:37', '2021-05-28 12:37:37', '2022-05-28 17:37:37'),
('42513ec30e4f38a52b8adff246f8add9bcbe52a144668f678ea8b8a83f07fb28ae608ac407ac7f1d', 3, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 13:19:58', '2021-05-28 13:19:58', '2022-05-28 18:19:58'),
('47ee04fab3e93ebe4c0200a3dd568307debd8440eef9051250d850eaa34012c120ed9c3f3c57c273', 3, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 13:13:58', '2021-05-28 13:13:58', '2022-05-28 18:13:58'),
('55b920e5e8a4919f439bec038b02f33da137b1c26c8188e86536ab27af7c564fa0b6ede6feba8741', 1, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 11:33:55', '2021-05-28 11:33:55', '2022-05-28 16:33:55'),
('8c6405eb214c4a8174eb928dc6caaaefa9efa7c2775f8e42a03aef7c690c38c7db03ea50ffe9e6bb', 3, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 13:26:14', '2021-05-28 13:26:14', '2022-05-28 18:26:14'),
('8ce4c39c1602dd7a493f3884ee35260f42d0a9e3a375df3cbde2c85ffed7086629391695c709bd33', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'authToken', '[]', 0, '2021-05-28 11:26:14', '2021-05-28 11:26:14', '2022-05-28 16:26:14'),
('9f7d9f576508ad471c14929d7742b9eeafefa7f31e497f0b109a8883c4af4ea65267bd1fff48e1a7', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 11:40:06', '2021-05-28 11:40:06', '2022-05-28 16:40:06'),
('b5adfb4d5daf9e1c3ec02015c8d4be56f1e9a0ae40cc6114d4acc561fa3c2559f1301e40f130638b', 3, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 13:10:48', '2021-05-28 13:10:48', '2022-05-28 18:10:48'),
('c2b0af83c5f4c981a434c54c7937cbc2010103c53617f8349ce3fd40e4b97385dc71518cb6fcdcb2', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 12:16:20', '2021-05-28 12:16:20', '2022-05-28 17:16:20'),
('d4b7a4b8260ffbd63ba4ef26c20827d48ada8abd8cdfe1ae664a69ee9489b82b95ce0b8e08917818', 1, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 10:59:31', '2021-05-28 10:59:31', '2022-05-28 15:59:31'),
('dfe1ac38da5c9cea2c1edfa3d6ff03d375a007212291f97388fe9d9b0cb4c7fd29422b9315d9d7d2', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 12:46:39', '2021-05-28 12:46:39', '2022-05-28 17:46:39'),
('e993c271c16f217dcea924e4a352c13ec324dccd95ad5078ac9e4aa2ff195aeaca4b6ba4d75adb89', 3, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 13:19:31', '2021-05-28 13:19:31', '2022-05-28 18:19:31'),
('ef39e9668497f7c9c9b6818c2266a94458fd5be49548a7189798b67544f75e36427d91ddb7d5b149', 2, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', 'Personal Access Token', '[]', 0, '2021-05-28 12:16:36', '2021-05-28 12:16:36', '2022-05-28 17:16:36');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
('938a3207-7f72-4e1b-b18f-7e2bd0054db3', NULL, 'Laravel Personal Access Client', '3azovGo70RtX5MPAlNsN56u3GgPhgDh9SyLlPv5M', NULL, 'http://localhost', 1, 0, 0, '2021-05-28 10:59:01', '2021-05-28 10:59:01'),
('938a3207-838b-4613-9540-3af313e3cd7b', NULL, 'Laravel Password Grant Client', 'HawEkJyqkjrIA4RTxhBJHvuOdEy12GKxDJKuWPCp', 'users', 'http://localhost', 0, 1, 0, '2021-05-28 10:59:01', '2021-05-28 10:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, '938a3207-7f72-4e1b-b18f-7e2bd0054db3', '2021-05-28 10:59:01', '2021-05-28 10:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`id`, `user_id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 3, 'drinks', 'Hello everyone When working in a project, user registration suddenly stopped working correctly. After registration, the email is not sent(although it was sent before), and the redirect does not work correctly... I just ran out of ideas about what I did wrong and what I did wrong. The thing is, I didn\'t even go there... I get the error ', NULL, NULL),
(2, 2, 'juice', 'If you want the currently authorized user, just use app()->user() . Also, you can simplify a lot of your logic and make it much easier to read.', NULL, NULL),
(3, 3, 'bed', 'bed is the furnetuire', '2021-05-28 13:38:25', '2021-05-28 13:38:25'),
(4, 3, 'mouse', 'mouse is the electrnoic', '2021-05-28 13:40:12', '2021-05-28 13:40:12'),
(5, 332, 'bed', 'bed is the furnetuire', '2021-05-28 13:48:52', '2021-05-28 13:48:52'),
(6, 3, 'mobile', 'bed is the furnetuire', '2021-05-28 13:52:11', '2021-05-28 13:52:11');

-- --------------------------------------------------------


--
-- Table structure for table `confirmation_temp`
--

CREATE TABLE `confirmation_temp` (
  `id` int(11) NOT NULL,
  `email` varchar(250) NOT NULL,
  `resetKey` varchar(250) NOT NULL,
  `expDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@admin.com', NULL, '$2y$10$UlNKhaMBwidRRQ/3Z8dOue.2sePGZJfdRUEc96Ox2Ve2t0fGTz.Ri', NULL, NULL, NULL),
(2, NULL, 'admin@gmai.com', NULL, '$2y$10$MabSBwXFwlrOdmwh/CNCNeKW1LSvt.SgShenRobaaPyjzLQUmD7A2', NULL, '2021-05-28 11:26:14', '2021-05-28 11:26:14'),
(3, NULL, 'a@a.com', NULL, '$2y$10$dKJxuQftfB/61D6z.d7iu...jVQGzbbn./KXCvixjl.lvbj4z4MRO', NULL, '2021-05-28 13:10:11', '2021-05-28 13:10:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `confirmation_temp`
--
ALTER TABLE `confirmation_temp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `confirmation_temp`
--
ALTER TABLE `confirmation_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT; 
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
