USE FxSAP ; DECLARE @TmpGodina smallint, @TmpMjesec smallint, @TmpDatumOd date, @TmpDatumDo date;

SET @TmpDatumOd = '2016-12-01';
SET @TmpDatumDo = '2016-12-31';
SET @TmpGodina = YEAR(@TmpDatumOd);
SET @TmpMjesec = MONTH(@TmpDatumOd);

WITH MyTmpTable AS(
SELECT RFID, (SELECT PSR.RadnikID FROM PlanSatiRada PSR WHERE PSR.Godina = @TmpGodina AND PSR.Mjesec = @TmpMjesec AND PSR.RFID = RS.RFID) AS RadnikID, 
	(SELECT PSR.Ime FROM PlanSatiRada PSR WHERE PSR.Godina = @TmpGodina AND PSR.Mjesec = @TmpMjesec AND PSR.RFID = RS.RFID) AS Ime, COUNT(*) AS Broj, 
	(SELECT Rad.Lokacija FROM FinkTKB.dbo.Radnici Rad WHERE Rad.RFID = RS.RFID) AS Lokacija 
	FROM RestStavke RS 
	WHERE Datum BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND RFID IN(SELECT PSR.RFID FROM PlanSatiRada PSR WHERE PSR.Godina = @TmpGodina AND PSR.Mjesec = @TmpMjesec AND PSR.Firma = 3) 
	AND ID_RJE IN(SELECT RJ.ID_RJE FROM RestJela RJ WHERE RJ.Grupacija = 'Glavno jelo') 
	GROUP BY RFID) 

SELECT * FROM MyTmpTable ORDER BY Ime 