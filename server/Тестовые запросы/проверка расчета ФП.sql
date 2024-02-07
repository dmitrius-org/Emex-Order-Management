

delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
--delete pOrdersFinTotal from pOrdersFinTotal where spid = @@Spid

insert pOrdersFinIn
      (Spid
      ,OrderID
      )
Select @@spid
      ,o.OrderID
  from tOrders o (nolock)
 where o.OrderID=8451

exec OrdersFinCalc
 



select 't.Orders',
       
	   Price          '�������'
	  ,CourseExt      '���� � ���������'
	  ,Purchase       '������� c ���������' --	�������� fkg � ���������	�������� vkg � ���������	��������	�������������	�������� �� �������	�������	��������������	����� %	����� P
	  ,Deliveryfkg    '�������� fkg � ���������' 
	  ,Deliveryvkg    '�������� vkg � ���������'
      ,Delivery       '�������� �����'
      ,CostPrice      '�������������'
      ,PriceCommission        '�������� �� �������'


      ,MarginF       '�������' 
      ,Profit        '��������������*'
      ,IncomePrc     '����� %' 
      ,Income        '����� �' 
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.Orders'
      ,Price               '�������'
      ,WeightKG            'WeightKG'
      ,WeightKGF           'WeightKGF'   
      ,VolumeKG            'VolumeKG'
	  ,VolumeKGF            'VolumeKGF'
      ,PricePurchase       'PricePurchase'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.ProfilesCustomer'
      ,Margin     * 100 as 'Margin'
      ,Commission * 100 as 'Comission' 
      ,ExtraKurs  * 100 as 'ExtraKurs'
  from pOrdersFin (nolock)
 where Spid = @@Spid
 
select 't.ProfilesDelivery'
      ,PdWeightKG          '��������� PdWeightKG'
      ,PdVolumeKG          '��������� PdVolumeKG'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.Clients'
      ,Taxes      * 100 as 'Taxes'
      ,'%'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.CurrencyRate', Course     as '����'
  from pOrdersFin (nolock)
 where Spid = @@Spid

