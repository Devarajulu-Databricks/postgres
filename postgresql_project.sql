-- healthcare.patient
CREATE TABLE healthcare.patient (
    PatientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

-- healthcare.doctor
CREATE TABLE healthcare.doctor (
    DoctorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100)
);
--healthcare.appointment
CREATE TABLE healthcare.appointment (
    AppointmentID SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate TIMESTAMP NOT NULL,
    Status VARCHAR(50),
    Notes TEXT,
    CONSTRAINT fk_patient
        FOREIGN KEY(PatientID) 
            REFERENCES healthcare.patient(PatientID),
    CONSTRAINT fk_doctor
        FOREIGN KEY(DoctorID) 
            REFERENCES healthcare.doctor(DoctorID)
);

-- healthcare.medicalRecord
CREATE TABLE healthcare.medicalRecord (
    RecordID SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT,
    RecordDate TIMESTAMP NOT NULL,
    Description TEXT NOT NULL,
    Treatment TEXT NOT NULL,
    CONSTRAINT fk_patient
        FOREIGN KEY(PatientID) 
            REFERENCES healthcare.patient(PatientID),
    CONSTRAINT fk_doctor
        FOREIGN KEY(DoctorID) 
            REFERENCES healthcare.doctor(DoctorID)
);
--healthcare.prescription
CREATE TABLE healthcare.prescription (
    PrescriptionID SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    PrescriptionDate TIMESTAMP NOT NULL,
    Medication VARCHAR(255) NOT NULL,
    Dosage VARCHAR(255) NOT NULL,
    CONSTRAINT fk_patient
        FOREIGN KEY(PatientID) 
            REFERENCES healthcare.patient(PatientID),
    CONSTRAINT fk_doctor
        FOREIGN KEY(DoctorID) 
            REFERENCES healthcare.doctor(DoctorID)
);

--healthcare.billing
CREATE TABLE healthcare.billing (
    BillID SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    AppointmentID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentStatus VARCHAR(50) NOT NULL,
    CONSTRAINT fk_patient
        FOREIGN KEY(PatientID) 
            REFERENCES healthcare.patient(PatientID),
    CONSTRAINT fk_appointment
        FOREIGN KEY(AppointmentID) 
            REFERENCES healthcare.appointment(AppointmentID)
);


CREATE TABLE healthcare.user (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) CHECK (Role IN ('Admin', 'Doctor', 'Patient')) NOT NULL
);

ALTER TABLE healthcare.user
ADD COLUMN PatientID INT,
ADD COLUMN DoctorID INT,
ADD CONSTRAINT fk_patient
    FOREIGN KEY(PatientID)
    REFERENCES healthcare.patient(PatientID),
ADD CONSTRAINT fk_doctor
    FOREIGN KEY(DoctorID)
    REFERENCES healthcare.doctor(DoctorID);

CREATE TABLE healthcare.insurance (
    InsuranceID SERIAL PRIMARY KEY,
    ProviderName VARCHAR(100) NOT NULL,
    PlanType VARCHAR(50) NOT NULL,
    PatientID INT NOT NULL,
    CONSTRAINT fk_patient
        FOREIGN KEY(PatientID) 
            REFERENCES healthcare.patient(PatientID)
);

