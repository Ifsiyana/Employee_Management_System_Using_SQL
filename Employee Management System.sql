-- CREATE DATABASE--
create database Employee_Management_System;
USE Employee_Management_System;

-- Table Departmens
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table Positions 
CREATE TABLE positions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    department_id INT REFERENCES departments(id) ON DELETE CASCADE
);

-- Table Employee
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL,
    position_id INT REFERENCES positions(id) ON DELETE SET NULL,
    hire_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive')) DEFAULT 'Active'
);

-- Salaries table
CREATE TABLE salaries (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
    base_salary INT NOT NULL,
    bonus INT DEFAULT 0,
    effective_date DATE NOT NULL
);

-- Table salaries history
CREATE TABLE salary_history (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
    old_salary INT NOT NULL,
    new_salary INT NOT NULL,
    change_reason TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table leave request
CREATE TABLE leave_requests (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
    leave_type VARCHAR(50) CHECK (leave_type IN ('Sick Leave', 'Annual Leave', 'Maternity Leave', 'Unpaid Leave')),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Approved', 'Rejected')) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table User Authentication
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) CHECK (role IN ('Admin', 'Manager', 'Employee')) DEFAULT 'Employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel attendance
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id bigint UNSIGNED NOT NULL,  
    attendance_date DATE NOT NULL DEFAULT (CURRENT_DATE),  
    check_in TIME DEFAULT NULL,
    check_out TIME DEFAULT NULL,
    status ENUM('Present', 'Late', 'Absent', 'On Leave') NOT NULL DEFAULT 'Absent',
    location VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);
--Input data dumy--
INSERT INTO departments (name) VALUES
('HR'),
('Finance'),
('IT'),
('Marketing'),
('Sales'),
('Operations');

INSERT INTO positions (name, department_id) VALUES
('HR Manager', 1),
('HR Assistant', 1),
('Finance Analyst', 2),
('Accountant', 2),
('Software Engineer', 3),
('Data Analyst', 3),
('Marketing Specialist', 4),
('SEO Expert', 4),
('Operations Manager', 5),
('Logistics Coordinator', 5),
('Sales Manager', 6),
('Sales Representative', 6);


INSERT INTO employees (name, email, phone, department_id, position_id, hire_date, status) VALUES
('Alice Johnson', 'alice@example.com', '081234567890', 1, 1, '2022-03-15', 'Active'),
('Bob Smith', 'bob@example.com', '081298765432', 2, 3, '2021-06-20', 'Active'),
('Charlie Brown', 'charlie@example.com', '081211122233', 3, 5, '2023-01-10', 'Active'),
('David Wilson', 'david@example.com', '081355544477', 4, 7, '2020-09-01', 'Active'),
('Eva Adams', 'eva@example.com', '081399988877', 5, 9, '2019-12-05', 'Inactive'),
('Frank Martin', 'frank@example.com', '081345678901', 6, 11, '2022-07-15', 'Active'),
('Grace Lee', 'grace@example.com', '081312345678', 6, 12, '2023-08-20', 'Active');

INSERT INTO salaries (employee_id, base_salary, bonus, effective_date) VALUES
(1, 7000000, 500000, '2023-01-01'),
(2, 8500000, 600000, '2023-02-01'),
(3, 9500000, 750000, '2023-03-01'),
(4, 7800000, 500000, '2023-04-01'),
(5, 6500000, 450000, '2023-05-01'),
(6, 9000000, 1000000, '2023-06-01'),
(7, 7000000, 750000, '2023-09-01');


INSERT INTO salary_history (employee_id, old_salary, new_salary, change_reason, changed_at) VALUES
(1, 6500000, 7000000, 'Annual Increment', '2023-01-01 10:00:00'),
(2, 8000000, 8500000, 'Performance Bonus', '2023-02-01 11:30:00'),
(3, 9000000, 9500000, 'Promotion', '2023-03-01 09:45:00'),
(4, 7500000, 7800000, 'Annual Increment', '2023-04-01 14:15:00'),
(5, 6200000, 6500000, 'Cost of Living Adjustment', '2023-05-01 12:00:00'),
(6, 8500000, 9000000, 'Promotion', '2023-06-01 10:30:00'),
(7, 6500000, 7000000, 'Annual Increment', '2023-09-01 11:00:00');



INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, status, created_at) VALUES
(1, 'Annual Leave', '2024-02-01', '2024-02-05', 'Approved', '2024-01-15 08:30:00'),
(2, 'Sick Leave', '2024-02-10', '2024-02-12', 'Pending', '2024-02-05 09:00:00'),
(3, 'Maternity Leave', '2024-03-01', '2024-06-01', 'Approved', '2024-01-20 14:00:00'),
(4, 'Unpaid Leave', '2024-04-15', '2024-04-20', 'Rejected', '2024-03-10 10:15:00'),
(5, 'Annual Leave', '2024-05-01', '2024-05-07', 'Pending', '2024-04-15 11:30:00'),
(6, 'Annual Leave', '2024-03-10', '2024-03-15', 'Approved', '2024-02-25 09:00:00'),
(7, 'Sick Leave', '2024-04-05', '2024-04-07', 'Pending', '2024-03-30 10:30:00');


INSERT INTO users (username, email, password_hash, role, created_at) VALUES
('alice_j', 'alice@example.com', 'hashed_password1', 'Admin', '2024-01-01 08:00:00'),
('bob_s', 'bob@example.com', 'hashed_password2', 'Manager', '2024-01-02 09:00:00'),
('charlie_b', 'charlie@example.com', 'hashed_password3', 'Employee', '2024-01-03 10:00:00'),
('david_w', 'david@example.com', 'hashed_password4', 'Employee', '2024-01-04 11:00:00'),
('eva_a', 'eva@example.com', 'hashed_password5', 'Employee', '2024-01-05 12:00:00');


INSERT INTO attendance (employee_id, attendance_date, check_in, check_out, status, location) VALUES
(1, '2024-02-01', '08:15:00', '17:05:00', 'Present', 'Office 1'),
(2, '2024-02-01', '09:10:00', '17:30:00', 'Late', 'Office 2'),
(3, '2024-02-01', NULL, NULL, 'Absent', NULL),
(4, '2024-02-01', '08:30:00', '17:10:00', 'Present', 'Office 3'),
(5, '2024-02-01', NULL, NULL, 'On Leave', NULL),
(6, '2024-02-02', '08:00:00', '17:00:00', 'Present', 'Office 1'),
(7, '2024-02-02', '08:30:00', '17:15:00', 'Present', 'Office 2');

ALTER TABLE employees MODIFY department_id BIGINT UNSIGNED;
DESC employees;
DESC departments;
ALTER TABLE employees MODIFY position_id BIGINT UNSIGNED;


ALTER TABLE employees
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(id),
ADD CONSTRAINT fk_position FOREIGN KEY (position_id) REFERENCES positions(id);

ALTER TABLE attendance
ADD CONSTRAINT fk_attendance_employee FOREIGN KEY (employee_id) REFERENCES employees(id);

ALTER TABLE salaries MODIFY employee_id BIGINT UNSIGNED;

ALTER TABLE salaries
ADD CONSTRAINT fk_salaries_employee FOREIGN KEY (employee_id) REFERENCES employees(id);

ALTER TABLE salary_history MODIFY employee_id BIGINT UNSIGNED;

ALTER TABLE salary_history
ADD CONSTRAINT fk_salary_history_employee FOREIGN KEY (employee_id) REFERENCES employees(id);

ALTER TABLE leave_requests MODIFY employee_id BIGINT UNSIGNED;
ALTER TABLE leave_requests
ADD CONSTRAINT fk_leave_requests_employee FOREIGN KEY (employee_id) REFERENCES employees(id);

ALTER TABLE users
ADD COLUMN employee_id BIGINT UNSIGNED,
ADD CONSTRAINT fk_users_employee FOREIGN KEY (employee_id) REFERENCES employees(id);


