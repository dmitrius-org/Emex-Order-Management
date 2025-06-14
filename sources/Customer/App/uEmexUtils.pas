﻿unit uEmexUtils;
{
                            Интеграция с Emex api
}
interface

uses System.SysUtils, System.Classes, //Vcl.Dialogs, //System.Variants,

     FireDAC.Comp.Client, FireDAC.Comp.Script,

     uCommonType,

     uServiceEmex, Soap.XSBuiltIns, uSqlUtils;

  Type
  /// <summary>
  /// TEmex класс интеграции с Emex api
  /// </summary>
  TEmex= class
    private
      FConnection: TFDConnection;

      FSQl: TSQL;
      FQuery: TFDQuery;

      FLang:string;
      FUrl:string;

      function GetEmex: ServiceSoap;
      function GetSQl: TSQL;

      /// <summary>
      /// FillFindByNumber - Вспомогательная процедура для заполнения pFindByNumber
      /// </summary>
      procedure FillFindByNumber(AClientID:LongInt; APparts: ArrayOfFindByNumber);
    public
      constructor Create(Value: TFDConnection); overload;
      destructor Destroy; override;

      property Emex: ServiceSoap read GetEmex;

      property SQl: TSQL read GetSQl;

      /// <summary>
      /// TestConnect - тестовый метод для проверки работоспособности сервисов emex.
      /// </summary>
      /// <returns>Возвращает тестовую стоку с текущим временем</returns>
      function TestConnect(): string;

      /// <summary>
      /// getCustomer - описание клиента. Подготовка авторизационных данных (пользователь, пароль)
      /// </summary>
      /// <returns> объект Customer</returns>
      function getCustomer(ASupplierID: Integer): Customer;

      /// <summary>Login - Авторизация </summary>
      function Login(AAccount: Integer): String;

      /// <summary>FindByDetailNumber - поиск детали по номеру</summary>
      procedure FindByDetailNumber(AClientID:LongInt; ASupplierID:LongInt; ADetailNum:string);
  end;

implementation


{ TEmex }
constructor TEmex.Create(Value: TFDConnection);
begin
  if Assigned(Value) then
    FConnection:= Value;

  if not Assigned(FSQl) then
    FSQl:=TSQl.Create(FConnection);

  if not assigned(FQuery) then
  begin
    FQuery:= TFDQuery.Create(nil);
    FQuery.FetchOptions.RowsetSize := 1000000;
    FQuery.Connection := FConnection;
  end;

  // Код языка, на котором будут возвращаться сообщения об ошибках - EN (по умолчанию) или RU
  FLang := FSQl.GetSetting('EmexServiceSoapLang', 'EN');

  FUrl := FSQl.GetSetting('EmexServiceSoapUrl');

  if Trim(FUrl) = '' then
  begin
    raise Exception.Create('Незадан адрес Emex Service Soap! (EmexServiceSoapUrl)');
  end;
end;

function TEmex.getCustomer(ASupplierID: Integer): Customer;
begin
  begin
      //данные для интеграции берем из справочника "Клиенты"
    SQl.Open('''
             Select s.emexUsername, s.emexPassword
               from tSuppliers  s with (nolock)
              where s.SuppliersID = :SuppliersID
    ''',
    ['SuppliersID'], [ASupplierID]);

    result := Customer.Create;
    result.UserName      := SQl.Q.FieldByName('emexUsername').AsString;
    result.Password      := SQl.Q.FieldByName('emexPassword').AsString;
    result.SubCustomerId := '0';
    result.CustomerId    := '0';
  end;
end;

function TEmex.GetEmex: ServiceSoap;
begin
  result:= GetServiceSoap(false, FUrl);
end;

function TEmex.GetSQl: TSQL;
begin
  Result :=FSQl;
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
    c:=Emex.Login(getCustomer(AAccount));
    Result := c.ToString;
    c.Destroy;
  except
    on E: Exception do
    begin
      Result := 'Ошибка авторизации. Клиент [' + AAccount.ToString + ']' + #13#10 + E.Message;
    end;
  end;
end;

procedure TEmex.FindByDetailNumber(AClientID:LongInt; ASupplierID:LongInt; ADetailNum:string);
var   parts: ArrayOfFindByNumber;
 ShowSubsts: Boolean;
begin
  // Показывать аналоги в поиске
  ShowSubsts := SQl.GetSetting('ShowSubsts', false);

  parts:=Emex.SearchPart(getCustomer(ASupplierID), ADetailNum, ShowSubsts);

  FillFindByNumber(AClientID, parts);
end;

destructor TEmex.Destroy;
begin
  inherited;

  FreeAndNil(FQuery);
  FreeAndNil(FSQl);
end;

procedure TEmex.FillFindByNumber(AClientID: LongInt; APparts: ArrayOfFindByNumber);
var part: FindByNumber;
    I: Integer;
begin
  for I := 0 to Length(APparts)-1 do
  begin
    part:= FindByNumber.Create;
    part :=  APparts[i];

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

             [
              'ClientID',
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
              'bitWeightMeasured'
              ],

             [
              AClientID,
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
