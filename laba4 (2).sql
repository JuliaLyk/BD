

use master
create database UNIVER on primary
( name = N'UNIVER_mdf', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба4\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба4\ER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба4\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба4\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба4\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);


------------Создание и заполнение таблицы AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('ЛК',            'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('ЛБ-К',          'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('ЛК-К',          'Лекционная с уст. проектором');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('ЛБ-X',          'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('ЛБ-СК',   'Спец. компьютерный класс');
                      
-------------Создание и заполнение таблицы AUDITORIUM  
  create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
   AUDITORIUM_NAME      varchar(50)                                     
)
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', 'ЛК-К',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', 'ЛК-К',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', 'ЛК',  90);

  ------Создание и заполнение таблицы FACULTY
  create table FACULTY
  (    FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИТ',     'Факультет информационных технологий');  
------Создание и заполнение таблицы PROFESSION
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-40 01 02',   'Информационные системы и технологии', 'инженер-программист-системотехник' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-47 01 01', 'Издательское дело', 'редактор-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-36 06 01',  'Полиграфическое оборудование и системы обработки информации', 'инженер-электромеханик' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ХТиТ',  '1-36 01 08',    'Конструирование и производство изделий из композиционных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ХТиТ',  '1-36 07 01',  'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ЛХФ',  '1-75 01 01',      'Лесное хозяйство', 'инженер лесного хозяйства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-75 02 01',   'Садово-парковое строительство', 'инженер садово-паркового строительства' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-89 02 02',     'Туризм и природопользование', 'специалист в сфере туризма' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ИЭФ',  '1-25 01 07',  'Экономика и управление на предприятии', 'экономист-менеджер' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ИЭФ',  '1-25 01 08',    'Бухгалтерский учет, анализ и аудит', 'экономист' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('ТТЛП',  '1-36 05 01',   'Машины и оборудование лесного комплекса', 'инженер-механик' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('ТТЛП',  '1-46 01 01',      'Лесоинженерное дело', 'инженер-технолог' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('ТОВ',  '1-48 01 02',  'Химическая технология органических веществ, материалов и изделий', 'инженер-химик-технолог' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('ТОВ',  '1-48 01 05',    'Химическая технология переработки древесины', 'инженер-химик-технолог' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-54 01 03',   'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' ); 

------Создание и заполнение таблицы PULPIT
  create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('ИСиТ', 'Информационных систем и технологий ','ИТ'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('ЛВ', 'Лесоводства','ЛХФ')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛУ', 'Лесоустройства','ЛХФ')           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('ЛЗиДВ', 'Лесозащиты и древесиноведения','ЛХФ')                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ЛКиП', 'Лесных культур и почвоведения','ЛХФ') 
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ')              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛПиСПС','Ландшафтного проектирования и садово-паркового строительства','ЛХФ')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТЛ', 'Транспорта леса', 'ТТЛП')                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ЛМиЛЗ','Лесных машин и технологии лесозаготовок','ТТЛП')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТДП','Технологий деревообрабатывающих производств', 'ТТЛП')   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ТиДИД','Технологии и дизайна изделий из древесины','ТТЛП')    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ОХ', 'Органической химии','ТОВ') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ХПД','Химической переработки древесины','ТОВ')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии ','ХТиТ') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('ПиАХП','Процессов и аппаратов химических производств','ХТиТ')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ЭТиМ',    'Экономической теории и маркетинга','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('МиЭП',   'Менеджмента и экономики природопользования','ИЭФ')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('СБУАиА', 'Статистики, бухгалтерского учета, анализа и аудита', 'ИЭФ')     
             
------Создание и заполнение таблицы TEACHER
 create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('м', 'ж')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('СМЛВ',    'Смелов Владимир Владиславович', 'м',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('АКНВЧ',    'Акунович Станислав Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('КЛСНВ',    'Колесников Виталий Леонидович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('БРКВЧ',    'Бракович Андрей Игоревич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ДТК',     'Дятко Александр Аркадьевич', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('УРБ',     'Урбанович Павел Павлович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('ГРН',     'Гурин Николай Иванович', 'м', 'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ж', 'ИСиТ');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('МРЗ',     'Мороз Елена Станиславовна',  'ж',   'ИСиТ');                                                                                                                 
insert into  TEACHER    (TEACHER,  TEACHER_NAME,GENDER, PULPIT )
                       values  ('БРНВСК',   'Барановский Станислав Иванович', 'м', 'ЭТиМ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('НВРВ',   'Неверов Александр Васильевич', 'м', 'МиЭП');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('РВКЧ',   'Ровкач Андрей Иванович', 'м', 'ЛВ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ДМДК', 'Демидко Марина Николаевна',  'ж',  'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('БРГ',     'Бурганская Татьяна Минаевна', 'ж', 'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('РЖК',   'Рожков Леонид Николаевич ', 'м', 'ЛВ');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('ЗВГЦВ',   'Звягинцев Вячеслав Борисович', 'м', 'ЛЗиДВ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('БЗБРДВ',   'Безбородов Владимир Степанович', 'м', 'ОХ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('НСКВЦ',   'Насковец Михаил Трофимович', 'м', 'ТЛ'); 
	------Создание и заполнение таблицы SUBJECT
create table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )
 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('СУБД',   'Системы управления базами данных', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('БД',     'Базы данных','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ИНФ',    'Информационные технологии','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПСП',    'Программирование сетевых приложений', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('МСОИ',  'Моделирование систем обработки информации', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('ПИС',     'Проектирование информационных систем', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КГ',      'Компьютерная геометрия ','ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('ДМ',   'Дискретная математика', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('МП',   'Математическое программирование','ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',  'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭП', 'Экономика природопользования','МиЭП')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ЭТ', 'Экономическая теория','ЭТиМ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОСПиЛПХ','Основы садово-паркового и лесопаркового хозяйства',  'ЛПиСПС')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ИГ', 'Инженерная геодезия ','ЛУ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ЛВ',    'Лесоводство', 'ЛЗиДВ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ОХ',    'Органическая химия', 'ОХ')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('ВТЛ',    'Водный транспорт леса','ТЛ')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок', 'ЛМиЛЗ') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('ТОПИ',   'Технология обогащения полезных ископаемых ','ТНВиОХТ')                                                                                                                                                      
  
------Создание и заполнение таблицы GROUPS
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ХТиТ','1-36 01 08', 2013),---12 гр                                                  
                ('ХТиТ','1-36 01 08', 2012),
                ('ХТиТ','1-36 07 01', 2011),
                ('ХТиТ','1-36 07 01', 2010),
                ('ТОВ','1-48 01 02', 2012), ---16 гр 
                ('ТОВ','1-48 01 02', 2011),
                ('ТОВ','1-48 01 05', 2013),
                ('ТОВ','1-54 01 03', 2012),
                ('ЛХФ','1-75 01 01', 2013),--20 гр      
                ('ЛХФ','1-75 02 01', 2012),
                ('ЛХФ','1-75 02 01', 2011),
                ('ЛХФ','1-89 02 02', 2012),
                ('ЛХФ','1-89 02 02', 2011),  
                ('ТТЛП','1-36 05 01', 2013),
                ('ТТЛП','1-36 05 01', 2012),
                ('ТТЛП','1-46 01 01', 2012),--27 гр
                ('ИЭФ','1-25 01 07', 2013), 
                ('ИЭФ','1-25 01 07', 2012),     
                ('ИЭФ','1-25 01 07', 2010),
                ('ИЭФ','1-25 01 08', 2013),
                ('ИЭФ','1-25 01 08', 2012) ---32 гр       
                          
------Создание и заполнение таблицы STUDENT
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
    values (2, 'Силюк Валерия Ивановна',         '12.07.1994'),
           (2, 'Сергель Виолетта Николаевна',    '06.03.1994'),
           (2, 'Добродей Ольга Анатольевна',     '09.11.1994'),
           (2, 'Подоляк Мария Сергеевна',        '04.10.1994'),
           (2, 'Никитенко Екатерина Дмитриевна', '08.01.1994'),
           (3, 'Яцкевич Галина Иосифовна',       '02.08.1993'),
           (3, 'Осадчая Эла Васильевна',         '07.12.1993'),
           (3, 'Акулова Елена Геннадьевна',      '02.12.1993'),
           (4, 'Плешкун Милана Анатольевна',     '08.03.1992'),
           (4, 'Буянова Мария Александровна',    '02.06.1992'),
           (4, 'Харченко Елена Геннадьевна',     '11.12.1992'),
           (4, 'Крученок Евгений Александрович', '11.05.1992'),
           (4, 'Бороховский Виталий Петрович',   '09.11.1992'),
           (4, 'Мацкевич Надежда Валерьевна',    '01.11.1992'),
           (5, 'Логинова Мария Вячеславовна',    '08.07.1995'),
           (5, 'Белько Наталья Николаевна',      '02.11.1995'),
           (5, 'Селило Екатерина Геннадьевна',   '07.05.1995'),
           (5, 'Дрозд Анастасия Андреевна',      '04.08.1995'),
           (6, 'Козловская Елена Евгеньевна',    '08.11.1994'),
           (6, 'Потапнин Кирилл Олегович',       '02.03.1994'),
           (6, 'Равковская Ольга Николаевна',    '04.06.1994'),
           (6, 'Ходоронок Александра Вадимовна', '09.11.1994'),
           (6, 'Рамук Владислав Юрьевич',        '04.07.1994'),
           (7, 'Неруганенок Мария Владимировна', '03.01.1993'),
           (7, 'Цыганок Анна Петровна',          '12.09.1993'),
           (7, 'Масилевич Оксана Игоревна',      '12.06.1993'),
           (7, 'Алексиевич Елизавета Викторовна','09.02.1993'),
           (7, 'Ватолин Максим Андреевич',       '04.07.1993'),
           (8, 'Синица Валерия Андреевна',       '08.01.1992'),
           (8, 'Кудряшова Алина Николаевна',     '12.05.1992'),
           (8, 'Мигулина Елена Леонидовна',      '08.11.1992'),
           (8, 'Шпиленя Алексей Сергеевич',      '12.03.1992'),
           (9, 'Астафьев Игорь Александрович',   '10.08.1995'),
           (9, 'Гайтюкевич Андрей Игоревич',     '02.05.1995'),
           (9, 'Рученя Наталья Александровна',   '08.01.1995'),
           (9, 'Тарасевич Анастасия Ивановна',   '11.09.1995'),
           (10, 'Жоглин Николай Владимирович',   '08.01.1994'),
           (10, 'Санько Андрей Дмитриевич',      '11.09.1994'),
           (10, 'Пещур Анна Александровна',      '06.04.1994'),
           (10, 'Бучалис Никита Леонидович',     '12.08.1994')
insert into STUDENT (IDGROUP,NAME, BDAY)
    values (11, 'Лавренчук Владислав Николаевич','07.11.1993'),
           (11, 'Власик Евгения Викторовна',     '04.06.1993'),
           (11, 'Абрамов Денис Дмитриевич',      '10.12.1993'),
           (11, 'Оленчик Сергей Николаевич',     '04.07.1993'),
           (11, 'Савинко Павел Андреевич',       '08.01.1993'),
           (11, 'Бакун Алексей Викторович',      '02.09.1993'),
           (12, 'Бань Сергей Анатольевич',       '11.12.1995'),
           (12, 'Сечейко Илья Александрович',    '10.06.1995'),
           (12, 'Кузмичева Анна Андреевна',      '09.08.1995'),
           (12, 'Бурко Диана Францевна',         '04.07.1995'),
           (12, 'Даниленко Максим Васильевич',   '08.03.1995'),
           (12, 'Зизюк Ольга Олеговна',          '12.09.1995'),
           (13, 'Шарапо Мария Владимировна',     '08.10.1994'),
           (13, 'Касперович Вадим Викторович',   '10.02.1994'),
           (13, 'Чупрыгин Арсений Александрович','11.11.1994'),
           (13, 'Воеводская Ольга Леонидовна',   '10.02.1994'),
           (13, 'Метушевский Денис Игоревич',    '12.01.1994'),
           (14, 'Ловецкая Валерия Александровна','11.09.1993'),
           (14, 'Дворак Антонина Николаевна',    '01.12.1993'),
           (14, 'Щука Татьяна Николаевна',       '09.06.1993'),
           (14, 'Коблинец Александра Евгеньевна','05.01.1993'),
           (14, 'Фомичевская Елена Эрнестовна',  '01.07.1993'),
           (15, 'Бесараб Маргарита Вадимовна',   '07.04.1992'),
           (15, 'Бадуро Виктория Сергеевна',     '10.12.1992'),
           (15, 'Тарасенко Ольга Викторовна',    '05.05.1992'),
           (15, 'Афанасенко Ольга Владимировна', '11.01.1992'),
           (15, 'Чуйкевич Ирина Дмитриевна',     '04.06.1992'),
           (16, 'Брель Алеся Алексеевна',        '08.01.1994'),
           (16, 'Кузнецова Анастасия Андреевна', '07.02.1994'),
           (16, 'Томина Карина Геннадьевна',     '12.06.1994'),
           (16, 'Дуброва Павел Игоревич',        '03.07.1994'),
           (16, 'Шпаков Виктор Андреевич',       '04.07.1994'),
           (17, 'Шнейдер Анастасия Дмитриевна',  '08.11.1993'),
           (17, 'Шыгина Елена Викторовна',       '02.04.1993'),
           (17, 'Клюева Анна Ивановна',          '03.06.1993'),
           (17, 'Доморад Марина Андреевна',      '05.11.1993'),
           (17, 'Линчук Михаил Александрович',   '03.07.1993'),
           (18, 'Васильева Дарья Олеговна',      '08.01.1995'),
           (18, 'Щигельская Екатерина Андреевна','06.09.1995'),
           (18, 'Сазонова Екатерина Дмитриевна', '08.03.1995'),
           (18, 'Бакунович Алина Олеговна',      '07.08.1995')

------Создание и заполнение таблицы PROGRESS
create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('ОАиП', 1001,  '01.10.2013',8),
           ('ОАиП', 1002,  '01.10.2013',7),
           ('ОАиП', 1003,  '01.10.2013',5),
           ('ОАиП', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('СУБД', 1014,  '01.12.2013',5),
           ('СУБД', 1015,  '01.12.2013',9),
           ('СУБД', 1016,  '01.12.2013',5),
           ('СУБД', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('КГ',   1018,  '06.5.2013',4),
           ('КГ',   1019,  '06.05.2013',7),
           ('КГ',   1020,  '06.05.2013',7),
           ('КГ',   1021,  '06.05.2013',9),
           ('КГ',   1022,  '06.05.2013',5),
           ('КГ',   1023,  '06.05.2013',6)




 -- Выполнение лабораторной работы 


 --КОЛ-ВО ПРЕПОДОВ НА КАЫЕДРЕ, КАЫЕДРА ПАРАМЕТР
GO
CREATE PROCEDURE PREP  @KAF varchar(20) = null
AS
BEGIN 
SELECT COUNT(TEACHER.TEACHER) FROM TEACHER 
							WHERE TEACHER.PULPIT= @KAF;
END;
GO 
EXEC PREP @KAF = 'ИСиТ'
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
PRINT 'Тип аудитории 301-1: '+CAST(@F AS VARCHAR(20));
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
(AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  Like N'Компьютер%');

 -- 3.
 
  select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
  From AUDITORIUM, AUDITORIUM_TYPE
  Where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

  select T1.AUDITORIUM, T2.AUDITORIUM_TYPENAME
  From AUDITORIUM T1, AUDITORIUM_TYPE T2
  Where T1.AUDITORIUM_TYPE = T2.AUDITORIUM_TYPE and (T2.AUDITORIUM_TYPENAME  Like N'Компьютер%');

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


SELECT isnull (TEACHER.TEACHER_NAME,'***')[Преподаватель],PULPIT.PULPIT_NAME[Кафедра]
FROM PULPIT Left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[Преподаватель],PULPIT.PULPIT_NAME[Кафедра]
FROM TEACHER Left outer join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[Преподаватель],PULPIT.PULPIT_NAME[Кафедра]
FROM PULPIT Right outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

SELECT isnull (TEACHER.TEACHER_NAME,'***')[Преподаватель],PULPIT.PULPIT_NAME[Кафедра]
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


create database КурсыПовышенияКвалификации on primary
( name = N'КурсыПовышенияКвалификацииDataBase_mdf', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба3\КурсыПовышенияКвалификацииDataBase_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'КурсыПовышенияКвалификацииDataBase_ndf', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба3\КурсыПовышенияКвалификацииDataBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'КурсыПовышенияКвалификацииDataBase_fg1_1', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба3\КурсыПовышенияКвалификацииDataBase_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'КурсыПовышенияКвалификацииDataBase_fg1_2', filename = N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба3\КурсыПовышенияКвалификацииDataBase_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'КурсыПовышенияКвалификацииDataBase_log', filename=N'G:\Программы малышей\ЛабораторныеРаботы\БД\Лаба3\КурсыПовышенияКвалификацииDataBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);

use КурсыПовышенияКвалификации
CREATE TABLE ГРУППА
( НомерГруппы int primary key,
  Специальность nvarchar(50) not null,
  Отделение nvarchar(50),
  КоличествоСтудентов int 
);

CREATE TABLE ПРЕПОДАВАТЕЛЬ
(
	КодПреподавателя int primary key,
	Фамилия nvarchar(50),
	Имя nvarchar(50),
	Отчество nvarchar(50),
	Телефон nvarchar(50),
	Стаж nvarchar(50)	
)

CREATE TABLE ПРЕДМЕТ
( КодПредмета int primary key,
  Предмет nvarchar(50),
  КоличествоЧасов int
)

CREATE TABLE ЗАНЯТИЕ
( IDзанятия int primary key,
  ТипЗаниятия nvarchar(50) check (ТипЗаниятия in ('ЛР','ПЗ','ЛК')),
  Преподаватель int foreign key references ПРЕПОДАВАТЕЛЬ(КодПреподавателя),
  КодПредмета int foreign key references ПРЕДМЕТ(КодПредмета),
  Оплата money
);

CREATE TABLE ПреподаваемыйПредмет
(
	АртикулПреподавания int primary key,
	NГруппы int foreign key references ГРУППА(НомерГруппы),
	НомерЗанятия int foreign key references ЗАНЯТИЕ(IDзанятия)
)


ALTER Table ЗАНЯТИЕ DROP Column Оплата;

ALTER TABLE ЗАНЯТИЕ 
ADD Оплата money ; 


/*
ALTER TABLE товары
ADD Мужской_женский nchar(1) default 'м' check (Мужской_женский in ('м','ж'));
ALTER Table Товары DROP Column Дата_поступления;
DROP table ТОВАРЫ;
*/

INSERT into ГРУППА(НомерГруппы, Специальность, Отделение, КоличествоСтудентов)
			Values (1, 'ИСИТ','ИС', 26),
				   (2, 'ИСИТ','ИС', 27),
				   (3, 'ПОИТ','ПИ', 23),
				   (4, 'ПОИТ','ПИ', 25),
				   (5, 'ПОИМБС','ИС', 29),
				   (6, 'ДЭИВИ','ДЭВ', 21);
				   
INSERT into ПРЕПОДАВАТЕЛЬ (КодПреподавателя, Фамилия, Имя, Отчество, Телефон, Стаж)	
			values (1,'Настерчук','Андрей','Аркадьевич','375444767124','6'),
				   (2,'Молодок','Никита','Витальевич','375447694523','3'),
				   (3,'Романова ','Ангелина ','Сергеевна','375917872352','5'),
				   (4,'Серый','Михаил','Павловна','375444909884','8'),
				   (5,'Аладьев','Анатолий','Павлович','375648796986','2'),
				   (6,'Мирная','Кирилл','Витальевич','375445235252','7'),
				   (7,'Абрамченко ','Анастасия','Антонович','375868768752','5'),
				   (8,'Димиденко','Анна ','Павловна','375447589996','14'),
				   (9,'Дворовенко','Максим','Геннадьевич','375298768752','14');

INSERT into ПРЕДМЕТ(КодПредмета, Предмет , КоличествоЧасов )
			values (1,'АЛОИЦВМ',72),
				   (2,'МАТАН',108),
				   (3,'ЛинАлг',108),
				   (4,'ООП',400),
				   (5,'БД',300),
				   (6,'ОАиП',108),
				   (7,'ОЗИ',36),
				   (8,'История',72),
				   (9,'Физкультура',400),
				   (10,'КЯРД',108),
				   (11,'СЯП',200),
				   (12,'КС',160),
				   (13,'ТерВер',200),
				   (14,'Английский ',500),
				   (15,'ПВС',108)
				   

INSERT into ЗАНЯТИЕ (IDзанятия , ТипЗаниятия, Преподаватель, КодПредмета , Оплата )
			values (1,'ЛР',1,1,20),
				   (2,'ПЗ',2,1,15),
				   (3,'ЛК',5,2,40),
				   (4,'ЛР',2,2,20),
				   (5,'ЛК',1,3,30),
				   (6,'ЛР',1,3,20),
				   (7,'ЛК',2,3,30),
				   (8,'ПЗ',6,5,15),
				   (9,'ЛК',8,4,20),
				   (10,'ПЗ',9,1,57),
				   (11,'ПЗ',5,8,15),
				   (12,'ЛР',3,6,20),
				   (13,'ЛК',3,12,20),
				   (14,'ЛК',3,15,30),
				   (15,'ЛР',2,15,20),
				   (16,'ЛР',5,6,20),
				   (17,'ЛК',8,14,30),
				   (18,'ЛК',9,13,41),
				   (19,'ЛК',7,14,63),
				   (20,'ПЗ',8,10,11),
				   (21,'ЛК',4,13,10),
				   (22,'ПЗ',6,7,40),
				   (23,'ЛК',5,7,30),
				   (24,'ЛР',1,5,49),
				   (25,'ЛК',2,7,40),
				   (26,'ЛР',3,6,30),
				   (27,'ЛК',3,5,20),
				   (28,'ЛР',5,10,30),
				   (29,'ЛК',4,15,30),
				   (30,'ПЗ',5,10,40);

use КурсыПовышенияКвалификации
INSERT into ПреподаваемыйПредмет (АртикулПреподавания, NГруппы, НомерЗанятия)
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
		   

SELECT COUNT(*) From ЗАНЯТИЕ; 

SELECT Предмет  , КоличествоЧасов  FROM ПРЕДМЕТ
Where КоличествоЧасов < 200 ; 


/*distinct - не выводит повторяющиеся строки */
SELECT DISTINCT TOP(5)  КодПредмета, Предмет  , КоличествоЧасов FROM ПРЕДМЕТ
Where КоличествоЧасов < 200 ; 

UPDATE ЗАНЯТИЕ set Оплата = Оплата+5 Where КодПредмета = '3';


SELECT Имя, Фамилия, Стаж FROM ПРЕПОДАВАТЕЛЬ
Where Стаж Between '1'And '6';

SELECT distinct Имя, Фамилия, Стаж FROM ПРЕПОДАВАТЕЛЬ
Where Фамилия Like 'Д%';

SELECT distinct КодПредмета,Предмет FROM ПРЕДМЕТ Where КоличествоЧасов In (400, 108);




-- 1

SELECT ПРЕПОДАВАТЕЛЬ.КодПреподавателя, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия, ЗАНЯТИЕ.Оплата
FROM ПРЕПОДАВАТЕЛЬ INNER JOIN ЗАНЯТИЕ 
ON ПРЕПОДАВАТЕЛЬ.КодПреподавателя = ЗАНЯТИЕ.Преподаватель;

-- 2 

SELECT ПРЕПОДАВАТЕЛЬ.КодПреподавателя, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия, ЗАНЯТИЕ.Оплата
FROM ПРЕПОДАВАТЕЛЬ INNER JOIN ЗАНЯТИЕ 
ON ПРЕПОДАВАТЕЛЬ.КодПреподавателя = ЗАНЯТИЕ.Преподаватель
AND 
(ЗАНЯТИЕ.ТипЗаниятия LIKE N'ЛК');

-- 3 

SELECT ГРУППА.Специальность, ПреподаваемыйПредмет.НомерЗанятия
FROM ГРУППА, ПреподаваемыйПредмет
WHERE ГРУППА.НомерГруппы = ПреподаваемыйПредмет.NГруппы;



SELECT Т1.Специальность, Т2.НомерЗанятия
FROM ГРУППА Т1, ПреподаваемыйПредмет Т2
WHERE Т1.НомерГруппы = Т2.NГруппы AND (Т1.Специальность LIKE N'ИСиТ'); 

 
 -- 4


SELECT ГРУППА.НомерГруппы, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия, ПРЕДМЕТ.Предмет, ЗАНЯТИЕ.ТипЗаниятия

FROM	ГРУППА INNER JOIN ПреподаваемыйПредмет ON ГРУППА.НомерГруппы = ПреподаваемыйПредмет.NГруппы
		   INNER JOIN ЗАНЯТИЕ ON ПреподаваемыйПредмет.НомерЗанятия = ЗАНЯТИЕ.IDзанятия
		   INNER JOIN ПРЕДМЕТ ON ЗАНЯТИЕ.КодПредмета = ПРЕДМЕТ.КодПредмета
		   INNER JOIN ПРЕПОДАВАТЕЛЬ ON ПРЕПОДАВАТЕЛЬ.КодПреподавателя = ЗАНЯТИЕ.Преподаватель
		order by ГРУППА.НомерГруппы desc ; 
 -- 5


 SELECT ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия, ПРЕДМЕТ.Предмет, ЗАНЯТИЕ.ТипЗаниятия,
   case
	when (ГРУППА.НомерГруппы  between 1 and 1) then 'один'
	when (ГРУППА.НомерГруппы  between 2 and 2) then 'два'
	when (ГРУППА.НомерГруппы  between 3 and 3) then 'три'
	when (ГРУППА.НомерГруппы  between 4 and 4) then 'четыре'
	when (ГРУППА.НомерГруппы  between 5 and 5) then 'пять'
	when (ГРУППА.НомерГруппы  between 6 and 6) then 'шесть'
	else 'another mark'
	end as 'Номер Группы'
FROM	ГРУППА INNER JOIN ПреподаваемыйПредмет ON ГРУППА.НомерГруппы = ПреподаваемыйПредмет.NГруппы
		   INNER JOIN ЗАНЯТИЕ ON ПреподаваемыйПредмет.НомерЗанятия = ЗАНЯТИЕ.IDзанятия
		   INNER JOIN ПРЕДМЕТ ON ЗАНЯТИЕ.КодПредмета = ПРЕДМЕТ.КодПредмета
		   INNER JOIN ПРЕПОДАВАТЕЛЬ ON ПРЕПОДАВАТЕЛЬ.КодПреподавателя = ЗАНЯТИЕ.Преподаватель;



-- 6 + 7 

select ЗАНЯТИЕ.Преподаватель, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ЗАНЯТИЕ LEFT OUTER JOIN ПРЕПОДАВАТЕЛЬ ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ;


select isnull (ЗАНЯТИЕ.Преподаватель, 0) [КодПрепода],isnull( ПРЕПОДАВАТЕЛЬ.Имя, '***')[Имя], ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ПРЕПОДАВАТЕЛЬ RIGHT OUTER JOIN ЗАНЯТИЕ ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ;

 --  8

select isnull (ЗАНЯТИЕ.Преподаватель, 0) [КодПрепода],isnull( ПРЕПОДАВАТЕЛЬ.Имя, '***')[Имя], ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ПРЕПОДАВАТЕЛЬ full OUTER JOIN ЗАНЯТИЕ ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ; 


select isnull (ЗАНЯТИЕ.Преподаватель, 0) [КодПрепода],isnull( ПРЕПОДАВАТЕЛЬ.Имя, '***')[Имя], ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ЗАНЯТИЕ full OUTER JOIN ПРЕПОДАВАТЕЛЬ ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ;


select isnull(ЗАНЯТИЕ.Преподаватель, 0) [КодПрепода], isnull( ПРЕПОДАВАТЕЛЬ.Имя, '***') [Имя], ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ЗАНЯТИЕ INNER join ПРЕПОДАВАТЕЛЬ
ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ;

select ЗАНЯТИЕ.Преподаватель, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ЗАНЯТИЕ full outer join ПРЕПОДАВАТЕЛЬ
ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя 
where ПРЕПОДАВАТЕЛЬ.КодПреподавателя  is null;

select ЗАНЯТИЕ.Преподаватель, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия 
FROM ПРЕПОДАВАТЕЛЬ full outer join ЗАНЯТИЕ
ON ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя 
where ПРЕПОДАВАТЕЛЬ.КодПреподавателя  is null;


-- 9 

select ЗАНЯТИЕ.Преподаватель, ПРЕПОДАВАТЕЛЬ.Имя, ПРЕПОДАВАТЕЛЬ.Фамилия 
from ЗАНЯТИЕ cross join ПРЕПОДАВАТЕЛЬ
where ЗАНЯТИЕ.Преподаватель = ПРЕПОДАВАТЕЛЬ.КодПреподавателя ;
