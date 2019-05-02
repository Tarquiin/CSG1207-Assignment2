-- Student Number(s): 10462621, 10480106 	
-- Student Name(s): Rob Brownin, Tarquin Bick		

/*	Database Creation & Population Script (8 marks)
	Produce a script to create the database you designed in Task 1 (incorporating any changes you have made since then).  
	Be sure to give your columns the same data types, properties and constraints specified in your data dictionary, and be sure to name tables and columns consistently.  
	Include any logical and correct default values and any check or unique constraints that you feel are appropriate.

	Make sure this script can be run multiple times without resulting in any errors (hint: drop the database if it exists before trying to create it).  
	You can use/adapt the code at the start of the creation scripts of the sample databases available in the unit materials to implement this.

	See the assignment brief for further information. 
*/


-- Write your creation script here

-- Check if the database exists, and drop it if it does.

IF DB_ID('airline') IS NOT NULL             
	BEGIN
		PRINT 'Database exists. Dropping....';
		
		USE master;		
		ALTER DATABASE airline SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE airline;
	END

GO

--  Create new database.

PRINT 'Creating database.....';

CREATE DATABASE airline;


GO

--  Make database active.

USE airline;

GO

-- Create databse tables

-- Country table, stores details about countries. 
CREATE TABLE Country
(    CountryCode CHAR(3) NOT NULL PRIMARY KEY,
     CountryName VARCHAR(60) NOT NULL
)
-- Airport table, stores details abour airports. 
CREATE TABLE Airport
(    IATAcode CHAR(3) NOT NULL PRIMARY KEY,
     CountryCode CHAR(3) NOT NULL FOREIGN KEY REFERENCES Country(CountryCode),
     AirportName VARCHAR(60) NOT NULL,
	 Latitude DECIMAL(9,6) NOT NULL,
	 Longitude DECIMAL(9,6) NOT NULL
)
-- Flight_Path table, stores details about flight paths.
CREATE TABLE Flight_Path
(    FlightPathNum VARCHAR(10) NOT NULL PRIMARY KEY,
     DepartureAirport CHAR(3) NOT NULL FOREIGN KEY REFERENCES Airport(IATAcode),
	 ArrivalAirport CHAR(3) NOT NULL FOREIGN KEY REFERENCES Airport(IATAcode),
	 Distance SMALLINT NOT NULL
)
-- Attendee table, stores details of flight attendants. 
CREATE TABLE Attendee
(    AttendeeID SMALLINT NOT NULL IDENTITY PRIMARY KEY,
     Mentor SMALLINT NULL FOREIGN KEY REFERENCES Attendee(AttendeeID),
	 FirstName VARCHAR(15) NOT NULL,
	 LastName VARCHAR(15) NOT NULL,
	 Language VARCHAR(40) NOT NULL
)
-- Model table, stores plane model details.
CREATE TABLE Model
(    ModelNum VARCHAR(9) NOT NULL PRIMARY KEY,
     ManufacturerName VARCHAR(20) NOT NULL,
	 TravelRange SMALLINT NOT NULL,
	 CruisingSpeed SMALLINT NOT NULL,
)
-- Plan table, stores details of planes. 
CREATE TABLE Plane
(    RegoNum VARCHAR(6) NOT NULL PRIMARY KEY,
     ModelNum VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Model(ModelNum),
	 BuildYear SMALLINT NOT NULL,
	 FirstClassCap TINYINT NOT NULL DEFAULT(0),
	 BusinessClassCap TINYINT NOT NULL DEFAULT(0),
	 EconomyClassCap SMALLINT NOT NULL
)
-- Pilot table, stores pilots details. 
CREATE TABLE Pilot
(    PilotiD SMALLINT NOT NULL IDENTITY PRIMARY KEY,
     FirstName VARCHAR(15) NOT NULL,
	 LastName VARCHAR(15) NOT NULL,
	 HireDate DATE NOT NULL
)
-- Qualified table, stores details of pilots qualifications.
CREATE TABLE Qualified
(    PilotID SMALLINT NOT NULL FOREIGN KEY REFERENCES Pilot(PilotID),
     ModelNum VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Model(ModelNum),
	 PRIMARY KEY (PilotID, ModelNum)
)
-- Flight_Instance tavble, stores details of flight instances.
CREATE TABLE Flight_Instance
(    FlightInstanceID BIGINT NOT NULL IDENTITY PRIMARY KEY,
     RegoNum VARCHAR(6) NOT NULL FOREIGN KEY REFERENCES Plane(RegoNum),
	 AttendeeID SMALLINT NOT NULL FOREIGN KEY REFERENCES Attendee(AttendeeID),
	 FlightPathNum VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Flight_Path(FlightPathNum),
	 PilotID SMALLINT NOT NULL FOREIGN KEY REFERENCES Pilot(PilotID),
	 CoPilotID SMALLINT NOT NULL FOREIGN KEY REFERENCES Pilot(PilotID),
	 DateTimeLeave DATETIME NOT NULL,
	 DateTimeArrive DATETIME NOT NULL
)
-- Flight_Crew table, stores details of the flight crew.
CREATE TABLE Flight_Crew
(    AttendeeID SMALLINT NOT NULL FOREIGN KEY REFERENCES Attendee(AttendeeID),
     FlightInstanceID BIGINT NOT NULL FOREIGN KEY REFERENCES Flight_Instance(FlightInstanceID),
	 PRIMARY KEY (AttendeeID, FlightInstanceID)
);
     
    

