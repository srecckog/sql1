USE FeroApp; DECLARE @TmpDatum date;

SET @TmpDatum = '2017-01-27';

/*WITH MyTmpTableULR AS(
SELECT (SELECT SKL.Grupacija FROM Skladista SKL WHERE SKL.ID_Skl = ULR.ID_SKL) AS Grupacije, CAST((CASE WHEN ULR.VrstaOtpisa = 'Kolicina' THEN KolicinaDokument * TezinaKomInv ELSE ULR.TezinaFaktura END) AS float) AS Tezina FROM UlazRobeDetaljnoView ULR 
	WHERE ULR.DatumUlaza = @TmpDatum 
		AND ULR.ID_SKL NOT IN(130, 621))
SELECT Grupacije, SUM(Tezina) AS TezinaUlaza_kg FROM MyTmpTableULR GROUP BY Grupacije */

WITH MyTmpTableENV AS(
SELECT @TmpDatum AS DatumObrade, ENV.*, NDV.ID_Par, Par.NazivPar, NDV.OrderNo, Hala + ' ' + Linija AS HalaLinija 
	FROM EvidencijaNormiView ENV 
		INNER JOIN NarudzbeDetaljnoView NDV ON ENV.BrojRN = NDV.BrojRN 
		INNER JOIN Partneri Par ON NDV.ID_Par = Par.ID_Par 
	WHERE ENV.Datum = @TmpDatum)
SELECT DatumObrade, NazivPar, COUNT(DISTINCT OrderNo) AS Broj_narudzbi_kupca, COUNT(DISTINCT HalaLinija) AS BrojLinija, SUM(KolicinaOK) AS Kolicina_ok, SUM(OtpadMat) AS Otpad_mat, SUM(OtpadObrada) AS Otpad_obrada 
	FROM MyTmpTableENV 
	GROUP BY DatumObrade, NazivPar 
	ORDER BY NazivPar 