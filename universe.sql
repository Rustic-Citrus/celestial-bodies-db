-- TO DO
-- (DONE) Create a database named universe
-- (DONE) Create tables named galaxy, star, planet, and moon
-- (DONE) Each table has a primary key
-- (DONE) Each primary key automatically increments
-- (DONE) Each table has a name column
-- (DONE) 2 columns use the INT data type and are not a primary or foreign key
-- (DONE) 1 column uses the NUMERIC data type
-- (DONE) 1 column uses the TEXT data type
-- (DONE) 2 columns use the BOOLEAN data type
-- (DONE) Each "star" has a foreign key that references one of the rows in galaxy
-- (DONE) Each "planet" has a foreign key that references one of the rows in star
-- (DONE) Each "moon" has a foreign key that references one of the rows in planet
-- (DONE) Database has at least 5 tables
-- (DONE) Each table has at least 3 rows
-- (DONE) The galaxy and star tables have at least 6 rows
-- (DONE) The planet table has at least 12 rows
-- (DONE) The moon table has at least 20 rows
-- (DONE) Each table should have at least 3 columns
-- (DONE) The galaxy, star, planet, and moon tables have at least 5 columns
-- (DONE) At least two columns per table do not accept NULL values
-- (DONE) At least one column from each table is UNIQUE
-- (DONE) All columns named name are of type VARCHAR
-- (DONE) Each primary key column follows the naming convention table_name_id
-- (DONE) Each foreign key column has the same name as the column it is referencing

DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;

--- galaxy table
DROP TABLE IF EXISTS galaxy CASCADE;
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL UNIQUE,
    number_of_stars INT, -- billions
    distance_from_earth INT NOT NULL, -- kiloparsecs
    age NUMERIC,
    apparent_magnitude NUMERIC,
    constellation TEXT,
    spiral_structure BOOLEAN,
    agn BOOLEAN -- active galactic nucleus
);

--- star table
DROP TABLE IF EXISTS star CASCADE;
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL UNIQUE,
    galaxy_id INT REFERENCES galaxy (galaxy_id),
    age NUMERIC, -- Billions of years
    discovered_by TEXT,
    temperature INT, -- Kelvin
    distance_from_earth INT NOT NULL, -- Light years
    multi_system BOOLEAN,
    main_sequence BOOLEAN
);

--- planet table
DROP TABLE IF EXISTS planet CASCADE;
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL UNIQUE,
    star_id INT REFERENCES star (star_id),
    diameter INT, -- kilometres, including approximations
    mean_temperature INT, -- Kelvin, including approximations
    gravitational_acceleration NUMERIC, -- m/s^2
    discovered_by TEXT,
    habitable BOOLEAN, -- Including potentially habitable
    dwarf BOOLEAN NOT NULL
);

--- moon table
DROP TABLE IF EXISTS moon;
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL UNIQUE,
    planet_id INT REFERENCES planet (planet_id),
    diameter INT, -- kilometres
    orbital_period NUMERIC, -- days
    discovered_by TEXT,
    semi_major_axis INT, -- kilometres
    tidally_locked BOOLEAN,
    atmospheric_presence BOOLEAN
);

--- nebula table
DROP TABLE IF EXISTS nebula;
CREATE TABLE nebula (
    nebula_id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE,
    galaxy_id INT REFERENCES galaxy (galaxy_id),
    apparent_magnitude NUMERIC,
    distance_from_earth INT, -- lightyears
    radius INT, -- lightyears
    constellation TEXT NOT NULL,
    star_forming_region BOOLEAN,
    ionization_presence BOOLEAN 
);

