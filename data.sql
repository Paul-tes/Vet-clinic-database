/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

  -- second round sample data.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Charmander', '2020-02-08', 0, FALSE, -11),
  ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
  ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
  ('Angemon', '2005-06-12', 1, TRUE, -45),
  ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
  ('Blossom', '1998-10-13', 3, TRUE, 17),
  ('Ditto', '2022-05-14', 4, TRUE, 22);

-- owners sample data
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- species sample data
INSERT INTO species (name)
VALUES 
  ('Pokemon'),
  ('Digimon');

-- Modify your inserted animals so it includes the species_id value
UPDATE animals
SET species_id = 
	CASE 
		WHEN NAME LIKE '%mon'
			THEN (SELECT id FROM species WHERE name = 'Digimon')
			ELSE (SELECT id FROM species WHERE name = 'Pokemon')
		END;
  
  -- Modify your inserted animals to include owner information (owner_id)
UPDATE animals
SET owner_id = 
	CASE 
		WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
		WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
      WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
      WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
      WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;


-- Add sample data to vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

-- Add sample data to specialties
INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON	
  (v.name = 'William Tatcher' AND s.name = 'Pokemon') OR
  (v.name = 'Stephanie Mendez' AND s.name = 'Digimon') OR
  (v.name = 'Stephanie Mendez' AND s.name = 'Pokemon') OR
  (v.name = 'Jack Harkness' AND s.name = 'Digimon');

-- Add sample data to visits table
INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT a.id, v.id, TO_DATE(visit_date, 'YYYY-MM-DD')
FROM animals a, vets v, (
  VALUES
    ('Agumon', 'William Tatcher', '2020-05-24'),
    ('Agumon', 'Stephanie Mendez', '2020-07-22'),
    ('Gabumon', 'Jack Harkness', '2021-02-02'),
    ('Pikachu', 'Maisy Smith', '2020-01-05'),
    ('Pikachu', 'Maisy Smith', '2020-03-08'),
    ('Pikachu', 'Maisy Smith', '2020-05-14'),
    ('Devimon', 'Stephanie Mendez', '2021-05-04'),
    ('Charmander', 'Jack Harkness', '2021-02-24'),
    ('Plantmon', 'Maisy Smith', '2019-12-21'),
    ('Plantmon', 'William Tatcher', '2020-08-10'),
    ('Plantmon', 'Maisy Smith', '2021-04-07'),
    ('Squirtle', 'Stephanie Mendez', '2019-09-29'),
    ('Angemon', 'Jack Harkness', '2020-10-03'),
    ('Angemon', 'Jack Harkness', '2020-11-04'),
    ('Boarmon', 'Maisy Smith', '2019-01-24'),
    ('Boarmon', 'Maisy Smith', '2019-05-15'),
    ('Boarmon', 'Maisy Smith', '2020-02-27'),
    ('Boarmon', 'Maisy Smith', '2020-08-03'),
    ('Blossom', 'Stephanie Mendez', '2020-05-24'),
    ('Blossom', 'William Tatcher', '2021-01-11')
) AS visits(animal_name, vet_name, visit_date)
WHERE a.name = visits.animal_name AND v.name = visits.vet_name;