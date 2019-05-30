Insert INTO Users VALUES('katherine_bollinger@syntelinc.com', 'ABC123abc!@#', 'N');
Insert INTO Users VALUES('anthony_pennella@syntelinc.com', 'abc!@#ABC123', 'Y');

Insert INTO Stream VALUES ('FSD123', 'Java Full Stack Developer');
Insert INTO Stream VALUES ('BD456', 'Big Data');

Insert INTO Category VALUES ('FOUND01', 'Foundation');
Insert INTO Category VALUES ('SPEC01', 'Specialization');
Insert INTO Category VALUES ('PD01', 'Process and Domain');

Insert INTO Class VALUES ('FSDFour', 'FSD123', 'katherine_bollinger@syntelinc.com', TO_DATE('03/11/2019', 'mm/dd/yyyy'), TO_DATE('04/23/2019', 'mm/dd/yyyy'));

Insert INTO Employees VALUES('5059990', 'Kate Bollinger', 'katherine_bollinger@syntelinc.com', 'FSDFour', 'anthony_pennella@syntelinc.com');
Insert INTO Employees VALUES('5059991', 'Tony Pennella', 'anthony_pennella@syntelinc.com', 'FSDFour', 'katherine_bollinger@syntelinc.com');
Insert INTO Employees VALUES('5059992', 'Julia Maxwell', 'test1@syntelinc.com', 'FSDFour', null);
Insert INTO Employees VALUES('5059993', 'Rishkar Gareth', 'test2@syntelinc.com', 'FSDFour', null);
Insert INTO Employees VALUES('5059994', 'Alice Edwards', 'test3@syntelinc.com', 'FSDFour', null);

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

Insert INTO Employees_Take_Modules VALUES('1', '5059990', 70.00);
Insert INTO Employees_Take_Modules VALUES('2', '5059990', 70.00);
Insert INTO Employees_Take_Modules VALUES('3', '5059990', 89.90);
Insert INTO Employees_Take_Modules VALUES('4', '5059990', 95.50);
Insert INTO Employees_Take_Modules VALUES('5', '5059990', 98.33);
Insert INTO Employees_Take_Modules VALUES('6', '5059990', 82.66);
Insert INTO Employees_Take_Modules VALUES('7', '5059990', 99.50);
Insert INTO Employees_Take_Modules VALUES('1', '5059991', 90.00);
Insert INTO Employees_Take_Modules VALUES('2', '5059991', 95.00);
Insert INTO Employees_Take_Modules VALUES('3', '5059991', 77.00);
Insert INTO Employees_Take_Modules VALUES('4', '5059991', 99.00);
Insert INTO Employees_Take_Modules VALUES('5', '5059991', 79.50);
Insert INTO Employees_Take_Modules VALUES('6', '5059991', 72.66);
Insert INTO Employees_Take_Modules VALUES('7', '5059991', 97.50);
Insert INTO Employees_Take_Modules VALUES('1', '5059992', 70.00);
Insert INTO Employees_Take_Modules VALUES('2', '5059992', 70.00);
Insert INTO Employees_Take_Modules VALUES('3', '5059992', 77.00);
Insert INTO Employees_Take_Modules VALUES('4', '5059992', 89.00);
Insert INTO Employees_Take_Modules VALUES('5', '5059992', 79.50);
Insert INTO Employees_Take_Modules VALUES('6', '5059992', 72.66);
Insert INTO Employees_Take_Modules VALUES('7', '5059992', 70.00);
Insert INTO Employees_Take_Modules VALUES('1', '5059993', 80.00);
Insert INTO Employees_Take_Modules VALUES('2', '5059993', 90.00);
Insert INTO Employees_Take_Modules VALUES('3', '5059993', 70.00);
Insert INTO Employees_Take_Modules VALUES('4', '5059993', 89.50);
Insert INTO Employees_Take_Modules VALUES('5', '5059993', 89.50);
Insert INTO Employees_Take_Modules VALUES('6', '5059993', 70.00);
Insert INTO Employees_Take_Modules VALUES('7', '5059993', 73.00);
Insert INTO Employees_Take_Modules VALUES('1', '5059994', 82.25);
Insert INTO Employees_Take_Modules VALUES('2', '5059994', 90.33);
Insert INTO Employees_Take_Modules VALUES('3', '5059994', 76.00);
Insert INTO Employees_Take_Modules VALUES('4', '5059994', 83.66);
Insert INTO Employees_Take_Modules VALUES('5', '5059994', 81.50);
Insert INTO Employees_Take_Modules VALUES('6', '5059994', 80.25);
Insert INTO Employees_Take_Modules VALUES('7', '5059994', 70.00);


COMMIT;