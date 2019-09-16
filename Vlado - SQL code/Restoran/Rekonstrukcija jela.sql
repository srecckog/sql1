USE FxSAP

--DELETE FROM RestEvidPotrosnje ; DBCC CHECKIDENT(RestEvidPotrosnje, RESEED, 1)
--INSERT INTO RestEvidPotrosnje (RFID, Datum, Vrijeme)
  --SELECT RFID, Datum, Vrijeme FROM RestStavke WHERE (SELECT Grupacija FROM RestJela WHERE ID_RJE = RestStavke.ID_RJE) = 'Glavno jelo'

DELETE FROM RestStavke ; DBCC CHECKIDENT(RestStavke, RESEED, 1)
DECLARE @TmpRFID varchar(25), @TmpDatum date, @TmpVrijeme time(0)
DECLARE RestoranRadnikDan CURSOR FOR 
  SELECT RFID, Datum, Vrijeme
    FROM RestEvidPotrosnje 
OPEN RestoranRadnikDan
  FETCH NEXT FROM RestoranRadnikDan INTO @TmpRFID, @TmpDatum, @TmpVrijeme 
	WHILE @@FETCH_STATUS = 0
	  BEGIN
	    INSERT INTO RestStavke (ID_RJE, RFID, Datum, Vrijeme)
			SELECT ID_RJE, @TmpRFID, @TmpDatum, @TmpVrijeme FROM RestMeniSta WHERE RestMeniSta.ID_RMZ = (SELECT RestMeniZag.ID_RMZ FROM RestMeniZag WHERE RestMeniZag.Datum = @TmpDatum)

	    FETCH NEXT FROM RestoranRadnikDan INTO @TmpRFID, @TmpDatum, @TmpVrijeme 
	  END

CLOSE RestoranRadnikDan ; DEALLOCATE RestoranRadnikDan
UPDATE RestStavke SET Naziv = (SELECT NazivJela FROM RestJela WHERE ID_RJE = RestStavke.ID_RJE), Cijena = 0