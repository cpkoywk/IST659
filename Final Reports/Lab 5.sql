/*Create the tables*/
CREATE TABLE States
(
stateAbbr VARCHAR(2) PRIMARY KEY,
stateName VARCHAR(20) NOT NULL
);


CREATE TABLE City
(
cityKey CHAR(8) PRIMARY KEY,
cityName VARCHAR(25) NOT NULL,
stateAbbr VARCHAR(2) NOT NULL
);


CREATE TABLE Airport
(
airportID CHAR(3) PRIMARY KEY,
airportName VARCHAR(45) NOT NULL UNIQUE,
cityKey CHAR(8) NOT NULL
);



SELECT * FROM Airport;

CREATE TABLE FlightRoute
(
flightNumber VARCHAR(6) PRIMARY KEY,
departAirport CHAR(3) NOT NULL,
arriveAirport CHAR(3) NOT NULL,
scheduledDepartTime TIME NOT NULL,
scheduledArrivalTime TIME NOT NULL
);

SELECT * FROM FlightRoute;


CREATE TABLE FlightSchedule
(
flightNumber VARCHAR(6) NOT NULL,
flightDATE DATE NOT NULL,
statusID CHAR(1) NOT NULL CHECK(statusID IN ('O', 'd', 'c')),
airplaneID CHAR(8) NOT NULL,
delayDepartTime TIME,
delayArrivalTime TIME,

CONSTRAINT FlightSchedule_PK PRIMARY KEY(flightNumber, flightDATE)
);


CREATE TABLE Status
(
statusID CHAR(1) NOT NULL CHECK(statusID IN ('O', 'd', 'c')),
description VARCHAR(20) NOT NULL,
);

CREATE TABLE Airplane
(
airplaneID CHAR(8) PRIMARY KEY,
aircraftTypeID CHAR(8) NOT NULL,
purchaseDate DATE NOT NULL DEFAULT '01/01/2012'
);

CREATE TABLE AircraftSpecs
(
aircraftTypeID CHAR(8) PRIMARY KEY,
aircraftVersion VARCHAR(10) NOT NULL,
cabinNumOfSeats INT,
fuelCapacity INT NOT NULL

);
/*add FKs*/

ALTER TABLE Airport
ADD CONSTRAINT Airport_FK FOREIGN KEY (cityKey) REFERENCES City(cityKey);
ALTER TABLE FlightRoute
ADD CONSTRAINT departAirport_FK FOREIGN KEY (departAirport) REFERENCES Airport(airportID);
ALTER TABLE FlightRoute
ADD CONSTRAINT arriveAirport_FK FOREIGN KEY (arriveAirport) REFERENCES Airport(airportID);
ALTER TABLE City
ADD CONSTRAINT stateAbbr_FK FOREIGN KEY (stateAbbr) REFERENCES States(stateAbbr);
ALTER TABLE Status
ADD CONSTRAINT Status_PK PRIMARY KEY(StatusID);
ALTER TABLE FlightSchedule
ADD CONSTRAINT statusID_FK FOREIGN KEY (statusID) REFERENCES Status(statusID);
ALTER TABLE FlightSchedule
ADD CONSTRAINT flightNumber_FK FOREIGN KEY (flightNumber) REFERENCES FlightRoute(flightNumber);
ALTER TABLE FlightSchedule
ADD CONSTRAINT airplaneID_FK FOREIGN KEY (airplaneID) REFERENCES Airplane(airplaneID);
ALTER TABLE Airplane
ADD CONSTRAINT aircraftTypeID_FK FOREIGN KEY (aircraftTypeID) REFERENCES AircraftSpecs(aircraftTypeID);


/*Populating*/
INSERT INTO States VALUES ('CA', 'California');
INSERT INTO States VALUES ('DC', 'Washington, D.C.');
INSERT INTO States VALUES ('FL', 'Florida');
INSERT INTO States VALUES ('IL', 'Illinois');
INSERT INTO States VALUES ('MA', 'Massachusetts');
INSERT INTO States VALUES ('NY', 'New York');
INSERT INTO States VALUES ('TX', 'Texas');
SELECT * FROM States;

