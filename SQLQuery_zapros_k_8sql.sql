/*����� ��� ��������� ������� ������� ���� ���� �� ������ 4 �� � ������� � ���������� 
���� ������ 4 ������� ���������� */
--Progress

DECLARE @x INT=(select count(*) FROM PROGRESS);
IF (SELECT count(*) FROM PROGRESS)>0
BEGIN
PRINT '������ 4';
PRINT'='+CAST (@x AS VARCHAR (10));
end;
begin
PRINT '������ 4';
PRINT '='+CAST (@x AS VARCHAR (10));
END;
