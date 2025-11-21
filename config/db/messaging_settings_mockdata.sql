use messaging_settings;

INSERT INTO messaging_settings (
    id,
    organization_number,
    municipality_id,
    department_id,
    department_name,
    namespace,
    rek_enabled,
    sms_enabled,
    callback_email,
    contact_information_email,
    contact_information_email_name,
    contact_information_phone_number,
    contact_information_url,
    sms_sender,
    support_text,
    snail_mail_method,
    created,
    updated
    ) VALUES
  ('11111111-1111-1111-1111-111111111111', '2120000001', '2281', '1', 'Kundtjänst', 'messaging', b'1', b'1',
   'callback@sundsvall.se', 'support@sundsvall.se', 'Sundsvalls Kommun', '+4660123456', 'https://www.sundsvall.se',
   'SUNDVALL', 'Testkonfiguration för Sundsvall', 'EMAIL', NOW(), NOW()),

  ('22222222-2222-2222-2222-222222222222', '2120000002', '2281', '2', 'Medborgarservice', 'messaging', b'1', b'0',
   'callback@timra.se', 'info@timra.se', 'Timrå Kommun', '+4660123457', 'https://www.timra.se',
   'TIMRA', 'SMS avaktiverat', 'EMAIL', NOW(), NOW()),

  ('33333333-3333-3333-3333-333333333333', '2120000003', '2281', '3', 'Kommunservice', 'messaging', b'0', b'1',
   'callback@ange.se', 'kontakt@ange.se', 'Ånge Kommun', '+4660123458', 'https://www.ange.se',
   'ANGE', 'Endast SMS aktivt', 'SC_ADMIN', NOW(), NOW()),

  ('44444444-4444-4444-4444-444444444444', '2120000004', '2281', '4', 'Digital Förvaltning', 'messaging', b'1', b'1',
   'callback@harnosand.se', 'it@harnosand.se', 'Härnösands Kommun', '+4660123459', 'https://www.harnosand.se',
   'HARNOSAND', 'Full funktionalitet', 'EMAIL', NOW(), NOW()),

  ('55555555-5555-5555-5555-555555555555', '2120000005', '2281', '5', 'Kommunikation', 'messaging', b'0', b'0',
   'callback@solleftea.se', 'kontakt@solleftea.se', 'Sollefteå Kommun', '+4660123460', 'https://www.solleftea.se',
   'SOLLEFTEA', 'Alla tjänster avstängda', 'SC_ADMIN', NOW(), NOW())
ON DUPLICATE KEY UPDATE
  rek_enabled = VALUES(rek_enabled),
  sms_enabled = VALUES(sms_enabled),
  callback_email = VALUES(callback_email),
  contact_information_email = VALUES(contact_information_email),
  contact_information_email_name = VALUES(contact_information_email_name),
  contact_information_phone_number = VALUES(contact_information_phone_number),
  contact_information_url = VALUES(contact_information_url),
  sms_sender = VALUES(sms_sender),
  support_text = VALUES(support_text),
  snail_mail_method = VALUES(snail_mail_method),
  updated = NOW();