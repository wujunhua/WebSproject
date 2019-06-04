INSERT INTO USERS VALUES('Gabriel_Urbaitis@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Jason_Richard@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Shengchun_liu@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Nicholas_Cook@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Daniel_Lowery@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Christopher_Foose@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Emmily_Lusz@Syntelinc.com', 'abC1@3deF', 'N');
INSERT INTO USERS VALUES('Jay_Patel@Syntelinc.com', 'abC1@3deF', 'Y');
INSERT INTO USERS VALUES('Junhua_Wu@Syntelinc.com', 'abC1@3deF', 'Y');
INSERT INTO USERS VALUES('Pearl_Matakatla@Syntelinc.com', 'abC1@3deF', 'N');

Insert INTO Stream VALUES ('FSD123', 'Java Full Stack Developer');
Insert INTO Stream VALUES ('BD456', 'Big Data');

Insert INTO Category VALUES ('FOUND01', 'Foundation');
Insert INTO Category VALUES ('SPEC01', 'Specialization');
Insert INTO Category VALUES ('PD01', 'Process and Domain');

INSERT INTO Employees VALUES('5060410', 'Gabriel Urbaitis', 'Gabriel_Urbaitis@Syntelinc.com');
INSERT INTO Employees VALUES('5060411', 'Jason Richard', 'Jason_Richard@Syntelinc.com');
INSERT INTO Employees VALUES('5060412', 'Shengchun Liu', 'Shengchun_liu@Syntelinc.com');
INSERT INTO Employees VALUES('5060413', 'Nicholas Cook', 'Nicholas_Cook@Syntelinc.com');
INSERT INTO Employees VALUES('5060414', 'Daniel Lowery', 'Daniel_Lowery@Syntelinc.com');
INSERT INTO Employees VALUES('5060415', 'Christopher Foose', 'Christopher_Foose@Syntelinc.com');
INSERT INTO Employees VALUES('5060416', 'Emmily Lusz', 'Emmily_Lusz@Syntelinc.com');
INSERT INTO Employees VALUES('5060417', 'Jay Patel', 'Jay_Patel@Syntelinc.com');
INSERT INTO Employees VALUES('5060418', 'Junhua Wu', 'Junhua_Wu@Syntelinc.com');
INSERT INTO Employees VALUES('5060419', 'Pearl Matakatla', 'Pearl_Matakatla@Syntelinc.com');

Insert INTO Modules VALUES(1, 'Responsive Web Design', 'FOUND01', 'FSD123');
Insert INTO Modules VALUES(2, 'Databases with Oracle', 'FOUND01', 'FSD123');
Insert INTO Modules VALUES(3, 'Core Java', 'SPEC01', 'FSD123');
Insert INTO Modules VALUES(4, 'Java Framework', 'SPEC01', 'FSD123');
Insert INTO Modules VALUES(5, 'ReactJS', 'SPEC01', 'FSD123');
Insert INTO Modules VALUES(6, 'Web Services and Automation Testing', 'SPEC01', 'FSD123');
Insert INTO Modules VALUES(7, 'Devops and Microservice Basics', 'PD01', 'FSD123');
Insert INTO Modules VALUES(8, 'Data Warehousing', 'FOUND01', 'BD456');
Insert INTO Modules VALUES(9, 'Clustered Computing', 'FOUND01', 'BD456');
Insert INTO Modules VALUES(10, 'Computing and Analyzing Data', 'FOUND01', 'BD456');

Insert INTO Courses VALUES('1', 'Responsive Web Design', '1');
Insert INTO Courses VALUES('2', 'Relational Database Management with Oracle', '2');
Insert INTO Courses VALUES('3', 'Programming with Java', '3');
Insert INTO Courses VALUES('4', 'Advanced Java - Spring Core', '4');
Insert INTO Courses VALUES('5', 'Advanced Java - Spring Web Applications', '4');
Insert INTO Courses VALUES('6', 'Responsive Web Design', '5');
Insert INTO Courses VALUES('7', 'Testing Overview', '6');
Insert INTO Courses VALUES('8', 'Selenium', '6');
Insert INTO Courses VALUES('9', 'Web Services', '6');
Insert INTO Courses VALUES('10', 'Spring Boot', '7');
Insert INTO Courses VALUES('11', 'Microservices Overview', '7');
Insert INTO Courses VALUES('12', 'Devops Overview', '7');
Insert INTO Courses VALUES('13', 'Build and Versioning Tools', '7');
INSERT INTO COURSES VALUES('14', 'MapReduce', '9');
INSERT INTO COURSES VALUES('15', 'Hadoop', '10');
INSERT INTO COURSES VALUES('16', '5C Architecture', '8');

Insert INTO Employees_Take_Modules VALUES('1', '5060410', 99.00);
Insert INTO Employees_Take_Modules VALUES('5', '5060410', 94.00);
Insert INTO Employees_Take_Modules VALUES('2', '5060411', 98.00);
Insert INTO Employees_Take_Modules VALUES('6', '5060411', 93.00);
Insert INTO Employees_Take_Modules VALUES('3', '5060412', 97.00);
Insert INTO Employees_Take_Modules VALUES('7', '5060412', 92.00);
Insert INTO Employees_Take_Modules VALUES('4', '5060413', 96.00);
Insert INTO Employees_Take_Modules VALUES('1', '5060413', 91.00);
Insert INTO Employees_Take_Modules VALUES('5', '5060418', 95.00);
Insert INTO Employees_Take_Modules VALUES('2', '5060418', 90.00);
Insert INTO Employees_Take_Modules VALUES('8', '5060414', 99.00);
Insert INTO Employees_Take_Modules VALUES('9', '5060414', 94.00);
Insert INTO Employees_Take_Modules VALUES('8', '5060415', 98.00);
Insert INTO Employees_Take_Modules VALUES('10', '5060415', 93.00);
Insert INTO Employees_Take_Modules VALUES('8', '5060416', 97.00);
Insert INTO Employees_Take_Modules VALUES('9', '5060416', 92.00);
Insert INTO Employees_Take_Modules VALUES('8', '5060417', 96.00);
Insert INTO Employees_Take_Modules VALUES('10', '5060417', 91.00);
Insert INTO Employees_Take_Modules VALUES('9', '5060419', 95.00);
Insert INTO Employees_Take_Modules VALUES('10', '5060419', 90.00);

INSERT INTO Batches VALUES('BEST07', '25-APR-19', '14-JUN-19', 'FSD123', 'USA', 'Phoenix');
INSERT INTO Batches VALUES('BEST13', '07-FEB-19', '05-APR-19', 'BD456', 'Netherlands', 'Amsterdam');

INSERT INTO Instructors_Teach_Batches VALUES('BEST07', '5060417');
INSERT INTO Instructors_Teach_Batches VALUES('BEST13', '5060418');

INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060410');
INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060411');
INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060412');
INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060413');
INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060418');
INSERT INTO Batches_Have_Employees VALUES('BEST07', '5060414');
INSERT INTO Batches_Have_Employees VALUES('BEST13', '5060415');
INSERT INTO Batches_Have_Employees VALUES('BEST13', '5060416');
INSERT INTO Batches_Have_Employees VALUES('BEST13', '5060419');
INSERT INTO Batches_Have_Employees VALUES('BEST13', '5060417');

COMMIT;