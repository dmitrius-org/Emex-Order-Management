unit uEmexUtils;
{
                            Интеграция с Emex api
}
interface

uses System.SysUtils, System.Classes,

     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Option,

     uCommonType, uConstant,

     uServiceEmex, Soap.XSBuiltIns, uSqlUtils;

  Type

  /// <summary>
  /// TEmex класс интеграции с Emex api
  /// </summary>
  TEmex= class
    private
      FConnection: TFDConnection;

      FEmex: ServiceSoap;

      FSQl: TSQL;
      FQuery: TFDQuery;

      FLang:string;
      FUrl:string;

      function GetEmex: ServiceSoap;
      function GetSQl: TSQL;

      /// <summary>
      /// ForClients - Формирование списка клиентов для обработки заказов в разрезе ForClients
      /// </summary>
      function ForClients: TStringList;

      /// <summary>
      /// ForSupplier - Формирование списка поставщиков для обработки заказов в разрезе поставщиков
      /// </summary>
      function ForSupplierByMarks: TStringList;

      /// <summary>
      /// FillMovement - Вспомогательная процедура для заполнения pMovement
      /// </summary>
      procedure FillMovement(AParts: ArrayOfMovement);

      /// <summary>
      /// FillFindByNumber - Вспомогательная процедура для заполнения pFindByNumber
      /// </summary>
      procedure FillFindByNumber(APparts: ArrayOfFindByNumber; AClientID: LongInt = 0);

      /// <summary>
      /// DeleteBasketDetails - Удаление детали из корзины
      /// </summary>
      procedure DeleteBasketDetails(AQry: TFDQuery; ASupplier: Integer = 0);

    public
      constructor Create(Value: TFDConnection); overload;
      destructor Destroy; override;

      property Emex: ServiceSoap read GetEmex;

      property SQl: TSQL read GetSQl;

      /// <summary>Login - Авторизация </summary>
      function Login(AAccount: Integer): String;

      /// <summary>
      /// TestConnect - тестовый метод для проверки работоспособности сервисов emex.
      /// </summary>
      /// <returns>Возвращает тестовую строку с текущим временем</returns>
      function TestConnect(): string;

      /// <summary>FindByDetailNumber - поиск детали по номеру </summary>
      procedure FindByDetailNumber(AClientID:LongInt; ADetailNum:string);

      /// <summary>
      /// getCustomer -Подготовка авторизационных данных (пользователь, пароль).
      /// </summary>
      /// <param name="ASuppliersID">идентификатор постащика </param>
      /// <returns> объект Customer</returns>
      function getCustomer(ASuppliersID: Integer): Customer;

      /// <summary>
      /// getCustomerByClient -Подготовка авторизационных данных (пользователь, пароль).
      /// </summary>
      /// <param name="AClientID">идентификатор клиента</param>
      /// <returns> объект Customer</returns>
      function getCustomerByClient(AClientID: Integer): Customer;

      /// <summary>
      /// InsertPartToBasketByMarks - Помещение запчастей в корзину
      /// </summary>
      /// <returns> число строк, добавленных в корзину</returns>
      function InsertPartToBasketByMarks(): integer;

      /// <summary>
      /// InsertPartToBasketRollbackByMarks -  Удаление запчастей из корзины. Вызывается при откате действия добавить в корзину.
      /// </summary>
      /// <returns>Ошибки пишем в pAccrualAction</returns>
      procedure InsertPartToBasketRollbackByMarks();

      /// <summary>
      /// InsertPartToBasketCancelByMarks -  Удаление запчастей из корзины при ошибке добавления или при ошибках мапинга
      /// </summary>
      procedure InsertPartToBasketCancelByMarks();

      /// <summary>GetBasketDetailsByMarks - получение корзины.
      /// </summary>
      /// <returns>Результат пишется в pBasketDetails</returns>
      procedure GetBasketDetailsByMarks();

      /// <summary>
      /// DeleteFromBasketByBasketID - Удаление детали из корзины.
      /// </summary>
      /// <param name="ABasketID">идентификатор строки корзины</param>
      procedure DeleteFromBasketByBasketID(ABasketID: Integer);

      /// <summary>
      /// DeleteFromBasketByOrderID - Удаление детали из корзины по идентификатору заказа
      /// </summary>
      /// <param name="AOrderID">идентификатор заказа</param>
      function DeleteFromBasketByOrderID(AOrderID: Integer): integer;

      /// <summary>
      /// InsertFromBasketByOrderID -  Добавление детали в корзину по идентификатору заказа
      /// </summary>
      /// <param name="AOrderID">идентификатор заказа</param>
      function InsertFromBasketByOrderID(AOrderID: Integer): Int64;

      /// <summary>
      /// GetBasketDetailsByOrderID - получение корзины.
      /// </summary>
      /// <returns>Результат ArrayOfBasketDetails_v2</returns>
      function GetBasketDetailsBySuppliersID(ASuppliersID: Integer):ArrayOfBasketDetails_v2;

      /// <summary>
      /// CreateOrder - создание заказа клиента по данным корзины. Заказ создается по всем позициям в корзине
      /// </summary>
      /// <returns> CreateOrderResult – при успешном завершении возвращает
      /// положительное число (номер созданного заказа)
      /// При неудаче возвращается отрицательное число или 0:
      /// -1 - Клиенту запрещено создавать заказ
      /// -2 - Недостаточно средств на балансе клиента
      /// -3 - Ошибка с типом отгрузки
      /// -4 - Нет позиций для заказа
      /// -0 - Иная ошибка
      /// </returns>
      procedure CreateOrder();

      /// <summary>OrderStateSyncByOrderNum - синхронизация статуса заявки </summary>
      procedure OrderStateSyncByOrderNum();

      /// <summary>MovementByOrderNumber - просмотр движения по номеру заказа.
      /// <param name="ASupplierID">идентификатор постащика </param>
      /// <param name="AEmexOrderID">идентификатор заказа в emex </param>
      /// <returns>Результат пишется в pMovement </returns
      /// </summary>
      procedure MovementByOrderNumber(ASupplierID: Integer; AEmexOrderID: integer);

      /// <summary>MovementInWorkByMarks Просмотр движения по статусу 'В работе' </summary>
      /// <returns>Результат пишется в pMovement </returns
      procedure MovementInWorkByMarks();

      /// <summary>
      /// FillBasketDetails - Вспомогательная процедура для заполнения pBasketDetails данными корзины из emex
      /// </summary>
      procedure FillBasketDetails(ABasket: ArrayOfBasketDetails_v2; ASupplier: Integer = 0); overload;

      /// <summary>
      /// FillBasketDetails - Вспомогательная процедура для заполнения pBasketDetails данными корзины из emex
      /// </summary>
      procedure FillBasketDetails(ABasket: BasketDetails_v2; ASupplier: Integer = 0); overload;

       /// <summary>UpdateBasketDetails- редактирование запчастей в корзине </summary>
      //function UpdateBasketDetails(Apart: BasketDetails; ASupplier: Integer):string;

  end;

