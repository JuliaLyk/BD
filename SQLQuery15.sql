--lab 15
use UNIVER
go 
select [Преподаватель].TEACHER_NAME [TEACHER_NAME], [Преподаватель].PULPIT [PULPIT]
from TEACHER [Преподаватель]
where [Преподаватель].PULPIT = 'ИСиТ' for xml PATH('Преподаватель'),
root('Список_преподавателей'), elements;
--RAW--
go 
select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_CAPACITY
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE ='ЛБ-К' FOR XML RAW,
ROOT('LIST_OF_AUDITORIUM'),ELEMENTS;
--1--
go 
select [Преподаватель].TEACHER_NAME [TEACHER_NAME], [Преподаватель].PULPIT [PULPIT]
from TEACHER [Преподаватель]
where [Преподаватель].PULPIT = 'ИСиТ' for xml PATH('Преподаватель'),
root('Список_преподавателей')

--2-- 
go
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY
from AUDITORIUM  join AUDITORIUM_TYPE 
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE LIKE '%ЛК%'
for xml auto,root('Список_Аудиторий'), elements;


--3-- преобразование XML-данных в строки таблицы
go
   declare @h int = 0,
@x varchar(2000) = N'<?xml version= "1.0" encoding = "windows-1251" ?>
<ROOT>
<subj SUBJECT = "Java_C" SUBJECT_NAME = "Java_Cмелов" PULPIT = "ИСиТ"/>
<subj SUBJECT = "Java_P" SUBJECT_NAME = "Java_Пацей" PULPIT = "ИСиТ"/>
<subj SUBJECT = "F#" SUBJECT_NAME = "F#" PULPIT = "ИСиТ"/>
</ROOT>';
exec sp_xml_preparedocument @h output,@x;
insert SUBJECT
select [SUBJECT],[SUBJECT_NAME],[PULPIT]
from openxml(@h,'/ROOT/subj',0)
with([SUBJECT] nvarchar(10),[SUBJECT_NAME] nvarchar(200),[PULPIT] nvarchar(10))
exec sp_xml_removedocument @h;

select * from SUBJECT


--4--вроде так
go
ALTER Table STUDENT ADD INFO xml; 

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1002, 6, N'Силюк Валерия Ивановна', cast('1994-11-09' as date), 
N'<Контактная_информация>
<Паспортные_данные>
<Серия>АВ</Серия>
<Номер_паспорта>2243173</Номер_паспорта>
<Дата_выдачи>2021.13.11
</Дата_выдачи>
</Паспортные_данные>
<Адрес>
<Страна>Беларусь</Страна>
<Город>Пинск</Город>
<Улица>Наконечникова</Улица>
</Адрес>
</Контактная_информация>')

update STUDENT set INFO = N'<Контактная_информация>
<Паспортные_данные>
<Серия>SWE</Серия>
<Номер_паспорта>7123591</Номер_паспорта>
<Дата_выдачи>2018.03.09
</Дата_выдачи>
</Паспортные_данные>
<Адрес>
<Страна>Швеция</Страна>
<Город>Стокгольм</Город>
<Улица>Алинк</Улица>
</Адрес>
</Контактная_информация>'
where IDSTUDENT = 1002

select STUDENT.NAME,
INFO.value(N'(/Контактная_информация/Паспортные_данные/Серия)[1]',N'nvarchar(20)')[Серия],
INFO.value(N'(/Контактная_информация/Паспортные_данные/Номер_паспорта)[1]',N'nvarchar(20)')[Номер],
INFO.query(N'/Контактная_информация/Адрес') [Адрес]
from STUDENT
where INFO is not null

--5-- уточнить как работает!
go
--drop xml schema collection STUDENT;
--maxOccurs /minOccurs атрибуты (то что будет только один)
CREATE XML SCHEMA COLLECTION STUDENT1 AS
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault = "unqualified"
elementFormDefault="qualified"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="Контактная_информация">
<xs:complexType>
<xs:sequence>
<xs:element name="Паспортные_данные" maxOccurs="1" minOccurs="1">
<xs:complexType>
<xs:sequence>
<xs:element name="Серия" type="xs:string"/>
<xs:element name="Номер_паспорта" type="xs:integer"/>
<xs:element name="Дата_выдачи" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
<xs:element name="Адрес">
<xs:complexType>
<xs:sequence>
<xs:element name="Страна" type="xs:string"/>
<xs:element name="Город" type="xs:string"/>
<xs:element name="Улица" type="xs:string"/>
<xs:element name="Дом" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:schema>';

