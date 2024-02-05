drop table if exists pAuditInsert
go
/* **********************************************************
pAccrualAction - 
********************************************************** */
create table pAuditInsert
(
 Spid             numeric(18,0)  not null  
,AuditID          numeric(18, 0)            
,ObjectID         numeric(18, 0) not null   -- �� ������� �� �������� ������� �����
,ObjectTypeID     numeric(18, 0) not null   -- ��� ������� 
,ActionID         numeric(18, 0) not null   -- �� ����������� ������� �� tAction
,Comment          nvarchar(1024)            -- �����������
,UserID           numeric(18, 0) 
,HostInfoID       nvarchar(256)
,Retval           int
)
go
create index ao1 on pAuditInsert(Spid, ObjectID, ActionID)
go
create index ao2 on pAuditInsert(Spid, Retval)
go
grant all on pAuditInsert to public
go
-- �������� �������
exec dbo.sys_setTableDescription @table = 'pAuditInsert', @desc = '��������� ������� ��� ��������� ���������� ������ �� �������'
