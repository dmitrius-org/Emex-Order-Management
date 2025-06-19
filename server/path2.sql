insert tSupplierPrices
(
SuppliersID
,Name
,Comment
,DeliveryTerm
,DeliveryType
,InWorkingDays
,ShowInSearch
,Flag
)

select 
 s.SuppliersID
,p.Name
,p.Comment
,p.DeliveryTerm
,p.DeliveryType
,p.InWorkingDays
,p.ShowInSearch
,p.Flag
from tSuppliers s
inner join tPrices p
        on 1=1



if OBJECT_ID('tPrices') is not null
  drop table tPrices


  insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1061, 1061, 'Редактирование суммы заказа',  'TOrderF.actAmountEnabled', 20, 1