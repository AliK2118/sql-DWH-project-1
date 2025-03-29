/*
============================================================================================
Database and Schema Creation
============================================================================================ 
Purpose of this Script:
  This script checks whether a database called 'DataWarehouse' exists, and drops it if it does. The database is eventaully recreated. 
 The script further creates thress schemas with the database namely: 'bronze', 'silver' and 'gold'.

WARNING:
When run, the script will drop the entire 'DataWarehouse' database if it exists. This means that all the data present in the databse
will be lost permanently.
Proceed cautiously and ensure you have proper backups before you run this script

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
GO

USE DataWarehouse;
GO

--Creating the database Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
