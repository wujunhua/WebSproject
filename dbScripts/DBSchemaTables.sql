-- -----------------------------------------------------
-- Schema Student_Performance
-- -----------------------------------------------------

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
-- Table Student_Performance.Class
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Class (
  class_id VARCHAR2(30) NOT NULL,
  stream_id VARCHAR2(40) NULL,
  user_id VARCHAR2(100) NULL,
  PRIMARY KEY (class_id)
,
  CONSTRAINT fk_Class_Stream1
    FOREIGN KEY (stream_id)
    REFERENCES Student_Performance.Stream (stream_id)
    ON DELETE SET NULL
,
  CONSTRAINT fk_Class_Users1
    FOREIGN KEY (user_id)
    REFERENCES Student_Performance.Users (user_id)
    ON DELETE SET NULL
);

CREATE INDEX fk_Class_Stream1_idx ON Student_Performance.Class (stream_id ASC);
CREATE INDEX fk_Class_Users1_idx ON Student_Performance.Class (user_id ASC);

-- -----------------------------------------------------
-- Table Student_Performance.Employees
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Employees (
  employee_id VARCHAR2(10) NOT NULL,
  name VARCHAR2(100) NULL,
  email VARCHAR2(100) NULL,
  class_id VARCHAR2(30) NULL,
  PRIMARY KEY (employee_id)
,
  CONSTRAINT fk_Students_Class1
    FOREIGN KEY (class_id)
    REFERENCES Student_Performance.Class (class_id)
    ON DELETE SET NULL
);

CREATE INDEX fk_Students_Class1_idx ON Student_Performance.Employees (class_id ASC);

-- -----------------------------------------------------
-- Table Student_Performance.Modules
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Modules (
  module_id NUMBER(10) NOT NULL,
  module_name VARCHAR2(45) NULL,
  category VARCHAR2(30) NULL,
  stream_id VARCHAR2(40) NULL,
  PRIMARY KEY (module_id)
,
  CONSTRAINT fk_Modules_Stream1
    FOREIGN KEY (stream_id)
    REFERENCES Student_Performance.Stream (stream_id)
    ON DELETE SET NULL
);

CREATE INDEX fk_Modules_Stream1_idx ON Student_Performance.Modules (stream_id ASC);

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
    ON DELETE SET NULL
);

CREATE INDEX fk_Courses_Modules1_idx ON Student_Performance.Courses (module_id ASC);

-- -----------------------------------------------------
-- Table Student_Performance.Employees_take_Modules
-- -----------------------------------------------------
CREATE TABLE Student_Performance.Employees_take_Modules (
  module_id NUMBER(10) NULL,
  employee_id VARCHAR2(10) NULL,
  scores NUMBER(6,2) NULL
,
  CONSTRAINT fk_Modules_has_Modules
    FOREIGN KEY (module_id)
    REFERENCES Student_Performance.Modules (module_id)
    ON DELETE SET NULL
,
  CONSTRAINT fk_Modules_has_Students
    FOREIGN KEY (employee_id)
    REFERENCES Student_Performance.Employees (employee_id)
    ON DELETE SET NULL
);

CREATE INDEX fk_Modules_has_Students_idx ON Student_Performance.Employees_take_Modules (employee_id ASC);
CREATE INDEX fk_Modules_has_Modules_idx ON Student_Performance.Employees_take_Modules (module_id ASC);