USE FeroApp

-- Izvaditi tvrdoæe (popuštene) ovih radnih naloga.
-- JR.F-588258/1
-- 1874/2016
-- 1773/2016

SELECT B.KratkiNaziv, VrstaKT, PodvrstaKT, CAST(Tvrdoca AS float) AS Tvrdoca, Kolicina, DatumUnosa, VrijemeUnosa, 
	(SELECT KalionicaTvrdoceZag.BrojSarze FROM KalionicaTvrdoceZag WHERE KalionicaTvrdoceZag.ID_KTZ = B.ID_KTZ) AS BrojSarze, 
	(SELECT KalionicaTvrdoceZag.Pec FROM KalionicaTvrdoceZag WHERE KalionicaTvrdoceZag.ID_KTZ = B.ID_KTZ) AS Pec, 
	(SELECT (CASE WHEN B.VrstaKT = 'Popustanje' THEN KalionicaTvrdoceZag.BrojPeciPopustanje ELSE KalionicaTvrdoceZag.BrojPeciKaljenje END) AS BrojPeci FROM KalionicaTvrdoceZag WHERE KalionicaTvrdoceZag.ID_KTZ = B.ID_KTZ) AS BrojPeci 
	FROM KalionicaTvrdoceSta B 
	WHERE B.ID_KTZ IN(SELECT A.ID_KTZ FROM KalionicaTvrdoceZag A WHERE A.BrojSarze IN(SELECT KalionicaKnjigaSmjeneSta.BrojSarze FROM KalionicaKnjigaSmjeneSta WHERE KalionicaKnjigaSmjeneSta.BrojRN IN('1865/2016')))
