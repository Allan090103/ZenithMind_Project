USE zenithmind_db;

ALTER TABLE app_users ADD COLUMN wellness_score INT DEFAULT 50;

-- Optional: Initialize with some values based on user role/mock data if needed
UPDATE app_users SET wellness_score = 72 WHERE name = 'student';
UPDATE app_users SET wellness_score = 86 WHERE name = 'faculty';
UPDATE app_users SET wellness_score = 91 WHERE name = 'counselor';
UPDATE app_users SET wellness_score = 78 WHERE name = 'admin';
