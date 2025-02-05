drop proc if exists CustomerReOrder
/*
  CustomerReOrder - перезаказываем отказанную позицию


*/
go
create proc CustomerReOrder
               @OrderID         numeric(18,0)                            
              ,@PriceLogo       nvarchar(64)  
              ,@MakeLogo        nvarchar(64)
              ,@DestinationLogo    nvarchar(20)
              
as
  declare @r             int = 0

  declare @P table 
         (PriceID   numeric(18, 0));
  insert into tPrice with (rowlock) -- если детали нет в нашей системе, то добавим его
        (     
         MakeLogo 
        ,Brand    
        ,DetailNum      
        ,DetailName      
        ,DetailNameF
        ,PriceLogo    
        ,WeightKG     
        ,VolumeKG 
        ,WeightKGF    
        ,VolumeKGf
        ,Fragile
        ,Restrictions
         ) 
  OUTPUT INSERTED.PriceID INTO @P(PriceID)
  select distinct 
         pr2.MakeLogo
        ,pr2.Brand
        ,pr2.DetailNum     
        ,pr2.DetailName --DetailName
        ,pr2.DetailNameF
        ,@PriceLogo
        ,pr2.WeightKG
        ,case
           when pr2.VolumeKG = 0 then pr2.WeightKG
           else pr2.VolumeKG
         end 
        ,pr2.WeightKG
        ,pr2.VolumeKG
        ,pr2.Fragile
        ,pr2.Restrictions
    from tOrders t with (nolock index=ao1)
   inner join tPrice pr2 with (nolock index=ao3)
           on pr2.PriceLogo  = t.PriceLogo
          and pr2.DetailNum  = t.DetailNumber
          and pr2.MakeLogo   = t.MakeLogo 
  --cross apply ( select top 1 *
  --                 from pFindByNumber p with (nolock index=ao3)
  --                where p.Spid = @@spid
  --                  and p.Make      = @MakeLogo
  --                  and p.DetailNum = t.DetailNumber
  --                  and p.PriceLogo = @PriceLogo
  --              ) as p
    left join tPrice pr with (nolock index=ao3)
           on pr.PriceLogo  = @PriceLogo
          and pr.DetailNum  = t.DetailNumber
          and pr.MakeLogo   = @MakeLogo 

   where t.OrderID = @OrderID
     and pr.PriceID is null

  update t
     set t.Price                  = p.PriceRub
        ,t.Amount                 = p.PriceRub * t.Quantity
        ,t.PricePurchase          = p.Price
        ,t.PricePurchaseOrg       = p.Price
        ,t.AmountPurchase         = p.Price * t.Quantity
        ,t.AmountPurchaseF        = null
        ,t.PricePurchaseF         = null
        ,t.MakeLogo               = p.Make
        ,t.PriceLogo              = p.PriceLogo
        ,t.CustomerPriceLogo      = p.PriceLogo
        ,t.PriceLogoOrg           = p.PriceLogo
        ,t.isCancel               = 0
        ,t.Flag                   = (isnull(t.Flag, 0) & ~4) 
                                                     | 8192 /*Перезаказан*/
        ,t.OrderDate              = cast(getdate() as date)
        ,t.BasketId               = null
        ,t.EmexOrderID            = null
        ,t.OrderDetailSubId       = null
        ,t.Comment                = null
        ,t.DestinationLogo        = @DestinationLogo
        ,t.DestinationName        = pd.Name
        ,t.ProfilesDeliveryID     = pc.ProfilesDeliveryID
        ,t.WeightKGAmount         = pd.WeightKG  
        ,t.VolumeKGAmount         = pd.VolumeKG 
         -- cроки поставки клиента
        ,t.DeliveryTermToCustomer = p.OurDelivery -- Срок поставки клиенту
        ,t.DeliveryDateToCustomer = cast( dateadd(dd, p.OurDelivery, getdate()) as date )-- Дата поставки клиенту    
        ,t.DeliveryRestToCustomer = p.OurDelivery -- Остаток срока до поставки клиенту
        ,t.DaysInWork             = 0

         -- параметры расчета себестоимости
        ,t.PercentSupped          = p.PercentSupped 
        ,t.Margin                 = p.Margin
        ,t.Discount               = p.Discount
        ,t.Commission             = p.Commission
        ,t.Reliability            = p.Reliability
        ,t.CommissionAmount       = null

        ,t.Kurs                   = p.Kurs     
        ,t.ExtraKurs              = p.ExtraKurs

        ,t.DeliveredDateToSupplier = null
        ,t.DeliveryPlanDateSupplier= null
        ,t.DeliveryRestTermSupplier= p.GuaranteedDay
        ,t.DeliveryTerm            = p.GuaranteedDay -- Срок доставки поставщику

        ,t.DeliveryDaysReserve     = null
        ,t.DeliveryDaysReserve2    = null
        ,t.DeliveryNextDate        = null
        ,t.DeliveryNextDate2       = null

        ,t.ReplacementMakeLogo     = null
        ,t.ReplacementDetailNumber = null
        ,t.ReplacementPrice        = null
        ,t.PriceID                 = isnull(pp.PriceID, t.PriceID)
        ,t.ProcessingDate          = null
 -- OUTPUT INSERTED. INTO @PriceID(PriceID)  
    from tOrders t with (updlock index=ao1)
   cross apply ( select top 1 *
                   from pFindByNumber p with (nolock index=ao3)
                  where p.Spid = @@spid
                    and p.Make      = @MakeLogo
                    and p.DetailNum = t.DetailNumber
                    and p.PriceLogo = @PriceLogo
                ) as p

   inner join tClients c with (nolock index=PK_tClients_ClientID)
           on c.ClientID = t.ClientID 
   inner join tSuppliers s with (nolock index=ao1)
           on S.SuppliersID = c.SuppliersID
   inner join tSupplierDeliveryProfiles pd with (nolock index=ao1)
           on pd.SuppliersID     = s.SuppliersID
          and pd.DestinationLogo = @DestinationLogo  
   inner join tProfilesCustomer pc with (nolock index=ao2)
           on pc.ClientID           = c.ClientID
          and pc.ProfilesDeliveryID = pd.ProfilesDeliveryID
   left join @P pp
          on 1=1 
   where t.OrderID = @OrderID


  delete from tOrdersDeliverySupplier with (rowlock) where OrderID = @OrderID

  delete pAccrualAction from pAccrualAction with (rowlock index=ao1) where spid = @@spid
  insert pAccrualAction with (rowlock) 
        (Spid,   
         ObjectID,  
         StateID,
         NewStateID,
         ActionID,
         OperDate,
         Message,
         Flag,
         sgn -- признак для понимания где сделали insert
         )
  select @@Spid, 
         o.OrderID, 
         o.StatusID, 
         1,--New
         18,--ToReNew
         getdate(),
         'Перезаказано клиентом',
         1,
         9
    from tOrders o with (nolock index=ao1) 
   where o.OrderID = @OrderID
  
  exec ProtocolAdd

  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
  insert pOrdersFinIn with (rowlock)
        (Spid, OrderID)
  Select @@spid, @OrderID
  
  exec OrdersFinCalc @IsSave = 1

  -- расчет сроков дотавки
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm  with (rowlock)
        (Spid, OrderID)
  Select @@spid, @OrderID
  
  exec OrdersSupplierDeliveryCalc @IsSave = 1

  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock)
        (Spid, OrderID) 
  Select @@spid, @OrderID
  
  exec OrdersDeliveryTermCalc @IsSave = 1
 

  exit_:
  return @r

go
grant exec on CustomerReOrder to public
go
exec setOV 'CustomerReOrder', 'P', '20250204', '6'
go
 