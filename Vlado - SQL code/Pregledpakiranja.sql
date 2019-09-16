USE FeroApp;

SELECT YEAR(FZ.DatumFakture) AS Godina, MONTH(FZ.DatumFakture) AS Mjesec, FS.VrstaPakiranja, SUM(FS.BrojPakiranja) AS Kolicina FROM FaktureSta FS 
		LEFT JOIN FaktureZag FZ ON FS.ID_FZ = FZ.ID_FZ 
	WHERE FZ.ID_Par = 221453 
		AND FS.VrstaTroska = 'Ambalaža' 
		AND FZ.DatumFakture BETWEEN '2016-11-01' AND '2017-05-31' 
	GROUP BY YEAR(FZ.DatumFakture), MONTH(FZ.DatumFakture), FS.VrstaPakiranja