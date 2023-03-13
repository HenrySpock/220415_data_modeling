-- -- from the terminal run:
-- -- psql < outer_space.sql

-- DROP DATABASE IF EXISTS ospace;

-- CREATE DATABASE ospace;

-- \c ospace

-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');
 
 -- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS ospace;

CREATE DATABASE ospace;

\c ospace

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age_in_billions_of_years FLOAT NOT NULL,
  type TEXT NOT NULL
);

INSERT INTO galaxies
  (name, age_in_billions_of_years, type)
VALUES
  ('Milky Way', 13.5, 'Spiral');

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  distance_in_light_years FLOAT NOT NULL,
  temperature_in_kelvin FLOAT NOT NULL,
  galaxy_id INTEGER REFERENCES galaxies(id)
);

INSERT INTO stars
  (name, distance_in_light_years, temperature_in_kelvin, galaxy_id)
VALUES
  ('Sun', 8.3, 5778, 1),
  ('Proxima Centauri', 4.2, 3042, 1),
  ('Gliese 876', 15.3, 3350, 1);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  radius_in_kilometers FLOAT NOT NULL,
  mass_in_kilograms FLOAT NOT NULL,
  orbital_period_in_days FLOAT NOT NULL,
  distance_from_star_in_millions_of_km FLOAT NOT NULL,
  star_id INTEGER REFERENCES stars(id)
);

INSERT INTO planets
  (name, radius_in_kilometers, mass_in_kilograms, orbital_period_in_days, distance_from_star_in_millions_of_km, star_id)
VALUES
  ('Earth', 6371, 5.97e24, 365.25, 149.6, 1),
  ('Mars', 3390, 6.39e23, 687, 227.9, 1),
  ('Venus', 6052, 4.87e24, 224.7, 108.2, 1),
  ('Neptune', 24622, 1.02e26, 60190, 4495.1, 2),
  ('Proxima Centauri b', 1.08, 1.31e25, 11.2, 0.05, 2),
  ('Gliese 876 b', 5264, 1.89e25, 61.4, 0.208, 3);

-- Sample queries:
-- Find the names of all stars in the Milky Way galaxy:

SELECT s.name
FROM stars s
INNER JOIN galaxies g ON s.galaxy_id = g.id
WHERE g.name = 'Milky Way';
-- Find the names of all planets with a radius greater than 5000 km and their respective star names:

SELECT p.name, s.name AS star_name
FROM planets p
INNER JOIN stars s ON p.star_id = s.id
WHERE p.radius_in_kilometers > 5000;
-- Find the distance from the Sun in light years and the temperature in Kelvin of all stars in the Milky Way:

SELECT s.name, s.distance_in_light_years, s.temperature_in_kelvin
FROM stars s
INNER JOIN galaxies g ON s.galaxy_id = g.id
WHERE g.name = 'Milky Way';
-- Find the names of all planets orbiting stars with a distance from their star of less than 0.1 million km:

SELECT p.name
FROM planets p
INNER JOIN stars s ON p.star_id = s.id
WHERE p.distance_from_star_in_millions_of_km < 0.1;