/*найти кол студентов которые сдавали субд если из больше 4 то и вывести х количество 
если меньше 4 вывести количество */
--Progress

DECLARE @x INT=(select count(*) FROM PROGRESS);
IF (SELECT count(*) FROM PROGRESS)>0
BEGIN
PRINT 'больше 4';
PRINT'='+CAST (@x AS VARCHAR (10));
end;
begin
PRINT 'меньше 4';
PRINT '='+CAST (@x AS VARCHAR (10));
END;