implementation

uses
  uLogger;


{ TEmex }

constructor TEmex.Create(Value: TFDConnection);
begin
  logger.Info('TEmex.Create Begin');

  if Assigned(Value) then
    FConnection:= Value;

  if not Assigned(FSQl) then
    FSQl:=TSQl.Create(FConnection);

  if not assigned(FQuery) then
  begin
    FQuery:= TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
   // FQuery.FetchOptions.AutoFetchAll := TFDAutoFetchAll.afAll;
   // FQuery.FetchOptions.AssignedValues := [evAutoFetchAll];
    FQuery.FetchOptions.RowsetSize := 1000000;
    FQuery.Connection := FConnection;
  end;

  // Код языка, на котором будут возвращаться сообщения об ошибках - EN (по умолчанию) или RU
  FLang := FSQl.GetSetting('EmexServiceSoapLang', 'RU');

  FUrl := FSQl.GetSetting('EmexServiceSoapUrl');

  if Trim(FUrl) = '' then
  begin
    raise Exception.Create('Незадан адрес Emex Service Soap! (EmexServiceSoapUrl)');
  end;

  logger.Info('TEmex.Create End');
end;

procedure TEmex.CreateOrder();
var Suppliers : TStringList;
    Supplier: string;
     Order: Integer;
    retval: Integer;
    Basket: ArrayOfBasketDetails_v2;
begin
  logger.Info('TEmex.CreateOrder Begin');


  FSQl.Open('''
            select 1
              from pAccrualAction p (nolock)
             where p.Spid   = @@SPID
               and p.RetVal = 534;
           ''', [],[]);
  if FSQl.Q.RecordCount > 0 then
  begin
    logger.Info('TEmex.CreateOrder End Ошибка: 534');
    Exit;
  end;

  Suppliers := ForSupplierByMarks();

  for Supplier in Suppliers do // Цикл по поставщикам
  begin

    // *** Проверка корзины *** \\
    Basket:=Emex.GetBasketDetails_v2(getCustomer(Supplier.ToInteger), FLang);  // запрос корзины в emex

    FSQL.Exec('Delete pBasketDetails from pBasketDetails (rowlock) where spid = @@spid', [], []);
    FillBasketDetails(Basket, Supplier.ToInteger); // запись в БД

    FSQl.Exec('exec EmexCreateOrderBasketCheck', [], []);
    FQuery.Open(' select * '+
                '   from pBasketDetails with (nolock index=ao1) '+
                '  where Spid   = @@spid '+
                '    and RetVal > 0      ');

    if FQuery.RecordCount > 0 then
    begin
        DeleteBasketDetails(FQuery, Supplier.ToInteger);

        FSQl.Open(' select 1 '+
                  '   from pBasketDetails with (nolock index=ao1) '+
                  '  where Spid   = @@spid '+
                  '    and RetVal = 537    ', [],[]);

        if FSQl.Q.RecordCount > 0 then // если имеются ошибки удаления, то оста
        begin
            logger.Info('TEmex.CreateOrder End Ошибка: 537');

            FQuery.Close;
            FQuery.SQL.Text := ' Update p                 '+
                            '    set p.Retval = 537    '+
                            '   from pAccrualAction p with (updlock index=ao2) '+
                            '  where p.spid   = @@spid '+
                            '    and p.Retval = 0      ';
            FQuery.ExecSQL;

            Exit;
        end;
    end;


    // *** Создание заказа *** \\
    Order:=Emex.CreateOrder(getCustomer(Supplier.ToInteger));

    logger.Info('TEmex.CreateOrder Создан заказ: ' + Order.ToString);

    if Order > 0 then
    begin
      logger.Info('TEmex.CreateOrder Order: ' + Order.ToString);
      FSQL.Exec(' delete pMovement from pMovement (rowlock) where spid = @@spid ', [],[]);

      // запрашиваем данные по сформированному заказу для проверки, что все позиции заказаны
      MovementByOrderNumber(Supplier.ToInteger, Order);

      FQuery.Close;
      FQuery.SQL.Text := 'exec EmexOrderCreateSync ';
      FQuery.ExecSQL;
    end
    else
    begin
      logger.Info('TEmex.CreateOrder Error: ' + Order.ToString);

      case Order of
        -1: retval := 507; // Клиенту запрещено создавать заказ!
        -2: retval := 508; // Недостаточно средств на балансе клиента!
        -3: retval := 509; // Ошибка с типом отгрузки!
        -4: retval := 510; // Нет позиций для заказа!
      else
        retval := 511;// Неизвестная ошибка!
      end;

      FQuery.Close;
      FQuery.SQL.Text := ' Update p '+
                      '    set p.Retval=:Retval           '+
                      '   from pAccrualAction p (updlock) '+
                      '  where p.spid   = @@spid '+
                      '    and p.Retval = 0      ';
      FQuery.ParamByName('Retval').AsInteger := retval;
      FQuery.ExecSQL;
    end;

  end;
  FreeAndNil(Suppliers);
  logger.Info('TEmex.CreateOrder End');
