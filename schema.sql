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
