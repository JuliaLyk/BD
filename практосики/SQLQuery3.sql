--�� ������ �������� ��������� ����� � ��� 30101
--drop procedure AUDITORIUM_T
--1--
go
ALTER procedure AUDITORIUM_TT @AUD  nvarchar(40)
as 
begin 
declare @t  nvarchar(40)
set @t  =(select AUDITORIUM_NAME FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
WHERE AUDITORIUM.AUDITORIUM=@AUD)
return @t 
END
go
declare @s  nvarchar(40) 
exec @s=AUDITORIUM_TT @AUD='301-1'
print '��� ���������' + cast(@s as nvarchar(40));


 

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


--2--
create function AUDITORIUM_T (@AUD nvarchar(40))returns int
as



























 