INSERT INTO City VALUES ('C001', 'Los Angeles', 'CA');
INSERT INTO City VALUES ('C002', 'San Francisco', 'CA');
INSERT INTO City VALUES ('C003', 'Washington. D.C.', 'DC');
INSERT INTO City VALUES ('C004', 'Miami', 'FL');
INSERT INTO City VALUES ('C005', 'Orlando', 'FL');
INSERT INTO City VALUES ('C006', 'Chicago', 'IL');
INSERT INTO City VALUES ('C007', 'Boston', 'MA');
INSERT INTO City VALUES ('C008', 'New York', 'NY');
INSERT INTO City VALUES ('C009', 'Syracuse', 'NY');
SELECT * FROM City;

INSERT INTO Airport VALUES ('BOS', 'Chen', 'C007');
INSERT INTO Airport VALUES ('DCA', 'Ronald Reagan National Airport', 'C003');
INSERT INTO Airport VALUES ('IAD', 'Washington Dulles International Airport', 'C003');
INSERT INTO Airport VALUES ('JFK', 'John F. Kennedy International Airport', 'C008');
INSERT INTO Airport VALUES ('LAX', 'Los Angeles  International Airport', 'C001');
INSERT INTO Airport VALUES ('LGA', 'LaGuardia Airport', 'C008');
INSERT INTO Airport VALUES ('MCO', 'Orlando International Airport', 'C005');
INSERT INTO Airport VALUES ('MDW', 'Chicago Midway International Airport', 'C006');
INSERT INTO Airport VALUES ('MIA', 'Miami International Airport', 'C004');
INSERT INTO Airport VALUES ('ORD', 'Chicago OHare International Airport', 'C006');
INSERT INTO Airport VALUES ('SFO', 'San Francisco International Airport', 'C002');
INSERT INTO Airport VALUES ('SYR', 'Syracuse Hancock International Airport', 'C009');
SELECT * FROM Airport;

INSERT INTO FlightRoute VALUES ('3310', 'SYR', 'JFK', '08:00:00', '09:02:00');
INSERT INTO FlightRoute VALUES ('3312', 'JFK', 'SYR', '12:20:00', '13:30:00');
INSERT INTO FlightRoute VALUES ('3426', 'LAX', 'ORD', '11:15:00', '15:05:00');
INSERT INTO FlightRoute VALUES ('5063', 'BOS', 'MCO', '14:30:00', '18:45:00');
SELECT * FROM FlightRoute;

INSERT INTO Status VALUES ('C', 'Cancelled');
INSERT INTO Status VALUES ('D', 'Delay');
INSERT INTO Status VALUES ('O', 'On Time');
SELECT * FROM Status;

INSERT INTO AircraftSpecs VALUES ('AIR1', 'A321-200', '220', '7930');
INSERT INTO AircraftSpecs VALUES ('AIR2', '737-600ER', '132', '6875');
INSERT INTO AircraftSpecs VALUES ('BOE1', '747-400ER', '416', '63705');
INSERT INTO AircraftSpecs VALUES ('BOE2', '767-300ER', '350', '23980');
INSERT INTO AircraftSpecs VALUES ('BOE3', '737-600ER', '132', '6875');
SELECT * FROM AircraftSpecs;

INSERT INTO Airplane VALUES ('AP098640', 'AIR2', '2013-03-01');
INSERT INTO Airplane VALUES ('AP239471', 'AIR1', '1900-01-01');
INSERT INTO Airplane VALUES ('AP309814', 'BOE2', '2012-05-22');
INSERT INTO Airplane VALUES ('AP629342', 'BOE1', '1900-01-01');
INSERT INTO Airplane VALUES ('AP872139', 'BOE3', '1900-01-01');
INSERT INTO Airplane VALUES ('AP998911', 'BOE2', '1900-01-01');
SELECT * FROM Airplane;

INSERT INTO FlightSchedule (flightNumber, flightDate, statusID, airplaneID) VALUES ('3310', '2014-02-10', 'O', 'AP629342');
INSERT INTO FlightSchedule (flightNumber, flightDate, statusID, airplaneID) VALUES ('3310', '2014-02-11', 'O', 'AP629342');
INSERT INTO FlightSchedule (flightNumber, flightDate, statusID, airplaneID) VALUES ('3312', '2014-02-10', 'O', 'AP872139');
INSERT INTO FlightSchedule (flightNumber, flightDate, statusID, airplaneID) VALUES ('3426', '2014-02-12', 'O', 'AP239471');
INSERT INTO FlightSchedule VALUES ('5063', '2014-02-13', 'O', 'AP309814', '15:40:00', '20:05:00');
SELECT * FROM FlightSchedule;