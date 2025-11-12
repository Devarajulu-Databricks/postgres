CREATE TABLE regions (
    region_id   INTEGER NOT NULL,
    region_name VARCHAR(25)
);

ALTER TABLE regions ADD CONSTRAINT reg_id_pk1 PRIMARY KEY (region_id);

CREATE UNIQUE INDEX reg_id_pk ON regions (region_id);


CREATE TABLE employees (
    employee_id INTEGER,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary NUMERIC(8,2),
    commission_pct NUMERIC(4,2),
    manager_id INTEGER,
    department_id INTEGER,
    CHECK (salary > 0)
);