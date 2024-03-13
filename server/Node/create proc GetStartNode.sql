drop proc if exists GetStartNode
/*
  GetStartNode - ��������� �������������� ���������� ���������
*/
go
create proc GetStartNode
              @ModelID          numeric(18,0) = null -- �� ������ ���������
			 ,@ObjectTypeID     numeric(18,0) = null -- �� ������� ������� ��� �������� ������������ ������
			 --,@NodeID           numeric(18,0) = null output -- �� ������� tNode.NodeID 
			 ,@StatusID         numeric(18,0) = null output -- �� ���������� ���������, ������ �� ������� � tOrders.StatusID
			 --,@Brief	        nvarchar(128) = null output -- ���������� ��������� 
            -- ,@Name   	        nvarchar(256) = null output -- ������������ ���������
	 
as
  declare @r int = 0



Select top 1 @StatusID =  m.StateID --, t.Flag
  from [tInstrument] t (nolock)
 inner join tModel m (nolock)
         on m.InstrumentID = t.InstrumentID
		and m.Flag&1=1
 where t.ObjectTypeID = @ObjectTypeID
    or m.ModelID = @ModelID
 order by m.ModelID


 exit_:
 return @r
go
grant exec on GetStartNode to public
go
exec setOV 'GetStartNode', 'P', '20240101', '0'
go