-- ==============================
INSERT INTO healthcare.patient (FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address)
VALUES 
    ('John', 'Doe', '1980-05-15', 'Male', '1234567890', 'john.doe@example.com', '123 Elm Street'),
    ('Jane', 'Smith', '1990-10-22', 'Female', '0987654321', 'jane.smith@example.com', '456 Oak Avenue'),
    ('Alice', 'Johnson', '1975-08-30', 'Female', '5555555555', 'alice.johnson@example.com', '789 Pine Road'),
    ('Bob', 'Brown', '1985-03-18', 'Male', '6666666666', 'bob.brown@example.com', '101 Maple Lane'),
    ('Eve', 'Davis', '2000-12-01', 'Female', '7777777777', 'eve.davis@example.com', '202 Birch Boulevard'),
    ('Michael', 'Wilson', '1992-11-10', 'Male', '8888888888', 'michael.wilson@example.com', '303 Cedar Street'),
    ('Olivia', 'Martinez', '1988-02-25', 'Female', '9999999999', 'olivia.martinez@example.com', '404 Walnut Drive'),
    ('James', 'Anderson', '1976-06-14', 'Male', '1010101010', 'james.anderson@example.com', '505 Cherry Circle'),
    ('Sophia', 'Taylor', '1995-09-05', 'Female', '2020202020', 'sophia.taylor@example.com', '606 Maple Drive'),
    ('Daniel', 'Thomas', '1982-07-22', 'Male', '3030303030', 'daniel.thomas@example.com', '707 Pine Avenue'),
    ('Isabella', 'Harris', '2001-04-11', 'Female', '4040404040', 'isabella.harris@example.com', '808 Oak Street'),
    ('William', 'Garcia', '1978-12-30', 'Male', '5050505050', 'william.garcia@example.com', '909 Elm Lane'),
    ('Mia', 'Robinson', '1994-03-09', 'Female', '6060606060', 'mia.robinson@example.com', '1010 Birch Avenue'),
    ('Alexander', 'Clark', '1987-10-18', 'Male', '7070707070', 'alexander.clark@example.com', '1212 Cedar Lane'),
    ('Charlotte', 'Lewis', '1993-01-21', 'Female', '8080808080', 'charlotte.lewis@example.com', '1313 Walnut Avenue'),
    ('Benjamin', 'Walker', '1983-05-12', 'Male', '9090909090', 'benjamin.walker@example.com', '1414 Cherry Street'),
    ('Amelia', 'Hall', '1996-11-23', 'Female', '0101010101', 'amelia.hall@example.com', '1515 Oak Boulevard'),
    ('Lucas', 'Young', '1979-08-04', 'Male', '1212121212', 'lucas.young@example.com', '1616 Pine Drive'),
    ('Harper', 'King', '2002-06-29', 'Female', '2323232323', 'harper.king@example.com', '1717 Elm Street'),
    ('Ethan', 'Wright', '1984-12-17', 'Male', '3434343434', 'ethan.wright@example.com', '1818 Maple Lane'),
    ('Ella', 'Scott', '1997-04-13', 'Female', '4545454545', 'ella.scott@example.com', '1919 Birch Boulevard'),
    ('Aiden', 'Adams', '1991-07-19', 'Male', '5656565656', 'aiden.adams@example.com', '2020 Cedar Circle');

INSERT INTO healthcare.doctor (FirstName, LastName, Specialty, ContactNumber, Email)
VALUES 
    ('John', 'Smith', 'Cardiology', '1234567890', 'john.smith@healthcare.com'),
    ('Emily', 'Johnson', 'Dermatology', '0987654321', 'emily.johnson@healthcare.com'),
    ('Robert', 'Williams', 'Neurology', '5555555555', 'robert.williams@healthcare.com'),
    ('Linda', 'Brown', 'Pediatrics', '6666666666', 'linda.brown@healthcare.com'),
    ('Michael', 'Jones', 'Orthopedics', '7777777777', 'michael.jones@healthcare.com'),
    ('Sophia', 'Garcia', 'Ophthalmology', '8888888888', 'sophia.garcia@healthcare.com'),
    ('James', 'Martinez', 'Gastroenterology', '9999999999', 'james.martinez@healthcare.com'),
    ('Olivia', 'Rodriguez', 'Internal Medicine', '1010101010', 'olivia.rodriguez@healthcare.com'),
    ('William', 'Wilson', 'Endocrinology', '2020202020', 'william.wilson@healthcare.com'),
    ('Ava', 'Taylor', 'Family Medicine', '3030303030', 'ava.taylor@healthcare.com'),
    ('Ethan', 'Anderson', 'Pulmonology', '4040404040', 'ethan.anderson@healthcare.com'),
    ('Isabella', 'Thomas', 'Hematology', '5050505050', 'isabella.thomas@healthcare.com'),
    ('Benjamin', 'Jackson', 'Rheumatology', '6060606060', 'benjamin.jackson@healthcare.com'),
    ('Mia', 'White', 'Oncology', '7070707070', 'mia.white@healthcare.com'),
    ('Alexander', 'Harris', 'Nephrology', '8080808080', 'alexander.harris@healthcare.com'),
    ('Charlotte', 'Martin', 'Infectious Diseases', '9090909090', 'charlotte.martin@healthcare.com'),
    ('Liam', 'Thompson', 'Urology', '0101010101', 'liam.thompson@healthcare.com'),
    ('Amelia', 'Garcia', 'Podiatry', '1212121212', 'amelia.garcia@healthcare.com'),
    ('Daniel', 'Martinez', 'Plastic Surgery', '2323232323', 'daniel.martinez@healthcare.com'),
    ('Harper', 'Walker', 'Emergency Medicine', '3434343434', 'harper.walker@healthcare.com');

