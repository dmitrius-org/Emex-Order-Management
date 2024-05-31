
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



Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-plane"></i>'
      ,ImageHelp = 'Экспресс доставка: “Прямая авиадоставка: быстро и дорого. Этим способом выгодно заказывать небольшие детали без объемного веса. К доставке не принимается опасный груз. Внизу поставить перечеркнутые логотипчики как в брошуре самолета, что нельзя возить взрывоопасные и легковоспламеняющиеся товары ( масла, подушки безопасности и т.д.)'
   where Name = 'ADQ-Express'
   

Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-car"></i>'
      ,ImageHelp = 'Стандартная доставка: “Непрямая авиадоставка с пересадкой и перегрузкой в грузовой транспорт. Этим способом выгодно доставлять 90% деталей, но для доставки деталей с большим объемным весом лучше выбрать Контейнерную доставку.'
   where Name = 'ADQ-Charter'
   


Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-ship"></i>'
      ,ImageHelp = 'Контейнерная доставка: Самый дешевый способ доставки грузов, он же и самый долгий. Этот способ подходит для доставки тяжелых или крупных деталей с большим объемом. Также можно доставлять любой опасный груз: масла, подушки безопасности с пиропатронами и так далее.”'
   where Name = 'ADQ-Container'

delete from tSettings 
where SettingsID in (70,71,72)

