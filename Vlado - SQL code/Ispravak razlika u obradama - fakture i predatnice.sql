USE FeroApp

UPDATE UlazProizvoda SET Obrada1 = 1
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada1 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada1 = 1) > 0
	AND ID_ULP <> 20482
	
UPDATE UlazProizvoda SET Obrada2 = 1
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada2 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada2 = 1) > 0
	AND ID_ULP <> 20482	

UPDATE UlazProizvoda SET Obrada3 = 1
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada3 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada3 = 1) > 0
	AND ID_ULP <> 20482

UPDATE UlazProizvoda SET Obrada4 = 1
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada4 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada4 = 1) > 0
	AND ID_ULP <> 20482

UPDATE UlazProizvoda SET Obrada5 = 1
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada5 = 0
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada5 = 1) > 0
	AND ID_ULP <> 20482

UPDATE UlazProizvoda SET CijenaObrada1 = (SELECT MAX(CijenaObrada1) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada1 = 1)
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada1 = 1
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada1 = 1) > 0
	AND ID_ULP <> 20482
	
UPDATE UlazProizvoda SET CijenaObrada2 = (SELECT MAX(CijenaObrada2) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada2 = 1)
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada2 = 1
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada2 = 1) > 0
	AND ID_ULP <> 20482	
	
UPDATE UlazProizvoda SET CijenaObrada3 = (SELECT MAX(CijenaObrada3) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada3 = 1)
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada3 = 1
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada3 = 1) > 0
	AND ID_ULP <> 20482		

UPDATE UlazProizvoda SET CijenaObrada4 = (SELECT MAX(CijenaObrada4) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada4 = 1)
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada4 = 1
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada4 = 1) > 0
	AND ID_ULP <> 20482	
	
UPDATE UlazProizvoda SET CijenaObrada5 = (SELECT MAX(CijenaObrada5) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada5 = 1)
	WHERE (SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE) >= '2012-10-01'
	AND Obrada5 = 1
	AND (SELECT COUNT(*) FROM FaktureSta WHERE ID_ULP = UlazProizvoda.ID_ULP AND Obrada5 = 1) > 0
	AND ID_ULP <> 20482		