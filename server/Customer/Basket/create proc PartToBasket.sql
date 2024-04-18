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

  Update t
     set t.Quantity =   t.Quantity + 1 
	    ,t.Amount   =  (t.Quantity + 1) * t.PriceRub
    from pFindByNumber p (nolock)
   inner join tBasket t (updlock)
	       on t.ClientID  = @ClientID
          and t.Make      = p.Make
	      and t.DetailNum = p.DetailNum
	      and t.PriceLogo = p.PriceLogo
   where p.Spid = @@Spid
     and p.ID   = @PartID

  insert tBasket 
        (ClientID
        ,Make
        ,MakeName
        ,DetailNum
        ,PartNameRus
        --,PartNameEng
        ,PriceLogo
		,OurDelivery
        ,GuaranteedDay
        ,Quantity
        ,Price
        ,PriceRub
        ,Amount
     --  ,Reference
        ,WeightKG
        ,VolumeKG
        ,DestinationLogo
        ,Margin
        ,Discount
        )
  select @ClientID
        ,p.Make
		,p.MakeName
		,p.DetailNum
		,p.PartNameRus
		,p.PriceLogo
		,p.OurDelivery
		,p.GuaranteedDay
        ,1--Quantity
		,p.Price
		,p.PriceRub
		,p.PriceRub
        ,p.WeightGr
        ,p.VolumeAdd
        ,p.DestinationLogo
        ,p.Margin
        ,p.Discount
    from pFindByNumber p (nolock)
   where p.Spid = @@Spid
     and p.ID   = @PartID
	 and not exists (select 1
	                   from tBasket t (nolock)
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
exec setOV 'PartToBasket', 'P', '20240404', '3'
go