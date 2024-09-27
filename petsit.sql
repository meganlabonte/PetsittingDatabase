-- -- Creating and using my database, PetSittingBusiness
-- CREATE DATABASE PetSittingBusiness;
USE PetSittingBusiness;

-- -- I create three pet tables, a customer table, and a pet sit table to ensure normalisation. 
-- -- I use NOT NULL and CHECK constraints alongside PRIMARY and FOREIGN KEY. 
-- -- NOT NULL ensures there must be a value, CHECK ensures the value must meet a certain condition.
-- -- I use various datatypes including VARCHAR, DECIMAL and INT.
-- CREATE TABLE Dog (
--     id INT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     weight DECIMAL(5, 2) CHECK (weight > 0),
--     age INT,
--     allergens VARCHAR(100)
-- );

-- CREATE TABLE Cat (
--     id INT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     weight DECIMAL(5, 2) CHECK (weight > 0),
--     age INT,
--     allergens VARCHAR(100)
-- );

-- CREATE TABLE Hamster (
--     id INT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     weight DECIMAL(5, 2) CHECK (weight > 0),
--     age INT,
--     allergens VARCHAR(100)
-- );

-- -- 
-- CREATE TABLE Customer (
--     id INT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     pet_type VARCHAR(10),
--     pet_id INT,
--     CONSTRAINT fk_dog FOREIGN KEY (pet_id) REFERENCES Dog(id),
--     CONSTRAINT fk_cat FOREIGN KEY (pet_id) REFERENCES Cat(id),
--     CONSTRAINT fk_hamster FOREIGN KEY (pet_id) REFERENCES Hamster(id)
-- );

-- CREATE TABLE PetSit (
--     id INT PRIMARY KEY,
--     customer_id INT,
--     week INT,
--     date_start DATE NOT NULL,
--     date_finish DATE NOT NULL,
--     price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
--     CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customer(id)
-- );

-- -- Inserting data into each table
-- INSERT INTO Dog (id, name, weight, age, allergens) VALUES
-- (1, 'Buddy', 25.5, 3, 'None'),
-- (2, 'Rex', 30.0, 5, 'Peanuts'),
-- (3, 'Bella', 20.2, 2, 'None'),
-- (4, 'Max', 27.5, 4, 'Grass'),
-- (5, 'Daisy', 22.8, 3, 'None'),
-- (6, 'Rocky', 28.3, 6, 'None'),
-- (7, 'Luna', 23.1, 1, 'Dust'),
-- (8, 'Molly', 26.2, 4, 'None');

-- INSERT INTO Cat (id, name, weight, age, allergens) VALUES
-- (1, 'Whiskers', 10.5, 2, 'Fish'),
-- (2, 'Shadow', 11.0, 3, 'None'),
-- (3, 'Simba', 9.2, 1, 'Grass'),
-- (4, 'Leo', 10.0, 4, 'None'),
-- (5, 'Lily', 8.8, 2, 'Grain'),
-- (6, 'Milo', 11.3, 5, 'None'),
-- (7, 'Cleo', 9.1, 3, 'Dust'),
-- (8, 'Nala', 10.2, 4, 'None');

-- INSERT INTO Hamster (id, name, weight, age, allergens) VALUES
-- (1, 'Nibbles', 0.5, 1, 'None'),
-- (2, 'Fuzz', 0.6, 2, 'Peanuts'),
-- (3, 'Squeaky', 0.4, 1, 'None'),
-- (4, 'Chewy', 0.7, 3, 'Grass'),
-- (5, 'Fluffy', 0.5, 2, 'None'),
-- (6, 'Puff', 0.6, 3, 'Grain'),
-- (7, 'Twitch', 0.5, 1, 'Dust'),
-- (8, 'Whisk', 0.6, 2, 'None');

