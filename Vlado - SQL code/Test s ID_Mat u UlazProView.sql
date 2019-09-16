USE FeroAppTmp

SELECT ID_Skl, ID_Mat, (SELECT NazivMat FROM Materijali WHERE ID_Mat = UlazProizvodaDetaljnoView.ID_Mat) AS NazivMat, SUM(KolicinaMat) AS Kolièina_mat, 
	SUM(OtpadMat) AS Otpad_mat, ID_Pro, MAX(NazivPro) AS NazivPro, SUM(KolicinaPro) AS Kolièina_pro, SUM(OtpadProUkupno) AS Otpad_pro,
	(SELECT OmjerPro FROM Materijali WHERE ID_Mat = UlazProizvodaDetaljnoView.ID_Mat) AS Omjer_MatPro
	FROM UlazProizvodaDetaljnoView WHERE DatumDokumenta BETWEEN '2013-01-01' AND '2013-03-31' AND ID_Skl IN(126,128)
	GROUP BY ID_Skl, ID_Mat, ID_Pro
	ORDER BY ID_Skl, ID_Pro, ID_Mat