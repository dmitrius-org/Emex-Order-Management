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
        ,t.Amount          = p.PriceRub * t.Quantity
        ,t.ReplacementPrice = null
        ,t.PricePurchase    = p.Price
        ,t.AmountPurchase   = p.Price
        ,t.AmountPurchaseF  = null
        ,t.MakeLogo        = p.Make
        ,t.PriceLogo       = p.PriceLogo
        ,t.isCancel        = 0
        ,t.Flag            = t.Flag & ~ 4 | 8192 /*Перезаказан*/
        --,t.StatusID        = 1	--New
        ,t.OrderDate       = cast(getdate() as date)
 -- OUTPUT INSERTED. INTO @PriceID(PriceID)  
	from tOrders t with (updlock index=ao1)
   inner join pFindByNumber p with (nolock index=ao3)
           on p.Spid = @@spid
          and p.Make      = @MakeLogo
          and p.DetailNum = t.DetailNumber
          and p.PriceLogo = @PriceLogo
          
   where t.OrderID = @OrderID

--   select * from tNodes

--select OrderDate from tOrders
 -- update p
 --    set p.DetailNameF	   = nullif(@DetailNameF, '')
 --       ,p.WeightKGF	   = case 
 --                              when isnull(@WeightKGF, 0) = 0 and p.WeightKG>0 then p.WeightKG
 --                              else @WeightKGF
 --                            end  
 --       ,p.VolumeKGF	   = case 
 --                              when isnull(@VolumeKGF, 0) = 0 and p.VolumeKG>0 then p.VolumeKG
 --                              else @VolumeKGF
 --                            end  
 --       ,p.Restrictions    = case
 --                              when @NoAir = 1 then 'NOAIR'
 --                              else null
 --                            end
 --        ,Fragile          = nullif(@Fragile, 0)
         
 --  OUTPUT INSERTED.PriceID INTO @PriceID(PriceID)  
	--from tOrders t (nolock)
 --  inner join tPrice p (updlock)
 --          on p.DetailNum = t.DetailNumber
	--	  and p.MakeLogo  = t.MakeLogo -- производитель
 --  where t.OrderID       = @OrderID

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
exec setOV 'CustomerReOrder', 'P', '20241119', '1'
go
 