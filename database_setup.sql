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
-- These will be handled by SecurityConfig's JdbcUserDetailsManager if they don't exist,
-- but adding them here for manual setup convenience.
-- Using {bcrypt}$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOn2 for 'password' (plain 'student', 'admin', etc in code)
-- Actually, the code uses User.withDefaultPasswordEncoder() which is {bcrypt} for current Spring Security versions.

INSERT IGNORE INTO app_users (name, role, points) VALUES ('student', 'STUDENT', 100);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('admin', 'ADMIN', 500);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('faculty', 'FACULTY', 200);
INSERT IGNORE INTO app_users (name, role, points) VALUES ('counselor', 'COUNSELOR', 300);

-- Seed some sample posts
INSERT IGNORE INTO posts (title, content, category, author, author_id, anonymous, likes, timestamp, time_ago) VALUES 
('How to manage stress?', 'I am feeling very stressed lately with all the assignments. Any tips?', 'General', 'student', 'student', false, 5, 1705140000000, '1 day ago'),
('Mental Health Awareness', 'Let\'s talk about the importance of mental health in academia.', 'Health', 'faculty', 'faculty', false, 10, 1705141000000, '1 day ago');

-- Seed some module content
INSERT IGNORE INTO module_contents (slug, title, description, duration, points, progress, status, button_label, icon) VALUES 
('stress-management', 'Stress Management 101', 'Learn how to handle academic pressure.', '30 mins', 50, 0, 'Not Started', 'Start Module', 'stress_icon'),
('mindfulness', 'Mindfulness Basics', 'Practice being present in the moment.', '15 mins', 25, 0, 'Not Started', 'Continue', 'mind_icon');
