drop proc if exists GroupDetailNameUpdate
/*
  GroupDetailNameUpdate - изменение данных по заказу/детали
*/
go
create proc GroupDetailNameUpdate
              @DetailName             nvarchar(512) = null -- Наименование факт

              
as
  set nocount on;
  declare @r       int = 0
		 ,@AuditID  numeric(18,0)

  declare @PriceID as table(PriceID numeric(18, 0))

  update p
     set p.DetailNameF	   = nullif(@DetailName, '')
	from tMarks m (nolock)
   inner join tOrders t (nolock)
           on t.OrderID = m.ID
   inner join tPrice p (updlock)
           on p.DetailNum = t.DetailNumber
		  and p.MakeLogo  = t.MakeLogo -- производитель
   where m.Spid = @@SPID
     and m.Type = 3

 exit_:
 return @r
go
grant exec on GroupDetailNameUpdate to public
go
