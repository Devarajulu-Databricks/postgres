select * from regions;      --4
select * from locations;    --23
select * from countries;    --25
select * from departments;  --27
select * from job_history;  --10
select * from jobs;         --19
select * from employees;    --107

select department_id, min(salary), avg(salary),max(salary), sum(salary),count(*), count(1) from employees
group by department_id order by 1 
;    --107
----------------------------------
select d.department_id, department_name, count(*) 
from employees e 
join departments d on e.department_id = d.department_id
--where department_id =10;
group by d.department_id, department_name
order by 1 ;

-- =====================================================
create table json_example( json_data json);
select unique * from json_example;

select json_data.name, json_data.age, json_data.city from json_example;

insert into json_example (json_data) values 
('{"name":"DEVA",  "age":30,  "city": "bangalore"}');

insert into json_example (json_data) values 
('{"name":"DEVA",  "age":30,  "city": "bangalore"}');

insert into json_example (json_data) values 
('{"name":"RAM",  "age":20,  "city": "Chennai"}');

-- =========================================================================
CREATE TABLE "Healthcare"."DoctorS" (
   doctor_id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   specialty VARCHAR(50) NOT NULL,
   contact_number VARCHAR(15) UNIQUE,
   email VARCHAR(50) UNIQUE
);

CREATE TABLE "Healthcare".patients (
   patient_id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   date_of_birth DATE NOT NULL,
   gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
   contact_number VARCHAR(15) UNIQUE,
   email VARCHAR(50),
   address TEXT,
   registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "Healthcare".appointments (
   appointment_id SERIAL PRIMARY KEY,
   patient_id INT NOT NULL REFERENCES "Healthcare".patients(patient_id) ON DELETE CASCADE,
   doctor_id INT NOT NULL REFERENCES "Healthcare".doctors(doctor_id),
   appointment_date TIMESTAMP NOT NULL,
   status VARCHAR(20) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
);

-- Insert statements for "Healthcare"."DoctorS"
INSERT INTO "Healthcare".doctors (first_name, last_name, specialty, contact_number, email) VALUES
('John', 'Doe', 'Cardiology', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', 'Neurology', '2345678901', 'jane.smith@example.com'),
('Emily', 'Johnson', 'Pediatrics', '3456789012', 'emily.johnson@example.com'),
('Michael', 'Brown', 'Orthopedics', '4567890123', 'michael.brown@example.com'),
('Sarah', 'Davis', 'Dermatology', '5678901234', 'sarah.davis@example.com'),
('David', 'Wilson', 'Oncology', '6789012345', 'david.wilson@example.com'),
('Laura', 'Garcia', 'Gynecology', '7890123456', 'laura.garcia@example.com'),
('Robert', 'Martinez', 'Psychiatry', '8901234567', 'robert.martinez@example.com'),
('Linda', 'Rodriguez', 'Gastroenterology', '9012345678', 'linda.rodriguez@example.com'),
('James', 'Lee', 'Urology', '0123456789', 'james.lee@example.com');

-- Insert statements for "Healthcare".patients
INSERT INTO "Healthcare".patients (first_name, last_name, date_of_birth, gender, contact_number, email, address) VALUES
('Alex', 'Miller', '1980-01-01', 'Male', '1012345678', 'alex.miller@example.com', '123 Main St, Anytown, USA'),
('Sam', 'Taylor', '1990-02-02', 'Female', '2023456789', 'sam.taylor@example.com', '456 Oak St, Anytown, USA'),
('Jamie', 'Anderson', '2000-03-03', 'Other', '3034567890', 'jamie.anderson@example.com', '789 Pine St, Anytown, USA'),
('Morgan', 'Thomas', '1985-04-04', 'Female', '4045678901', 'morgan.thomas@example.com', '101 Maple St, Anytown, USA'),
('Jordan', 'Jackson', '1995-05-05', 'Male', '5056789012', 'jordan.jackson@example.com', '202 Elm St, Anytown, USA'),
('Casey', 'White', '1975-06-06', 'Other', '6067890123', 'casey.white@example.com', '303 Cedar St, Anytown, USA'),
('Taylor', 'Harris', '1965-07-07', 'Female', '7078901234', 'taylor.harris@example.com', '404 Birch St, Anytown, USA'),
('Riley', 'Martin', '1955-08-08', 'Male', '8089012345', 'riley.martin@example.com', '505 Walnut St, Anytown, USA'),
('Avery', 'Clark', '2005-09-09', 'Other', '9090123456', 'avery.clark@example.com', '606 Chestnut St, Anytown, USA'),
('Jordan', 'Lewis', '2010-10-10', 'Female', '0101234567', 'jordan.lewis@example.com', '707 Spruce St, Anytown, USA');

-- Insert statements for "Healthcare".appointments
INSERT INTO "Healthcare".appointments ( appointment_id, patient_id, doctor_id, appointment_date, status) VALUES
--(200,1, 1, '2024-07-20 10:00:00', 'Scheduled'),
(201,1, 2, '2024-07-21 11:00:00', 'Scheduled'),
(202,2, 3, '2024-07-22 12:00:00', 'Cancelled'),
(203,3, 4, '2024-07-23 13:00:00', 'Scheduled'),
(204,4, 5, '2024-07-24 14:00:00', 'Completed'),
(205,5, 6, '2024-07-25 15:00:00', 'Cancelled'),
(7, 7, '2024-07-26 16:00:00', 'Scheduled'),
(8, 8, '2024-07-27 17:00:00', 'Completed'),
(9, 9, '2024-07-28 18:00:00', 'Cancelled'),
(10, 10, '2024-07-29 19:00:00', 'Scheduled');


select * from healthcare.doctors order by specialty asc,last_name asc; 
select * from healthcare.patients group by gender ;where gender = 'Male' ;
select * from healthcare.appointments order by ;

select * --first_name,last_name, appointment_date 
from healthcare.appointments a 
join healthcare.doctors d  on d.doctor_id = a.doctor_id
join healthcare.patients p on p.patient_id = a.patient_id
where d.last_name = 'Smith' and p.first_name ='Jordan'
order by appointment_date;


select first_name,last_name, appointment_date from "Healthcare".doctors d 
join "Healthcare".appointments a on d.doctor_id = a.doctor_id
order by appointment_date;


SELECT *
FROM "Healthcare".appointments a
JOIN "Healthcare".doctors d ON a.doctor_id = d.doctor_id
WHERE d.last_name = 'Smith' and p."first_name" ="Jordan"
ORDER BY a.appointment_date ASC;

ALTER SCHEMA "Healthcare" RENAME TO healthcare;

SELECT "first_name",	"last_name"	,"date_of_birth",	"gender",
EXTRACT(YEAR FROM age(CURRENT_DATE, date_of_birth)) AS age
FROM healthcare.patients
ORDER BY age LIMIT 5;


SELECT *
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'departments';

 