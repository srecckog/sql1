USE FeroApp

-- DECLARE @TmpIdSklMat smallint ; SET @TmpIdSklMat = 300
-- DELETE FROM VezeDokSta WHERE ID_ULR IN(SELECT UlazRobe.ID_ULR FROM UlazRobe WHERE UlazRobe.ID_SKL = @TmpIdSklMat)
-- DELETE FROM FaktureSta WHERE ID_Ulp IN(SELECT UlazProizvodaDetaljnoView.ID_ULP FROM UlazProizvodaDetaljnoView WHERE UlazProizvodaDetaljnoView.ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_Skl = @TmpIdSklMat))
-- DELETE FROM FaktureSta WHERE ID_Izr IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_Skl = @TmpIdSklMat)
-- DELETE FROM UlazProizvoda WHERE ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_SKL = @TmpIdSklMat)
-- DELETE FROM UlazProizvodaKorekcija WHERE ID_UPK IN(SELECT UpkDetaljnoView.ID_UPK FROM UpkDetaljnoView WHERE ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE ID_Skl = @TmpIdSklMat))
-- DELETE FROM IzlazRobeKorekcija WHERE ID_IRK IN(SELECT IrkDetaljnoView.ID_IRK FROM IrkDetaljnoView WHERE IrkDetaljnoView.ID_SKL = @TmpIdSklMat)
-- DELETE FROM IzlazRobe WHERE ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_SKL = @TmpIdSklMat AND IzlazRobeDetaljnoView.VrstaDokumenta = 'Povrat')
-- DELETE FROM IzlazRobe WHERE ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_SKL = @TmpIdSklMat)
-- DELETE FROM UlazRobeKorekcija WHERE ID_URK IN(SELECT UrkDetaljnoView.ID_URK FROM UrkDetaljnoView WHERE ID_SKL = @TmpIdSklMat)
-- DELETE FROM UlazRobe WHERE ID_SKL = @TmpIdSklMat

--SELECT * FROM IzlazRobeDetaljnoView WHERE ID_SKL = @TmpIdSklMat

SELECT (SELECT MAX(UlazRobeDetaljnoView.DatumDokumenta) FROM UlazRobeDetaljnoView WHERE UlazRobeDetaljnoView.ID_SKL = Skladista.ID_Skl) AS MaxDatumUlaza, 
	(SELECT MAX(IzlazRobeDetaljnoView.DatumIzlaza) FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_SKL = Skladista.ID_Skl) AS MaxDatumIzlaza, 
	* 
	FROM Skladista 
	WHERE (FakturirajOtpad = 1 OR FakturirajOtpadMat = 1) 
	AND Vrsta = 'Skladište materijala'

SELECT (SELECT MAX(UlazProizvodaDetaljnoView.DatumDokumenta) FROM UlazProizvodaDetaljnoView WHERE UlazProizvodaDetaljnoView.ID_SKL = Skladista.ID_Skl) AS MaxDatumUlazaPro, 
	(SELECT MAX(FaktureDetaljnoViewStat.DatumFakture) FROM FaktureDetaljnoViewStat WHERE FaktureDetaljnoViewStat.ID_SKL = Skladista.ID_Skl) AS MaxDatumIzlaza, 
	* 
	FROM Skladista 
	WHERE (FakturirajOtpad = 1 OR FakturirajOtpadMat = 1) 
	AND Vrsta = 'Skladište gotovih proizvoda'

-- SELECT * FROM StanjeULP('2199-12-31') WHERE ID_IZR IN(SELECT IzlazRobeDetaljnoView.ID_IZR FROM IzlazRobeDetaljnoView WHERE IzlazRobeDetaljnoView.ID_SKL = 300) ORDER BY DatumDokumenta