end;

procedure TEmex.DeleteBasketDetails(AQry: TFDQuery; ASupplier: Integer);
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    I, R: Integer;
begin
  logger.Info('TEmex.DeleteBasketDetails Begin');
  if AQry.RecordCount > 0 then
  begin
    SetLength(outBasket, 1);

    part:= BasketDetails.Create;

    AQry.First;
    for I := 0 to AQry.RecordCount - 1 do // удаление выполняем по одному, чтобы можно было понять по какой детали получили ошибку
    begin
      logger.Info('TEmex.DeleteBasketDetails BasketId: ' + AQry.FieldByName('BasketId').AsString);

      part.BasketId := AQry.FieldByName('BasketId').AsLargeInt;
      part.Date_add:= TXSDateTime.Create;

      outBasket[0]:= part;

      R:=Emex.DeleteFromBasket(getCustomer(ASupplier), outBasket);

      if R <> 1 then
      begin
        logger.Info('TEmex.DeleteBasketDetails 537 Количество удаленных товаров: ' + R.ToString);
        logger.Info('TEmex.DeleteBasketDetails 537 Ошибка удаления товара из корзины, требуется ручная проверка! '+
        '[ASupplier: ' + ASupplier.ToString + ', BasketId: ' + part.BasketId.ToString +  ']');

        FSQl.Exec(' Update pBasketDetails '+
                  '    set Retval = 537   '+
                  '   from pBasketDetails with (updlock index=ao2) '+
                  '  where Spid     = @@spid     '+
                  '    and BasketId = :BasketId  ',
                  ['BasketId'],
                  [AQry.FieldByName('BasketId').AsLargeInt]);
      end;

      AQry.Next;
    end;

    part.Destroy;
  end;
  logger.Info('TEmex.DeleteBasketDetails End');
end;

procedure TEmex.DeleteFromBasketByBasketID(ABasketID: Integer);
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    I, R: Integer;
begin

end;

function TEmex.DeleteFromBasketByOrderID(AOrderID: Integer): integer;
var part: BasketDetails;
    InBasket: ArrayOfBasketDetails;
begin
  logger.Info('TEmex.DeleteFromBasketByOrderID Begin');
  result:=0;

  FQuery.close;
  FQuery.sql.Text := 'select BasketId, SuppliersID from tOrders (nolock) where OrderID = :OrderID ';
  FQuery.ParamByName('OrderID').AsInteger := AOrderID;
  FQuery.Open();

  if FQuery.RecordCount > 0 then
  begin
    SetLength(InBasket, 1);

    part:= BasketDetails.Create;

    FQuery.First;
    begin
      logger.Info('TEmex.DeleteFromBasketByOrderID BasketId: ' + FQuery.FieldByName('BasketId').AsString);

      part.BasketId := FQuery.FieldByName('BasketId').AsLargeInt;
      part.Date_add:= TXSDateTime.Create;

      InBasket[0]:= part;

      result:=Emex.DeleteFromBasket(getCustomer(FQuery.FieldByName('SuppliersID').AsLargeInt), InBasket);

      if result <> 1 then
      begin
        Result := 537;
        logger.Info('TEmex.DeleteFromBasketByOrderID 537 Количество удаленных товаров: ' + result.ToString);
        logger.Info('TEmex.DeleteFromBasketByOrderID 537 Ошибка удаления товара из корзины. '+ '[ASupplier: ' + FQuery.FieldByName('SuppliersID').AsLargeInt.ToString + ', BasketId: ' + part.BasketId.ToString +  ']');
      end;

      FQuery.Next;
    end;

    part.Destroy;
  end;
  logger.Info('TEmex.DeleteFromBasketByOrderID End');
end;

destructor TEmex.Destroy;
begin
  inherited;

  FreeAndNil(FQuery);
  FreeAndNil(FSQl);
end;

function TEmex.ForClients: TStringList;
var i: Integer;
begin
    result := TStringList.Create;
    FQuery.Close;
    FQuery.Open('''
              Select distinct o.ClientID
               from pAccrualAction p with (nolock index=ao2)
              inner join tOrders o with (nolock)
                      on o.OrderID=p.ObjectID
              where p.Spid = @@spid
                and p.Retval = 0
             ''', [], []);
    FQuery.First;
    for I := 0 to FQuery.RecordCount - 1 do
    begin
      result.Add(FQuery.FieldByName('ClientID').AsString);
      FQuery.Next;
    end;
end;

function TEmex.ForSupplierByMarks: TStringList;
var i: Integer;
begin
    result := TStringList.Create;
    FQuery.Close;
    FQuery.Open('''
              Select distinct
                     s.SuppliersID
                from pAccrualAction p with (nolock index=ao2)
               inner join tOrders o with (nolock)
                       on o.OrderID = p.ObjectID
               inner join tClients c with (nolock)
                       on c.ClientID = o.ClientID
               inner join tSuppliers  s with (nolock)
                       on s.SuppliersID = c.SuppliersID
               where p.Spid   = @@spid
                 and p.Retval = 0
             ''', [], []);
    FQuery.First;
    for I := 0 to FQuery.RecordCount - 1 do
    begin
      result.Add(FQuery.FieldByName('SuppliersID').AsString);
      FQuery.Next;
    end;
end;

