unit uReOrderF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uCommonType, uMainVar, uniMultiItem, uniComboBox,
  uUniExComboBox, uniGUIBaseClasses, uniLabel, uniButton, uniBitBtn, uniCheckBox,
  uniPanel, Data.DB, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.DataSet,
  uEmexUtils, uniTimer, System.Actions, Vcl.ActnList, uniMainMenu, uniImageList,
  uToast, uuUniExComboBoxHelper, Quick.Logger;

type
  TSQLQueryThread = class(TThread)
  private
    FConnection: TFDConnection;
    FClientID: Integer;
    FDetailNumber: string;
    FPriceLogo: string;
    FLogger: tLogger;
    function GetLogger: tLogger;
    procedure SetLogger(const Value: tLogger);
  protected
    procedure Execute(); override;
  public
    constructor Create(AConnection: TFDConnection; AClientID: Integer; ADetailNumber, APriceLogo: string);
    // передаем логгер в поток
    property Logger: tLogger read GetLogger write SetLogger;
  end;

  TReOrder = class(TUniForm)
    UniLabel11: TUniLabel;
    cbDestinationLogo: TUniExComboBox;
    UniLabel12: TUniLabel;
    cbPrice: TUniExComboBox;
    UniContainerPanel1: TUniContainerPanel;
    edtNextPart: TUniCheckBox;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniTimer: TUniTimer;
    UniActionList1: TUniActionList;
    actRefreshFormData: TAction;
    actProtocol: TAction;
    UniNativeImageList1: TUniNativeImageList;
    procedure UniFormShow(Sender: TObject);
    procedure cbDestinationLogoChange(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure actRefreshFormDataExecute(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    FIsCounter: Boolean;

    FDetailNumber: string;
    FPriceLogo: string;
    FManufacturer: string;
    FMakeLogo: string;
   // FPrice: Real;

    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();
    procedure SetBtnEnabled;

    /// <summary>
    /// OrderUpdate - Изменение информации по заказу
    /// </summary>
    procedure OrderUpdate(ATargetStateID: integer = 0);
  public
    { Public declarations }
    var IsExistNext: Boolean;

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
    property IsCounter: Boolean read FIsCounter write FIsCounter;

    /// <summary>
    /// LoadDataPart - загрузка данных по позиции из БД
    /// </summary>
    procedure LoadDataPart();

    ///<summary>
    ///  LoadPriceList - получение данных по детали из БД
    ///</summary>
    procedure LoadPriceList();

    ///<summary>
    ///  GetPartFromEmex - поиск детали а emex в потоке
    ///</summary>
    procedure GetPartFromEmex();

    ///<summary>
    ///  LoadNextPart - переход к следующей детали
    ///</summary>
    function LoadNextPart():Boolean;
  end;

function ReOrder: TReOrder;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uUtils.Logger;

function ReOrder: TReOrder;
begin
  Result := TReOrder(UniMainModule.GetFormInstance(TReOrder));
end;

{ TReOrder }
procedure TReOrder.actRefreshFormDataExecute(Sender: TObject);
begin
  actRefreshFormData.Enabled := False;
  cbPrice.Enabled := False;

  cbPrice.BeginUpdate;
  try
    LoadDataPart;
    GetPartFromEmex;
  finally
    cbPrice.EndUpdate;

    cbPrice.Enabled := True;
    actRefreshFormData.Enabled := True;
  end;
end;

procedure TReOrder.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TReOrder.btnOkClick(Sender: TObject);
begin
  RetVal.Clear;
  btnOk.Enabled := False;
  btnOk.ScreenMask.ShowMask('Ждите, операция выполняется!');

  OrderUpdate();

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end
end;

procedure TReOrder.cbDestinationLogoChange(Sender: TObject);
begin
  FMakeLogo := cbPrice.Value.Substring(Pos('.', cbPrice.Value),  4);
  FPriceLogo:= cbPrice.Value.Substring(0, Pos('.', cbPrice.Value)-1);

  LoadPriceList;
end;

procedure TReOrder.DataLoad;
var js: string;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
       delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid

       select v.DetailName as DetailName
             ,v.Manufacturer
             ,v.DetailNumber
             ,v.PriceLogo
             ,v.Manufacturer
             ,v.MakeLogo
             ,v.DestinationLogo
             ,v.ProfilesCustomerID
             --,v.PricePurchase
             --,v.Price
         from vCustomerOrders v
        where v.OrderID = :OrderID
  ''';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FMakeLogo          := UniMainModule.Query.FieldByName('MakeLogo').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;

  ComboBoxFill(cbPrice,
  '''
    -- список поставщиков
    exec ReOrderF_SupplierList
               @OrderID =
  ''' + FID.ToString);

  cbPrice.Value := UniMainModule.Query.FieldByName('PriceLogo').AsString + '.' +UniMainModule.Query.FieldByName('MakeLogo').AsString;    //
  cbDestinationLogo.Value:= UniMainModule.Query.FieldByName('ProfilesCustomerID').AsString; // направление отгрузки

  Self.Caption:=UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
                UniMainModule.Query.FieldByName('DetailNumber').AsString+ ' ' +
                UniMainModule.Query.FieldByName('DetailName').AsString;

  IsExistNext := True;
end;

procedure TReOrder.GetPartFromEmex;
var t: TSQLQueryThread;
begin
  try
    sql.Exec('if OBJECT_ID(''tempdb..#IsPart'') is not null drop table #IsPart CREATE TABLE #IsPart (IsPart bit);', [], []);

    t := TSQLQueryThread.Create(UniMainModule.FDConnection, UniMainModule.AUserID, FDetailNumber, FPriceLogo);
    t.FreeOnTerminate := True; // Экземпляр должен само уничтожиться после выполнения
    t.Priority := tThreadPriority.tpNormal; // Выставляем приоритет потока
    t.Logger := GetCurrentLogData();
    t.Resume; // непосредственно ручной запуск потока

    UniTimer.Enabled := True;
  finally
  end;
end;

procedure TReOrder.LoadPriceList;  var Price: string;
begin
  sql.Exec('''
    exec SearchPriceCalc
           @ProfilesCustomerID = :ProfilesCustomerID,
           @DetailNum = :DetailNum
 ''',
 ['ProfilesCustomerID', 'DetailNum'],
 [cbDestinationLogo.Value.ToInteger, FDetailNumber]);


  Price:=cbPrice.Value;
  // список поставщиков
  ComboBoxFill( cbPrice, ' exec ReOrderF_SupplierList @OrderID = ' + FID.ToString );

  cbPrice.Value:=Price;

  SetBtnEnabled;
end;

procedure TReOrder.OrderUpdate(ATargetStateID: integer);
var sqltext: string;
begin
  RetVal.Clear;

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin

        if RetVal.Code = 0 then
        begin
          sqltext :='''
            declare @R      int

            exec @r = CustomerReOrder
                        @OrderID   = :OrderID
                       ,@PriceLogo = :PriceLogo
                       ,@MakeLogo  = :MakeLogo
                       ,@ProfilesCustomerID = :ProfilesCustomerID

            select @r as retcode
          ''';

          Sql.Open(sqltext,
                   ['OrderID', 'PriceLogo', 'MakeLogo', 'ProfilesCustomerID'],
                   [FID,
                    FPriceLogo,
                    FMakeLogo,
                    cbDestinationLogo.Value.ToInteger
                    ]);

          RetVal.Code := Sql.Q.FieldByName('retcode').Value;
        end;

      end;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    ToastOK('Изменение успешно выполнено!', unisession);

    if not edtNextPart.Checked then
      ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TReOrder.LoadDataPart;
begin
  // способы доставки
  cbDestinationLogo.FillFromSQL('exec CustomerReOrderF_DestinationList @OrderID = ' + FID.ToString );

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      DataLoad;
    end
  else
    //
  end;
end;

function TReOrder.LoadNextPart: Boolean;
begin
  Result := False;

  if not edtNextPart.Checked then
  begin
    Exit;
  end;

  sql.open('''
             Update #CounterPart
                set Processed = 1
              where OrderID   = :OrderID

             Select top 1 OrderID
               from #CounterPart (nolock)
              where isnull(Processed, 0) = 0
              order by N
           ''',
           ['OrderID'],
           [FID]
           );

  if sql.count > 0 then
  begin
    ID := sql.f('OrderID').AsInteger;

    LoadDataPart;

    GetPartFromEmex;

    Result := True;
  end
  else
    btnOk.ScreenMask.HideMask;
end;

procedure TReOrder.SetBtnEnabled;
begin
  edtNextPart.Enabled := IsCounter;

  btnOk.ScreenMask.HideMask;
  btnOk.Enabled := True;
end;

procedure TReOrder.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TReOrder.UniFormDestroy(Sender: TObject);
begin
  UniTimer.Enabled := false;
end;

procedure TReOrder.UniFormReady(Sender: TObject);
begin
  GetPartFromEmex;
end;

procedure TReOrder.UniFormShow(Sender: TObject);
begin
  LoadDataPart;
end;

procedure TReOrder.UniTimerTimer(Sender: TObject);
var Price: string;
begin
  try
    Sql.Open('select 1 from #IsPart (nolock)', [],[]);

    if Sql.Q.RecordCount > 0 then
    begin

      LoadPriceList();

      UniTimer.Enabled := False;
      cbPrice.Enabled  := true;
    end;
  finally
  end;
end;

{ TSQLQueryThread }

constructor TSQLQueryThread.Create(AConnection: TFDConnection;
  AClientID: Integer; ADetailNumber, APriceLogo: string);
begin
  inherited Create(False);

  FConnection  := AConnection;
  FClientID    := AClientID;
  FPriceLogo   := APriceLogo;
  FDetailNumber:= ADetailNumber;
end;

procedure TSQLQueryThread.Execute;
var Emex:TEmex;
begin
  FLogger.Debug('TSQLQueryThread.Execute Begin');
  Emex := TEmex.Create(FConnection);
  try
    FLogger.Info('TEmex.FindByDetailNumber Begin');
    FLogger.Info('TEmex.FindByDetailNumber Begin FClientID=%s, FDetailNumber=%s ', [FClientID.ToString, FDetailNumber]);

    Emex.FindByDetailNumber(FClientID, FDetailNumber);

    FLogger.Info('TEmex.FindByDetailNumber End');
    Emex.SQl.Exec('insert #IsPart (IsPart)  select 1', [],[]);
  finally
    Emex.Destroy;
    FLogger.Debug('TSQLQueryThread.Execute End');
  end;
end;

function TSQLQueryThread.GetLogger: tLogger;
begin
  Result:=FLogger;
end;

procedure TSQLQueryThread.SetLogger(const Value: tLogger);
begin
  if Assigned(Value) then
    FLogger := Value;
end;

end.
