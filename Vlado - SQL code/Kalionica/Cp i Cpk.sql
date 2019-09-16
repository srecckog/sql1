USE FeroApp;

WITH MjerenjeCpCpk1 AS(
SELECT KratkiNaziv, (CASE WHEN VrstaKT = 'Popustanje' THEN VrstaKT ELSE VrstaKT + ' - ' + PodvrstaKT END) AS Vrsta, ISNULL((SELECT KalionicaKratkiNazivi.Materijal FROM KalionicaKratkiNazivi WHERE KalionicaKratkiNazivi.KratkiNaziv = KalionicaTvrdoceSta.KratkiNaziv), '') AS Materijal, Tvrdoca 
	FROM KalionicaTvrdoceSta WHERE VrstaKT = 'Popustanje'),
MjerenjeCpCpk2 AS(SELECT DENSE_RANK() OVER(ORDER BY KratkiNaziv) AS PozicijaNo, KratkiNaziv, Vrsta, Materijal, Tvrdoca FROM MjerenjeCpCpk1),
MjerenjeCpCpk3 AS(SELECT ROW_NUMBER() OVER(PARTITION BY PozicijaNo ORDER BY PozicijaNo) AS RB, PozicijaNo, KratkiNaziv, Vrsta, Materijal, Tvrdoca FROM MjerenjeCpCpk2),
MjerenjeCpCpk4 AS(SELECT FLOOR((RB - 1)/6) + 1 AS SetNo, RB, PozicijaNo, KratkiNaziv, Vrsta, Materijal, Tvrdoca FROM MjerenjeCpCpk3) 

SELECT PozicijaNo, SetNo, KratkiNaziv, Vrsta, Materijal, COUNT(*) AS BrojMjerenja, CAST(AVG(Tvrdoca) AS decimal(20,10)) AS Prosjek, CAST(STDEV(Tvrdoca) AS decimal(20,10)) AS StdDev 
	FROM MjerenjeCpCpk4 
	GROUP BY PozicijaNo, SetNo, KratkiNaziv, Vrsta, Materijal
	HAVING COUNT(*) = 6
	ORDER BY PozicijaNo, SetNo, KratkiNaziv, Vrsta


USE FeroApp

SELECT * FROM KalionicaTvrdoceCpk('2015-01-01', '2016-12-31', '', '', '', 0, 0)
	ORDER BY PozicijaNo, SetNo, KratkiNaziv, Vrsta