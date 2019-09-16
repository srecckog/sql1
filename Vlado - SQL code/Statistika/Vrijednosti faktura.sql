USE FeroApp;

/*WITH MyTmpTable AS(
SELECT FDV.DatumFakture, FDV.VlasnistvoFX, CijenaProKom, KolicinaPro, ((FDV.Obrada1 * FDV.CijenaObrada1) + (FDV.Obrada2 * FDV.CijenaObrada2) + (FDV.Obrada3 * FDV.CijenaObrada3) + (FDV.Obrada4 * FDV.CijenaObrada4) + (FDV.Obrada5 * FDV.CijenaObrada5)) AS CijenaObrade 
	FROM FaktureDetaljnoView FDV 
	WHERE DatumFakture >= '2016-01-01' 
	AND FDV.VrstaFakture IN(SELECT VF.VrstaFakture FROM VrsteFaktura VF WHERE VF.CreateASN = 1) 
	AND FDV.VrstaTroska = 'Proizvod'), 
MyTmpTable2 AS(
SELECT MONTH(DatumFakture) AS Mjesec, VlasnistvoFX, (KolicinaPro * (CASE WHEN VlasnistvoFX = 1 THEN CijenaProKom - CijenaObrade ELSE 0 END)) AS Materijal, (KolicinaPro * CijenaObrade) AS Obrada
	FROM MyTmpTable)

SELECT Mjesec, CAST(SUM(Materijal) AS float) AS Materijal, CAST(SUM(Obrada) AS float) AS Obrada 
	FROM MyTmpTable2
	GROUP BY Mjesec
	ORDER BY Mjesec*/

WITH MyTmpTable AS(
SELECT FZ.ID_FZ, FZ.VrstaFakture, FZ.DatumFakture, FZ.BrojFakture, FZ.ID_Par, 
	CAST((SELECT SUM(FS.CijenaProKom * FS.KolicinaPro) FROM FaktureSta FS WHERE FS.ID_FZ = FZ.ID_FZ AND FS.VrstaTroska = 'Proizvod') AS float) AS IznosPro, 
	CAST((SELECT SUM(((FS.Obrada1 * FS.CijenaObrada1) + (FS.Obrada2 * FS.CijenaObrada2) + (FS.Obrada3 * FS.CijenaObrada3) + (FS.Obrada4 * FS.CijenaObrada4) + (FS.Obrada5 * FS.CijenaObrada5)) * FS.KolicinaPro) FROM FaktureSta FS WHERE FS.ID_FZ = FZ.ID_FZ AND FS.VrstaTroska = 'Proizvod') AS float) AS IznosObrada, 
	CAST((SELECT SUM(FS.MalaSerija * FS.MalaSerija_EUR) FROM FaktureSta FS WHERE FS.ID_FZ = FZ.ID_FZ AND FS.VrstaTroska = 'Proizvod') AS float) AS MalaSerija 
	FROM FaktureZag FZ
	WHERE FZ.DatumFakture BETWEEN '2017-01-01' AND '2017-01-31' AND FZ.VrstaFakture IN(SELECT VF.VrstaFakture FROM VrsteFaktura VF WHERE VF.CreateASN = 1))

SELECT ID_FZ, VrstaFakture, DatumFakture, BrojFakture, ID_Par, (CASE WHEN VrstaFakture LIKE '%Loan%' THEN 0 ELSE IznosPro - IznosObrada END) AS IznosMaterijal, IznosObrada, MalaSerija FROM MyTmpTable ORDER BY DatumFakture 

-- SELECT FS.* FROM FaktureSta FS WHERE FS.ID_FZ = 14158