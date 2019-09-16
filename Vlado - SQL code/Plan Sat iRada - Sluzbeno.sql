USE FxSAP

SELECT     PsrsID, Firma, RadnikID, Ime, Godina, Mjesec, PocetakRadnogVremena, SluzbenoSatiMjesecno, OffsetSati, OffsetDan, Sati01, Oznaka01, Sati02, Oznaka02, Sati03, 
                      Oznaka03, Sati04, Oznaka04, Sati05, Oznaka05, Sati06, Oznaka06, Sati07, Oznaka07, Sati08, Oznaka08, Sati09, Oznaka09, Sati10, Oznaka10, Sati11, Oznaka11, 
                      Sati12, Oznaka12, Sati13, Oznaka13, Sati14, Oznaka14, Sati15, Oznaka15, Sati16, Oznaka16, Sati17, Oznaka17, Sati18, Oznaka18, Sati19, Oznaka19, Sati20, 
                      Oznaka20, Sati21, Oznaka21, Sati22, Oznaka22, Sati23, Oznaka23, Sati24, Oznaka24, Sati25, Oznaka25, Sati26, Oznaka26, Sati27, Oznaka27, Sati28, Oznaka28, 
                      Sati29, Oznaka29, Sati30, Oznaka30, Sati31, Oznaka31
FROM         PlanSatiRadaSluzbeno
WHERE     (Godina = 2012) AND (Mjesec = 12) AND (Ime = 'KOŽINEC BOŽIDAR')