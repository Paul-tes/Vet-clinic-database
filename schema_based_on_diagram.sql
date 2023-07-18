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
