drop proc if exists PartToBasket
/*
  PartToBasket - добавление детали в корзину


  @ClientID  - ид клиента
  @PartID    - ид детали с формы поиска детали
*/
go

Create proc PartToBasket
             @ClientID numeric(18, 0)
            ,@PartID   numeric(18, 0)
           
as
declare @r int = 0

  
  if exists (select 1 
               from tSettings with (nolock index=ao2)
              where Brief = 'CheckFillToCartName' --Контролировать заполнение наименования при добавлении в корзину
                and Val   = '1')
    if exists (select 1
                 from pFindByNumber p  with (nolock index=ao1)
                where p.Spid = @@Spid
                  and p.ID   = @PartID
                  and isnull(p.PartNameRus, '') = '')
    begin
      select @r = 702-- Поле "Описание" обязательно к заполению
      goto exit_
    end

  if exists (select 1 
               from tSettings with (nolock index=ao2)
              where Brief = 'CheckFillToCartWeight' --Контролировать заполнение веса при добавлении в корзин
                and Val   = '1')
    if exists (select 1
                 from pFindByNumber p  with (nolock index=ao1)
                where p.Spid = @@Spid
                  and p.ID   = @PartID
                  and isnull(p.WeightGr, 0) = 0)
    begin
      select @r = 703-- Поле "Вес" обязательно к заполению
      goto exit_
    end

  if exists (select 1 
               from tSettings with (nolock index=ao2)
              where Brief = 'CheckFillToCartVolume' --Контролировать заполнение объема при добавлении в корзину
                and Val   = '1')
    if exists (select 1
                 from pFindByNumber p with (nolock index=ao1)
                where p.Spid = @@Spid
                  and p.ID   = @PartID
                  and isnull(p.VolumeAdd, 0) = 0)
    begin
      select @r = 704 -- Поле "Объём" обязательно к заполению
      goto exit_
    end    

  Update t
     set t.Quantity =  (( (t.Quantity + 1) + p.Packing - 1) / p.Packing) * p.Packing
	    ,t.Amount   = ((( (t.Quantity + 1) + p.Packing - 1) / p.Packing) * p.Packing) * t.PriceRub
    from pFindByNumber p with (nolock index=ao1)
   inner join tBasket t with (updlock index=ao2)
	       on t.ClientID  = @ClientID
          and t.Make      = p.Make
	      and t.DetailNum = p.DetailNum
	      and t.PriceLogo = p.PriceLogo
   where p.Spid = @@Spid
     and p.ID   = @PartID

  insert tBasket with (rowlock) 
        (ClientID
        ,Make
        ,MakeName
        ,DetailNum
        ,PartNameRus
        --,PartNameEng
        ,PriceLogo
		,OurDelivery   -- срок поставки клиенту
        ,GuaranteedDay
        ,Quantity
        ,Price
        ,PriceRub
        ,Amount
     --  ,Reference
        ,WeightKG
        ,VolumeKG
        ,DestinationLogo
        ,PercentSupped
        
        ,Margin
        ,Discount
        ,Kurs
        ,ExtraKurs
        ,Commission
        ,Reliability
        ,Fragile
                          
        ,Flag   

        ,Packing
        )
  select @ClientID
        ,p.Make
		,p.MakeName
		,p.DetailNum
		,p.PartNameRus
		,p.PriceLogo
		,p.OurDelivery
		,p.GuaranteedDay
        ,((1 + p.Packing - 1) / p.Packing) * p.Packing -- Quantity
		,p.Price
		,p.PriceRub
		,((1 + p.Packing - 1) / p.Packing) * p.Packing  * p.PriceRub -- Amount
        ,p.WeightGr
        ,p.VolumeAdd
        ,p.DestinationLogo
        ,p.PercentSupped

        ,p.Margin
        ,p.Discount
        ,p.Kurs
        ,p.ExtraKurs
        ,p.Commission
        ,p.Reliability
        ,p.Fragile

        ,p.Flag

        ,p.Packing -- количество деталей в упаковке
    from pFindByNumber p with (nolock index=ao1)
   where p.Spid = @@Spid
     and p.ID   = @PartID
	 and not exists (select 1
	                   from tBasket t with (nolock index=PK_tBasket_BasketID)
					  where t.ClientID        = @ClientID
                        and t.Make            = p.Make
					    and t.DetailNum       = p.DetailNum
						and t.PriceLogo       = p.PriceLogo
                        and t.DestinationLogo = p.DestinationLogo)
                       
  exit_:

  return @r
GO
grant exec on PartToBasket to public
go
exec setOV 'PartToBasket', 'P', '20250217', '12'
go