CREATE DATABASE IF NOT EXISTS `relations` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'relations'@'%' IDENTIFIED BY 'relations';
GRANT ALL PRIVILEGES ON `relations`.* TO 'relations'@'%';

CREATE DATABASE IF NOT EXISTS `notes` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'notes'@'%' IDENTIFIED BY 'notes';
GRANT ALL PRIVILEGES ON `notes`.* TO 'notes'@'%';

CREATE DATABASE IF NOT EXISTS `eventlog` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'eventlog'@'%' IDENTIFIED BY 'eventlog';
GRANT ALL PRIVILEGES ON `eventlog`.* TO 'eventlog'@'%';

CREATE DATABASE IF NOT EXISTS `message_exchange` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'message_exchange'@'%' IDENTIFIED BY 'message_exchange';
GRANT ALL PRIVILEGES ON `message_exchange`.* TO 'message_exchange'@'%';

CREATE DATABASE IF NOT EXISTS `messaging_settings` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'messaging_settings'@'%' IDENTIFIED BY 'messaging_settings';
GRANT ALL PRIVILEGES ON `messaging_settings`.* TO 'messaging_settings'@'%';

CREATE DATABASE IF NOT EXISTS `templating` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'templating'@'%' IDENTIFIED BY 'templating';
GRANT ALL PRIVILEGES ON `templating`.* TO 'templating'@'%';

CREATE DATABASE IF NOT EXISTS `support_management` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'support_management'@'%' IDENTIFIED BY 'support_management';
GRANT ALL PRIVILEGES ON `support_management`.* TO 'support_management'@'%';

CREATE DATABASE IF NOT EXISTS `case_status` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'case_status'@'%' IDENTIFIED BY 'case_status';
GRANT ALL PRIVILEGES ON `case_status`.* TO 'case_status'@'%';

CREATE DATABASE IF NOT EXISTS `messaging` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'messaging'@'%' IDENTIFIED BY 'messaging';
GRANT ALL PRIVILEGES ON `messaging`.* TO 'messaging'@'%';

CREATE DATABASE IF NOT EXISTS `case_data` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'case_data'@'%' IDENTIFIED BY 'case_data';
GRANT ALL PRIVILEGES ON `case_data`.* TO 'case_data'@'%';

CREATE DATABASE IF NOT EXISTS `case_management` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'case_management'@'%' IDENTIFIED BY 'case_management';
GRANT ALL PRIVILEGES ON `case_management`.* TO 'case_management'@'%';

CREATE DATABASE IF NOT EXISTS `access_mapper` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'access_mapper'@'%' IDENTIFIED BY 'access_mapper';
GRANT ALL PRIVILEGES ON `access_mapper`.* TO 'access_mapper'@'%';

FLUSH PRIVILEGES;