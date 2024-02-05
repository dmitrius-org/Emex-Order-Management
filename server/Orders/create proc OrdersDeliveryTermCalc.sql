drop proc if exists OrdersDeliveryTermCalc
/*
  OrdersDeliveryTermCalc - ������ 

  @IsSave - ��������� ������ � tOrders
            0 - ���
            1 - ��

  �������� ����� ������: pDeliveryTerm
  ��������� �������: pDeliveryTerm
*/
go
create proc OrdersDeliveryTermCalc
              @IsSave bit =  null           
as
set nocount on;
SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID           = o.ClientID
      ,p.OrderDate          = o.OrderDate
      ,p.PriceLogo          = o.PriceLogo
      ,p.DestinationLogo    = isnull(nullif(o.DestinationLogo, ''), pd.DestinationLogo) 
      ,p.ProfilesDeliveryID = o.ProfilesDeliveryID
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
 --inner join tClients c (nolock)
 --        on c.ClientID = o.ClientID
  --left join tProfilesCustomer pc (nolock)
  --       on pc.ClientPriceLogo = o.CustomerPriceLogo
  left join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
  --left join tPrice p (nolock)
  --       on p.PriceID = o.PriceID
 where p.Spid = @@Spid

-- select * from pDeliveryTerm
Update p   
   set p.DeliveryPlanDateSupplier  =  case 
                                        when t.DeliveryTerm < 5 -- � ������� �� ������ ������ 5 ���� ��������� �������� ��� �� ������� ���
                                        then dbo.AddDaysAndWeekends(p.OrderDate, t.DeliveryTerm, 1)
                                        else DATEADD(dd, t.DeliveryTerm, p.OrderDate)
                                      end
      ,p.DeliveryTerm = t.DeliveryTerm
  from pDeliveryTerm p (nolock)
 inner join tPrices t (nolock)
         on t.Name = p.PriceLogo
 where p.Spid = @@Spid

update p
   set p.DeliveryNextDate =  case 
                               when DATEPART(dw, p.DeliveryPlanDateSupplier) < (pd.DenVyleta) 
                                 -- �������� �� ���� ������
                                 then  DATEADD(dd, pd.DenVyleta - DATEPART(dw, p.DeliveryPlanDateSupplier), p.DeliveryPlanDateSupplier)

                                 else (select DATEADD(DAY, pd.DenVyleta - DATEPART(WEEKDAY, p.wkNextDate), p.wkNextDate)  -- ������ ������
                                        from (select DATEADD(wk, 1, p.DeliveryPlanDateSupplier) as wkNextDate) as p
                                      )
                             end
  from pDeliveryTerm p (nolock)
 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = p.ProfilesDeliveryID
 where p.Spid = @@spid


if @IsSave = 1
    update o
       set o.DeliveryPlanDateSupplier = p.DeliveryPlanDateSupplier
          ,o.DeliveryNextDate         = p.DeliveryNextDate
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid


 exit_:

-- select * from pDeliveryTerm where spid = @@spid


 
 return @r
go
  grant exec on OrdersDeliveryTermCalc to public
go
 