alter table STUDENT ALTER COLUMN INFO xml(STUDENT1)

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1050, 51, N'Пекарев Ефросий Евгеньевич', cast('30-08-2002' as date), 
N'<Контактная_информация>
<Паспортные_данные>
<Серия>МР</Серия>
<Номер_паспорта>8974521</Номер_паспорта>
<Дата_выдачи>2018.04.04
</Дата_выдачи>
</Паспортные_данные>
<Адрес>
<Страна>Россия</Страна>
<Город>Урюпинск</Город>
<Улица>Ленина</Улица>
</Адрес>
</Контактная_информация>')

select * from STUDENT

insert STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY, INFO)
values(1051, 51, N'Беков Магомед Иванович', cast('06-07-1999' as date), 
N'<Контактная_информация>
<Паспортные_данные>
<Серия>МР</Серия>
<Номер_паспорта>6712817</Номер_паспорта>
<Дата_выдачи>2015.09.09
</Дата_выдачи>
</Паспортные_данные>
<Паспортные_данные>
<Серия>МР</Серия>
</Паспортные_данные>
<Адрес>
<Страна>Россия</Страна>
<Город>Уфа</Город>
<Улица>Валеева</Улица>
</Адрес>
</Контактная_информация>')
-----------------&&&&&&5
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

select NAME ,INFO from STUDENT where NAME ='Лыкова Юлия Дмитриевна'
alter table STUDENT alter column INFO XML (STUDENT)


----------------------MyBase------------------------
use DB_Lykova

--1--
go 
select  [CREDITS].Наименование_кредита [CREDITS]
from CREDITS
where [CREDITS].Наименование_кредита  = 'Льготный' for xml PATH('Наименование_кредита'),
root('Список')


--2-- 
go
select OFORMLENN_CREDITS.Название_кредита,OFORMLENN_CREDITS.Название_фирмы_клиента, CREDITS.Наименование_кредита
from OFORMLENN_CREDITS  join CREDITS 
on OFORMLENN_CREDITS.Название_кредита = CREDITS.Наименование_кредита
WHERE OFORMLENN_CREDITS.Название_кредита LIKE '%На_машину%'
for xml auto,root('кредит'), elements;

--3--????????????????
go
   declare @h int = 0,
@x varchar(2000) = N'<?xml version= "1.0" encoding = "windows-1251" ?>
<ROOT>
<ofr Контактное_лицо = "Шахнович Д.С" Адрес = "ул.Нола,д.20" Телефон= "0843209" />
<ofr Контактное_лицо = "Мельникович В.В." Адрес = "ул.Гид,д.25" Телефон= "234567" />
<ofr Контактное_лицо = "Рубец С.Э." Адрес= "ул.Нол,д.30" Телефон= "8392386" />
</ROOT>';
exec sp_xml_preparedocument @h output,@x;--подготовка документа
insert CLIENTS
select [Контактное_лицо],[Адрес],[Телефон] 
from openxml(@h,'/ROOT/subj',0)
with([Контактное_лицо] nvarchar(30),[Адрес] nvarchar(30),[Телефон] nvarchar(30))
exec sp_xml_removedocument @h;

select * from CLIENTS

--4--
create table DATA_T
( Серия_паспорта nvarchar(50) primary key,
Номер_паcпорта xml
);
insert into DATA_T(Серия_паспорта,Номер_паcпорта)
values ('SWE','<номер_папорта>34567890</номер_папорта>');

insert into DATA_T(Серия_паспорта,Номер_паcпорта)
values ('РБ','<номер_папорта>5362820</номер_папорта>');

select Серия_паспорта,
Номер_паcпорта.value('(/номер_папорта)[1]','varchar(50)')[номер_папорта],
Номер_паcпорта.query('/номер_папорта')[номер]
from DATA_T
