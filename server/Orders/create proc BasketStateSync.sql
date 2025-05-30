if OBJECT_ID('BasketStateSync') is not null
    drop proc BasketStateSync
/*
  BasketStateSync - синхронизация данных после добавления детали в корзину


  -- 20.10.2023 - добавлен расчет финансовых показателей
*/
go
create proc BasketStateSync
as
 declare @r int = 0
 declare @CoeffMaxAgree money

 Update p
    set p.OrderID = o.OrderID
	   ,p.ClientID= isnull(p.ClientID, o.ClientID)
   from pBasketDetails p (updlock)
  inner join tOrders o (nolock) 
          on o.BasketId = p.BasketId   
 where p.Spid   = @@SPID

 Update p
    set p.OrderID = o.OrderID
	   ,p.ClientID= isnull(p.ClientID, o.ClientID)
   from pBasketDetails p (updlock) 
  cross apply (select top 1 *
                 from tOrders o (nolock) 
                where o.DetailNumber  = p.DetailNum
                  and o.CustomerSubId = p.CustomerSubId 
                  and o.Reference     = p.Reference 
                 
                 order by /*case 
				            when o.CustomerSubId = p.CustomerSubId 
							  then 1
                              else 2
						  end*/
                          case 
				            when o.MakeLogo = p.MakeLogo 
							  then 1
                              else 2
						  end
						 ,case 
				            when o.PriceLogo = p.PriceLogo
							  then 1
                              else 2
						  end
						 ,case 
				            when o.Quantity = p.Quantity
							  then 1
                              else 2
						  end

						 ,case 
				            when isnull(o.BasketId, '') = ''
							  then 1
                              else 2
						  end

               ) o   
 where p.Spid               = @@SPID
   and isnull(p.OrderID, 0) = 0
 
 select @CoeffMaxAgree = convert(money, isnull(s.Val, 0))
   from tSettings s (nolock)
  where s.Brief = 'CoeffMaxAgree' 

 Update o
    set o.BasketId        = p.BasketId
   from pBasketDetails p (nolock)        
  inner join tOrders o (Updlock) 
          on o.OrderID = p.OrderID     
 where p.Spid   = @@SPID

 Update o
    set o.PricePurchaseF  = p.Price
	   ,o.AmountPurchaseF = round(p.Price * p.Quantity, 2)
	   ,o.EmexQuantity    = p.Quantity
	   ,o.OverPricing     = case 
	                          when p.Price >  p.UploadedPrice
							  then p.Price / p.UploadedPrice * 100 - 100
							  else 0
                            end 
        ,o.Warning         = case
                              when isnull(p.WarnText, '') <> '' then p.WarnText	
                              else '' --o.Warning  
                             end                 
   from pBasketDetails p (nolock)        
  inner join tOrders o (Updlock) 
          on o.OrderID = p.OrderID     
 where p.Spid   = @@SPID
  

 Update o
    set o.flag = isnull(o.Flag, 0)
                        & ~1      -- превышение цены
                        & ~2      -- нет цены
                        & ~16384  -- Несоответствие упаковке
                        & ~32768  -- Нет в наличии
                        & ~262144 -- Измените метод отправки     
                        
                        | iif(p.WarnCode = -1, 1     , 0)  -- превышение цены
                        | iif(p.WarnCode = -2, 2     , 0)  -- нет цены
                        | iif(p.WarnCode = -4, 16384 , 0)  -- Несоответствие упаковке
                        | iif(p.WarnCode = -5, 32768 , 0)  -- Нет в наличии
                        | iif(p.WarnCode = 99, 262144, 0)  -- Измените метод отправки
       ,o.updDatetime = GetDate()
   from pBasketDetails p (nolock)        
  inner join tOrders o (Updlock) 
          on o.OrderID = p.OrderID     
 where p.Spid = @@SPID


Update p 
   set p.Retval = 517-- 'Неизвестная ошибка, деталь не добавлена в корзину!'
  from pAccrualAction p (Updlock)
 where p.Spid     = @@spid
   and not exists ( select 1 
                      from pBasketDetails bd (nolock)  
                     where bd.Spid = @@SPID 
					   and bd.OrderID = p.ObjectID)


-- расчет финнасовых показателей
delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
insert pOrdersFinIn
      (Spid
      ,OrderID
      )
Select @@spid
      ,OrderID
  from pBasketDetails p (nolock)         
 where p.Spid    = @@SPID
   and p.OrderID > 0
   and p.UploadedPrice <> p.Price

exec OrdersFinCalc @IsSave = 1
  

 exit_:
 return @r
go
grant exec on BasketStateSync to public
go
exec setOV 'BasketStateSync', 'P', '20250319', '5'
go
 