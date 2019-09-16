USE FxFirme

DECLARE @TmpSqlCommand varchar(max), @TmpSifraFirme smallint, @TmpSqlDatabase varchar(50), @TmpCounter smallint

SET @TmpCounter = 0

DECLARE SifrarnikFxFirmiList CURSOR FOR 
  SELECT SifrarnikFxFirmi.Sifra, SifrarnikFxFirmi.SqlDatabase 
    FROM SifrarnikFxFirmi 
      WHERE SifrarnikFxFirmi.Sifra = 1

  OPEN SifrarnikFxFirmiList
  FETCH NEXT FROM SifrarnikFxFirmiList INTO @TmpSifraFirme, @TmpSqlDatabase
    WHILE @@FETCH_STATUS = 0
      BEGIN
	    PRINT 'Šifra: ' + CAST(@TmpSifraFirme AS varchar) + ', database: ' + @TmpSqlDatabase
		SET @TmpCounter += 1

		IF @TmpCounter = 1
		  BEGIN
		    SET @TmpSqlCommand =  'SELECT A.ID_FS, A.BrojFakture, A.DatumFakture, CAST(A.KolicinaPro AS float) AS Kolicina FROM ' + @TmpSqlDatabase + '.dbo.FaktureDetaljnoView A WHERE A.BrojRN = ''2539/2015'' AND A.VrstaTroska = ''Proizvod'' '
		  END
		ELSE
		  BEGIN
		    SET @TmpSqlCommand += 'UNION '
			SET @TmpSqlCommand +=  'SELECT A.ID_FS, A.BrojFakture, A.DatumFakture, CAST(A.KolicinaPro AS float) AS Kolicina FROM ' + @TmpSqlDatabase + '.dbo.FaktureDetaljnoView A WHERE A.BrojRN = ''2539/2015'' AND A.VrstaTroska = ''Proizvod'' '
		  END

        FETCH NEXT FROM SifrarnikFxFirmiList INTO @TmpSifraFirme, @TmpSqlDatabase
      END
  CLOSE SifrarnikFxFirmiList 
DEALLOCATE SifrarnikFxFirmiList

IF @TmpCounter > 0
  BEGIN
    SET @TmpSqlCommand += 'ORDER BY DatumFakture'
    EXEC (@TmpSqlCommand)
  END
ELSE
  BEGIN
    PRINT 'No data'
  END