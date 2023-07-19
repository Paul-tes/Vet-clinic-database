CREATE TABLE IF NOT EXISTS public.patients (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE IF NOT EXISTS public.treatments (
    id INT PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.medical_histories (
    id INT PRIMARY KEY,
    admitted_at INT,
    patient_id INT REFERENCES public.patients (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    status VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.invoices (
    id INT PRIMARY KEY,
    total_amount DECIMAL(5, 2) NOT NULL,
    generated_at DATE,
    payed_at DATE,
    medical_history_id INT REFERENCES public.medical_histories (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.invoice_items (
    id INT PRIMARY KEY,
    unit_price DECIMAL(5, 2),
    quantity INT,
    total_price DECIMAL(5, 2),
    invoice_id INT REFERENCES public.invoices (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    treatment_id INT REFERENCES public.treatments (id) MATCH SIMPLE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS treatment_histories (
	history_id int,
	treatment_id int,
	FOREIGN KEY (history_id) REFERENCES medical_histories(id),
	FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX treatment_histories_history_index ON treatment_histories(history_id);
CREATE INDEX treatment_histories_treatment_index ON treatment_histories(treatment_id);
CREATE INDEX invoice_items_invoice_index ON invoice_items(invoice_id);
CREATE INDEX invoice_items_treatment_index ON invoice_items(treatment_id);
CREATE INDEX invoices_medical_history_index ON invoices(medical_history_id);
CREATE INDEX medical_histories_patient_index ON medical_histories(patient_id);