INSERT INTO healthcare.appointment (PatientID, DoctorID, AppointmentDate, Status, Notes)
VALUES 
    (1, 1, '2024-08-01 10:00:00', 'Scheduled', 'Initial consultation for heart condition'),
    (2, 2, '2024-08-02 11:00:00', 'Completed', 'Skin checkup'),
    (3, 3, '2024-08-03 09:30:00', 'Cancelled', 'Neurological assessment postponed'),
    (4, 4, '2024-08-04 13:00:00', 'Scheduled', 'Routine pediatric examination'),
    (5, 5, '2024-08-05 14:00:00', 'Completed', 'Follow-up on recent surgery'),
    (6, 6, '2024-08-06 15:00:00', 'No Show', 'Eye exam missed'),
    (7, 7, '2024-08-07 08:30:00', 'Scheduled', 'Digestive system evaluation'),
    (8, 8, '2024-08-08 10:00:00', 'Completed', 'Internal medicine review'),
    (9, 9, '2024-08-09 11:30:00', 'Scheduled', 'Diabetes management consultation'),
    (10, 10, '2024-08-10 12:00:00', 'Completed', 'Family medicine check-up'),
    (11, 11, '2024-08-11 14:30:00', 'Scheduled', 'Lung function test'),
    (12, 12, '2024-08-12 09:00:00', 'Completed', 'Blood disorder follow-up'),
    (13, 13, '2024-08-13 15:00:00', 'Cancelled', 'Joint pain assessment rescheduled'),
    (14, 14, '2024-08-14 16:00:00', 'Scheduled', 'Cancer screening'),
    (15, 15, '2024-08-15 10:30:00', 'No Show', 'Kidney function test missed'),
    (16, 1, '2024-08-16 11:00:00', 'Scheduled', 'Cardiac stress test'),
    (17, 2, '2024-08-17 12:00:00', 'Completed', 'Routine dermatology check'),
    (18, 3, '2024-08-18 13:30:00', 'Scheduled', 'Neurological follow-up'),
    (19, 4, '2024-08-19 14:00:00', 'Completed', 'Pediatric vaccination'),
    (20, 5, '2024-08-20 09:00:00', 'Scheduled', 'Orthopedic evaluation');

INSERT INTO healthcare.medicalRecord (PatientID, DoctorID, RecordDate, Description, Treatment)
VALUES 
    (1, 1, '2024-07-01 10:00:00', 'Initial consultation for chest pain', 'Prescribed cardiac stress test'),
    (2, 2, '2024-07-02 11:00:00', 'Skin examination for rash', 'Recommended topical ointment'),
    (3, 3, '2024-07-03 09:30:00', 'Neurological assessment for headaches', 'Scheduled MRI and follow-up'),
    (4, 4, '2024-07-04 13:00:00', 'Routine checkup for developmental milestones', 'Administered vaccinations'),
    (5, 5, '2024-07-05 14:00:00', 'Post-surgery follow-up for knee replacement', 'Physical therapy plan'),
    (6, NULL, '2024-07-06 15:00:00', 'Routine eye exam', 'Updated glasses prescription'),
    (7, 7, '2024-07-07 08:30:00', 'Evaluation of abdominal pain', 'Prescribed digestive medication'),
    (8, 8, '2024-07-08 10:00:00', 'General health check-up', 'Reviewed chronic condition management'),
    (9, 9, '2024-07-09 11:30:00', 'Diabetes management review', 'Adjusted insulin dosage'),
    (10, NULL, '2024-07-10 12:00:00', 'Family medicine annual checkup', 'No significant findings'),
    (11, 11, '2024-07-11 14:30:00', 'Evaluation of respiratory symptoms', 'Prescribed inhaler'),
    (12, 12, '2024-07-12 09:00:00', 'Follow-up for blood disorder', 'Adjusted medication'),
    (13, 13, '2024-07-13 15:00:00', 'Assessment for joint pain', 'Recommended joint injections'),
    (14, 14, '2024-07-14 16:00:00', 'Cancer screening consultation', 'Scheduled biopsy'),
    (15, NULL, '2024-07-15 10:30:00', 'Routine kidney function check', 'Reviewed lab results'),
    (16, 1, '2024-07-16 11:00:00', 'Follow-up on cardiac stress test', 'Reviewed test results and adjusted treatment plan'),
    (17, 2, '2024-07-17 12:00:00', 'Follow-up on skin rash', 'Recommended new treatment plan'),
    (18, 3, '2024-07-18 13:30:00', 'Neurological follow-up', 'Reviewed MRI results and discussed options'),
    (19, 4, '2024-07-19 14:00:00', 'Pediatric growth check', 'Reviewed growth metrics and advised on nutrition'),
    (20, 5, '2024-07-20 09:00:00', 'Orthopedic evaluation of knee', 'Reviewed post-surgery progress and adjusted therapy');

