USE FxSAP

--DELETE FROM MjesecnaSpecifikacijaObroka WHERE ID = 49
--UPDATE MjesecnaSpecifikacijaObroka SET Dan01 = 1, Dan22 = 1 WHERE ID = 63

--SELECT * FROM MjesecnaSpecifikacijaObroka WHERE RadnikID = 994

SELECT RadnikID, (SELECT Ime FROM PlanSatiRada WHERE Godina = MjesecnaSpecifikacijaObroka.Godina AND Mjesec = MjesecnaSpecifikacijaObroka.Mjesec AND RadnikID = MjesecnaSpecifikacijaObroka.RadnikID) AS Ime, 
	SUM(ISNULL(Dan01, 0)) AS D1, SUM(ISNULL(Dan02, 0)) AS D2, SUM(ISNULL(Dan03, 0)) AS D3, SUM(ISNULL(Dan04, 0)) AS D4, SUM(ISNULL(Dan05, 0)) AS D5, SUM(ISNULL(Dan06, 0)) AS D6, SUM(ISNULL(Dan07, 0)) AS D7, SUM(ISNULL(Dan08, 0)) AS D8, SUM(ISNULL(Dan09, 0)) AS D9, SUM(ISNULL(Dan10, 0)) AS D10, 
	SUM(ISNULL(Dan11, 0)) AS D11, SUM(ISNULL(Dan12, 0)) AS D12, SUM(ISNULL(Dan13, 0)) AS D13, SUM(ISNULL(Dan14, 0)) AS D14, SUM(ISNULL(Dan15, 0)) AS D15, SUM(ISNULL(Dan16, 0)) AS D16, SUM(ISNULL(Dan17, 0)) AS D17, SUM(ISNULL(Dan18, 0)) AS D18, SUM(ISNULL(Dan19, 0)) AS D19, SUM(ISNULL(Dan20, 0)) AS D20, 
	SUM(ISNULL(Dan21, 0)) AS D21, SUM(ISNULL(Dan22, 0)) AS D22, SUM(ISNULL(Dan23, 0)) AS D23, SUM(ISNULL(Dan24, 0)) AS D24, SUM(ISNULL(Dan25, 0)) AS D25, SUM(ISNULL(Dan26, 0)) AS D26, SUM(ISNULL(Dan27, 0)) AS D27, SUM(ISNULL(Dan28, 0)) AS D28, SUM(ISNULL(Dan29, 0)) AS D29, SUM(ISNULL(Dan30, 0)) AS D30, 
	SUM(ISNULL(Dan31, 0)) AS D31
	FROM MjesecnaSpecifikacijaObroka
	GROUP BY RadnikID, Godina, Mjesec
 
--SELECT * FROM MjesecnaSpecifikacijaObroka WHERE ID >= 120