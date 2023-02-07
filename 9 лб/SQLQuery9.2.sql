Use UNIVER
exec SP_HELPINDEX'AUDITORIUM_TYPE'

CREATE table #EXPLRE
(TIND int,
TFIELD varchar(100)
);

set nocount on;--не выводить сообщение о вводе строк
DECLARE @i int=0;
WHILE @i<1000
begin
INSERT #EXPLRE(TIND, TFIELD)
values(floor(
