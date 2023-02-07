--1--
DEALLOCATE SpDists

use UNIVER
Declare @sb char(20), @t char(300) = '';
Declare SpDists CURSOR for select SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ';
OPEn SpDists;
Fetch SpDists into @sb;
print 'Список дисциплин';
while @@FETCH_STATUS = 0
begin
set @t = rtrim(@sb)+ ','+@t;
fetch SpDists into @sb;
end;
print @t;
Close SpDists;		

--2--
-------CURSOR LOCAL


DECLARE Local_Curs CURSOR LOCAL
for SELECT SUBJECT from SUBJECT where SUBJECT.PULPIT='ИСиТ';
DECLARE @sp char(20);
OPEN Local_Curs;
FETCH Local_Curs into @sp;
print 'Первая дисциплина:'+@sp;
go
DECLARE @sp char(20);
FETCH Local_Curs into @sp;
print 'Вторая дисциплина:'+@sp;
go

-----CURSOR GLOBAL
declare notesGl CURSOR GLOBAL 
for select NOTE, SUBJECT from PROGRESS;
declare @nt real, @subj char(20);
OPEN notesGl;
fetch notesGl into @nt, @subj;
print '1. '+@subj+cast(@nt as varchar(5));
go
declare @nt real, @subj char(20);
fetch notesGL into @nt, @subj;
print '2. '+@subj+cast(@nt as varchar(5));
Close notesGl;
deallocate notesGl;
go

--3--CURSOR Local statiс --не работает

