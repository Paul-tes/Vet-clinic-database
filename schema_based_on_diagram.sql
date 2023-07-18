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


CREATE TABLE IF NOT EXISTS public.invoices
(
    id INT PRIMARY KEY,
    total_amount DECIMAL(5, 2) NOT NULL,
    generated_at DATE,
    payed_at DATE,
    medical_history_id INT REFERENCES public.medical_histories (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.invoice_items
(
    id INT PRIMARY KEY,
    unit_price DECIMAL(5, 2),
    quantity INT,
    total_price DECIMAL(5, 2),
    invoice_id INT  REFERENCES public.invoices (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    treatment_id INT REFERENCES public.treatments (id) MATCH SIMPLE ON UPDATE NO ACTION
);