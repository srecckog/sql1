USE [RFIND]
GO

DECLARE	@return_value int
DECLARE	@id int
DECLARE	@no varchar(50)
DECLARE	@user1 varchar(50)
DECLARE	@lastn varchar(50)
DECLARE	@name varchar(50)
declare @custid varchar(3)
DECLARE	@serijskibroj varchar(16)


declare @csn1 varchar(50)
declare @customid varchar(50)

DECLARE db_cursor CURSOR FOR  
SELECT cast(id as decimal(10,0)),rfid2,ime,prezime
FROM radnici_
where cast(id as decimal(10,0))=1021
 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @id,@serijskibroj,@name,@lastn 

WHILE @@FETCH_STATUS = 0   
BEGIN   
       	   
		   
EXEC	@return_value = [dbo].[FX_Import]
		@EXT_ID = @id ,
		@FNAME = @name,
		@LNAME = @lastn,
		@CSN = @serijskibroj,
		@START_TIME = N'2017-01-01',
		@END_TIME = N'2030-11-30',
		@STATUS = 0

		FETCH NEXT FROM db_cursor INTO @id,@serijskibroj,@name,@lastn 
		print @serijskibroj
END   

CLOSE db_cursor   
deallocate db_cursor
