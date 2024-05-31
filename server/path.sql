
--alter table tBasket add InDateTime  datetime default getdate()        -- Дата добавления детали в корзину


delete from tMenu where MenuID=65
delete from tMenu where MenuID=66
--Update tMenu
--   set Name = 'TInstructionT'
-- where Name = 'TConfluenceT'


insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 65,  65,  'Инструкции',                  'TInstructionT', 0,   64, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 66,  66,  'Разработка',                  'TInstructionDevT', 0,   64, ''




alter table tSupplierDeliveryProfiles add [Image]            nvarchar(256)
alter table tSupplierDeliveryProfiles add [ImageHelp]        nvarchar(2048)



select * from tSupplierDeliveryProfiles
--select * from tSettings 