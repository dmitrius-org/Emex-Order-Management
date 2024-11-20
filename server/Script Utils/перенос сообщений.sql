--rollback tran
begin tran
declare @ID as table (

ChatID	numeric (18, 0),
OrderID	numeric (18, 0)

)


insert tChats
(

 ClientID
,OrderID
,InDateTime
)
output  INSERTED.ChatID, INSERTED.OrderID  INTO  @ID(ChatID, OrderID) 
Select o.ClientID
      ,o.OrderID 
      ,'20241101'
  from tOrders o
 --inner join tChats c
 --        on c.OrderID = o.OrderID
 where isnull(o.Comment, '') <> '' 


insert tChatsMessage
      (
       ChatID
      ,UserID
      ,Message
      ,Flag
      ,InDateTime
      )
select id.ChatID
      ,2
      ,o.Comment
      ,1
      ,'20140101'
  from @ID id
 inner join tOrders o 
         on o.OrderID = id.OrderID

select * from tChats (nolock)

select * from tChatsMessage (nolock)
-- commit tran
--select * from tUser


Update m
  set m.InDateTime = o.OrderDate
  from tOrders o
 inner join tChats c
         on c.OrderID = o.OrderID

          inner join tChatsMessage m
         on m.ChatID = c.ChatID
         and m.InDateTime = '20140101'