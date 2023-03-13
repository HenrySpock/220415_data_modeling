-- -- from the terminal run:
-- -- psql < air_traffic.sql

-- DROP DATABASE IF EXISTS air_traffic;

-- CREATE DATABASE air_traffic;

-- \c air_traffic

-- CREATE TABLE tickets
-- (
--   id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );

-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');

-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS airtrafficdb;

CREATE DATABASE airtrafficdb;

\c airtrafficdb

CREATE TABLE airlines
(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
country TEXT NOT NULL
);

INSERT INTO airlines
(name, country)
VALUES
('United', 'United States'),
('British Airways', 'United Kingdom'),
('Delta', 'United States'),
('TUI Fly Belgium', 'Belgium'),
('Air China', 'China'),
('American Airlines', 'United States'),
('Avianca Brasil', 'Brazil');

CREATE TABLE airports
(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
city TEXT NOT NULL,
country TEXT NOT NULL
);

INSERT INTO airports
(name, city, country)
VALUES
('Washington Dulles International Airport', 'Washington DC', 'United States'),
('Heathrow Airport', 'London', 'United Kingdom'),
('Los Angeles International Airport', 'Los Angeles', 'United States'),
('Seattle-Tacoma International Airport', 'Seattle', 'United States'),
('Charles de Gaulle Airport', 'Paris', 'France'),
('Dubai International Airport', 'Dubai', 'UAE'),
('LaGuardia Airport', 'New York', 'United States'),
('Eastern Iowa Airport', 'Cedar Rapids', 'United States'),
('Louis Armstrong New Orleans International Airport', 'New Orleans', 'United States'),
('São Paulo–Guarulhos International Airport', 'Sao Paolo', 'Brazil'),
('Santiago International Airport', 'Santiago', 'Chile');

-- Create the flights table
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
id SERIAL PRIMARY KEY,
flight_no VARCHAR(10),
departure_time TIMESTAMP,
arrival_time TIMESTAMP,
departure_airport VARCHAR(10),
arrival_airport VARCHAR(10),
airline VARCHAR(50)
);

-- Insert some sample flights
INSERT INTO flights (flight_no, departure_time, arrival_time, departure_airport, arrival_airport, airline) VALUES
('UA123', '2022-01-01 12:00:00', '2022-01-01 14:30:00', 'SFO', 'JFK', 'United Airlines'),
('AA456', '2022-01-02 08:30:00', '2022-01-02 10:45:00', 'JFK', 'LAX', 'American Airlines'),
('DL789', '2022-01-03 17:00:00', '2022-01-03 19:15:00', 'LAX', 'MIA', 'Delta Airlines'),
('UA234', '2022-01-04 10:00:00', '2022-01-04 12:45:00', 'ORD', 'DEN', 'United Airlines'),
('AA567', '2022-01-05 19:00:00', '2022-01-05 21:30:00', 'DEN', 'MIA', 'American Airlines'),
('DL901', '2022-01-06 06:30:00', '2022-01-06 09:15:00', 'MIA', 'SFO', 'Delta Airlines');

-- Create the passengers table
DROP TABLE IF EXISTS passengers;
CREATE TABLE passengers (
id SERIAL PRIMARY KEY,
name VARCHAR(100),
flight_id INTEGER,
FOREIGN KEY (flight_id) REFERENCES flights (id)
);

-- Insert some sample passengers
INSERT INTO passengers (name, flight_id) VALUES
('Alice', 1),
('Bob', 1),
('Charlie', 2),
('Dave', 3),
('Eve', 4),
('Frank', 4),
('Grace', 5),
('Heidi', 5),
('Ivan', 6),
('Judy', 6);

-- Create the baggage table
DROP TABLE IF EXISTS baggage;
CREATE TABLE baggage (
id SERIAL PRIMARY KEY,
passenger_id INTEGER,
weight FLOAT,
FOREIGN KEY (passenger_id) REFERENCES passengers (id)
);

-- Insert some sample baggage
INSERT INTO baggage (passenger_id, weight) VALUES
(1, 20.0),
(2, 15.5),
(3, 18.2),
(4, 25.0),
(5, 12.7),
(6, 16.0),
(7, 22.5),
(8, 19.8),
(9, 17.0),
(10, 14.3);

-- Sample queries:
-- Query to get all the airlines:  
SELECT * FROM airlines;

-- Query to get all the airports: 
SELECT * FROM airports;

-- Query to get all the flights: 
SELECT * FROM flights;

-- Query to get all the passengers: 
SELECT * FROM passengers;

-- Query to get all the baggage: 
SELECT * FROM baggage;

-- Join to get all the flights along with the airline details: 
SELECT flights.*, airlines.name AS airline_name, airlines.country AS airline_country FROM flights 
INNER JOIN airlines ON flights.airline = airlines.name;

-- Join to get all the passengers along with their flight and airline details: 
SELECT passengers.*, flights.flight_no, airlines.name AS airline_name, airlines.country AS airline_country FROM passengers 
INNER JOIN flights ON passengers.flight_id = flights.id 
INNER JOIN airlines ON flights.airline = airlines.name;

-- Join to get all the baggage along with the passenger and flight details: 
SELECT baggage.*, passengers.name AS passenger_name, flights.flight_no, airlines.name AS airline_name FROM baggage 
INNER JOIN passengers ON baggage.passenger_id = passengers.id 
INNER JOIN flights ON passengers.flight_id = flights.id 
INNER JOIN airlines ON flights.airline = airlines.name;