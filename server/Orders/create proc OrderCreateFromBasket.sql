drop proc if exists OrderCreateFromBasket
/*
  OrderCreateFromBasket - создание заказа на основе корзины


  @ClientID  - ид клиента
  @PartID    - ид детали с формы поиска детали
*/
go

create proc OrderCreateFromBasket          
as
declare @r int = 0
       ,@StatusID       numeric(18,0)  -- Ид начального состояния 
       ,@ClientID       numeric(18, 0)
       ,@OrderNum       nvarchar(128) 
       ,@ClientOrderNum int -- сквозной номер заказа клиента

  select @StatusID = NodeID
    from tNodes (nolock)
   where Brief = 'Preparation'

  if isnull(@StatusID, 0) = 0
  begin
    set @r = 530 -- '[OrderCreateFromBasket] Не определен идентификатор начального состояния!'
	goto exit_
  end	

  select @ClientID = max(b.ClientID)
    from tMarks m (nolock)
   inner join tBasket b (nolock)
           on b.BasketID = m.ID
   where m.spid = @@spid   
     and m.Type = 6--Корзина


  if isnull(@ClientID, 0) = 0
  begin
    set @r = 527 -- 'Не выбраны позиции для заказа!'
    goto exit_
  end

  if exists (Select 1
               from tClients (nolock)
              where ClientID = @ClientID
                and isnull(SuppliersID, 0) = 0)
  begin
    set @r = 533-- '[OrderCreateFromBasket] Не определен поставщик, обратитесь к администратору системы!'
    goto exit_
  end

  -- формирование номера заказа 
  exec OrderNum
         @ClientID = @ClientID
        ,@OrderNum = @OrderNum out

  if exists (Select 1
               from tOrders (nolock)
              where ClientID = @ClientID
                and OrderNum = @OrderNum)
  begin
    set @r = 528 -- 'Заказ с заданным номером существует!'
    goto exit_
  end
  
  select @ClientOrderNum = max(ClientOrderNum)
    from tOrders (nolock)
   where ClientID = @ClientID

  declare @ID as table (OrderID numeric(18, 0), ID numeric(18, 0))

  insert tOrders
        (ClientID
        ,Manufacturer
        ,DetailNumber
        ,Quantity
        ,Price
        ,Amount
        ,PricePurchaseOrg
        ,PricePurchase
        ,AmountPurchase
        ,OrderNum
        ,OrderDate
        ,CustomerPriceLogo 
        ,PriceLogo
        ,ProfilesDeliveryID
        ,isCancel
		,MakeLogo
		,DetailName 
        ,Reference
        ,Flag
        
        ,WeightKG
        ,VolumeKG
        ,DestinationLogo
        ,Margin
        ,Discount
        --
        ,ClientOrderNum

		,DetailID
		,CustomerSubId

        ,ID
        )
  output inserted.OrderID, inserted.ID into @ID (OrderID, ID)
  select b.ClientID
        ,b.MakeName--Manufacturer
        ,b.DetailNum
        ,b.Quantity
        ,b.PriceRub
        ,b.Amount
        ,b.Price --PricePurchaseOrg
        ,b.Price - (b.Price * (b.Discount / 100))-- Цена закупки с учетом скидки	 PricePurchase
        ,b.Price - (b.Price * (b.Discount / 100))-- Цена закупки с учетом скидки	 AmountPurchase
        ,@OrderNum               -- OrderNum
        ,cast(getdate() as date) -- OrderDate
        ,b.PriceLogo             -- CustomerPriceLogo
        ,b.PriceLogo             -- PriceLogo
        ,0--pc.ProfilesDeliveryID--
        ,0                       -- isCancel             
		,b.Make		             -- Бренд
		,b.PartNameRus           -- наименование детали
        ,@OrderNum               -- Reference
        ,16                      -- on-line заказ
        ,b.WeightKG -- Вес Физический из прайса	
        ,b.VolumeKG -- Вес Объемный из прайса
        ,b.DestinationLogo
        ,b.Margin  -- Наценка из прайса
        ,b.Discount-- Скидка  
        --
        ,ROW_NUMBER() Over(Partition by b.ClientID order by b.ClientID ) + isnull(@ClientOrderNum, 0) -- ClientOrderNum
        ,b.BasketID -- DetailID 
		,b.BasketID -- CustomerSubId

		,b.BasketID -- ID
    from tMarks m (nolock)
   inner join tBasket b (nolock)
           on b.BasketID = m.ID
   where m.spid = @@spid   
     and m.Type = 6--Корзина
   -- - - -

   --    Update o
   --  set o.PricePurchase    = round(p.DetailPrice - (p.DetailPrice * (o.Discount / 100)), 2)-- Цена закупки с учетом скидки	
	  --  ,o.PricePurchaseOrg = round(p.DetailPrice, 2) 
   --     ,o.WeightKG         = p.WeightKG -- Вес Физический из прайса	
   --     ,o.VolumeKG         = p.VolumeKG -- Вес Объемный из прайса	
   -- from @ID i
   --inner join tOrders o with (updlock)
   --        on o.OrderID = i.OrderID
   --inner join tPrice p (nolock) 
   --        on p.PriceID = o.PriceID

   --outer apply (select top 1 *
   --               from tPrice p (nolock) 
   --              where p.DetailNum= o.DetailNumber
   --              order by case
			--	            when p.Brand = o.Manufacturer then 0
			--				else 1
			--	          end
   --                      ,case
			--	            when p.PriceLogo= pc.UploadPriceName then 0
			--				else 1
   --                       end
			--			 ,p.DetailPrice 
			--    ) p

     --and not exists (select 1
     --                  from tOrders t (nolock)
     --                 where t.ClientID          = o.ClientID
     --                   and t.CustomerPriceLogo = o.PriceNum
     --                   and t.OrderNum          = o.OrderNum
     --                   )


  -- Протокол
  declare @ToNew numeric(18, 0)
  select @ToNew = NodeID
    from tNodes (nolock)
   Where Brief = 'ToNew'

  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid
  insert into pAccrualAction
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID)
  Select @@Spid,
         i.OrderID ,
		 isnull(@ToNew, 0),
		 @StatusID, -- текущее состояние
		 @StatusID
    from @ID i

  exec ProtocolAdd

  -- удаляем записи из корзины после создания заказа
  delete b  
    from @ID i
   inner join tBasket b (rowlock)
           on b.BasketID = i.ID

---- расчет финнасовых показателей
delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
insert pOrdersFinIn
      (Spid
      ,OrderID)
Select @@spid
      ,OrderID
  from @ID

exec OrdersFinCalc @IsSave = 1

  exit_:

  return @r
GO
grant exec on OrderCreateFromBasket to public
go
exec setOV 'OrderCreateFromBasket', 'P', '20240404', '3'
go
 