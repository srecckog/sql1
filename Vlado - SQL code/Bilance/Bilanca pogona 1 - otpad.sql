USE FeroApp ; DECLARE @TmpDatumOd date, @TmpDatumDo date ; SET @TmpDatumOd = '2013-12-01' ; SET @TmpDatumDo = '2013-12-31'

SELECT DISTINCT ID_Skl
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo
	AND (SELECT MT FROM IzlazRobeDetaljnoView WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) IN('1', '3')
	AND (SELECT OtpadObrada1 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0
	AND ID_Skl < 200
	
SELECT DISTINCT ID_Skl
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo
	AND (SELECT MT FROM IzlazRobeDetaljnoView WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) IN('1', '3')
	AND ((SELECT OtpadObrada2 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0 OR (SELECT OtpadObrada3 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0)
	AND ID_Skl > 200

SELECT ID_ULP, ID_IZR, BrojDokumenta, DatumDokumenta, ID_Pro, KolicinaMat, KolicinaPro, CijenaObrada1, CijenaObrada2, CijenaObrada3, 
	(SELECT OtpadObrada1 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) AS Otpad_tok, 
	(SELECT OtpadObrada2 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) AS Otpad_kalj, 
	(SELECT OtpadObrada3 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) AS Otpad_tt, 
	dbo.CalcVrijednostUlpOtpad(ID_ULP, 0) AS Vrijednost,
	dbo.PronadjiTecaj(DatumDokumenta, 'EUR') AS Teèaj
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo
	AND ID_Skl = 328
	AND (SELECT MT FROM IzlazRobeDetaljnoView WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) IN('1', '3')
	AND ((SELECT OtpadObrada1 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0 OR (SELECT OtpadObrada2 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0 OR (SELECT OtpadObrada3 FROM UlazProizvoda WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) <> 0)