USE FxApp;

DECLARE @TmpGodina smallint, @TmpMjesecOd tinyint, @TmpMjesecDo tinyint, @TmpTjedanOd tinyint, @TmpTjedanDo tinyint;

SET @TmpGodina = 2017;
SET @TmpMjesecOd = 1;
SET @TmpMjesecDo = 6;
SET @TmpTjedanOd = 1;
SET @TmpTjedanDo = 26;

WITH MyTmpTable1 AS(
SELECT CZ.[Buyer Article Number] AS ID_Pro_Kup, MAX([transmission no. new]) AS BrojDokumenta FROM CSVDiZaglavlja CZ WHERE CAST(CZ.[Delivery Instruction Date] AS date) >= '2016-11-01' GROUP BY CZ.[Buyer Article Number]),
MyTmpTable2 AS(
SELECT (SELECT CZx.[Plant Name] FROM CSVDiZaglavlja CZx WHERE CZx.IDZapisDi = CS.IDZapisDiZaglavlja) AS Kupac, CAST(CS.[Delivery date] AS date) AS Datum, ISNULL([Delivery quantity], 0) AS Kolicina, Status FROM CSVDiStavke CS WHERE CS.IDZapisDiZaglavlja IN(SELECT (SELECT CZ.IDZapisDi FROM CSVDiZaglavlja CZ WHERE CZ.[Buyer Article Number] = MyTmpTable1.ID_Pro_Kup AND CZ.[transmission no. new] = MyTmpTable1.BrojDokumenta) AS ID FROM MyTmpTable1)),
MyTmpTable3 AS(
SELECT Kupac, DATEPART(YEAR, Datum) AS Godina, DATEPART(MONTH, Datum) AS Mjesec, DATEPART(WK, Datum) AS Tjedan, Kolicina FROM MyTmpTable2)

SELECT Kupac, Godina, Tjedan, SUM(Kolicina) AS Kolicina FROM MyTmpTable3 WHERE Godina = @TmpGodina AND Tjedan BETWEEN @TmpTjedanOd AND @TmpTjedanDo GROUP BY Kupac, Godina, Tjedan 
ORDER BY Kupac,tjedan, Godina

