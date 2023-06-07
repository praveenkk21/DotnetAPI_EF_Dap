USE DotNetCourseDatabase;
GO

CREATE OR ALTER PROCEDURE PraveenSchema.spUser_Upsert
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(50),
	@Gender NVARCHAR(50),
	@Active BIT = 1,
	@UserId INT = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM PraveenSchema.Users WHERE UserId = @UserId)
        BEGIN
        IF NOT EXISTS (SELECT * FROM PraveenSchema.Users WHERE Email = @Email)
            BEGIN
                INSERT INTO PraveenSchema.Users(
                    [FirstName],
                    [LastName],
                    [Email],
                    [Gender],
                    [Active]
                ) VALUES (
                    @FirstName,
                    @LastName,
                    @Email,
                    @Gender,
                    @Active
                )
            END
        END
    ELSE 
        BEGIN
            UPDATE PraveenSchema.Users 
                SET FirstName = @FirstName,
                    LastName = @LastName,
                    Email = @Email,
                    Gender = @Gender,
                    Active = @Active
                WHERE UserId = @UserId
        END
END;
GO

CREATE OR ALTER PROCEDURE PraveenSchema.spUser_Upsert
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(50),
	@Gender NVARCHAR(50),
	@JobTitle NVARCHAR(50),
	@Department NVARCHAR(50),
    @Salary DECIMAL(18, 4),
	@Active BIT = 1,
	@UserId INT = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM PraveenSchema.Users WHERE UserId = @UserId)
        BEGIN
        IF NOT EXISTS (SELECT * FROM PraveenSchema.Users WHERE Email = @Email)
            BEGIN
                DECLARE @OutputUserId INT

                INSERT INTO PraveenSchema.Users(
                    [FirstName],
                    [LastName],
                    [Email],
                    [Gender],
                    [Active]
                ) VALUES (
                    @FirstName,
                    @LastName,
                    @Email,
                    @Gender,
                    @Active
                )

                SET @OutputUserId = @@IDENTITY

                INSERT INTO PraveenSchema.UserSalary(
                    UserId,
                    Salary
                ) VALUES (
                    @OutputUserId,
                    @Salary
                )

                INSERT INTO PraveenSchema.UserJobInfo(
                    UserId,
                    Department,
                    JobTitle
                ) VALUES (
                    @OutputUserId,
                    @Department,
                    @JobTitle
                )
            END
        END
    ELSE 
        BEGIN
            UPDATE PraveenSchema.Users 
                SET FirstName = @FirstName,
                    LastName = @LastName,
                    Email = @Email,
                    Gender = @Gender,
                    Active = @Active
                WHERE UserId = @UserId

            UPDATE PraveenSchema.UserSalary
                SET Salary = @Salary
                WHERE UserId = @UserId

            UPDATE PraveenSchema.UserJobInfo
                SET Department = @Department,
                    JobTitle = @JobTitle
                WHERE UserId = @UserId
        END
END
