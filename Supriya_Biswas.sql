-- Show all tables in the database
SHOW TABLES;

-- Create the Manager table with columns for manager ID, first name, and last name
CREATE TABLE Manager (
    mid INT PRIMARY KEY,            -- Manager ID, primary key
    fname VARCHAR(50),              -- Manager's first name
    lname VARCHAR(50)               -- Manager's last name
);

-- Insert sample data into the Manager table
INSERT INTO Manager (mid, fname, lname) VALUES
(1, 'Amit', 'Sharma'),
(2, 'Priya', 'Singh'),
(3, 'Rajesh', 'Verma'),
(4, 'Sita', 'Patel'),
(5, 'Vikram', 'Mehta'),
(6, 'Anjali', 'Nair'),
(7, 'Rahul', 'Deshmukh'),
(8, 'Pooja', 'Iyer'),
(9, 'Sanjay', 'Kumar'),
(10, 'Neha', 'Chopra');

-- Create the Employee table with columns for employee ID, first name, last name, and manager ID
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,          -- Employee ID, primary key
    first_name VARCHAR(50),         -- Employee's first name
    last_name VARCHAR(50),          -- Employee's last name
    mid INT,                        -- Manager ID (foreign key)
    FOREIGN KEY (mid) REFERENCES Manager(mid)  -- Foreign key referencing the Manager table
);

-- Insert sample data into the Employee table with assigned manager IDs
INSERT INTO Employee (emp_id, first_name, last_name, mid) VALUES
(101, 'Karan', 'Jain', 1),
(102, 'Deepa', 'Agarwal', 3),
(103, 'Mohit', 'Kapoor', 3),
(104, 'Sneha', 'Gupta', 3),
(105, 'Anand', 'Reddy', 5),
(106, 'Swati', 'Bose', 6),
(107, 'Manoj', 'Joshi', 8),
(108, 'Rekha', 'Mishra', 8),
(109, 'Aakash', 'Bhatia', 7),
(110, 'Leela', 'Saxena', 10),
(111, 'Sunil', 'Shukla', 1),
(112, 'Ravi', 'Malhotra', 2),
(113, 'Aditi', 'Bhalla', 3),
(114, 'Kavita', 'Yadav', 4),
(115, 'Vikas', 'Pillai', 5),
(116, 'Renu', 'Nair', 6),
(117, 'Shankar', 'Pandey', 7),
(118, 'Geeta', 'Menon', 8),
(119, 'Prakash', 'Rao', 9),
(120, 'Maya', 'Das', 10);

-- Insert additional employees with NULL as their manager ID (unassigned)
INSERT INTO Employee (emp_id, first_name, last_name, mid) VALUES
(121, 'Aman', 'Kumar', NULL),
(122, 'Nisha', 'Verma', NULL),
(123, 'Vani', 'Singh', NULL),
(124, 'Raj', 'Patil', NULL),
(125, 'Pritam', 'Sahu', NULL);

-- Select employees and their corresponding managers
SELECT m.mid, 
       m.fname AS manager_fname, 
       m.lname AS manager_lname,
       e.emp_id, 
       e.first_name AS employee_fname, 
       e.last_name AS employee_lname
FROM Manager m
JOIN Employee e ON m.mid = e.mid  -- Join Manager and Employee on mid
ORDER BY m.mid, e.emp_id;         -- Order results by manager ID and employee ID

-- Count the number of employees under each manager
SELECT m.fname AS manager_fname,
       m.lname AS manager_lname,
       COUNT(e.emp_id) AS employee_count  -- Count of employees
FROM Manager m
LEFT JOIN Employee e ON m.mid = e.mid  -- Left join to include managers with no employees
GROUP BY m.mid, m.fname, m.lname;       -- Group by manager details

-- Select all manager details
SELECT mid, 
       fname AS first_name, 
       lname AS last_name
FROM Manager;

-- Select names of employees with no assigned manager
SELECT first_name, 
       last_name 
FROM Employee 
WHERE mid IS NULL;  -- Filter for employees with NULL manager ID

-- Define a function to get the full name of an employee
DELIMITER //
CREATE FUNCTION Get_Full_Name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC  -- Function always returns the same output for the same inputs
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);  -- Concatenate first and last name
END //
DELIMITER ;

-- Use the Get_Full_Name function to retrieve employee full names
SELECT emp_id, 
       Get_Full_Name(first_name, last_name) AS full_name
FROM Employee;  -- Select from Employee table