function TEmex.getCustomer(ASuppliersID: Integer): Customer;
begin
  logger.Info('TEmex.getCustomer begin');
  logger.Info('TEmex.getCustomer ASuppliersID: ' + ASuppliersID.ToString);
  begin
    //данные для интеграции берем из справочника "Клиенты"
    FSQL.Open('''
      Select s.emexUsername, s.emexPassword
        from tSuppliers  s with (nolock index=ao1)
       where s.SuppliersID = :SuppliersID
    ''',
    ['SuppliersID'], [ASuppliersID]);

    result := Customer.Create;
    result.UserName      := FSQL.Q.FieldByName('emexUsername').AsString;
    result.Password      := FSQL.Q.FieldByName('emexPassword').AsString;
    result.SubCustomerId := '0';
    result.CustomerId    := '0';

  end;
  logger.Info('TEmex.getCustomer end');
end;

function TEmex.getCustomerByClient(AClientID: Integer): Customer;
begin
  logger.Info('TEmex.getCustomerByClient begin');
  logger.Info('TEmex.getCustomerByClient AClientID: ' + AClientID.ToString);
  begin
    FSQL.Open('Select s.emexUsername, s.emexPassword        '+
             '  from tClients c with (nolock index=ao1)    '+
             '  join tSuppliers  s with (nolock index=ao1) '+
             '    on s.SuppliersID = c.SuppliersID         '+
             ' where c.ClientID = :ClientID',
            ['ClientID'], [AClientID]);

    result := Customer.Create;
    result.UserName      := FSQL.Q.FieldByName('emexUsername').AsString;
    result.Password      := FSQL.Q.FieldByName('emexPassword').AsString;

    result.SubCustomerId := '0';
    result.CustomerId    := '0';
  end;
  logger.Info('TEmex.getCustomerByClient end');
end;

function TEmex.GetEmex: ServiceSoap;
begin
  logger.Info('TEmex.GetEmex: ServiceSoap');

  result:= GetServiceSoap(false, FUrl);
end;

function TEmex.GetSQl: TSQL;
begin
  Result :=FSQl;
end;

function TEmex.InsertFromBasketByOrderID(AOrderID: Integer): Int64;
var part: partstobasket;
    InBasket: ArrayOfPartstobasket;
    OutBasket: ArrayOfBasketChangeResult;
begin
    logger.Info('TEmex.InsertPartToBasketByMarks Begin');
    Result := 0;
    begin
      logger.Info('TEmex.InsertPartToBasketByMarks AOrderID: ' + AOrderID.ToString);
      FQuery.Close;
      FQuery.SQL.Text:='''
        Select distinct *
          from vInsertPartToBasketByOrder
         where OrderID=:OrderID
      ''';
      FQuery.ParamByName('OrderID').AsInteger := AOrderID;
      FQuery.Open;

      if FQuery.RecordCount > 0 then
      begin
        FQuery.First;

        SetLength(inBasket, 1);

        part := partstobasket.Create;
        // – Текстовая информация, позволяющая клиенту идентифицировать запчасть. Часть этой информации может быть распечатана в виде штрих-кода на стикере запчасти
        part.Reference       := FQuery.FieldByName('Reference').AsString;
        part.CoeffMaxAgree   := FSQL.GetSetting('CoeffMaxAgree', 1.1);  // - максимальный коэффициент превышения цены продажи для клиента над ценой, показанной на сайте (по умолчанию 1.1)
        part.UploadedPrice   := FQuery.FieldByName('PricePurchase').AsFloat;  // - цена, заданная клиентом
        part.Confirm         := True;  // – признак, что строчка корзины будет включена в заказ (необходимо задать 1)
        part.Delete          := False; // – признак, что строчка корзины будет удалена (необходимо задать 0)
        part.bitAgree        := False; // – признак что клиент согласен на превышение цены свыше коэффициента CoeffMaxAgree
        part.OnlyThisBrand   := FQuery.FieldByName('OnlyThisBrand').asBoolean; // – признак ТОЛЬКО ЭТОТ БРЕНД
        part.MakeLogo        := FQuery.FieldByName('MakeLogo').AsString;       // – лого бренда
        part.DetailNum       := FQuery.FieldByName('DetailNumber').AsString;   // – номер детали
        part.PriceLogo       := FQuery.FieldByName('PriceLogo').AsString;      // – лого прайслиста
        part.Quantity        := FQuery.FieldByName('Quantity').AsInteger;      // – количество
        part.bitOnly         := False; // – признак ТОЛЬКО ЭТОТ НОМЕР
        part.bitQuantity     := False; // – признак ТОЛЬКО ЭТО КОЛИЧЕСТВО
        part.bitWait         := False; // – признак СОГЛАСЕН ЖДАТЬ 1 месяц
        part.CustomerSubId   := FQuery.FieldByName('CustomerSubID').Value;  // – идентификатор запчасти клиента
        part.TransportPack   := '';    // – тип упаковки (WOOD – требуется деревянная обрешетка, CARTON := '' – отправка в картонной коробке)
        part.DetailWeight    := FQuery.FieldByName('WeightKG').Value; //  – вес детали в кг
        part.EmExWeight      := FQuery.FieldByName('WeightKG').Value; //  – последнее изменение веса датали, сделанное  на нашем складе
        part.DestinationLogo := FQuery.FieldByName('DestinationLogo').AsString; // – тип отгрузки (EMEW – авиа, CNTE – контейнер)
        part.CustomerStickerData:= '';

        InBasket[0]:= part;

        logger.Info('Emex.InsertPartToBasket_v2 Begin');

        OutBasket:=Emex.InsertPartToBasket_v2(getCustomer( FQuery.FieldByName('SuppliersID').AsInteger ), InBasket,  FUrl);

        if OutBasket[0].BasketId > 0 then
        begin
          Result := OutBasket[0].BasketId;

          FSQL.exec('''
            Update tOrders
               set Warning = :Warning
                  ,BasketId= :BasketId
             where OrderID = :OrderID
          ''',
          ['OrderID',
           'Warning',
           'BasketId'],
          [AOrderID,
           OutBasket[0].WarnText,
           Result]);

          logger.Info('Emex.InsertPartToBasket_v2 End');
          SetLength(InBasket, 0);
        end;

        FreeAndNil(part);
      end;
    end;

    logger.Info('TEmex.InsertPartToBasketByMarks End');
