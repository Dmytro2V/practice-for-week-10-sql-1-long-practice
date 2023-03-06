-- Your code here
.print
.print =================    PHASE4      ========================
.print
.open the-office.db
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS parties;

CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    department VARCHAR(40) NOT NULL,
    role VARCHAR(40) NOT NULL,
    romantic VARCHAR(40)
);
CREATE TABLE reviews (
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(40) NOT NULL,
    score NUMBER(1,1),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);
CREATE TABLE parties (
    id INTEGER PRIMARY KEY,
    budget NUMBER(3,2) NOT NULL,
    is_onsite BOOLEAN,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);


INSERT INTO employees (first_name, last_name, department, role)
    VALUES 
    ("Michael", "Scott", "Management", "Regional Manager"),
    ("Dwight", "Schrute", "Sales", "Assistant Regional Manager"),
    ("Jim", "Halpert", "Sales", "Sales Representative"),
    ("Pam", "Beesly", "Reception", "Receptionist"),
    ("Kelly", "Kapoor", "Product Oversight", "Customer Service Representative"),
    ("Angela", "Martin", "Accounting", "Head of Accounting"),
    ("Roy", "Anderson", "Warehouse", "Warehouse Staff")
;
UPDATE employees
    SET romantic = "Pam Beesly"
    WHERE first_name = "Roy" AND last_name = "Anderson"
;
UPDATE employees
    SET romantic = "Roy Anderson"
    WHERE first_name = "Pam" AND last_name = "Beesley"
;
INSERT INTO employees (first_name, last_name, department, role)
    VALUES 
    ("Ryan", "Howard", "Reception", "Temp")
;
INSERT INTO parties (budget, is_onsite)
    VALUES 
    (100.00, true)
;
INSERT INTO reviews (full_name, score)
    VALUES 
    ("Dwight Schrute", 3.3),
    ("Jim Halpert", 4.2)
;
-- last id of "Dwight Schrute":
-- SELECT id FROM reviews WHERE full_name = "Dwight Schrute" ORDER by id DESC LIMIT 1
UPDATE reviews
    SET score = 9.0
    WHERE id = (SELECT id FROM reviews WHERE full_name = "Dwight Schrute" 
                    ORDER by id DESC LIMIT 1)    
;
UPDATE reviews
    SET score = 9.3
    WHERE id = (SELECT id FROM reviews WHERE full_name = "Jim Halpert"
                    ORDER by id DESC LIMIT 1)    
;    
UPDATE employees
    SET role = "Assistant Regional Manager"
    WHERE first_name = "Jim" AND last_name = "Halpert"
;
UPDATE employees
    SET role = "Assistant Regional Manager",
        department = "Sales Representative"
    WHERE first_name = "Ryan" AND last_name = "Howard"
;
INSERT INTO parties (budget, is_onsite)
    VALUES 
    (200.00, false)
;

UPDATE employees
    SET romantic = "Dwight Schrute"
    WHERE first_name = "Angela" AND last_name = "Martin"
;
UPDATE employees
    SET romantic = "Angela Martin"
    WHERE first_name = "Dwight" AND last_name = "Schrute"
;

INSERT INTO reviews (full_name, score)
    VALUES 
    ("Angela Martin", 6.2)
;
-- "Ryan Howard" and "Kelly Kapoor" are in a romantic relationship.
-- An onsite office party is scheduled with a budget of $50.00.

--"Jim Halpert" moves to another office branch (make sure to remove his relationships and performance reviews if he has any).

DELETE FROM employees
    WHERE first_name = "Jim" AND last_name = "Halpert"
;
DELETE FROM reviews 
    WHERE full_name = "Jim Halpert"
;


UPDATE employees 
    SET romantic = NULL
    WHERE first_name = "Roy" and last_name = "Anderson"
    OR    first_name = "Pam" and last_name = "Beesly"
;
--"Pam Beesly" gets a performance review score of 7.6.
--"Dwight Schrute" gets another performance review score of 8.7.
--"Ryan Howard" quits the office (make sure to remove his relationships and performance reviews if he has any).
--"Jim Halpert" moves back to this office branch's "Sales" department in the role of "Sales Representative"
--"Karen Filippelli" moves from a different office into this office's "Sales" department in the role of "Sales Representative"
--"Karen Filippelli" and "Jim Halpert" are in a romantic relationship.
--An onsite office party is scheduled with a budget of $120.00.
--The onsite office party scheduled right before this is canceled, and an offsite office party is scheduled instead with a budget of $300.00.
--"Karen Filippelli" and "Jim Halpert" are NO LONGER in a romantic relationship.
--"Pam Beesly" and "Jim Halpert" are in a romantic relationship.
SELECT * FROM employees;
.print
SELECT * FROM reviews;
.print
SELECT * FROM parties;

/* BONUS :
How would you change your database schema to track the employees who 
attended an office party?
ANSWER: 
add table party_employers with foreign key of the party and employer name or key

How would you change your database schema to track vacation days taken by employees?
ANSWER:
if need data on days - add another table with employer id and data and days taken
if only days matters (low probability) then can add field to employers.