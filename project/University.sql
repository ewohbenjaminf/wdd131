-- ============================================================================
-- W06 Project: University Database
-- File: University.sql
-- ============================================================================

-- ----------------------------------------------------------------------------
-- PART 1: Forward Engineer / Schema Setup
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS university;
CREATE SCHEMA IF NOT EXISTS university DEFAULT CHARACTER SET utf8;
USE university;

-- Table: college
CREATE TABLE IF NOT EXISTS college (
  college_id INT NOT NULL AUTO_INCREMENT,
  college_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (college_id)
) ENGINE=InnoDB;

-- Table: department
CREATE TABLE IF NOT EXISTS department (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(100) NOT NULL,
  department_code VARCHAR(10) NOT NULL,
  college_id INT NOT NULL,
  PRIMARY KEY (department_id),
  CONSTRAINT fk_department_college
    FOREIGN KEY (college_id)
    REFERENCES college (college_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Table: course
CREATE TABLE IF NOT EXISTS course (
  course_id INT NOT NULL AUTO_INCREMENT,
  course_num INT NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  credits INT NOT NULL,
  department_id INT NOT NULL,
  PRIMARY KEY (course_id),
  CONSTRAINT fk_course_department
    FOREIGN KEY (department_id)
    REFERENCES department (department_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Table: term
CREATE TABLE IF NOT EXISTS term (
  term_id INT NOT NULL AUTO_INCREMENT,
  term_name VARCHAR(20) NOT NULL,
  term_year YEAR NOT NULL,
  PRIMARY KEY (term_id)
) ENGINE=InnoDB;

-- Table: faculty
CREATE TABLE IF NOT EXISTS faculty (
  faculty_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL,
  PRIMARY KEY (faculty_id)
) ENGINE=InnoDB;

-- Table: section
CREATE TABLE IF NOT EXISTS section (
  section_id INT NOT NULL AUTO_INCREMENT,
  section_num INT NOT NULL,
  capacity INT NOT NULL,
  course_id INT NOT NULL,
  term_id INT NOT NULL,
  faculty_id INT NOT NULL,
  PRIMARY KEY (section_id),
  CONSTRAINT fk_section_course
    FOREIGN KEY (course_id)
    REFERENCES course (course_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_section_term
    FOREIGN KEY (term_id)
    REFERENCES term (term_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_section_faculty
    FOREIGN KEY (faculty_id)
    REFERENCES faculty (faculty_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Table: student
CREATE TABLE IF NOT EXISTS student (
  student_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL,
  gender CHAR(1) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state CHAR(2) NOT NULL,
  birthdate DATE NOT NULL,
  PRIMARY KEY (student_id)
) ENGINE=InnoDB;

-- Table: enrollment
CREATE TABLE IF NOT EXISTS enrollment (
  student_id INT NOT NULL,
  section_id INT NOT NULL,
  PRIMARY KEY (student_id, section_id),
  CONSTRAINT fk_enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES student (student_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_enrollment_section
    FOREIGN KEY (section_id)
    REFERENCES section (section_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- ----------------------------------------------------------------------------
-- PART 2: Insert Data
-- ----------------------------------------------------------------------------

-- Colleges
INSERT INTO college (college_id, college_name) VALUES
(1, 'Physical Science and Engineering'),
(2, 'College of Business and Communication'),
(3, 'College of Language and Letters');

-- Departments
INSERT INTO department (department_id, department_name, department_code, college_id) VALUES
(1, 'Computer Information Technology', 'ITM', 1),
(2, 'Economics', 'ECON', 2),
(3, 'Humanities and Philosophy', 'HUM', 3);

-- Courses
INSERT INTO course (course_id, course_num, course_name, credits, department_id) VALUES
(1, 111, 'Intro to Databases', 3, 1),
(2, 150, 'Micro Economics', 3, 2),
(3, 388, 'Econometrics', 4, 2),
(4, 376, 'Classical Heritage', 2, 3);

-- Terms
INSERT INTO term (term_id, term_name, term_year) VALUES
(1, 'Fall', 2019),
(2, 'Winter', 2018);

-- Faculty
INSERT INTO faculty (faculty_id, fname, lname) VALUES
(1, 'Marty', 'Morring'),
(2, 'Nate', 'Norris'),
(3, 'Ben', 'Barrus'),
(4, 'John', 'Jensen'),
(5, 'Bill', 'Barney');

-- Students
INSERT INTO student (student_id, fname, lname, gender, city, state, birthdate) VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-08');

-- Sections
INSERT INTO section (section_id, section_num, capacity, course_id, term_id, faculty_id) VALUES
(1, 1, 30, 1, 1, 1), -- ITM 111, Sec 1, Fall 2019, Marty Morring
(2, 1, 50, 2, 1, 2), -- ECON 150, Sec 1, Fall 2019, Nate Norris
(3, 2, 50, 2, 1, 2), -- ECON 150, Sec 2, Fall 2019, Nate Norris
(4, 1, 50, 3, 1, 3), -- ECON 388, Sec 1, Fall 2019, Ben Barrus
(5, 1, 30, 4, 1, 4), -- HUM 376, Sec 1, Fall 2019, John Jensen
(6, 2, 30, 1, 2, 1), -- ITM 111, Sec 2, Winter 2018, Marty Morring
(7, 3, 35, 1, 2, 5), -- ITM 111, Sec 3, Winter 2018, Bill Barney
(8, 1, 100, 2, 2, 2), -- ECON 150, Sec 1, Winter 2018, Nate Norris
(9, 1, 30, 4, 2, 4), -- HUM 376, Sec 1, Winter 2018, John Jensen
(10, 2, 30, 4, 2, 4); -- HUM 376, Sec 2, Winter 2018, John Jensen

-- Enrollments
INSERT INTO enrollment (student_id, section_id) VALUES
(6, 7),  -- Alece Adams -> ITM 111 Sec 3 (W18)
(7, 6),  -- Bryce Carlson -> ITM 111 Sec 2 (W18)
(7, 8),  -- Bryce Carlson -> ECON 150 Sec 1 (W18)
(7, 10), -- Bryce Carlson -> HUM 376 Sec 2 (W18)
(4, 9),  -- Devon Merrill -> HUM 376 Sec 1 (W18)
(3, 4),  -- Kelly Jones -> ECON 388 Sec 1 (F19)
(5, 4),  -- Mandy Murdock -> ECON 388 Sec 1 (F19)
(5, 5),  -- Mandy Murdock -> HUM 376 Sec 1 (F19)
(1, 1),  -- Paul Miller -> ITM 111 Sec 1 (F19)
(1, 3),  -- Paul Miller -> ECON 150 Sec 2 (F19)
(5, 9),  -- Mandy Murdock -> HUM 376 Sec 1 (W18)
(10, 6), -- Susan Sorensen -> ITM 111 Sec 2 (W18)
(2, 2),  -- Katie Smith -> ECON 150 Sec 1 (F19)
(2, 4);  -- Katie Smith -> ECON 388 Sec 1 (F19)


-- ----------------------------------------------------------------------------
-- PART 3: Queries
-- ----------------------------------------------------------------------------

-- Query 1
-- Students born in September, formatted date, sorted by last name
SELECT 
    fname, 
    lname, 
    DATE_FORMAT(birthdate, '%M %e, %Y') AS `Sept Birthdays`
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY lname;


-- Query 2
-- Student's age in years and days as of Jan. 5, 2017, sorted from oldest to youngest
SELECT 
    lname, 
    fname, 
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS Years,
    DATEDIFF('2017-01-05', birthdate) % 365 AS Days,
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' - Yrs, ', DATEDIFF('2017-01-05', birthdate) % 365, ' - Days') AS `Years and Days`
FROM student
ORDER BY birthdate ASC;


-- Query 3
-- Students taught by John Jensen, sorted by last name
SELECT DISTINCT 
    st.fname, 
    st.lname
FROM student st
JOIN enrollment e ON st.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE f.fname = 'John' AND f.lname = 'Jensen'
ORDER BY st.lname;


-- Query 4
-- Instructors Bryce Carlson will have in Winter 2018, sorted by faculty last name
SELECT DISTINCT 
    f.fname, 
    f.lname
FROM faculty f
JOIN section sec ON f.faculty_id = sec.faculty_id
JOIN term t ON sec.term_id = t.term_id
JOIN enrollment e ON sec.section_id = e.section_id
JOIN student st ON e.student_id = st.student_id
WHERE st.fname = 'Bryce' 
  AND st.lname = 'Carlson'
  AND t.term_name = 'Winter' 
  AND t.term_year = 2018
ORDER BY f.lname;


-- Query 5
-- Students taking Econometrics in Fall 2019, sorted by student last name
SELECT 
    st.fname, 
    st.lname
FROM student st
JOIN enrollment e ON st.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
JOIN term t ON sec.term_id = t.term_id
WHERE c.course_name = 'Econometrics'
  AND t.term_name = 'Fall'
  AND t.term_year = 2019
ORDER BY st.lname;


-- Query 6
-- Report showing all of Bryce Carlson's courses for Winter 2018, sorted by course name
SELECT 
    d.department_code, 
    c.course_num, 
    c.course_name AS name
FROM course c
JOIN department d ON c.department_id = d.department_id
JOIN section sec ON c.course_id = sec.course_id
JOIN term t ON sec.term_id = t.term_id
JOIN enrollment e ON sec.section_id = e.section_id
JOIN student st ON e.student_id = st.student_id
WHERE st.fname = 'Bryce' 
  AND st.lname = 'Carlson'
  AND t.term_name = 'Winter' 
  AND t.term_year = 2018
ORDER BY c.course_name;


-- Query 7
-- Number of enrollments for Fall 2019
SELECT 
    t.term_name AS term, 
    t.term_year AS year, 
    COUNT(e.student_id) AS Enrollment
FROM term t
JOIN section sec ON t.term_id = sec.term_id
JOIN enrollment e ON sec.section_id = e.section_id
WHERE t.term_name = 'Fall' AND t.term_year = 2019
GROUP BY t.term_name, t.term_year;


-- Query 8
-- Number of courses in each college, sorted by college name
SELECT 
    col.college_name AS Colleges, 
    COUNT(c.course_id) AS Courses
FROM college col
JOIN department d ON col.college_id = d.college_id
JOIN course c ON d.department_id = c.department_id
GROUP BY col.college_name
ORDER BY col.college_name;


-- Query 9
-- Total capacity each professor can teach in Winter 2018, sorted by total teaching capacity
SELECT 
    f.fname, 
    f.lname, 
    SUM(sec.capacity) AS TeachingCapacity
FROM faculty f
JOIN section sec ON f.faculty_id = sec.faculty_id
JOIN term t ON sec.term_id = t.term_id
WHERE t.term_name = 'Winter' AND t.term_year = 2018
GROUP BY f.faculty_id, f.fname, f.lname
ORDER BY TeachingCapacity ASC;


-- Query 10
-- Each student's total credit load for Fall 2019 (credits > 3), sorted in descending order
SELECT 
    st.lname, 
    st.fname, 
    SUM(c.credits) AS Credits
FROM student st
JOIN enrollment e ON st.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
JOIN term t ON sec.term_id = t.term_id
WHERE t.term_name = 'Fall' AND t.term_year = 2019
GROUP BY st.student_id, st.lname, st.fname
HAVING SUM(c.credits) > 3
ORDER BY Credits DESC;