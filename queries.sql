/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = true;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Update queries */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE EXTRACT(year FROM date_of_birth) >= 2022;
SAVEPOINT delete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) AS nbr_animals FROM animals;

SELECT COUNT(*) AS nbr_animals FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS avr_weight_kg FROM animals;

SELECT neutered, SUM(escape_attempts) total_attempts FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg) min_weight_kg, MAX(weight_kg) max_weight_kg FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) avr_escape_attempts FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

/* update queries*/

SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id and o.full_name='Melody Pond';

SELECT * FROM animals a JOIN species s ON a.species_id = s.id AND s.name='Pokemon';

SELECT * FROM owners o LEFT JOIN animals a ON a.owner_id = o.id;

SELECT s.name, COUNT(a.id) nb_animals FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

SELECT * FROM animals a JOIN species s ON s.id = a.species_id AND s.name='Digimon' JOIN owners o ON a.owner_id = o.id AND o.full_name='Jennifer Orwell';

SELECT * FROM animals a JOIN owners o ON a.owner_id = o.id AND o.full_name='Dean Winchester' AND escape_attempts=0;

SELECT o.full_name, COUNT(a.id) nbr_animals FROM animals a JOIN owners o ON a.owner_id = o.id GROUP BY o.full_name ORDER BY nbr_animals DESC LIMIT 1;
