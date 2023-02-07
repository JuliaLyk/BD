use UNIVER;
--1-- 
--drop function COUNT_STUDENTS
go
alter function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin declare @rc int =0;
set @rc=(select count(NAME)
from STUDENT join GROUPS
on STUDENT.IDGROUP= GROUPS.IDGROUP
join FACULTY
on GROUPS.FACULTY=FACULTY.FACULTY
where FACULTY.FACULTY=@faculty);
return @rc;
end;
go
declare @f int=dbo.COUNT_STUDENTS('���');
print'���������� ���������= '+cast(@f as varchar(4));

--1a--
go
alter function COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20)=null)returns int
as begin
return(
select count(NAME)
from FACULTY join PROFESSION on FACULTY.FACULTY=PROFESSION.FACULTY
join GROUPS on PROFESSION.PROFESSION=GROUPS.PROFESSION
join STUDENT on STUDENT.IDGROUP= GROUPS.IDGROUP
where FACULTY.FACULTY=isnull(@faculty, FACULTY.FACULTY) and
PROFESSION.PROFESSION=isnull(@prof, PROFESSION.PROFESSION)
);
end;

go
select FACULTY.FACULTY '����������', PROFESSION.PROFESSION '�������������', 
dbo.COUNT_STUDENTS(FACULTY.FACULTY,PROFESSION.PROFESSION)'���������� ���������'
from FACULTY join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
--2--
--drop function FSUBJECTS
alter FUNCTION  FSUBJECTS (@p varchar(20)) returns char (300)
as
begin 
declare @t varchar(300)='����������:';
declare @tv char (20);
declare SUBJECTS CURSOR LOCAL STATIC
for select PULPIT from SUBJECT
where SUBJECT.PULPIT=@p;
open SUBJECTS
fetch SUBJECTS into @tv;
while @@FETCH_STATUS=0
begin
set @t=@t + ',' + RTRIM(@tv);
fetch SUBJECTS into @tv;
end;
return @t;
end;
go
select PULPIT,dbo. FSUBJECTS(PULPIT) from PULPIT; 
go

--3--
--DROP function FFACPUL

alter function FFACPUL(@fac nvarchar(10), @pul nvarchar(10)) returns table
as return
select f.FACULTY, p.PULPIT
from FACULTY f  left join PULPIT p
on f.FACULTY = p.FACULTY
where f.FACULTY = isnull(@fac, f.FACULTY)
and p.PULPIT = isnull(@pul, p.PULPIT);
select * from dbo.FFACPUL(NULL, NULL);--��� ������� �� ����������--
select * from dbo.FFACPUL(NULL, N'����');--������ ���� ������ ���������--
select * from dbo.FFACPUL(N'����', NULL);--������ �������� �������--
select * from dbo.FFACPUL(N'��', N'����');--�������� ������� ��������� ����������--



--4--
-- drop function FCTEACHER
alter function FCTEACHER (@p varchar(50)) returns int
as
begin 
declare @rc int=(select COUNT(*) from TEACHER
where PULPIT=ISNULL(@p,PULPIT));
return @rc;
end;
go

select PULPIT,dbo.FCTEACHER(PULPIT)[���-��] from PULPIT
go
select dbo.FCTEACHER(NULL)[���-��];
go

--6--
go 
alter function PulpitCount(@faculty varchar(50)) returns int 
as 
begin 
   declare @pulpitCount int = 0 
   set @pulpitCount = (select count(*) 
              from PULPIT 
                where PULPIT.FACULTY = @faculty) 
  return @pulpitCount 
end 
go 
go 
alter function GroupCount(@faculty varchar(50)) returns int 
as 
begin 
   declare @groupCount int = 0 
   set @groupCount = (select count(*) 
              from GROUPS 
                where GROUPS.FACULTY = @faculty) 
  return @groupCount 
