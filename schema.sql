/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id integer,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals
ADD species text;

/* update */

ALTER TABLE animals ADD COLUMN species text;

CREATE TABLE owners (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	full_name text,
	age int
);

CREATE TABLE species (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name text
);

ALTER TABLE animals DROP species;

ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

/* update */

CREATE TABLE vets (
	id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name text,
	age int,
	date_of_graduation date
);

CREATE TABLE specializations (
	vets_id int NOT NULL,
	species_id int NOT NULL,
	PRIMARY KEY (vets_id,species_id),
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
	CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
	date_of_visit date,
	animals_id int  NOT NULL,
	vets_id int  NOT NULL,
	PRIMARY KEY (vets_id,animals_id),
	CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);

-- pair programming

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_id_asc ON visits(animal_id ASC);
CREATE INDEX vet_id ON visits(vet_id ASC);
CREATE INDEX email_asc ON owners(email ASC);
