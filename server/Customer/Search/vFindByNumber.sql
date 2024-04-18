if OBJECT_ID('vFindByNumber') is not null
    drop view vFindByNumber
go
/* **********************************************************						
vFindByNumber - получение списка найденных деталей



поиск детали по номеру

Выходные параметры:

Available     – наличие детали на складе
bitOldNum     – признак УСТАРЕВШИЙ НОМЕР
PercentSupped – процент поставки
PriceId       – идентификатор прайслиста
Region        – регион доставки детали
Delivery      – срок поставки
Make          – лого бренда детали
DetailNum     – номер детали
PriceLogo     – лого прайслиста
Price         – цена детали, показаваемая на сайте
PartNameRus   – русское название детали
PartNameEng   – английское название детали
WeightGr      – вес детали в граммах
MakeName      – название бренда
Packing       – количество деталей в упаковке
VolumeAdd     – наценка объем (объемный вес)
GuaranteedDay – гарантированный срок поставки детали

********************************************************** */

create view vFindByNumber
as 

select ROW_NUMBER() over (partition by p.DetailNum order by p.PercentSupped desc, cast(p.Available as int) desc) N,
       p.ID,
       p.MakeName,
       p.DetailNum,
	   p.PartNameRus,
	   0 as DeliveryType,   -- тип доставки
	   p.WeightGr [Weight], -- вес детали в граммах
	   p.VolumeAdd,         -- наценка объем (объемный вес)
	   --dbo.AddDaysAndWeekends(GetDate(), p.Delivery, 1) 
	   p.OurDelivery,     -- наш срок поставки
	   p.OurDeliverySTR,  -- наш срок поставки строкой, показываем клиенту
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
  from pFindByNumber p with (nolock index=ao2)

 --cross apply (select top 1 * 
 --               from pFindByNumber pp  with (nolock index=ao2)
	--	   	   where pp.Spid = @@spid
	--		 ) pp
 
 left join tSettings st (nolock)
        on st.Brief = 'PercentSupped'


 where p.Spid             = @@spid
   --
   and p.Available        > 0
   -- фильтры по вероятности поставки
   and p.PercentSupped   >= isnull(cast(st.Val as int), 0)

   and not exists (select 1
                     from tPrices sp with (nolock index=a1)
                    where sp.Name         = p.PriceLogo
					  and sp.ShowInSearch = 1)

go
grant all on vFindByNumber to public

go
exec setOV 'vFindByNumber', 'V', '20240416', '5'
go
-- select * from tPrice where DetailNum =  '09G301469A'