end;

function TEmex.InsertPartToBasketByMarks: integer;
var part: partstobasket;
    outBasket: ArrayOfPartstobasket;
    I, RCount, r:  Integer;

  Suppliers : TStringList;
    Supplier: string;
begin
    logger.Info('TEmex.InsertPartToBasketByMarks Begin');
    R :=0;

    // Получаем список поставщиков
    Suppliers := ForSupplierByMarks ();

    // Цикл по поставщикам
    for Supplier in Suppliers do
    begin
      logger.Info('TEmex.InsertPartToBasketByMarks Supplier:' + Supplier);
      FQuery.Close;
      FQuery.SQL.Text:='''
        Select distinct *
          from vInsertPartToBasketByPart p
         where SuppliersID=:SuppliersID
      ''';
      FQuery.ParamByName('SuppliersID').AsInteger := Supplier.ToInteger;
      FQuery.Open;

      RCount := FQuery.RecordCount;
      if RCount > 0 then
      begin
        FQuery.First;
        logger.Info('TEmex.InsertPartToBasketByMarks RecordCount ' + FQuery.RecordCount.ToString);

        for I := 0 to FQuery.RecordCount - 1 do
        begin
          SetLength(outBasket, i+1);

          part := partstobasket.Create;
          // – Текстовая информация, позволяющая клиенту идентифицировать запчасть. Часть этой информации может быть распечатана в виде штрих-кода на стикере запчасти
          part.Reference       := FQuery.FieldByName('Reference').AsString;
          part.CoeffMaxAgree   := FSQL.GetSetting('CoeffMaxAgree', 1.1);    //максимальный коэффициент превышения цены продажи для клиента над ценой, показанной на сайте (по умолчанию 1.1)
          part.UploadedPrice   := FQuery.FieldByName('PricePurchase').Value;  //цена, заданная клиентом
          part.Confirm         := True;  // – признак, что строчка корзины будет включена в заказ (необходимо задать 1)
          part.Delete          := False; // – признак, что строчка корзины будет удалена (необходимо задать 0)
          part.bitAgree        := False; // – признак что клиент согласен на превышение цены свыше коэффициента CoeffMaxAgree
          part.OnlyThisBrand   := FQuery.FieldByName('OnlyThisBrand').asBoolean; // – признак ТОЛЬКО ЭТОТ БРЕНД
          part.MakeLogo        := FQuery.FieldByName('MakeLogo').AsString;;   // – лого бренда
          part.DetailNum       := FQuery.FieldByName('DetailNumber').AsString;// – номер детали
          part.PriceLogo       := FQuery.FieldByName('PriceLogo').AsString;   // – лого прайслиста
          part.Quantity        := FQuery.FieldByName('Quantity').Value;       // – количество
          part.bitOnly         := False; // – признак ТОЛЬКО ЭТОТ НОМЕР
          part.bitQuantity     := False; // – признак ТОЛЬКО ЭТО КОЛИЧЕСТВО
          part.bitWait         := False; // – признак СОГЛАСЕН ЖДАТЬ 1 месяц
          part.CustomerSubId   := FQuery.FieldByName('CustomerSubID').Value;  // – идентификатор запчасти клиента
          part.TransportPack   := '';   // – тип упаковки (WOOD – требуется деревянная обрешетка, CARTON := '' – отправка в картонной коробке)
          part.DetailWeight    := FQuery.FieldByName('WeightKG').Value; //  – вес детали в кг
          part.EmExWeight      := FQuery.FieldByName('WeightKG').Value; //  – последнее изменение веса датали, сделанное  на нашем складе
          part.DestinationLogo := FQuery.FieldByName('DestinationLogo').AsString; // – тип отгрузки (EMEW – авиа, CNTE – контейнер)
          part.CustomerStickerData:= '';

          outBasket[i]:= part;

          logger.Info('Emex.InsertPartToBasket Begin');
          R:=Emex.InsertPartToBasket(getCustomer(Supplier.ToInteger), outBasket);

          if R > 0 then
          begin
            FSQL.exec('''
              -- обработанные детали
              if OBJECT_ID('tempdb..#ProcessedRecords') is not null
              Update #ProcessedRecords
                 set Processed = :Processed,
                     Total     = :Total
            ''', ['Processed', 'Total'], [i+1,  FQuery.RecordCount]);

            logger.Info('Emex.InsertPartToBasket End');
            SetLength(outBasket, 0);
          end;

          Result:=Result+R;

          FQuery.Next;
        end;

        FreeAndNil(part);
      end;
    end;

    FreeAndNil(Suppliers);

    Result := R;
    logger.Info('TEmex.InsertPartToBasketByMarks End');
end;

procedure TEmex.InsertPartToBasketRollbackByMarks;
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    OrderID: Integer;
    I, RCount, R: Integer;
    dat: TXSDateTime;