-- -- I later drop the pet_type column as it is not accurate/not needed
-- INSERT INTO Customer (id, name, pet_type, pet_id) VALUES
-- (1, 'John Doe', 'Dog', 1),
-- (2, 'Jane Smith', 'Cat', 2),
-- (3, 'Emily Davis', 'Hamster', 3),
-- (4, 'Michael Brown', 'Dog', 4),
-- (5, 'Sarah Wilson', 'Cat', 5),
-- (6, 'David Johnson', 'Hamster', 6),
-- (7, 'Laura Martinez', 'Dog', 7),
-- (8, 'James Garcia', 'Cat', 8);

-- INSERT INTO PetSit (id, customer_id, week, date_start, date_finish, price) VALUES
-- (1, 1, 23, '2024-06-03', '2024-06-10', 100.00),
-- (2, 2, 24, '2024-06-11', '2024-06-18', 120.00),
-- (3, 3, 25, '2024-06-19', '2024-06-26', 80.00),
-- (4, 4, 26, '2024-06-27', '2024-07-04', 110.00),
-- (5, 5, 27, '2024-07-05', '2024-07-12', 130.00),
-- (6, 6, 28, '2024-07-13', '2024-07-20', 90.00),
-- (7, 7, 29, '2024-07-21', '2024-07-28', 105.00),
-- (8, 8, 30, '2024-07-29', '2024-08-05', 115.00);

-- -- Queries to retrieve data
-- -- View all customers:
-- SELECT* 
-- FROM customer
-- ORDER BY name ASC;

-- -- 2 aggregate functions, SUM and MIN
-- -- To see the total price for all my petsits:
-- SELECT SUM(price) AS total_price
-- FROM PetSit;

-- -- To see when my next pet sit is:
-- SELECT MIN(date_start) AS next_sit
-- FROM PetSit;

-- -- To view cat sizes for feeding requirements:
-- SELECT weight
-- FROM cat
-- ORDER BY weight DESC;

-- -- JOIN Example to show which customer has which hamster:
-- SELECT Customer.name AS customer_name, Hamster.name AS hamster_name
-- FROM Customer
-- INNER JOIN Hamster
-- ON Customer.pet_id = Hamster.id
-- ORDER BY hamster_name ASC; -- order by alphabetical name

-- -- After doing the above join I realised the pet_type column was not needed, as I had already given each customer one of each pet type.
-- -- As each table requires 8 rows of data per table I made the decision to drop the column.
-- ALTER TABLE Customer
-- DROP COLUMN pet_type;
-- SELECT* FROM customer;

-- Example of deleting a customer who no longer needs my services:
-- DELETE FROM customer
-- WHERE customer.id = 4;

-- -- Stored procedure to be used in the event a pet sit needs to be resheduled:
-- DELIMITER // -- delimiter to ignore ; within procedure
-- CREATE PROCEDURE ReshedulePetSit (
-- 	INT customerID INT,
--     IN newStartDate DATE,
--     IN newEndDate DATE
-- )
-- BEGIN 
-- 	UPDATE PetSit
--     SET date_start = newStartDate, date_finish = newEndDate
--     WHERE customer_id = customerId;
-- END //
-- DELIMITER ;

-- -- Calling the procedure. 
-- CALL ReschedulePetSit(1, '2024-08-01', '2024-08-10');

-- Creative use: I have created this database to log my customers, their pets, and their petsit dates for my pet sitting business. 
-- I want to effectively view pet details, customer names, and petsitting dates. I want to be able to easily update sits should they need rescheduling.
-- John Doe has informed me that he needs to reschedule his holiday due to his pet needing a trip to the vets. 
-- I need to retrieve johns details and update the database with his new holiday dates of '2024-08-01' - '2024-08-10'.

-- SELECT p.date_start, p.date_finish, c.name AS customer_name
-- FROM Customer AS c
-- INNER JOIN Petsit AS p
-- ON c.id = p.customer_id
-- WHERE name = 'John Doe';

-- CALL ReschedulePetSit(1, '2024-08-01', '2024-08-10');




