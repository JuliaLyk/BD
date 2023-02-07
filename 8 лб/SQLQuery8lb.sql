use UNIVER;

--1--
DECLARE 
@a char ='j',
@b varchar (3)='ФИТ',
@c datetime,
@d time,
@h int,
@i smallint,
@f tinyint,
@g numeric(12,5);
SET @c='12.07.1994';--getdate();
SET @d='00:00:00';--getutcdate();
SELECT @c=PDATE from PROGRESS
SELECT @h=max(AUDITORIUM_CAPACITY) from AUDITORIUM;
SELECT @i=min(NOTE) from PROGRESS;
SELECT @f=count(NOTE) from PROGRESS;
SELECT @a char, @b varchar, @c datetime;
PRINT 'int: '+cast(@h as varchar(10));
PRINT 'smallint: '+cast(@i as varchar(10));
PRINT 'tinyint: '+cast(@f as varchar(10));

--2--
declare @i1 int, @i2 int, @i3 real, @i4 real, @i5 real;
select @i1=sum(AUDITORIUM_CAPACITY) from AUDITORIUM;
select @i2=avg(AUDITORIUM_CAPACITY) from AUDITORIUM;
set @i3=(select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY<@i2);
set @i5=(select count(*) from AUDITORIUM);
set @i4=cast((@i3/@i5)*100 as numeric(4,2));
if @i1>200
begin
select @i1 sum, @i2 avg, @i3 count, @i4'%';
end
else print 'capacity: '+@i1;

--3--
PRINT 'count of rows:'+CAST (@@ROWCOUNT AS VARCHAR );--число обработанных строк
PRINT 'version:'+CAST (@@VERSION AS VARCHAR);
PRINT 'identification of process:'+CAST (@@SPID AS VARCHAR);--возвращает системный идентификатор процесса
PRINT 'code of last error:'+CAST (@@ERROR AS VARCHAR);
PRINT 'servername: '+CAST (@@SERVERNAME AS VARCHAR);
PRINT 'level of tran:'+CAST (@@TRANCOUNT AS VARCHAR);--возвращает уровень вложенности транзакции
PRINT 'fetch status:'+CAST (@@FETCH_STATUS AS VARCHAR);--проверка результата считывания строк результирующего набора
PRINT 'level of procedure:'+CAST (@@NESTLEVEL AS VARCHAR);--уровень вложенности текущей проце-дуры

--4----возвращает наибольшее целочиленное значение которое равно или меньше числа(floor)
go
declare @t float=0.3, @x float=0.5, @z float;
if (@t>@x) set @z=power(sin(@t),2)--возвращает m возведенную в n
else if(@t<@x) set @z=1-exp(@x-2)--возращает возведенные в степень числа 
else set @z=4*(@t+@x)
print 'z= '+cast(@z as varchar(10));
go

go
select replace('Лыкова Юлия Дмитриевна','Юлия Дмитриевна','Ю.Д.') ФИО
 go

go
declare @currentDate date = GETDATE();
declare	@nextmohth int = MONTH(@currentDate)+1;
select IDSTUDENT, BDAY, datediff(year,BDAY,@currentDate) [YEARS OLD] from STUDENT
where MONTH(BDAY) = @nextmohth
go

go
select distinct DATENAME(dw,PDATE) [День сдачи] from PROGRESS 
where SUBJECT = 'СУБД';
go
--5--
DECLARE @x INT=(SELECT COUNT(*) FROM AUDITORIUM);
IF (SELECT COUNT(*) FROM AUDITORIUM)>5
BEGIN
PRINT 'кол аудиторий больше 5';
PRINT'кол='+CAST (@x AS VARCHAR (10));
end;
begin
PRINT 'Кол аудиторий меньшеш 5';
PRINT '='+CAST (@x AS VARCHAR (10));
END;

--6--
SELECT CASE 
WHEN NOTE BETWEEN 0 AND 3 THEN ''
WHEN NOTE BETWEEN 4 AND 6 THEN ''
WHEN NOTE BETWEEN 6 AND 9 THEN ''

ELSE 'ПЛОХО'
END  NOTE ,COUNT (*) [кол оценок ]
FROM PROGRESS
GROUP BY CASE 
WHEN NOTE BETWEEN 0 AND 3 THEN ''
WHEN NOTE BETWEEN 4 AND 6 THEN ''
WHEN NOTE BETWEEN 6 AND 9 THEN ''

ELSE 'ПЛОХО'
END
		
--7--&&&&&&&&&&&&&&&&&&&&&&&&&				
CREATE TABLE #EXPLRE
( OP INT,
OP2 varchar(50),
OP3 INT
);
SET nocount on ;
DECLARE @i2 int =0;
WHILE @i2<100
begin
INSERT #EXPLRE(OP,OP2)
values (floor(30000*rand()),replicate('строка',10));
IF (@i2 % 100 = 0)
print @i2;
SET @i2=@i2 +1;
end;


--8--
DECLARE @jul int=15
print @jul+1
print @jul+2
RETURN
print @jul+3


--9--
begin TRY
UPDATE AUDITORIUM set AUDITORIUM_TYPE='206-1'
where AUDITORIUM_TYPE='301-1'
end try
begin CATCH
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch
--область видимости пременных()
--пакет ()
--return(предотвращает работу пакет)