begin
  logger.Info('TEmex.InsertPartToBasketRollbackByMarks Begin');
  try

    FQuery.Close;
    FQuery.Open('Select o.OrderID,  o.BasketId, o.ClientID '+
             '  from pAccrualAction p (nolock)'+
             ' inner join tOrders o (nolock)  '+
             '         on o.OrderID=p.ObjectID'+
             '        and isnull(o.BasketId, 0) <> 0'+
             ' where p.Spid   = @@spid        '+
             '   and p.Retval = 0             ', [], []);
    FQuery.Open;
    RCount := FQuery.RecordCount;

    if RCount > 0 then
    begin

      OrderID:=FQuery.FieldByName('OrderID').Value;

      SetLength(outBasket, 1);

      dat := TXSDateTime.Create;
      part:= BasketDetails.Create;

      FQuery.First;
      for I := 0 to FQuery.RecordCount - 1 do // удаление выполняем по одному, чтобы можно было понять по какой детали получили ошибку
      begin
        part.BasketId := FQuery.FieldByName('BasketId').AsLargeInt;
        part.Date_add:= dat;


        outBasket[0]:= part;

        logger.Info('TEmex.InsertPartToBasketRollbackByMarks DeleteFromBasket: ' +  part.BasketId.ToString);

        R:=Emex.DeleteFromBasket(getCustomerByClient(FQuery.FieldByName('ClientID').AsInteger), outBasket);

        if R = 1 then
        begin
          FSQL.exec('''
            -- обработанные детали
            if OBJECT_ID('tempdb..#ProcessedRecords') is not null
            Update #ProcessedRecords
               set Processed = :Processed,
                   Total     = :Total
          ''', ['Processed', 'Total'], [i+1,  FQuery.RecordCount]);
        end
        else
        begin
          logger.Info('TEmex.InsertPartToBasketRollbackByMarks 505 Количество удаленных товаров: ' +  R.ToString);
          logger.Info('TEmex.InsertPartToBasketRollbackByMarks 505 Ошибка удаления товара из корзины, требуется ручная проверка! [OrderID: ' + OrderID.ToString + ']');
        end;

        FQuery.Next;
      end;

      part.Destroy;

    end;
  except
    on E: Exception do
    begin

      if Assigned(part) then part.Destroy;

      logger.Info('TEmex.InsertPartToBasketRollbackByMarks error: ' + e.Message);

      FSQL.Exec('Update pAccrualAction set retval = 506, Message =:Message where spid = @@spid and ObjectID=:OrderID',
              ['OrderID','Message'],[OrderID, e.Message]);

      FSQL.Exec('Update pAccrualAction set retval = 506, Message =:Message where spid = @@spid and ObjectID<>:OrderID',
              ['OrderID','Message'],[OrderID, '']);
    end;
  end;

  logger.Info('TEmex.InsertPartToBasketRollbackByMarks End');
end;

procedure TEmex.InsertPartToBasketCancelByMarks;
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    I, RCount, R: Integer;
    dat: TXSDateTime;
begin
  logger.Info('TEmex.InsertPartToBasketCancelByMarks Begin');
  try

    FQuery.Close;
    FQuery.Open('''
              Select distinct
                     BasketId,
                     SupplierID
                from pBasketDetails (nolock)
               where Spid   = @@spid
                 and isnull(OrderID, 0) = 0
                 and isnull(BasketId, 0)> 0
             ''', [], []);
    FQuery.Open;

    RCount := FQuery.RecordCount;
    if RCount > 0 then
    begin
      SetLength(outBasket, 1);

      dat := TXSDateTime.Create;
      part:= BasketDetails.Create;

      FQuery.First;
      for I := 0 to FQuery.RecordCount - 1 do // удаление выполняем по одному, чтобы можно было понять по какой детали получили ошибку
      begin
        part.BasketId := FQuery.FieldByName('BasketId').AsLargeInt;
        part.Date_add:= dat;

        outBasket[0]:= part;

        logger.Info('TEmex.InsertPartToBasketCancelByMarksInsertPartToBasketCancel DeleteFromBasket: ' + part.BasketId.ToString);

        R:=Emex.DeleteFromBasket(getCustomer(FQuery.FieldByName('SupplierID').AsInteger), outBasket);

        if R <> 1 then
        begin
          logger.Info('TEmex.InsertPartToBasketCancelByMarks Количество удаленных товаров: ' +  R.ToString);
        end;

        FQuery.Next;
      end;
      part.Destroy;
    end;

  except
    on E: Exception do
    begin
      if Assigned(part) then part.Destroy;

      logger.Info('TEmex.InsertPartToBasketCancelByMarks Error: ' + e.Message);
    end;
  end;

  logger.Info('TEmex.InsertPartToBasketCancelByMarks End');
end;

function TEmex.Login(AAccount: Integer): String;
var c: Customer;
begin
  Result:='';
  try
    c:=Emex.Login(getCustomer(AAccount));
    Result := c.ToString;
    c.Destroy;
  except
    on E: Exception do
    begin
      Result := 'Ошибка авторизации. Клиент [' + AAccount.ToString + ']' + #13#10 +
                E.Message;
    end;
  end;
end;

procedure TEmex.FillBasketDetails(ABasket: ArrayOfBasketDetails_v2; ASupplier: Integer = 0);
var I: Integer;
begin
  for I := 0 to Length(ABasket)-1 do
    begin
      FillBasketDetails(ABasket[i], ASupplier);
    end;
end;


procedure TEmex.FillBasketDetails(ABasket: BasketDetails_v2; ASupplier: Integer);
begin
  FSQL.Exec('''
      insert into pBasketDetails with (rowlock)
            (Spid, BasketId, MakeLogo, DetailNum, PriceLogo, Price, Quantity, Comments, DetailWeight, EmExWeight, DestinationLogo, UploadedPrice, CoeffMaxAgree, CustomerSubId, Reference, SupplierID
            ,WarnCode
            ,WarnText
            ,AvailableQuantity
             )
      select @@spid, :BasketId,:MakeLogo,:DetailNum,:PriceLogo,:Price, :Quantity, :Comments, :DetailWeight, :EmExWeight, :DestinationLogo, :UploadedPrice, :CoeffMaxAgree, :CustomerSubId, :Reference, :SupplierID
            ,:WarnCode
            ,:WarnText
            ,:AvailableQuantity
     ''',
     ['BasketId','MakeLogo','DetailNum','PriceLogo','Price','Quantity',
     'Comments', 'DetailWeight', 'EmExWeight', 'DestinationLogo',
     'UploadedPrice', 'CoeffMaxAgree', 'CustomerSubId', 'Reference',
     'SupplierID'
     ,'WarnCode'
     ,'WarnText'
     ,'AvailableQuantity'],
     [ABasket.BasketId,
      ABasket.MakeLogo,
      ABasket.DetailNum,
      ABasket.PriceLogo,
      ABasket.Price,
      ABasket.Quantity,
      ABasket.Comments,
      ABasket.DetailWeight,
      ABasket.EmExWeight,
      ABasket.DestinationLogo,
      ABasket.UploadedPrice,
      ABasket.CoeffMaxAgree,
      ABasket.CustomerSubId,
      ABasket.Reference,
      ASupplier,
      ABasket.WarnCode,
      ABasket.WarnText,
      ABasket.AvailableQuantity]
     );
