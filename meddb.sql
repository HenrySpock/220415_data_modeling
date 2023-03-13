-- Drop the database if it exists
DROP DATABASE IF EXISTS meddb;

-- Create the database
CREATE DATABASE meddb;

-- Connect to the database
\c meddb

-- Drop tables if they exist
DROP TABLE IF EXISTS diagnoses;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS diseases;

-- Create tables
CREATE TABLE diseases (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  specialty VARCHAR(255) NOT NULL
);

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  birthdate DATE NOT NULL,
  gender VARCHAR(10) NOT NULL
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  patient_id INTEGER REFERENCES patients(id),
  doctor_id INTEGER REFERENCES doctors(id),
  date DATE NOT NULL
);

CREATE TABLE diagnoses (
  id SERIAL PRIMARY KEY,
  visit_id INTEGER REFERENCES visits(id),
  disease_id INTEGER REFERENCES diseases(id)
);

-- Insert data
INSERT INTO diseases (name) VALUES
  ('Flu'),
  ('Malaria'),
  ('Pneumonia'),
  ('Tuberculosis');

INSERT INTO doctors (name, specialty) VALUES
  ('Dr. Smith', 'Pediatrics'),
  ('Dr. Johnson', 'Cardiology'),
  ('Dr. Lee', 'Oncology'),
  ('Dr. Brown', 'Neurology');

INSERT INTO patients (name, birthdate, gender) VALUES
  ('Alice', '1985-01-01', 'F'),
  ('Bob', '1990-02-02', 'M'),
  ('Charlie', '1980-03-03', 'M'),
  ('Danielle', '1995-04-04', 'F');

INSERT INTO visits (patient_id, doctor_id, date) VALUES
  (1, 2, '2022-01-01'),
  (2, 3, '2022-02-02'),
  (3, 4, '2022-03-03'),
  (4, 1, '2022-04-04');

INSERT INTO diagnoses (visit_id, disease_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4);