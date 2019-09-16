USE FeroApp

SELECT ID_Pro, VlasnistvoFX, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = FaktureDetaljnoView.ID_Pro) AS IdPro, 
	(SELECT ID_Pro_Kup FROM Proizvodi WHERE ID_Pro = FaktureDetaljnoView.ID_Pro) AS IdProKupac, 
	VrstaFakture, CAST(SUM(KolicinaPro) AS Float) AS Kolièina 
	FROM FaktureDetaljnoView 
	WHERE DatumFakture BETWEEN '2014-12-01' AND '2014-12-31' 
	AND ID_Ulp IS NOT NULL
	AND ID_Par = 221452
	GROUP BY VrstaFakture, VlasnistvoFX, ID_Pro
	ORDER BY VlasnistvoFX, ID_Pro