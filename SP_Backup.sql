USE GLOBANT_DB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- DATABASE TABLES BACKUP CREATION
-- =============================================

Alter PROCEDURE DBbackup

@name VARCHAR(MAX) = 'GLOBANT_BKP'
AS
BEGIN

DECLARE @path VARCHAR(256)
DECLARE @fileName VARCHAR(256)
DECLARE @fileDate VARCHAR(20)

SET @path = 'C:\Data\GLOBANT\Backup\'

-- specify filename format
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112)

BEGIN
SET @fileName = @path + @name + '_' + @fileDate + '.BAK'
BACKUP DATABASE @name TO DISK = @fileName
END
END
GO

Likewise just pass names of db’s to stored procedure to create backup.
EXEC [DBbackup] 'GLOBANT_DB'