INSERT INTO users (username, email, password_hash, role, created_at) VALUES
('david_black', 'david.black10@example.com', 'hashed_password', 'manager', NOW()),
('charlie_admin', 'charlie.black11@example.com', 'Admin1234', 'admin', NOW()),
('alice_admin', 'alice.black12@example.com', 'Admin1234', 'admin', NOW()),
('henryBlack', 'henry.black13@example.com', 'hashed_password', 'employee', NOW()),
('charliejhon12', 'charlie.johnson14@example.com', 'hashed_password', 'employee', NOW()),
('alice_admin2', 'alice.green15@example.com', 'Admin1234', 'admin', NOW());

INSERT INTO attendance (employee_id, attendance_date, check_in, check_out, status, location, created_at) VALUES
(1, '2024-02-01', '08:30:00', '17:00:00', 'On Leave', 'Office', NOW()),
(2, '2024-02-01', '08:30:00', '17:00:00', 'On Leave', 'Office', NOW()),
(3, '2024-02-01', '08:30:00', '17:00:00', 'Absent', 'Office', NOW()),
(4, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(5, '2024-02-01', '08:00:00', '17:00:00', 'Absent', 'Office', NOW()),
(6, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(7, '2024-02-01', '08:00:00', '17:00:00', 'Absent', 'Office', NOW()),
(8, '2024-02-01', '08:30:00', '17:00:00', 'Absent', 'Office', NOW()),
(9, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(10, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(11, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(12, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(13, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(14, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(15, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(16, '2024-02-01', '08:30:00', '17:00:00', 'Late', 'Office', NOW()),
(17, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(18, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(19, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(20, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(21, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(22, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(23, '2024-02-01', '08:30:00', '17:00:00', 'Present', 'Office', NOW()),
(24, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(25, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(26, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(27, '2024-02-01', '08:30:00', '17:00:00', 'Present', 'Office', NOW()),
(28, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(29, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(30, '2024-02-01', '08:30:00', '17:00:00', 'Absent', 'Office', NOW()),
(31, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(32, '2024-02-01', '08:30:00', '17:00:00', 'Present', 'Office', NOW()),
(33, '2024-02-01', '08:30:00', '17:00:00', 'Absent', 'Office', NOW()),
(34, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(35, '2024-02-01', '08:30:00', '17:00:00', 'Late', 'Office', NOW()),
(36, '2024-02-01', '08:30:00', '17:00:00', 'Late', 'Office', NOW()),
(37, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(38, '2024-02-01', '08:00:00', '17:00:00', 'Absent', 'Office', NOW()),
(39, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(40, '2024-02-01', '08:30:00', '17:00:00', 'On Leave', 'Office', NOW()),
(41, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(42, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(43, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(44, '2024-02-01', '08:00:00', '17:00:00', 'On Leave', 'Office', NOW()),
(45, '2024-02-01', '08:00:00', '17:00:00', 'Absent', 'Office', NOW()),
(46, '2024-02-01', '08:30:00', '17:00:00', 'On Leave', 'Office', NOW()),
(47, '2024-02-01', '08:00:00', '17:00:00', 'Absent', 'Office', NOW()),
(48, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW()),
(49, '2024-02-01', '08:00:00', '17:00:00', 'Late', 'Office', NOW()),
(50, '2024-02-01', '08:00:00', '17:00:00', 'Present', 'Office', NOW());
SELECT*from employees;
SELECT*from salary_history;
INSERT INTO employees (id, name, email, phone, department_id, position_id, hire_date, status) VALUES
(8, 'David Johnson', 'david.johnson8@example.com', '081907962916', 3, 3, '2021-01-18', 'Active'),
(9, 'Bob Green', 'bob.green9@example.com', '087788574974', 2, 5, '2020-06-21', 'Active'),
(10, 'David Black', 'david.black10@example.com', '086870540282', 2, 5, '2023-04-01', 'Active'),
(11, 'Charlie Black', 'charlie.black11@example.com', '088440784427', 4, 3, '2023-01-26', 'Active'),
(12, 'Alice Black', 'alice.black12@example.com', '085013868405', 2, 3, '2023-12-15', 'Active'),
(13, 'Henry Black', 'henry.black13@example.com', '082572845562', 3, 3, '2022-02-21', 'Inactive'),
(14, 'Charlie Johnson', 'charlie.johnson14@example.com', '082159026804', 4, 4, '2021-09-25', 'Inactive'),
(15, 'Alice Green', 'alice.green15@example.com', '084442076180', 1, 1, '2023-12-25', 'Active'),
(16, 'Bob Harris', 'bob.harris16@example.com', '086798579933', 3, 3, '2021-07-10', 'Inactive'),
(17, 'Jane White', 'jane.white17@example.com', '082559512055', 1, 1, '2020-08-16', 'Active'),
(18, 'Grace White', 'grace.white18@example.com', '084293659292', 1, 2, '2021-09-01', 'Inactive'),
(19, 'Jane Doe', 'jane.doe19@example.com', '085287496290', 3, 4, '2023-11-10', 'Active'),
(20, 'David Green', 'david.green20@example.com', '086116977311', 3, 4, '2021-12-28', 'Active'),
(21, 'Charlie Doe', 'charlie.doe21@example.com', '089245683041', 5, 2, '2023-12-28', 'Active'),
(22, 'Emily Black', 'emily.black22@example.com', '082764568097', 3, 4, '2023-10-24', 'Active'),
(23, 'Frank Johnson', 'frank.johnson23@example.com', '089021972547', 5, 1, '2020-04-05', 'Active'),
(24, 'Charlie Doe', 'charlie.doe24@example.com', '087229376204', 5, 5, '2021-07-27', 'Inactive'),
(25, 'Alice Green', 'alice.green25@example.com', '083881303141', 1, 2, '2022-07-27', 'Active'),
(26, 'Jane Brown', 'jane.brown26@example.com', '085855693240', 1, 2, '2021-09-11', 'Inactive'),
(27, 'Charlie Smith', 'charlie.smith27@example.com', '087357050744', 4, 3, '2022-12-18', 'Inactive'),
(28, 'Frank Johnson', 'frank.johnson28@example.com', '083912616653', 2, 5, '2021-01-14', 'Inactive'),
(29, 'Bob King', 'bob.king29@example.com', '086961634723', 5, 1, '2023-03-08', 'Inactive'),
(30, 'Charlie Doe', 'charlie.doe30@example.com', '086953913330', 3, 2, '2021-06-12', 'Active'),
(31, 'Frank Green', 'frank.green31@example.com', '087000383035', 2, 1, '2023-03-26', 'Active'),
(32, 'Charlie Smith', 'charlie.smith32@example.com', '086848965297', 5, 3, '2023-05-28', 'Active'),
(33, 'Henry Doe', 'henry.doe33@example.com', '081156501706', 2, 3, '2021-09-21', 'Active'),
(34, 'John Green', 'john.green34@example.com', '088969310435', 3, 5, '2022-11-11', 'Active'),
(35, 'Grace Lopez', 'grace.lopez35@example.com', '086403296107', 3, 5, '2023-12-17', 'Inactive'),
(36, 'Bob Black', 'bob.black36@example.com', '085344359409', 4, 2, '2023-12-07', 'Inactive'),
(37, 'Charlie Brown', 'charlie.brown37@example.com', '086093355231', 4, 3, '2021-10-08', 'Active'),
(38, 'David Harris', 'david.harris38@example.com', '088529750881', 3, 3, '2023-03-24', 'Inactive'),
(39, 'Grace White', 'grace.white39@example.com', '087932786669', 1, 1, '2023-07-23', 'Inactive'),
(40, 'Frank Lopez', 'frank.lopez40@example.com', '083678689114', 5, 3, '2021-08-10', 'Inactive'),
(41, 'David Harris', 'david.harris41@example.com', '089175160826', 4, 5, '2021-06-15', 'Inactive'),
(42, 'John Green', 'john.green42@example.com', '082743890317', 5, 3, '2021-02-10', 'Inactive'),
(43, 'Emily King', 'emily.king43@example.com', '088756498079', 3, 4, '2022-08-15', 'Active'),
(44, 'Alice Brown', 'alice.brown44@example.com', '083709002230', 5, 3, '2020-12-14', 'Active'),
(45, 'David Green', 'david.green45@example.com', '085995509212', 4, 4, '2020-09-26', 'Active'),
(46, 'Alice King', 'alice.king46@example.com', '089168722999', 2, 5, '2023-04-19', 'Inactive'),
(47, 'John Green', 'john.green47@example.com', '088920407319', 4, 2, '2023-02-26', 'Active'),
(48, 'Alice Johnson', 'alice.johnson48@example.com', '087534399892', 1, 5, '2020-01-27', 'Active'),
(49, 'Frank Doe', 'frank.doe49@example.com', '083905041057', 1, 5, '2020-09-12', 'Active'),
(50, 'Bob Doe', 'bob.doe50@example.com', '081501701648', 1, 1, '2023-08-18', 'Inactive');


INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, status, created_at) VALUES
(46, 'Maternity Leave', '2024-02-05', '2024-02-07', 'Rejected', NOW()),
(9, 'Sick Leave', '2024-02-05', '2024-02-07', 'Pending', NOW()),
(33, 'Annual Leave', '2024-02-05', '2024-02-07', 'Rejected', NOW()),
(50, 'Annual Leave', '2024-02-05', '2024-02-07', 'Rejected', NOW());

INSERT INTO salaries (employee_id, base_salary, bonus, effective_date) VALUES
(9, 8887765, 641315, '2020-06-21'),
(10, 7331391, 974405, '2023-04-01'),
(11, 7626069, 872325, '2023-01-26'),
(12, 6365070, 1899781, '2023-12-15'),
(13, 7324420, 603695, '2022-02-21'),
(14, 6471085, 1799500, '2021-09-25'),
(15, 5538501, 262494, '2023-12-25'),
(16, 5055051, 888068, '2021-07-10'),
(17, 9508232, 597797, '2020-08-16'),
(18, 7261751, 164547, '2021-09-01'), 
(19, 5647510, 633367, '2023-11-10'), 
(20, 8820662, 142889, '2021-12-28'),
(21, 7467598, 1433522, '2023-12-28'),
(22, 4182744, 324870, '2023-10-24'),
(23, 6556243, 1126752, '2020-04-05'),
(24, 5507843, 674437, '2021-07-27'),
(25, 5797268, 967319, '2022-07-27'),
(26, 6046661, 353295, '2021-09-11'),
(27, 8170617, 1750439, '2022-12-18'),
(28, 7519982, 945115, '2021-01-14'),
(29, 8755184, 507990, '2023-03-08'),
(30, 7601046, 1058370, '2021-06-12'),
(31, 5819349, 790913, '2023-03-26'),
(32, 8383117, 1989522, '2023-05-28'),
(33, 6300945, 730900, '2021-09-21'),
(34, 6125919, 1201902, '2022-11-11'),
(35, 5808785, 179454, '2023-12-17'),
(36, 8026602, 1783155, '2023-12-07'),
(37, 9916294, 1219979, '2021-10-08'),
(38, 9849899, 1833337, '2023-03-24'),
(39, 7886469, 417905, '2023-07-23'),
(40, 9465372, 1733661, '2021-08-10'),
(41, 4347755, 1245593, '2021-06-15'),
(42, 6165157, 1228182, '2021-02-10'),
(43, 5383788, 1085606, '2022-08-15'),
(44, 4974477, 1518180, '2020-12-14'),
(45, 7300942, 62344, '2020-09-26'),
(46, 6178351, 718831, '2023-04-19'),
(47, 8899854, 591803, '2023-02-26'),
(48, 8283157, 747568, '2020-01-27'),
(49, 9702722, 1841072, '2020-09-12'),
(50, 8254481, 1298327, '2023-08-18');
