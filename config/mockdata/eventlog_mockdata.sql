USE eventlog;

INSERT INTO event (
  id, created, expires, history_reference, log_key, municipality_id, owner, source_type, type, message
) VALUES
  ('b43540c5-8ea0-4652-a2ab-f2bb7b79de8c', NOW(6) - INTERVAL 5 DAY, NOW(6) + INTERVAL 10 DAY, 'HIST-001', '2ec84e16-0a0f-450d-8b9c-c9f72c78b0df', '2281', 'system-a', 'sensor',  'UPDATE',  'Temperature exceeded threshold.'),
  ('8967c440-2378-4901-86db-cc93fb37b2c6', NOW(6) - INTERVAL 4 DAY, NOW(6) + INTERVAL  5 DAY, 'HIST-002', '73dabaf6-ec1a-4ad0-b731-408d5bd2dbb4',  '2281', 'system-b', 'web',     'UPDATE',   'Daily report successfully generated.'),
  ('fcbd1d13-b611-4e70-8004-a9a9ae7d4ee5', NOW(6) - INTERVAL 3 DAY, NOW(6) + INTERVAL  2 DAY, 'HIST-003', 'af91649d-0ddd-4d03-a81e-859820fba43f',  '2281', 'system-a', 'sensor',  'UPDATE','Humidity level high.')
ON DUPLICATE KEY UPDATE
  expires  = VALUES(expires),
  message  = VALUES(message),
  log_key  = VALUES(log_key),
  municipality_id = VALUES(municipality_id),
  owner    = VALUES(owner),
  type     = VALUES(type);

INSERT INTO event_metadata (event_id, `key`, value) VALUES
  ('b43540c5-8ea0-4652-a2ab-f2bb7b79de8c', 'severity',  'high'),
  ('b43540c5-8ea0-4652-a2ab-f2bb7b79de8c', 'sensor_id', 'temp-17'),
  ('8967c440-2378-4901-86db-cc93fb37b2c6', 'severity',  'low'),
  ('fcbd1d13-b611-4e70-8004-a9a9ae7d4ee5', 'severity',  'medium'),
  ('fcbd1d13-b611-4e70-8004-a9a9ae7d4ee5', 'sensor_id', 'humidity-4')
ON DUPLICATE KEY UPDATE
  value = VALUES(value); 