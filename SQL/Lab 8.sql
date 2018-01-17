CREATE TABLE employee (
employeeID NUMERIC(5,0) PRIMARY KEY,
employeeFName VARCHAR(30) NOT NULL,
employeeLName VARCHAR(30) NOT NULL,
employeeSalary int
);

CREATE TABLE project (
projectID NUMERIC(4,0) PRIMARY KEY,
projectDesc VARCHAR(200) NOT NULL,
projectStartDate DATETIME DEFAULT getdate(),
projectDuration VARCHAR(30)
);

CREATE TABLE projectAssignment(
employeeID NUMERIC(5,0) FOREIGN KEY REFERENCES employee(employeeID),
projectID NUMERIC(4,0)  FOREIGN KEY REFERENCES project(projectID),
projectRole VARCHAR(20) NOT NULL,
CONSTRAINT projectAssignment_PK PRIMARY KEY (employeeID, projectID)
);

INSERT INTO project (projectID, projectDesc) VALUES (1001, 'new database');
INSERT INTO project VALUES (1002, 'new website', '2010-01-01', 'six months');
INSERT INTO project VALUES (1003, 'new mobile app', '2013-01-01', 'six months');


INSERT INTO employee VALUES (11111, 'James', 'Smith', 30000);
INSERT INTO employee VALUES (11112, 'Ada', 'Zack', 40000);
INSERT INTO employee VALUES (11113, 'Ben', 'Yale', 50000);
INSERT INTO employee VALUES (11114, 'Callen', 'Wales', 60000);
INSERT INTO employee VALUES (11115, 'Dale', 'Veller', 70000);
INSERT INTO employee VALUES (11116, 'Ethan', 'Miller', 80000);
INSERT INTO employee VALUES (11117, 'Fanny', 'Niel', 90000);

INSERT INTO projectAssignment VALUES (11111, 1001, 'manager');
INSERT INTO projectAssignment VALUES (11112, 1001, 'PHP programmer');
INSERT INTO projectAssignment VALUES (11113, 1001, 'Oracle DBA');
INSERT INTO projectAssignment VALUES (11114, 1001, 'quality assurance');
INSERT INTO projectAssignment VALUES (11115, 1001, 'test engineer');
INSERT INTO projectAssignment VALUES (11117, 1001, 'Oracle DBA');
INSERT INTO projectAssignment VALUES (11115, 1002, 'manager');
INSERT INTO projectAssignment VALUES (11116, 1002, 'test engineer');
INSERT INTO projectAssignment VALUES (11117, 1002, 'test engineer');
INSERT INTO projectAssignment VALUES (11113, 1002, 'test engineer');
INSERT INTO projectAssignment VALUES (11114, 1002, 'quality assurance');

SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM projectAssignment;

ALTER TABLE EMPLOYEE
DROP COLUMN NUMPROJECTS

/*1.Add an employee using your own name and create a project assignment for your self using existing project id.*/
INSERT INTO employee VALUES (88888, 'Pan', 'Chen', 10000);
INSERT INTO projectAssignment VALUES (88888, 1001, 'slave');
SELECT * FROM EMPLOYEE;
SELECT * FROM projectAssignment;

/*2.Write a scalar function that returns the average salary of the Employees*/
CREATE FUNCTION average_salary() 
RETURNS DECIMAL(20,2)
AS BEGIN
	DECLARE @avg INT;
	SELECT @avg=AVG(employeeSalary)
	FROM employee
	RETURN @avg;
END;
/*call the scaler function*/
SELECT dbo.average_salary() as 'average';

/*3)	Write a table-valued function that returns the Projects given an EmployeeID as a parameter and 
a.	Show the function created 
b.	return the results for your own project*/
CREATE FUNCTION projecttable(@EmployeeID INT) 
RETURNS TABLE
AS 
RETURN
	(SELECT t1.EmployeeID, t2.projectID, employeeFName, employeeLName
	 ProjectDesc, ProjectStartDate, ProjectDuration, ProjectRole FROM PROJECTASSIGNMENT T1 
	INNER JOIN project t2 ON t1.projectID = t2.projectID
	INNER JOIN employee t3 ON t1.employeeID = t3.employeeID
	WHERE t1.EmployeeID=@EmployeeID);

/*call the table-valued function*/
SELECT * FROM dbo.projecttable(88888);



/*4)	Alter the Employee table to add a new column called ‘Num of Projects’ which can be INTEGER data type.
 Write a procedure that updates employee table with the total projects assigned to each employee
  (to the newly created column)*/


ALTER TABLE EMPLOYEE ADD NumProjects Int;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECTASSIGNMENT;
CREATE PROCEDURE totalprojects
AS
BEGIN
	UPDATE EMPLOYEE
	SET NumProjects = projectcount.count1
	FROM 
	(SELECT EMPLOYEEID, count(projectID) 'count1' FROM projectAssignment
	GROUP BY EMPLOYEEID) AS projectcount
	WHERE EMPLOYEE.EMPLOYEEID = projectcount.employeeID
END;	
	EXEC totalprojects;
	DROP PROCEDURE totalprojects

/*5)	Create a trigger that can update the num of projects whenever a new project is assigned to an employee. 
a.	Test the trigger with the below insert
INSERT INTO projectAssignment VALUES (11114, 1003, ‘quality assurance');
INSERT INTO projectAssignment VALUES (11115, 1003,'test engineer');
*/
CREATE TRIGGER updateprojectnumtrigger
ON Projectassignment
FOR INSERT, UPDATE
AS
IF  @@ROWCount>=1
BEGIN
	UPDATE EMPLOYEE
	SET NumProjects = projectcount.count1
	FROM 
	(SELECT EMPLOYEEID, count(projectID) 'count1' FROM projectAssignment
	GROUP BY EMPLOYEEID) AS projectcount
	WHERE EMPLOYEE.EMPLOYEEID = projectcount.employeeID
END;

SELECT * FROM EMPLOYEE

INSERT INTO projectAssignment VALUES (11114, 1003, 'quality assurance');
INSERT INTO projectAssignment VALUES (11115, 1003, 'test engineer');
