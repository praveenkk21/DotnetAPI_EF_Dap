CREATE DATABASE PraveenK;
GO

USE PraveenK;
GO

CREATE SCHEMA PraveenSchema;
GO

DROP TABLE IF EXISTS PraveenSchema.Users;

-- IF OBJECT_ID('PraveenSchema.Users') IS NOT NULL
--     DROP TABLE PraveenSchema.Users;

CREATE TABLE PraveenSchema.Users
(
    UserId INT IDENTITY(1, 1) PRIMARY KEY
    , FirstName NVARCHAR(50)
    , LastName NVARCHAR(50)
    , Email NVARCHAR(50)
    , Gender NVARCHAR(50)
    , Active BIT
);

DROP TABLE IF EXISTS PraveenSchema.UserSalary;

-- IF OBJECT_ID('PraveenSchema.UserSalary') IS NOT NULL
--     DROP TABLE PraveenSchema.UserSalary;

CREATE TABLE PraveenSchema.UserSalary
(
    UserId INT
    , Salary DECIMAL(18, 4)
);

DROP TABLE IF EXISTS PraveenSchema.UserJobInfo;

-- IF OBJECT_ID('PraveenSchema.UserJobInfo') IS NOT NULL
--     DROP TABLE PraveenSchema.UserJobInfo;

CREATE TABLE PraveenSchema.UserJobInfo
(
    UserId INT
    , JobTitle NVARCHAR(50)
    , Department NVARCHAR(50),
);

-- USE DotNetCourseDatabase;
-- GO

-- SELECT  [UserId]
--         , [FirstName]
--         , [LastName]
--         , [Email]
--         , [Gender]
--         , [Active]
--   FROM  PraveenSchema.Users;

-- SELECT  [UserId]
--         , [Salary]
--   FROM  PraveenSchema.UserSalary;

-- SELECT  [UserId]
--         , [JobTitle]
--         , [Department]
--   FROM  PraveenSchema.UserJobInfo;