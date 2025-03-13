alter table tBasket add ItemKey                 varchar(256)


insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 102, 102, 'Исключения',                  'TExceptionsT',            0,   80, '22' 


insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1037, 1037, 'Добавить',  'TExceptionsT.actAdd', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1038, 1038, 'Изменить',  'TExceptionsT.actEdit', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1039, 1039, 'Удалить',  'TExceptionsT.actDelete', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1040, 1040, 'Обновить таблицу',  'TExceptionsT.actRefreshAll', 102, 1




  insert tShipmentsBoxesDetail
        (ShipmentsBoxesID
        ,OrderID
        ,TransporterNumber
        ,Invoice
        ,BoxNumber
        ,Weight
        ,Volume)
  select sb.ShipmentsBoxesID
        ,o.OrderID
        ,sb.TransporterNumber
        ,o.Invoice
        ,sb.BoxNumber
        ,isnull(p.[WeightKGF],o.[WeightKG])
        ,isnull(p.[VolumeKGF],o.[VolumeKG])
    from tShipmentsBoxes sb (nolock)
    
   inner join tOrders o with (nolock index=ao3)
           on o.box = sb.BoxNumber          
    left join tPrice p with (nolock index=ao1)
           on p.PriceID = o.PriceID	