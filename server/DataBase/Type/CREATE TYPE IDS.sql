-- тип данных идентификаторы
drop TYPE if exists SID
go
CREATE TYPE SID AS TABLE
(
    Name varchar(60)
);