--- Insert values into galaxy table
INSERT INTO galaxy (name, number_of_stars, distance_from_earth, age, apparent_magnitude, constellation, spiral_structure, agn)
VALUES 
    ('Milky Way', 100, 0, 13.6, -0.5, 'Sagittarius', TRUE, FALSE),
    ('Triangulum', 40, 3000, 13.5, 5.72, 'Triangulum', TRUE, FALSE),
    ('Whirlpool', 30, 23000, 13, 8.4, 'Canes Venatici', TRUE, TRUE),
    ('Sombrero', 80, 29000, 12.7, 8.98, 'Virgo', TRUE, TRUE),
    ('Pinwheel', 100, 21000, 13.3, 7.86, 'Ursa Major', TRUE, FALSE),
    ('Andromeda', 1000, 2537, 10, 3.44, 'Andromeda', TRUE, FALSE),
    ('Black Eye', 100, 17000, 13.2, 9.36, 'Coma Berenices', TRUE, TRUE);

--- Insert values into star table
INSERT INTO star (name, galaxy_id, age, temperature, discovered_by, distance_from_earth, multi_system, main_sequence)
VALUES
    ('Sol', 1, 4.6, 5800, NULL, 0, FALSE, TRUE),
    ('Kepler-442', 1, 2.9, 4402, 'Kepler Space Telescope team', 1206, FALSE, TRUE),
    ('Gliese 667 C', 1, 6.0, 3443, 'European Southern Observatory (ESO) team', 23, TRUE, TRUE),
    ('TRAPPIST-1', 1, 7.6, 2566, 'John Gizis', 41, FALSE, TRUE),
    ('Orkaria', 1, 7.5, 3111, 'MEarth Project', 48, TRUE, TRUE),
    ('Copernicus', 1, 8.6, 3320, 'Barbara McArthur', 41, TRUE, TRUE),
    ('Kepler-22', 1, 7.0, 5596, 'Kepler Space Telescope team', 644, FALSE, TRUE),
    ('WASP-12', 1, 1.7, 6300, 'D. Pollaco, et al', 1347, FALSE, TRUE),
    ('HD 40307', 1, 1.2, 4774, 'European Southern Observatory (ESO) team', 42, FALSE, TRUE);

--- Insert values into planet table
INSERT INTO planet (name, star_id, diameter, mean_temperature, gravitational_acceleration, discovered_by, habitable, dwarf)
VALUES
    ('Earth', 1, 12742, 298, 9.807, NULL, TRUE, FALSE),
    ('Mars', 1, 6779, 210, 3.721, NULL, TRUE, FALSE),
    ('Jupiter', 1, 139822, 165, 24.79, NULL, FALSE, FALSE),
    ('Saturn', 1, 116464, 134, 10.44, NULL, FALSE, FALSE),
    ('Pluto', 1, 2377, 44, 0.62, 'Clyde Tombaugh', FALSE, TRUE),
    ('Eris', 1, 2326, 42, 0.82, 'Michael E. Brown, Chad Trujillo, and David Rabinowitz', FALSE, TRUE),
    ('Uranus', 1, 50724, 76, 8.69, 'William Herschel', FALSE, FALSE),
    ('Neptune', 1, 49244, 72, 11.15, 'Johann Galle', FALSE, FALSE),
    ('Kepler-442b', 1, 12700, 277, NULL, 'Kepler Space Telescope team', TRUE, FALSE),
    ('Gliese 667 Cc', 1, 14000, 283, NULL, 'European Southern Observatory (ESO) team', TRUE, FALSE),
    ('TRAPPIST-1d', 2, 8000, 258, NULL, 'TRAPPIST (Transiting Planets and Planetesimals Small Telescope) team', TRUE, FALSE),
    ('Enaiposha', 4, 25200, 473, NULL, 'MEarth Project', FALSE, FALSE),
    ('Janssen', 5, 12740, 1973, NULL, 'Geoffrey Marcy and R. Paul Butler', FALSE, FALSE),
    ('Kepler-22b', 6, 30000, 295, NULL, 'Kepler Space Telescope team', TRUE, FALSE),
    ('WASP-12b', 7, 19000, 2473, NULL, 'SuperWASP (Wide Angle Search for Planets) team', FALSE, FALSE),
    ('HD 40307g', 3, 20000, NULL, NULL, 'European Southern Observatory (ESO) team', TRUE, FALSE);

