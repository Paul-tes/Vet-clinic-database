/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

-- Create [ animal ] table
CREATE TABLE animals (
  id INT,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL(5,2)
);

-- Add column species in animals table
ALTER TABLE animalS
ADD COLUMN species VARCHAR(255);

-- Add owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY, -- [SERIAL] is for autoincreament.
    full_name VARCHAR(255),
    age INT
);

-- add species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- drop id column
ALTER TABLE animals DROP COLUMN id;

-- add auto increment primary id to animals table
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;

-- drop species table
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

