drop proc if exists OrderCreateFromBasket
/*
  OrderCreateFromBasket - создание заказа на основе корзины
*/
go

create proc OrderCreateFromBasket   
              @OrderNum varchar(32) = null out
as
declare @r int = 0
       ,@StatusID       numeric(18,0)  -- Ид начального состояния 
       ,@ClientID       numeric(18, 0)
       ,@ClientOrderNum int -- сквозной номер заказа клиента

  select @StatusID = NodeID
    from tNodes with (nolock index=ao2)
   where Brief = 'New' --'Preparation'

  if isnull(@StatusID, 0) = 0
  begin
    set @r = 530 -- '[OrderCreateFromBasket] Не определен идентификатор начального состояния!'
    goto exit_
  end    

  select @ClientID = max(b.ClientID)
    from tMarks m with (nolock index=pk_tMarks)
   inner join tBasket b with (nolock index=PK_tBasket_BasketID)
           on b.BasketID = m.ID
   where m.spid = @@spid   
     and m.Type = 6--Корзина

  if isnull(@ClientID, 0) = 0
  begin
    set @r = 527 -- 'Не выбраны позиции для заказа!'
    goto exit_
  end

  if exists (Select 1
               from tClients with (nolock index=PK_tClients_ClientID)
              where ClientID = @ClientID
                and isnull(SuppliersID, 0) = 0)
  begin
    set @r = 533-- '[OrderCreateFromBasket] Не определен поставщик, обратитесь к администратору системы!'
    goto exit_
  end

  -- формирование номера заказа 
  if isnull(@OrderNum, '') = ''
      exec OrderNum
             @ClientID = @ClientID
            ,@OrderNum = @OrderNum out

  if exists (Select 1
               from tOrders with (nolock index=ao2)
              where ClientID = @ClientID
                and OrderNum = @OrderNum)
  begin
    set @r = 528 -- 'Заказ с заданным номером существует!'
    goto exit_
  end
  
  select @ClientOrderNum = max(ClientOrderNum)
    from tOrders with (nolock index=ao2)
   where ClientID = @ClientID  

  if OBJECT_ID('tempdb..#Price') is not null
    drop table #Price
  CREATE TABLE #Price
  (
          BasketID  numeric(18, 0) 
         ,PartID    numeric(18, 0)
         ,PriceID   numeric(18, 0)
         ,Brand     varchar(30)
         ,DetailNum varchar(128)
         ,PriceLogo varchar(30)
         ,PartNameRus varchar(256)
         ,WeightKG  float
         ,VolumeKG  float
  );

  insert #Price
        (BasketID,
         PartID,
         PriceID,
         Brand, 
         DetailNum, 
         PriceLogo,
         PartNameRus,
         WeightKG,
         VolumeKG
        )
  select b.BasketID,
         p.PartID,
         pp.PriceID,
         b.Make,
         b.DetailNum,
         b.PriceLogo,
         b.PartNameRus, --DetailName
         b.WeightKG,
         case
           when b.VolumeKG = 0 then b.WeightKG
           else b.VolumeKG
         end 
    from tMarks m with (nolock index=pk_tMarks)
   inner join tBasket b with (nolock index=PK_tBasket_BasketID)
           on b.BasketID = m.ID
    left join vParts p
           on p.Brand     = b.Make           
          and p.DetailNum = b.DetailNum 

    left join tPrice pp  (Nolock) 
           on pp.PartID    = p.PartID      
          and pp.PriceLogo = b.PriceLogo 

   where m.spid = @@spid   
     and m.Type = 6 -- Корзина
  
  exec PriceInsert


  declare @ID as table (OrderID numeric(18, 0), ID numeric(18, 0), OrderNum	varchar(32))
  insert tOrders with (rowlock)
        (ClientID
        ,SuppliersID 
        ,Manufacturer
        ,DetailNumber
        ,Quantity
        ,QuantityOrg
        ,Price
        ,Amount
        ,PricePurchaseOrg
        ,PricePurchase
        ,AmountPurchase
        ,OrderNum
        ,OrderDate
        ,CustomerPriceLogo 
        ,PriceLogo
        ,PriceLogoOrg
        ,ProfilesDeliveryID
        ,isCancel
        ,MakeLogo
        ,DetailName 
        ,Reference
        ,Flag
        
        ,WeightKG
        ,VolumeKG
        ,DestinationLogo
        ,DestinationName
        ,ProfilesCustomerID
        ,PercentSupped
        ,Margin
        ,Discount
        ,Kurs
        ,ExtraKurs
        ,Commission
        ,Reliability
        ,Fragile
        ,ClientOrderNum
        ,DeliveryTerm           -- Срок поставки поставщику
        ,DetailID
        ,CustomerSubId
        ,PriceID  
        ,ID
        ,WeightKGAmount
        ,VolumeKGAmount
         -- cроки поставки клиента
        ,DeliveryTermToCustomer -- Срок поставки клиенту
        ,DeliveryDateToCustomer -- Дата поставки клиенту    
        ,DeliveryRestToCustomer -- Остаток срока до поставки клиенту
        ,DaysInWork
        ,Comment2
        ,ItemKey
        ,DeliveryTermFromSupplier
        )
  output inserted.OrderID, inserted.ID, inserted.OrderNum into @ID (OrderID, ID, OrderNum)
  select b.ClientID
        ,c.SuppliersID
        ,b.MakeName              -- Manufacturer
        ,b.DetailNum
        ,b.Quantity
        ,b.Quantity
        ,b.PriceRub
        ,b.Amount
        ,b.Price                 -- PricePurchaseOrg
        ,b.Price                 -- (b.Price * (b.Discount / 100))-- Цена закупки с учетом скидки     PricePurchase
        ,b.Quantity * b.Price    -- (b.Price * (b.Discount / 100)))-- Цена закупки с учетом скидки     AmountPurchase
        ,@OrderNum               -- OrderNum
        ,cast(getdate() as date) -- OrderDate
        ,b.PriceLogo             -- CustomerPriceLogo
        ,b.PriceLogo             -- PriceLogo
        ,b.PriceLogo             -- PriceLogoOrg
        ,pd.ProfilesDeliveryID  -- Обязательно нужно заполнять, на основе поля считаем: срок доставки, финасовые показатели OrdersFinCalc
        ,0                       -- isCancel             
        ,b.Make                  -- Бренд
        ,b.PartNameRus           -- наименование детали
        ,@OrderNum               -- Reference
        ,16                      -- on-line заказ
         | (isnull(b.flag, 0)&512)     --Вес изменен клиентом
         | (isnull(b.flag, 0)&4194304) --NOAIR
        ,b.WeightKG              -- Вес Физический из прайса    
        ,case
           when b.VolumeKG = 0 then b.WeightKG
           else b.VolumeKG
         end                     -- Вес Объемный из прайса
        ,pd.DestinationLogo
        ,pd.DestinationName      -- 
        ,b.ProfilesCustomerID
        ,b.PercentSupped         -- процент поставки
         --
        ,b.Margin                -- Наценка из прайса
        ,b.Discount              -- Скидка  
        ,b.Kurs
        ,b.ExtraKurs
        ,b.Commission
        ,b.Reliability
        ,b.Fragile
         --
        ,ROW_NUMBER() Over(Partition by b.ClientID order by b.ClientID ) + isnull(@ClientOrderNum, 0) -- ClientOrderNum
        ,b.GuaranteedDay         -- DeliveryTerm           -- Срок поставки поставщику
        ,b.BasketID              -- DetailID 
        ,b.BasketID              -- CustomerSubId
        ,p.PriceID               -- tPrice.PriceID
        ,b.BasketID              -- ID
        ,pd.WeightKG             
        ,pd.VolumeKG          
         -- cроки поставки клиента
        ,b.OurDelivery           -- Срок поставки клиенту
        ,cast( dateadd(dd, b.OurDelivery, getdate()) as date )-- Дата поставки клиенту    
        ,b.OurDelivery           -- Остаток срока до поставки клиенту
        ,0
        ,b.Comment2
        ,b.ItemKey
        ,pd.DeliveryTermFromSupplier -- срок поставки от поставщика
    from tMarks m with (nolock index=pk_tMarks)
   inner join tBasket b with (nolock index=PK_tBasket_BasketID)
           on b.BasketID = m.ID
   inner join tClients c with (nolock index=PK_tClients_ClientID)
           on c.ClientID = b.ClientID 
   inner join tSuppliers s with (nolock index=ao1)
           on S.SuppliersID = c.SuppliersID

   outer apply ( -- для клиентов работающих через файл, профилей может быть несколько
         select top 1
                cp.*
           from vClientProfilesParam cp
          where cp.ProfilesCustomerID = b.ProfilesCustomerID
       ) as pd
   inner join #Price p (nolock)
           on p.BasketID = b.BasketID
   where m.spid = @@spid   
     and m.Type = 6--Корзина

  -- Протокол
  declare @ToNew numeric(18, 0)
  select @ToNew = NodeID
    from tNodes (nolock)
   Where Brief = 'ToNew'

  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid
  insert into pAccrualAction with (rowlock)
        (Spid,
         ObjectID,
         ActionID,
         StateID,
         NewStateID,
         Flag,
         sgn -- признак для понимания где сделали insert
         )
  Select @@Spid,
         i.OrderID ,
         isnull(@ToNew, 0),
         @StatusID, -- текущее состояние
         @StatusID,
         1,
         8
    from @ID i

  exec ProtocolAdd

  -- удаляем записи из корзины после создания заказа
  delete b  
    from @ID i
   inner join tBasket b (rowlock)
           on b.BasketID = i.ID

  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
  insert pOrdersFinIn with (rowlock)
        (Spid, OrderID)
  Select @@spid, OrderID
    from @ID
  
  exec OrdersFinCalc @IsSave = 1

  -- расчет сроков дотавки
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm  with (rowlock)
        (Spid, OrderID)
  Select @@spid, OrderID
    from @ID
  
  exec OrdersSupplierDeliveryCalc @IsSave = 1

  /*Расчет сроков доставки при создании заказа: 
     - Ближайшая дата вылета DeliveryNextDate
     - Дней запаса до вылета*/
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm  with (rowlock)
        (Spid, OrderID)
  Select @@spid, OrderID
    from @ID
  
  exec OrdersDeliveryTermCalc @IsSave = 1

  /*Расчет сроков доставки при создании заказа: 
     - Крайняя дата отгрузки со склада в ОАЭ
     - Дней до крайней даты отгрузки со склада в ОАЭ*/
  delete pDeliveryTerm from pDeliveryTerm with (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock)
        (Spid, OrderID)
  Select @@spid, OrderID
    from @ID

  exec OrdersLastDateShipmentCalc @IsSave = 1

  --declare @Orders as ID
  --insert @Orders (ID)
  --Select i.OrderID
  --  from @ID i

  --! расчет статистики по заказам
  --EXEC PartsStatisticsCalc @Orders = @Orders; -- считаем в ProtocolAdd

  exit_:

  return @r
GO
grant exec on OrderCreateFromBasket to public
go
exec setOV 'OrderCreateFromBasket', 'P', '20250531', '29'
go
 