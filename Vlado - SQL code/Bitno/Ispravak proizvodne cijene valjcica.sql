USE FeroApp

UPDATE UlazProizvoda 
	SET CijenaProFink = ((SELECT CijenaKom FROM ProizvodiCijene WHERE ID_Pro = UlazProizvoda.ID_Pro AND Godina = (SELECT YEAR(DatumDokumenta) FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE)) * dbo.PronadjiTecaj((SELECT DatumDokumenta FROM Predatnice WHERE ID_PRE = UlazProizvoda.ID_PRE), 'EUR')) 
	WHERE ID_Skl IN(113, 119) AND CijenaProFink = 0