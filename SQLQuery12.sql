Use UNIVER;
--1--
go 
create PROCEDURE PSUBJECT
as
begin
declare @k int = (select count(*)from SUBJECT);
select * from SUBJECT;
return @k;
end;			

declare @r int;
EXEC @r=PSUBJECT;
print'' + cast(@r as varchar(3));

--drop procedure psubject--

--2--
Alter procedure PSUBJECT @p varchar(20) , @c int output
as 
begin
declare @k int = (select count(*) from SUBJECT);
print '��������� @p='+@p+',@c'+cast(@c as varchar(3));
select * from SUBJECT where PULPIT=@p;
set @c= @@rowcount;/*������� ���������� ���������� ���������� ����� ��� ���������� ��������� ����������*/
return @k;
end;

EXEC PSUBJECT '����',13

--3--
CREATE table #SUBJECT
(   SUBJECT nvarchar(10),
	SUBJECT_NAME varchar(100),
	PULPIT nvarchar(20)
)

alter procedure PSUBJECT @p varchar(20)
as begin
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT where PULPIT=@p;
end;

INSERT #SUBJECT exec PSUBJECT @p='����';
INSERT #SUBJECT exec PSUBJECT @p='��';

select * from #SUBJECT

--4--
--drop procedure PAUDITORIUM_INSERT
USE UNIVER
go
alter procedure PAUDITORIUM_INSERT
@a CHAR(20),@n VARCHAR(50),@c INT,@t CHAR(10)
as 
declare @rc int =1;
begin try
insert into AUDITORIUM (AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
			values (@a,@n,@c,@t)
return @rc;
end try
begin catch
print '����� ������:'+ cast(error_number() as varchar(6));
print '���������:'+error_message();
print '�������:'+cast(error_severity() as varchar(6));
print '�����:'+cast(error_state() as varchar(8));
print '����� ������:'+cast(error_line() as varchar(8));
if error_procedure() is not null
print '��� ���������:'+error_procedure();
return -1;
end catch;

declare @rc int;
exec @rc=PAUDITORIUM_INSERT @a='777-7',@n='��',@c=18,@t='777-7';
print ''+cast(@rc as varchar(3));


--5--
--drop procedure SUBJECT_REPORT--
CREATE procedure SUBJECT_REPORT @p CHAR(10)
as declare @rc int =0;
begin try
	declare @tv char(20), @t char(300)='';
	declare SUBJECT_CURSOR CURSOR for
	select SUBJECT from SUBJECT where PULPIT =@p;
	if not exists (select SUBJECT from SUBJECT where PULPIT =@p)
	raiserror('mistake',11,1);
	else
	open SUBJECT_CURSOR;
	fetch SUBJECT_CURSOR into @tv;
	print 'PULPIT';
	while @@FETCH_STATUS=0
	begin
	set @t=rtrim(@tv)+','+@t;
	set @rc= @rc+1;
	fetch SUBJECT_CURSOR into @tv;
	end;
print @t;
close SUBJECT_CURSOR;
return @rc;
end try

begin catch
print '������ � ����������'
if error_procedure() is not null
print 'name procedure:'+error_procedure();/*���������� ��� �������� ��������� ��� ��������, � ������� ��������� ������.*/
return @rc;
end catch;

declare @rc int ;
exec @rc=SUBJECT_REPORT @p='����';
print '���-�� ���������'+cast(@rc as varchar(3));

--6--
--drop procedure PAUDITORIUM_INSERTX
USE UNIVER
go

CREATE procedure PAUDITORIUM_INSERTX
@a CHAR(20),@n VARCHAR(50),@c INT,@t CHAR(10), @tn nvarchar(50)
as declare @rc int =1;
begin try
	set transaction isolation level SERIALIZABLE;
	begin tran
	insert into AUDITORIUM (AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
			values (@a,@n,@c,@t)
	exec PAUDITORIUM_INSERT @n,@c,@t;
	commit tran;
    return @rc;
end try
begin catch
print '����� ������:'+ cast(error_number() as varchar(6));
print '���������:'+error_message();
print '�������:'+cast(error_severity() as varchar(6));
print '�����:'+cast(error_state() as varchar(8));
print '����� ������:'+cast(error_line() as varchar(8));
if error_procedure() is not null
print '��� ���������:'+error_procedure();
return -1;
end catch;

declare @rc int;
exec @rc=PAUDITORIUM_INSERTX @a='888-8',@n='��',@c=18,@t='888-8',@tn='����';
print '���-�� ���������'+cast(@rc as varchar(3));

select * from AUDITORIUM;


 ------------------MyBase------------------

 use DB_Lykova;
 --1--

 go
 alter procedure MYh
 as
 begin
 declare @j int=(select COUNT(*) from OFORMLENN_CREDITS);
 select * from OFORMLENN_CREDITS;
 RETURN @j;
 end;
 declare @jo int=0;
 EXEC @jo=MYh;
 print '����� �������'+cast (@jo as varchar(30));

 --2--
 alter procedure MYh @p varchar(20),@c int output
 as
 begin
 declare @j int=(select COUNT(*) from OFORMLENN_CREDITS);
 print 'new '+@p+',@c='+cast (@c as varchar(20));
 select * from OFORMLENN_CREDITS where ���_�������������=@p;
 set @c=@@ROWCOUNT;
 return @j;
 end;
 
 --4--
go
alter procedure PAUD
@a CHAR(20),@n VARCHAR(50),@c INT
as 
declare @rc int =1;
begin try
insert into CLIENTS(����������_����,�����,�������)
			values (@a,@n,@c)
return @rc;
end try
begin catch
print '����� ������:'+ cast(error_number() as varchar(20));
print '���������:'+error_message();
print '�������:'+cast(error_severity() as varchar(20));
print '�����:'+cast(error_state() as varchar(20));
print '����� ������:'+cast(error_line() as varchar(20));
if error_procedure() is not null
print '��� ���������:'+error_procedure();
return -1;
end catch;
go
declare @rc int;
exec @rc=PAUD @a='777-7',@n='��',@c=18;
print ''+cast(@rc as varchar(20));
go

--5--
ALTER procedure OP @p CHAR(10)
as declare @rc int =0;
begin try
	declare @tv char(20), @t char(300)='';
	declare OP_CURSOR CURSOR for
	select ����������_���� from CLIENTS where ����������_���� = @p;
	if not exists (select ����������_���� from CLIENTS where ����������_���� =@p)
	raiserror('mistake',11,1);
	else
	open OP_CURSOR;
	fetch OP_CURSOR into @tv;
	print 'CLIENTS';
	while @@FETCH_STATUS=0
	begin
	set @t=rtrim(@tv)+','+@t;
	set @rc= @rc+1;
	fetch OP_CURSOR into @tv;
	end;
print @t;
close OP_CURSOR;
return @rc;
end try

begin catch
print '������ � ����������'
if error_procedure() is not null
print 'name procedure:'+error_procedure();/*���������� ��� �������� ��������� ��� ��������, � ������� ��������� ������.*/
return @rc;
end catch;

declare @rc int ;
exec @rc=OP @p='������� �.�';
print '��� '+cast(@rc as varchar(20));