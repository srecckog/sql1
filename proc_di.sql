-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE proc_di 
	-- Add the parameters for the stored procedure here

 @TmpGodina  int,
 @TmpMjesecOd  int,
 @TmpMjesecDo  int,
 @TmpTjedanOd  int,
 @TmpTjedanDo int ;

	
AS
BEGIN

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

SELECT Kupac, Godina, Tjedan, SUM(Kolicina) AS Kolicina FROM MyTmpTable3 WHERE Godina = @TmpGodina AND Tjedan BETWEEN @TmpTjedanOd AND @TmpTjedanDo GROUP BY Kupac, Godina, Tjedan ORDER BY Kupac, Godina, Tjedan


END
GO
