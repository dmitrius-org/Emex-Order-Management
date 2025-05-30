if OBJECT_ID('DashBoardDataLoad') is not null
    drop proc DashBoardDataLoad
/*
  DashBoardDataLoad -


status:
info
warning 
danger
success


*/
go
create proc DashBoardDataLoad
as
  SET NOCOUNT ON; 
  SET DATEFIRST 1;  

  declare @r int = 0



  if OBJECT_ID('tempdb..#result') is not null
      drop table #result
  CREATE TABLE #result
  (
      Id       int,
      Title    nvarchar(30),
      Status   nvarchar(30), 
      Icon     nvarchar(30), 
      Hint     nvarchar(256),
      Detail   nvarchar(500),
  );
  
  

  -- Проверка закрузки курсов
 
  /* insert #result (Id, Title, Status, Icon, Detail, Hint) 
  select 1,
         'Загрузка курсов',
         case 
             when datepart(dw, getdate()) = 1 and datediff(dd, t.OnDate, getdate()) >= 3 then 'panel-danger'
             when datepart(dw, getdate()) <> 1 and datediff(dd, t.OnDate, getdate()) >= 1 then 'panel-warning'
             else 'panel-success'
         end,
         'fa4-usd',
         t.Value,
         'Cтатус загрузки курсов'
    from (select max(t.OnDate) OnDate,
                 STRING_AGG(cast(Value as varchar) + ', ' + convert(varchar, OnDate, 104), '</br>')  as Value
            from 
                 (select top 5 *
                    from tCurrencyRate (nolock) 
                   order by OnDate desc
                 ) as t
          ) as t*/

    WITH TopRates AS (
        SELECT TOP 1 *
          FROM tCurrencyRate (NOLOCK)
         ORDER BY OnDate DESC
    ),
    NumberedRates AS (
        SELECT 
              ROW_NUMBER() OVER (ORDER BY OnDate DESC) AS rn,
              Value,
              OnDate
         FROM TopRates
    ),
    FormattedRates AS (
        SELECT 
            CASE 
              WHEN rn = 1 
              THEN '<b>' + CAST(Value AS VARCHAR) + ', ' + CONVERT(VARCHAR, OnDate, 104) + '</b>'
              ELSE CAST(Value AS VARCHAR) + ', ' + CONVERT(VARCHAR, OnDate, 104)
            END AS Formatted
        FROM NumberedRates
    )
    insert #result (Id, Title, Status, Icon, Detail, Hint) 
    SELECT 
          1,
          'Загрузка курсов',
          CASE 
              WHEN DATEPART(dw, GETDATE()) = 1 AND DATEDIFF(dd, t.OnDate, GETDATE()) >= 3 THEN 'panel-danger'
              WHEN DATEPART(dw, GETDATE()) <> 1 AND DATEDIFF(dd, t.OnDate, GETDATE()) >= 1 THEN 'panel-warning'
              ELSE 'panel-success'
          END,
          'fa4-usd',
          (
            SELECT STRING_AGG(Formatted, '</br>')
            FROM FormattedRates
          ),
          'Cтатус загрузки курсов'
    FROM (
         SELECT MAX(OnDate) AS OnDate
          FROM TopRates
    ) AS t;

  
  -- проверка загрузки прайсов
  insert #result (Id, Title, Status, Icon, Detail, Hint) 
  select 2,
         'Поставщики',
         case 
             when t.Price is not null then 'panel-danger'
             else 'panel-success'
         end,
         'fa-calculator',
         case 
             when t.Price is not null then t.Price
             else 'Дата обновления: ' + convert(nvarchar, getdate(), 104)
         end,
         'Поставщики - показывает все ли прайс-листы вовремя обновлены и загружены в систему'
    from (select 1 as p) as p
    left join ( select STRING_AGG (rtrim(PriceName) + ', ' + convert(nvarchar, UpdateDate, 104), '</br>') as Price
                  from tProfilesPrice
                 where datediff(dd, UpdateDate, Getdate()) > 0
              ) as t on 1=1

  

  -- проверка выгрузки ответов/отказов
  insert #result (Id, Title, Status, Icon, Detail, Hint) 
  select 
        3,
        'Отказы',
        case 
            when  datediff(dd, t.OperDate, getdate()) >2 then 'panel-danger'
            when  datediff(dd, t.OperDate, getdate()) >1 then 'panel-warning'
            else 'panel-success'
        end,
        'fa-reply-all', 
         --'<p>' + Detail + '</p>',
         Detail,
        'Отказы (Автоматические) - показывает когда клиентам выгружены отказы'
  from
      (
      select min(up.OperDate) as OperDate,        
             STRING_AGG(c.Brief + ': ' + convert(nvarchar, up.OperDate, 104), '</br>') as Detail
        from tClients c (nolock)
       OUTER APPLY (select top 1 up.OperDate
                      from tUnloadRefusals up (nolock)
                     where up.ClientID = c.ClientID
                     order by OperDate desc
                   ) as up
       where c.NotificationMethod = 0 --Способ оповещения: Автоматический
      ) as t

exit_:

  select Id      
        ,Title    
        ,Status  
        ,Icon    
        ,Hint    
        ,Detail 
    from #result (nolock)
   order by Id


return @r
go
grant exec on DashBoardDataLoad to public
go
exec setOV 'DashBoardDataLoad', 'P', '20240611', '2'
go


exec DashBoardDataLoad