end;

procedure TEmex.FillFindByNumber(APparts: ArrayOfFindByNumber; AClientID: LongInt = 0);
var I: Integer;
begin
  FSQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  for I := 0 to Length(APparts)-1 do
  begin
    FSQL.Exec('''
                exec FindByNumberInsert
                      @ClientID           = :ClientID
                     ,@Available          = :Available
                     ,@bitOldNum          = :bitOldNum
                     ,@PercentSupped      = :PercentSupped
                     ,@PriceId            = :PriceId
                     ,@Region             = :Region
                     ,@Delivery           = :Delivery
                     ,@Make               = :Make
                     ,@DetailNum          = :DetailNum
                     ,@PriceLogo          = :PriceLogo
                     ,@Price              = :Price
                     ,@PartNameRus        = :PartNameRus
                     ,@PartNameEng        = :PartNameEng
                     ,@WeightGr           = :WeightGr
                     ,@MakeName           = :MakeName
                     ,@Packing            = :Packing
                     ,@bitECO             = :bitECO
                     ,@bitWeightMeasured  = :bitWeightMeasured
                     ,@VolumeAdd          = :VolumeAdd
                     ,@GuaranteedDay      = :GuaranteedDay
              ''',
             ['ClientID',
              'Available',
              'bitOldNum',
              'PercentSupped',
              'PriceId',
              'Region',
              'Delivery',
              'Make',
              'DetailNum',
              'PriceLogo',
              'Price',
              'PartNameRus',
              'PartNameEng',
              'WeightGr',
              'MakeName',
              'Packing',
              'VolumeAdd',
              'GuaranteedDay',
              'bitECO',
              'bitWeightMeasured'],

             [AClientID,
              APparts[i].Available,
              APparts[i].bitOldNum,
              APparts[i].PercentSupped,
              APparts[i].PriceId,
              APparts[i].Region,
              APparts[i].Delivery,
              APparts[i].Make,
              APparts[i].DetailNum,
              APparts[i].PriceLogo,
              APparts[i].Price,
              APparts[i].PartNameRus,
              APparts[i].PartNameEng,
              APparts[i].WeightGr,
              APparts[i].MakeName,
              APparts[i].Packing,
              APparts[i].VolumeAdd,
              APparts[i].GuaranteedDay,
              APparts[i].bitECO,
              APparts[i].bitWeightMeasured
              ]);
  end;
end;

procedure TEmex.FillMovement(AParts: ArrayOfMovement);
var part: Movement;
       I: Integer;
begin
  for I := 0 to Length(Aparts)-1 do
  begin
    part:= Movement.Create;
    part :=  Aparts[i];

    if part = nil then Exit;

    FSQL.Exec( 'insert into pMovement'+
              '       (Spid,    OrderNumber, Comment, OrderDetailSubId, DocumentDate, PriceOrdered, PriceSale, MakeLogo, DetailNum, Quantity, Condition, Reference, DetailNameRus,  DetailNameEng,  CustomerSubId,   DestinationLogo,  PriceLogo,  StatusId,  StateText, '+
                      ' ReplacementMakeLogo, ReplacementDetailNumber) '+
              ' select @@spid, :OrderNumber,:Comment,:OrderDetailSubId,:DocumentDate,:PriceOrdered,:PriceSale,:MakeLogo,:DetailNum,:Quantity,:Condition,:Reference,:DetailNameRus, :DetailNameEng, :CustomerSubId,  :DestinationLogo, :PriceLogo, :StatusId, :StateText,'+
              '        :ReplacementMakeLogo, :ReplacementDetailNumber ',
             ['OrderNumber','Comment','OrderDetailSubId','DocumentDate','PriceOrdered','PriceSale', 'MakeLogo', 'DetailNum', 'Quantity', 'Condition', 'Reference', 'DetailNameRus','DetailNameEng','CustomerSubId', 'DestinationLogo','PriceLogo','StatusId','StateText', 'ReplacementMakeLogo', 'ReplacementDetailNumber'],
             [part.OrderNumber,
              part.Comment,
              part.OrderDetailSubId,
              part.DocumentDate.AsUTCDateTime,
              part.PriceOrdered,
              part.PriceSale,
              part.Make,
              part.DetailNum,
              part.Quantity,
              part.Condition,
              part.Reference,
              part.DetailNameRus,
              part.DetailNameEng,
              part.CustomerSubId,
              part.DestinationLogo,
              part.PriceLogo,
              part.StatusId,
              part.StateText,
              part.SubstMake,
              part.SubstNum
              ]);

    freeandnil(part);
  end;
end;

procedure TEmex.FindByDetailNumber(AClientID:LongInt; ADetailNum: string);
var parts: ArrayOfFindByNumber;
begin
  logger.Info('TEmex.MovementByOrderNumber Begin');
  logger.Info('TEmex.AClientID: '  + AClientID.ToString);
  logger.Info('TEmex.ADetailNum: ' + ADetailNum);

  parts:=Emex.SearchPart(getCustomerByClient(AClientID), ADetailNum, False);

  FillFindByNumber(parts, AClientID);

  logger.Info('TEmex.MovementByOrderNumber End');
