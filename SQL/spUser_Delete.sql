USE DotNetCourseDatabase
GO

CREATE PROCEDURE PraveenSchema.spUser_Delete
    @UserId INT
AS
BEGIN
    DELETE FROM PraveenSchema.Users 
        WHERE UserId = @UserId
        
    DELETE FROM PraveenSchema.UserSalary 
        WHERE UserId = @UserId

    DELETE FROM PraveenSchema.UserJobInfo 
        WHERE UserId = @UserId
END
GO

CREATE OR ALTER PROCEDURE PraveenSchema.spUser_Delete
    @UserId INT
AS
BEGIN
    DECLARE @Email NVARCHAR(50);

    SELECT  @Email = Users.Email
      FROM  PraveenSchema.Users
     WHERE  Users.UserId = @UserId;

    DELETE  FROM PraveenSchema.UserSalary
     WHERE  UserSalary.UserId = @UserId;

    DELETE  FROM PraveenSchema.UserJobInfo
     WHERE  UserJobInfo.UserId = @UserId;

    DELETE  FROM PraveenSchema.Users
     WHERE  Users.UserId = @UserId;

    DELETE  FROM PraveenSchema.Auth
     WHERE  Auth.Email = @Email;
END;
GO