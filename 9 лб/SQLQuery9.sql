 exec sp_helpindex'AUDITORIUM'
  exec sp_helpindex'AUDITORIUM_TYPE'
   exec sp_helpindex'FACULTY'
    exec sp_helpindex'GROUPS'
	 exec sp_helpindex'PROFESSION'
	  exec sp_helpindex'PROGRESS'
	   exec sp_helpindex'PULPIT'
	    exec sp_helpindex'STUDENT'
		 exec sp_helpindex'SUBJECT'
		  exec sp_helpindex'TEACHER'
--1--
use UNIVER
 exec sp_helpindex'AUDITORIUM'
CREATE table #LAB9 ( TIND int, TFIELD varchar(100));
SET nocount on ; 
 declare @R int = 0;
 while @R<1000
 begin
 insert #LAB9(TIND,TFIELD)
 values(floor(20000*rand()), replicate('строка',10));
 if (@R%100=0)
 print @R; 
 set @R = @R +1;
 end;
 SELECT * FROM #LAB9 where TIND between 1500 and 2500 order by TIND 

 checkpoint;  --фиксация БД
 DBCC DROPCLEANBUFFERS;  --очистить буферный кэш
 CREATE clustered index #LAB9_CL on #LAB9(TIND asc)

 --2--
 CREATE table #EX
 (TKEY int,
 CC int identity(1,1),
 TF varchar(100));
 
 set nocount on;
 declare @i int =0;
 while @i<10000
 begin
 INSERT #EX(TKEY,TF) values(floor(10000*rand()),replicate('строка',10));
 set @i=@i+1;
 end;

SELECT count(*)[кол строк]from #EX;
SELECT*from #EX

--составной  индекс
CREATE index #EX_NONCLU on #EX(TKEY,CC)

SELECT *from #EX where TKEY>1500 and CC<4500;
SELECT *from #EX order by TKEY,CC

SELECT *from #EX WHERE TKEY=556 AND CC>3

--3--некластеризованный индекс покрытия 
 CREATE table #EX_2 
 (TKI int,
 FF int identity(1,1),
 TFC varchar(100));
 
set nocount on;
declare @y int=0;
while @y<999
begin 
INSERT #EX_2(TKI,TFC)values (floor(999*rand()),replicate('строка',10));
set @y=@y+1
end;

CREATE index #EX_2TKEY_X  on #EX_2(TKI)INCLUDE(FF)
SELECT FF from #EX_2 where TKI<10000

--4--некластеризованный фильтруемый индекс
SELECT*FROM #EX where TKEY between 5000 and 20000;
SELECT *FROM #EX WHERE TKEY>=5000 AND TKEY<20000;
CREATE index #EX_WHERE on #EX(TKEY) where (TKEY >=5000 AND TKEY<20000);

--5-- 
CREATE   index #EX_TKEY ON #EX(TKEY); 

  SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
  WHERE name is not null

     INSERT top(10000) #EX(TKEY, TF) select TKEY, TF from #EX;

	 --реорганизация 
	ALTER index #EX_TKEY on #EX reorganize;

	--перестройка
	ALTER index #EX_TKEY on #EX rebuild with (online=off);


--6--
DROP index #EX_TKEY on #EX;

    CREATE index #EX_TKEY on #EX(TKEY) with (fillfactor = 65);

	INSERT top(50)percent INTO #EX(TKEY, TF) 
    SELECT TKEY, TF  FROM #EX;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
       ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
       WHERE name is not null;


