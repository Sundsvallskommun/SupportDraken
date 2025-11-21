use support_management;

INSERT INTO status(id, created, modified, municipality_id, name, namespace)
VALUES	(1, now(), null, '2281', 'NEW', 'CONTACTSUNDSVALL'),
		(2, now(), null, '2281', 'ONGOING', 'CONTACTSUNDSVALL'),
		(3, now(), null, '2281', 'PENDING', 'CONTACTSUNDSVALL'),
		(4, now(), null, '2281', 'SOLVED', 'CONTACTSUNDSVALL'),
		(5, now(), null, '2281', 'SUSPENDED', 'CONTACTSUNDSVALL'),
		(6, now(), null, '2281', 'AWAITING_INTERNAL_RESPONSE', 'CONTACTSUNDSVALL')
		ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		name = VALUES(name),
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

INSERT INTO contact_reason(id, namespace, municipality_id, reason, created, modified)
VALUES	(1, 'CONTACTSUNDSVALL', '2281', 'E-tjänst saknas', now(), null),
		(2, 'CONTACTSUNDSVALL', '2281', 'Felanmälan', now(), null),
		(3, 'CONTACTSUNDSVALL', '2281', 'Information hittas inte', now(), null),
		(4, 'CONTACTSUNDSVALL', '2281', 'Information saknas', now(), null),
		(5, 'CONTACTSUNDSVALL', '2281', 'Information felaktig', now(), null)
		ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		namespace = VALUES(namespace),
		municipality_id = VALUES(municipality_id),
		reason = VALUES(reason),
		created = VALUES(created),
		modified = VALUES(modified);

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

INSERT INTO role(id, created, modified, municipality_id, name, namespace, display_name)
VALUES	(1, now(), null, '2281', 'CONTACT', 'CONTACTSUNDSVALL', 'Kontaktperson'),
		(2, now(), null, '2281', 'PRIMARY', 'CONTACTSUNDSVALL', 'Ärendeägare')
		ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		created = VALUES(created),
		modified = VALUES(modified),
		municipality_id = VALUES(municipality_id),
		name = VALUES(name),
		namespace = VALUES(namespace),
		display_name = VALUES(display_name);