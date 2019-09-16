USE [RFIND]
GO

DECLARE	@return_value int
DECLARE	@oid int
DECLARE	@no varchar(50)
DECLARE	@no2 varchar(50)
DECLARE	@user1 varchar(50)
DECLARE	@lastn varchar(50)
declare @custid varchar(3)
DECLARE	@serijskibroj varchar(16)
declare @csn1 varchar(50)
declare @customid varchar(50)
DECLARE db_cursor CURSOR FOR  
SELECT oid,no,no2,[user]
fROM event
where dt>='12/25/2016' and eventtype!='SP23'
ORDER by dt desc


OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @oid,@no,   @no2,@user1 

WHILE @@FETCH_STATUS = 0   
BEGIN   
       	   

		select @user1= [user] from badge b  where badgeno=@no
		update event set [user]=@user1 where no=@no


		FETCH NEXT FROM db_cursor INTO  @oid,@no,   @no2,@user1 
		print @user1
END   

CLOSE db_cursor   
deallocate db_cursor















EXEC	@return_value = [dbo].[FX_Import]
		@EXT_ID = N'1173',
		@FNAME = N'Sreækoo',
		@LNAME = N'Gašpariæ',
		@CSN = N'125-3605707',
		@START_TIME = N'2016-011-01',
		@END_TIME = N'2017-11-30',
		@STATUS = 0

SELECT	'Return Value' = @return_value

GO



DECLARE @name VARCHAR(50) -- database name  
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileName VARCHAR(256) -- filename for backup  
DECLARE @fileDate VARCHAR(20) -- used for file name 

SET @path = 'C:\Backup\'  

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

DECLARE db_cursor CURSOR FOR  
SELECT name 
FROM MASTER.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb')  

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
       SET @fileName = @path + @name + '_' + @fileDate + '.BAK'  
       BACKUP DATABASE @name TO DISK = @fileName  

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor
