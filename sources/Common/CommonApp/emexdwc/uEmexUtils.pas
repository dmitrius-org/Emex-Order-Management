unit uEmexUtils;
{
                            ���������� � Emex api
}
interface

uses System.SysUtils, System.Classes, //Vcl.Dialogs, //System.Variants,

     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Option,

     uCommonType,

     uEmexService, Soap.XSBuiltIns, uSqlUtils;

  Type
  /// <summary>
  /// TEmex ����� ���������� � Emex api
  /// </summary>
  TEmex= class
    private
      FConnection: TFDConnection;
     // FCustomer: Customer;
      FQuery: TFDQuery;
      FEmex: ServiceSoap;
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
      /// FillMovement - ��������������� ��������� ��� ���������� pMovement
      /// </summary>
      procedure FillMovement(AParts: ArrayOfMovement);
    public
      destructor Destroy; override;
      property Connection: TFDConnection read GetConnection write SetConnection;
      property Qry: TFDQuery read GetQry write SetQry;
      property Emex: ServiceSoap read GetEmex;
      property SQl: TSQL read GetSQl write SetSQl;

      /// <summary>
      /// TestConnect - �������� ����� ��� �������� ����������������� �������� emex.
      /// </summary>
      /// <returns>���������� �������� ����� � ������� ��������</returns>
      function TestConnect(): string;

      /// <summary>
      /// getCustomer - �������� �������. ���������� ��������������� ������ (������������, ������)
      /// AAccount - ������������� �������
      /// </summary>
      /// <returns> ������ Customer</returns>
      function getCustomer(AAccount: Integer): Customer;

      /// <summary>
      /// InsertPartToBasketByPart - ��������� ��������� � �������
      /// </summary>
      /// <returns> ����� �����, ����������� � �������</returns>
      function InsertPartToBasketByPart(): integer;

      /// <summary>
      /// InsertPartToBasketByPartDelete - �������� ��������� �� �������
      /// </summary>
      /// <returns>������ ����� � pAccrualAction</returns>
      procedure InsertPartToBasketByPartDelete();

      procedure InsertPartToBasketCancel();

      /// <summary>
      /// CreateOrder - �������� ������ ������� �� ������ �������.
      /// </summary>
      /// <returns> CreateOrderResult � ��� �������� ���������� ����������
      /// ������������� ����� (����� ���������� ������)
      /// ��� ������� ������������ ������������� ����� ��� 0:
      /// -1 - ������� ��������� ��������� �����
      /// -2 - ������������ ������� �� ������� �������
      /// -3 - ������ � ����� ��������
      /// -4 - ��� ������� ��� ������
      /// -0 - ���� ������
      /// </returns>
      procedure CreateOrder();

      /// <summary>OrderStateSyncByOrderNum - ������������� ������� ������ </summary>
      procedure OrderStateSyncByOrderNum();

      /// <summary>GetBasketDetails - ��������� �������.
      ///      ��������� ������� � pBasketDetails
      /// </summary>
      procedure GetBasketDetails();

      /// <summary>MovementByOrderNumber - �������� �������� �� ������ ������
      ///  ��������� ������� � pMovement
      /// </summary>
      procedure MovementByOrderNumber(AAccount: Integer; AEmexOrderID: integer);

      /// <summary>MovementInWork �������� �������� �� ������� '� ������' </summary>
      /// <returns>��������� ������� � pMovement </returns
      procedure MovementInWork();

      /// <summary>Basket�heck - �������� ������� </summary>
      /// <returns>��������� ������� � pBasketDetails </returns
      procedure Basket�heck();

      /// <summary>Login - ����������� </summary>
      function Login(AAccount: Integer): String;

      /// <summary>FindByDetailNumber - ����� ������ �� ������ </summary>
      procedure FindByDetailNumber(AClientID:LongInt; ADetailNum:string);

      /// <summary>
      /// FillFindByNumber - ��������������� ��������� ��� ���������� pFindByNumber
      /// </summary>
      procedure FillFindByNumber(APparts: ArrayOfFindByNumber);
  end;

implementation

uses
  uLogger;


{ TEmex }

procedure TEmex.Basket�heck;
begin
  logger.Info('TEmex.Basket�heck Begin');
  // �������� ������ ������� emex
  GetBasketDetails();

  Qry.Close;
  Qry.SQL.Text := ' declare @R int; exec @r = Basket�heck; select @r as retcode ';
  Qry.Open;

  logger.Info('TEmex.Basket�heck End');
end;

procedure TEmex.CreateOrder();
var Clients : TStringList;
    Client: string;
    Order:Integer;
    retval: Integer;
begin
  logger.Info('TEmex.CreateOrder Begin');

  Clients := ForClients();
  // ���� �� ��������
  for Client in Clients do
  begin
    logger.Info('TEmex.CreateOrder ������:' + Client);
    // �������� ������
    Order:=Emex.CreateOrder(getCustomer(Client.ToInteger));

    logger.Info('TEmex.CreateOrder ������ �����: ' + Order.ToString);

    if Order > 0 then
    begin
      logger.Info('TEmex.CreateOrder Order: ' + Order.ToString);
      SQl.Exec(' delete pMovement from pMovement (rowlock) where spid = @@spid ', [],[]);

      MovementByOrderNumber(Client.ToInteger, Order);

      Qry.Close;
      Qry.SQL.Text := ' EmexOrderCreateSync @EmexOrderID =:EmexOrderID ';
      Qry.ParamByName('EmexOrderID').AsInteger := Order;
      Qry.ExecSQL;
    end
    else
    begin
      logger.Info('TEmex.CreateOrder Order ERR: ' + Order.ToString);

      case Order of
        -1: retval := 507;// ������� ��������� ��������� �����!
        -2: retval := 508;// ������������ ������� �� ������� �������!
        -3: retval := 509;// ������ � ����� ��������!
        -4: retval := 510;// ��� ������� ��� ������!
      else
        retval := 511;// ����������� ������!
      end;

      Qry.Close;
      Qry.SQL.Text := ' Update p set p.Retval=:Retval     '+
                      '   from pAccrualAction p (updlock) '+
                      '  where p.spid   = @@spid '+
                      '    and p.Retval = 0';
      Qry.ParamByName('Retval').AsInteger := retval;
      Qry.ExecSQL;
    end;
  end;
  FreeAndNil(Clients);
  logger.Info('TEmex.CreateOrder End');
end;

destructor TEmex.Destroy;
begin
  FreeAndNil(FQuery);
 // FEmex.
 // FreeAndNil(FEmex);
  FreeAndNil(FSQl);

  inherited;
end;

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
//    SuppliersID := Sql.GetSetting('SearchSuppliers', 0);
//    if SuppliersID = 0 then
//    begin
//      //������ ��� ���������� ����� �� ����������� "�������"
      SQl.Open('Select s.emexUsername, s.emexPassword '+
               '  from tClients c (nolock)            ' +
               '  join tSuppliers  s (nolock)         ' +
               '    on s.SuppliersID = c.SuppliersID  ' +
               ' where c.ClientID = :ClientID',
              ['ClientID'], [AAccount]);
//    end
//    else
//    begin
//      //������ ��� ���������� ����� �� ��������� SearchSuppliers
//      SQl.Open('Select s.emexUsername, s.emexPassword '+
//               '  from tSuppliers  s (nolock)         ' +
//               ' where s.SuppliersID = :SuppliersID  ',
//              ['SuppliersID'], [SuppliersID]);
//    end;

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
  result:= GetServiceSoap();
end;

function TEmex.GetQry: TFDQuery;
begin
  if not assigned(FQuery) then
  begin
    FQuery:= TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
   // FQuery.FetchOptions.AutoFetchAll := TFDAutoFetchAll.afAll;
   // FQuery.FetchOptions.AssignedValues := [evAutoFetchAll];
    FQuery.FetchOptions.RowsetSize := 1000000;
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

function TEmex.InsertPartToBasketByPart: integer;
var part: partstobasket;
    outBasket: ArrayOfPartstobasket;
    I, RCount, r:  Integer;
    Clients: TStringList;
    Client:string;
begin
    logger.Info('TEmex.InsertPartToBasketByPart Begin');
    R :=0;

    // �������� ������ ��������
    Clients := ForClients();

    // ���� �� ��������
    for Client in Clients do
    begin
        logger.Info('TEmex.InsertPartToBasketByPart ������:' + Client);
        Qry.Close;
        Qry.SQL.Text:='Select * from vInsertPartToBasketByPart p where ClientID=:ClientID';
        Qry.ParamByName('ClientID').AsInteger := Client.ToInteger;
        Qry.Open;

        RCount := Qry.RecordCount;
        if RCount > 0 then
        begin
          Qry.First;
          logger.Info('Qry.RecordCount ' + Qry.RecordCount.ToString);
          for I := 0 to Qry.RecordCount - 1 do
          begin
            SetLength(outBasket, i+1);

            part := partstobasket.Create;
            // � ��������� ����������, ����������� ������� ���������������� ��������. ����� ���� ���������� ����� ���� ����������� � ���� �����-���� �� ������� ��������
            part.Reference       := Qry.FindField('Reference').AsString;
            part.CoeffMaxAgree   := SQl.GetSetting('CoeffMaxAgree', 1.1);  //������������ ����������� ���������� ���� ������� ��� ������� ��� �����, ���������� �� ����� (�� ��������� 1.1)
            part.UploadedPrice   := Qry.FindField('PricePurchase').Value;  //����, �������� ��������
            part.Confirm         := True;  // � �������, ��� ������� ������� ����� �������� � ����� (���������� ������ 1)
            part.Delete          := False; // � �������, ��� ������� ������� ����� ������� (���������� ������ 0)
            part.bitAgree        := False; // � ������� ��� ������ �������� �� ���������� ���� ����� ������������ CoeffMaxAgree
            part.OnlyThisBrand   := False; // � ������� ������ ���� �����
            part.MakeLogo        := Qry.FindField('MakeLogo').AsString;;    // � ���� ������
            part.DetailNum       := Qry.FindField('DetailNumber').AsString; // � ����� ������
            part.PriceLogo       := Qry.FindField('PriceLogo').AsString;    // � ���� ����������
            part.Quantity        := Qry.FindField('Quantity').Value;        //  � ����������
            part.bitOnly         := False; // � ������� ������ ���� �����
            part.bitQuantity     := False; // � ������� ������ ��� ����������
            part.bitWait         := False; // � ������� �������� ����� 1 �����
            part.CustomerSubId   := Qry.FindField('CustomerSubID').Value;  // � ������������� �������� �������
            part.TransportPack   := '';   // � ��� �������� (WOOD � ��������� ���������� ���������, CARTON := '' � �������� � ��������� �������)
            part.DetailWeight    := Qry.FindField('WeightKG').Value; //  � ��� ������ � ��
            part.EmExWeight      := Qry.FindField('WeightKG').Value; //  � ��������� ��������� ���� ������, ���������  �� ����� ������
            part.DestinationLogo := Qry.FindField('DestinationLogo').AsString; // � ��� �������� (EMEW � ����, CNTE � ���������)
            part.CustomerStickerData:= '';

            outBasket[i]:= part;

            logger.Info('I= ' + i.ToString);
            Qry.Next;
          end;


          logger.Info('Emex.InsertPartToBasket Begin');
          R:=R+Emex.InsertPartToBasket(getCustomer(Client.ToInteger), outBasket);
          logger.Info('Emex.InsertPartToBasket End');
          SetLength(outBasket, 0);

          FreeAndNil(part);
        end;
    end;

    FreeAndNil(Clients);

    Result := R;
    logger.Info('TEmex.InsertPartToBasketByPart End');
end;

procedure TEmex.InsertPartToBasketByPartDelete;
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    OrderID: Integer;
    I, RCount, R: Integer;
    dat: TXSDateTime;
begin
  logger.Info('TEmex.InsertPartToBasketByPartDelete Begin');
  try

    qry.Close;
    Qry.Open('Select o.OrderID,  o.BasketId, o.ClientID '+
             '  from pAccrualAction p (nolock)'+
             ' inner join tOrders o (nolock)  '+
             '         on o.OrderID=p.ObjectID and isnull(o.BasketId, 0) <> 0'+
             ' where p.Spid   = @@spid        '+
             '   and p.Retval = 0             ', [], []);
    qry.Open;
    RCount := qry.RecordCount;

    if RCount > 0 then
    begin

      OrderID:=Qry.FieldByName('OrderID').Value;

      SetLength(outBasket, 1);

      dat := TXSDateTime.Create;
      part:= BasketDetails.Create;

      qry.First;
      for I := 0 to qry.RecordCount - 1 do // �������� ��������� �� ������, ����� ����� ���� ������ �� ����� ������ �������� ������
      begin
        part.BasketId := Qry.FieldByName('BasketId').AsLargeInt;
        part.Date_add:= dat;


        outBasket[0]:= part;

        logger.Info('TEmex.InsertPartToBasketByPartDelete DeleteFromBasket: ' +  part.BasketId.ToString);

        R:=Emex.DeleteFromBasket(getCustomer(Qry.FieldByName('ClientID').AsInteger), outBasket);

        if R <> 1 then
        begin
          logger.Info('TEmex.InsertPartToBasketByPartDelete 505 ���������� ��������� �������: ' +  R.ToString);
          logger.Info('TEmex.InsertPartToBasketByPartDelete 505 ������ �������� ������ �� �������, ��������� ������ ��������! [OrderID: ' + OrderID.ToString + ']');
         // tsql.Exec('Update pAccrualAction set retval = 505 where spid = @@spid and ObjectID=:OrderID',['OrderID'],[OrderID]);
        end;

        qry.Next;
      end;

      part.Destroy;

    end;
  except
    on E: Exception do
    begin

      if Assigned(part) then part.Destroy;

      logger.Info('TEmex.InsertPartToBasketByPartDelete error: ' + e.Message);

      SQl.Exec('Update pAccrualAction set retval = 506, Message =:Message where spid = @@spid and ObjectID=:OrderID',
              ['OrderID','Message'],[OrderID, e.Message]);
    end;
  end;

  logger.Info('TEmex.InsertPartToBasketByPartDelete End');
end;

procedure TEmex.InsertPartToBasketCancel;
var part: BasketDetails;
    outBasket: ArrayOfBasketDetails;
    I, RCount, R: Integer;
    dat: TXSDateTime;
begin
  logger.Info('TEmex.InsertPartToBasketCancel Begin');
  try

    qry.Close;
    Qry.Open('Select BasketId, ClientID     '+
             '  from pBasketDetails (nolock)'+
             ' where Spid   = @@spid        '+
             '   and isnull(OrderID, 0) = 0 '+
             '   and isnull(BasketId, 0)> 0 ', [], []);
    qry.Open;
    RCount := qry.RecordCount;

    if RCount > 0 then
    begin
      SetLength(outBasket, 1);

      dat := TXSDateTime.Create;
      part:= BasketDetails.Create;

      qry.First;
      for I := 0 to qry.RecordCount - 1 do // �������� ��������� �� ������, ����� ����� ���� ������ �� ����� ������ �������� ������
      begin
        part.BasketId := Qry.FieldByName('BasketId').AsLargeInt;
        part.Date_add:= dat;

        outBasket[0]:= part;

        logger.Info('TEmex.InsertPartToBasketCancel DeleteFromBasket: ' +  part.BasketId.ToString);

        R:=Emex.DeleteFromBasket(getCustomer(Qry.FieldByName('ClientID').AsInteger), outBasket);

        if R <> 1 then
        begin
          logger.Info('TEmex.InsertPartToBasketCancel 505 ���������� ��������� �������: ' +  R.ToString);
        end;

        qry.Next;
      end;
      part.Destroy;
    end;
  except
    on E: Exception do
    begin
      if Assigned(part) then part.Destroy;

      logger.Info('TEmex.InsertPartToBasketCancel error: ' + e.Message);
    end;
  end;

  logger.Info('TEmex.InsertPartToBasketCancel End');
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
      Result := '������ �����������. ������ [' + AAccount.ToString + ']' + #13#10 +
                E.Message;
    end;
  end;
end;

procedure TEmex.FillFindByNumber(APparts: ArrayOfFindByNumber);
var part: FindByNumber;
    I: Integer;
begin
  SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  for I := 0 to Length(APparts)-1 do
  begin
    part:= FindByNumber.Create;
    part :=  APparts[i];

    SQl.Exec( 'insert into pFindByNumber'+
              '       (Spid,    Available, bitOldNum, PercentSupped, PriceId, Region, Delivery, Make, DetailNum, PriceLogo, Price, PartNameRus, PartNameEng,  WeightGr,  MakeName,   Packing,  VolumeAdd,  GuaranteedDay, bitECO, bitWeightMeasured) '+
              ' select @@spid, :Available,:bitOldNum,:PercentSupped,:PriceId,:Region,:Delivery,:Make,:DetailNum,:PriceLogo,:Price,:PartNameRus,:PartNameEng, :WeightGr, :MakeName,  :Packing, :VolumeAdd, :GuaranteedDay, :bitECO, :bitWeightMeasured ',
             ['Available','bitOldNum','PercentSupped','PriceId','Region','Delivery', 'Make', 'DetailNum', 'PriceLogo', 'Price', 'PartNameRus', 'PartNameEng','WeightGr','MakeName', 'Packing','VolumeAdd','GuaranteedDay', 'bitECO', 'bitWeightMeasured'],
             [part.Available,
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

procedure TEmex.FillMovement(AParts: ArrayOfMovement);
var part: Movement;
       I: Integer;
begin
  for I := 0 to Length(Aparts)-1 do
  begin
    part:= Movement.Create;
    part :=  Aparts[i];

    if part = nil then Exit;

    SQl.Exec( 'insert into pMovement'+
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
  Account: Integer;

begin
  logger.Info('TEmex.MovementByOrderNumber Begin');
  logger.Info('TEmex.AClientID: ' + Account.ToString);
  logger.Info('TEmex.ADetailNum: ' + ADetailNum);

  parts:=Emex.SearchPart(getCustomer(AClientID), ADetailNum, False);

  FillFindByNumber(parts);

  logger.Info('TEmex.MovementByOrderNumber End');
end;

procedure TEmex.MovementByOrderNumber(AAccount: Integer; AEmexOrderID: integer);
var parts: ArrayOfMovement;
begin
  logger.Info('TEmex.MovementByOrderNumber Begin');
  logger.Info('TEmex.MovementByOrderNumber Client(AAccount): '    + AAccount.ToString);
  logger.Info('TEmex.MovementByOrderNumber EmexOrderID: ' + AEmexOrderID.ToString);

  parts:=Emex.MovementByOrderNumber(getCustomer(AAccount), AEmexOrderID);

  FillMovement(parts);

  logger.Info('TEmex.MovementByOrderNumber End');
end;

procedure TEmex.MovementInWork;
var parts : ArrayOfMovement;
   Clients: TStringList;
   Client : String;
begin
  logger.Info('TEmex.MovementInWork Begin');
  {
  MovementInWork -> ServiceSoap.MovementInWork
  }
  SQl.Exec('delete pMovement from pMovement (rowlock) where spid = @@spid', [],[]);

  // �������� ������ ��������
  Clients := ForClients();

  for Client in Clients do
  begin
    parts:=Emex.MovementInWork(getCustomer(Client.ToInteger));
    FillMovement(parts);
  end;

  logger.Info('TEmex.MovementInWork Begin');
end;

procedure TEmex.OrderStateSyncByOrderNum;
var Clients: TStringList;
     Client: String;
      Order: Integer;
          I: Integer;
begin
  logger.Info('TEmex.OrderStateSyncByOrderNum Begin');
  {
    ������ ��������� ����������
    ��� ������������� �������� �� ��������������� �������

    ������ �������� (��������) ������������ �� pAccrualAction
  }
  Clients := ForClients();

  if Clients.Count = 0 then
     logger.Info('TEmex.OrderStateSyncByOrderNum ��� ������ ��� ������������� ��������!');

  // ���� �� ��������
  for Client in Clients do
  begin
    logger.Info('TEmex.OrderStateSyncByOrderNum ������:' + Client);

    Qry.Close;
    Qry.Sql.Text := ' Select distinct EmexOrderID      '+
                    '   from vOrderStateSyncByOrderNum '+
                    '  where ClientID = :CID           ';

    Qry.ParamByName('CID').AsInteger := Client.ToInteger;
    Qry.open;

    Qry.First;
    for I := 0 to Qry.RecordCount-1 do
    begin
      Order :=  Qry.FieldByName('EmexOrderID').AsInteger;
      logger.Info('TEmex.OrderStateSyncByOrderNum ����� ������ Emex: ' + Order.ToString);

      SQl.Exec('delete pMovement from pMovement (rowlock) where spid = @@spid', [],[]);

      MovementByOrderNumber(Client.ToInteger, Order);

      SQl.Exec(' exec EmexOrderStateSync select 0 ', [],[]);

      Qry.Next;
    end;
    Qry.Close;

    //SQl.Exec('delete pMovement from pMovement (rowlock) where spid = @@spid', [],[]);
  end;

  FreeAndNil(Clients);

  logger.Info('TEmex.OrderStateSyncByOrderNum End');
end;

procedure TEmex.GetBasketDetails;
var inBasket: ArrayOfBasketDetails;
    part    : BasketDetails;
         i: Integer;

   Clients: TStringList;
    Client: String;
begin
  logger.Info('TEmex.GetBasketDetails Begin');

  Qry.ExecSQL('delete pBasketDetails where spid = @@spid', [],[]);

  // �������� ������ ��������
  Clients := ForClients();

  for Client in Clients do
  begin
    inBasket:=Emex.GetBasketDetails(getCustomer(Client.ToInteger));

    for I := 0 to Length(inBasket)-1 do
    begin
      part:= BasketDetails.Create;
      part:= inBasket[i];

      SQl.Exec(''+
               ' insert into pBasketDetails'+
               '       (Spid, BasketId, MakeLogo, DetailNum, PriceLogo, Price, Quantity, Comments, DetailWeight, EmExWeight, DestinationLogo, UploadedPrice, CoeffMaxAgree, CustomerSubId, Reference, ClientID) '+
               ' select @@spid, :BasketId,:MakeLogo,:DetailNum,:PriceLogo,:Price, :Quantity, :Comments, :DetailWeight, :EmExWeight, :DestinationLogo, :UploadedPrice, :CoeffMaxAgree, :CustomerSubId, :Reference, :ClientID'+
               '       ',
               ['BasketId','MakeLogo','DetailNum','PriceLogo','Price','Quantity', 'Comments', 'DetailWeight', 'EmExWeight', 'DestinationLogo', 'UploadedPrice', 'CoeffMaxAgree', 'CustomerSubId', 'Reference', 'ClientID'],
               [part.BasketId, part.MakeLogo, part.DetailNum, part.PriceLogo, part.Price, part.Quantity
               ,part.Comments, part.DetailWeight, part.EmExWeight, part.DestinationLogo, part.UploadedPrice
               ,part.CoeffMaxAgree, part.CustomerSubId, part.Reference, Client.ToInteger]
               );
    end;

    freeandnil(part);
  end;
  freeandnil(Clients);

  logger.Info('TEmex.GetBasketDetails End');
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

end.
