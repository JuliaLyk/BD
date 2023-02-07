

use master
create database UNIVER on primary
( name = N'UNIVER_mdf', filename = N'G:\��������� �������\������������������\��\����4\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'G:\��������� �������\������������������\��\����4\ER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'G:\��������� �������\������������������\��\����4\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'G:\��������� �������\������������������\��\����4\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'G:\��������� �������\������������������\��\����4\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);


------------�������� � ���������� ������� AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
                      
-------------�������� � ���������� ������� AUDITORIUM  
  create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- ����������� 
   AUDITORIUM_NAME      varchar(50)                                     
)
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', '��-�',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', '��-�',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', '��',  90);

  ------�������� � ���������� ������� FACULTY
  create table FACULTY
  (    FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('��',     '��������� �������������� ����������');  
------�������� � ���������� ������� PROFESSION
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-40 01 02',   '�������������� ������� � ����������', '�������-�����������-�������������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-47 01 01', '������������ ����', '��������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-36 06 01',  '��������������� ������������ � ������� ��������� ����������', '�������-��������������' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 01 08',    '��������������� � ������������ ������� �� �������������� ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('����',  '1-36 07 01',  '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-75 01 01',      '������ ���������', '������� ������� ���������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-75 02 01',   '������-�������� �������������', '������� ������-��������� �������������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-89 02 02',     '������ � ������������������', '���������� � ����� �������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-25 01 07',  '��������� � ���������� �� �����������', '���������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-25 01 08',    '������������� ����, ������ � �����', '���������' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 05 01',   '������ � ������������ ������� ���������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('����',  '1-46 01 01',      '�������������� ����', '�������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-48 01 02',  '���������� ���������� ������������ �������, ���������� � �������', '�������-�����-��������' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('���',  '1-48 01 05',    '���������� ���������� ����������� ���������', '�������-�����-��������' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-54 01 03',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' ); 

------�������� � ���������� ������� PULPIT
  create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','��'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('��', '�����������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '��������������','���')           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('�����', '���������� � ����������������','���')                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('����', '������ ������� � ������������','���') 
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('���', '������� � ������������������','���')              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('������','������������ �������������� � ������-��������� �������������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '���������� ����', '����')                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('�����','������ ����� � ���������� �������������','����')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���','���������� �������������������� �����������', '����')   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('�����','���������� � ������� ������� �� ���������','����')    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('��', '������������ �����','���') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('���','���������� ����������� ���������','���')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('�����','��������� � ��������� ���������� �����������','����')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('����',    '������������� ������ � ����������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('����',   '����������� � ��������� ������������������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('������', '����������, �������������� �����, ������� � ������', '���')     
             
------�������� � ���������� ������� TEACHER
 create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('�', '�')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '�������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '���������� ������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '�������� ������ ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                                                 
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('������',   '����������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������ ������ ��������', '�', '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����', '������� ������ ����������',  '�',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '���������� ������� ��������', '�', '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',   '������ ������ ���������� ', '�', '��');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '��������� �������� ���������', '�', '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('������',   '���������� �������� ����������', '�', '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '�������� ������ ����������', '�', '��'); 
	------�������� � ���������� ������� SUBJECT
