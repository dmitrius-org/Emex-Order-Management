

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
      ,t.Brand    
      ,t.BrandName       
      ,isnull(t.DetailNameF, t.DetailName) DetailName
      ,isnull(t.WeightKGF, t.WeightKG)     WeightKG   
      ,isnull(t.VolumeKGF, t.VolumeKG)     VolumeKG   
      ,t.NoAir
      ,t.Fragile
      ,t.NLA
      ,cast(u.Name as varchar) as UserName      
      ,t.UpDatetime

  FROM tOrders o with (nolock index=ao1)
 inner join vPartHistory t
         on t.Brand  = /*isnull(o.ReplacementMakeLogo,    */ o.MakeLogo--) 
        and t.DetailNum = /*isnull(o.ReplacementDetailNumber,*/ o.DetailNumber--)
  
       
 inner join tUser u with (nolock index=ao1)
         on u.UserID = t.UserID
 where o.OrderID=@OrderID

 order by t.UpDatetime desc
 
go
grant exec on PartProtocolSelect to public
go
exec setOV 'PartProtocolSelect', 'P', '20250531', '2'
go


exec PartProtocolSelect @OrderID=189339