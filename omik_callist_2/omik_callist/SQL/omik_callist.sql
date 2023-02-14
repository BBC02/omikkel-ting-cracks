DROP TABLE IF EXISTS `omik_callist`;

CREATE TABLE `omik_callist` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from_identifier` text NOT NULL,
  `message` text NOT NULL,
  `sender` varchar(40) NOT NULL,
  `receiver` varchar(40) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`coords`)),
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`status`)),
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;