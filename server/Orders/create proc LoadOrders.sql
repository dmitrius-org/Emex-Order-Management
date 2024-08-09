if OBJECT_ID('LoadOrders') is not null
    drop proc LoadOrders
/*
  LoadOrders - загрузка заказов из файла


  pOrders - входящий набор данных

  -- 20.10.2023 - добавлен расчет финансовых показателей
*/
go

Create proc [LoadOrders]
           
as
  set nocount on;
  declare @r int = 0
         ,@ObjectTypeID numeric(18,0)  -- ид объекта системы для которого используется модель
         ,@StatusID     numeric(18,0)  -- Ид начального состояния 
         ,@Brief	    nvarchar(128)  -- Сокращение состояния 
         ,@Name   	    nvarchar(256)  -- Наименование состояния

  Select @ObjectTypeID = ObjectTypeID
    from tObjectType (nolock)
   where Brief = 'Заказы'

  if isnull(@ObjectTypeID, 0) = 0
  begin
    set @r =310 -- '[LoadOrders] Не определен идентификатор объекта системы для которго настроена модель состояния!'
	goto exit_
  end

  exec GetStartNode
         @ObjectTypeID = @ObjectTypeID
		,@StatusID     = @StatusID out
		 
  if isnull(@StatusID, 0) = 0
  begin
    set @r = 320-- '[LoadOrders] Не определен идентификатор начального состояния!'
	goto exit_
  end	

  declare @ID as ID

  insert tOrders
        (ClientID
        ,SuppliersID
        ,Manufacturer
        ,DetailNumber
        ,Quantity
        ,DetailID
        ,Price
        ,Amount
        ,OrderNum
        ,OrderDate
        ,CustomerPriceLogo 
        ,PriceLogo
        ,ProfilesDeliveryID

        ,isCancel
		,PriceID
		,MakeLogo
		,DetailName
        ,FileDate    
        
        ,Margin
		,Discount
        ,Reliability
        ,Commission
        ,ExtraKurs
        ,Fragile
        --,Kurs
        ,Taxes
        ,WeightKGAmount     -- Стоимость кг физического веса
        ,VolumeKGAmount   
        ,DestinationLogo
        )
  output inserted.OrderID into @ID (ID)
  select o.ClientID
        ,c.SuppliersID
        ,o.Manufacturer
        ,o.DetailNumber
        ,o.Quantity
        ,o.DetailID
        ,o.Price
        ,o.Amount
        ,o.OrderNum
        ,cast(o.OrderDate as date)
        ,o.PriceNum             -- CustomerPriceLogo
        ,pc.UploadPriceName     -- PriceLogo
        ,pc.ProfilesDeliveryID  --

        ,0                      -- isCancel
		,p.PriceID              -- 
		,p.MakeLogo				-- Код бренда
		,coalesce(pd.Name_RUS, o.DetailName) -- наименование детали
        ,o.FileDate  

        ,pc.Margin              -- Наценка из прайса
		,pc.Discount            -- Скидка
        ,pc.Reliability
        ,pc.Commission
        ,pc.ExtraKurs
        ,pc.Fragile
        ,c.Taxes
        ,pc.WeightKG   -- Стоимость кг физического веса
        ,pc.VolumeKG 
        ,pc.DestinationLogo
    from pOrders o (nolock)
   inner join tClients c (nolock)
           on c.ClientID = o.ClientID
   -- - - -
   outer apply (select top 1 
                       pc.UploadPriceName,
                       pc.ProfilesDeliveryID,
                       pc.Margin,
					   s.Discount,
                       pc.Reliability,
                       s.Commission,
                       s.ExtraKurs,
                       pd.DestinationLogo,
                       pd.WeightKG,   -- Стоимость кг физического веса
                       pd.VolumeKG,
                       pd.Fragile
                  from tProfilesCustomer pc with (nolock index=ao2)
                 inner join tSupplierDeliveryProfiles pd with (nolock index=ao2)
                         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
                 inner join tSuppliers s with (nolock index=ao1)
                         on s.SuppliersID = pd.SuppliersID 
                 where pc.ClientID        = c.ClientID
                   and pc.ClientPriceLogo = o.PriceNum -- CustomerPriceLogo
                 order by pc.ProfilesCustomerID) pc
   -- - - -
   outer apply (select top 1 *
                  from tPrice p with (nolock index=ao2) 
                 where p.DetailNum= o.DetailNumber
                 order by case
				            when p.Brand = o.Manufacturer then 0
							else 1
				          end
                         ,case
				            when p.PriceLogo= pc.UploadPriceName then 0
							else 1
                          end
						 ,p.DetailPrice 
			    ) p
  -- - - -
  left join tPartDescription pd with (nolock index=ao2)     
         on pd.Make   = p.MakeLogo	
        and pd.Number = p.DetailNum 

   where o.Spid = @@Spid
     and not exists (select 1 -- проверка на повторную загрузку
                       from tOrders t with (nolock index=ao2)
                      where t.ClientID          = o.ClientID
                        and t.CustomerPriceLogo = o.PriceNum
                        and t.OrderNum          = o.OrderNum
                        )

  Update o
     set o.PricePurchase    = round(p.DetailPrice - (p.DetailPrice * (o.Discount / 100)), 2)-- Цена закупки с учетом скидки	
	    ,o.PricePurchaseOrg = round(p.DetailPrice, 2) 
        ,o.WeightKG         = p.WeightKG -- Вес Физический из прайса	
        ,o.VolumeKG         = p.VolumeKG -- Вес Объемный из прайса	
    from @ID i
   inner join tOrders o with (updlock)
           on o.OrderID = i.ID
   inner join tPrice p (nolock) 
           on p.PriceID = o.PriceID
                        
  Update o
     set o.AmountPurchase  = o.PricePurchase * o.Quantity  -- Сумма закупки	   
    from @ID i
   inner join tOrders o with (updlock)
           on o.OrderID = i.ID

  --! Протокол
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
		 NewStateID,
		 sgn)
  Select @@Spid,
         i.ID ,
		 isnull(@ToNew, 0),
		 0, -- текущее состояние
		 @StatusID,
		 6
    from @ID i

  exec ProtocolAdd

  --! проставляем поля Reference и CustomerSubID
  exec OrdersReferenceCalc

  --! расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn (rowlock) where spid = @@Spid
  insert pOrdersFinIn (Spid, OrderID)
  Select @@spid, ID
    from @ID
  
  exec OrdersFinCalc @IsSave = 1
  
  --! расчет сроков дотавки
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm (Spid, OrderID)
  Select @@spid, ID
    from @ID
  
  exec OrdersDeliveryTermCalc @IsSave = 1

  --! Автоматический перевод в Проверено при загрузке заказа
  if OBJECT_ID('tempdb..#Order') is not null drop table #Order
  CREATE TABLE #Order ( OrderID  numeric(18,0) );

  insert #Order (OrderID) Select ID from @ID

  exec OrderAutoSetStatus

  --! расчет статистики по заказам
  EXEC PartsStatisticsCalc @Orders = @ID;

exit_:

return @r
go
grant exec on LoadOrders to public
go
exec setOV 'LoadOrders', 'P', '20240809', '3'
go
 