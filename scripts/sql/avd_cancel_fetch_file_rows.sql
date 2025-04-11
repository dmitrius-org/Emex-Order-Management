    select ROW_NUMBER() over( partition by FileName order by FileName) as N
        ,FileName
        ,OperDate
        ,OrderNum
        ,convert(varchar(8), OrderDate, 3) OrderDateStr
        ,UploadFileName
        ,MakeLogo
        ,DetailNumber
        ,DetailName
        ,CustomerPriceLogo
        ,DetailID    
        ,Quantity
        ,QuantityOrg
        ,Price
        ,Amount
        ,Brand
        ,OnlyThisBrand
        ,CustomerClientNum  -- № Клиента
        ,CustomerClientSign -- Пометки Клиента
        ,CustomerOrder      -- Заказ
    from #UnloadRefusals (nolock)
    where FileName = ?
    order by FileName 