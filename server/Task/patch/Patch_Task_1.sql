alter table tTask
drop column LinkID
go
alter table tTask
drop column Field
go
alter table tTask
drop column [TaskType]
go
alter table tTask
add Flag int
