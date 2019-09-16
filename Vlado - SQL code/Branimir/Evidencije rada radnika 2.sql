USE FxSAP;

DECLARE @TmpDatumOd date, @TmpDatumDo date, @TmpSearchString varchar(1);

SET @TmpDatumOd = '2016-12-05'; 
SET @TmpDatumDo = '2016-12-05'; 
SET @TmpSearchString = 'e'; 

WITH MyTmpTable1 AS(
SELECT dbo.CalcZbrojVrstaSati((CASE WHEN YEAR(@TmpDatumOd) = Godina AND MONTH(@TmpDatumOd) = Mjesec THEN DAY(@TmpDatumOd) ELSE 1 END), (CASE WHEN YEAR(@TmpDatumDo) = Godina AND MONTH(@TmpDatumDo) = Mjesec THEN DAY(@TmpDatumDo) ELSE BrojDanaUmjesecu END), 'e', Dan01, Dan02, Dan03, Dan04, Dan05, Dan06, Dan07, Dan08, Dan09, Dan10, Dan11, Dan12, Dan13, Dan14, Dan15, Dan16, Dan17, Dan18, Dan19, Dan20, Dan21, Dan22, Dan23, Dan24, Dan25, Dan26, Dan27, Dan28, Dan29, Dan30, Dan31) AS BrojDana_e, 
	dbo.CalcZbrojVrstaSati((CASE WHEN YEAR(@TmpDatumOd) = Godina AND MONTH(@TmpDatumOd) = Mjesec THEN DAY(@TmpDatumOd) ELSE 1 END), (CASE WHEN YEAR(@TmpDatumDo) = Godina AND MONTH(@TmpDatumDo) = Mjesec THEN DAY(@TmpDatumDo) ELSE BrojDanaUmjesecu END), 'b', Dan01, Dan02, Dan03, Dan04, Dan05, Dan06, Dan07, Dan08, Dan09, Dan10, Dan11, Dan12, Dan13, Dan14, Dan15, Dan16, Dan17, Dan18, Dan19, Dan20, Dan21, Dan22, Dan23, Dan24, Dan25, Dan26, Dan27, Dan28, Dan29, Dan30, Dan31) AS BrojDana_b, 
	dbo.CalcZbrojVrstaSati((CASE WHEN YEAR(@TmpDatumOd) = Godina AND MONTH(@TmpDatumOd) = Mjesec THEN DAY(@TmpDatumOd) ELSE 1 END), (CASE WHEN YEAR(@TmpDatumDo) = Godina AND MONTH(@TmpDatumDo) = Mjesec THEN DAY(@TmpDatumDo) ELSE BrojDanaUmjesecu END), 'g', Dan01, Dan02, Dan03, Dan04, Dan05, Dan06, Dan07, Dan08, Dan09, Dan10, Dan11, Dan12, Dan13, Dan14, Dan15, Dan16, Dan17, Dan18, Dan19, Dan20, Dan21, Dan22, Dan23, Dan24, Dan25, Dan26, Dan27, Dan28, Dan29, Dan30, Dan31) AS BrojDana_g, 
	* 
	FROM PlanSatiRada 
	WHERE Godina BETWEEN YEAR(@TmpDatumOd) AND YEAR(@TmpDatumDo) 
	AND (CASE WHEN Godina = YEAR(@TmpDatumOd) AND Mjesec < MONTH(@TmpDatumOd) THEN 0 WHEN Godina = YEAR(@TmpDatumDo) AND Mjesec > MONTH(@TmpDatumDo) THEN 0 ELSE 1 END) = 1 
	AND VrstaRM = 'Proizvodnja'),
MyTmpTable2 AS(
SELECT Firma, RadnikID, Ime, SUM(BrojDana_e) AS BrojDana_e, SUM(BrojDana_b) AS BrojDana_b, SUM(BrojDana_g) AS BrojDana_g 
	FROM MyTmpTable1 
	GROUP BY Firma, RadnikID, Ime)

SELECT *, (SELECT TOP 1 PSR.SifraRM FROM PlanSatiRada PSR WHERE PSR.RadnikID = MyTmpTable2.RadnikID AND PSR.Firma = MyTmpTable2.Firma ORDER BY PSR.PsrID DESC) AS SifraRM FROM MyTmpTable2 
	WHERE BrojDana_e <> 0 
	OR BrojDana_b <> 0 
	OR BrojDana_g <> 0 
	ORDER BY Firma, RadnikID