INSERT INTO healthcare.prescription (PatientID, DoctorID, PrescriptionDate, Medication, Dosage)
VALUES 
    (1, 1, '2024-07-01 10:00:00', 'Atenolol', '50 mg daily'),
    (2, 2, '2024-07-02 11:00:00', 'Hydrocortisone Cream', 'Apply twice daily'),
    (3, 3, '2024-07-03 09:30:00', 'Sumatriptan', '100 mg as needed'),
    (4, 4, '2024-07-04 13:00:00', 'Diphtheria-Tetanus-Pertussis Vaccine', 'Single dose'),
    (5, 5, '2024-07-05 14:00:00', 'Ibuprofen', '400 mg every 6 hours as needed'),
    (6, 6, '2024-07-06 15:00:00', 'Latanoprost Eye Drops', 'One drop in each eye daily'),
    (7, 7, '2024-07-07 08:30:00', 'Omeprazole', '20 mg daily'),
    (8, 8, '2024-07-08 10:00:00', 'Metformin', '500 mg twice daily'),
    (9, 9, '2024-07-09 11:30:00', 'Levothyroxine', '100 mcg daily'),
    (10, 10, '2024-07-10 12:00:00', 'Furosemide', '40 mg daily'),
    (11, 11, '2024-07-11 14:30:00', 'Albuterol Inhaler', 'Two puffs every 4-6 hours as needed'),
    (12, 12, '2024-07-12 09:00:00', 'Ranitidine', '150 mg twice daily'),
    (13, 13, '2024-07-13 15:00:00', 'Methotrexate', '7.5 mg once weekly'),
    (14, 14, '2024-07-14 16:00:00', 'Tamoxifen', '20 mg daily'),
    (15, 15, '2024-07-15 10:30:00', 'Lisinopril', '10 mg daily'),
    (16, 1, '2024-07-16 11:00:00', 'Clopidogrel', '75 mg daily'),
    (17, 2, '2024-07-17 12:00:00', 'Triamcinolone Acetonide', 'Apply once daily'),
    (18, 3, '2024-07-18 13:30:00', 'Topiramate', '50 mg daily'),
    (19, 4, '2024-07-19 14:00:00', 'Polio Vaccine', 'Single dose'),
    (20, 5, '2024-07-20 09:00:00', 'Celecoxib', '200 mg daily');

INSERT INTO healthcare.billing (PatientID, AppointmentID, Amount, PaymentStatus)
VALUES 
    (1, 1, 150.00, 'Paid'),
    (2, 2, 75.00, 'Pending'),
    (3, 3, 200.00, 'Paid'),
    (4, 4, 120.00, 'Paid'),
    (5, 5, 300.00, 'Pending'),
    (6, 6, 90.00, 'Paid'),
    (7, 7, 130.00, 'Overdue'),
    (8, 8, 110.00, 'Paid'),
    (9, 9, 160.00, 'Pending'),
    (10, 10, 180.00, 'Paid'),
    (11, 11, 85.00, 'Paid'),
    (12, 12, 140.00, 'Pending'),
    (13, 13, 220.00, 'Paid'),
    (14, 14, 160.00, 'Overdue'),
    (15, 15, 200.00, 'Paid'),
    (16, 16, 170.00, 'Pending'),
    (17, 17, 95.00, 'Paid'),
    (18, 18, 130.00, 'Paid'),
    (19, 19, 140.00, 'Pending'),
    (20, 20, 190.00, 'Paid');
