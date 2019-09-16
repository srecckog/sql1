USE FeroApp

SELECT * INTO TempFaktureSta FROM FaktureSta WHERE Godina = 2013
ALTER TABLE TempFaktureSta DROP COLUMN ID_ProC
UPDATE TempFaktureSta SET Godina = 2014
INSERT INTO FaktureSta SELECT * FROM TempFaktureSta
DROP TABLE TempFaktureSta