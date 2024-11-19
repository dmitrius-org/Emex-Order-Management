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
       p.Make as MakeLogo,
       p.MakeName,
       p.DetailNum,
	   p.PartNameRus,
	   0 as DeliveryType,   -- тип доставки
	   p.WeightGr [Weight], -- вес детали в граммах
	   p.VolumeAdd,         -- наценка объем (объемный вес)
	   p.OurDelivery,       -- наш срок поставки
	   p.OurDeliverySTR,    -- наш срок поставки строкой, показываем клиенту
       p.PercentSupped,     -- процент поставки (Статистика)
	   p.Price,             -- цена детали у emex
       p.PriceRub,          -- цена детали, показаваемая на сайте
       case 
         when isnumeric(p.Available) = 1 
         then cast(p.Available as int)
         else null
       end  Available,
       --case 
       --  when p.Available = -1 then 'под заказ'
       --  else cast(p.Available as nvarchar)
       --end as AvailableStr,-- наличие детали на складе
       p.PriceLogo,
       p.DestinationLogo,
       p.Packing
  from pFindByNumber p with (nolock index=ao2)
  left join tSettings st with (nolock index=ao2)
         on st.Brief = 'PercentSupped'
 where p.Spid             = @@spid
   -- фильтры по вероятности поставки
   and p.PercentSupped   >= isnull(cast(st.Val as int), 0)
   and not exists (select 1
                     from tPrices sp with (nolock index=a1)
                    where sp.Name         = p.PriceLogo
					  and sp.ShowInSearch = 1)

go
grant all on vFindByNumber to public
go
exec setOV 'vFindByNumber', 'V', '20241119', '11'
go

