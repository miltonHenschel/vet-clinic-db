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

/* update queries */

select a.name last_animal_seen, extract(year from v.date_of_visit) last_seen_date from animals a join visits v on a.id = v.animals_id and vets_id = 1 order by last_seen_date desc limit 1;

SELECT vt.name, COUNT(v.animals_id) nbr_animal_seen FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id WHERE vt.id = 3 GROUP BY vt.name;

select * from vets vt left join specializations s on vt.id = s.vets_id left join species sp on s.species_id = sp.id;

select * from animals a join visits v on a.id = v.animals_id where v.date_of_visit between '2020-04-01' and '2020-08-30' and v.vets_id = 3;

select a.name, count(v.date_of_visit) most_nbr_visits from animals a join visits v on a.id = v.animals_id group by a.name order by most_nbr_visits desc limit 1;

select a.name, min(v.date_of_visit) first_date_visited from animals a join visits v on a.id = v.animals_id where vets_id = 2 group by a.name order by first_date_visited limit 1;

select a.name, vt.name, v.date_of_visit most_recent_date_visited from animals a join visits v on a.id = v.animals_id join vets vt on vt.id = v.vets_id order by most_recent_date_visited desc limit 1;

SELECT COUNT(*) nbr_visit_not_specialized FROM (SELECT vt.name,a.name animal_visited, sp.species_id vet_specialities,a.species_id animal_species,date_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id LEFT JOIN specializations sp ON sp.vets_id=v.vets_id WHERE sp.species_id != a.species_id OR sp.species_id IS NULL) visit_not_specialized;

SELECT s.name,a.species_id,COUNT(a.species_id) most_visited_species FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id LEFT JOIN specializations sp ON sp.vets_id=v.vets_id JOIN species s ON s.id = a.species_id WHERE vt.id = 2 GROUP BY a.species_id, s.name ORDER BY COUNT(a.species_id) DESC LIMIT 1;
