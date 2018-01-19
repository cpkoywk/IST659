select * FROM AircraftSpecs;

/*add column cabinNumber*/
ALTER TABLE AircraftSpecs
ADD cabinNumber INT;

/*Update AircraftSpecs data*/
UPDATE AircraftSpecs
SET fuelCapacity =73705
WHERE fuelCapacity =63705;

select * FROM FlightSchedule;

/*view all the FlightSchedule info of flight 3310*/
SELECT * FROM FlightSchedule
WHERE flightNumber = 3310;

/*Find all flights departing from LAX airport. Show flight number, arrival airport, 
and depart time.*/
SELECT flightNumber, arriveAirport, scheduledDepartTime
FROM flightRoute
WHERE departAirport LIKE 'LAX';

/*Find all planes purchased in March 2013. Show airplane ID and purchase date only.*/
SELECT airplaneID, purchaseDate
FROM Airplane
WHERE purchaseDate LIKE '2013-03%';

UPDATE FlightSchedule
SET statusID='D'
WHERE flightNumber=5063;


/*	Find all flights that are of status “Delay”. 
Show flight number, flight date, and delay arrive time only.*/
SELECT flightNumber, flightDATE, delayArrivalTime 
FROM FlightSchedule
WHERE statusID='D';

/*Find all aircraft types whose number of seats is less than 250. 
Show aircraft version only.*/
SELECT aircraftVersion
FROM AircraftSpecs
WHERE cabinNumOfSeats < 250;

/*Count the number of flights departing each day. Show the date and the number of flights. */
SELECT flightDate, COUNT(flightDate) as totalFlights
FROM FlightSchedule
GROUP BY flightDate;

/*Sort AircraftSpecs table by fuel capacity in ascending order. 
 Show the result with aircraft version and fuel capacity. */
SELECT aircraftVersion, fuelCapacity
FROM AircraftSpecs
ORDER BY fuelCapacity ASC;

/* Calculate the average, min, and max value of cabin seats numbers for aircraft spec. 
 Show average seat numbers, min seat numbers, and max seat numbers.*/
SELECT AVG (cabinNumOfSeats) as AvgNumOfSeats, MIN(cabinNumOfSeats) as MinNumOfSeats, 
Max (cabinNumOfSeats) as MaxNumOfSeats
FROM AircraftSpecs;

 /*Show the average fuel capacity of airplanes from Boeing and Airbus separately. */
 SELECT AVG (fuelCapacity) as BOEAvgFuelCapacity
 FROM AircraftSpecs
 where aircraftTypeID LIKE 'BOE%'
 SELECT AVG (fuelCapacity) as AIRAvgFuelCapacity
 FROM AircraftSpecs
 where aircraftTypeID LIKE 'AIR%'

 Select *
 FROM FlightSchedule
/*Show how many flight are delayed and how many flights are on time*/
SELECT statusID, COUNT(statusID) as NoFlights
FROM FlightSchedule
GROUP BY statusID;

/*Show how many flight are on time from different flights*/
SELECT flightNumber, COUNT(statusID) as NoFlightsOnTime
FROM FlightSchedule
WHERE statusID = 'O'
GROUP BY flightNumber;