end 
go 
go 
alter function StudentCount(@faculty varchar(50)) returns int 
as 
begin 
  declare @studentCount int = 0 
  set @studentCount = (select count(*)  
              from STUDENT  
              Inner Join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP 
              Inner Join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY 
                where FACULTY.FACULTY = @faculty) 
  return @studentCount 
end 
go 
go 
alter function ProfessionCount(@faculty varchar(50)) returns int 
as 
begin 
   declare @professionCount int = 0 
   set @professionCount = (select count(*) 
              from PROFESSION 
                where PROFESSION.FACULTY = @faculty) 
  return @professionCount 
end 
go 
 
go 
alter function FacultyReport(@studentCount int) returns  @result table 
                                ( 
                                  faculty varchar(50), 
                                  pulpitCount int,  
                                  groupCount int,  
                                  professionCount int 
                                ) 
as 
begin 
  declare FacultyCursor cursor local for 
    select FACULTY from FACULTY where dbo.StudentCount(FACULTY) > @studentCount 
  declare @faculty varchar(50) 
  open FacultyCursor 
    fetch FacultyCursor into @faculty 
    while @@FETCH_STATUS = 0 
    begin 
      insert into @result values 
      (@faculty, dbo.PulpitCount(@faculty), dbo.GroupCount(@faculty), dbo.ProfessionCount(@faculty)) 
 
      fetch FacultyCursor into @faculty 
    end 
 
  close FacultyCursor 
  return 
end 
go 
 
select FACULTY, dbo.StudentCount(FACULTY)[student count] from FACULTY 
select * from dbo.FacultyReport(14)




---------
create function FACULTY_REPORT(@c int) returns @fr table
	                        ( [���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                                                                 [���������� ���������] int, [���������� ��������������] int )
	as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                                                    where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),   dbo.COUNT_STUDENTS(@f, default),
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;

-------------MyBase-------------

--1--&&&&&&&&&&&&&&&&&
USE DB_Lykova
CREATE function COUNT_CLIENTS (@st varchar(20)) returns int
as begin declare @rc int =0;
set @rc=(select count(����������_����)
from  OFORMLENN_CREDITS join CLIENTS
on OFORMLENN_CREDITS.��������_�����_�������=CLIENTS.����������_����
join CREDITS
on OFORMLENN_CREDITS.��������_�������=CREDITS.������������_�������
where CREDITS.������������_�������=@st);
return @rc;
end;
go
declare @f int=dbo.COUNT_CLIENTS('��������� �.�.');
print'���= '+cast(@f as varchar(4));

--2--
CREATE FUNCTION  FS (@p varchar(20)) returns char (300)
as
begin 
declare @t varchar(300)='�������: ';
declare @tv char (20);
declare CRE CURSOR LOCAL STATIC
for select OFORMLENN_CREDITS.��������_������� from OFORMLENN_CREDITS
where OFORMLENN_CREDITS.��������_�������=@p;
open CRE
fetch CRE into @tv;
while @@FETCH_STATUS=0
begin
set @t=@t + ',' + RTRIM(@tv);
fetch CRE into @tv;
end;
return @t;
end;
go
select OFORMLENN_CREDITS.��������_�������,dbo. FS (��������_�������) from OFORMLENN_CREDITS; 
go

--3--
create function FFACPUL(@fac nvarchar(10), @pul nvarchar(10)) returns table
as return
select OFORMLENN_CREDITS.��������_�����_�������, CREDITS.������������_�������
from OFORMLENN_CREDITS  left join CREDITS
on OFORMLENN_CREDITS.��������_������� = CREDITS.������������_�������
where OFORMLENN_CREDITS.��������_������� = isnull(@fac, OFORMLENN_CREDITS.��������_�������)
and CREDITS.������������_������� = isnull(@pul, CREDITS.������������_�������);
select * from dbo.FFACPUL(NULL, NULL);
select * from dbo.FFACPUL(NULL, N'��_������');