INSERT INTO healthcare.user (Username, PasswordHash, Role)
VALUES 
    ('admin_user', 'hashed_password_1', 'Admin'),
    ('dr_smith', 'hashed_password_2', 'Doctor'),
    ('jane_doe', 'hashed_password_3', 'Patient'),
    ('dr_johnson', 'hashed_password_4', 'Doctor'),
    ('alice_w', 'hashed_password_5', 'Patient'),
    ('bob_ross', 'hashed_password_6', 'Patient'),
    ('dr_brown', 'hashed_password_7', 'Doctor'),
    ('emily_clark', 'hashed_password_8', 'Patient'),
    ('charlie_m', 'hashed_password_9', 'Patient'),
    ('dr_white', 'hashed_password_10', 'Doctor'),
    ('admin_two', 'hashed_password_11', 'Admin'),
    ('susan_jones', 'hashed_password_12', 'Patient'),
    ('dr_lee', 'hashed_password_13', 'Doctor'),
    ('nina_adams', 'hashed_password_14', 'Patient'),
    ('dr_green', 'hashed_password_15', 'Doctor'),
    ('oliver_t', 'hashed_password_16', 'Patient'),
    ('admin_three', 'hashed_password_17', 'Admin'),
    ('laura_m', 'hashed_password_18', 'Patient'),
    ('dr_kim', 'hashed_password_19', 'Doctor'),
    ('jason_k', 'hashed_password_20', 'Patient'),
    ('dr_davis', 'hashed_password_21', 'Doctor');
INSERT INTO healthcare.insurance (ProviderName, PlanType, PatientID)
VALUES 
    ('HealthFirst', 'Gold', 1),
    ('CarePlus', 'Silver', 2),
    ('WellnessNet', 'Platinum', 3),
    ('MedGuard', 'Gold', 4),
    ('FamilyCare', 'Bronze', 5),
    ('PrimeHealth', 'Silver', 6),
    ('SecureLife', 'Gold', 7),
    ('TotalHealth', 'Platinum', 8),
    ('OptiCare', 'Gold', 9),
    ('HealthyLiving', 'Bronze', 10),
    ('EliteCare', 'Silver', 11),
    ('WellCare', 'Gold', 12),
    ('LifePlus', 'Platinum', 13),
    ('NextGenHealth', 'Gold', 14),
    ('CareNet', 'Silver', 15),
    ('GlobalHealth', 'Bronze', 16),
    ('SafeHealth', 'Gold', 17),
    ('CompleteCare', 'Platinum', 18),
    ('TotalWellness', 'Gold', 19),
    ('EssentialCare', 'Silver', 20);
------ ALTER ------------------------------------------------------------------------------
alter table healthcare.patient add column middlename varchar(50);
alter table healthcare.patient drop column middle_name ;

alter table healthcare.doctor alter column contactnumber type varchar(50);

alter table healthcare.doctor rename column contactnumber to contact_number;

alter table healthcare.appointment alter column status set default 'Scheduled' ;

-- ------------------------------------------------------------------------------------

alter table healthcare.medicalRecord
add  constraint fk_doctor1 
foreign key (doctorid) references healthcare.doctor(doctorid);

alter table healthcare.medicalRecord
drop constraint fk_doctor1 ;

DROP TABLE IF EXISTS healthcare.insurance1;

alter table healthcare.patient add column middle_name varchar(50);
--



select * from healthcare.patient ;
select * from healthcare.doctor;
select * from healthcare.appointment where status = 'Scheduled';
select * from healthcare.medicalRecord;
select * from healthcare.prescription ;
select * from healthcare.billing;
create table healthcare.user select * from healthcare.user;
create table healthcare.insurance1 as select * from healthcare.insurance;


--
select distinct role from healthcare.user;

--
select * from pg_tables where schemaname = 'healthcare';  --pg_tables: Contains information about all tables in the database.
select * from pg_indexes  where schemaname = 'healthcare' and tablename = 'patient'; --Contains information about all indexes in the database.
select * from pg_class ;     --: Contains information about tables, indexes, sequences, and other relations.
select * from pg_attribute;  --: Contains information about table columns.
select * from pg_constraint; --: Contains information about table constraints.
select * from pg_type;       --: Contains information about data types.
select * from pg_namespace;  --: Contains information about schemas.
select * from pg_roles;      --: Contains information about database roles (users and groups).
select * from pg_statistic ;