/*	Database Population Statements
	Following the SQL statements to create your database and its tables, you must include statements to populate the database with sufficient test data.
	Make sure referential integrity is observed – you cannot add data to a column with a foreign key constraint if you do not yet have data in the column it references.

	You may wish to start working on your views and queries and write INSERT statements that add the data needed to test each one as you go.   
	The final create.sql should be able to create your database and populate it with enough data to make sure that all views and queries return meaningful results.

	Since writing sample data is time-consuming and quite tedious, I have provided data for several of the tables below.
	Adapt the INSERT statements as needed, and write your own INSERT statements for the remaining tables at the end of the file.
*/





/*  The following statement inserts the details of 4 countries into a table named "country".
    It specifies values for 2 columns:  Country code and country name.
	Make sure that the columns in your country table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.nationsonline.org/oneworld/country_code_list.htm
*/

INSERT INTO Country (CountryCode, CountryName)
VALUES ('AU', 'Australia'),
	   ('NZ', 'New Zealand'),
	   ('IN', 'India'),
	   ('CN', 'China');




/*	The following statement inserts the details of 5 airports into a table named "airport". 
    It specifies values for 5 columns:  Airport code, airport name, latitude, longitude and country code.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.world-airport-codes.com/
*/

INSERT INTO Airport (IATAcode, AirportName, Latitude, Longitude, CountryCode)
VALUES ('PER', 'Perth International Airport',					-31.9403,		115.9670029,	'AU'),
	   ('SYD', 'Sydney Kingsford Smith International Airport',	-33.9460983,	151.177002,		'AU'),
	   ('AKL', 'Auckland International Airport',				-37.0080986,	174.7920074,	'NZ'),
	   ('DEL', 'Indhira Gandhi International Airport',			28.5664997,		77.1031036,		'IN'),
	   ('PEK', 'Beijing Capital International Airport',			40.080101,		116.5849991,	'CN'); 




/*	The following statement inserts the details of 4 plane models into a table named "model". 
    It specifies values for 4 columns:  Model number, manufacturer name, travel range in kms and cruise speed in km/h.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.aircraftcompare.com/ (Jumbo and Mid Size Passenger Jets categories)
*/

INSERT INTO Model (ModelNum, ManufacturerName, TravelRange, CruisingSpeed)
VALUES	('A340 300',	'Airbus',	13705,	896), 
		('A380 800',	'Airbus',	16112,	1088), 
		('737 600',		'Boeing',	5649,	827), 
		('777 200LR',	'Boeing',	17500,	945);




/*	The following statement inserts the details of 6 planes into a table named "plane". 
    It specifies values for 6 columns:  Registration number, model number, build year and first, business and economy class passenger capacities.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	Seating capacities were sourced from https://www.seatguru.com/ (note that the data below includes two A380 800s and two 777 200LRs, with different seating layouts).
*/

INSERT INTO plane (RegoNum, ModelNum, BuildYear, FirstClassCap, BusinessClassCap, EconomyClassCap)
VALUES  ('VH-ABC', 'A340 300',	2010,   40, 28, 179),
		('VH-DEF', 'A380 800',	2013,   14, 64, 406),
		('VH-GHI', 'A380 800',	2016,   0,  58, 557),
		('VH-JKL', '737 600',	1998,   0,  12, 101),
		('VH-MNO', '777 200LR',	2008,   8,  35, 195),
		('VH-PQR', '777 200LR', 2012,   8,  42, 216);

		


-- Write the insert statements to add data to the rest of the tables here.
-- You are responsible for coming up with the data for these tables - see the assignment brief for further details.

-- For realistic data regarding distances and flight times between airports, use https://www.airmilescalculator.com/
-- Remember that you do not need to create a lot of data and it does not need to be realistic or comprehensive.