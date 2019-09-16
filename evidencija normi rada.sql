SELECT ENR.Radnik, ENR.Vrsta, ENR.Firma, ENR.Datum, ENR.Hala, ENR.Smjena, ENR.Linija, ENR.BrojRN, ENR.Proizvod, ENR.Norma, ENR.KolicinaOK 
FROM EvidNormiRada('2017-01-04', '2017-01-04') ENR 
WHERE ENR.Radnik = 'JORDAN KARLO'


SELECT *
FROM EvidNormiRada('2017-01-04', '2017-01-04') ENR 
WHERE ENR.Radnik = 'JORDAN KARLO'


select x1.*,x1.kn*x1.vrijednost as stim1
from 
(
select *,(kolicinaok-Norma) kn, (ObradaA*CijenaObradaA+ObradaB*CijenaObradaB+ObradaC*CijenaObradaC) vrijednost
FROM EvidNormi('2017-2-1', '2017-02-28',0) ENR 
) x1

WHERE ENR.Radnik = 'JORDAN KARLO'