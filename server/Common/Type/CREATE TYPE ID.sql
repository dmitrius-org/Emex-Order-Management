-- тип данных идентификаторы
drop TYPE if exists ID
go
CREATE TYPE ID AS TABLE
(
    ID numeric(18, 0)
);


