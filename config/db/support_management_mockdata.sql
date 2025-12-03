use support_management;

INSERT INTO status(id, created, modified, municipality_id, name, namespace)
VALUES
	(1, now(), null, '2281', 'NEW', 'CONTACTSUNDSVALL'),
	(2, now(), null, '2281', 'ONGOING', 'CONTACTSUNDSVALL'),
	(3, now(), null, '2281', 'PENDING', 'CONTACTSUNDSVALL'),
	(4, now(), null, '2281', 'SOLVED', 'CONTACTSUNDSVALL'),
	(5, now(), null, '2281', 'SUSPENDED', 'CONTACTSUNDSVALL'),
	(6, now(), null, '2281', 'AWAITING_INTERNAL_RESPONSE', 'CONTACTSUNDSVALL'),
	(7, now(), null, '2281', 'ASSIGNED', 'CONTACTSUNDSVALL')
ON DUPLICATE KEY UPDATE
	id = VALUES(id),
	name = VALUES(name),
	created = VALUES(created),
	modified = VALUES(modified),
	municipality_id = VALUES(municipality_id),
	namespace = VALUES(namespace);

INSERT INTO validation(id, created, modified, municipality_id, namespace, type, validated)
VALUES 	(1, now(), null, '2281', 'CONTACTSUNDSVALL', 'ROLE', 1)
		ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		namespace = VALUES(namespace),
		type = VALUES(type),
		validated = VALUES(validated);

INSERT INTO namespace_config(id, municipality_id, namespace, short_code, created, modified, display_name, notification_ttl_in_days, access_control)
VALUES 	(2, '2281',	'CONTACTSUNDSVALL',	'KS', now(), null, 'Kontakt Sundsvall', 40,	0)
		ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		municipality_id = VALUES(municipality_id),
		namespace = VALUES(namespace),
		short_code = VALUES(short_code),
		created = VALUES(created),
		modified = VALUES(modified),
		display_name = VALUES(display_name),
		notification_ttl_in_days = VALUES(notification_ttl_in_days), 
		access_control = VALUES(access_control);

