USE FeroApp

--UPDATE UlazProizvoda SET CijenaProFink = dbo.PronadjiTecaj((SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE), 'EUR') * (SELECT CijenaKom FROM ProizvodiCijene WHERE Godina = 2013 AND ID_Pro = UlazProizvoda.ID_Pro)
--	WHERE ID_ULP IN(SELECT ID_ULP FROM UlazProizvodaDetaljnoView WHERE ID_Skl = 119 AND CijenaProFink = 0)

SELECT * FROM UlazProizvodaDetaljnoView WHERE ID_Skl = 119 AND CijenaProFink = 0 ORDER BY DatumDokumenta

--SELECT * FROM StanjeULP('2013-09-30') WHERE ID_Skl = 119 AND ID_Pro = 990363 AND SaldoKolPro <> 0