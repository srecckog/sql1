USE FeroApp

SET DATEFORMAT dmy
DECLARE @Od date
DECLARE @Do date
DECLARE @Koeficijent as float
DECLARE @KnEur as float
DECLARE @ManjeOd as float
DECLARE @NetoBruto as float
----------UPISATI PODATKE----------
SET @Koeficijent=3 -- s koliko se dijeli
SET @KnEur=7.5 -- vrijednost Eura
SET @ManjeOd=50 -- ne prikazuj manje od
SET @NetoBruto=1.77
SET @Od='1.2.2017'
SET @Do='28.2.2017'
-----------------------------------
SELECT 
      @Od as 'Od'
      ,@Do as 'Do'
      ,Hala
      , Radnik
      ,CAST(ROUND(SUM(CijenaObradaA*(KolicinaOK-Norma))/@Koeficijent*@KnEur,2) AS MONEY) AS 'Kn neto'
      ,CAST(ROUND(SUM(CijenaObradaA*(KolicinaOK-Norma))/@Koeficijent*@KnEur*@NetoBruto,2) AS MONEY) AS 'Kn bruto'
      ,COUNT(*) as 'Koliko puta'
FROM EvidNormi(@Od, @Do,0)
WHERE ObradaA='1' and KolicinaOK > Norma and Radnik <> '' and Norma > 10 and Napomena1=''
GROUP BY hala, Radnik
HAVING CAST(ROUND(SUM(CijenaObradaA*(KolicinaOK-Norma))/@Koeficijent*@KnEur,2) AS MONEY) > @ManjeOd
ORDER BY hala, 'Kn neto' DESC



select *
from evidnormi('2017-02-01','2017-02-28',0)