USE FeroTmp

DECLARE @AllesGut tinyint, @PocetniDan date, @PocetnoVrijeme time, @PocetnaSmjena tinyint, @ZavrsniDan date, @ZavrsnoVrijeme time, @ZavrsnaSmjena tinyint, @Hala varchar(2), @Linija varchar(15), @TmpDatumVrijeme datetime, @TmpSmjena tinyint
DECLARE @D1S1 tinyint, @D1S2 tinyint, @D1S3 tinyint, @D2S1 tinyint, @D2S2 tinyint, @D2S3 tinyint, @D3S1 tinyint, @D3S2 tinyint, @D3S3 tinyint, @D4S1 tinyint, @D4S2 tinyint, @D4S3 tinyint, @D5S1 tinyint, @D5S2 tinyint, @D5S3 tinyint, @D6S1 tinyint, @D6S2 tinyint, @D6S3 tinyint, @D7S1 tinyint, @D7S2 tinyint, @D7S3 tinyint

SET @PocetniDan     = '2016-06-09'
SET @PocetnoVrijeme = '10:00'
SET @PocetnaSmjena = (CASE WHEN @PocetnoVrijeme BETWEEN '00:00:00' AND '07:59:59' THEN 1 WHEN @PocetnoVrijeme BETWEEN '08:00:00' AND '15:59:59' THEN 2 ELSE 3 END) -- raèunaj novu smjenu
SET @ZavrsniDan     = '2016-06-15'
SET @ZavrsnoVrijeme = '17:00'
SET @ZavrsnaSmjena = (CASE WHEN @ZavrsnoVrijeme BETWEEN '00:00:00' AND '07:59:59' THEN 1 WHEN @ZavrsnoVrijeme BETWEEN '08:00:00' AND '15:59:59' THEN 2 ELSE 3 END) -- raèunaj novu smjenu
SET @Hala = '1'
SET @Linija = '01'

SELECT @D1S1 = ISNULL(PLI.PonS1, 0), @D1S2 = ISNULL(PLI.PonS2, 0), @D1S3 = ISNULL(PLI.PonS3, 0), @D2S1 = ISNULL(PLI.UtoS1, 0), @D2S2 = ISNULL(PLI.UtoS2, 0), @D2S3 = ISNULL(PLI.UtoS3, 0), 
	   @D3S1 = ISNULL(PLI.SriS1, 0), @D3S2 = ISNULL(PLI.SriS2, 0), @D3S3 = ISNULL(PLI.SriS3, 0), @D4S1 = ISNULL(PLI.CetS1, 0), @D4S2 = ISNULL(PLI.CetS2, 0), @D4S3 = ISNULL(PLI.CetS3, 0), 
	   @D5S1 = ISNULL(PLI.PetS1, 0), @D5S2 = ISNULL(PLI.PetS2, 0), @D5S3 = ISNULL(PLI.PetS3, 0), @D6S1 = ISNULL(PLI.SubS1, 0), @D6S2 = ISNULL(PLI.SubS2, 0), @D6S3 = ISNULL(PLI.SubS3, 0), 
	   @D7S1 = ISNULL(PLI.NedS1, 0), @D7S2 = ISNULL(PLI.NedS2, 0), @D7S3 = ISNULL(PLI.NedS3, 0) 
	FROM ProizvodneLinije PLI WHERE PLI.Hala = @Hala AND PLI.Broj = @Linija

PRINT 'Poèetna smjena: ' + CAST(@PocetnaSmjena AS varchar)
PRINT 'Završna smjena: ' + CAST(@ZavrsnaSmjena AS varchar)

SET @AllesGut = 1

SET @TmpDatumVrijeme = CAST(@PocetniDan AS datetime) + ' ' + CAST(@PocetnoVrijeme AS datetime)
SET @TmpSmjena = @PocetnaSmjena

PRINT ''

