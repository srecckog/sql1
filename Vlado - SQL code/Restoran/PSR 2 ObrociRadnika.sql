USE FxSAP

DECLARE @TmpGodina smallint, @TmpMjesec tinyint

SET @TmpGodina = 2015
SET @TmpMjesec = 11

-- DELETE FROM ObrociRadnika

-- SELECT * FROM PlanSatiRada WHERE Godina = @TmpGodina AND Mjesec = @TmpMjesec AND Firma = 1

-- INSERT INTO ObrociRadnika (RadnikID, Ime, BrojObroka)
SELECT (SELECT RadnikID FROM PlanSatiRada WHERE Godina = @TmpGodina AND Mjesec = @TmpMjesec AND Firma = 1 AND RFID = RestStavke.RFID), (SELECT Ime FROM PlanSatiRada WHERE Godina = @TmpGodina AND Mjesec = @TmpMjesec AND Firma = 1 AND RFID = RestStavke.RFID), COUNT(*) 
	FROM RestStavke 
	WHERE YEAR(Datum) = @TmpGodina AND MONTH(Datum) = @TmpMjesec 
	AND RFID IN(SELECT RFID FROM PlanSatiRada WHERE Godina = @TmpGodina AND Mjesec = @TmpMjesec AND Firma = 1) 
	GROUP BY RFID

SELECT * FROM ObrociRadnika

/*SELECT (SELECT RFID FROM PlanSatiRada WHERE Godina = 2015 AND Mjesec = 11 AND RadnikID = MjesecnaSpecifikacijaObroka.RadnikID AND Ime = MjesecnaSpecifikacijaObroka.Ime) AS RFID, ID_MSO, RadnikID, Godina, Mjesec, Ime, 
	(ISNULL(Dan01, 0) + ISNULL(Dan02, 0) + ISNULL(Dan03, 0) + ISNULL(Dan04, 0) + ISNULL(Dan05, 0) + ISNULL(Dan06, 0) + ISNULL(Dan07, 0) + ISNULL(Dan08, 0) + ISNULL(Dan09, 0) + ISNULL(Dan10, 0)) + 
	(ISNULL(Dan11, 0) + ISNULL(Dan12, 0) + ISNULL(Dan13, 0) + ISNULL(Dan14, 0) + ISNULL(Dan15, 0) + ISNULL(Dan16, 0) + ISNULL(Dan17, 0) + ISNULL(Dan18, 0) + ISNULL(Dan19, 0) + ISNULL(Dan20, 0)) + 
	(ISNULL(Dan21, 0) + ISNULL(Dan22, 0) + ISNULL(Dan23, 0) + ISNULL(Dan24, 0) + ISNULL(Dan25, 0) + ISNULL(Dan26, 0) + ISNULL(Dan27, 0) + ISNULL(Dan28, 0) + ISNULL(Dan29, 0) + ISNULL(Dan30, 0) + ISNULL(Dan31, 0)) AS BrojObroka
	FROM MjesecnaSpecifikacijaObroka
	WHERE Godina = @TmpGodina 
	AND Mjesec = @TmpMjesec
	AND Firma = 1*/