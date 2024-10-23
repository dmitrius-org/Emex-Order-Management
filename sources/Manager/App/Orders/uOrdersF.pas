
unit uOrdersF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,
  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  unimURLFrame, uniCheckBox, uniMemo, uniHTMLMemo, uniListBox, uniFieldSet,
  UniFSCombobox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, uniMainMenu,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type

  TSQLQueryThread = class(TThread)
  private
    FConnection: TFDConnection;
    FClientID: Integer;
    FDetailNumber: string;
    FPriceLogo: string;
  protected
    procedure Execute(); override;
  public
    constructor Create(AConnection: TFDConnection; AClientID: Integer; ADetailNumber, APriceLogo: string);
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
    ImageList16: TUniImageList;
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
    UniLabel13: TUniLabel;
    edtMessage: TUniEdit;
    UniGroupBox9: TUniGroupBox;
    edtPrice: TUniEdit;
    edtMargin: TUniEdit;
    edtMarginF: TUniEdit;
    edtIncome: TUniEdit;
    edtProfit: TUniEdit;
    edtDelivery: TUniEdit;
    edtDeliveryClient: TUniEdit;
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
    edtDeliveryClient2: TUniEdit;
    edtCount2: TUniEdit;
    cbDestinationLogo: TUniFSComboBox;
    btnOkToCancel: TUniBitBtn;
    btnOkToProc: TUniBitBtn;
    edtNextPart: TUniCheckBox;
    edtDetailNameF: TUniComboBox;
    NotExists: TUniLabel;
    cbPrice: TUniFSComboBox;
    UniActionList1: TUniActionList;
    actRefreshFormDate: TAction;
    UniHTMLFrame1: TUniHTMLFrame;
    UniContainerPanel1: TUniContainerPanel;
    actProtocol: TAction;
    UniNativeImageList1: TUniNativeImageList;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtLChange(Sender: TObject);
    procedure btnGoogleImagesClick(Sender: TObject);
    procedure btnYandexImagesClick(Sender: TObject);
    procedure btnExistClick(Sender: TObject);
    procedure btnZZAPClick(Sender: TObject);
    procedure btnEmExClick(Sender: TObject);
    procedure edtVKGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnNumberClick(Sender: TObject);
    procedure btnNumber2Click(Sender: TObject);
    procedure btnDestinationLogoClick(Sender: TObject);
    procedure cbPriceChange(Sender: TObject);
    procedure edtWeightKGFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbDestinationLogoChange(Sender: TObject);
    procedure btnOkToCancelClick(Sender: TObject);
    procedure btnOkToProcClick(Sender: TObject);
    procedure edtDetailNameFRemoteQuery(const QueryString: string; Result: TStrings);
    procedure actRefreshFormDateExecute(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
    procedure actProtocolExecute(Sender: TObject);

  private
    FAction: TFormAction;
    /// <remarks> FID - Идентификатор заказа </remarks>
    FID: Integer;
    FFlag: Integer;
    FClientID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;

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

    /// <value>FStatusID - текущее состояние</value>
    FStatusID: Integer;
    FIsCounter: Boolean;

    /// <value>FGoogleKey - ключ к программируемой поисковой системы google</value>
    FGoogleKey : string;

    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

    procedure SetOpenUrl(AUrl: string);

    /// <summary>
    ///  GooglePSE - интеграция программируемой поисковой системы google
    ///</summary>
    procedure GooglePSE();
  public
    { Public declarations }

    var IsExistNext: Boolean;

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
    property IsCounter: Boolean read FIsCounter write FIsCounter;

    ///<summary>
    ///  getPartRatingFromDB2 - получение данных по детали после изменения данных
    ///</summary>
    procedure getPartRatingFromDB2();

    procedure SetRating(ARating: integer);

    procedure SetEditDataRating(ARating: integer);

    /// <summary>
    /// PriceCalc - расчет цены и срока поставки
    /// </summary>
    procedure PriceCalc();

    /// <summary>
    /// SetIndicatorsStyle - Установка стилей для показателей: Показатели до изменения
    /// </summary>
    procedure SetIndicatorsStyle(AIncome: real);

    /// <summary>
    /// PriceCalc - Установка стилей для показателей: Показатели после изменения
    /// </summary>
    procedure SetEditDataStyle();

    procedure SetBtnEnabled();

    /// <summary>
    /// OrderUpdate - Изменение информации по заказу
    /// </summary>
    procedure OrderUpdate(ATargetStateID: integer = 0);

    /// <summary>
    /// LoadDataPart - получение данных по детали из базы
    /// </summary>
    procedure LoadDataPart();

    procedure GetPartFromEmex();

    function LoadNextPart():Boolean;
  end;

function OrderF: TOrderF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils, uLogger, ServerModule, uOrdersT, uToast, uOrdersProtocol_T;

function OrderF: TOrderF;
begin
  Result := TOrderF(UniMainModule.GetFormInstance(TOrderF));
end;



{ TSQLQueryThread }

constructor TSQLQueryThread.Create(AConnection: TFDConnection; AClientID: Integer; ADetailNumber, APriceLogo: string);
begin
  inherited Create(False);

  FConnection  := AConnection;
  FClientID    := AClientID;
  FPriceLogo   := APriceLogo;
  FDetailNumber:= ADetailNumber;
end;

procedure TSQLQueryThread.Execute();
var Emex:TEmex;
begin
  Emex := TEmex.Create;
  try
    Emex.Connection := FConnection;
    Emex.FindByDetailNumber(FClientID, FDetailNumber);

    Emex.SQl.Exec('insert #IsPart (IsPart)  select 1', [],[]);
  finally
    Emex.Destroy;
  end;
end;

{ TOrderF }

procedure TOrderF.actProtocolExecute(Sender: TObject);
begin
  OrdersProtocol_T.ID:= FID;
  OrdersProtocol_T.ShowModal;
end;

procedure TOrderF.actRefreshFormDateExecute(Sender: TObject);
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
  cbDestinationLogo.Enabled := true;
  cbDestinationLogo.SetFocus;
end;

procedure TOrderF.btnEmExClick(Sender: TObject);
var
  HeaderPanel: TUniPanel;
  NewButton: TUniButton;
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
  FMakeLogo          := cbPrice.Value.Substring(Pos('.', cbPrice.Value),  4);
  FPriceLogo         := cbPrice.Value.Substring(0, Pos('.', cbPrice.Value)-1);

  logger.Info('cbPrice.Value: ' + cbPrice.Value);
  logger.Info('FMakeLogo:  ' + FMakeLogo);
  logger.Info('FPriceLogo: ' + FPriceLogo);

  PriceCalc();
  getPartRatingFromDB2;
end;

procedure TOrderF.cbPriceChange(Sender: TObject);
begin
  PriceCalc();
  getPartRatingFromDB2;
end;

procedure TOrderF.btnNumber2Click(Sender: TObject);
begin
  btnNumber2.JSInterface.JSCall('copyToClipboard', [FDetailNumber2]);
end;

procedure TOrderF.btnNumberClick(Sender: TObject);
var js: string;
begin
  btnNumber.JSInterface.JSCall('copyToClipboard', [FDetailNumber]);
end;

procedure TOrderF.OrderUpdate(ATargetStateID: integer = 0); var sqltext: string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin

        // если заказа в корзине, нужно его удалить
        if (FStatusID = 3)	{InBasket	В корзине}  and (ATargetStateID = 12) then
        begin
            var Emex:TEmex;

            Emex := TEmex.Create;
            try
              Emex.Connection := UniMainModule.FDConnection;
              RetVal.Code := Emex.DeleteFromBasketByOrderID(FID);

              Emex.SQl.Exec('insert #IsPart (IsPart)  select 1', [],[]);
            finally
              Emex.Destroy;
            end;
        end;

        if RetVal.Code = 0 then
        begin
          sqltext :='''
                     declare @R      int

                     exec @r = OrderUpdate
                                 @OrderID        = :OrderID
                                ,@DetailNameF    = :DetailNameF
                                ,@WeightKGF      = :WeightKGF
                                ,@VolumeKGF      = :VolumeKGF
                                ,@Fragile        = :Fragile
                                ,@NoAir          = :NoAir
                                ,@Price          = :Price
                                ,@DestinationLogo=:DestinationLogo
                                ,@Comment        =:Comment
                                ,@TargetStateID  =:TargetStateID
                                ,@MakeLogo       =:MakeLogo
                                ,@ReplacementPrice = :ReplacementPrice
                     select @r as retcode
          ''';

          Sql.Open(sqltext,
                   ['WeightKGF','VolumeKGF','DetailNameF', 'OrderID', 'Price', 'MakeLogo',
                    'DestinationLogo', 'Fragile', 'NoAir', 'Comment', 'TargetStateID', 'ReplacementPrice'],
                   [edtWeightKGF.Value,
                    edtVolumeKGF.Value,
                    edtDetailNameF.Text,
                    FID,
                    FPriceLogo,
                    FMakeLogo,
                    cbDestinationLogo.Value ,
                    cbFragile.Checked,
                    cbNoAir.Checked,
                    edtMessage.Text,
                    ATargetStateID,
                    FPrice2
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

procedure TOrderF.UniBitBtn1Click(Sender: TObject);
begin
  cbPrice.Enabled := true;
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

  LoadDataPart;
end;

procedure TOrderF.UniTimerTimer(Sender: TObject);
var Price: string;
begin
  try
    Sql.Open('select 1 from #IsPart (nolock)', [],[]);
    logger.Info('UniTimerTimer IsPart:' + Sql.Q.RecordCount.ToString);

    if Sql.Q.RecordCount > 0 then
    begin
      PriceCalc();

      getPartRatingFromDB2();

      UniTimer.Enabled := False;
    end;
  finally
  end;
end;

procedure TOrderF.btnOkClick(Sender: TObject);
begin
  btnOk.Enabled := False;
  OrderUpdate();

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.btnOkToCancelClick(Sender: TObject);
begin
  btnOkToCancel.Enabled := False;
  OrderUpdate(12 {InCancel	Отказан});

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.btnOkToProcClick(Sender: TObject);
begin
  btnOkToProc.Enabled := False;

  OrderUpdate( 2 {InChecked	Проверено});

  if RetVal.Code = 0 then
  begin
    IsExistNext := LoadNextPart();
  end;

  SetBtnEnabled;
end;

procedure TOrderF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtDetailNameF.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
        Exit();
      end
    end;
  end;
end;

procedure TOrderF.DataLoad;
var js: string;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
       delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid

       select v.WeightKG
             ,v.VolumeKG
             ,v.WeightKGF
             ,v.VolumeKGF
             ,v.DetailName as DetailName
             ,v.Manufacturer
             ,v.DetailNumber
             ,v.NoAir
             ,v.Fragile
             ,v.PriceLogo
             ,v.Manufacturer
             ,v.DestinationLogo
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
             ,v.OrderUniqueCount
             ,isnull((select count(*)
                        from tPartsStatistics ps (nolock)
                       where ps.OrderUniqueCount >= v.OrderUniqueCount), 999) TopPosition

         from vOrders v
        where v.OrderID = :OrderID
  ''';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  ComboBoxFill(cbPrice,
  '''
    -- список поставщиков
    OrderF_SupplierList
               @OrderID =
  ''' + FID.ToString);

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;

  FDetailNumber2     := FManufacturer + ' ' + FDetailNumber;

  FMakeLogo          := UniMainModule.Query.FieldByName('MakeLogo').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FMargin            := UniMainModule.Query.FieldByName('Margin').Value;
  FFlag              := UniMainModule.Query.FieldByName('Flag').AsInteger;
  FClientID          := UniMainModule.Query.FieldByName('ClientID').AsInteger;
  FStatusID          := UniMainModule.Query.FieldByName('StatusID').AsInteger;
  FPercentSupped     :=  UniMainModule.Query.FieldByName('PercentSupped').AsInteger;

  edtWeightKG.Text   := UniMainModule.Query.FieldByName('WeightKG').AsString;
  edtVolumeKG.Text   := UniMainModule.Query.FieldByName('VolumeKG').AsString;
  edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;    // Вес Физический факт
  edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString;    // Вес Объемный факт
  edtDetailNameF.text:= UniMainModule.Query.FieldByName('DetailName').AsString;   //
  cbPrice.Value      := UniMainModule.Query.FieldByName('PriceLogo').AsString + '.' +UniMainModule.Query.FieldByName('MakeLogo').AsString;    //
  cbDestinationLogo.Value:= UniMainModule.Query.FieldByName('DestinationLogo').AsString; // направление отгрузки

  cbFragile.Checked  := UniMainModule.Query.FieldByName('Fragile').AsBoolean;
  cbNoAir.Checked    := UniMainModule.Query.FieldByName('NoAir').AsBoolean;
  edtMessage.Text    := UniMainModule.Query.FieldByName('Comment').AsString;
  edtCount.Text      := FQuantity.ToString + '/' + UniMainModule.Query.FieldByName('PriceQuantity').AsString;

  edtMargin.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Margin').AsFloat);
  edtMarginF.Text    := FormatFloat('##0%',  UniMainModule.Query.FieldByName('MarginF').AsFloat);
  edtProfit.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Profit').AsFloat);
  edtPrice.Text      := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').AsFloat);
  edtIncome.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').AsFloat);
  edtDelivery.Text   := UniMainModule.Query.FieldByName('DeliveryRestTermSupplier').AsString;
  edtDelivery.Hint   := 'Плановая дата поступления поставщику: ' + UniMainModule.Query.FieldByName('DeliveryPlanDateSupplier').AsString;

  FPrice             := UniMainModule.Query.FieldByName('PricePurchase').AsFloat;
  //
  FMarginF           := UniMainModule.Query.FieldByName('MarginF').AsFloat;
  FIncome            := UniMainModule.Query.FieldByName('IncomePrc').AsFloat;
  FProfin            := UniMainModule.Query.FieldByName('Profit').AsFloat;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FPriceQuantity     := UniMainModule.Query.FieldByName('PriceQuantity').AsInteger;
  //
  FPrice2            := UniMainModule.Query.FieldByName('PricePurchase').AsFloat;
  FMarginF2          := UniMainModule.Query.FieldByName('MarginF').AsFloat;
  FIncome2           := UniMainModule.Query.FieldByName('IncomePrc').AsFloat;
  FProfin2           := UniMainModule.Query.FieldByName('Profit').AsFloat;
  FQuantity2         := UniMainModule.Query.FieldByName('PriceQuantity').AsInteger;
  //
  edtMargin2.Text    := FormatFloat('##0%',  UniMainModule.Query.FieldByName('Margin').AsFloat);
  edtMarginF2.Text   := FormatFloat('##0%',  UniMainModule.Query.FieldByName('MarginF').AsFloat);
  edtProfit2.Text    := FormatFloat('##0%',  UniMainModule.Query.FieldByName('Profit').AsFloat);
  edtPrice2.Text     := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').AsFloat);
  edtIncome2.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').AsFloat);
  edtDelivery2.text  := UniMainModule.Query.FieldByName('DeliveryRestTermSupplier').AsString;
  //
  SetIndicatorsStyle(UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  SetEditDataStyle();

  Self.Caption:=UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
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
  edtDeliveryClient.Color := edtMarginF.Color;
  edtCount.Color          := edtMarginF.Color;
  edtReliability.Color    := edtMarginF.Color;
end;

procedure TOrderF.SetEditDataStyle();
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
  setColor(FMarginF2,  FMarginF,  edtDelivery2);
  setColor(FMarginF2,  FMarginF,  edtDeliveryClient2);
  setColor(FQuantity2, FPriceQuantity, edtCount2);
end;

procedure TOrderF.edtDetailNameFRemoteQuery(const QueryString: string;
  Result: TStrings);
begin
   sql.Open(
   '''
    select distinct top 50
           Name_RUS
      from tPartDescription (nolock)
     where Name_RUS LIKE '' + :Number + '%'
   ''',
   ['Number'], [QueryString]);

    sql.q.First;
    while not sql.q.Eof do
    begin
      Result.Add( sql.q.FieldByName('Name_RUS').AsString );
      sql.q.Next;
    end;
end;

procedure TOrderF.edtLChange(Sender: TObject);
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

procedure TOrderF.edtWeightKGFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    PriceCalc();
    getPartRatingFromDB2;
  end;
end;

procedure TOrderF.getPartRatingFromDB2;  var Price: string;
var js: string;
     r: string;
begin
  logger.Info('getPartRatingFromDB2 begin');

  sql.Open('''
           select top 1 *,
                  case
                    when p.Available = -1 then 'под заказ'
                    else cast(p.Available as nvarchar)
                  end as AvailableStr -- наличие детали на складе
                 ,f.MarginF
                 ,f.IncomePrc
                 ,f.Profit
             from pFindByNumber p with (nolock index= ao3)
            inner join pOrdersFin f with (nolock index= ao1)
                    on f.spid = @@spid
            where p.spid      = @@spid
              and p.Make      = :MakeLogo
              and p.DetailNum = :DetailNum
              and p.PriceLogo = :PriceLogo

            order by p.PercentSupped desc
           ''',
           ['DetailNum', 'PriceLogo', 'MakeLogo'],
           [FDetailNumber, FPriceLogo, FMakeLogo]);

  if sql.Q.RecordCount>0 then
  begin
    FPrice2            := sql.q.FieldByName('Price').Value;
    FMarginF2          := sql.q.FieldByName('MarginF').AsFloat;
    FIncome2           := sql.q.FieldByName('IncomePrc').AsFloat;
    FProfin2           := sql.q.FieldByName('Profit').AsFloat;
    FQuantity2         := sql.Q.FieldByName('Available').AsInteger;

    edtCount2.Text     := FQuantity.ToString + '/' + sql.Q.FieldByName('AvailableStr').AsString;
    edtMargin2.Text    := FormatFloat('##0%', FMargin);
    edtMarginF2.Text   := FormatFloat('##0%', FMarginF2);
    edtProfit2.Text    := FormatFloat('##0%', FProfin2);
    edtDelivery2.text  := sql.Q.FieldByName('GuaranteedDay').AsString;

    var t: Real; t:= SimpleRoundTo(sql.q.FieldByName('Price').Value*100/FPrice - 100, -2);
    if t > 0 then r := '+'
    else
    if t = 0 then r := ''
    else
      r := '';

    r := r + FloatToStr(t);

    edtPrice2.Text     := FormatFloat('$###,##0.00', sql.q.FieldByName('Price').AsFloat) + ' ('+ r + '%)';
    edtIncome2.Text    := FormatFloat('##0%', FIncome2);

    SetEditDataStyle();
    SetEditDataRating(sql.Q.FieldByName('PercentSupped').AsInteger);

    NotExists.Visible := false;
    edtReliability2.Visible := true;
  end
  else
  begin

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

  end;

  Price:=cbPrice.Value;
  // список поставщиков
  ComboBoxFill( cbPrice, ' OrderF_SupplierList @OrderID = ' + FID.ToString );

  cbPrice.Value:=Price;

  logger.Info('getPartRatingFromDB2 end');
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

procedure TOrderF.PriceCalc;
begin
  RetVal.Clear;

  Sql.exec(
  '''
          delete pOrdersFin from pOrdersFin (rowlock) where spid = @@Spid
          insert pOrdersFin
                (Spid
                ,OrderDate
                ,ClientID
                ,Price  -- продажа
                ,PricePurchase
                ,WeightKG
                ,VolumeKG
                ,WeightKGF
                ,VolumeKGF
                ,Taxes
                ,Commission
                ,Margin
                ,ExtraKurs
                ,PdWeightKG
                ,PdVolumeKG
                ,PriceCommission -- Комиссия от продажи
                )
          Select @@spid
                ,o.OrderDate
                ,p.ClientID
                ,o.Price -- цена продажи в рублях c заказа
                ,p.Price -- цена закупки в долларах из АПИ
                ,isnull(o.WeightKG,  0)
                ,isnull(o.VolumeKG , 0)
                ,isnull(:WeightGr,  0)
                ,isnull(:VolumeAdd, 0)
                ,isnull(o.Taxes, c.Taxes)    -- Комиссия + Налоги
                ,isnull(o.Commission, 0)/100 -- Комиссия за оплату  Comission ExtraKurs
                ,isnull(o.Margin, 0)/100     -- Наценка             Margin
                ,isnull(o.ExtraKurs, 0)/100  -- Комиссия на курс    ExtraKurs
                ,pd.WeightKG                 -- Стоимость кг
                ,pd.VolumeKG                 -- Стоимость vкг
                ,o.CommissionAmount       -- Комиссия от продажи
            from pFindByNumber p with (nolock index=ao2)
           inner join tOrders o with (nolock index=ao1)
                   on o.OrderID = :OrderID
           inner join tClients c with (nolock index=ao1)
                   on c.ClientID = o.ClientID
           inner join tProfilesCustomer pc (nolock)
                   on pc.ClientID = c.ClientID
           inner join tSupplierDeliveryProfiles pd with (nolock index=ao2)
                   on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
                  and pd.DestinationLogo = :DestinationLogo
           where p.spid = @@spid
             and p.Make            = :MakeLogo
             and p.DetailNum       = :DetailNum
             and p.PriceLogo       = :PriceLogo

            exec OrdersFinCalc
                   @IsSave = 0,
                   @IsFilled=1

  ''',
  ['DestinationLogo', 'DetailNum', 'PriceLogo', 'WeightGr', 'VolumeAdd', 'OrderID', 'MakeLogo'],
  [cbDestinationLogo.Value, FDetailNumber,  FPriceLogo, edtWeightKGF.Value, edtVolumeKGF.Value, FID, FMakeLogo]);
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

  btnOkToCancel.Enabled := (IsExistNext) and (FStatusID in [1, 2, 3, 22]);
  btnOkToProc.Enabled := (IsExistNext) and (FStatusID in [1, 22]);

  btnOk.Enabled := True;
end;

procedure TOrderF.SetOpenUrl(AUrl: string);
begin
  UniSession.BrowserWindow(AUrl, 0, 0, '_blank');
end;

procedure TOrderF.LoadDataPart;
begin
  ComboBoxFill(cbDestinationLogo,'''
          SELECT distinct
                 pd.[DestinationLogo] as id
                ,pd.[Name]
            FROM tOrders o (nolock)
           inner join tProfilesCustomer pc with (nolock)
                   on pc.ClientID = o.ClientID
           inner join tSupplierDeliveryProfiles pd with (nolock index=ao1)
                   on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
           where o.OrderID =
        ''' + FID.ToString );

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
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

procedure TOrderF.GetPartFromEmex;
var t: TSQLQueryThread;
begin
  try
    sql.Exec('if OBJECT_ID(''tempdb..#IsPart'') is not null drop table #IsPart CREATE TABLE #IsPart (IsPart bit);', [], []);

    t := TSQLQueryThread.Create(UniMainModule.FDConnection, FClientID, FDetailNumber, FPriceLogo);
    t.FreeOnTerminate := True; // Экземпляр должен само уничтожиться после выполнения
    t.Priority := tThreadPriority.tpNormal; // Выставляем приоритет потока
    t.Resume; // непосредственно ручной запуск потока

    UniTimer.Enabled := True;
  finally
  end;
end;

function TOrderF.LoadNextPart:Boolean;
begin
  Result := False;

  if not edtNextPart.Checked then Exit;

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

  sql.q.first;
  if sql.Q.RecordCount > 0 then
  begin
    Result := True;

    ID := sql.Q.FieldByName('OrderID').AsInteger;

    SetRating(0);

    SetEditDataRating(0);

    LoadDataPart;

    GetPartFromEmex;
  end;
end;

procedure TOrderF.GooglePSE;
begin
  logger.info('GooglePSE');

  logger.info(FManufacturer);
  logger.info(FDetailNumber);

  if FGoogleKey = '' then
  begin
    with TStringList.Create() do
    begin
      LoadFromFile('.\files\html\GoogleCSEKeyErr.html');
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

    '''
    , [FGoogleKey, FManufacturer, FDetailNumber]);
end;

end.