-- INDEXES =================
select * from pg_indexes  where schemaname = 'healthcare' and tablename IN ('patient','medicalrecord') order by tablename; 
create index idx_patients_email on healthcare.patient (email);
create unique index idx_patients_email_uqx on healthcare.patient (email); -- it will alow NULL Values

create index idx_patients_name on healthcare.patient (firstname,middlename,lastname);
--Partial Index
create index idx_active_appointments1 on healthcare.appointment (appointmentdate) where status = 'Scheduled';;
--GIN (Generalized Inverted INdex) -- array full text search -- arry type of data
create index idx_medicalrecords_description_gin on healthcare.medicalRecord
using GIN (to_tsvector('english',description))

--GIST (Generalized Search Tree)------------------------------
--userful for complex data types
--like geometric data 
--arrays data



-- BRIN (Block Range Index) ---------------------
--Effecient for very large tables 
--where data is naturallu clustered
drop index healthcare."idx_active_appointment_date_brin1";
select * from pg_indexes  where schemaname = 'healthcare' and tablename ='appointment';
create index idx_active_appointment_date_brin on healthcare.appointment using BRIN (appointmentdate);

-----Reindexing a table --------------------------------------------
reindex table healthcare.patient; --rebuilding all the indexes on a table-- drop and create

-- to updateh statistics for a query
 Analyze healthcare.appointment


-- Optimization SQL's      -----------------
explain  
select * from healthcare.appointment where status = 'Scheduled' and doctorid =1
order by appointmentdate desc;


-- 25-JUL-2024 --------------------------
create user app_user password 'readonly';
GRANT ALL PRIVILEGES ON SCHEMA healthcare TO app_user;
select * from pg_user ;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin;
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM app_user;


--------------------------------------------------------
create role admin with login password 'admin';
create role doctor with login password 'doctor';
create role nurse with login password 'nurse';
create role patient with login password 'patient';

--------------------------------------------------------------
-- Admin priviliges
grant all privileges on all tables in schema healthcare to admin;
grant all privileges on all sequences in schema healthcare to admin;

------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON healthcare.user TO admin;



GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_user;
GRANT SELECT ON ALL TABLES IN SCHEMA healthcare TO app_user;


-- ===============================================================

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    patient_name VARCHAR(100),
    date_of_birth DATE,
    address TEXT,
    phone_number VARCHAR(20)
);

-- Create or replace the function to retrieve patient data by patient ID
DROP FUNCTION IF EXISTS get_patient_data(INT);

-- Drop the existing function if it exists
DROP FUNCTION IF EXISTS get_patient_data1(INT);

