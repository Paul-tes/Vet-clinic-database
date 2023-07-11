/*Queries that provide answers to the questions from all projects.*/

-- [1]
SELECT * FROM animals 
WHERE name LIKE '%mon';

-- [2]
SELECT * FROM animalS
WHERE date_of_birth BETWEEN '2016.01.01' AND '2019.12.31';

-- [3]
SELECT name FROM animals
WHERE neutered = true AND escape_attempts < 3;

-- [4]
SELECT date_of_birth FROM animals
WHERE name IN('Agumon', 'Pikachu');

-- [5]
SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

-- [6]
SELECT * FROM animals
WHERE neutered = true;

-- [7]
SELECT * FROM animals
WHERE name != 'Gabumon';

-- [8]
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;