unit uEmexUtils;
{
                            Интеграция с Emex api
}
interface

uses System.SysUtils, System.Classes, //Vcl.Dialogs, //System.Variants,

     FireDAC.Comp.Client, FireDAC.Comp.Script,

     uCommonType,

     uEmexService, Soap.XSBuiltIns, uSqlUtils;

  Type
  /// <summary>
  /// TEmex класс интеграции с Emex api
  /// </summary>
  TEmex= class
    private
      FConnection: TFDConnection;
     // FCustomer: Customer;
      FQuery: TFDQuery;
      FEmex:ServiceSoap;
      FSQl: TSQL;

      function GetConnection: TFDConnection;
      procedure SetConnection(const Value: TFDConnection);

      function GetQry: TFDQuery;
      procedure SetQry(const Value: TFDQuery);
      function GetEmex: ServiceSoap;
      procedure SetSQl(const Value: TSQL);
      function GetSQl: TSQL;

      function ForClients: TStringList;

      /// <summary>
      /// FillFindByNumber - Вспомогательная процедура для заполнения pFindByNumber
      /// </summary>
      procedure FillFindByNumber(AClientID:LongInt; APparts: ArrayOfFindByNumber);
      property Emex: ServiceSoap read GetEmex;
    public
      property Connection: TFDConnection read GetConnection write SetConnection;
      property Qry: TFDQuery read GetQry write SetQry;

      property SQl: TSQL read GetSQl write SetSQl;

      /// <summary>
      /// TestConnect - тестовый метод для проверки работоспособности сервисов emex.
      /// </summary>
      /// <returns>Возвращает тестовую стоку с текущим временем</returns>
      function TestConnect(): string;

      /// <summary>
      /// getCustomer - описание клиента. Подготовка авторизационных данных (пользователь, пароль)
      /// </summary>
      /// <returns> объект Customer</returns>
      function getCustomer(AAccount: Integer): Customer;

      /// <summary>Login - Авторизация </summary>
      function Login(AAccount: Integer): String;

      /// <summary>FindByDetailNumber - поиск детали по номеру </summary>
      procedure FindByDetailNumber(AClientID:LongInt; ADetailNum:string);
  end;

implementation

uses
  uLogger;


{ TEmex }

function TEmex.ForClients: TStringList;
var i: Integer;
begin
    result := TStringList.Create;
    Qry.Close;
    Qry.Open('Select distinct o.ClientID '+
             '  from pAccrualAction p (nolock)'+
             ' inner join tOrders o (nolock) on o.OrderID=p.ObjectID'+
             ' where p.Spid = @@spid and p.Retval = 0  ', [], []);
    Qry.First;
    for I := 0 to qry.RecordCount - 1 do
    begin
      result.Add(qry.FieldByName('ClientID').AsString);
      Qry.Next;
    end;
end;

function TEmex.GetConnection: TFDConnection;
begin
  Result:= FConnection;
end;

function TEmex.getCustomer(AAccount: Integer): Customer;
var SuppliersID: Integer;
begin
  logger.Info('TEmex.getCustomer begin');
  logger.Info('TEmex.getCustomer AAccount: ' + AAccount.ToString);
  begin
    SuppliersID := Sql.GetSetting('SearchSuppliers', 0);

    if SuppliersID = 0 then
    begin
      //данные для интеграции берем из справочника "Клиенты"
      SQl.Open('Select s.emexUsername, s.emexPassword '+
               '  from tClients c (nolock)            ' +
               '  join tSuppliers  s (nolock)         ' +
               '    on s.SuppliersID = c.SuppliersID  ' +
               ' where c.ClientID = :ClientID',
              ['ClientID'], [AAccount]);
    end
    else
    begin
      //данные для интеграции берем из настройки SearchSuppliers
      SQl.Open('Select s.emexUsername, s.emexPassword '+
               '  from tSuppliers  s (nolock)         ' +
               ' where s.SuppliersID = :SuppliersID  ',
              ['SuppliersID'], [SuppliersID]);
    end;

    result := Customer.Create;
    result.UserName      := SQl.Q.FieldByName('emexUsername').AsString;
    result.Password      := SQl.Q.FieldByName('emexPassword').AsString;
    result.SubCustomerId := '0';
    result.CustomerId    := '0';
  end;
  logger.Info('TEmex.getCustomer end');
end;

function TEmex.GetEmex: ServiceSoap;
begin
  result:= GetServiceSoap();; //FEmex;