end;

procedure TEmex.MovementByOrderNumber(ASupplierID: Integer; AEmexOrderID: integer);
var parts: ArrayOfMovement;
begin
  logger.Info('TEmex.MovementByOrderNumber Begin');
  logger.Info('TEmex.MovementByOrderNumber ASupplierID: ' + ASupplierID.ToString);
  logger.Info('TEmex.MovementByOrderNumber EmexOrderID: ' + AEmexOrderID.ToString);

  parts:=Emex.MovementByOrderNumber(getCustomer(ASupplierID), AEmexOrderID);

  FillMovement(parts);

  logger.Info('TEmex.MovementByOrderNumber End');
end;

procedure TEmex.MovementInWorkByMarks;
var parts : ArrayOfMovement;
 Suppliers: TStringList;
  Supplier: string;
begin
  logger.Info('TEmex.MovementInWorkByMarks Begin');
  {
  TProcExec.EmexCreateOrderCheck -> ...

  MovementInWorkByMarks -> ServiceSoap.MovementInWork
  }
  FSQL.Exec('delete pMovement from pMovement (rowlock) where spid = @@spid', [],[]);

  // Получаем список поставщиков
  Suppliers := ForSupplierByMarks();

  for Supplier in Suppliers do
  begin
    parts:=Emex.MovementInWork(getCustomer(Supplier.ToInteger));
    FillMovement(parts);
  end;

  FreeAndNil(Suppliers);

  logger.Info('TEmex.MovementInWorkByMarks Begin');
end;

procedure TEmex.OrderStateSyncByOrderNum;
var Clients: TStringList;
     Client: String;
      Order: Integer;
          I: Integer;
begin
  logger.Info('TEmex.OrderStateSyncByOrderNum Begin');
  {
    данная процедура вызывается
    при синхронизации статусов из автоматического задания

    список клиентов (профилей) определяется из pAccrualAction
  }
  Clients := ForClients();

  if Clients.Count = 0 then
     logger.Info('TEmex.OrderStateSyncByOrderNum Нет данных для синхронизации статусов!');

  // Цикл по клиентам
  for Client in Clients do
  begin
    logger.Info('TEmex.OrderStateSyncByOrderNum Клиент:' + Client);

    FQuery.Close;
    FQuery.SQL.Text := '''
     Select distinct EmexOrderID, SuppliersID
       from vOrderStateSyncByOrderNum
      where ClientID = :CID
    ''';

    FQuery.ParamByName('CID').AsInteger := Client.ToInteger;
    FQuery.open;

    FQuery.First;
    for I := 0 to FQuery.RecordCount-1 do
    begin
      Order :=  FQuery.FieldByName('EmexOrderID').AsInteger;
      logger.Info('TEmex.OrderStateSyncByOrderNum Номер заказа Emex: ' + Order.ToString);

      FSQL.Exec('delete pMovement from pMovement (rowlock) where spid = @@spid', [],[]);

      MovementByOrderNumber(FQuery.FieldByName('SuppliersID').AsInteger, Order);

      FSQL.Exec(' exec EmexOrderStateSync select 0 ', [],[]);

      FQuery.Next;
    end;
    FQuery.Close;
  end;

  FreeAndNil(Clients);

  logger.Info('TEmex.OrderStateSyncByOrderNum End');
end;

procedure TEmex.GetBasketDetailsByMarks;
var Basket : ArrayOfBasketDetails_v2;
    part   : BasketDetails;

  Suppliers: TStringList;
   Supplier: string;
begin
  logger.Info('TEmex.GetBasketDetailsByMarks Begin');

  // Получаем список поставщиков/личный кабинет emex
  Suppliers := ForSupplierByMarks();
  try
    FSQL.Exec('Delete pBasketDetails from pBasketDetails (rowlock) where spid = @@spid', [], []);
    for Supplier in Suppliers do
    begin
      Basket:=Emex.GetBasketDetails_v2(getCustomer(Supplier.ToInteger), FLang);
      FillBasketDetails(Basket, Supplier.ToInteger);
    end;
  finally
    freeandnil(Suppliers);
  end;

  logger.Info('TEmex.GetBasketDetailsByMarks End');
end;

Function TEmex.GetBasketDetailsBySuppliersID(ASuppliersID: Integer):ArrayOfBasketDetails_v2;
begin
  logger.Info('TEmex.GetBasketDetailsBySuppliersID Begin');

  Result:=Emex.GetBasketDetails_v2(getCustomer(ASuppliersID), FLang);

  logger.Info('TEmex.GetBasketDetailsBySuppliersID End');
end;

function TEmex.TestConnect: string;
begin
  result := Emex.TEST;
end;
//
//function TEmex.UpdateBasketDetails(Apart: BasketDetails; ASupplier: Integer):string;
//var inBasket: ArrayOfBasketDetails;
//    outBasket: ArrayOfBasketChangeResult;
//begin
//  logger.Info('TEmex.UpdateBasketDetails Begin');
//
//  SetLength(inBasket, 1);
//
//  inBasket[0]:= Apart;
//
//  logger.Info('Emex.UpdateBasketDetails_v2 Begin');
//  outBasket:=Emex.UpdateBasketDetails_v2(getCustomer(ASupplier), inBasket, FLang);
//
//  logger.Info('Emex.UpdateBasketDetails_v2 result');
//  logger.Info(outBasket[0].BasketId.ToString);
//  logger.Info(outBasket[0].WarnText);
//
//  Result:= outBasket[0].WarnText;
//
//  logger.Info('TEmex.UpdateBasketDetails End');
//end;

end.
