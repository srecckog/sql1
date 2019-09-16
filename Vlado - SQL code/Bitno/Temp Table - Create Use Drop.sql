USE TestDB

CREATE TABLE #TmpTable1
	(ID_Tmp int IDENTITY(1,1) PRIMARY KEY,
	Opis varchar(50) NULL,
	Broj decimal(11,2) NULL)
	
insert into #TmpTable1(Opis, Broj) values('Vlado', 10)
insert into #TmpTable1(Opis, Broj) values('Martina', 20)
insert into #TmpTable1(Opis, Broj) values('Bajdo', 5)

SELECT * FROM #TmpTable1

DROP TABLE #TmpTable1