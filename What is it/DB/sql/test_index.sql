-- 測試用學生 Table
DROP TABLE IF EXISTS `test_student`;
CREATE TABLE `test_student` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `no` varchar(20) NOT NULL DEFAULT '' COMMENT '',
    `name` varchar(50) NOT NULL DEFAULT '' COMMENT '',
    `age` int(11) NOT NULL DEFAULT 0 COMMENT '',
    `score` int(11) NOT NULL DEFAULT 0 COMMENT '',
    `department＿id` bigint unsigned NOT NULL COMMENT '',
    PRIMARY KEY (`id`),
    UNIQUE INDEX un_idx_no(`no`),
    INDEX idx_name (`name`),
    INDEX idx_department＿id (`department＿id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用學生 Table';

-- 測試用部門 Table
DROP TABLE IF EXISTS `test_department`;
CREATE TABLE `test_department` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `name` varchar(50) NOT NULL DEFAULT '' COMMENT '',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用部門 Table';

-- 分隔線

-- 測試用文章 Table
DROP TABLE IF EXISTS `test_post`;
CREATE TABLE `test_post` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `title` varchar(50) NOT NULL DEFAULT '' COMMENT '標題',
    `content` varchar(50) NOT NULL DEFAULT '' COMMENT '內容',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用文章 Table';

-- 測試用標籤 Table
DROP TABLE IF EXISTS `test_tag`;
CREATE TABLE `test_tag` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `name` varchar(50) NOT NULL DEFAULT '' COMMENT '',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用標籤 Table';

-- 測試用標籤 To 文章 Table
DROP TABLE IF EXISTS `test_tag_to_post`;
CREATE TABLE `test_tag_to_post` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `tag_id` bigint unsigned NOT NULL COMMENT '',
    `post_id` bigint unsigned NOT NULL COMMENT '',
    PRIMARY KEY (`id`),
    UNIQUE INDEX un_idx_tag_id_post_id(`tag_id`, `post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用標籤 To 文章 Table';
