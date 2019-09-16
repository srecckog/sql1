USE FeroAppArh2015;

WITH MyTmpTable1 AS( 
SELECT ID_Pro, Obrada1, Obrada2, MAX(ID_FS) AS ID_FS 
	FROM FaktureDetaljnoView 
	WHERE DatumFakture BETWEEN '2010-01-01' AND '2015-09-30' 
	AND (ID_Mat IN(SELECT Materijali.ID_Mat FROM Materijali WHERE Materijali.ID_Mat IN(SELECT UlazRobeDetaljnoView.ID_MAT FROM UlazRobeDetaljnoView WHERE UlazRobeDetaljnoView.ID_Par IN(12222, 221139))) 
	OR ID_Mat IN(SELECT FeroApp.dbo.Materijali.ID_Mat FROM FeroApp.dbo.Materijali WHERE FeroApp.dbo.Materijali.ID_Mat IN(SELECT FeroApp.dbo.UlazRobeDetaljnoView.ID_MAT FROM FeroApp.dbo.UlazRobeDetaljnoView WHERE FeroApp.dbo.UlazRobeDetaljnoView.ID_Par IN(12222, 221139)))) 
	AND ID_Ulp IS NOT NULL 
	AND VlasnistvoFX = 1 
	GROUP BY ID_Pro, Obrada1, Obrada2), 
MyTmpTable2 AS( 
SELECT *, (SELECT FaktureSta.ID_Pro_Kup FROM FaktureSta WHERE FaktureSta.ID_FS = MyTmpTable1.ID_FS) AS SAP_ID, 
	(SELECT FaktureSta.NazivPro FROM FaktureSta WHERE FaktureSta.ID_FS = MyTmpTable1.ID_FS) AS NazivPro, 
	CAST((SELECT FaktureSta.CijenaProKom FROM FaktureSta WHERE FaktureSta.ID_FS = MyTmpTable1.ID_FS) AS float) AS CijenaProKom 
	FROM MyTmpTable1), 
MyTmpTable3 AS( 
SELECT *, ISNULL(CAST((SELECT SUM(KolicinaPro) FROM FaktureDetaljnoView WHERE FaktureDetaljnoView.DatumFakture BETWEEN '2015-10-01' AND '2015-12-31' AND FaktureDetaljnoView.VlasnistvoFX = 1 AND FaktureDetaljnoView.ID_Pro = MyTmpTable2.ID_Pro AND FaktureDetaljnoView.Obrada1 = MyTmpTable2.Obrada1 AND FaktureDetaljnoView.Obrada2 = MyTmpTable2.Obrada2) AS float), 0) AS Kolicina_iv,  
	ISNULL(CAST((SELECT SUM(KolicinaPro * CijenaProKom) FROM FaktureDetaljnoView WHERE FaktureDetaljnoView.DatumFakture BETWEEN '2015-10-01' AND '2015-12-31' AND FaktureDetaljnoView.VlasnistvoFX = 1 AND FaktureDetaljnoView.ID_Pro = MyTmpTable2.ID_Pro AND FaktureDetaljnoView.Obrada1 = MyTmpTable2.Obrada1 AND FaktureDetaljnoView.Obrada2 = MyTmpTable2.Obrada2) AS float), 0) AS Iznos_iv, 
	(SELECT TOP 1 CAST(FaktureDetaljnoView.CijenaProKom AS float) FROM FaktureDetaljnoView WHERE FaktureDetaljnoView.ID_Pro = MyTmpTable2.ID_Pro AND FaktureDetaljnoView.VlasnistvoFX = 1 AND FaktureDetaljnoView.DatumFakture BETWEEN '2015-10-01' AND '2015-12-31' AND Obrada1 = MyTmpTable2.Obrada1 AND FaktureDetaljnoView.Obrada2 = MyTmpTable2.Obrada2 ORDER BY FaktureDetaljnoView.DatumFakture DESC) AS ZadnjaCijena_iv 
	FROM MyTmpTable2), 
MyTmpTable4 AS( 
SELECT *, ISNULL(CAST((SELECT SUM(KolicinaPro) FROM FeroApp.dbo.FaktureDetaljnoView WHERE FeroApp.dbo.FaktureDetaljnoView.DatumFakture BETWEEN '2016-01-01' AND '2016-03-31' AND FeroApp.dbo.FaktureDetaljnoView.VlasnistvoFX = 1 AND FeroApp.dbo.FaktureDetaljnoView.ID_Pro = MyTmpTable3.ID_Pro AND FeroApp.dbo.FaktureDetaljnoView.Obrada1 = MyTmpTable3.Obrada1 AND FeroApp.dbo.FaktureDetaljnoView.Obrada2 = MyTmpTable3.Obrada2) AS float), 0) AS Kolicina_i,  
	ISNULL(CAST((SELECT SUM(FeroApp.dbo.FaktureDetaljnoView.KolicinaPro * FeroApp.dbo.FaktureDetaljnoView.CijenaProKom) FROM FeroApp.dbo.FaktureDetaljnoView WHERE FeroApp.dbo.FaktureDetaljnoView.DatumFakture BETWEEN '2016-01-01' AND '2016-03-31' AND FeroApp.dbo.FaktureDetaljnoView.VlasnistvoFX = 1 AND FeroApp.dbo.FaktureDetaljnoView.ID_Pro = MyTmpTable3.ID_Pro AND FeroApp.dbo.FaktureDetaljnoView.Obrada1 = MyTmpTable3.Obrada1 AND FeroApp.dbo.FaktureDetaljnoView.Obrada2 = MyTmpTable3.Obrada2) AS float), 0) AS Iznos_i, 
	(SELECT TOP 1 CAST(FeroApp.dbo.FaktureDetaljnoView.CijenaProKom AS float) FROM FeroApp.dbo.FaktureDetaljnoView WHERE FeroApp.dbo.FaktureDetaljnoView.ID_Pro = MyTmpTable3.ID_Pro AND FeroApp.dbo.FaktureDetaljnoView.VlasnistvoFX = 1 AND FeroApp.dbo.FaktureDetaljnoView.DatumFakture BETWEEN '2016-01-01' AND '2016-03-31' AND FeroApp.dbo.FaktureDetaljnoView.Obrada1 = MyTmpTable3.Obrada1 AND FeroApp.dbo.FaktureDetaljnoView.Obrada2 = MyTmpTable3.Obrada2 ORDER BY FeroApp.dbo.FaktureDetaljnoView.DatumFakture DESC) AS ZadnjaCijena_i 
	FROM MyTmpTable3) 

SELECT * FROM MyTmpTable4 