WHILE @AllesGut = 1
  BEGIN
    IF CAST(@TmpDatumVrijeme AS date) < @ZavrsniDan
	  BEGIN 
	    PRINT 'Smjena ' + CAST(@TmpSmjena AS varchar) + ': ' + CAST(CAST(@TmpDatumVrijeme AS date) AS varchar) + ' ' + CAST(CAST(@TmpDatumVrijeme AS time(0)) AS varchar) + ', dan ' + CAST(DATEPART(dw, @TmpDatumVrijeme) AS varchar) + ', ' + CAST((CASE DATEPART(dw, @TmpDatumVrijeme) WHEN 1 THEN (CASE @TmpSmjena WHEN 1 THEN @D1S1 WHEN 2 THEN @D1S2 ELSE @D1S3 END) WHEN 2 THEN (CASE @TmpSmjena WHEN 1 THEN @D2S1 WHEN 2 THEN @D2S2 ELSE @D2S3 END) WHEN 3 THEN (CASE @TmpSmjena WHEN 1 THEN @D3S1 WHEN 2 THEN @D3S2 ELSE @D3S3 END) WHEN 4 THEN (CASE @TmpSmjena WHEN 1 THEN @D4S1 WHEN 2 THEN @D4S2 ELSE @D4S3 END) WHEN 5 THEN (CASE @TmpSmjena WHEN 1 THEN @D5S1 WHEN 2 THEN @D5S2 ELSE @D5S3 END) WHEN 6 THEN (CASE @TmpSmjena WHEN 1 THEN @D6S1 WHEN 2 THEN @D6S2 ELSE @D6S3 END) ELSE (CASE @TmpSmjena WHEN 1 THEN @D7S1 WHEN 2 THEN @D7S2 ELSE @D7S3 END) END) AS varchar)
		SET @TmpDatumVrijeme = CAST(DATEADD(HOUR, 8, @TmpDatumVrijeme) AS datetime)
		SET @TmpSmjena = (CASE WHEN CAST(@TmpDatumVrijeme AS time) BETWEEN '00:00:00' AND '07:59:59' THEN 1 WHEN CAST(@TmpDatumVrijeme AS time) BETWEEN '08:00:00' AND '15:59:59' THEN 2 ELSE 3 END)
	  END
	ELSE IF CAST(@TmpDatumVrijeme AS date) = @ZavrsniDan
	  BEGIN
	    IF @TmpSmjena <= @ZavrsnaSmjena
		  BEGIN
		    PRINT 'Smjena ' + CAST(@TmpSmjena AS varchar) + ': ' + CAST(CAST(@TmpDatumVrijeme AS date) AS varchar) + ' ' + CAST(CAST(@TmpDatumVrijeme AS time(0)) AS varchar) + ', dan ' + CAST(DATEPART(dw, @TmpDatumVrijeme) AS varchar) + ', ' + CAST((CASE DATEPART(dw, @TmpDatumVrijeme) WHEN 1 THEN (CASE @TmpSmjena WHEN 1 THEN @D1S1 WHEN 2 THEN @D1S2 ELSE @D1S3 END) WHEN 2 THEN (CASE @TmpSmjena WHEN 1 THEN @D2S1 WHEN 2 THEN @D2S2 ELSE @D2S3 END) WHEN 3 THEN (CASE @TmpSmjena WHEN 1 THEN @D3S1 WHEN 2 THEN @D3S2 ELSE @D3S3 END) WHEN 4 THEN (CASE @TmpSmjena WHEN 1 THEN @D4S1 WHEN 2 THEN @D4S2 ELSE @D4S3 END) WHEN 5 THEN (CASE @TmpSmjena WHEN 1 THEN @D5S1 WHEN 2 THEN @D5S2 ELSE @D5S3 END) WHEN 6 THEN (CASE @TmpSmjena WHEN 1 THEN @D6S1 WHEN 2 THEN @D6S2 ELSE @D6S3 END) ELSE (CASE @TmpSmjena WHEN 1 THEN @D7S1 WHEN 2 THEN @D7S2 ELSE @D7S3 END) END) AS varchar)
	    	SET @TmpDatumVrijeme = CAST(DATEADD(HOUR, 8, @TmpDatumVrijeme) AS datetime)
		    SET @TmpSmjena = (CASE WHEN CAST(@TmpDatumVrijeme AS time) BETWEEN '00:00:00' AND '07:59:59' THEN 1 WHEN CAST(@TmpDatumVrijeme AS time) BETWEEN '08:00:00' AND '15:59:59' THEN 2 ELSE 3 END)
		  END
		ELSE
		  BEGIN
		    BREAK
		  END
	  END
	ELSE
	  BEGIN 
	    BREAK
	  END
  END