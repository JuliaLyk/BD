--lab 15
use UNIVER
go 
select [�������������].TEACHER_NAME [TEACHER_NAME], [�������������].PULPIT [PULPIT]
from TEACHER [�������������]
where [�������������].PULPIT = '����' for xml PATH('�������������'),
root('������_��������������'), elements;
--RAW--
go 
select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_CAPACITY
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE ='��-�' FOR XML RAW,
ROOT('LIST_OF_AUDITORIUM'),ELEMENTS;
--1--
go 
select [�������������].TEACHER_NAME [TEACHER_NAME], [�������������].PULPIT [PULPIT]
from TEACHER [�������������]
where [�������������].PULPIT = '����' for xml PATH('�������������'),
root('������_��������������')

--2-- 
go
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY
from AUDITORIUM  join AUDITORIUM_TYPE 
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE '%��%'
for xml auto,root('������_���������'), elements;


--3-- �������������� XML-������ � ������ �������
go
   declare @h int = 0,
@x varchar(2000) = N'<?xml version= "1.0" encoding = "windows-1251" ?>
<ROOT>
<subj SUBJECT = "Java_C" SUBJECT_NAME = "Java_C�����" PULPIT = "����"/>
<subj SUBJECT = "Java_P" SUBJECT_NAME = "Java_�����" PULPIT = "����"/>
<subj SUBJECT = "F#" SUBJECT_NAME = "F#" PULPIT = "����"/>
</ROOT>';
exec sp_xml_preparedocument @h output,@x;
insert SUBJECT
select [SUBJECT],[SUBJECT_NAME],[PULPIT]
from openxml(@h,'/ROOT/subj',0)
with([SUBJECT] nvarchar(10),[SUBJECT_NAME] nvarchar(200),[PULPIT] nvarchar(10))
exec sp_xml_removedocument @h;

select * from SUBJECT


--4--����� ���
go
ALTER Table STUDENT ADD INFO xml; 

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1002, 6, N'����� ������� ��������', cast('1994-11-09' as date), 
N'<����������_����������>
<����������_������>
<�����>��</�����>
<�����_��������>2243173</�����_��������>
<����_������>2021.13.11
</����_������>
</����������_������>
<�����>
<������>��������</������>
<�����>�����</�����>
<�����>�������������</�����>
</�����>
</����������_����������>')

update STUDENT set INFO = N'<����������_����������>
<����������_������>
<�����>SWE</�����>
<�����_��������>7123591</�����_��������>
<����_������>2018.03.09
</����_������>
</����������_������>
<�����>
<������>������</������>
<�����>���������</�����>
<�����>�����</�����>
</�����>
</����������_����������>'
where IDSTUDENT = 1002

select STUDENT.NAME,
INFO.value(N'(/����������_����������/����������_������/�����)[1]',N'nvarchar(20)')[�����],
INFO.value(N'(/����������_����������/����������_������/�����_��������)[1]',N'nvarchar(20)')[�����],
INFO.query(N'/����������_����������/�����') [�����]
from STUDENT
where INFO is not null

--5-- �������� ��� ��������!
go
--drop xml schema collection STUDENT;
--maxOccurs /minOccurs �������� (�� ��� ����� ������ ����)
CREATE XML SCHEMA COLLECTION STUDENT1 AS
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault = "unqualified"
elementFormDefault="qualified"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="����������_����������">
<xs:complexType>
<xs:sequence>
<xs:element name="����������_������" maxOccurs="1" minOccurs="1">
<xs:complexType>
<xs:sequence>
<xs:element name="�����" type="xs:string"/>
<xs:element name="�����_��������" type="xs:integer"/>
<xs:element name="����_������" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
<xs:element name="�����">
<xs:complexType>
<xs:sequence>
<xs:element name="������" type="xs:string"/>
<xs:element name="�����" type="xs:string"/>
<xs:element name="�����" type="xs:string"/>
<xs:element name="���" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:schema>';

alter table STUDENT ALTER COLUMN INFO xml(STUDENT1)

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1050, 51, N'������� ������� ����������', cast('30-08-2002' as date), 
N'<����������_����������>
<����������_������>
<�����>��</�����>
<�����_��������>8974521</�����_��������>
<����_������>2018.04.04
</����_������>
</����������_������>
<�����>
<������>������</������>
<�����>��������</�����>
<�����>������</�����>
</�����>
</����������_����������>')

select * from STUDENT

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1051, 51, N'����� ������� ��������', cast('06-07-1999' as date), 
N'<����������_����������>
<����������_������>
<�����>��</�����>
<�����_��������>6712817</�����_��������>
<����_������>2015.09.09
</����_������>
</����������_������>
<����������_������>
<�����>��</�����>
</����������_������>
<�����>
<������>������</������>
<�����>���</�����>
<�����>�������</�����>
</�����>
</����������_����������>')
-----------------&&&&&&5
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

select NAME ,INFO from STUDENT where NAME ='������ ���� ����������'
alter table STUDENT alter column INFO XML (STUDENT)


----------------------MyBase------------------------
use DB_Lykova

--1--
go 
select  [CREDITS].������������_������� [CREDITS]
from CREDITS
where [CREDITS].������������_�������  = '��������' for xml PATH('������������_�������'),
root('������')


--2-- 
go
select OFORMLENN_CREDITS.��������_�������,OFORMLENN_CREDITS.��������_�����_�������, CREDITS.������������_�������
from OFORMLENN_CREDITS  join CREDITS 
on OFORMLENN_CREDITS.��������_������� = CREDITS.������������_�������
WHERE OFORMLENN_CREDITS.��������_������� LIKE '%��_������%'
for xml auto,root('������'), elements;

--3--????????????????
go
   declare @h int = 0,
@x varchar(2000) = N'<?xml version= "1.0" encoding = "windows-1251" ?>
<ROOT>
<ofr ����������_���� = "�������� �.�" ����� = "��.����,�.20" �������= "0843209" />
<ofr ����������_���� = "����������� �.�." ����� = "��.���,�.25" �������= "234567" />
<ofr ����������_���� = "����� �.�." �����= "��.���,�.30" �������= "8392386" />
</ROOT>';
exec sp_xml_preparedocument @h output,@x;--���������� ���������
insert CLIENTS
select [����������_����],[�����],[�������] 
from openxml(@h,'/ROOT/subj',0)
with([����������_����] nvarchar(30),[�����] nvarchar(30),[�������] nvarchar(30))
exec sp_xml_removedocument @h;

select * from CLIENTS

--4--
create table DATA_T
( �����_�������� nvarchar(50) primary key,
�����_��c����� xml
);
insert into DATA_T(�����_��������,�����_��c�����)
values ('SWE','<�����_�������>34567890</�����_�������>');

insert into DATA_T(�����_��������,�����_��c�����)
values ('��','<�����_�������>5362820</�����_�������>');

select �����_��������,
�����_��c�����.value('(/�����_�������)[1]','varchar(50)')[�����_�������],
�����_��c�����.query('/�����_�������')[�����]
from DATA_T
