CREATE DATABASE IF NOT EXISTS school_db;

USE school_db;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL,
    marks DECIMAL(5,2) NOT NULL DEFAULT 0
);

INSERT INTO students (name,email,course,marks)
SELECT 'Aarav Sharma','aarav.sharma@example.com',
       'Computer Science',88.50
WHERE NOT EXISTS (
    SELECT 1 FROM students
    WHERE email='aarav.sharma@example.com'
);

INSERT INTO students (name,email,course,marks)
SELECT 'Priya Nair','priya.nair@example.com',
       'Information Tech',91.00
WHERE NOT EXISTS (
    SELECT 1 FROM students
    WHERE email='priya.nair@example.com'
);

INSERT INTO students (name,email,course,marks)
SELECT 'Rohan Mehta','rohan.mehta@example.com',
       'Electronics',76.20
WHERE NOT EXISTS (
    SELECT 1 FROM students
    WHERE email='rohan.mehta@example.com'
);
