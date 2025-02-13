use employee_management_system;

-- Total Employees in Each Department
SELECT d.name AS department_name, COUNT(e.id) AS total_employees
FROM employees e
JOIN departments d ON e.id = d.id
GROUP BY d.name
ORDER BY total_employees DESC;

--  Leave Requests Analysis
SELECT status, COUNT(*) AS total_requests
FROM leave_requests
GROUP BY status;

-- Employee Attendance Summary
SELECT e.name, 
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS total_present,
       SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS total_late,
       SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS total_absent
FROM employees e
JOIN attendance a ON e.id = a.employee_id
GROUP BY e.name
ORDER BY total_present DESC;

-- Average Salary by Job Position
SELECT p.name, AVG(s.base_salary) AS average_salary
FROM salaries s
JOIN employees e ON s.employee_id = e.id
JOIN positions p ON e.id = p.id
GROUP BY p.name
ORDER BY average_salary DESC;


-- Top 5 Highest Paid Employees
SELECT e.id, e.name, d.name, p.name, s.base_salary
FROM employees e
JOIN salaries s ON e.id = s.employee_id
JOIN positions p ON e.position_id = p.id
JOIN departments d ON e.department_id = d.id
ORDER BY s.base_salary DESC
LIMIT 5;

-- Department with the Highest Salary Expenses
SELECT d.name, SUM(s.base_salary) AS total_salary
FROM salaries s
JOIN employees e ON s.employee_id = e.id
JOIN departments d ON e.department_id = d.id
GROUP BY d.name
ORDER BY total_salary DESC
LIMIT 3;

--  Employees Who Took the Most Leave
SELECT e.name, COUNT(lr.id) AS total_leaves
FROM leave_requests lr
JOIN employees e ON lr.employee_id = e.id
WHERE lr.status = 'Approved'
GROUP BY e.name
ORDER BY total_leaves DESC
LIMIT 3;




