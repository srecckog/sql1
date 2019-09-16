USE FeroAppTKB;

SELECT * FROM FaktureZag WHERE BrojFakture = '64-1-1';
-- SELECT ID_FS, ID_FZ, VrstaTroska, SifraUsluge, OpisUsluge, KolicinaUsl, JmUsl, CijenaUslKom FROM FaktureSta WHERE ID_FZ = 8698;

USE FeroApp;
SELECT * FROM FaktureZag WHERE ID_Par = 121301 AND DatumFakture BETWEEN '2016-12-01' AND '2016-12-30';

WITH MyTmpTable AS(
SELECT MAX(NazivPro) AS NazivPro, (SELECT FZ.TecajValute FROM FaktureZag FZ WHERE FZ.ID_FZ = FaktureSta.ID_FZ) AS TecajFakture, JmPro, SUM(KolicinaPro) AS KolicinaPro, Obrada1, CijenaObrada1, Obrada2, CijenaObrada2, Obrada3, CijenaObrada3, Obrada4, CijenaObrada4, Obrada5, CijenaObrada5 
	FROM FaktureSta 
	WHERE ID_FZ = 14898 
		AND VrstaTroska = 'Proizvod'
	GROUP BY FaktureSta.ID_FZ, VrstaTroska, ID_Mat, ID_NarZ, BrojVeze, JmMat, CijenaMatKom, ID_Pro, JmPro, 
	CijenaProKom, TezinaProKom, Obrada1, CijenaObrada1, BrojRN1, BrojNar1, Obrada2, CijenaObrada2, BrojRN2, BrojNar2, Obrada3, CijenaObrada3, BrojRN3, BrojNar3, Obrada4, 
	CijenaObrada4, BrojRN4, BrojNar4, Obrada5, CijenaObrada5, BrojRN5, BrojNar5, SamoPakiranja, VlasnistvoFX, BrojSarze),
MyTmpTable2 AS(
SELECT NazivPro, KolicinaPro, JmPro, TecajFakture, ((Obrada1 * CijenaObrada1) + (Obrada2 * CijenaObrada2) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) + (Obrada5 * CijenaObrada5)) AS ObradaEUR FROM MyTmpTable)

-- INSERT INTO FeroAppTKB.dbo.FaktureSta (FeroAppTKB.dbo.FaktureSta.ID_FZ, FeroAppTKB.dbo.FaktureSta.VrstaTroska, FeroAppTKB.dbo.FaktureSta.RedniBroj, FeroAppTKB.dbo.FaktureSta.SifraUsluge, FeroAppTKB.dbo.FaktureSta.OpisUsluge, FeroAppTKB.dbo.FaktureSta.KolicinaUsl, FeroAppTKB.dbo.FaktureSta.JmUsl, FeroAppTKB.dbo.FaktureSta.CijenaUslKom)
SELECT 8710, 'Proizvod' AS VrstaTroska, ROW_NUMBER() OVER (ORDER BY NazivPro) AS RedniBroj, CAST(ROW_NUMBER() OVER (ORDER BY NazivPro) AS varchar) AS Broj, CAST(NazivPro AS varchar(40)), KolicinaPro, 
	JmPro, CAST(ROUND((TecajFakture * ObradaEUR * 0.97), 2) AS decimal(10,2)) AS IznosEUR FROM MyTmpTable2 ORDER BY NazivPro