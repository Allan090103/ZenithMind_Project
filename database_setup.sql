CREATE DATABASE IF NOT EXISTS zenithmind_db;
USE zenithmind_db;

-- Drop existing tables if they exist to start fresh
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS app_users;
DROP TABLE IF EXISTS post_liked_by_users;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS module_contents;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_module_progress;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS faculty_training_progress;
SET FOREIGN_KEY_CHECKS = 1;

-- Create users table for Spring Security
CREATE TABLE users (
  username VARCHAR(50) NOT NULL PRIMARY KEY,
  password VARCHAR(500) NOT NULL,
  enabled TINYINT(1) NOT NULL
);

-- Create authorities table for Spring Security
CREATE TABLE authorities (
  username VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users(username)
);
CREATE UNIQUE INDEX ix_auth_username ON authorities (username, authority);

-- Create app_users table for user profiles
CREATE TABLE app_users (
  name VARCHAR(255) NOT NULL PRIMARY KEY,
  role VARCHAR(255),
  points INT DEFAULT 0,
  wellness_score INT DEFAULT 50
);

-- Create mood_logs table
CREATE TABLE mood_logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  mood VARCHAR(50) NOT NULL,
  mood_score INT NOT NULL,
  activities VARCHAR(255),
  note TEXT,
  log_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create assessment_results table
CREATE TABLE assessment_results (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  assessment_type VARCHAR(255) NOT NULL,
  score INT NOT NULL,
  severity_level VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create posts table
CREATE TABLE posts (
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
CREATE TABLE comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  post_id BIGINT,
  author VARCHAR(255),
  content TEXT,
  timestamp BIGINT,
  time_ago VARCHAR(255),
  CONSTRAINT fk_comments_posts FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Create post_liked_by_users table (Many-to-Many for likedByUsers Set)
CREATE TABLE post_liked_by_users (
  post_id BIGINT NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (post_id, user_id),
  CONSTRAINT fk_liked_posts FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Create module_contents table
CREATE TABLE module_contents (
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
INSERT IGNORE INTO users (username, password, enabled) VALUES ('student', '{bcrypt}$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOn2', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('student', 'ROLE_STUDENT');

INSERT IGNORE INTO app_users (name, role, points, wellness_score) VALUES ('student', 'STUDENT', 150, 72);
INSERT IGNORE INTO app_users (name, role, points, wellness_score) VALUES ('admin', 'ADMIN', 500, 78);
INSERT IGNORE INTO app_users (name, role, points, wellness_score) VALUES ('faculty', 'FACULTY', 200, 86);
INSERT IGNORE INTO app_users (name, role, points, wellness_score) VALUES ('counselor', 'COUNSELOR', 300, 91);

-- Seed some sample posts matching the UI image
INSERT IGNORE INTO posts (title, content, category, author, author_id, anonymous, likes, replies, timestamp, time_ago) VALUES 
('Dealing with exam anxiety - tips that helped me', 'I wanted to share some techniques that really helped me manage my exam anxiety this semester. Deep breathing before exams, regular study breaks, and talking to friends made a huge difference.', 'anxiety', 'Anonymous', 'anon1', true, 24, 2, 1705540000000, '2 hours ago'),
('How do you balance work, study, and self-care?', 'I\'m struggling to find time for everything. Between part-time work, classes, and trying to maintain my mental health, I feel overwhelmed. Any advice?', 'stress', 'Student_247', 'user2', false, 15, 1, 1705530000000, '5 hours ago'),
('6 months of therapy - worth it!', 'Just wanted to share that after 6 months of counseling through the campus center, I\'m in such a better place. Don\'t hesitate to reach out for professional help!', 'success-stories', 'Anonymous', 'anon3', true, 45, 0, 1705460000000, '1 day ago');

-- Seed some module content
INSERT IGNORE INTO module_contents (slug, title, description, duration, points, progress, status, button_label, icon) VALUES 
('stress-management', 'Stress Management 101', 'Learn how to handle academic pressure.', '30 mins', 50, 0, 'Not Started', 'Start Module', 'stress_icon'),
('mindfulness', 'Mindfulness Basics', 'Practice being present in the moment.', '15 mins', 25, 0, 'Not Started', 'Continue', 'mind_icon');
