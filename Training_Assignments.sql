Assignment 1: Role-Based Access Control (RBAC)
Objective: Implement role-based access control (RBAC) to manage database access.
Instructions:
Define Roles:
Assign Privileges:
Implement:
Submission:
Create at least five distinct roles (e.g., SuperAdmin, Admin, Doctor, Nurse, Patient).
Define and assign appropriate privileges to each role. For example:
SuperAdmin should have full access to all tables and schema modifications.
Admin should have full access to all tables except sensitive patient data.
Doctor should have access to patient data, appointments, and prescriptions but not to billing information.
Nurse should have access to patient records and appointments but limited access to prescriptions.
Patient should only have access to their own data and appointments.
Write SQL scripts to create these roles and assign the specified privileges.
Submit the SQL scripts along with a document explaining the role definitions and privileges.
-- ==================================
-- Create SuperAdmin role with all privileges
CREATE ROLE SuperAdmin WITH
  LOGIN
  SUPERUSER
  CREATEDB
  CREATEROLE
  INHERIT
  NOREPLICATION
  PASSWORD 'superadmin_password';

-- Create Admin role with administrative privileges
CREATE ROLE Admin WITH
  LOGIN
  CREATEDB
  CREATEROLE
  INHERIT
  NOREPLICATION
  PASSWORD 'admin_password';

-- Create Doctor role with specific database access
CREATE ROLE Doctor WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  PASSWORD 'doctor_password';

-- Create Nurse role with specific database access
CREATE ROLE Nurse WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  PASSWORD 'nurse_password';

-- Create Patient role with limited access
CREATE ROLE Patient WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  PASSWORD 'patient_password';

  -- =======================
  -- Grant Admin full access to all tables except billing
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA healthcare TO Admin;
REVOKE ALL ON TABLE hospital.billing FROM Admin;  -- Remove access to billing table


-- Grant Doctor access to specific tables
GRANT SELECT, INSERT, UPDATE ON healthcare.patient TO Doctor;
GRANT SELECT, INSERT, UPDATE ON healthcare.appointment TO Doctor;
GRANT SELECT, INSERT, UPDATE ON healthcare.prescription TO Doctor;
-- No access to billing


-- Grant Nurse access to patient records and appointments
GRANT SELECT ON healthcare.patient TO Nurse;
GRANT SELECT, INSERT, UPDATE ON healthcare.appointment TO Nurse;
-- Limited access to prescriptions (e.g., view only)
GRANT SELECT ON healthcare.prescription TO Nurse;
-- No access to billing


-- Enable row-level security on the patients table
ALTER TABLE healthcare.patient ENABLE ROW LEVEL SECURITY;
select * from healthcare.patient;
-- Create a policy for the Patient role to access only their records
CREATE POLICY patient_access_policy ON healthcare.patient
USING (patientid = current_setting('app.current_patient_id')::int);

-- Grant access to the Patient role
GRANT SELECT ON healthcare.patient TO Patient;
GRANT SELECT, INSERT, UPDATE ON healthcare.appointment TO Patient;  -- Access to their own appointments

-- Repeat row-level security for appointments if needed
ALTER TABLE healthcare.appointment ENABLE ROW LEVEL SECURITY;
CREATE POLICY appointment_access_policy ON healthcare.appointment
USING (patientid = current_setting('app.current_patient_id')::int);

-- ======================
-- View
CREATE VIEW male_patients AS
SELECT patientid, firstname, lastname, dateofbirth
FROM healthcare.patient
WHERE gender = 'M';
 
explain analyze
SELECT * FROM mv_male_patients;


 

CREATE MATERIALIZED VIEW MV_male_patients AS
SELECT patientid, firstname, lastname, dateofbirth
FROM healthcare.patient
WHERE gender = 'M';

SELECT * FROM mv_male_patients;

select * FROM healthcare.patient
 