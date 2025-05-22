
unit uOrdersF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, System.StrUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,
  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  unimURLFrame, uniCheckBox, uniMemo, uniHTMLMemo, uniListBox, uniFieldSet,
  uUniExComboBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, uniMainMenu,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, uConstant,
  uUniExComboBoxHelper, uMessengerF, uServiceEmex, uniSpeedButton, uSpplitForm,
  Quick.Logger;

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

  TOrderF = class(TUniForm)
    tabCommon: TUniFieldContainer;
    lblWeightKGF: TUniLabel;
    lblVolumeKGF: TUniLabel;
    lblDetailNameF: TUniLabel;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    UniGroupBox1: TUniGroupBox;
    edtL: TUniNumberEdit;
    edtW: TUniNumberEdit;
    edtH: TUniNumberEdit;
    edtVKG: TUniNumberEdit;
    UniGroupBox2: TUniGroupBox;
    UniGroupBox3: TUniGroupBox;
    btnGoogleImages: TUniButton;
    btnYandexImages: TUniButton;
    btnExist: TUniButton;
    btnZZAP: TUniButton;
    btnEmEx: TUniButton;
    UniLabel1: TUniLabel;
    UniBitBtn1: TUniBitBtn;
    UniTimer: TUniTimer;
    btnNumber: TUniButton;
    btnNumber2: TUniButton;
    btnDestinationLogo: TUniBitBtn;
    cbFragile: TUniCheckBox;
    cbNoAir: TUniCheckBox;
    UniGroupBox5: TUniGroupBox;
    edtWeightKG: TUniNumberEdit;
    UniGroupBox6: TUniGroupBox;
    edtWeightKGF: TUniNumberEdit;
    UniGroupBox7: TUniGroupBox;
    edtVolumeKG: TUniNumberEdit;
    UniGroupBox8: TUniGroupBox;
    edtVolumeKGF: TUniNumberEdit;
    UniLabel11: TUniLabel;
    UniLabel12: TUniLabel;
    UniGroupBox9: TUniGroupBox;
    edtPrice: TUniEdit;
    edtMargin: TUniEdit;
    edtMarginF: TUniEdit;
    edtIncome: TUniEdit;
    edtProfit: TUniEdit;
    edtDelivery: TUniEdit;
    edtCount: TUniEdit;
    edtReliabilityGroup: TUniFieldContainer;
    edtReliability: TUniHTMLFrame;
    UniGroupBox4: TUniGroupBox;
    edtPrice2: TUniEdit;
    edtMargin2: TUniEdit;
    edtMarginF2: TUniEdit;
    edtIncome2: TUniEdit;
    edtProfit2: TUniEdit;
    edtReliabilityGroup2: TUniFieldContainer;
    edtReliability2: TUniHTMLFrame;
    edtDelivery2: TUniEdit;
    edtCount2: TUniEdit;
    cbDestinationLogo: TUniExComboBox;
    btnOkToCancel: TUniBitBtn;
    btnOkToProc: TUniBitBtn;
    edtNextPart: TUniCheckBox;
    edtDetailNameF: TUniComboBox;
    NotExists: TUniLabel;
    cbPrice: TUniExComboBox;
    UniActionList1: TUniActionList;
    actRefreshFormData: TAction;
    UniHTMLFrame1: TUniHTMLFrame;
    UniContainerPanel1: TUniContainerPanel;
    actProtocol: TAction;
    UniNativeImageList1: TUniNativeImageList;
    lblKurs: TUniLabel;
    edtKurs: TUniNumberEdit;
    lblCurKurs: TUniLabel;
    edtCurKurs: TUniNumberEdit;
    edtCurExtraKurs: TUniNumberEdit;
    lblCurExtraKurs: TUniLabel;
    lblExtraKurs: TUniLabel;
    edtExtraKurs: TUniNumberEdit;
    btnMessage: TUniButton;
    cbNLA: TUniCheckBox;
    lblChangeW: TUniHTMLFrame;
    btnSplit: TUniBitBtn;
    pnlSplitMessage: TUniContainerPanel;
    lblSplit: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnGoogleImagesClick(Sender: TObject);
    procedure btnYandexImagesClick(Sender: TObject);
    procedure btnExistClick(Sender: TObject);
    procedure btnZZAPClick(Sender: TObject);
    procedure btnEmExClick(Sender: TObject);
    procedure btnNumberClick(Sender: TObject);
    procedure btnNumber2Click(Sender: TObject);
    procedure btnDestinationLogoClick(Sender: TObject);
    procedure cbPriceChange(Sender: TObject);
    procedure cbDestinationLogoChange(Sender: TObject);
    procedure btnOkToCancelClick(Sender: TObject);
    procedure btnOkToProcClick(Sender: TObject);
    procedure edtDetailNameFRemoteQuery(const QueryString: string; Result: TStrings);
    procedure actRefreshFormDataExecute(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
    procedure actProtocolExecute(Sender: TObject);
    procedure edtWeightKGFChange(Sender: TObject);
    procedure edtLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtVKGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtWeightKGFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtVolumeKGFChange(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure btnSplitClick(Sender: TObject);

  private
    FAction: TFormAction;
    /// <remarks> FID - Идентификатор заказа </remarks>
    FID: Integer;
    FFlag: Integer;
    FClientID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;
    FPriceLogoOld: string;

    FManufacturer:string;
    FMakeLogo:string;
    FPrice:   Real;
    FMargin:  Real;

    FMarginF: Real;
    FIncome:  Real;
    FProfin:  Real;
    FQuantity: Integer;
    FPriceQuantity: Integer;
    FPercentSupped: Integer; // вероятность поставки

    FPrice2:   Real;
    FMarginF2: Real;
    FIncome2:  Real;
    FProfin2:  Real;
    FQuantity2: Integer;
    FReference :string;
    FCustomerSubID:string;
    FSuppliersID: Integer;
    FBasketId:Integer;

    /// <value>FStatusID - текущее состояние</value>
    FStatusID: Integer;
    FIsCounter: Boolean;

    /// <value>FGoogleKey - ключ к программируемой поисковой системы google</value>
    FGoogleKey : string;

    FDeliveryTermSupplier,
    FDeliveryDaysReserve,
    FDeliveryTermFromSupplierProfile,
    FProfilesCustomerID,
    FProfilesDeliveryID,
    /// <summary>
    ///  FDeliveryTermFromCustomerProfile -  cрок клиента
    ///</summary>
    FDeliveryTermFromCustomerProfile,
    FPassedDayInWork: Integer;

    FIsSplit: Boolean;
    FSplitQuantity: Integer;

    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck(ATargetStateID: integer = 0);


    procedure SetOpenUrl(AUrl: string);

    /// <summary>
    ///  GooglePSE - интеграция программируемой поисковой системы google
    ///</summary>
    procedure GooglePSE();

    procedure WeightKGFStyle();

    procedure SetDeliveryHint();

    /// <summary>
    ///  SetOrderCountLabel - Установка количества оставщихся деталей в обработке. BadgeText
    ///</summary>
    procedure SetOrderCountLabel();

    function GetOrderCount: Integer;

    /// <summary>
    ///  OrderCount - Количество деталей в обработке
    ///</summary>
    property OrderCount: Integer read GetOrderCount;
  public
    { Public declarations }

    var IsExistNext: Boolean;

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
    property IsCounter: Boolean read FIsCounter write FIsCounter;

    ///<summary>
    ///  GetPartDataFromBase - получение данных по детали для: Показатели после изменения
    ///</summary>
    procedure GetPartDataFromBase();

    procedure GetSupplierList();

    procedure SetRating(ARating: integer);

    procedure SetEditDataRating(ARating: integer);

    /// <summary>
    /// OrdersFinCalc - расчет цены, финансовых показателей
    /// </summary>
    procedure OrdersFinCalc();

    /// <summary>
    /// SetIndicatorsStyle - Установка стилей для показателей: Показатели до изменения
    /// </summary>
    procedure SetIndicatorsStyle(AIncome: real);

    /// <summary>
    /// SetDeliveryStyle - Установка стилей для поля Срок доставки, до изменения
    /// </summary>
    procedure SetDeliveryStyle(aVal: Integer);

    /// <summary>
    /// SetEditDeliveryStyle - Установка стилей для поля: Срок доставки, после изменения
    /// </summary>
    procedure SetEditDeliveryStyle(aVal: Integer);

    /// <summary>
    /// PriceCalc - Установка стилей для показателей: Показатели после изменения
    /// </summary>
    procedure SetEditDataStyle();

    procedure SetBtnEnabled();

    /// <summary>
    /// OrderSave - Изменение информации по заказу
    /// </summary>
    procedure OrderSave(ATargetStateID: integer = 0);

    /// <summary>
    /// OrderUpdate - Изменение информации по заказу в базе
    /// </summary>
    procedure OrderUpdate(AOrderID: integer; ATargetStateID: integer = 0);

    /// <summary>
    /// LoadDataPart - получение данных по детали из базы
    /// </summary>
    procedure LoadDataPart();

    procedure GetPartFromEmex();

    /// <summary>
    /// LoadNextPart - переход к следующей детали для обработки
    /// </summary>
    function LoadNextPart():Boolean;
  end;

function OrderF: TOrderF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils,
  ServerModule, uOrdersT, uToast, uOrdersProtocol_T, uUtils.Strings,
  Soap.XSBuiltIns, uUtils.Logger;

function OrderF: TOrderF;
begin
  Result := TOrderF(UniMainModule.GetFormInstance(TOrderF));
end;


{ TSQLQueryThread }

constructor TSQLQueryThread.Create(AConnection: TFDConnection; AClientID: Integer; ADetailNumber, APriceLogo: string);
begin
  inherited Create(True); // поток создаётся приостановленным

  FConnection  := AConnection;
  FClientID    := AClientID;
  FPriceLogo   := APriceLogo;
  FDetailNumber:= ADetailNumber;
end;

procedure TSQLQueryThread.Execute();
var Emex:TEmex;
begin
  FLogger.Debug('TSQLQueryThread.Execute Begin');
  Emex := TEmex.Create(FConnection, FLogger);
  try
    FLogger.Debug('TSQLQueryThread.Execute FindByDetailNumber Begin FClientID=%s, FDetailNumber=%s ', [FClientID.ToString, FDetailNumber]);

    Emex.FindByDetailNumber(FClientID, FDetailNumber);

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

{ TOrderF }

procedure TOrderF.edtDetailNameFRemoteQuery(const QueryString: string;
  Result: TStrings);
begin
   sql.Open(
   '''
     exec OrderF_PartDescription
             @Number = :Number
   ''',
   ['Number'], [QueryString]);

    sql.q.First;
    while not sql.q.Eof do
    begin
      Result.Add( sql.q.FieldByName('Name_RUS').AsString );
      sql.q.Next;
    end;
end;

procedure TOrderF.edtLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edtVKG.Value := ( (edtL.Value * edtW.Value * edtH.Value) / 5000 );
end;

procedure TOrderF.edtVKGKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (KEY = 13) then //enter
  begin
     edtVolumeKGF.Value := edtVKG.Value;
  end;
end;

procedure TOrderF.edtVolumeKGFChange(Sender: TObject);
begin
  OrdersFinCalc();
  GetPartDataFromBase;
end;

procedure TOrderF.edtWeightKGFChange(Sender: TObject);
begin
  WeightKGFStyle();
  OrdersFinCalc();
  GetPartDataFromBase();
end;

procedure TOrderF.edtWeightKGFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    OrdersFinCalc();
    GetPartDataFromBase;
  end;
end;

function TOrderF.GetOrderCount: Integer;
begin
  sql.Open(
  '''
    declare @CNT as Int = 0

    if OBJECT_ID('tempdb..#CounterPart') is not null
      select @CNT = Count(1)
        from #CounterPart (nolock)
       where isnull(Processed, 0) = 0

    select @CNT as CNT
  ''', [], []);

  Result := sql.F('CNT').asInteger;
end;

procedure TOrderF.GetPartFromEmex;
var t: TSQLQueryThread;
begin
  try
    sql.Exec('if OBJECT_ID(''tempdb..#IsPart'') is not null drop table #IsPart CREATE TABLE #IsPart (IsPart bit);', [], []);

    t := TSQLQueryThread.Create(UniMainModule.FDConnection, FClientID, FDetailNumber, FPriceLogo);
    t.FreeOnTerminate := True; // Экземпляр должен само уничтожиться после выполнения
//    t.Priority := tThreadPriority.tpNormal; // Выставляем приоритет потока
    t.Logger := GetCurrentLogData();
    t.start; // непосредственно ручной запуск потока

    UniTimer.Enabled := True;
  finally
  end;
end;

procedure TOrderF.GetSupplierList;   // список поставщиков
var Price: String;
        //i: Integer;
begin
  Price:=cbPrice.Value;

  Sql.Q.Close;
  Sql.Open('''
     exec OrderF_SupplierList
            @OrderID            = :OrderID
           ,@ProfilesDeliveryID = :ProfilesDeliveryID
  ''',
  ['OrderID', 'ProfilesDeliveryID'],
  [FID, FProfilesDeliveryID]);

  with Sql.Q do
  begin
    DisableControls;
    cbPrice.Items.BeginUpdate;
    cbPrice.ClearAll;
    First;
    while not Eof do
      begin
        cbPrice.Items.Add(FieldByName('Name').AsString);
//ломает itemindex почему? не понятно
//        cbPrice.JSInterface.JSCall('store.getAt(' + i.ToString + ').set',
//                ['tag',
//                 FieldByName('Flag').AsInteger]);

        cbPrice.ValueList.Add(FieldByName('ID').AsString);

        Next;
      end;

    cbPrice.Items.EndUpdate;
    cbPrice.Value:=Price;
    EnableControls;
  end;
end;

procedure TOrderF.GetPartDataFromBase();
var r, HintText: string;
    DeliveryTermFromSupplierProfile: Integer;
begin
  Log('TOrderF.GetPartDataFromBase Begin', etDebug);
  HintText := '';

  Log('TOrderF.GetPartDataFromBase DetailNum=%s, PriceLogo=%s, MakeLogo=%s, ProfilesDeliveryID=%d',
     [FDetailNumber, FPriceLogo, FMakeLogo, FProfilesDeliveryID], etDebug);

  sql.Open('''
           exec OrderF_GetEditData
                  @Make      = :MakeLogo
                 ,@DetailNum = :DetailNum
                 ,@PriceLogo = :PriceLogo
                 ,@ProfilesDeliveryID = :ProfilesDeliveryID
           ''',
           ['DetailNum', 'PriceLogo', 'MakeLogo', 'ProfilesDeliveryID'],
           [FDetailNumber, FPriceLogo, FMakeLogo,  FProfilesDeliveryID]);

  if sql.Count>0 then
  begin
    FPrice2            := sql.F('Price').asfloat;
    FMarginF2          := sql.F('MarginF').AsFloat;
    FIncome2           := sql.F('IncomePrc').AsFloat;
    FProfin2           := sql.F('Profit').AsFloat;
    FQuantity2         := sql.F('Available').AsInteger;

    edtCount2.Text     := FQuantity.ToString + '/' + sql.F('AvailableStr').AsString + ' (' + sql.F('Packing').AsString + ')';
    edtMargin2.Text    := FormatFloat('##0%', FMargin);
    edtMarginF2.Text   := FormatFloat('##0%', FMarginF2);
    edtProfit2.Text    := FormatFloat('##0%', FProfin2);

    var DeliveryTermSupplier: Integer := sql.F('GuaranteedDay').AsInteger;
    DeliveryTermFromSupplierProfile   := sql.F('DeliveryTermFromSupplier').AsInteger;

    var DeliveryTermFromCustomerProfile: Integer;
    DeliveryTermFromCustomerProfile   :=
         IfThen((FFlag and Integer(TOrderFlag.ORDER_ONLINE)) > 0,
                 FDeliveryTermFromCustomerProfile, //sql.F('OurDelivery').AsInteger,
                 FDeliveryTermFromCustomerProfile
                );

    //  Срок поставки:
    edtDelivery2.Text:= FPassedDayInWork.ToString + '+' +          // дней в обработке
                        DeliveryTermSupplier.ToString +'+' +       // Срок поставщика из API
                        FDeliveryDaysReserve.ToString+ '+' +       // Запас до вылета
                        DeliveryTermFromSupplierProfile.ToString + // Доставка
                        '=' +
                        (
                          FPassedDayInWork +               // дней в обработке
                          DeliveryTermSupplier+            // Срок поставщика из API
                          FDeliveryDaysReserve+            // Запас до вылета
                          DeliveryTermFromSupplierProfile  // Доставка
                        ).ToString +

                        '(' +
                        IfThen(FPassedDayInWork+
                               DeliveryTermSupplier+
                               FDeliveryDaysReserve+
                               DeliveryTermFromSupplierProfile-
                               DeliveryTermFromCustomerProfile > 0, '+', '') +

                        (
                          FPassedDayInWork +                // дней в обработке
                          DeliveryTermSupplier+             // Срок поставщика из API
                          FDeliveryDaysReserve+             // Запас до вылета
                          DeliveryTermFromSupplierProfile-  // Доставка
                          DeliveryTermFromCustomerProfile   // Срок клиента
                        ).ToString +
                        ')';

    var t: Real := SimpleRoundTo(sql.F('Price').Value*100/FPrice - 100, -2);
    if t > 0 then r := '+'
    else
    if t = 0 then r := ''
    else
      r := '';

    r := r + FloatToStr(t);

    edtPrice2.Text     := FormatFloat('$###,##0.00', sql.F('Price').AsFloat) + ' ('+ r + '%)';
    edtIncome2.Text    := FormatFloat('##0%', FIncome2);

    SetEditDataStyle();
    SetEditDataRating(sql.F('PercentSupped').AsInteger);

    SetEditDeliveryStyle((FPassedDayInWork+
                          DeliveryTermSupplier+
                          FDeliveryDaysReserve+
                          DeliveryTermFromSupplierProfile-
                          DeliveryTermFromCustomerProfile));

    // вплывающая подсказака
    HintText := HintText + FPassedDayInWork.ToString      + ' - дней до взятия в работу' + #10;
    HintText := HintText + DeliveryTermSupplier.ToString  + ' - срок поставщика из прайса' + #10;
    HintText := HintText + FDeliveryDaysReserve.ToString  + ' - дней запаса до вылета' + #10;
    HintText := HintText + DeliveryTermFromSupplierProfile.ToString + ' - доставка' + #10;
    HintText := HintText + (FPassedDayInWork + DeliveryTermSupplier + FDeliveryDaysReserve + DeliveryTermFromSupplierProfile).ToString + ' - срок доставки клиенту' + #10;

    if FPassedDayInWork + DeliveryTermSupplier + FDeliveryDaysReserve + DeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile < 0 then
      HintText := HintText + (FPassedDayInWork + DeliveryTermSupplier + FDeliveryDaysReserve + DeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile).ToString + ' - дней в запасе'+ #10+#13
    else
      HintText := HintText + '+' + (FPassedDayInWork + DeliveryTermSupplier + FDeliveryDaysReserve + DeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile).ToString + ' - дней позже'+ #10+#13;
    HintText := HintText + DeliveryTermFromCustomerProfile.ToString + ' - cрок клиента';

    edtDelivery2.Hint := HintText;

    NotExists.Visible := false;
    edtReliability2.Visible := true;
  end
  else
  begin // нет данных
    Log(' TOrderF.GetPartDataFromBase Нет данных', etDebug);
    edtCount2.Clear;
    edtMargin2.Clear;
    edtMarginF2.Clear;
    edtProfit2.Clear;
    edtPrice2.Clear  ;
    edtIncome2.Clear ;

    FPrice2   :=0;
    FMarginF2 :=0;
    FIncome2  :=0;
    FProfin2  :=0;
    FQuantity2:=0;

    NotExists.Visible := True;
    edtReliability2.Visible := False;

    SetEditDataStyle();
    SetEditDataRating(0);

    edtDelivery2.Hint := '';
  end;
  Log(' TOrderF.GetPartDataFromBase Begin', etDebug);
end;

procedure TOrderF.GooglePSE;
begin
  if FGoogleKey = '' then
  begin
    with TStringList.Create() do
    begin
      LoadFromFile(UniServerModule.StartPath +  '\files\html\GoogleCSEKeyErr.html');
      UniHTMLFrame1.HTML.Text := Text;
      Free;
    end;

    exit ;
  end;

  UniHTMLFrame1.HTML.clear;

  UniHTMLFrame1.HTML.Text := Format(
  '''
    <script async src="https://cse.google.com/cse.js?cx=%s"></script>
    <div class="gcse-search" data-gname="search"></div>

    <script>
        // Функция для создания поискового запроса
        function performSearch(brand, partNumber) {

            // Получаем объект поиска
            var searchControl = google.search.cse.element.getElement('search');
            if (searchControl) {
                console.log(searchControl);

                searchControl.clearAllResults();

                // Устанавливаем поисковый запрос
                const searchQuery = brand + " " + partNumber;
                searchControl.prefillQuery(searchQuery);
                // Выполняем поиск
                searchControl.execute();
            };
        };

      // Ждем загрузки компонента Google Custom Search
      function onGoogleSearchLoaded() {
        console.log("Google Custom Search загружен");

        performSearch("%s", "%s");

      };

      // Событие инициализации поиска Google Custom Search
      window.__gcse = {
        callback: onGoogleSearchLoaded
      };

    </script>

  ''', [FGoogleKey, FManufacturer, FDetailNumber]);
end;

procedure TOrderF.LoadDataPart;
begin
  cbDestinationLogo.FillFromSQL('exec OrderF_DestinationList @OrderID =' + FID.ToString );

  // начитываем данные с базы
  case FAction of
    acUpdate, acUpdateShipments, acUserAction, acDelete, acShow:
    begin
      DataLoad;

      GooglePSE();

      edtDetailNameF.SetFocus;
    end
  else
    //
  end;

  SetBtnEnabled;
end;

function TOrderF.LoadNextPart: Boolean;
begin
  Result := False;

  if not edtNextPart.Checked then Exit;

  if FIsSplit then // если разделили деталь, то нам нужно поднять на изменение ее же, предварительно разбив на части
  begin
    if ID > 0 then Result := True;

    SetRating(0);

    SetEditDataRating(0);

    LoadDataPart;

   // GetPartFromEmex;
  end
  else
  begin
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
             [FID]);

    sql.q.first;
    if sql.Q.RecordCount > 0 then
    begin
      ID := sql.Q.FieldByName('OrderID').AsInteger;

      if ID > 0 then Result := True;

      SetRating(0);

      SetEditDataRating(0);

      LoadDataPart;

      GetPartFromEmex;
    end;
  end;
end;

procedure TOrderF.actProtocolExecute(Sender: TObject);
begin
  OrdersProtocol_T.ID:= FID;
  OrdersProtocol_T.ShowModal;
end;

procedure TOrderF.actRefreshFormDataExecute(Sender: TObject);
begin
  SetEditDataRating(0);
  LoadDataPart;
  GetPartFromEmex;
end;

procedure TOrderF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TOrderF.btnDestinationLogoClick(Sender: TObject);
begin
  cbDestinationLogo.Enabled := not cbDestinationLogo.Enabled;
  cbDestinationLogo.SetFocus;
end;

procedure TOrderF.btnEmExClick(Sender: TObject);
begin
  setOpenUrl(Format('https://emexdwc.ae/Search.aspx?n=%s&d=$DLV$1', [FDetailNumber]));
end;

procedure TOrderF.btnExistClick(Sender: TObject);
begin
  setOpenUrl(Format('https://www.exist.ru/Price/?igu=1&pcode=%s', [FDetailNumber]));
end;

procedure TOrderF.btnGoogleImagesClick(Sender: TObject);
begin
  setOpenUrl(Format('https://www.google.com/search?igu=1&tbm=isch&q=%s+%s', [FManufacturer, FDetailNumber]));
end;

procedure TOrderF.btnMessageClick(Sender: TObject);
begin
  MessageF.OrderID := Fid;
  MessageF.ShowModal();
end;

procedure TOrderF.btnYandexImagesClick(Sender: TObject);
begin
  setOpenUrl(Format('https://yandex.ru/images/search?igu=1&from=tabbar&text=%s+%s', [FManufacturer, FDetailNumber]));
end;

procedure TOrderF.btnZZAPClick(Sender: TObject);
begin
  setOpenUrl(Format('https://www.zzap.ru/public/search.aspx#rawdata=%s', [FDetailNumber]));
end;

procedure TOrderF.cbDestinationLogoChange(Sender: TObject);
begin
  if (FFlag and 16 {Онлайн заказ}) > 0 then  // направления отгрузки
  begin
    FProfilesCustomerID:= cbDestinationLogo.Value.ToInteger;

    Sql.Open('''
      Select ProfilesDeliveryID
        from vClientProfilesParam
       where ProfilesCustomerID = :ID
    ''',
    ['ID'],
    [FProfilesCustomerID]);

    FProfilesDeliveryID := Sql.F('ProfilesDeliveryID').AsInteger;
  end
  else
  begin // если не онлайн, то у нас тут cbDestinationLogo=ProfilesDeliveryID
    FProfilesDeliveryID:= cbDestinationLogo.Value.ToInteger;
  end;

  OrdersFinCalc();

  GetPartDataFromBase();

  GetSupplierList();
end;

procedure TOrderF.cbPriceChange(Sender: TObject);   // var i: Integer;
begin
  Log('TOrderF.cbPriceChange Begin', etDebug);

  FMakeLogo  := cbPrice.Value.Substring(Pos('.', cbPrice.Value),  4);
  FPriceLogo := cbPrice.Value.Substring(0, Pos('.', cbPrice.Value)-1);

  Log('TOrderF.cbPriceChange FMakeLogo=%s, FPriceLogo=%s', [FMakeLogo, FPriceLogo], etDebug);

  GetPartDataFromBase;
  Log('TOrderF.cbPriceChange End', etDebug);
end;

procedure TOrderF.btnNumber2Click(Sender: TObject);
begin
  btnNumber2.JSInterface.JSCall('copyToClipboard', [FDetailNumber2]);
end;

procedure TOrderF.btnNumberClick(Sender: TObject);
begin
  btnNumber.JSInterface.JSCall('copyToClipboard', [FDetailNumber]);
end;

procedure TOrderF.OrdersFinCalc;
begin
  Log('TOrderF.OrdersFinCalc Begin', etDebug);
  Log('TOrderF.OrdersFinCalc FDetailNumber=%s, FID=%d, FProfilesCustomerID=%d, ', [FDetailNumber, FID, FProfilesCustomerID], etDebug);

  RetVal.Clear;

  Sql.exec(
  '''
    exec SearchPriceCalc
           @ProfilesCustomerID=:ProfilesCustomerID,
           @DetailNum         =:DetailNum

    exec OrderF_OrdersFinCalc
           @OrderID  =:OrderID
          ,@WeightKGF=:Weight
          ,@VolumeKGF=:Volume
  ''',
  ['ProfilesCustomerID', 'DetailNum', 'OrderID', 'Weight', 'Volume'],
  [FProfilesCustomerID,
   FDetailNumber,
   FID,
   edtWeightKGF.Value,
   edtVolumeKGF.Value]);

   Log('TOrderF.OrdersFinCalc End', etDebug);
end;

procedure TOrderF.OrderUpdate(AOrderID: integer; ATargetStateID: integer = 0);
var sqltext: string;
begin
  if RetVal.Code = 0 then
  begin
    sqltext :=
    '''
       declare @R int

       exec @r = OrderUpdate
                   @OrderID           = :OrderID
                  ,@DetailNameF       = :DetailNameF
                  ,@WeightKGF         = :WeightKGF
                  ,@VolumeKGF         = :VolumeKGF
                  ,@Fragile           = :Fragile
                  ,@NoAir             = :NoAir
                  ,@Price             = :Price
                  ,@ProfilesCustomerID= :ProfilesCustomerID
                  ,@ProfilesDeliveryID= :ProfilesDeliveryID
                  ,@TargetStateID     = :TargetStateID
                  ,@MakeLogo          = :MakeLogo
                  ,@ReplacementPrice  = :ReplacementPrice
                  ,@NLA               = :NLA
                  ,@IsSplit           = :IsSplit
                  ,@SplitQuality      = :SplitQuality

       select @r as retcode
    ''';

    Sql.Open(sqltext,
             ['WeightKGF','VolumeKGF','DetailNameF', 'OrderID', 'Price', 'MakeLogo',
              'ProfilesCustomerID', 'ProfilesDeliveryID', 'Fragile', 'NoAir',
              'TargetStateID', 'ReplacementPrice', 'NLA', 'IsSplit', 'SplitQuality'],
             [edtWeightKGF.Value,
              edtVolumeKGF.Value,
              edtDetailNameF.Text,
              AOrderID,
              FPriceLogo,
              FMakeLogo,
              FProfilesCustomerID,
              FProfilesDeliveryID,
              cbFragile.Checked,
              cbNoAir.Checked,
              ATargetStateID,
              FPrice2,
              cbNLA.Checked, //-- No longer available Более недоступно
              FIsSplit,
              FSplitQuantity
              ]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;
  end;
end;

procedure TOrderF.OrderSave(ATargetStateID: integer = 0);
var Emex:TEmex;
 BasketID: Int64;
 Baskets : ArrayOfBasketDetails_v2;
 I: Integer;
begin
  RetVal.Clear;

  DataCheck(ATargetStateID);

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate, acUpdateShipments:
      begin
        // если заказа в корзине, нужно его удалить
        if (FStatusID = 3)	{InBasket	В корзине}  then
        begin
            Emex := TEmex.Create(UniMainModule.FDConnection, GetCurrentLogData());
            try
              RetVal.Code := Emex.DeleteFromBasketByOrderID(FID);

              if RetVal.Code = 1 then
                RetVal.Clear
              else
              begin
                RetVal.Code := 705; // Деталь не найдена в корзине!
              end;

              Emex.SQl.Exec('insert #IsPart (IsPart)  select 1', [],[]);
            finally
              Emex.Destroy;
            end;
        end;

        if RetVal.Code = 0 then
        begin
          OrderUpdate(FID, ATargetStateID);
        end;

        // Добавление а корзину emex
        if (RetVal.Code = 0) and (FStatusID = 3) and (ATargetStateID = 0) then
        begin
            Emex := TEmex.Create(UniMainModule.FDConnection, GetCurrentLogData());
            try
              BasketID := Emex.InsertFromBasketByOrderID(FID);

              if BasketID>0 then
              begin
                Baskets := Emex.GetBasketDetailsBySuppliersID(FSuppliersID);

                // получим нужную нам позицию
                for I := 0 to High(Baskets)-1 do
                  begin
                    if Baskets[I].BasketId = BasketID then
                    begin
                      Break;
                    end;
                  end;

                SQL.Exec('Delete pBasketDetails from pBasketDetails (rowlock) where spid = @@spid', [], []);
                Emex.FillBasketDetails(Baskets[I], FSuppliersID);

                Sql.Exec(' exec BasketStateSync ', [], []);
              end
            finally
              Emex.Destroy;
            end;
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

procedure TOrderF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TOrderF.SetBtnEnabled;
begin
  edtNextPart.Enabled := IsCounter;

  if IsCounter then
  begin
    //
  end;

  btnOkToCancel.Enabled := (FAction <> acUpdateShipments) and (IsExistNext) and (FStatusID in [1, 2, 3, 22]);
  btnOkToProc.Enabled   := (FAction <> acUpdateShipments) and (IsExistNext) and (FStatusID in [1, 22]);
  btnOk.Enabled := IsExistNext;

  btnSplit.Enabled := (FAction <> acUpdateShipments) and (FStatusID in [1, 2]) and (FQuantity > 1);

  pnlSplitMessage.Visible := FIsSplit;

  SetOrderCountLabel;
end;

procedure TOrderF.SetDeliveryHint;
var
  HintText: string;
begin
  HintText := HintText + FPassedDayInWork.ToString + ' - дней до взятия в работу' + #10;
  HintText := HintText + FDeliveryTermSupplier.ToString + ' - срок поставщика из прайса' + #10;
  HintText := HintText + FDeliveryDaysReserve.ToString +  ' - дней запаса до вылета' + #10;
  HintText := HintText + FDeliveryTermFromSupplierProfile.ToString + ' - доставка' + #10;
  HintText := HintText + (FPassedDayInWork + FDeliveryTermSupplier + FDeliveryDaysReserve + FDeliveryTermFromSupplierProfile).ToString + ' - срок доставки клиенту' + #10;

  if FPassedDayInWork + FDeliveryTermSupplier + FDeliveryDaysReserve + FDeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile < 0 then
    HintText := HintText + (FPassedDayInWork + FDeliveryTermSupplier + FDeliveryDaysReserve + FDeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile).ToString + ' - дней в запасе'+ #10+#13
  else
    HintText := HintText + '+' + (FPassedDayInWork + FDeliveryTermSupplier + FDeliveryDaysReserve + FDeliveryTermFromSupplierProfile - FDeliveryTermFromCustomerProfile).ToString + ' - дней позже'+ #10+#13;
  HintText := HintText + FDeliveryTermFromCustomerProfile.ToString + ' - cрок клиента';

  edtDelivery.Hint := HintText;
end;

procedure TOrderF.SetDeliveryStyle(aVal: Integer);
begin
  if aVal < 0 then
    edtDelivery.Color :=  $0080FF80
  else
  if aVal = 0 then
    edtDelivery.Color := clWhite
  else
    edtDelivery.Color := $008080FF;
end;

procedure TOrderF.SetEditDataRating(ARating: integer);
var r, js: string;
begin
    case ARating  of
      0..9:
        r:= 'star';
      10..19:
        r:= 'star10';
      20..29:
        r:= 'star20';
      30..39:
        r:= 'star30';
      40..49:
        r:= 'star40';
      50..59:
        r:= 'star50';
      60..69:
        r:= 'star60';
      70..79:
        r:= 'star70';
      80..89:
        r:= 'star80';
      90..99:
        r:= 'star90';
      100:
        r:= 'star100';
    else
      r:= 'star';
    end;

    js :=
    '''
    function setRatingVal2(AVal, APercent)
    {
     document.getElementById(AVal).checked = true;
     document.getElementById("prc2").innerText = APercent + '%';
    }
    ''' +
    'ajaxRequest(' + edtReliability2.JSName + ', ''rating2'', [setRatingVal2("' + r + '2", ' + ARating.ToString +')]);';

    UniSession.JSCode(js);
end;

procedure TOrderF.SetEditDataStyle;
  procedure setColor(aVal: Real; aVal2: Real; AEdit: TUniEdit);
  begin
      if aVal < 0 then
          AEdit.Color := $008080FF
      else
      if aVal = 0 then
          AEdit.Color := clWhite
      else
      if (aVal > 0 ) and (aVal < aVal2) then
          AEdit.Color := clYellow
      else
          AEdit.Color := $0080FF80;
  end;
begin
  setColor(FMarginF2,  FMarginF,  edtMarginF2);
  setColor(FIncome2,   FIncome,   edtIncome2);
  setColor(FProfin2,   FProfin,   edtProfit2);
 // setColor(FMarginF2,  FMarginF,  edtDelivery2);
  setColor(FQuantity2, FPriceQuantity, edtCount2);
end;

procedure TOrderF.SetEditDeliveryStyle(aVal: Integer);
begin
  if aVal < 0 then
      edtDelivery2.Color :=  $0080FF80
  else
  if aVal = 0 then
      edtDelivery2.Color := clWhite
  else
      edtDelivery2.Color := $008080FF;
end;

procedure TOrderF.SetIndicatorsStyle(AIncome: real);
begin
  if AIncome >= 0 then
    edtMarginF.Color :=   $0080FF80
  else
    edtMarginF.Color :=   $008080FF;

  edtProfit.Color         := edtMarginF.Color;
  edtIncome.Color         := edtMarginF.Color;
  edtDelivery.Color       := edtMarginF.Color;
  edtCount.Color          := edtMarginF.Color;
  edtReliability.Color    := edtMarginF.Color;
end;

procedure TOrderF.SetOpenUrl(AUrl: string);
begin
  UniSession.BrowserWindow(AUrl, 0, 0, '_blank');
end;

procedure TOrderF.SetOrderCountLabel;
begin
  if IsCounter then
    UniSession.AddJS(Self.JSInterface.JSName + '.setBadgeText("' + 'Позиций в работе:  '+ OrderCount.ToString +  ' ");');
end;

procedure TOrderF.SetRating(ARating: integer);
var r, js: string;
begin
    case ARating of
      0..9:
        r:= 'star';
      10..19:
        r:= 'star10';
      20..29:
        r:= 'star20';
      30..39:
        r:= 'star30';
      40..49:
        r:= 'star40';
      50..59:
        r:= 'star50';
      60..69:
        r:= 'star60';
      70..79:
        r:= 'star70';
      80..89:
        r:= 'star80';
      90..99:
        r:= 'star90';
      100:
        r:= 'star100';
    else
      r:= 'star';
    end;

    js := '''
    function setRatingVal(AVal, APercent)
    {
       document.getElementById(AVal).checked = true;
       document.getElementById("prc").innerText = APercent + '%';
    }
    '''  +
    'ajaxRequest(' + edtReliability.JSName + ', "rating", [setRatingVal("' + r + '", '+ ARating.ToString +')]);';

    UniSession.JSCode(js);
end;

procedure TOrderF.UniBitBtn1Click(Sender: TObject);
begin
  cbPrice.Enabled := not cbPrice.Enabled;
  cbPrice.SetFocus;
end;

procedure TOrderF.UniFormDestroy(Sender: TObject);
begin
  UniTimer.Enabled := false;
end;

procedure TOrderF.UniFormReady(Sender: TObject);
begin
  GetPartFromEmex;

  SetRating(FPercentSupped);
end;

procedure TOrderF.UniFormShow(Sender: TObject);
begin
  FGoogleKey := Sql.GetSetting('GoogleProgrammableSearchEngineKey');

  if FIsCounter then
    UniSession.AddJS(Self.JSInterface.JSName + '.badgeEl.show();')
  else
    UniSession.AddJS(Self.JSInterface.JSName + '.badgeEl.hide();');

  LoadDataPart;
end;

procedure TOrderF.UniTimerTimer(Sender: TObject);
begin
  try
    Sql.Open('select 1 from #IsPart (nolock)', [],[]);

    if Sql.Q.RecordCount > 0 then
    begin
      OrdersFinCalc();

      GetPartDataFromBase();

      GetSupplierList();

      UniTimer.Enabled := False;
    end;
  finally
  end;
end;

procedure TOrderF.WeightKGFStyle;
begin
  if edtWeightKGF.Value = 0 then
    edtWeightKGF.Color := $008080FF
  else
    edtWeightKGF.Color := clWindow;
end;

procedure TOrderF.btnOkClick(Sender: TObject);
begin
  btnOk.Enabled := False;
  btnOkToCancel.Enabled := False;
  btnOkToProc.Enabled := False;

  UniSession.Synchronize();

  OrderSave();

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.btnOkToCancelClick(Sender: TObject);
begin
  btnOk.Enabled := False;
  btnOkToCancel.Enabled := False;
  btnOkToProc.Enabled := False;

  UniSession.Synchronize();

  OrderSave(12 {InCancel	Отказан});

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.btnOkToProcClick(Sender: TObject);
begin
  btnOk.Enabled := False;
  btnOkToCancel.Enabled := False;
  btnOkToProc.Enabled := False;

  UniSession.Synchronize();

  OrderSave( 2 {InChecked	Проверено});

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.btnSplitClick(Sender: TObject);
begin
  // групповое изменение наименования детали
  SpplitForm.ID := FID;
  SpplitForm.FormAction := TFormAction.acUpdate;
  SpplitForm.Caption    := 'Укажите количество для текущей части заказа';
  SpplitForm.lblDetailNameF.Caption := 'Укажите количество для текущей части заказа:';

  if SpplitForm.ShowModal() = mrOk then
  begin
    FIsSplit := True;
    FSplitQuantity := SpplitForm.Quantity;

    pnlSplitMessage.Visible := FIsSplit;

    lblSplit.Caption:= 'При сохранении заказ будет разделен на части. Количество в заказе: ' + FSplitQuantity.ToString;
  end;
end;

procedure TOrderF.DataCheck(ATargetStateID: integer = 0);
const
  ValidNameSymbols = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя0123456789-()., ';
  ForbiddenWords: array[1..8] of string = (
  'Запчасть', 'Запасные части', 'Автозапчасть', 'Автозч', 'Деталь',
  'Автодеталь', 'Автопринадлежность', 'Автокомпонент');
var
  I: Integer;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acUpdateShipments, acUpdate, acReportEdit:
    begin
      if ATargetStateID <> 0 then
      if edtDetailNameF.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
        Exit();
      end;

      // Проверка допустимых символов
      for I := 1 to Length(edtDetailNameF.Text) do
      begin
        if not CharInSet(edtDetailNameF.Text[I], ValidNameSymbols) then
        begin
          RetVal.Code := 1;
          RetVal.Message := 'Поле [Наименование] содержит недопустимые символы!';
          Exit();
        end;
      end;

      // Проверка запрещенных слов
      for I := Low(ForbiddenWords) to High(ForbiddenWords) do
      begin
        if Pos(ForbiddenWords[I], edtDetailNameF.Text) > 0 then
        begin
          RetVal.Code := 1;
          RetVal.Message := 'Поле [Наименование] содержит запрещенные слова!';
          Exit();
        end;
      end;

      // Проверка веса
      if (edtWeightKG.Value = 0) and ((edtWeightKGF.Value = 0) or (edtWeightKGF.Text = '')) then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Невозможно подтвердить деталь: Вес Физический и Вес Физический Факт равны нулю или отсутствуют!';
        Exit();
      end;

      if (FIsSplit) then
      begin

        Sql.open('''
          declare @R int
          exec @R = OrderSplittingSupplierValid
                      @OrderID   = :OrderID
                     ,@PriceLogo = :PriceLogo
          select @R as retcode
        ''', ['OrderID', 'PriceLogo'], [FID, FPriceLogo]);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      end;
    end;
  end;

end;

procedure TOrderF.DataLoad;
var js: string;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text :=
  '''
       Declare @Kurs         money
              ,@ExtraKurs    money
              ,@CurKurs      money
              ,@CurExtraKurs money

       select @Kurs         = o.Kurs
             ,@ExtraKurs    = o.ExtraKurs
             ,@CurExtraKurs = s.ExtraKurs
         from tOrders o with (nolock index=ao1)
        inner join tClients c with (nolock index=PK_tClients_ClientID)
                on c.ClientID    = o.ClientID
        inner join tSuppliers s with (nolock index=ao1)
                on S.SuppliersID = c.SuppliersID
        where o.OrderID = :OrderID

       select @CurKurs = dbo.GetCurrencyRate('840', null)

       if :IsSplit <> 1
         delete pFindByNumber
           from pFindByNumber with (rowlock index=ao1)
          where Spid = @@Spid

       select @Kurs         as Kurs
             ,@ExtraKurs    as ExtraKurs
             ,@CurKurs      as CurKurs
             ,@CurExtraKurs as CurExtraKurs
             ,v.OrderDate
             ,v.WeightKG
             ,v.VolumeKG
             ,v.WeightKGF
             ,v.VolumeKGF
             ,v.DetailName
             ,v.DetailNumber
             ,v.NoAir
             ,v.Fragile
             ,v.NLA
             ,v.PriceLogo
             ,v.Manufacturer
             ,v.ProfilesCustomerID
             ,v.ProfilesDeliveryID
             ,v.SuppliersID
             ,v.PriceID
             ,v.ClientID
             ,v.Flag
             ,v.Quantity
             ,v.Margin
             ,v.MarginF
             ,v.Profit
             ,v.Income
             ,v.IncomePRC
             ,v.PricePurchase
             ,v.PriceQuantity
             ,v.Comment
             ,v.StatusID
             ,v.MakeLogo
             ,v.PercentSupped -- вероятность доставки
             ,v.DeliveryPlanDateSupplier
             ,v.DeliveryRestTermSupplier
             ,v.DeliveryTermSupplier     -- Срок до поступления поставщику (срок из прайса)
             ,isnull(v.DeliveryDaysReserve2, v.DeliveryDaysReserve) as DeliveryDaysReserve
             ,v.DeliveryTermFromSupplier -- Срок доставки с профиля доставки поставщика
             ,v.DeliveryTermFromCustomerProfile

             ,v.OrderUniqueCount
             ,v.DeliveryTermToCustomer   -- срок клиента
             ,isnull((select count(*)
                        from tPartsStatistics ps (nolock)
                       where ps.OrderUniqueCount >= v.OrderUniqueCount), 999) TopPosition
             ,datediff(day, v.OrderDate, getdate()) PassedDayInWork -- прошло дней с момента заказа
             ,v.Reference
             ,v.CustomerSubID
             ,v.BasketId
         from vOrders v
        where v.OrderID = :OrderID
  ''';

  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.ParamByName('IsSplit').AsBoolean := FIsSplit;
  UniMainModule.Query.Open;

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FReference         := UniMainModule.Query.FieldByName('Reference').AsString;
  FCustomerSubID     := UniMainModule.Query.FieldByName('CustomerSubID').AsString;
  FBasketId          := UniMainModule.Query.FieldByName('BasketId').AsInteger;
  FDetailNumber2     := FManufacturer + ' ' + FDetailNumber;
  FMakeLogo          := UniMainModule.Query.FieldByName('MakeLogo').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;
  FPriceLogoOld      := FPriceLogo;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FMargin            := UniMainModule.Query.FieldByName('Margin').AsFloat;
  FFlag              := UniMainModule.Query.FieldByName('Flag').AsInteger;
  FClientID          := UniMainModule.Query.FieldByName('ClientID').AsInteger;
  FStatusID          := UniMainModule.Query.FieldByName('StatusID').AsInteger;
  FSuppliersID       := UniMainModule.Query.FieldByName('SuppliersID').AsInteger;
  FPercentSupped     := UniMainModule.Query.FieldByName('PercentSupped').AsInteger;

  edtWeightKG.Text   := UniMainModule.Query.FieldByName('WeightKG').AsString;
  edtVolumeKG.Text   := UniMainModule.Query.FieldByName('VolumeKG').AsString;

  lblChangeW.visible := FFlag and 512 > 0;

  if FFlag and 512 > 0 then
  begin
    if UniMainModule.Query.FieldByName('WeightKGF').asFloat = 0 then
       edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('WeightKG').AsString   // Вес Физический факт
    else
      edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;  // Вес Физический факт

    if UniMainModule.Query.FieldByName('VolumeKGF').asFloat = 0 then
       edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKG').AsString  // Вес Объемный факт
    else
      edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString; // Вес Объемный факт
  end
  else
  begin
    edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString;   // Вес Объемный факт
    edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;   // Вес Физический факт
  end;

  edtDetailNameF.text:= UniMainModule.Query.FieldByName('DetailName').AsString;

  FProfilesCustomerID:= UniMainModule.Query.FieldByName('ProfilesCustomerID').asinteger;
  FProfilesDeliveryID:= UniMainModule.Query.FieldByName('ProfilesDeliveryID').asinteger;

  cbPrice.FillFromSQL('exec OrderF_SupplierList '+
                      '  @OrderID=' + FID.ToString +
                      ' ,@ProfilesDeliveryID=' + FProfilesDeliveryID.ToString);

  if (FFlag and 16 {Онлайн заказ}) > 0 then  // направления отгрузки
    cbDestinationLogo.Value:= FProfilesCustomerID.ToString
  else
    cbDestinationLogo.Value:= FProfilesDeliveryID.ToString;

  cbPrice.Value      := UniMainModule.Query.FieldByName('PriceLogo').AsString + '.' +UniMainModule.Query.FieldByName('MakeLogo').AsString;    //
  cbFragile.Checked  := UniMainModule.Query.FieldByName('Fragile').AsBoolean;
  cbNoAir.Checked    := UniMainModule.Query.FieldByName('NoAir').AsBoolean;
  cbNLA.Checked      := UniMainModule.Query.FieldByName('NLA').AsBoolean;
  edtCount.Text      := FQuantity.ToString + '/' + UniMainModule.Query.FieldByName('PriceQuantity').AsString;

  edtMargin.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Margin').AsFloat);
  edtMarginF.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('MarginF').AsFloat);
  edtProfit.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Profit').AsFloat);
  edtPrice.Text      := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').AsFloat);
  edtIncome.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').AsFloat);
  edtKurs.Value      := UniMainModule.Query.FieldByName('Kurs').AsFloat;
  edtExtraKurs.Value := UniMainModule.Query.FieldByName('ExtraKurs').AsFloat;
  edtCurKurs.Value   := UniMainModule.Query.FieldByName('CurKurs').AsFloat;
  edtCurExtraKurs.Value:= UniMainModule.Query.FieldByName('CurExtraKurs').AsFloat;

  FPassedDayInWork := UniMainModule.Query.FieldByName('PassedDayInWork').asInteger;        // дней в обработке
  FDeliveryTermSupplier := UniMainModule.Query.FieldByName('DeliveryTermSupplier').asInteger;   // Срок поставщика из прайса
  FDeliveryDaysReserve  := UniMainModule.Query.FieldByName('DeliveryDaysReserve').asInteger;   // Запас до вылета
  FDeliveryTermFromSupplierProfile := UniMainModule.Query.FieldByName('DeliveryTermFromSupplier').asInteger; // Доставка

  // !!! тут по идее можно оставить только DeliveryTermToCustomer
  FDeliveryTermFromCustomerProfile :=
  IfThen((FFlag and Integer(TOrderFlag.ORDER_ONLINE)) > 0,
  UniMainModule.Query.FieldByName('DeliveryTermToCustomer').asInteger,
  UniMainModule.Query.FieldByName('DeliveryTermFromCustomerProfile').asInteger);

  //  Срок поставки:
  edtDelivery.Text   := FPassedDayInWork.ToString + '+' +         // дней в обработке
                        FDeliveryTermSupplier.ToString + '+' +    // Срок поставщика из прайса
                        FDeliveryDaysReserve.ToString+ '+' +      // Запас до вылета
                        FDeliveryTermFromSupplierProfile.ToString + // Доставка
                        '=' +
                        (
                          FPassedDayInWork +         // дней в обработке
                          FDeliveryTermSupplier+     // Срок поставщика из прайса
                          FDeliveryDaysReserve+      // Запас до вылета
                          FDeliveryTermFromSupplierProfile // Доставка
                        ).ToString +

                        '(' +
                        IfThen(FPassedDayInWork+
                               FDeliveryTermSupplier+
                               FDeliveryDaysReserve+
                               FDeliveryTermFromSupplierProfile-
                               FDeliveryTermFromCustomerProfile > 0, '+', '') +

                        (
                          FPassedDayInWork +         // дней в обработке
                          FDeliveryTermSupplier+     // Срок поставщика из прайса
                          FDeliveryDaysReserve+      // Запас до вылета
                          FDeliveryTermFromSupplierProfile- // Доставка
                          FDeliveryTermFromCustomerProfile
                        ).ToString +
                        ')';

  FPrice             := UniMainModule.Query.FieldByName('PricePurchase').AsFloat;
  FMarginF           := UniMainModule.Query.FieldByName('MarginF').AsFloat;
  FIncome            := UniMainModule.Query.FieldByName('IncomePrc').AsFloat;
  FProfin            := UniMainModule.Query.FieldByName('Profit').AsFloat;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FPriceQuantity     := UniMainModule.Query.FieldByName('PriceQuantity').AsInteger;

  FPrice2            := FPrice;
  FMarginF2          := FMarginF;
  FIncome2           := FIncome;
  FProfin2           := FProfin;
  FQuantity2         := FQuantity;

  edtMargin2.Text    := edtMargin.Text;
  edtMarginF2.Text   := edtMarginF.Text;
  edtProfit2.Text    := edtProfit.Text;
  edtPrice2.Text     := edtPrice.Text;
  edtIncome2.Text    := edtIncome.Text;
  edtDelivery2.text  := edtDelivery.Text;

  SetDeliveryHint;

  SetIndicatorsStyle(UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  SetDeliveryStyle((FPassedDayInWork+
                    FDeliveryTermSupplier+
                    FDeliveryDaysReserve+
                    FDeliveryTermFromSupplierProfile-
                    FDeliveryTermFromCustomerProfile));

  SetEditDataStyle;

  edtDelivery2.Color := edtDelivery.Color;

  Self.Caption:='Заказ от:' + UniMainModule.Query.FieldByName('OrderDate').AsString + ' ' +
                UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
                UniMainModule.Query.FieldByName('DetailNumber').AsString+ ' ' +
                UniMainModule.Query.FieldByName('DetailName').AsString;

  js :=
  '''
    var header = document.querySelector(".x-header-orderf .x-window-header-title");
    if (header) {

        var div = document.querySelector(".part-top-label");

        if (div) {
           div.remove()
        };
  ''';

  if UniMainModule.Query.FieldByName('TopPosition').asinteger <= 100 then
  begin
    js := js +
    '''
        var div = document.createElement("div");
        div.className = "part-top-label";
        header.append(div);
    '''+
    'div.innerHTML = "Количество заказов:' + UniMainModule.Query.FieldByName('OrderUniqueCount').AsString +
    ' Топ-' + UniMainModule.Query.FieldByName('TopPosition').AsString + '";';
  end;

  js := js + '}';

  UniSession.AddJS(js);

  IsExistNext := True;

  WeightKGFStyle;

  FIsSplit:=False;
  FSplitQuantity:=0;
end;

end.


