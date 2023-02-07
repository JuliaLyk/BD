--1-- 

set nocount on 
if exists (select * from SYS.OBJECTS
where OBJECT_ID= object_id(N'DBO.X'))
drop table X;

declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON --режим неявной транзакции
create table X(K int);
insert X values (1),(2),(3);
set @c = (select count(*) from X);
print 'количество строк в таблице Х:'+cast(@c as varchar(2));
if @flag = 'r' commit;
else rollback;
SET IMPLICIT_TRANSACTIONS OFF

if exists (select * from SYS.OBJECTS
where OBJECT_ID= object_id(N'DBO.X'))
print 'таблица Х есть';
else print 'таблицы Х нет'

--2--
begin try
begin tran   --начало явной транзакции
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='ЛК';
insert AUDITORIUM_TYPE values ('ЛК','Лек');
insert AUDITORIUM_TYPE values('ЛК','Лекци');
commit tran;
end try
begin catch
print 'ошибка'+case
when error_number()=2627 and patindex('%PK_AUDITORIUM_TYPE%',error_message())>0
then 'дубль лекции'
else 'неизвестная ошибка:'+cast(error_number()as varchar(5))+error_message()
end;
if @@trancount>0 rollback tran;
end catch;
--3--
declare @point varchar(32)
			begin try
begin tran
delete AUDITORIUM where AUDITORIUM.AUDITORIUM = '322-1'
set @point = 'p1'; save tran @point;
insert AUDITORIUM values (N'439-3а', N'ЛБ-К', 15, N'439-3а');
set @point = 'p2'; save tran @point
update AUDITORIUM set AUDITORIUM_TYPE = 'ЛК' where AUDITORIUM_CAPACITY = 15;
set @point = 'p3'; save tran @point
truncate table AUDITORIUM;
set @point = 'p4'; save tran @point
insert AUDITORIUM values (N'439-3а', N'ЛБ-К', 15, N'439-3а');
commit tran;
end try
begin catch
print N'Ошибка: ' + case when error_number() = 2627 and patindex('%PK%', error_message()) > 0 
THEN N'Дублирование аудитории'
when error_number() = 547 and patindex('%FK%', error_message()) > 0
then N'Несоответствие внешнего  ключа'
when error_number() = 4712
then N'Невозможно применить TRUNCATE'
else N'Неизвестная ошибка' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print N'контрольная точка: ' + @point;
rollback tran @point;
commit tran;
end;
end catch;


--4-- 
---A---
set transaction isolation level READ UNCOMMITTED
begin transaction
---t1---
select @@SPID,'insert AUDITORIUM','результат', * from AUDITORIUM
                                                 where AUDITORIUM_CAPACITY=15;
select @@SPID,'insert AUDITORIUM','результат', AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM
                                                 where AUDITORIUM_CAPACITY=15;
commit;
---t2---
---B---
begin transaction
select @@SPID
update AUDITORIUM set AUDITORIUM_CAPACITY=11
                  where AUDITORIUM_CAPACITY=15
---t1---
rollback;

--5--
USE UNIVER
---A---
set transaction isolation level READ COMMITTED
begin transaction
select count(*) from AUDITORIUM
                where AUDITORIUM_CAPACITY=60;
---t1---
---t2---
select 'update AUDITORIUM','результат', count(*) from AUDITORIUM
                                        where AUDITORIUM_CAPACITY=60;
commit;
---B---
begin transaction
---t1---
update AUDITORIUM set AUDITORIUM_CAPACITY=11
                  where AUDITORIUM_CAPACITY=60
commit;
---t2---

--6--
USE UNIVER
---A---
set transaction isolation level REPEATABLE READ
begin transaction
select FACULTY_NAME from FACULTY;
---t1---
---t2---
select case
when  FACULTY_NAME='Технология органических веществ' then 'insert AUDITORIUM' else ''
end 'result',  FACULTY_NAME from FACULTY
commit;
---B---
begin transaction
---t1---
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ1',     '-------');
commit;
---t2---

--7--     
---t2---
USE UNIVER
---A---
set transaction isolation level SERIALIZABLE
begin transaction
select * from FACULTY where FACULTY='ТОВ';
---t1---
select FACULTY from FACULTY where FACULTY='ТОВ';
---t2---
commit;
---B---
begin transaction
select * from FACULTY where FACULTY='ТОВ';
---t1---
commit;
select FACULTY from FACULTY where FACULTY='ТОВ';
---t2---
--8--
begin tran 
insert AUDITORIUM_TYPE values('ЛКС','Лексис');
begin tran
update AUDITORIUM_TYPE set AUDITORIUM_TYPE='ЛКС' where AUDITORIUM_TYPE='ЛКС';
commit;
if @@TRANCOUNT>0 rollback;
select 
(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='ЛКС') 'AUDITORIUM_TYPE',
(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='ЛКС') 'AUDITORIUM_TYPE';
