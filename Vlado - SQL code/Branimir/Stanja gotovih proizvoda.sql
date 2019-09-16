USE FeroTmp


select *
from (
SELECT ID_NarS, BrojRN, DatumIsporuke, (CASE WHEN ISNULL(LoanPosao, 0) = 1 THEN 0 ELSE 1 END) AS VlasnistvoFX, (SELECT ID_Par FROM NarudzbeZag WHERE ID_NarZ = NarudzbeSta.ID_NarZ) AS ID_Par, 
	ID_Mat, ID_Pro, KolicinaNar, (CASE WHEN ISNULL(Obrada1, 0) = 1 THEN 1 ELSE 0 END) AS Tokarenje, ISNULL(CijenaObrada1, 0) AS CijenaTok, 
	(CASE WHEN ISNULL(Obrada2, 0) = 1 THEN 1 ELSE 0 END) AS Kaljenje, ISNULL(CijenaObrada2, 0) AS CijenaKalj, 
	(CASE WHEN ISNULL(Obrada3, 0) = 1 THEN 1 ELSE 0 END) AS TvrdoTok, ISNULL(CijenaObrada3, 0) AS CijenaTT, 
	ISNULL((CASE WHEN ISNULL(Obrada1, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaOK, 0)) FROM EvidencijaProizvodnjeView WHERE BrojRN = NarudzbeSta.BrojRN1) ELSE 0 END), 0) AS ProizvedenoTok, 
	ISNULL((CASE WHEN ISNULL(Obrada2, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaOK, 0)) FROM EvidencijaProizvodnjeView WHERE BrojRN = NarudzbeSta.BrojRN2) ELSE 0 END), 0) AS ProizvedenoKalj, 
	ISNULL((CASE WHEN ISNULL(Obrada3, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaOK, 0)) FROM EvidencijaProizvodnjeView WHERE BrojRN = NarudzbeSta.BrojRN3) ELSE 0 END), 0) AS ProizvedenoTvrdoTok, 
	ISNULL((CASE WHEN ISNULL(Obrada1, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaPro, 0)) FROM FaktureSta WHERE BrojRN = NarudzbeSta.BrojRN AND Obrada1 = 1) ELSE 0 END), 0) AS FakturiranoTok, 
	ISNULL((CASE WHEN ISNULL(Obrada2, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaPro, 0)) FROM FaktureSta WHERE BrojRN = NarudzbeSta.BrojRN AND Obrada2 = 1) ELSE 0 END), 0) AS FakturiranoKalj, 
	ISNULL((CASE WHEN ISNULL(Obrada3, 0) = 1 THEN (SELECT SUM(ISNULL(KolicinaPro, 0)) FROM FaktureSta WHERE BrojRN = NarudzbeSta.BrojRN AND Obrada3 = 1) ELSE 0 END), 0) FakturiranoTvrdoTok 
	FROM NarudzbeSta 
	WHERE BazniRN = 1 
	AND Aktivno = 1 
	AND (SELECT VrstaNar FROM NarudzbeZag WHERE ID_NarZ = NarudzbeSta.ID_NarZ) = 'Prsteni'

	AND DatumIsporuke IS NOT NULL
	) x1
	where id_par=274
	ORDER BY DatumIsporuke