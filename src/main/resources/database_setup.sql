-- Drop existing tables if they exist to start fresh
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS app_users;
DROP TABLE IF EXISTS post_liked_by_users;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS module_contents;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

-- Create users table for Spring Security
CREATE TABLE IF NOT EXISTS users (
  username VARCHAR(50) NOT NULL PRIMARY KEY,
  password VARCHAR(500) NOT NULL,
  enabled TINYINT(1) NOT NULL
);

-- Create authorities table for Spring Security
CREATE TABLE IF NOT EXISTS authorities (
  username VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users(username)
);
CREATE UNIQUE INDEX IF NOT EXISTS ix_auth_username ON authorities (username, authority);

-- Create app_users table for user profiles
CREATE TABLE IF NOT EXISTS app_users (
  name VARCHAR(255) NOT NULL PRIMARY KEY,
  role VARCHAR(255),
  points INT DEFAULT 0,
  wellness_score INT DEFAULT 50
);

-- Create posts table
CREATE TABLE IF NOT EXISTS posts (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  content TEXT,
  category VARCHAR(255),
  author VARCHAR(255),
  author_id VARCHAR(255),
  anonymous BOOLEAN,
  likes INT DEFAULT 0,
  replies INT DEFAULT 0,
  flagged BOOLEAN DEFAULT FALSE,
  timestamp BIGINT,
  time_ago VARCHAR(255)
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  post_id BIGINT,
  author VARCHAR(255),
  content TEXT,
  timestamp BIGINT,
  time_ago VARCHAR(255),
  CONSTRAINT fk_comments_posts FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Create post_liked_by_users table (Many-to-Many for likedByUsers Set)
CREATE TABLE IF NOT EXISTS post_liked_by_users (
  post_id BIGINT NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (post_id, user_id),
  CONSTRAINT fk_liked_posts FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Create module_contents table
CREATE TABLE IF NOT EXISTS module_contents (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(255) UNIQUE,
  title VARCHAR(255),
  description TEXT,
  duration VARCHAR(255),
  points INT DEFAULT 0,
  progress INT DEFAULT 0,
  status VARCHAR(255),
  button_label VARCHAR(255),
  icon VARCHAR(255),
  sections BLOB,
  current_section INT DEFAULT 1
);

-- Seed Initial Users (Security)
INSERT IGNORE INTO app_users (name, role, points) VALUES ('student', 'STUDENT', 0);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('admin', 'ADMIN', 0);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('faculty', 'FACULTY', 0);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('counselor', 'COUNSELOR', 0);

-- Seed some sample posts
INSERT IGNORE INTO posts (title, content, category, author, author_id, anonymous, likes, timestamp, time_ago) VALUES 
('How to manage stress?', 'I am feeling very stressed lately with all the assignments. Any tips?', 'General', 'student', 'student', false, 5, 1705140000000, '1 day ago'),
('Mental Health Awareness', 'Let\'s talk about the importance of mental health in academia.', 'Health', 'faculty', 'faculty', false, 10, 1705141000000, '1 day ago');

-- Seed some module content
INSERT IGNORE INTO module_contents (slug, title, description, duration, points, progress, status, button_label, icon) VALUES 
('stress-management', 'Stress Management', 'Learn techniques to manage daily stress and build healthy routines.', '15 min', 50, 0, 'Not Started', 'Start', '🧘'),
('understanding-anxiety', 'Understanding Anxiety', 'Learn about anxiety, its causes, symptoms, and effective coping strategies.', '20 min', 75, 0, 'Not Started', 'Start', '📘'),
('depression-awareness', 'Depression Awareness', 'Recognize signs, risk factors, and when to seek help.', '25 min', 100, 0, 'Not Started', 'Start', '☀️'),
('mindfulness-basics', 'Mindfulness Basics', 'Introduction to mindfulness meditation and practice.', '10 min', 50, 0, 'Not Started', 'Start', '🌿');

-- Create mood_logs table for tracking user mood entries
CREATE TABLE IF NOT EXISTS mood_logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  mood VARCHAR(50) NOT NULL,
  mood_score INT NOT NULL,
  activities VARCHAR(500),
  note TEXT,
  log_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_mood_logs_users FOREIGN KEY (username) REFERENCES users(username)
);

-- Create assessment_results table for tracking self-assessment results
CREATE TABLE IF NOT EXISTS assessment_results (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  assessment_type VARCHAR(50) NOT NULL,
  score INT NOT NULL,
  severity_level VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_assessment_results_users FOREIGN KEY (username) REFERENCES users(username)
);

-- Create appointments table
CREATE TABLE IF NOT EXISTS appointments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  student_username VARCHAR(50) NOT NULL,
  counselor_username VARCHAR(50) NOT NULL,
  appt_date DATE NOT NULL,
  appt_time VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'Pending',
  type VARCHAR(50) DEFAULT 'Video Call',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_appt_student FOREIGN KEY (student_username) REFERENCES users(username),
  CONSTRAINT fk_appt_counselor FOREIGN KEY (counselor_username) REFERENCES users(username)
);

-- Seed Counselor Aisyah
INSERT IGNORE INTO users (username, password, enabled) VALUES ('aisyah@wellness.org', '{noop}password', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('aisyah@wellness.org', 'COUNSELOR');
INSERT IGNORE INTO app_users (name, role, points, wellness_score) VALUES ('Aisyah', 'COUNSELOR', 0, 85);

