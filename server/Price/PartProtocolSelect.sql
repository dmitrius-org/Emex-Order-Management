

if OBJECT_ID('PartProtocolSelect') is not null
    drop proc PartProtocolSelect
go
/* **********************************************************						
PartProtocolSelect - начитка данных для формы Протокол
********************************************************** */
create proc PartProtocolSelect
              @OrderID	numeric(18, 0)
as

SELECT t.DetailNum	 
      ,t.MakeLogo    
      ,t.Brand       
      ,t.DetailName  
      ,t.WeightKG    
      ,t.VolumeKG    
      ,t.Restrictions
      ,t.Fragile
      ,t.NLA
      ,cast(u.Name as varchar) as UserName      
      ,t.InDatetime  as updDateTime

  FROM tOrders o with (nolock index=ao1)
 inner join tParts for system_time all t with (nolock index=PK_tParts_ID) 
         on t.DetailNum = /*isnull(o.ReplacementDetailNumber,*/ o.DetailNumber--)
        and t.MakeLogo  = /*isnull(o.ReplacementMakeLogo,    */ o.MakeLogo--)
       
 inner join tUser u with (nolock index=ao1)
         on u.UserID = t.UserID
 where o.OrderID=@OrderID

 order by t.ValidFrom desc
 
go
grant exec on PartProtocolSelect to public
go
exec setOV 'PartProtocolSelect', 'P', '20250227', '1'
go


exec PartProtocolSelect @OrderID=189339