

if OBJECT_ID('PartProtocolSelect') is not null
    drop proc PartProtocolSelect
go
/* **********************************************************						
PartProtocolSelect - начитка данных для формы Протокол
********************************************************** */
create proc PartProtocolSelect
              @OrderID	numeric(18, 0)
as

SELECT h.DetailNum	 
      ,h.MakeLogo    
      ,h.Brand       
      ,h.DetailName  
      ,h.WeightKG    
      ,h.VolumeKG    
      ,h.Restrictions
      ,h.Fragile
      ,cast(u.Name as varchar) as UserName      
      ,h.updDateTime 

  FROM tOrders o with (nolock index=ao1)
 inner join History.tPartsHistory h with (nolock index=ao1)
         on h.DetailNum = /*isnull(o.ReplacementDetailNumber,*/ o.DetailNumber--)
        and h.MakeLogo  = /*isnull(o.ReplacementMakeLogo,    */ o.MakeLogo--)
 inner join tUser u with (nolock index=ao1)
         on u.UserID = h.UserID
 where o.OrderID=@OrderID
 order by h.updDateTime desc
 
go
grant exec on PartProtocolSelect to public
go
exec setOV 'PartProtocolSelect', 'P', '20250220', '0'
go
