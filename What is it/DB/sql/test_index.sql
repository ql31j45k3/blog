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

INSERT INTO `test_student` (`no`, `name`, `age`, `score`, `department＿id`)
VALUE ('s0003', '小明', 19, 100, 1),
    ('s0004', '小黃', 19, 100, 1),
    ('s0005', 'abboy', 19, 100, 2),
    ('s0006', '好正', 19, 100, 3),
    ('s0007', '正妹就是正', 19, 100, 4),
    ('s0008', '小明的好朋友', 19, 100, 5),
    ('s0009', '小明的壞朋友', 19, 100, 6),
    ('s0010', '小明的敵人', 19, 100, 1)
;

-- 測試用部門 Table
DROP TABLE IF EXISTS `test_department`;
CREATE TABLE `test_department` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '',
    `name` varchar(50) NOT NULL DEFAULT '' COMMENT '',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '測試用部門 Table';

INSERT INTO `test_department` (`name`)
VALUE ('資工'), ('商管'), ('資管'), ('國文'), ('數學'), ('設計')
;

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
