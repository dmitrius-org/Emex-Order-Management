drop proc if exists CustomerReOrder
/*
  CustomerReOrder - перезаказываем отказанную позицию


*/
go
create proc CustomerReOrder
               @OrderID      numeric(18,0)                            
              ,@PriceLogo    nvarchar(64)  
              ,@MakeLogo     nvarchar(64)
              
as
  declare @r             int = 0
		 ,@Type          int
		 ,@AuditID       numeric(18,0)
   --      ,@AuditComment  nvarchar(2048)


 -- declare @PriceID as table(PriceID numeric(18, 0))

  update t
     set 
         t.PercentSupped    = p.PercentSupped
        ,t.Price            = p.PriceRub
        ,t.Amount           = p.PriceRub * t.Quantity
        ,t.ReplacementPrice = null
        ,t.PricePurchase    = p.Price
        ,t.AmountPurchase   = p.Price * t.Quantity
        ,t.AmountPurchaseF  = null
        ,t.MakeLogo         = p.Make
        ,t.PriceLogo        = p.PriceLogo
        ,t.isCancel         = 0
        ,t.Flag             = (isnull(t.Flag, 0) & ~4) 
                                               | 8192 /*Перезаказан*/
        --,t.StatusID        = 1	--New
        ,t.OrderDate        = cast(getdate() as date)
        ,t.BasketId         = null
        ,t.EmexOrderID      = null
        ,t.OrderDetailSubId = null
        ,t.Comment          = null
 -- OUTPUT INSERTED. INTO @PriceID(PriceID)  
	from tOrders t with (updlock index=ao1)
   cross apply ( select top 1 *
                   from pFindByNumber p with (nolock index=ao3)
                  where p.Spid = @@spid
                    and p.Make      = @MakeLogo
                    and p.DetailNum = t.DetailNumber
                    and p.PriceLogo = @PriceLogo
                ) as p
   where t.OrderID = @OrderID

  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn with (rowlock index=ao1) where spid = @@Spid
  insert pOrdersFinIn with (rowlock) 
        (Spid, OrderID)
  Select @@spid, @OrderID

  exec OrdersFinCalc @IsSave = 1

  delete pAccrualAction from pAccrualAction with (rowlock index=ao1) where spid = @@spid
  insert pAccrualAction with (rowlock) 
        (Spid,   
         ObjectID,  
         StateID,
         NewStateID,
         ActionID,
         OperDate,
         Message)
  select @@Spid, 
         o.OrderID, 
         o.StatusID, 
         1,--New
         18,--ToReNew
         cast(getdate() as date),
         'Перезаказан'
    from tOrders o with (nolock index=ao1) 
   where o.OrderID = @OrderID
  
  exec ProtocolAdd
 

  exit_:
  return @r

go
grant exec on CustomerReOrder to public
go
exec setOV 'CustomerReOrder', 'P', '20241122', '1'
go
 