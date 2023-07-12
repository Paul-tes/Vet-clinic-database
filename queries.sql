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

-- ______________________________________________

-- TRANSACTION QUIRIES

-- [1]
BEGIN TRANSACTION;

	UPDATE animals SET species = 'unspecified';
	SELECT * FROM animals; -- Verify
	
ROLLBACK; -- Roll back

-- Verify role back
SELECT * FROM animals;


-- [2]
BEGIN TRANSACTION;

	-- Update the animals table to set the species column to digimon for all animals that have a name ending in mon
	UPDATE animals
	SET species = 'digimon'
	WHERE name LIKE '%mon';

	-- Update the animals table to set the species column to pokemon for all animals that don't have species already set
	UPDATE animals
	SET species = 'pokemon'
	WHERE species IS NULL;

	-- Verify changes
	SELECT * FROM animals;

COMMIT;

-- Verify that the changes persist after the commit
SELECT * FROM animals;

-- [3]
BEGIN TRANSACTION;
	-- delete all records
	DELETE FROM animals;
ROLLBACK;

-- verfiy the data is still exist.
SELECT * FROM animals;

-- [4]
BEGIN TRANSACTION;
	-- Delete all animals that was born after Jan, 1st, 2022
	DELETE FROM animals
	WHERE date_of_birth > '2022.01.01';
	SAVEPOINT deleteNewBorn; -- save point above transaction.
	
	-- update wight of animals
	UPDATE animals
	SET weight_kg = weight_kg * -1;
	
	ROLLBACK TO deleteNewBorn;
	-- correction on updates of weight.
	UPDATE animals
	SET weight_kg = weight_kg * -1
	WHERE weight_kg < 0;
COMMIT;

-- verfiy changes
SELECT * FROM animals;

-- _________________________________________

-- SELECTED QUESTIONS

-- [1] How many animas are there?
SELECT COUNT(*) as count FROM animals;

-- [2] How many animals have never tried to escape?
SELECT COUNT(*) as "Never escaped animals" FROM animals
WHERE escape_attempts = 0;

-- [3] What is the average weight of animals?
SELECT AVG(weight_kg) as "Avarage Weight" FROM animals;

-- [4] Who escapes the most, neutered or not neutered animals?
SELECT
	CASE
		WHEN neutered = true THEN 'neutered'
		WHEN neutered = false THEN 'NOT NEUTERED'
	END,
	AVG(escape_attempts) as "Total escape attmpts"
FROM animals
GROUP BY neutered
ORDER BY "Total escape attmpts" DESC
LIMIT 1;

-- [5] What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

-- [6] What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990.01.01' AND '2000.12.31'
GROUP BY species;

-- _____________________________________________________________________


-- JOIN QUIRIES 

-- [1] What animals belong to Melody Pond?
SELECT a.name "Melody Pond's Animals"
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- [2] List all owners and their animals, remember to include those that don't own any animal.
SELECT a.name "Pokemon Type"
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- [3] List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.id; 

-- [4] How many animals are there per species?
SELECT s.name, COUNT(a.id) AS NO
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- [5] List all Digimon owned by Jennifer Orwell.
SELECT a.name AS "Jennifers Digimon's"
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- [6] List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND  a.escape_attempts = 0;

-- [7] Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS No
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY No DESC
LIMIT 1;