declare @tid char(50), @tnm char(10), @tgn char(10);
declare Auditorium CURSOR Local dynamic 
for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
FROM AUDITORIUM WHERE AUDITORIUM.AUDITORIUM_TYPE='ЛБ-К';
open Auditorium;
print 'Количество строк: '+ cast(@@CURSOR_ROWS as varchar(5));
UPDATE AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 100 where AUDITORIUM= '206-1';
DELETE AUDITORIUM where AUDITORIUM='236-1';
INSERT AUDITORIUM (AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values('236-1', 'ЛК', 60, 236-1);
FETCH Auditorium into @tid, @tnm, @tgn;
while @@FETCH_STATUS=0
begin
print @tid + ''+@tnm+''+@tgn;
fetch Auditorium into @tid, @tnm, @tgn;
end;
close Auditorium;

--4--
declare @tc int, @rn char(50);
declare Primer cursor local dynamic scroll
for select row_number() over (order by NAME) N, NAME from dbo.STUDENT where IDGROUP = 4
OPEN Primer;
fetch Primer into @tc, @rn;
print 'следующая строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch LAST from Primer into @tc, @rn;
print 'последняя строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch FIRST from Primer into @tc, @rn;
print 'первая строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch NEXT from Primer into @tc, @rn;
print 'следующая строка за текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch PRIOR from Primer into @tc, @rn;
print 'предыдущая строка от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch ABSOLUTE 3 from Primer into @tc, @rn;
print 'третья строка от начала: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch ABSOLUTE -3 from Primer into @tc, @rn;
print 'третья строка от конца: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch RELATIVE  5 from Primer into @tc, @rn;
print 'пятая строка вперед от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch RELATIVE  -5  from Primer into @tc, @rn;
print 'пятая строка назад от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
CLOSE Primer;

--5--
use UNIVER;
SELECT IDSTUDENT,IDGROUP,NAME from STUDENT where IDGROUP<7;
declare @tn char(20),@tf real,@tk nvarchar(100);
declare Primer2 cursor local dynamic
for SELECT IDSTUDENT,IDGROUP,NAME from STUDENT where IDGROUP<7 FOR UPDATE;
OPEN Primer2;
FETCH Primer2 into @tn,@tf,@tk;
DELETE STUDENT WHERE CURRENT OF Primer2;
FETCH Primer2 into @tn,@tf,@tk;
UPDATE STUDENT SET IDGROUP+=1 WHERE CURRENT OF Primer2;
CLOSE Primer2;
SELECT IDSTUDENT,IDGROUP,NAME FROM STUDENT WHERE IDGROUP<7;

--6-- не работает

declare @idstud int, @note int;
declare Primer3 cursor local dynamic
for select IDSTUDENT, NOTE from PROGRESS where IDSTUDENT = 1017 for update;
open Primer3;
FETCH Primer3 into @idstud, @note;
update PROGRESS set NOTE = NOTE +1 where CURRENT OF Primer3;
Close Primer3;


declare @idstud int;
declare Primer4 cursor local dynamic
for select IDSTUDENT from STUDENT where IDSTUDENT = 1033 for update;
open Primer4;
FETCH Primer4 into @idstud;
DELETE STUDENT where CURRENT OF Primer4;
Close Primer4;

declare @idstud int, @name char(30);
declare Primer4 cursor local dynamic
for select IDSTUDENT, NAME from STUDENT where IDSTUDENT = 1027 for update;
open Primer4;
FETCH Primer4 into @idstud, @name;
UPDATE STUDENT set NAME = 'Романов Роман Романович' where CURRENT OF Primer4;
Close Primer4;



------------------MyBase--------------------
use DB_Lykova

--1--
declare @k char(30),@t char(100)='';
declare ME cursor 
for select Контактное_лицо from CLIENTS;
OPEN ME;
FETCH ME into @k;
print 'Контактное_лицо';
while @@FETCH_STATUS=0
begin 
set @t=RTRIM(@k)+','+@t;
FETCH ME INTO @k;
end;
print @t;
CLOSE ME;

--3--
DECLARE CREDI CURSOR global 
FOR SELECT CLIENTS.Контактное_лицо,CLIENTS.Телефон FROM CLIENTS 
DECLARE @f char(30),@c char(30);
OPEN CREDI;
FETCH CREDI INTO @f,@c;
print 'оп '+ @f +cast(@c as varchar (10));
go
DECLARE @f char(30),@c real;
OPEN CREDI;
FETCH CREDI INTO @f,@c;
print 'оп '+ @f +cast(@c as varchar (10));
go

--4--
declare @tc int, @rn char(50);
declare Primer0 cursor local dynamic scroll
for select row_number() over (order by Контактное_лицо) N, CLIENTS.Контактное_лицо from dbo.CLIENTS where CLIENTS.Телефон = 7673373894
OPEN Primer0;
fetch Primer0 into @tc, @rn;
print 'следующая строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch LAST from Primer0 into @tc, @rn;
print 'последняя строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch FIRST from Primer0 into @tc, @rn;
print 'первая строка: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch NEXT from Primer0 into @tc, @rn;
print 'следующая строка за текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch PRIOR from Primer0 into @tc, @rn;
print 'предыдущая строка от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch ABSOLUTE 3 from Primer0 into @tc, @rn;
print 'третья строка от начала: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch ABSOLUTE -3 from Primer0 into @tc, @rn;
print 'третья строка от конца: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch RELATIVE  5 from Primer0 into @tc, @rn;
print 'пятая строка вперед от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
fetch RELATIVE  -5  from Primer0 into @tc, @rn;
print 'пятая строка назад от текущей: '+cast(@tc as varchar(3))+rtrim(@rn);
CLOSE Primer0;

--6--
declare @idstud char(30), @note int;
declare Prime cursor local dynamic
for select Наименование_кредита, Ставка from CREDITS where Ставка = 16 for update;
open Prime;
FETCH Prime into @idstud, @note;
update CREDITS set Ставка = Ставка +10 where CURRENT OF Prime;
Close Prime;

declare @idstud int;
declare Prime cursor local dynamic
for select Сумма from OFORMLENN_CREDITS where Сумма = 5647 for update;
open Prime;
FETCH Prime into @idstud;
DELETE OFORMLENN_CREDITS where CURRENT OF Prime;
Close Prime;

declare @idstud char(30), @name char(30);
declare Primer4 cursor local dynamic
for select OFORMLENN_CREDITS.Название_кредита, OFORMLENN_CREDITS.Сумма from OFORMLENN_CREDITS where OFORMLENN_CREDITS.Сумма = 1728390 for update;
open Primer4;
FETCH Primer4 into @idstud, @name;
UPDATE OFORMLENN_CREDITS set Название_кредита = 'jjj' where CURRENT OF Primer4;
Close Primer4;