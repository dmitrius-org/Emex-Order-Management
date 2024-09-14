if OBJECT_ID('ShipmentsStatusRefresh') is not null
  drop proc ShipmentsStatusRefresh
go
/* **********************************************************

********************************************************** */
create proc ShipmentsStatusRefresh
as

insert tShipmentsStatus (
       Date
      ,Number
      ,Name
      ,Brief
      ) 
select p.Date
      ,p.Number
      ,p.Name
      ,p.Brief
  from #shipments p (nolock)
 where not exists (select 1
                     from tShipmentsStatus t with (nolock index=ao2)
                    where t.Brief = p.Brief
                      and t.Number= p.Number
                  )

--update t
--   set t.Code    = p.Code
--      ,t.Name    = p.Name
--      ,t.Country = p.Country
--      ,t.updDatetime  = GetDate()
--  from #shipments p (nolock)
-- inner join tMakes t (updlock)
--         on t.Code  = p.Code

go
grant execute on ShipmentsStatusRefresh to public
go
exec setOV 'ShipmentsStatusRefresh', 'P', '20240914', '0'
go