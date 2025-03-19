if OBJECT_ID('ApiBasketContentSelect', 'P') is not null
    drop proc ApiBasketContentSelect	 
go
/* --------------------------------------------------------
  ApiBasketContentSelect - �������� ������ ������� � �������
-------------------------------------------------------- */
create proc ApiBasketContentSelect
               @ClientID     numeric(18, 0)
as
set nocount on;

declare @RetVal int  = 0

select
       t.BasketID         -- 
      ,t.ClientID         -- 
      ,t.Make             -- 
      ,t.MakeName         Brand-- 
      ,t.DetailNum        DetailNumber-- 
      ,t.PriceLogo + '-' + cast(t.ProfilesCustomerID as varchar) as SupplierCode
      ,t.ItemKey
      ,t.PartNameRus      DetailName-- 
      ,t.PriceRub         -- 
      ,t.OurDelivery      Delivery -- ��� ���� ��������, ���������� �������/���� ������� ������
	  ,t.Quantity         -- 
      ,t.Amount           -- 
      ,t.Packing          Packing-- ���������� ������� � ��������
      ,t.Comment2         Comment-- �����������     
      ,(case 
              when datediff(hh, t.InDateTime, getdate()) >= 24 then 0
              else 1
            end ) Status -- ������ 24 ����, ���������� �������� ����
      ,(case 
              when datediff(hh, t.InDateTime, getdate()) >= 24 then '������ 24 ����, ���������� �������� ����'
              else ''
            end ) ErrorMessage -- ������ 24 ����, ���������� �������� ����
      

  from tBasket t with (nolock index=ao2)
 Where t.ClientID = @ClientID
       
exit_:
return @RetVal    
go
grant exec on ApiBasketContentSelect to public
go
exec setOV 'ApiBasketContentSelect', 'P', '20240605', '0'
go
 

 --delivery
 --select
 --      *

 -- from tBasket t with (nolock index=ao2)
 --Where t.ClientID = 57