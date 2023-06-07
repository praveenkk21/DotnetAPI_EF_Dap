USE DotNetCourseDatabase;
GO

CREATE OR ALTER PROCEDURE PraveenSchema.spUsers_Get
/*EXEC PraveenSchema.spUsers_Get @UserId=3*/
    @UserId INT = NULL
AS
BEGIN
    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.Department,
        UserJobInfo.JobTitle
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END;
GO

CREATE OR ALTER PROCEDURE PraveenSchema.spUsers_Get
/*EXEC PraveenSchema.spUsers_Get @UserId=3*/
    @UserId INT = NULL
AS
BEGIN
    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.Department,
        UserJobInfo.JobTitle,
        AvgSalary.AvgSalary
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        OUTER APPLY (
            SELECT AVG(UserSalary2.Salary) AvgSalary
            FROM PraveenSchema.Users AS Users 
                LEFT JOIN PraveenSchema.UserSalary AS UserSalary2
                    ON UserSalary2.UserId = Users.UserId
                LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo2
                    ON UserJobInfo2.UserId = Users.UserId
                WHERE UserJobInfo2.Department = UserJobInfo.Department
                GROUP BY UserJobInfo2.Department
            ) AS AvgSalary
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
END;
GO


ALTER PROCEDURE PraveenSchema.spUsers_Get
/*EXEC PraveenSchema.spUsers_Get @UserId=3*/
    @UserId INT = NULL
    , @Active BIT = NULL
AS
BEGIN
    -- IF OBJECT_ID('tempdb..#AverageDeptSalary', 'U') IS NOT NULL
    --     BEGIN
    --         DROP TABLE #AverageDeptSalary
    --     END

    DROP TABLE IF EXISTS #AverageDeptSalary

    SELECT UserJobInfo.Department
        , AVG(UserSalary.Salary) AvgSalary
        INTO #AverageDeptSalary
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        GROUP BY UserJobInfo.Department

    CREATE CLUSTERED INDEX cix_AverageDeptSalary_Department ON #AverageDeptSalary(Department)

    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.Department,
        UserJobInfo.JobTitle,
        AvgSalary.AvgSalary
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        LEFT JOIN #AverageDeptSalary AS AvgSalary
            ON AvgSalary.Department = UserJobInfo.Department
        -- OUTER APPLY (
        --     SELECT AVG(UserSalary2.Salary) AvgSalary
        --     FROM PraveenSchema.Users AS Users 
        --         LEFT JOIN PraveenSchema.UserSalary AS UserSalary2
        --             ON UserSalary2.UserId = Users.UserId
        --         LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo2
        --             ON UserJobInfo2.UserId = Users.UserId
        --         WHERE UserJobInfo2.Department = UserJobInfo.Department
        --         GROUP BY UserJobInfo2.Department
        --     ) AS AvgSalary
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
            AND ISNULL(Users.Active, 0) = COALESCE(@Active, Users.Active, 0)
END
GO

ALTER PROCEDURE PraveenSchema.spUsers_Get
/*EXEC PraveenSchema.spUsers_Get @UserId=3*/
    @UserId INT = NULL
    , @Active BIT = NULL
AS
BEGIN
    DROP TABLE IF EXISTS #AverageDeptSalary
    -- IF OBJECT_ID('tempdb..#AverageDeptSalary') IS NOT NULL
    --     DROP TABLE #AverageDeptSalary;

    SELECT UserJobInfo.Department
        , AVG(UserSalary.Salary) AvgSalary
        INTO #AverageDeptSalary
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        GROUP BY UserJobInfo.Department

    CREATE CLUSTERED INDEX cix_AverageDeptSalary_Department ON #AverageDeptSalary(Department)

    SELECT [Users].[UserId],
        [Users].[FirstName],
        [Users].[LastName],
        [Users].[Email],
        [Users].[Gender],
        [Users].[Active],
        UserSalary.Salary,
        UserJobInfo.Department,
        UserJobInfo.JobTitle,
        AvgSalary.AvgSalary
    FROM PraveenSchema.Users AS Users 
        LEFT JOIN PraveenSchema.UserSalary AS UserSalary
            ON UserSalary.UserId = Users.UserId
        LEFT JOIN PraveenSchema.UserJobInfo AS UserJobInfo
            ON UserJobInfo.UserId = Users.UserId
        LEFT JOIN #AverageDeptSalary AS AvgSalary
            ON AvgSalary.Department = UserJobInfo.Department
        WHERE Users.UserId = ISNULL(@UserId, Users.UserId)
            AND ISNULL(Users.Active, 0) = COALESCE(@Active, Users.Active, 0)
END

