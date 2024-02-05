if OBJECT_ID('vFindByNumber') is not null
    drop view vFindByNumber
go
/* **********************************************************						
vFindByNumber - получение списка найденных
********************************************************** */

create view vFindByNumber

as

--SET DATEFIRST 1;

select ROW_NUMBER() over (partition by p.DetailNum order by p.PercentSupped desc, cast(p.Available as int) desc) N,
       p.ID,
       p.MakeName,
       p.DetailNum,
	   p.PartNameRus,
	   0 as DeliveryType, -- тип доставки
	   --dbo.AddDaysAndWeekends(GetDate(), p.Delivery, 1) 
	   p.Delivery,        -- срок поставки
       p.PercentSupped,   -- процент поставки (Статистика)
	   p.Price,           -- цена детали у emex
       p.PriceRub,        -- цена детали, показаваемая на сайте
       p.Available,       -- наличие детали на складе
       p.PriceLogo,
       '<fieldset class="rating">'+
       '<input type="radio" ' + iif(p.PercentSupped between 91 and 100,'checked', '') + '/><label class="full" for="star5"    ></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 81 and 90, 'checked', '') + '/><label class="half" for="star4half"></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 71 and 80, 'checked', '') + '/><label class="full" for="star4"    ></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 61 and 70, 'checked', '') + '/><label class="half" for="star3half"></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 51 and 60, 'checked', '') + '/><label class="full" for="star3"    ></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 41 and 50, 'checked', '') + '/><label class="half" for="star2half"></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 31 and 40, 'checked', '') + '/><label class="full" for="star2"    ></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 21 and 30, 'checked', '') + '/><label class="half" for="star1half"></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 11 and 20, 'checked', '') + '/><label class="full" for="star1"    ></label>'+
       '<input type="radio" ' + iif(p.PercentSupped between 1  and 10, 'checked', '') + '/><label class="half" for="star0half"></label>'+
       '</fieldset>'+
       '<label id="prc" class="ratingprc"> ' + cast(p.PercentSupped as varchar(30)) + '%</label>' as Rating,
       p.DestinationLogo
  from pFindByNumber p (nolock)
 --inner join tSearchPrice sp (nolock)
 --        on sp.MakeLogo             = p.PriceLogo
	   -- and isnull(sp.Synthetic, 0) = 0
-- where p.Spid = @@spid
   --and (p.PercentSupped >= 30
   --    or (p.PercentSupped <30 and not exists (select 1 
   --                                                from pFindByNumber f (nolock)
   -- 											  where f.Spid = @@spid
   -- 											    and f.PercentSupped >= 30
   --                                                 )
   -- 	  )
   --     )

go
grant all on vFindByNumber to public
go


Select *
  from vFindByNumber
order by n  



Select *
  from vFindByNumber
 where DestinationLogo = '0001'
order by n  