create table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )
 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('����',   '������� ���������� ������ ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������ �������������� � ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '���������������� ������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '�������������� �������������� ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '������������ �������������� �������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('��',   '���������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('��',   '�������������� ����������������','����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('����', '���������� ������ ���',  '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '��������� ������������������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '������������� ������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('�������','������ ������-��������� � ������������� ���������',  '������')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��', '���������� �������� ','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��',    '�����������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��',    '������������ �����', '��')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',    '������ ��������� ����','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� � ������������ �������������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ','�������')                                                                                                                                                      
  
------�������� � ���������� ������� GROUPS
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('����','1-36 01 08', 2013),---12 ��                                                  
                ('����','1-36 01 08', 2012),
                ('����','1-36 07 01', 2011),
                ('����','1-36 07 01', 2010),
                ('���','1-48 01 02', 2012), ---16 �� 
                ('���','1-48 01 02', 2011),
                ('���','1-48 01 05', 2013),
                ('���','1-54 01 03', 2012),
                ('���','1-75 01 01', 2013),--20 ��      
                ('���','1-75 02 01', 2012),
                ('���','1-75 02 01', 2011),
                ('���','1-89 02 02', 2012),
                ('���','1-89 02 02', 2011),  
                ('����','1-36 05 01', 2013),
                ('����','1-36 05 01', 2012),
                ('����','1-46 01 01', 2012),--27 ��
                ('���','1-25 01 07', 2013), 
                ('���','1-25 01 07', 2012),     
                ('���','1-25 01 07', 2010),
                ('���','1-25 01 08', 2013),
                ('���','1-25 01 08', 2012) ---32 ��       
                          
------�������� � ���������� ������� STUDENT
create table STUDENT 
(    IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
      IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
      NAME   nvarchar(100), 
      BDAY   date,
      STAMP  timestamp,
      INFO     xml,
      FOTO     varbinary
 ) 
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (2, '����� ������� ��������',         '12.07.1994'),
           (2, '������� �������� ����������',    '06.03.1994'),
           (2, '�������� ����� �����������',     '09.11.1994'),
           (2, '������� ����� ���������',        '04.10.1994'),
           (2, '��������� ��������� ����������', '08.01.1994'),
           (3, '������� ������ ���������',       '02.08.1993'),
           (3, '������� ��� ����������',         '07.12.1993'),
           (3, '������� ����� �����������',      '02.12.1993'),
           (4, '������� ������ �����������',     '08.03.1992'),
           (4, '������� ����� �������������',    '02.06.1992'),
           (4, '�������� ����� �����������',     '11.12.1992'),
           (4, '�������� ������� �������������', '11.05.1992'),
           (4, '����������� ������� ��������',   '09.11.1992'),
           (4, '�������� ������� ����������',    '01.11.1992'),
           (5, '�������� ����� ������������',    '08.07.1995'),
           (5, '������ ������� ����������',      '02.11.1995'),
           (5, '������ ��������� �����������',   '07.05.1995'),
           (5, '����� ��������� ���������',      '04.08.1995'),
           (6, '���������� ����� ����������',    '08.11.1994'),
           (6, '�������� ������ ��������',       '02.03.1994'),
           (6, '���������� ����� ����������',    '04.06.1994'),
           (6, '��������� ���������� ���������', '09.11.1994'),
           (6, '����� ��������� �������',        '04.07.1994'),
           (7, '����������� ����� ������������', '03.01.1993'),
           (7, '������� ���� ��������',          '12.09.1993'),
           (7, '��������� ������ ��������',      '12.06.1993'),
           (7, '���������� ��������� ����������','09.02.1993'),
           (7, '������� ������ ���������',       '04.07.1993'),
           (8, '������ ������� ���������',       '08.01.1992'),
           (8, '��������� ����� ����������',     '12.05.1992'),
           (8, '�������� ����� ����������',      '08.11.1992'),
           (8, '������� ������� ���������',      '12.03.1992'),
           (9, '�������� ����� �������������',   '10.08.1995'),
           (9, '���������� ������ ��������',     '02.05.1995'),
           (9, '������ ������� �������������',   '08.01.1995'),
           (9, '��������� ��������� ��������',   '11.09.1995'),
           (10, '������ ������� ������������',   '08.01.1994'),
           (10, '������ ������ ����������',      '11.09.1994'),
           (10, '����� ���� �������������',      '06.04.1994'),
           (10, '������� ������ ����������',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (11, '��������� ��������� ����������','07.11.1993'),
           (11, '������ ������� ����������',     '04.06.1993'),
           (11, '������� ����� ����������',      '10.12.1993'),
           (11, '������� ������ ����������',     '04.07.1993'),
           (11, '������� ����� ���������',       '08.01.1993'),
           (11, '����� ������� ����������',      '02.09.1993'),
           (12, '���� ������ �����������',       '11.12.1995'),
           (12, '������� ���� �������������',    '10.06.1995'),
           (12, '��������� ���� ���������',      '09.08.1995'),
           (12, '����� ����� ���������',         '04.07.1995'),
           (12, '��������� ������ ����������',   '08.03.1995'),
           (12, '����� ����� ��������',          '12.09.1995'),
           (13, '������ ����� ������������',     '08.10.1994'),
           (13, '���������� ����� ����������',   '10.02.1994'),
           (13, '�������� ������� �������������','11.11.1994'),
           (13, '���������� ����� ����������',   '10.02.1994'),
           (13, '����������� ����� ��������',    '12.01.1994'),
           (14, '�������� ������� �������������','11.09.1993'),
           (14, '������ �������� ����������',    '01.12.1993'),
           (14, '���� ������� ����������',       '09.06.1993'),
           (14, '�������� ���������� ����������','05.01.1993'),
           (14, '����������� ����� ����������',  '01.07.1993'),
           (15, '������� ��������� ���������',   '07.04.1992'),
           (15, '������ �������� ���������',     '10.12.1992'),
           (15, '��������� ����� ����������',    '05.05.1992'),
           (15, '���������� ����� ������������', '11.01.1992'),
           (15, '�������� ����� ����������',     '04.06.1992'),
           (16, '����� ����� ����������',        '08.01.1994'),
           (16, '��������� ��������� ���������', '07.02.1994'),
           (16, '������ ������ �����������',     '12.06.1994'),
           (16, '������� ����� ��������',        '03.07.1994'),
           (16, '������ ������ ���������',       '04.07.1994'),
           (17, '������� ��������� ����������',  '08.11.1993'),
           (17, '������ ����� ����������',       '02.04.1993'),
           (17, '������ ���� ��������',          '03.06.1993'),
           (17, '������� ������ ���������',      '05.11.1993'),
           (17, '������ ������ �������������',   '03.07.1993'),
           (18, '��������� ����� ��������',      '08.01.1995'),
           (18, '���������� ��������� ���������','06.09.1995'),
           (18, '�������� ��������� ����������', '08.03.1995'),
           (18, '��������� ����� ��������',      '07.08.1995')

------�������� � ���������� ������� PROGRESS
create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('����', 1001,  '01.10.2013',8),
           ('����', 1002,  '01.10.2013',7),
           ('����', 1003,  '01.10.2013',5),
           ('����', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('����', 1014,  '01.12.2013',5),
           ('����', 1015,  '01.12.2013',9),
           ('����', 1016,  '01.12.2013',5),
           ('����', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('��',   1018,  '06.5.2013',4),
           ('��',   1019,  '06.05.2013',7),
           ('��',   1020,  '06.05.2013',7),
           ('��',   1021,  '06.05.2013',9),
           ('��',   1022,  '06.05.2013',5),
           ('��',   1023,  '06.05.2013',6)




 -- ���������� ������������ ������ 


 --���-�� �������� �� �������, ������� ��������
GO
CREATE PROCEDURE PREP  @KAF varchar(20) = null
AS
BEGIN 
SELECT COUNT(TEACHER.TEACHER) FROM TEACHER 
							WHERE TEACHER.PULPIT= @KAF;
END;
GO 
EXEC PREP @KAF = '����'
-----------------------------
 USE UNIVER;
GO
CREATE FUNCTION FAUD (@AUD VARCHAR(50)) RETURNS VARCHAR(50)
AS BEGIN
DECLARE @RC VARCHAR(50);
SET @RC=(SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
												ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
												WHERE AUDITORIUM.AUDITORIUM=@AUD)
RETURN @RC;
END;
GO
DECLARE @F VARCHAR(50) = DBO.FAUD('301-1');
PRINT '��� ��������� 301-1: '+CAST(@F AS VARCHAR(20));
DROP FUNCTION FAUD

 -- 1.
 select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from dbo.AUDITORIUM inner join dbo.AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

 -- 2.
 
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from dbo.AUDITORIUM inner join dbo.AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE 
and
(AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  Like N'���������%');

 -- 3.
 
  select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
  From AUDITORIUM, AUDITORIUM_TYPE
  Where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

  select T1.AUDITORIUM, T2.AUDITORIUM_TYPENAME
  From AUDITORIUM T1, AUDITORIUM_TYPE T2
  Where T1.AUDITORIUM_TYPE = T2.AUDITORIUM_TYPE and (T2.AUDITORIUM_TYPENAME  Like N'���������%');

  -- 4 
  SELECT FACULTY.FACULTY, PULPIT.PULPIT,SUBJECT.SUBJECT, PROFESSION.PROFESSION, STUDENT.NAME,
  case
	when (PROGRESS.NOTE between 6 and 6) then 'six'
	when (PROGRESS.NOTE between 7 and 7) then 'seven'
	when (PROGRESS.NOTE between 8 and 8) then 'eight'
	else 'another mark'
	end as MARK
  FROM
  
  FACULTY INNER JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
			   INNER JOIN SUBJECT ON PULPIT.PULPIT = SUBJECT.PULPIT
			   INNER JOIN PROGRESS ON SUBJECT.SUBJECT = PROGRESS.SUBJECT
			   INNER JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
			   INNER JOIN GROUPS ON  STUDENT.IDGROUP = GROUPS.IDGROUP
			   INNER JOIN PROFESSION ON GROUPS.PROFESSION = PROFESSION.PROFESSION

			ORDER BY FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION, STUDENT.NAME , PROGRESS.NOTE DESC;


  /*
	 STUDENT
			   INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
			   INNER JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
			   INNER JOIN SUBJECT ON SUBJECT.SUBJECT = PROGRESS.SUBJECT
			   INNER JOIN PULPIT ON PULPIT.PULPIT = SUBJECT.PULPIT
			   INNER JOIN PROFESSION ON PROFESSION.PROFESSION = GROUPS.PROFESSION
			   INNER JOIN FACULTY ON FACULTY.FACULTY = PROFESSION.FACULTY
			   ORDER BY FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION, STUDENT.NAME , PROGRESS.NOTE DESC;
*/

-- 5 


SELECT FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION, STUDENT.NAME,
  case
	when (PROGRESS.NOTE between 6 and 6) then 'six'
	when (PROGRESS.NOTE between 7 and 7) then 'seven'
	when (PROGRESS.NOTE between 8 and 8) then 'eight'
	else 'another mark'
	end as MARK
  FROM 
  
	 STUDENT
			   INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
			   INNER JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
			   INNER JOIN SUBJECT ON SUBJECT.SUBJECT = PROGRESS.SUBJECT
			   INNER JOIN PULPIT ON PULPIT.PULPIT = SUBJECT.PULPIT
			   INNER JOIN PROFESSION ON PROFESSION.PROFESSION = GROUPS.PROFESSION
			   INNER JOIN FACULTY ON FACULTY.FACULTY = PROFESSION.FACULTY
			   ORDER BY CASE
					WHEN(PROGRESS.NOTE = 6) then 3
					WHEN(PROGRESS.NOTE = 7) then 1
					WHEN(PROGRESS.NOTE = 8) then 2
			   end;

-- 6 + 7 


SELECT isnull (TEACHER.TEACHER_NAME,'***')[�������������],PULPIT.PULPIT_NAME[�������]
FROM PULPIT Left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[�������������],PULPIT.PULPIT_NAME[�������]
FROM TEACHER Left outer join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[�������������],PULPIT.PULPIT_NAME[�������]
FROM PULPIT Right outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[�������������],PULPIT.PULPIT_NAME[�������]
FROM TEACHER Right outer join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT

-- 8 
select isnull(PULPIT.PULPIT, '***') PULPIT, isnull(TEACHER.TEACHER, '***') TEACHER 
FROM TEACHER full outer join PULPIT
ON PULPIT.PULPIT = TEACHER.PULPIT;

select isnull(PULPIT.PULPIT, '***') PULPIT, isnull(TEACHER.TEACHER, '***') TEACHER 
FROM PULPIT full outer join TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT;

select isnull(PULPIT.PULPIT, '***') PULPIT, isnull(TEACHER.TEACHER, '***') TEACHER 
FROM PULPIT INNER join TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT;

select TEACHER.TEACHER_NAME, PULPIT.PULPIT
FROM TEACHER full outer join PULPIT
ON PULPIT.PULPIT = TEACHER.PULPIT
where PULPIT.PULPIT is null;

select TEACHER.TEACHER_NAME, PULPIT.PULPIT
FROM PULPIT full outer join TEACHER
ON PULPIT.PULPIT = TEACHER.PULPIT
where TEACHER is null;

select PULPIT.PULPIT, TEACHER.TEACHER_NAME
FROM TEACHER full outer join PULPIT
ON PULPIT.PULPIT = TEACHER.PULPIT
where PULPIT.PULPIT is not null;


-- 9 


select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from dbo.AUDITORIUM cross join dbo.AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;


--- My DataBase 


create database �������������������������� on primary
( name = N'��������������������������DataBase_mdf', filename = N'G:\��������� �������\������������������\��\����3\��������������������������DataBase_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'��������������������������DataBase_ndf', filename = N'G:\��������� �������\������������������\��\����3\��������������������������DataBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'��������������������������DataBase_fg1_1', filename = N'G:\��������� �������\������������������\��\����3\��������������������������DataBase_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'��������������������������DataBase_fg1_2', filename = N'G:\��������� �������\������������������\��\����3\��������������������������DataBase_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'��������������������������DataBase_log', filename=N'G:\��������� �������\������������������\��\����3\��������������������������DataBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);

use ��������������������������
CREATE TABLE ������
( ����������� int primary key,
  ������������� nvarchar(50) not null,
  ��������� nvarchar(50),
  ������������������� int 
);

CREATE TABLE �������������
(
	���������������� int primary key,
	������� nvarchar(50),
	��� nvarchar(50),
	�������� nvarchar(50),
	������� nvarchar(50),
	���� nvarchar(50)	
)

CREATE TABLE �������
( ����������� int primary key,
  ������� nvarchar(50),
  ��������������� int
)

CREATE TABLE �������
( ID������� int primary key,
  ����������� nvarchar(50) check (����������� in ('��','��','��')),
  ������������� int foreign key references �������������(����������������),
  ����������� int foreign key references �������(�����������),
  ������ money
);

CREATE TABLE ��������������������
(
	������������������� int primary key,
	N������ int foreign key references ������(�����������),
	������������ int foreign key references �������(ID�������)
)


ALTER Table ������� DROP Column ������;

ALTER TABLE ������� 
ADD ������ money ; 


/*
ALTER TABLE ������
ADD �������_������� nchar(1) default '�' check (�������_������� in ('�','�'));
ALTER Table ������ DROP Column ����_�����������;
DROP table ������;
*/

INSERT into ������(�����������, �������������, ���������, �������������������)
			Values (1, '����','��', 26),
				   (2, '����','��', 27),
				   (3, '����','��', 23),
				   (4, '����','��', 25),
				   (5, '������','��', 29),
				   (6, '�����','���', 21);
				   
INSERT into ������������� (����������������, �������, ���, ��������, �������, ����)	
			values (1,'���������','������','����������','375444767124','6'),
				   (2,'�������','������','����������','375447694523','3'),
				   (3,'�������� ','�������� ','���������','375917872352','5'),
				   (4,'�����','������','��������','375444909884','8'),
				   (5,'�������','��������','��������','375648796986','2'),
				   (6,'������','������','����������','375445235252','7'),
				   (7,'���������� ','���������','���������','375868768752','5'),
				   (8,'���������','���� ','��������','375447589996','14'),
				   (9,'����������','������','�����������','375298768752','14');

INSERT into �������(�����������, ������� , ��������������� )
			values (1,'�������',72),
				   (2,'�����',108),
				   (3,'������',108),
				   (4,'���',400),
				   (5,'��',300),
				   (6,'����',108),
				   (7,'���',36),
				   (8,'�������',72),
				   (9,'�����������',400),
				   (10,'����',108),
				   (11,'���',200),
				   (12,'��',160),
				   (13,'������',200),
				   (14,'���������� ',500),
				   (15,'���',108)
				   

INSERT into ������� (ID������� , �����������, �������������, ����������� , ������ )
			values (1,'��',1,1,20),
				   (2,'��',2,1,15),
				   (3,'��',5,2,40),
				   (4,'��',2,2,20),
				   (5,'��',1,3,30),
				   (6,'��',1,3,20),
				   (7,'��',2,3,30),
				   (8,'��',6,5,15),
				   (9,'��',8,4,20),
				   (10,'��',9,1,57),
				   (11,'��',5,8,15),
				   (12,'��',3,6,20),
				   (13,'��',3,12,20),
				   (14,'��',3,15,30),
				   (15,'��',2,15,20),
				   (16,'��',5,6,20),
				   (17,'��',8,14,30),
				   (18,'��',9,13,41),
				   (19,'��',7,14,63),
				   (20,'��',8,10,11),
				   (21,'��',4,13,10),
				   (22,'��',6,7,40),
				   (23,'��',5,7,30),
				   (24,'��',1,5,49),
				   (25,'��',2,7,40),
				   (26,'��',3,6,30),
				   (27,'��',3,5,20),
				   (28,'��',5,10,30),
				   (29,'��',4,15,30),
				   (30,'��',5,10,40);

use ��������������������������
INSERT into �������������������� (�������������������, N������, ������������)
	values (1,1,1),
		   (2,1,2),
		   (3,1,2),
		   (4,1,3),
		   (5,1,4),
		   (6,1,5),
		   (7,1,6),
		   (8,1,8),
		   (9,1,10),
		   (10,2,16),
		   (11,2,9),
		   (12,2,5),
		   (13,2,9),
		   (14,2,6),
		   (15,2,5),
		   (16,2,8),
		   (17,2,9),
		   (18,3,10),
		   (19,3,11),
		   (20,3,12),
		   (21,3,13),
		   (22,3,14),
		   (23,3,15),
		   (24,3,16),
		   (25,3,17),
		   (26,3,18),
		   (27,3,10),
		   (28,4,19),
		   (29,4,20),
		   (30,4,21),
		   (31,4,12),
		   (32,4,14),
		   (33,4,25),
		   (34,5,26),
		   (35,5,5),
		   (36,5,14),
		   (37,5,29),
		   (38,6,30),
		   (39,6,28),
		   (40,6,27);
		   

SELECT COUNT(*) From �������; 

SELECT �������  , ���������������  FROM �������
Where ��������������� < 200 ; 


/*distinct - �� ������� ������������� ������ */
SELECT DISTINCT TOP(5)  �����������, �������  , ��������������� FROM �������
Where ��������������� < 200 ; 

UPDATE ������� set ������ = ������+5 Where ����������� = '3';


SELECT ���, �������, ���� FROM �������������
Where ���� Between '1'And '6';

SELECT distinct ���, �������, ���� FROM �������������
Where ������� Like '�%';

SELECT distinct �����������,������� FROM ������� Where ��������������� In (400, 108);




-- 1

SELECT �������������.����������������, �������������.���, �������������.�������, �������.������
FROM ������������� INNER JOIN ������� 
ON �������������.���������������� = �������.�������������;

-- 2 

SELECT �������������.����������������, �������������.���, �������������.�������, �������.������
FROM ������������� INNER JOIN ������� 
ON �������������.���������������� = �������.�������������
AND 
(�������.����������� LIKE N'��');

-- 3 

SELECT ������.�������������, ��������������������.������������
FROM ������, ��������������������
WHERE ������.����������� = ��������������������.N������;



SELECT �1.�������������, �2.������������
FROM ������ �1, �������������������� �2
WHERE �1.����������� = �2.N������ AND (�1.������������� LIKE N'����'); 

 
 -- 4


SELECT ������.�����������, �������������.���, �������������.�������, �������.�������, �������.�����������

FROM	������ INNER JOIN �������������������� ON ������.����������� = ��������������������.N������
		   INNER JOIN ������� ON ��������������������.������������ = �������.ID�������
		   INNER JOIN ������� ON �������.����������� = �������.�����������
		   INNER JOIN ������������� ON �������������.���������������� = �������.�������������
		order by ������.����������� desc ; 
 -- 5


 SELECT �������������.���, �������������.�������, �������.�������, �������.�����������,
   case
	when (������.�����������  between 1 and 1) then '����'
	when (������.�����������  between 2 and 2) then '���'
	when (������.�����������  between 3 and 3) then '���'
	when (������.�����������  between 4 and 4) then '������'
	when (������.�����������  between 5 and 5) then '����'
	when (������.�����������  between 6 and 6) then '�����'
	else 'another mark'
	end as '����� ������'
FROM	������ INNER JOIN �������������������� ON ������.����������� = ��������������������.N������
		   INNER JOIN ������� ON ��������������������.������������ = �������.ID�������
		   INNER JOIN ������� ON �������.����������� = �������.�����������
		   INNER JOIN ������������� ON �������������.���������������� = �������.�������������;



-- 6 + 7 

select �������.�������������, �������������.���, �������������.������� 
FROM ������� LEFT OUTER JOIN ������������� ON �������.������������� = �������������.���������������� ;


select isnull (�������.�������������, 0) [����������],isnull( �������������.���, '***')[���], �������������.������� 
FROM ������������� RIGHT OUTER JOIN ������� ON �������.������������� = �������������.���������������� ;

 --  8

select isnull (�������.�������������, 0) [����������],isnull( �������������.���, '***')[���], �������������.������� 
FROM ������������� full OUTER JOIN ������� ON �������.������������� = �������������.���������������� ; 


select isnull (�������.�������������, 0) [����������],isnull( �������������.���, '***')[���], �������������.������� 
FROM ������� full OUTER JOIN ������������� ON �������.������������� = �������������.���������������� ;


select isnull(�������.�������������, 0) [����������], isnull( �������������.���, '***') [���], �������������.������� 
FROM ������� INNER join �������������
ON �������.������������� = �������������.���������������� ;

select �������.�������������, �������������.���, �������������.������� 
FROM ������� full outer join �������������
ON �������.������������� = �������������.���������������� 
where �������������.����������������  is null;

select �������.�������������, �������������.���, �������������.������� 
FROM ������������� full outer join �������
ON �������.������������� = �������������.���������������� 
where �������������.����������������  is null;


-- 9 

select �������.�������������, �������������.���, �������������.������� 
from ������� cross join �������������
where �������.������������� = �������������.���������������� ;
