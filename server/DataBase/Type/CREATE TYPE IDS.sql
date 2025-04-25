-- тип данных идентификаторы
drop TYPE if exists SID
go
CREATE TYPE SID AS TABLE
(
    Name varchar(60)
);
go
--GRANT REFERENCES ON TYPE::dbo.SID TO Public;
go
GRANT EXECUTE ON TYPE::dbo.SID TO Public;