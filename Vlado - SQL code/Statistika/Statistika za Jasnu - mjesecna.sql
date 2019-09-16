USE FeroApp

-- Tokareno
SELECT ID_Pro, NazivPro, CAST(SUM(KolicinaPro) AS Float) AS Kolicina, CAST(SUM(KolicinaPro * TezinaPro) AS Float) AS Tezina, ID_Skl 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2017-01-01' AND '2017-01-31' 
	AND Obrada1 = 1 
	AND ID_Skl IN(SELECT ID_Skl FROM Skladista WHERE Vrsta = 'Skladište gotovih proizvoda' AND ID_Skl > 100)
	GROUP BY ID_Skl, ID_Pro, NazivPro 
	HAVING SUM(KolicinaPro) <> 0
	ORDER BY ID_Skl, ID_Pro
	
-- Kaljeno	
SELECT ID_Pro, NazivPro, CAST(SUM(KolicinaPro) AS Float) AS Kolicina, CAST(SUM(KolicinaPro * TezinaPro) AS Float) AS Tezina, ID_Skl 
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2017-01-01' AND '2017-01-31' 
	AND Obrada2 = 1 
	AND ID_Skl IN(SELECT ID_Skl FROM Skladista WHERE Vrsta = 'Skladište gotovih proizvoda' AND ID_Skl > 100)
	GROUP BY ID_Skl, ID_Pro, NazivPro 
	HAVING SUM(KolicinaPro) <> 0
	ORDER BY ID_Skl, ID_Pro	