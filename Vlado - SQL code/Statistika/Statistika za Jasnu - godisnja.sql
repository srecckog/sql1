USE FeroApp 
DECLARE @TmpDatumOd date, @TmpDatumDo date

SET @TmpDatumOd = '2015-01-01'
SET @TmpDatumDo = '2015-12-31'

/*SELECT ID_Skl, (SELECT Skladista.NazivSkladista FROM Skladista WHERE Skladista.ID_Skl = UlazProizvodaDetaljnoView.ID_Skl) AS NazivSkl, CAST(SUM(TezinaPro * KolicinaPro) AS float) AS Kg 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo 
	GROUP BY ID_Skl
	ORDER BY ID_Skl*/

/*SELECT ID_Skl, VlasnistvoFX, (SELECT Skladista.NazivSkladista FROM Skladista WHERE Skladista.ID_Skl = FaktureDetaljnoViewStat.ID_Skl) AS NazivSkl, 
	(SELECT (CASE WHEN Skladista.Lokacija = 'Zona' THEN 'P2' ELSE 'P1' END) FROM Skladista WHERE Skladista.ID_Skl = FaktureDetaljnoViewStat.ID_Skl) AS Lokacija, 
	CAST(SUM(KolicinaMat * TezinaMatKom) AS float) AS TezinaMat_Kg, CAST(SUM(KolicinaPro * TezinaProKom) AS float) AS TezinaPro_Kg, 
	CAST(SUM(KolicinaMat * CijenaMatKom * TecajValute) AS float) AS IznosMat, CAST(SUM(KolicinaPro * CijenaObrada1 * ISNULL(Obrada1, 0) * TecajValute) AS float) AS Tokarenje, 
	CAST(SUM(KolicinaPro * CijenaObrada2 * ISNULL(Obrada2, 0) * TecajValute) AS float) AS Kaljenje, CAST(SUM(KolicinaPro * CijenaObrada3 * ISNULL(Obrada3, 0) * TecajValute) AS float) AS TvrdoTok, 
	CAST((CASE WHEN VlasnistvoFX = 1 THEN SUM(KolicinaPro * CijenaProKom * TecajValute) ELSE -1 END) AS float) AS Fakturirano 
	FROM FaktureDetaljnoViewStat 
	WHERE DatumFakture BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_Skl NOT IN(113, 119)
	AND ID_Ulp IN(SELECT UlazProizvodaDetaljnoView.ID_ULP FROM UlazProizvodaDetaljnoView WHERE UlazProizvodaDetaljnoView.DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo)
	GROUP BY ID_Skl, VlasnistvoFX
	ORDER BY ID_Skl*/

/*SELECT ID_Skl, VlasnistvoFX, (SELECT Skladista.NazivSkladista FROM Skladista WHERE Skladista.ID_Skl = FaktureDetaljnoViewStat.ID_Skl) AS NazivSkl, 
	(SELECT (CASE WHEN Skladista.Lokacija = 'Zona' THEN 'P2' ELSE 'P1' END) FROM Skladista WHERE Skladista.ID_Skl = FaktureDetaljnoViewStat.ID_Skl) AS Lokacija, 
	CAST(SUM(KolicinaMatKg) AS float) AS TezinaMat_Kg, CAST(SUM(KolicinaPro * TezinaProKom) AS float) AS TezinaPro_Kg, 
	CAST(SUM(KolicinaMat * CijenaMatKom * TecajValute) AS float) AS IznosMat, CAST(SUM(KolicinaPro * CijenaObrada1 * ISNULL(Obrada1, 0) * TecajValute) AS float) AS Tokarenje, 
	CAST(SUM(KolicinaPro * CijenaObrada2 * ISNULL(Obrada2, 0) * TecajValute) AS float) AS Kaljenje, CAST(SUM(KolicinaPro * CijenaObrada3 * ISNULL(Obrada3, 0) * TecajValute) AS float) AS TvrdoTok, 
	CAST((CASE WHEN VlasnistvoFX = 1 THEN SUM(KolicinaPro * CijenaProKom * TecajValute) ELSE -1 END) AS float) AS Fakturirano 
	FROM FaktureDetaljnoViewStat 
	WHERE DatumFakture BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_Skl IN(113, 119)
	AND ID_Ulp IN(SELECT UlazProizvodaDetaljnoView.ID_ULP FROM UlazProizvodaDetaljnoView WHERE UlazProizvodaDetaljnoView.DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo)
	GROUP BY ID_Skl, VlasnistvoFX
	ORDER BY ID_Skl*/