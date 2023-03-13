-- Drop the database if it exists
DROP DATABASE IF EXISTS crlistdb;
-- Create the database
CREATE DATABASE crlistdb;
-- Connect to the database
\c crlistdb;

-- Create the regions table
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Insert some sample regions
INSERT INTO regions (name) VALUES
  ('San Francisco'),
  ('Atlanta'),
  ('Seattle'),
  ('New York');

-- Create the users table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  preferred_region_id INTEGER,
  FOREIGN KEY (preferred_region_id) REFERENCES regions (id)
);

-- Insert some sample users
INSERT INTO users (name, preferred_region_id) VALUES
  ('John Doe', 1),
  ('Jane Smith', 2),
  ('Bob Johnson', 3),
  ('Alice Lee', 4);

-- Create the posts table
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  text TEXT,
  user_id INTEGER,
  location VARCHAR(255),
  region_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (region_id) REFERENCES regions (id)
);

-- Insert some sample posts
INSERT INTO posts (title, text, user_id, location, region_id) VALUES
  ('Sofa for sale', 'In good condition', 1, 'San Francisco', 1),
  ('Car for sale', 'Low miles', 2, 'Atlanta', 2),
  ('Apartment for rent', 'Spacious', 3, 'Seattle', 3),
  ('Job opening', 'Full-time', 4, 'New York', 4);

-- Create the categories table
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Insert some sample categories
INSERT INTO categories (name) VALUES
  ('Furniture'),
  ('Cars'),
  ('Housing'),
  ('Jobs');

-- Create the posts_categories table to handle the many-to-many relationship between posts and categories
DROP TABLE IF EXISTS posts_categories;
CREATE TABLE posts_categories (
  post_id INTEGER,
  category_id INTEGER,
  PRIMARY KEY (post_id, category_id),
  FOREIGN KEY (post_id) REFERENCES posts (id),
  FOREIGN KEY (category_id) REFERENCES categories (id)
);

-- Insert some sample posts_categories relationships
INSERT INTO posts_categories (post_id, category_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4);
