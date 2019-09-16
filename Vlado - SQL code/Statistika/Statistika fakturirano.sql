USE FeroApp

/*SELECT ID_Pro, KolicinaPro,
	((KolicinaMat * dbo.PronadjiTecaj(DatumFakture,'EUR') * (ROUND((CijenaMatKom * (CASE WHEN (SELECT VrstaManTro FROM Skladista WHERE ID_Skl = FaktureDetaljnoViewStat.ID_Skl) IN ('Proizvod','Materijal') THEN (1 + ((SELECT PostotakManTroFak FROM Skladista WHERE ID_Skl = FaktureDetaljnoViewStat.ID_Skl)/100)) ELSE 1 END)),2)))) AS VrijednostMat, 
	((KolicinaPro * dbo.PronadjiTecaj(DatumFakture,'EUR') * (ROUND((Obrada1 * CijenaObrada1 * (CASE WHEN (SELECT VrstaManTro FROM Skladista WHERE ID_Skl = FaktureDetaljnoViewStat.ID_Skl) IN ('Proizvod','Obrada') THEN (1 + ((SELECT PostotakManTroFak FROM Skladista WHERE ID_Skl = FaktureDetaljnoViewStat.ID_Skl)/100)) ELSE 1 END)),2)))) AS VrijednostTok, 
	(KolicinaPro * TezinaProKom) AS Tezina, ID_Skl 
	INTO TmpStatistikaFakturirano 
	FROM FaktureDetaljnoViewStat 
	WHERE ID_Ulp IS NOT NULL 
	AND ID_SKL NOT IN(106, 113, 119) 
	AND DatumFakture BETWEEN '2015-11-01' AND '2015-11-30' 
	AND Obrada1 = 1 
	AND KolicinaPro <> 0 
SELECT ID_PRO, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = TmpStatistikaFakturirano.ID_Pro) AS NazivPro, CAST(SUM(KolicinaPro) AS Float) AS Kolièina, CAST(SUM(VrijednostMat) AS Float) AS VrijednostMat, 
	CAST(SUM(VrijednostTok) AS Float) AS VrijednostTok, CAST(SUM(Tezina) AS Float) AS Težina, ID_Skl 
	FROM TmpStatistikaFakturirano
	GROUP BY ID_Skl, ID_Pro
	ORDER BY ID_Skl, ID_Pro
DROP TABLE TmpStatistikaFakturirano*/
	
/*SELECT ID_Par, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = FaktureDetaljnoViewStat.ID_Pro) AS NazivPro, CAST(SUM(KolicinaPro) AS Float) AS Kolièina, 
	CAST(SUM(KolicinaPro * CijenaProKom * dbo.PronadjiTecaj(DatumFakture,'EUR')) AS Float) AS Vrijednost, 
	CAST(SUM(KolicinaPro * TezinaProKom) AS Float) AS Težina, ID_Skl
	FROM FaktureDetaljnoViewStat 
	WHERE (SELECT ID_Skl FROM UlazProizvoda WHERE ID_ULP = FaktureDetaljnoViewStat.ID_Ulp) in(113, 119)
	AND ID_Ulp IS NOT NULL 
	AND DatumFakture BETWEEN '2015-11-01' AND '2015-11-30' 
	AND KolicinaPro <> 0
	GROUP BY ID_Par, ID_Pro, ID_Skl
	ORDER BY ID_Skl, ID_Par, ID_Pro */