-- CONTACT_REASON
INSERT INTO contact_reason(id, reason, created, modified, municipality_id, namespace)
VALUES
	(1, 'E-tjänst hittas inte', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(2, 'Övrigt', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(3, 'Valde personlig kontakt', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(4, 'Synpunkt', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(5, 'Problem med digitala verktyg', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(6, 'Klagomål', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(7, 'Information svår att förstå', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(8, 'Information felaktig', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(9, 'Information saknas', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL'),
	(10, 'Information hittas inte', '2024-05-27 15:15:00', '2024-05-27 15:15:00', '2281', 'CONTACTSUNDSVALL')
	ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		reason = VALUES(reason),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		namespace = VALUES(namespace);

-- EXTERNAL_ID_TYPE
INSERT INTO external_id_type(id, name, created, modified, municipality_id, namespace)
VALUES
	(1, 'EMPLOYEE', '2023-03-27 11:43:58', NULL, '2281', 'CONTACTSUNDSVALL'),
	(2, 'ENTERPRISE', '2023-03-27 11:43:58', NULL, '2281', 'CONTACTSUNDSVALL'),
	(3, 'PRIVATE', '2023-03-27 11:43:58', NULL, '2281', 'CONTACTSUNDSVALL')
	ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		name = VALUES(name),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		namespace = VALUES(namespace);

-- ROLE
INSERT INTO role(id, name, created, modified, municipality_id, namespace)
VALUES
	(1, 'CONTACT', '2023-03-27 11:43:58', NULL, '2281', 'CONTACTSUNDSVALL'),
	(2, 'PRIMARY', '2023-03-27 11:43:58', NULL, '2281', 'CONTACTSUNDSVALL')
	ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		name = VALUES(name),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		namespace = VALUES(namespace);

-- CATEGORIES
INSERT INTO category(id, created, modified, municipality_id, namespace, display_name, name) VALUES
	(1, '2024-06-14 13:27:57', '2024-11-05 10:51:25', '2281', 'CONTACTSUNDSVALL', 'BoU', 'BOU'),
	(2, '2024-06-17 08:47:22', NULL, '2281', 'CONTACTSUNDSVALL', 'Bolag & övriga', 'COMPANIES_AND_OTHERS'),
	(3, '2024-06-14 13:27:27', NULL, '2281', 'CONTACTSUNDSVALL', 'IAF', 'IAF'),
	(4, '2024-06-17 08:04:23', NULL, '2281', 'CONTACTSUNDSVALL', 'KSK', 'KSK'),
	(5, '2024-06-17 08:48:47', NULL, '2281', 'CONTACTSUNDSVALL', 'Kontakt Sundsvall', 'CONTACT_SUNDSVALL'),
	(6, '2024-06-17 09:05:58', NULL, '2281', 'CONTACTSUNDSVALL', 'Kultur & Fritid', 'CULTURE_AND_LEISURE'),
	(7, '2024-06-17 09:07:24', NULL, '2281', 'CONTACTSUNDSVALL', 'Lantmäteriet', 'SURVEYING'),
	(8, '2024-06-17 09:09:28', NULL, '2281', 'CONTACTSUNDSVALL', 'Miljökontoret', 'ENVIRONMENT_OFFICE'),
	(9, '2024-06-17 08:29:16', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Bygglov', 'SBK_BUILDING_PERMIT'),
	(10, '2024-06-17 08:32:04', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Gata', 'SBK_STREET'),
	(11, '2024-06-17 08:35:06', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK MEX', 'SBK_MEX'),
	(12, '2024-06-17 08:36:33', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Park', 'SBK_PARK'),
	(13, '2024-06-17 08:37:41', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Planavdelningen', 'SBK_PLANNING_DEPARTMENT'),
	(14, '2024-06-17 08:12:02', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Planering', 'SBK_PLANNING'),
	(15, '2024-06-17 08:39:23', NULL, '2281', 'CONTACTSUNDSVALL', 'SBK Övriga', 'SBK_OTHER'),
	(16, '2024-06-17 08:43:38', NULL, '2281', 'CONTACTSUNDSVALL', 'VOF', 'VOF'),
	(17, '2024-10-25 10:46:59', NULL, '2281', 'CONTACTSUNDSVALL', 'testnivå1', 'TEST'),
	(18, '2024-06-17 09:01:12', NULL, '2281', 'CONTACTSUNDSVALL', 'ÖFK', 'OFK')
ON DUPLICATE KEY UPDATE id=VALUES(id), created=VALUES(created), modified=VALUES(modified), municipality_id=VALUES(municipality_id), namespace=VALUES(namespace), display_name=VALUES(display_name), name=VALUES(name);

-- TYPES
INSERT INTO `type`(id, category_id, created, modified, display_name, escalation_email, name) VALUES
	(1, 1, '2024-06-14 15:14:15', NULL, 'Avgiftskontroll barnomsorg', 'Draken.eskalering.test1@sundsvall.se', 'FEE_CONTROL_CHILDCARE'),
	(2, 1, '2024-06-14 15:14:15', NULL, 'Barnomsorgshandläggning, fakturafrågor', 'Draken.eskalering.test1@sundsvall.se', 'CHILDCARE_ADMINISTRATION_BILLING_QUESTIONS'),
	(3, 1, '2024-06-14 15:14:15', NULL, 'Förskola', 'Draken.eskalering.test1@sundsvall.se', 'PRESCHOOL'),
	(4, 1, '2024-06-14 15:14:15', NULL, 'Gymnasium, gymnasieval, inackordering', 'Draken.eskalering.test1@sundsvall.se', 'HIGH_SCHOOL_HIGH_SCHOOL_CHOICE_BOARDING'),
	(5, 1, '2024-06-14 15:14:15', NULL, 'Skola, fritids', 'Draken.eskalering.test1@sundsvall.se', 'SCHOOL_LEISURE'),
	(6, 1, '2024-06-14 15:14:15', NULL, 'Skolskjuts, elevresor', 'Draken.eskalering.test1@sundsvall.se', 'SCHOOL_TRANSPORT_STUDENT_TRAVEL'),
	(7, 1, '2024-06-14 15:14:15', NULL, 'Skolval, skolbyte', 'Draken.eskalering.test1@sundsvall.se', 'SCHOOL_CHOICE_SCHOOL_TRANSFER'),
	(8, 1, '2025-01-14 20:57:49', NULL, 'test2', '', 'TEST2'),
	(9, 1, '2025-11-11 20:26:28', NULL, 'test3', '', 'TEST3'),
	(10, 1, '2024-06-14 15:14:15', NULL, 'Övrigt', 'Draken.eskalering.test1@sundsvall.se', 'OTHER'),
	(11, 2, '2024-06-17 08:47:22', NULL, 'Fackförbund', 'Draken.eskalering.test1@sundsvall.se', 'TRADE_UNION'),
	(12, 2, '2024-06-17 08:47:22', NULL, 'MSVA', 'Draken.eskalering.test1@sundsvall.se', 'MSVA'),
	(13, 2, '2024-06-17 08:47:22', NULL, 'Medelpads Räddningstjänstförbund', 'Draken.eskalering.test1@sundsvall.se', 'MEDELPAD_RESCUE_SERVICE_ASSOCIATION'),
	(14, 2, '2024-06-17 08:47:22', NULL, 'Mitthem', 'Draken.eskalering.test1@sundsvall.se', 'MITTHEM'),
	(15, 2, '2024-06-17 08:47:22', NULL, 'Scenkonst Västernorrland', 'Draken.eskalering.test1@sundsvall.se', 'PERFORMING_ARTS_VASTERNORRLAND'),
	(16, 2, '2024-06-17 08:47:22', NULL, 'Servanet', 'Draken.eskalering.test1@sundsvall.se', 'SERVANET'),
	(17, 2, '2024-06-17 08:47:22', NULL, 'Skifu', 'Draken.eskalering.test1@sundsvall.se', 'SKIFU'),
	(18, 2, '2024-06-17 08:47:22', NULL, 'Sundsvall Timrå Airport', 'Draken.eskalering.test1@sundsvall.se', 'SUNDSVALL_TIMRA_AIRPORT'),
	(19, 2, '2024-06-17 08:47:22', NULL, 'Sundsvalls Elnät', 'Draken.eskalering.test1@sundsvall.se', 'SUNDSVALLS_ELECTRIC_GRID'),
	(20, 2, '2024-06-17 08:47:22', NULL, 'Sundsvalls Energi', 'Draken.eskalering.test1@sundsvall.se', 'SUNDSVALLS_ENERGY'),
	(21, 2, '2024-06-17 08:47:22', NULL, 'Övrigt', 'Draken.eskalering.test1@sundsvall.se', 'OTHER'),
	(22, 3, '2024-06-14 15:10:46', NULL, 'Alkohol och tobak', 'Draken.eskalering.test1@sundsvall.se', 'ALCOHOL_AND_TOBACCO'),
	(23, 3, '2024-06-14 15:10:46', NULL, 'Arbete & försörjning', 'Draken.eskalering.test1@sundsvall.se', 'WORK_AND_LIVELIHOOD'),
	(24, 3, '2024-06-14 15:10:46', NULL, 'BOS - Biståndssociala  (söker BOS bostad)', 'Draken.eskalering.test1@sundsvall.se', 'BOS_SOCIAL_ASSISTANCE(SEEKING_BOS_HOUSING)'),
	(25, 3, '2024-06-14 15:10:46', NULL, 'BOS - Öppenvård (har BOS bostad)', 'Draken.eskalering.test1@sundsvall.se', 'BOS_OUTPATIENT_CARE(HAS_BOS_HOUSING)'),
	(26, 3, '2024-06-14 15:10:46', NULL, 'BUF Geografiska team', 'Draken.eskalering.test1@sundsvall.se', 'BUF_GEOGRAPHICAL_TEAM'),
	(27, 3, '2024-11-18 14:29:08', NULL, 'BUF Nord 1 Ljustadalen/Sundsbruk', '', 'BUF_NORD_1_L_S'),
	(28, 3, '2024-06-14 15:10:46', NULL, 'BUF placeringsenheten', 'Draken.eskalering.test1@sundsvall.se', 'BUF_PLACEMENT_UNIT'),
	(29, 3, '2024-06-14 15:10:46', NULL, 'Dödsbohandläggare', 'Draken.eskalering.test1@sundsvall.se', 'ESTATE_ADMINISTRATOR'),
	(30, 3, '2024-06-14 15:10:46', NULL, 'Familjerätten', 'Draken.eskalering.test1@sundsvall.se', 'FAMILY_LAW'),
	(31, 3, '2024-06-14 15:10:46', NULL, 'Familjerådgivning', 'Draken.eskalering.test1@sundsvall.se', 'FAMILY_COUNSELING'),
	(32, 3, '2024-06-14 15:10:46', NULL, 'Integration', 'Draken.eskalering.test1@sundsvall.se', 'INTEGRATION'),
	(33, 3, '2024-06-14 15:10:46', NULL, 'Mottagning familj och vuxen, socialjour', 'Draken.eskalering.test1@sundsvall.se', 'RECEPTION_FAMILY_AND_ADULT_SOCIAL_EMERGENCY_SERVICE'),
	(34, 3, '2024-06-14 15:10:46', NULL, 'Mottagningsgrupp ekonomiskt bistånd', 'Draken.eskalering.test1@sundsvall.se', 'RECEPTION_GROUP_FINANCIAL_ASSISTANCE'),
	(35, 3, '2024-06-14 15:10:46', NULL, 'Sommarjobbsenheten gymnasiet', 'Draken.eskalering.test1@sundsvall.se', 'SUMMER_JOB_UNIT_HIGH_SCHOOL'),
	(36, 3, '2024-06-14 15:10:46', NULL, 'Vuxenstöd, missbruk & psykisk ohälsa', 'Draken.eskalering.test1@sundsvall.se', 'ADULT_SUPPORT_ADDICTION_AND_MENTAL_ILLNESS'),
	(37, 3, '2024-06-14 15:10:46', NULL, 'Vuxenutbildning', 'Draken.eskalering.test1@sundsvall.se', 'ADULT_EDUCATION'),
	(38, 3, '2024-06-14 15:10:46', NULL, 'Övrigt', 'Draken.eskalering.test1@sundsvall.se', 'OTHER')
ON DUPLICATE KEY UPDATE id=VALUES(id), category_id=VALUES(category_id), created=VALUES(created), modified=VALUES(modified), display_name=VALUES(display_name), escalation_email=VALUES(escalation_email), name=VALUES(name);