--- Insert values into moon table
INSERT INTO moon (name, planet_id, diameter, orbital_period, discovered_by, semi_major_axis, tidally_locked, atmospheric_presence)
VALUES 
    ('Moon', 1, 3475, 27.32, NULL, 384400, TRUE, FALSE),
    ('Phobos', 2, 22.4, 0.319, 'Asaph Hall', 9376, TRUE, FALSE),
    ('Deimos', 2, 12.4, 1.262, 'Asaph Hall', 23460, TRUE, FALSE),
    ('Ganymede', 3, 5268, 7.155, 'Galileo Galilei', 1070400, FALSE, FALSE),
    ('Callisto', 3, 4821, 16.69, 'Galileo Galilei', 1882700, FALSE, FALSE),
    ('Io', 3, 3643, 1.769, 'Galileo Galilei', 421700, FALSE, FALSE),
    ('Europa', 3, 3122, 3.551, 'Galileo Galilei', 671100, FALSE, FALSE),
    ('Titan', 4, 5152, 15.945, 'Christiaan Huygens', 1221870, FALSE, TRUE),
    ('Rhea', 4, 1527, 4.518, 'Giovanni Domenico Cassini', 527040, FALSE, FALSE),
    ('Iapetus', 4, 1469, 79.3215, 'Giovanni Domenico Cassini', 3560820, FALSE, FALSE),
    ('Miranda', 7, 471.6, 1.4135, 'Gerard Kuiper', 129900, FALSE, FALSE),
    ('Titania', 7, 1577.8, 8.706, 'William Herschel', 436300, FALSE, FALSE),
    ('Oberon', 7, 1522.8, 13.463, 'William Herschel', 583500, FALSE, FALSE),
    ('Triton', 8, 2706.8, -5.87685, 'William Lassell', 354759, FALSE, TRUE),
    ('Proteus', 8, 420, 1.12231, 'Voyager 2', 117646, FALSE, FALSE),
    ('Enceladus', 4, 504, 1.37, 'William Herschel', 238020, FALSE, TRUE),
    ('Dione', 4, 1122, 2.74, 'Giovanni Domenico Cassini', 377400, FALSE, FALSE),
    ('Tethys', 4, 1062, 1.888, 'Giovanni Domenico Cassini', 294670, FALSE, FALSE),
    ('Umbriel', 7, 1169, 4.144, 'William Lassell', 266000, FALSE, FALSE),
    ('Ariel', 7, 1158, 2.52, 'William Lassell', 191020, FALSE, FALSE);

-- Insert values into nebula table
INSERT INTO nebula (name, galaxy_id, apparent_magnitude, distance_from_earth, radius, constellation, star_forming_region, ionization_presence)
VALUES 
    ('Orion Nebula', 1, 4.0, 1344, 12, 'Orion', TRUE, TRUE),
    ('Crab Nebula', 1, 8.4, 6500, 5, 'Taurus', FALSE, TRUE),
    ('Eagle Nebula', 1, 6.0, 7000, 70, 'Serpens', TRUE, TRUE),
    ('Ring Nebula', 1, 8.8, 2300, 1, 'Lyra', FALSE, TRUE),
    ('Triangulum Emission Nebula', 2, NULL, NULL, NULL, 'Triangulum', TRUE, TRUE),
    ('Whirlpool Star Nursery', 3, NULL, NULL, NULL, 'Canes Venatici', TRUE, TRUE),
    ('Sombrero Dust Ring', 4, NULL, NULL, NULL, 'Virgo', FALSE, FALSE),
    ('Pinwheel Sparkling Region', 5, NULL, NULL, NULL, 'Ursa Major', TRUE, TRUE);
