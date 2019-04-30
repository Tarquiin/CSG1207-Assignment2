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

PRINT 'Database created.'

GO

--  Make database active.

USE airline;

GO








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

INSERT INTO country (country_code, country_name)
VALUES ('AU', 'Australia'),
	   ('NZ', 'New Zealand'),
	   ('IN', 'India'),
	   ('CN', 'China');




/*	The following statement inserts the details of 5 airports into a table named "airport". 
    It specifies values for 5 columns:  Airport code, airport name, latitude, longitude and country code.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.world-airport-codes.com/
*/

INSERT INTO airport (airport_code, airport_name, latitude, longitude, country_code)
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

INSERT INTO model (model_num, manufacturer, travel_range, cruise_speed)
VALUES	('A340 300',	'Airbus',	13705,	896), 
		('A380 800',	'Airbus',	16112,	1088), 
		('737 600',		'Boeing',	5649,	827), 
		('777 200LR',	'Boeing',	17500,	945);




/*	The following statement inserts the details of 6 planes into a table named "plane". 
    It specifies values for 6 columns:  Registration number, model number, build year and first, business and economy class passenger capacities.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	Seating capacities were sourced from https://www.seatguru.com/ (note that the data below includes two A380 800s and two 777 200LRs, with different seating layouts).
*/

INSERT INTO plane (rego_num, model_num, build_year, first_capacity, bus_capacity, econ_capacity)
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