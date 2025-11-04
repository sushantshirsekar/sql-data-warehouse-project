/*
============================================
Create Database and Schemas
============================================

Script Purpose :
This script creates a fresh SQL data warehouse environment by setting up
the main database 'DataWarehouse' and its core schemas — Bronze, Silver, and Gold.
It ensures a clean start for the Medallion Architecture setup.

Warning :
Running this script will DROP the existing 'DataWarehouse' database if it already exists.
All existing data and objects within it will be permanently deleted.
Execute only in a safe or development environment.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

USE DataWarehouse; 
GO

-- Create Schemas 
CREATE SCHEMA bronze
GO

CREATE SCHEMA silver
GO

CREATE SCHEMA gold
GO
