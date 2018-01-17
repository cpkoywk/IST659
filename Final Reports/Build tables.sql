CREATE TABLE Patient
(
PatientID CHAR(20) PRIMARY KEY,
PFirstName VARCHAR(30) NOT NULL,
PLastName VARCHAR(30) NOT NULL,
PAddress VARCHAR(50) NOT NULL,
PPhone VARCHAR(20) NOT NULL,
PEmail VARCHAR(30),
PGender VARCHAR(8) NOT NULL,
PSSN CHAR(9),
PDOB DATE NOT NULL,
TotalClaims Int,
TotalOwedMoney Int,
);
/*Populate Patient Table*/
INSERT INTO Patient VALUES('3', 'Chris', 'Paul', '213 Staples Center', '2131234567', 'cp3@lac.com',
'male', '333333333', '1982/10/13', Null, Null);

Select * from patient
select * from staff

CREATE TABLE Insurance
(
PolicyNo CHAR(15) PRIMARY KEY,
PatientID CHAR(20) NOT NULL,
InsCompany VARCHAR(30) NOT NULL,
InsProgram VARCHAR(30),
InsAddress VARCHAR(50) NOT NULL,
InsPhoneNo VARCHAR(20) NOT NULL,
InsEmail VARCHAR(30) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
CONSTRAINT PatientID_FK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Visit
(
VisitID CHAR(15) PRIMARY KEY,
PatientID CHAR(20) NOT NULL,
VisitType VARCHAR(20) NOT NULL,
VisitDesc VARCHAR(200) NOT NULL,
VisitDate DATE NOT NULL,
VisitTime TIME NOT NULL,
CONSTRAINT PatientID_FK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Staff
(
StaffID CHAR(15) PRIMARY KEY,
StaffFName VARCHAR(20) NOT NULL,
StaffLName VARCHAR(20) NOT NULL,
StaffPhoneNo VARCHAR(20) NOT NULL,
StaffEmail VARCHAR(30) NOT NULL,
);

CREATE TABLE ClaimStatus
(
StatusID CHAR(15) PRIMARY KEY,
StatusDesc VARCHAR(15) NOT NULL CHECK(statusDesc IN ('S', 'D', 'N', 'P')),
StatusDetail VARCHAR(200) NOT NULL
);


CREATE TABLE Claim
(
ClaimNo CHAR(15) PRIMARY KEY,
PolicyNo CHAR(15) NOT NULL,
VisitID CHAR(15) NOT NULL,
StatusID CHAR(15) NOT NULL,
StaffID CHAR(15) NOT NULL,
ClaimDate DATE NOT NULL,
SentDate DATE, 
SettleDate DATE,
AmtClaimed DECIMAL(10,2) NOT NULL,/*this is required*/
AmtPaidByIns DECIMAL(10,2),
AmtPaidByPatient DECIMAL(10,2),
AmtOwedByPatient AS AmtClaimed - AmtPaidByIns - AmtPaidByPatient,
CONSTRAINT PolicyNo_FK FOREIGN KEY (PolicyNo) REFERENCES Insurance(PolicyNo),
CONSTRAINT VisitID_FK FOREIGN KEY (VisitID) REFERENCES Visit(VisitID),
CONSTRAINT StatusID_FK FOREIGN KEY (StatusID) REFERENCES ClaimStatus(StatusID),
CONSTRAINT StaffID_FK FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
);



/*calculate how many claims did a particular patient file,
 how much money he/she paid and how much he/she owes the clinic*/

CREATE PROCEDURE totalOwedMoney
AS
BEGIN
	UPDATE Patient
	SET TotalOwedMoney = totalowed.count2
	FROM 
	(Select pat.PatientID, sum(amtowedbypatient) AS "count2" from Patient pat
INNER JOIN INSURANCE INS
ON pat.patientID=Ins.patientID
Inner Join Claim cl
ON INS.policyNo=cl.policyNo
GROUP BY pat.PatientID)
AS totalowed
	WHERE patient.patientiD = totalowed.patientID
END;	

	EXEC totalOwedMoney;

/* Alter the STAFF table to add a new column called ‘Num of Claims’ which can be INTEGER data type.
 Write a procedure that updates staff table with the total claims handled by each staff member
 */
CREATE PROCEDURE totalclaimsStaff
AS
BEGIN
	UPDATE staff
	SET NumClaims = totalclaims.count1
	FROM 
	(Select sta.StaffID, Count(claimNo) 'count1' from Staff sta
Inner Join Claim cl
ON cl.staffid=sta.staffid
GROUP BY sta.staffID) AS totalclaims
	WHERE staff.staffiD = totalclaims.staffID
END;	

	EXEC totalclaimsStaff;



/*total claims filed by a particular patient*/

UPDATE patient
SET Totalclaims = claims.count2
FROM(
Select pat.PatientID, Count(claimNo) AS "count2" from Patient pat
INNER JOIN INSURANCE INS
ON pat.patientID=Ins.patientID
Inner Join Claim cl
ON INS.policyNo=cl.policyNo
GROUP BY pat.PatientID) as claims

/*trigger updated the number of claims for the patient when a new claim is filed*/
CREATE TRIGGER claimsfiled
ON claim
FOR INSERT, UPDATE, DELETE
AS
IF  @@ROWCount>=0
BEGIN	
UPDATE PATIENT
SET Totalclaims = claimcount.count1
FROM 
(Select pat.PatientID, Count(claimNo) AS "count1" from Patient pat
INNER JOIN INSURANCE INS
ON pat.patientID=Ins.patientID
Inner Join Claim cl
ON INS.policyNo=cl.policyNo
GROUP BY pat.PatientID) AS claimcount
END;


INSERT INTO CLAIM (CLAIMNO, policyno,visitID,StatusID,StaffID,Claimdate,sentdate,AmtClaimed,AmtPaidByIns,AmtPaidByPatient)
 values('5', '10002', '13', '125','67890','2017-09-10','2017-09-10',300,250,0);



SELECT * FROM claim
Select * from patient
select * from visit

/*Test the trigger with the below Delete
DELETE FROM Claim
WHERE claimNo=3*/

/*Populate the ClaimStatus Table*/
Insert INTO ClaimStatus VALUES ('P1','P','Insurance company has paid, waiting for the patient Payment');
Insert INTO ClaimStatus VALUES ('S1','S','Both insurance company and patient have paid');
Insert INTO ClaimStatus VALUES ('D1','D','the insurance company only agrees to pay 50% of the amount');
Insert INTO ClaimStatus VALUES ('N1','N','the claim is not filed yet due to large volume of work');

/*insert into 

/*populate the insurance policies*/
Insert INTO  VALUES ('N1','N','the claim is not filed yet due to large volume of work');

SELECT * FROM ClaimStatus