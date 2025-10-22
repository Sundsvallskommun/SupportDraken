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


FLUSH PRIVILEGES;
 