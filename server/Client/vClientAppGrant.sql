if OBJECT_ID('vClientAppGrant') is not null
    drop view vClientAppGrant
--go
--/* 						
--vClientAppGrant - Формирование главного меню клиентского приложения
-- */

--create view vClientAppGrant

--as
----
--select 1          GrantID    
--      ,1          MenuID   
--      ,0          ParentID
--      ,'Поиск'    Caption	           
--      ,'TSearchF' Name
--      ,2          Image
--Union all select 2, 2, 0, 'Корзина', 'TBasketF', 3
--Union all select 3, 3, 0, 'Заказы',   'TOrdersT2', 4

--go
--grant all on vClientAppGrant to public