end;

function TEmex.GetQry: TFDQuery;
begin
  if not assigned(FQuery) then
  begin
    FQuery:= TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
  end;

  if not assigned(FQuery.Connection) then
  begin
    FQuery.Connection := FConnection;
  end;

  result:= FQuery;
end;

function TEmex.GetSQl: TSQL;
begin
  if not Assigned(FSQl) then
    FSQl:=TSQl.Create(FConnection);

  Result :=FSQl;
end;

procedure TEmex.SetConnection(const Value: TFDConnection);
begin
  if Assigned(Value) then FConnection:= Value;
end;


procedure TEmex.SetQry(const Value: TFDQuery);
begin
  if Assigned(Value) then FQuery:= Value;
end;

procedure TEmex.SetSQl(const Value: TSQL);
begin
  if Assigned(Value) then FSQl := Value;
end;

function TEmex.TestConnect: string;
begin
  result := Emex.TEST;
end;

function TEmex.Login(AAccount: Integer): String;
var c: Customer;
begin
  Result:='';
  try
    Emex.Login(getCustomer(AAccount));
    Result := c.ToString;

  except
    on E: Exception do
    begin
      Result := 'Ошибка авторизации. Клиент [' + AAccount.ToString + ']' + #13#10 +
                E.Message;
    end;
  end;
end;

procedure TEmex.FindByDetailNumber(AClientID:LongInt; ADetailNum:string);
var part: FindByNumber;
   parts: ArrayOfFindByNumber;
       I: Integer;
 ShowSubsts: Boolean;
begin
//  logger.Info('TEmex.MovementByOrderNumber Begin');
  // Показывать аналоги в поиске
  ShowSubsts := SQl.GetSetting('ShowSubsts', false);

  parts:=Emex.SearchPart(getCustomer(AClientID), ADetailNum, ShowSubsts);

  FillFindByNumber(AClientID, parts);

  //logger.Info('TEmex.MovementByOrderNumber End');
end;

procedure TEmex.FillFindByNumber(AClientID: LongInt; APparts: ArrayOfFindByNumber);
var part: FindByNumber;
    I: Integer;
begin
  SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  for I := 0 to Length(APparts)-1 do
  begin
    part:= FindByNumber.Create;
    part :=  APparts[i];

    SQl.Exec( 'exec FindByNumberInsert'+
              '  @ClientID           = :ClientID     '+
              ' ,@Available          = :Available    '+
              ' ,@bitOldNum          = :bitOldNum    '+
              ' ,@PercentSupped      = :PercentSupped'+
              ' ,@PriceId            = :PriceId      '+
              ' ,@Region             = :Region       '+
              ' ,@Delivery           = :Delivery     '+
              ' ,@Make               = :Make         '+
              ' ,@DetailNum          = :DetailNum    '+
              ' ,@PriceLogo          = :PriceLogo    '+
              ' ,@Price              = :Price        '+
              ' ,@PartNameRus        = :PartNameRus  '+
              ' ,@PartNameEng        = :PartNameEng  '+
              ' ,@WeightGr           = :WeightGr     '+
              ' ,@MakeName           = :MakeName     '+
              ' ,@Packing            = :Packing      '+
              ' ,@bitECO             = :bitECO       '+
              ' ,@bitWeightMeasured  = :bitWeightMeasured '+
              ' ,@VolumeAdd          = :VolumeAdd         '+
              ' ,@GuaranteedDay      = :GuaranteedDay     ',
             ['ClientID', 'Available','bitOldNum','PercentSupped','PriceId','Region','Delivery', 'Make', 'DetailNum', 'PriceLogo', 'Price', 'PartNameRus', 'PartNameEng','WeightGr','MakeName', 'Packing','VolumeAdd','GuaranteedDay', 'bitECO', 'bitWeightMeasured'],
             [AClientID,
              part.Available,
              part.bitOldNum,
              part.PercentSupped,
              part.PriceId,
              part.Region,
              part.Delivery,
              part.Make,
              part.DetailNum,
              part.PriceLogo,
              part.Price,
              part.PartNameRus,
              part.PartNameEng,
              part.WeightGr,
              part.MakeName,
              part.Packing,
              part.VolumeAdd,
              part.GuaranteedDay,
              part.bitECO,
              part.bitWeightMeasured
              ]);

    freeandnil(part);
  end;
end;


end.
