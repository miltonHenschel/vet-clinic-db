CREATE DATABASE clinic;
/* Creates patients table*/
CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    date_of_birth DATE,
    PRIMARY KEY(id)
);

/* Creates treatments table*/
CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(255),
    name VARCHAR(255),
    PRIMARY KEY(id)
);

/* Creates medical_histories table*/
CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    PRIMARY KEY(id),
    CONSTRAINT fk_patient FOREIGN KEY(patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

/* Creates invoices table*/
CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history__id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_medical_history FOREIGN KEY(medical_history__id) REFERENCES medical_histories(id) ON DELETE CASCADE
);

/* Creates invoice_items table*/
CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_treatment FOREIGN KEY(treatment_id) REFERENCES treatments(id) ON DELETE CASCADE,
    CONSTRAINT fk_invoice FOREIGN KEY(invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
);

/* Creates medical_treatment_histories table*/
CREATE TABLE medical_treatment_histories (
    medical_id INT NOT NULL REFERENCES medical_histories(id),
    treatment_id INT NOT NULL REFERENCES treatments(id),
    PRIMARY KEY (medical_id, treatment_id) 
);

/* Creates Indexes */

CREATE INDEX ON medical_histories (patient_id);

CREATE INDEX ON invoice_items (invoice_id);

CREATE INDEX ON invoice_items (treatment_id);

CREATE INDEX ON invoices (medical_history_id);

CREATE INDEX ON medical_treatment_histories (treatment_id);

CREATE INDEX ON medical_treatment_histories (medical_id);
