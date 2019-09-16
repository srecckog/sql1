USE FeroTmp;

SELECT Par.NazivPar AS Dobavljac, FZ.BrojFakture, FZ.DatumFakture, FZ.VrstaFakture, FS.ID_Pro_Kup, REPLACE(FS.NazivPro, ' ', '') AS NazivPro, CAST(Mat.OmjerPro AS float) AS OmjerProMat, FS.ID_Mat, 
		CAST(FS.KolicinaPro AS float) AS KolicinaPro, CAST(FS.CijenaProKom AS float) AS CijenaProKom, CAST(FS.Obrada1 * FS.CijenaObrada1 AS float) AS Tokarenje, 
		CAST(FS.Obrada2 * FS.CijenaObrada2 AS float) AS Kaljenje, CAST(FS.Obrada3 * FS.CijenaObrada3 AS float) AS TvrdoTok, CAST(FS.Obrada4 * FS.CijenaObrada4 AS float) AS Brusenje,
		(SELECT CAST(MC.BaznaCijenaMat AS float) FROM MaterijaliCijene MC WHERE MC.ID_Mat = FS.ID_Mat AND MC.Godina = YEAR(FZ.DatumFakture) AND MC.Kvartal = (CASE WHEN MONTH(FZ.DatumFakture) BETWEEN 1 AND 3 THEN 1 WHEN MONTH(FZ.DatumFakture) BETWEEN 4 AND 6 THEN 2 WHEN MONTH(FZ.DatumFakture) BETWEEN 7 AND 9 THEN 3 ELSE 4 END)) AS CijenaMat, 
		(SELECT TOP 1 TCP.Dobavljac FROM TmpCijeneProizvoda TCP WHERE TCP.ID_Pro_Kup = FS.ID_Pro_Kup) AS DobavljacCjenik, 
		(SELECT TOP 1 TCP.CijenaProQ4 FROM TmpCijeneProizvoda TCP WHERE TCP.ID_Pro_Kup = FS.ID_Pro_Kup) AS CijenaProCjenik, 
		(SELECT TOP 1 TCP.Tokarenje FROM TmpCijeneProizvoda TCP WHERE TCP.ID_Pro_Kup = FS.ID_Pro_Kup) AS TokarenjeCjenik, 
		(SELECT TOP 1 TCP.Kaljenje FROM TmpCijeneProizvoda TCP WHERE TCP.ID_Pro_Kup = FS.ID_Pro_Kup) AS KaljenjeCjenik 
	FROM FaktureSta FS 
		LEFT JOIN FaktureZag FZ ON FS.ID_FZ = FZ.ID_FZ 
		LEFT JOIN Materijali Mat ON FS.ID_Mat = Mat.ID_Mat 
		LEFT JOIN UlazProizvoda ULP ON FS.ID_Ulp = ULP.ID_ULP 
		LEFT JOIN IzlazRobe IZR ON ULP.ID_IZR = IZR.ID_IZR 
		LEFT JOIN UlazRobeDetaljnoView ULR ON IZR.ID_ULR = ULR.ID_ULR 
		LEFT JOIN Partneri Par ON ULR.ID_Par = Par.ID_Par 
	WHERE FZ.ID_Par = 274 
		AND FZ.DatumFakture = '2016-12-16'
		AND FS.VrstaTroska = 'Proizvod'
		AND FZ.VrstaFakture LIKE 'Prsteni%Loan%' 