-- Create or replace the function to retrieve patient data by patient ID
CREATE OR REPLACE FUNCTION get_patient_data1(p_patient_id INT)
RETURNS TABLE (
    patient_id INTEGER,
    patient_name VARCHAR(100),
    date_of_birth DATE,
    patient_address TEXT,
    phone_number VARCHAR(20)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        patientid AS patient_id,
        firstname AS patient_name,
        dateofbirth AS date_of_birth,
        address as patient_address,
        contactnumber AS phone_number
    FROM
        healthcare.patient
    WHERE
        patientid = p_patient_id;

exception when no_data_found Then
	
END;
$$ LANGUAGE plpgsql;




SELECT * FROM get_patient_data1(1204);

-- lab ===============================
-- Create Admin role
CREATE ROLE admin;

-- Create Doctor role
CREATE ROLE doctor;

-- Create Receptionist role
CREATE ROLE receptionist;



-- Grant full access to all tables for Admin role
GRANT ALL ON ALL TABLES IN SCHEMA healthcare TO admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA healthcare TO admin;

-- Grant read and update permissions for Doctor role
GRANT SELECT, INSERT, UPDATE ON healthcare.patient TO doctor;
GRANT SELECT, INSERT, UPDATE ON healthcare.appointment TO doctor;
GRANT SELECT, INSERT, UPDATE ON healthcare.prescription TO doctor;

-- Grant read permissions for Doctor role (if needed for viewing)
-- GRANT SELECT ON healthcare.billing TO doctor;

-- Grant read and update permissions for Receptionist role
GRANT SELECT ON healthcare.patient TO receptionist;
GRANT SELECT, UPDATE ON healthcare.appointment TO receptionist;

-- Deny access to Billing table for Receptionist role
-- REVOKE ALL PRIVILEGES ON healthcare.billing FROM receptionist;


CREATE EXTENSION IF NOT EXISTS pgcrypto;
-- Add encrypted columns
ALTER TABLE healthcare.patient
    ADD COLUMN encrypted_firstname BYTEA,
    ADD COLUMN encrypted_address BYTEA,
    ADD COLUMN encrypted_phone_number BYTEA;

-- Encrypt existing data
UPDATE healthcare.patient
SET
    encrypted_firstname = pgp_sym_encrypt(firstname, 'encryption_key'),
    encrypted_address = pgp_sym_encrypt(address, 'encryption_key'),
    encrypted_phone_number = pgp_sym_encrypt(contactnumber, 'encryption_key');

-- Optionally, drop original columns if no longer needed
-- ALTER TABLE healthcare.patients
--    DROP COLUMN patient_name,
--    DROP COLUMN address,
--    DROP COLUMN phone_number;

--===
-- Decrypt data from encrypted columns
CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT firstname,address,
    pgp_sym_decrypt(encrypted_firstname, 'encryption_key') AS decrypted_firstname,
    pgp_sym_decrypt(encrypted_address, 'encryption_key') AS decrypted_address,
    pgp_sym_decrypt(encrypted_phone_number, 'encryption_key') AS decrypted_phone_number
FROM healthcare.patient;


select * from healthcare.patient


-- Create a login role
CREATE ROLE app_user LOGIN PASSWORD 'secure_password';

-- Grant necessary permissions to the role
GRANT CONNECT ON DATABASE postgres TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;

-- Grant specific table permissions as needed
GRANT SELECT, INSERT, UPDATE, DELETE ON healthcare.patient TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON healthcare.appointment TO app_user;


------------
-- Create a login role
CREATE ROLE app_user LOGIN PASSWORD 'app_user123';

-- Grant specific table permissions as needed
GRANT SELECT, INSERT, UPDATE, DELETE ON healthcare.patients TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON healthcare.appointments TO app_user;



CREATE TABLE healthcare.audit_log (
    audit_id SERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    change_type CHAR(1) NOT NULL,  -- 'I' for Insert, 'U' for Update, 'D' for Delete
    change_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(100) NOT NULL
);

-- Create function to log changes
CREATE OR REPLACE FUNCTION log_audit_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO healthcare.audit_log (table_name, change_type, user_name)
        VALUES (TG_TABLE_NAME, 'I', current_user);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO healthcare.audit_log (table_name, change_type, user_name)
        VALUES (TG_TABLE_NAME, 'U', current_user);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO healthcare.audit_log (table_name, change_type, user_name)
        VALUES (TG_TABLE_NAME, 'D', current_user);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers on key tables to log changes
CREATE TRIGGER audit_patient
AFTER INSERT OR UPDATE OR DELETE ON healthcare.patient
FOR EACH ROW EXECUTE FUNCTION log_audit_trigger();

CREATE TRIGGER audit_appointment
AFTER INSERT OR UPDATE OR DELETE ON healthcare.appointment
FOR EACH ROW EXECUTE FUNCTION log_audit_trigger();

-- =========
# On Linux systems with systemd
sudo systemctl restart postgresql

# Or using service command
sudo service postgresql restart
psql -U your_username -d your_database
CREATE EXTENSION pg_stat_statements;
explain analyze
select * from healthcare.patient;


SELECT   * FROM    pg_stat_statements
ORDER BY
    total_time DESC
LIMIT 10;


SELECT pid, usename, application_name, client_addr, state, query
FROM pg_stat_activity;

SELECT datname, numbackends, xact_commit, xact_rollback, blks_read, blks_hit
FROM pg_stat_database;
select * FROM pg_stat_segment;

SELECT
 *
FROM
    pg_stat_statements
;

DO $$
BEGIN
    -- Attempt to insert a record into the employees table
    INSERT INTO employees (employee_id, first_name, department_id) VALUES (1, 'John Doe', 'Sales');
EXCEPTION
    WHEN unique_violation THEN
        -- Handle unique constraint violation
        RAISE NOTICE 'Duplicate employee ID detected.';
    WHEN OTHERS THEN
        -- Handle other exceptions
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$$;

CREATE OR REPLACE FUNCTION calculate_age(dob DATE) RETURNS INTEGER AS $$
BEGIN
    RETURN FLOOR(EXTRACT(YEAR FROM AGE(dob)));
END;
$$ LANGUAGE plpgsql;

SELECT calculate_age('1970-01-01');

