USE FeroApp;

DECLARE @TmpdatumOd date, @TmpDatumDo date;
SET @TmpdatumOd = '2017-01-01';
SET @TmpDatumDo = '2017-06-30';

WITH MyTmpTable AS(
SELECT NZ.ID_Par, YEAR(DatumIsporuke) AS Godina, CAST(NS.KolicinaNar AS float) AS Kolicina, DATEPART(WK, NS.DatumIsporuke) AS Tjedan FROM NarudzbeSta NS 
		LEFT JOIN NarudzbeZag NZ ON NS.ID_NarZ = NZ.ID_NarZ 
	WHERE NZ.VrstaDok = 'Order'
		AND NS.DatumIsporuke BETWEEN @TmpdatumOd AND @TmpDatumDo
		AND NS.BazniRN = 1)

SELECT ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = MyTmpTable.ID_Par) AS Kupac, Godina, Tjedan, SUM(Kolicina) AS Kolicina 
	FROM MyTmpTable 
	GROUP BY ID_Par, Godina, Tjedan
	ORDER BY ID_Par, Godina, Tjedan