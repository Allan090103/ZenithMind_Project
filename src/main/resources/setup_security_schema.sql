-- Drop existing tables if they exist to start fresh
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;

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

-- Create unique index on authorities
CREATE UNIQUE INDEX ix_auth_username ON authorities (username, authority);
