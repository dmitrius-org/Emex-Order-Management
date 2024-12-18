-- тип данных идентификаторы
drop TYPE if exists ID
go
CREATE TYPE ID AS TABLE
(
    ID numeric(18, 0)
);
go
--GRANT REFERENCES ON TYPE::dbo.ID TO Public;
go
GRANT EXECUTE ON TYPE::dbo.ID TO Public;

