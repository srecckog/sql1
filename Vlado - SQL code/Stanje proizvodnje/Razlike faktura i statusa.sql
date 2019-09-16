USE FeroApp

DECLARE @TmpDatumStatusa date

SET @TmpDatumStatusa = '2016-01-27'

SELECT FaktureDetaljnoView.BrojRN as RN_Tokarenje, ISNULL(FaktureDetaljnoView.BrojRN2, '') AS RN_Kaljenje, ISNULL(FaktureDetaljnoView.BrojRN3, '') AS RN_TvrdoTok, (CASE WHEN ISNULL(FaktureDetaljnoView.Obrada1, 0) = 1 THEN 'Da' ELSE '-' END) AS Tokarenje, (CASE WHEN ISNULL(FaktureDetaljnoView.Obrada2, 0) = 1 THEN 'Da' ELSE '-' END) AS Kaljenje, (CASE WHEN ISNULL(FaktureDetaljnoView.Obrada3, 0) = 1 THEN 'Da' ELSE '-' END) AS TvrdoTok, 
	ISNULL(CAST(SUM(ISNULL(FaktureDetaljnoView.KolicinaPro, 0)) AS int), 0) AS Fakture_Pro, (CASE WHEN ISNULL(FaktureDetaljnoView.Obrada3, 0) = 1 THEN ISNULL(FaktureDetaljnoView.BrojRN3, '') WHEN ISNULL(FaktureDetaljnoView.Obrada2, 0) = 1 THEN ISNULL(FaktureDetaljnoView.BrojRN2, '') ELSE FaktureDetaljnoView.BrojRN END) AS RN_Statusa, 
	ISNULL((SELECT SUM(ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0)) FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE WHEN ISNULL(FaktureDetaljnoView.Obrada3, 0) = 1 THEN ISNULL(FaktureDetaljnoView.BrojRN3, '') WHEN ISNULL(FaktureDetaljnoView.Obrada2, 0) = 1 THEN ISNULL(FaktureDetaljnoView.BrojRN2, '') ELSE FaktureDetaljnoView.BrojRN END)) AND EvidencijaProizvodnjeSta.Status = 1 AND EvidencijaProizvodnjeSta.DatumStatusa = @TmpDatumStatusa), 0) AS Statusi_Pro 
	FROM FaktureDetaljnoView 
	WHERE FaktureDetaljnoView.DatumFakture = @TmpDatumStatusa
	AND FaktureDetaljnoView.VrstaFakture IN(SELECT VrstaFakture FROM VrsteFaktura WHERE CreateASN = 1) 
	AND FaktureDetaljnoView.VrstaTroska = 'Proizvod'
	AND ISNULL(FaktureDetaljnoView.BrojRN, '') <> ''
	GROUP BY BrojRN, ISNULL(Obrada1, 0), ISNULL(Obrada2, 0), ISNULL(Obrada3, 0), ISNULL(BrojRN2, ''), ISNULL(BrojRN3, '')

SELECT (SELECT EvidencijaProizvodnjeZag.BrojRN FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.ID_EPZ = EvidencijaProizvodnjeSta.ID_EPZ) AS BrojRN, SUM(KolicinaOK) AS Kolicina FROM EvidencijaProizvodnjeSta WHERE DatumStatusa = @TmpDatumStatusa AND Status = 1 GROUP BY ID_EPZ