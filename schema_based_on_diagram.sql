------------------------- creating all the tables ---------------------------
create table patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    PRIMARY KEY (id)
)

create table medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at timestamp,
    patient_id int,
    status VARCHAR(100),
    PRIMARY KEY (id)
)

create table treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(100),
    name VARCHAR(100),
    PRIMARY KEY (id)
)

create table invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    PRIMARY KEY (id)
)

create table invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity int,
    total_price DECIMAL,
    invoice_id int,
    treatment_id int,
    PRIMARY KEY (id)
)

-------------------------------- Joining the tabes ---------------------------

-- patients to medical_histories table as one to many relationship

ALTER TABLE medical_histories
ADD CONSTRAINT patient_id_foreign_key
FOREIGN KEY (patient_id) REFERENCES patients(id);

-- invoices to invoice_items table as one to many relationship

ALTER TABLE invoice_items
ADD CONSTRAINT invoice_id_foreign_key
FOREIGN KEY (invoice_id) REFERENCES invoices(id);

-- invoices to medical_histories table as one to one relationship

ALTER TABLE invoices
ADD CONSTRAINT medical_history_id_foreign_key
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

-- medical_histories to treatments table as many to many relationship

CREATE TABLE medical_history_treatments (
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

-- invoice_items to treatments table as one to many relationship

ALTER TABLE invoice_items
ADD CONSTRAINT treatment_id_foreign_key
FOREIGN KEY (treatment_id) REFERENCES treatments (id);