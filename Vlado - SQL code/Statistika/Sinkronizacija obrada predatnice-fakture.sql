USE FeroApp ; DECLARE @Datum1 date, @Datum2 date ; SET @Datum1 = '2016-07-01' ; SET @Datum2 = '2016-07-31'

UPDATE UlazProizvoda SET Obrada2 = 1 WHERE ID_ULP IN(SELECT ID_ULP 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @Datum1 AND @Datum2
	AND ID_Skl <> 106
	AND Obrada2 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada2 = 1) > 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada2 = 0) = 0)

UPDATE UlazProizvoda SET Obrada3 = 1 WHERE ID_ULP IN(SELECT ID_ULP 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @Datum1 AND @Datum2
	AND ID_Skl <> 106
	AND Obrada3 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada3 = 1) > 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada3 = 0) = 0)
	
UPDATE UlazProizvoda SET Obrada4 = 1 WHERE ID_ULP IN(SELECT ID_ULP 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @Datum1 AND @Datum2
	AND ID_Skl <> 106
	AND Obrada4 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada4 = 1) > 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada4 = 0) = 0)
	
UPDATE UlazProizvoda SET Obrada5 = 1 WHERE ID_ULP IN(SELECT ID_ULP 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @Datum1 AND @Datum2
	AND ID_Skl <> 106
	AND Obrada5 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada5 = 1) > 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP AND Obrada5 = 0) = 0)	