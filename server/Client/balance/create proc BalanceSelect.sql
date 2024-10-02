if OBJECT_ID('BalanceSelect') is not null
    drop proc BalanceSelect
/* **********************************************************
  BalanceSelect - 

********************************************************** */
go
create proc BalanceSelect
              @ClientID   numeric(18,0)  
             ,@BDate      datetime
             ,@EDate      datetime 
as
set nocount on;

declare @r     int = 0
       ,@Rest  money

if OBJECT_ID('tempdb..#Documents') is not null
  drop table #Documents;
create table #Documents
(
 DocumentID  numeric(18,0) 
,ClientID    numeric(18,0)
,Number      nvarchar(255)  
,Date        datetime
,Amount      money
,Balance     money
,Comment	 nvarchar(512) 
,Flag        int
);


if @ClientID = -1
begin
    -- по всем клиентам
    Insert #Documents
          (DocumentID
          ,Flag
          ,Number
          ,Date
          ,Amount
          ,Comment
          ,ClientID
          )
    select d.DocumentID
          ,d.Flag
          ,d.Number
          ,d.Date
          ,d.Amount
          ,d.Comment
          ,d.ClientID
      from tDocuments d (nolock)
     where d.Date between @BDate and @EDate

    Update d
       set d.Balance = isnull((select sum(d2.Amount*d2.Type)
                                 from tDocuments d2 (nolock)
                                where d2.Date between @BDate and @EDate
                                  and d2.DocumentID<= d.DocumentID
                               ), 0)
      from #Documents d (updlock)
   
    set @Rest = isnull((select sum(Amount*Type)
                          from tDocuments (nolock)
                         where Date between @BDate and @EDate
                        ), 0)
end
else
begin

    Insert #Documents
          (DocumentID
          ,Flag
          ,Number
          ,Date
          ,Amount
          ,Comment
          ,ClientID
          )
    select d.DocumentID
          ,d.Flag
          ,d.Number
          ,d.Date
          ,d.Amount
          ,d.Comment
          ,d.ClientID
      from tDocuments d (nolock)
     where d.ClientID = @ClientID
       and d.Date between @BDate and @EDate

    Update d
       set d.Balance = isnull((select sum(d2.Amount*d2.Type)
                                 from tDocuments d2 (nolock)
                                where d2.Date between @BDate and @EDate
                                  and d2.ClientID   = @ClientID
                                  and d2.DocumentID<= d.DocumentID
                               ), 0)
      from #Documents d (updlock)
   
    set @Rest = isnull((select sum(Amount*Type)
                          from tDocuments (nolock)
                         where Date between @BDate and @EDate
                           and ClientID = @ClientID
                        ), 0)
end

select DocumentID
      ,Case
         when Flag&1>0 then 'Пополнение баланса'
         else ''
       end       as Document
      ,Number
      ,Date
      ,Amount
      ,Balance 
      ,Comment

      ,@Rest     as Rest
  from #Documents (nolock)
 order by DocumentID desc




exit_:
return @r
go
grant exec on BalanceSelect to public
go
exec setOV 'BalanceSelect', 'P', '20240101', '0'
go
