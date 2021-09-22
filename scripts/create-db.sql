-- Create a new database called 'motfDb'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'motfDb'
)
CREATE DATABASE motfDb
GO

USE motfDb
GO

IF OBJECT_ID('Inventory', 'U') IS NOT NULL
BEGIN 
    DROP TABLE Inventory
END
GO

-- Create the table in the specified schema
CREATE TABLE Inventory
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    name [NVARCHAR](50) NOT NULL,
    quantity INT NOT NULL
);
GO

INSERT INTO Inventory VALUES(1, 'banana', 150); 
INSERT INTO Inventory VALUES(2, 'orange', 120); 
INSERT INTO Inventory VALUES(3, 'apple', 90);
GO