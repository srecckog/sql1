USE SupplyOn;

IF EXISTS(SELECT * FROM sys.columns WHERE Name = N'DatumIsporuke' AND Object_ID = Object_ID(N'CsvOrdersTmp'))
	BEGIN
		PRINT 'Postoji'
		--EXEC sp_RENAME 'CsvOrdersTmp.DatumIsporuke', 'DatumIsporukeX' , 'COLUMN'
	END
ELSE
	BEGIN
		PRINT 'Ne postoji'
		--EXEC sp_RENAME 'CsvOrdersTmp.DatumIsporukeX', 'DatumIsporuke' , 'COLUMN'
	END