--1--
USE UNIVER
DECLARE @sub char(20), @s char(300)= '';
DECLARE Zksubject CURSOR
                  for SELECT SUBJECT.SUBJECT from SUBJECT
				  WHERE SUBJECT.PULPIT LIKE 'ИСиТ';
OPEN Zksubject;
FETCH Zksubject into @sub;
print 'дисциплины';
while @@FETCH_STATUS = 0
begin 
 set @s = rtrim(@sub)+','+@s;
 FETCH Zksubject into @s;
end;
print @s;
CLOSE Zksubject;
--2--

--LOCAL--

DECLARE S1 CURSOR LOCAL
                  for SELECT SUBJECT.SUBJECT, SUBJECT.PULPIT from SUBJECT;
DECLARE @sub1 char(20), @s1 char(20);
OPEN S1;
FETCH S1 into @sub1,@s1;
print '1.'+@sub1+cast(@s1 as varchar(6));
go
DECLARE @sub1 char(20), @s1 char(20);
FETCH S1 into @sub1,@s1;
print '2.'+@sub1+cast(@s1 as varchar(6));
go
CLOSE S1;
--GLOBAL--
DECLARE S2 CURSOR GLOBAL
                  for SELECT SUBJECT.SUBJECT, SUBJECT.PULPIT from SUBJECT;
DECLARE @sub2 char(20), @s2 char(20);
OPEN S2;
FETCH S2 into @sub2,@s2;
print '1.'+@sub2+cast(@s2 as varchar(6));
go
DECLARE @sub2 char(20), @s2 char(20);
FETCH S2 into @sub2,@s2;
print '2.'+@sub2+cast(@s2 as varchar(6));
go
CLOSE S2;
/*3*/
/*LOCAL STATIC*/
DECLARE myCursor CURSOR LOCAL STATIC
                  for SELECT AUDITORIUM.AUDITORIUM_TYPE,AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
				  WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE '%ЛК%';
DECLARE @t1 char(20), @t2 char(20);
OPEN myCursor;
print 'количество строк:'+cast(@@CURSOR_ROWS as varchar(5));
UPDATE AUDITORIUM set AUDITORIUM_CAPACITY=7 where AUDITORIUM.AUDITORIUM_TYPE='ЛК';
DELETE AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY=7;
FETCH myCursor into @t1,@t2;
while @@FETCH_STATUS = 0
begin 
 print @t1+' '+@t2;
 FETCH myCursor into @t1,@t2;
end;
CLOSE myCursor;
--LOCAL DYNAMIC--
DECLARE myCursor2 CURSOR LOCAL DYNAMIC
                  for SELECT AUDITORIUM.AUDITORIUM_TYPE,AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM
				  WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE '%ЛК%';
DECLARE @t3 char(20), @t4 char(20);
OPEN myCursor2;
print 'количество строк:'+cast(@@CURSOR_ROWS as varchar(5));
UPDATE AUDITORIUM set AUDITORIUM_CAPACITY=7 where AUDITORIUM.AUDITORIUM_TYPE='ЛК';
DELETE AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY=7;
FETCH myCursor2 into @t3,@t4;
while @@FETCH_STATUS = 0
begin 
 print @t3+' '+@t4;
 FETCH myCursor2 into @t3,@t4;
end;
CLOSE myCursor2
--4--
USE UNIVER
DECLARE S4 CURSOR LOCAL DYNAMIC SCROLL
                  for SELECT row_number() over ( order by GROUPS.PROFESSION)N, GROUPS.PROFESSION from GROUPS
				  WHERE GROUPS.FACULTY='ИТ'
DECLARE @sub4 int, @s4 char(50);
OPEN S4;
FETCH FIRST from S4 into @sub4,@s4;
print 'первая строка: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH NEXT from S4 into @sub4,@s4;
print 'следующая строка: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH LAST from S4 into @sub4,@s4;
print 'последняя строка: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH PRIOR from S4 into @sub4,@s4;
print 'предыдущая строка от текущей: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH ABSOLUTE 3 from S4 into @sub4,@s4;
print 'третья строка от начала: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH ABSOLUTE -3 from S4 into @sub4,@s4;
print 'третья строка от конца: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH RELATIVE  5  from S4 into @sub4,@s4;
print 'пятая строка вперед от текущей: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
FETCH RELATIVE -5  from S4 into @sub4,@s4;
print 'пятая строка назад от текущей: '+cast(@sub4 as varchar(3))+'^'+rtrim(@s4);
CLOSE S4;
--5--
DECLARE myCursor5 CURSOR LOCAL DYNAMIC
                  for SELECT PROGRESS.NOTE,PROGRESS.SUBJECT
				  from PROGRESS FOR UPDATE; 
DECLARE @sub5 char(20), @s5 char(20);
OPEN myCursor5;
FETCH myCursor5 into @sub5,@s5;
DELETE PROGRESS WHERE CURRENT OF myCursor5;
FETCH myCursor5 into @sub5,@s5;
UPDATE PROGRESS set NOTE=NOTE+1 WHERE CURRENT OF myCursor5;
CLOSE myCursor5
--6--
DECLARE myCursor6 CURSOR LOCAL DYNAMIC
                  for SELECT PROGRESS.NOTE,PROGRESS.SUBJECT
				  from PROGRESS INNER JOIN STUDENT
				  ON PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT FOR UPDATE; 
DECLARE @sub6 char(20), @s6 char(20);
OPEN myCursor6;
FETCH myCursor6 into @sub6,@s6;
DELETE PROGRESS WHERE NOTE=4;
CLOSE myCursor6


