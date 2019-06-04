-- -----------------------------------------------------
-- Schema Student_Performance
-- -----------------------------------------------------

DROP USER Student_Performance Cascade;
CREATE USER Student_Performance IDENTIFIED BY Student_Performance;
GRANT CONNECT, RESOURCE, DBA To Student_Performance;
connect Student_Performance/Student_Performance;

-- -----------------------------------------------------
-- Table Student_Performance.Users
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Users (
  user_id VARCHAR2(100) NOT NULL,
  password VARCHAR2(30) NULL,
  isAdmin VARCHAR2(1) NULL,
  PRIMARY KEY (user_id)
);

-- -----------------------------------------------------
-- Table Student_Performance.Stream
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Stream (
  stream_id VARCHAR2(40) NOT NULL,
  stream_name VARCHAR2(50) NULL,
  PRIMARY KEY (stream_id)
);

-- -----------------------------------------------------
-- Table Student_Performance.Category
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Category (
  category_id VARCHAR2(30) NOT NULL,
  category_name VARCHAR2(45) NULL,
  PRIMARY KEY (category_id)
);
-- -----------------------------------------------------
-- Table Student_Performance.Employees
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Employees (
  employee_id VARCHAR2(10) NOT NULL,
  name VARCHAR2(100) NULL,
  email VARCHAR2(100) NULL,
  PRIMARY KEY (employee_id)
);

-- -----------------------------------------------------
-- Table Student_Performance.Modules
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Modules (
  module_id NUMBER(10) NOT NULL,
  module_name VARCHAR2(45) NULL,
  category_id VARCHAR2(30) NOT NULL,
  stream_id VARCHAR2(40) NOT NULL,
  PRIMARY KEY (module_id)
,
  CONSTRAINT fk_Modules_Stream1
    FOREIGN KEY (stream_id)
    REFERENCES Student_Performance.Stream (stream_id)
    ----ON DELETE NO ACTION
,
  CONSTRAINT fk_Modules_Category1
    FOREIGN KEY (category_id)
    REFERENCES Student_Performance.Category (category_id)
    ----ON DELETE NO ACTION
);

-- -----------------------------------------------------
-- Table Student_Performance.Courses
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Courses (
  course_id VARCHAR2(20) NOT NULL,
  course_name VARCHAR2(45) NULL,
  module_id NUMBER(10) NULL,
  PRIMARY KEY (course_id)
,
  CONSTRAINT fk_Courses_Modules1
    FOREIGN KEY (module_id)
    REFERENCES Student_Performance.Modules (module_id)
    ----ON DELETE NO ACTION
);

-- -----------------------------------------------------
-- Table Student_Performance.Employees_take_Modules
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Employees_take_Modules (
  module_id NUMBER(10) NULL,
  employee_id VARCHAR2(10) NULL,
  batch_id VARCHAR2(10) NOT NULL,
  scores NUMBER(6,2) NULL
,
  CONSTRAINT fk_Modules_has_Modules
    FOREIGN KEY (module_id)
    REFERENCES Student_Performance.Modules (module_id)
    ----ON DELETE NO ACTION
,
  CONSTRAINT fk_Modules_has_Students
    FOREIGN KEY (employee_id)
    REFERENCES Student_Performance.Employees (employee_id)
    ----ON DELETE NO ACTION
);

-- -----------------------------------------------------
-- Table Student_Performance.Batches & join tables for Batches, Instructors, And Employees
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Batches(
  batch_id VARCHAR2(10) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  stream_id VARCHAR2(40) NULL,
  country VARCHAR2(20) NOT NULL,
  city VARCHAR2(20) NOT NULL,
  PRIMARY KEY (batch_id)
,
  CONSTRAINT fk_Batches_has_Stream
    FOREIGN KEY (stream_id)
    REFERENCES Student_Performance.Stream (stream_id)
    ON DELETE SET NULL
);

CREATE TABLE Student_Performance.Instructors_Teach_Batches(
  batch_id VARCHAR2(10) NOT NULL,
  employee_id VARCHAR2(100) NOT NULL
,
  CONSTRAINT fk_Batches_has_Batches
    FOREIGN KEY (batch_id)
    REFERENCES Student_Performance.Batches (batch_id)
,
  CONSTRAINT fk_Batches_has_Instructors
    FOREIGN KEY (employee_id)
    REFERENCES Student_Performance.Employees (employee_id)
); 