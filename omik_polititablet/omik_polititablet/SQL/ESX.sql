ALTER TABLE users
ADD COLUMN IF NOT EXISTS `officer_id` int(11) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `tablet_notes` text NOT NULL DEFAULT '',
ADD COLUMN IF NOT EXISTS `profile_logo` text NOT NULL DEFAULT 'https://i.imgur.com/YSXdYqv.png';

ALTER TABLE owned_vehicles
ADD COLUMN IF NOT EXISTS `thumbnail` text NOT NULL DEFAULT 'https://www.auto123.com/static/auto123/images/unknown.692d9ec5c563.png';

CREATE TABLE IF NOT EXISTS `omik_polititablet_ansatte` (
  `officer_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `badge_number` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `on_duty` tinyint(1) NOT NULL,
  `rank` varchar(100) NOT NULL,
  `responsible_area` varchar(100) NOT NULL,
  `profile_logo` text NOT NULL DEFAULT 'https://i.imgur.com/YSXdYqv.png',
  `employment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `fleetStatus` text NOT NULL DEFAULT '',
  `certificates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`certificates`)),
  `educations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}' CHECK (json_valid(`permissions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE omik_polititablet_ansatte
ADD COLUMN IF NOT EXISTS `fleetStatus` text NOT NULL DEFAULT '';

CREATE TABLE IF NOT EXISTS `omik_polititablet_logs` (
    `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `officer_id` int(11) NOT NULL,  
    `action` varchar(100) NOT NULL,
    `title` varchar(300) NOT NULL,
    `description` text NOT NULL,
    `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    CONSTRAINT `omik_polititablet_logs_ibfk_1` 
        FOREIGN KEY (`officer_id`) REFERENCES `omik_polititablet_ansatte` (`officer_id`) 
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `omik_polititablet_ansogninger_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `officer_id` int(11) NOT NULL,
  `structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`structure`)),
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `omik_polititablet_ansogninger`;
CREATE TABLE IF NOT EXISTS `omik_polititablet_ansogninger` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `formID` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`structure`)),
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  CONSTRAINT `omik_polititablet_ansogninger_ibfk_1` 
    FOREIGN KEY (`formID`) REFERENCES `omik_polititablet_ansogninger_forms` (`id`) 
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`config`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `omik_polititablet_config` (`id`, `config`) VALUES
(1, '{\"permissions\":{\"admin\":{\"label\":\"Administrator - Alle rettigheder\",\"value\":false},\"edit_daily_msg\":{\"label\":\"Ret dagens besked\",\"value\":false},\"edit_guides\":{\"label\":\"Ret/slet guides\",\"value\":false},\"edit_posts\":{\"label\":\"Ret/slet opslag\",\"value\":false},\"edit_laws\":{\"label\":\"Ret/slet love\",\"value\":false},\"edit_employees\":{\"label\":\"Ret/slet ansatte\",\"value\":false},\"edit_certificates\":{\"label\":\"Ret betjentes certifikater\",\"value\":false},\"edit_educations\":{\"label\":\"Ret betjentes uddannelser\",\"value\":false},\"edit_warrants\":{\"label\":\"Ret efterlysninger\",\"value\":false},\"del_warrants\":{\"label\":\"Slet efterlysninger\",\"value\":false},\"accept_ansogninger\":{\"label\":\"Accepter ansøgninger\",\"value\":false},\"create_ansogninger_templates\":{\"label\":\"Opret Ansøgnings Skabeloner\",\"value\":false}},\"general\":{\"showDriversLicenseStatus\":true,\"maxClips\":3,\"disqDays\":\"3\"},\"extra\":{\"customSpeedTicket\":false,\"loweredOffense\":false,\"autoCharge\":false,\"logEvents\":false},\"webhooks\":{\"newOffense\":\"\",\"newWarrant\":\"\",\"newEmployee\":\"\",\"newPost\":\"\"}}');

CREATE TABLE IF NOT EXISTS `omik_polititablet_efterlysninger` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `type` enum('vehicle','person') NOT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL DEFAULT 'Ingen beskrivelse',
  `offenses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '[]',
  `officer_id` int(11) NOT NULL,
  `date` varchar(100) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_frakendelser` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `identifier` varchar(100) NOT NULL,
  `expires` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_guides` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `officer_id` int(11) NOT NULL,
  `color` varchar(40) NOT NULL,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `officer_id` int(11) NOT NULL,
  `daily_msg` tinyint(1) NOT NULL DEFAULT 0,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `likes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`likes`)),
  `dislikes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`dislikes`)),
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_laws` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `type` varchar(40) NOT NULL,
  `law` text NOT NULL,
  `paragraph` varchar(40) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `cols` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}' CHECK (json_valid(`cols`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `omik_polititablet_sigtelser` (
  `offense_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `identifier` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `officer_id` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `officers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`officers`)),
  `offenses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`offenses`)),
  `confiscated` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`confiscated`)),
  `lawyer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`lawyer`)),
  `weapons_used` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`weapons_used`)),
  `total_offense_amount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`total_offense_amount`)),
  `report` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE owned_vehicles CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE owned_properties CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE properties CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;