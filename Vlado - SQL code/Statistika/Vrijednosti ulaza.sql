USE FeroApp; 

WITH MyTmpTable AS(
SELECT ULR.ID_SKL, MONTH(ULR.DatumUlaza) AS Mjesec, ULR.Valuta, 
	CAST((CASE WHEN ULR.VrstaOtpisa = 'Komadno' THEN ULR.KolicinaDokument * ULR.CijenaKom ELSE ULR.TezinaFaktura * ULR.CijenaKg END) AS float) AS Iznos 
	FROM UlazRobeDetaljnoView ULR 
	WHERE ULR.DatumUlaza BETWEEN '2017-01-01' AND '2017-01-31' 
		AND ULR.VrstaUR = 'UlazULR' 
		AND ULR.VrstaDokumenta <> 'Zapisnik' 
		AND ULR.ID_SKL IN(99, 118, 252, 308, 325, 327, 334, 336, 361, 371))

SELECT ID_SKL, (SELECT Skladista.NazivSkladista FROM Skladista WHERE Skladista.ID_Skl = MyTmpTable.ID_SKL) AS Skladista, Mjesec, Valuta, SUM(Iznos) AS Iznos 
	FROM MyTmpTable
	GROUP BY ID_SKL, Mjesec, Valuta
	ORDER BY ID_SKL, Mjesec, Valuta