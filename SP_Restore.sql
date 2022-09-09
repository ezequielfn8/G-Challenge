USE GLOBANT_DB
GO

-- =============================================
--DATABASE TABLES BACKUP RESTORE
-- =============================================

Alter PROCEDURE DBRestore

@name VARCHAR(MAX) = 'GLOBANT_BKP'
AS
BEGIN

DECLARE @SQL VARCHAR(MAX)
DECLARE @NewDBName VARCHAR(MAX) 
DECLARE @FileNameOrgBackup VARCHAR(MAX) 
DECLARE @PathOrgignalBackup VARCHAR(MAX) 

SET @NewDBName = @name
SET @PathOrgignalBackup = 'C:\Data\GLOBANT\Backup\'
SET @FileNameOrgBackup = @PathOrgignalBackup + @name + '.bak'
SET @SQL = ''

SET @SQL ='RESTORE DATABASE ' + @NewDBName
SET @SQL = @SQL + ' FROM DISK = ''' + @FileNameOrgBackup + ''''

EXECUTE(@SQL)
END
GO

Likewise just pass names of db’s to stored procedure to restore database.
EXEC [DBRestore] 'GLOBANT_DB'