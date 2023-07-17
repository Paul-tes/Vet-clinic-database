/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

-- Create [ animal ] table
CREATE TABLE animals (
  id INT,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL(5, 2)
);

-- Add column species in animals table
ALTER TABLE
  animalS
ADD
  COLUMN species VARCHAR(255);

-- Add owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  -- [SERIAL] is for autoincreament.
  full_name VARCHAR(255),
  age INT
);

-- add species table
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- drop id column
ALTER TABLE
  animals DROP COLUMN id;

-- add auto increment primary id to animals table
ALTER TABLE
  animals
ADD
  COLUMN id SERIAL PRIMARY KEY;

-- drop species table
ALTER TABLE
  animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE
  animals
ADD
  COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE
  animals
ADD
  COLUMN owner_id INT REFERENCES owners(id);

-- Add Vets table
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name TEXT,
  age INT,
  date_of_graduation DATE
);

-- Add specializations table for maintain many to many relationship b/n vet and species.
CREATE TABLE specializations (
  vet_id INT,
  species_id INT,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE,
  -- DEETE CASCADE is ON for to insure referential integrity on delelation of row.
  FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE
);

-- Add Visits join table to maintain many to many r/n b/n animals and thire visitors from vet.
CREATE TABLE visits (
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY (animal_id, vet_id, date_of_visit),
  FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE,
  FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE
);

CREATE INDEX visits_animals_id ON visits(animal_id);

CREATE INDEX index_vet_id ON visits(vet_id);

CREATE INDEX owners_email ON owners(email);