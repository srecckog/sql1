USE FeroApp ; DECLARE @TmpULD int ; SET @TmpULD = 8252

SELECT * FROM UlazRobeDetaljnoView WHERE ID_ULR IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)
--SELECT * FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)
--SELECT * FROM IzlazRobeDetaljnoView WHERE ID_ULR IN((SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE ID_ULR IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)),(SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)))
--SELECT * FROM UlazProizvodaDetaljnoView WHERE ID_IZR IN(SELECT ID_IZR FROM IzlazRobeDetaljnoView WHERE ID_ULR IN((SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE ID_ULR IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)),(SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD))))
SELECT (SELECT VrstaDokumenta + ' ' + BrojDokumenta FROM UlazniDokumenti WHERE ID_ULD = @TmpULD) AS Primka, 
	(SELECT ID_SKL FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(FaktureDetaljnoView.ID_Ulp, 'ULP')) AS SkladištePrimka, 
	(SELECT CijenaKom FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(FaktureDetaljnoView.ID_Ulp, 'ULP')) AS CijenaPrimka, 
	(SELECT KolicinaDokument FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(FaktureDetaljnoView.ID_Ulp, 'ULP')) AS KolièinaPrimka, ID_FS, VrstaFakture, 
	BrojFakture, DatumFakture, (SELECT ID_Skl FROM UlazProizvoda WHERE ID_ULP = FaktureDetaljnoView.ID_Ulp) AS SkladištePredatnica,
	ID_Mat, NazivMat, KolicinaMat, ID_Pro, NazivPro, KolicinaPro, CijenaMatKom, Obrada1 * CijenaObrada1 AS TokarenjeEUR, Obrada2 * CijenaObrada2 AS KaljenjeEUR,
	Obrada3 * CijenaObrada3 AS TvrdTokEUR, Obrada4 * CijenaObrada4 AS Obrada4EUR, Obrada5 * CijenaObrada5 AS Obrada5EUR, CijenaProKom
	FROM FaktureDetaljnoView WHERE ID_Ulp IN(SELECT ID_ULP FROM UlazProizvodaDetaljnoView WHERE ID_IZR IN(SELECT ID_IZR FROM IzlazRobeDetaljnoView WHERE ID_ULR IN((SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE ID_ULR IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD)))))
		OR ID_Ulp IN(SELECT ID_ULP FROM UlazProizvodaDetaljnoView WHERE ID_IZR IN(SELECT ID_IZR FROM IzlazRobeDetaljnoView WHERE ID_ULR IN(SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR FROM UlazRobe WHERE ID_ULD = @TmpULD))))
	