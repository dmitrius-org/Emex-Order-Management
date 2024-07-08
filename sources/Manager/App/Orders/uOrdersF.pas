
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
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

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
    cbPrice: TUniComboBox;
    ImageList16: TUniImageList;
    UniBitBtn1: TUniBitBtn;
    UniTimer: TUniTimer;
    btnNumber: TUniButton;
    btnNumber2: TUniButton;
    btnDestinationLogo: TUniBitBtn;
    MessageContainer: TUniFieldContainer;
    UniLabel3: TUniLabel;
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
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure edtLChange(Sender: TObject);
    procedure btnGoogleImagesClick(Sender: TObject);
    procedure btnYandexImagesClick(Sender: TObject);
    procedure btnExistClick(Sender: TObject);
    procedure btnZZAPClick(Sender: TObject);
    procedure btnEmExClick(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
    procedure UniTimerTimer(Sender: TObject);
    procedure edtVKGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnNumberClick(Sender: TObject);
    procedure btnNumber2Click(Sender: TObject);
    procedure btnDestinationLogoClick(Sender: TObject);
    procedure cbPriceChange(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure edtWeightKGFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtWeightKGFExit(Sender: TObject);
    procedure cbDestinationLogoChange(Sender: TObject);
    procedure btnOkToCancelClick(Sender: TObject);
    procedure btnOkToProcClick(Sender: TObject);
    procedure edtDetailNameFRemoteQuery(const QueryString: string;
      Result: TStrings);


  private
    FAction: TFormAction;
    FID: Integer;
    FFlag: Integer;
    FClientID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;
    FManufacturer:string;
    FQuantity: Integer;
    FMargin: Real;
    FPrice: Real;
    //FStatus: string;
    FStatusID: Integer;
    FIsCounter: Boolean;

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
  public
    { Public declarations }

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
    property IsCounter: Boolean read FIsCounter write FIsCounter;

    procedure GetPartRatingFromDB(DetailNumber, PriceLogo: string);

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

    procedure SetIndicatorsStyle(AIncome: real);
    procedure SetEditDataStyle(AIncome: real);

    procedure SetBtnEnabled();

    procedure OrderUpdate(ATargetStateID: integer = 0);


    procedure LoadDataPart();

    procedure LoadDataPartFromEmex();
    procedure LoadNextPart();
  end;

function OrderF: TOrderF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils, uLogger, ServerModule, uOrdersT;

function OrderF: TOrderF;
begin
  Result := TOrderF(UniMainModule.GetFormInstance(TOrderF));
end;

{ TOrderF }

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
        sqltext :='''
                   declare @R      int

                   exec @r = OrderUpdate
                               @OrderID      = :OrderID
                              ,@DetailNameF  = :DetailNameF
                              ,@WeightKGF    = :WeightKGF
                              ,@VolumeKGF    = :VolumeKGF
                              ,@Fragile      = :Fragile
                              ,@NoAir        = :NoAir
                              ,@Price        = :Price
                              ,@DestinationLogo=:DestinationLogo
                              ,@Comment        =:Comment
                              ,@TargetStateID  =:TargetStateID
                   select @r as retcode
                  ''';

        Sql.Open(sqltext,
                 ['WeightKGF','VolumeKGF','DetailNameF', 'OrderID', 'Price',
                  'DestinationLogo', 'Fragile', 'NoAir', 'Comment', 'TargetStateID'],
                 [edtWeightKGF.Value,
                  edtVolumeKGF.Value,
                  edtDetailNameF.Text,
                  FID,
                  cbPrice.Text,
                  cbDestinationLogo.Value ,
                  cbFragile.Checked,
                  cbNoAir.Checked,
                  edtMessage.Text,
                  ATargetStateID
                  ]);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      end;
    end;
  end;

  if RetVal.Code = 0 then
  begin

    if not edtNextPart.Checked then
      ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TOrderF.btnOkClick(Sender: TObject);
begin
  OrderUpdate();

  LoadNextPart();
end;

procedure TOrderF.btnOkToCancelClick(Sender: TObject);
begin
  OrderUpdate(12 {InCancel	Отказан});

  LoadNextPart();
end;

procedure TOrderF.btnOkToProcClick(Sender: TObject);
begin
  OrderUpdate( 2 {InChecked	Проверено});

  LoadNextPart();
end;

procedure TOrderF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//      if edtBrief.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := 'Поле [Сокращение] обязательна к заполнению!'; Exit();
//      end
//    end;
//  end;
end;

procedure TOrderF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
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
                                         ,v.[Quantity]
                                         ,v.[Margin]
                                         ,v.[MarginF]
                                         ,v.[Profit]
                                         ,v.[Income]
                                         ,v.[IncomePRC]
                                         ,v.[PricePurchase]
                                         ,v.[PriceQuantity]
                                         ,v.[Comment]
                                         ,v.StatusID
                                         --,n.Brief as Status
                                     from vOrders v
                                    --inner join tNodes n (nololck)
                                      --      on n.NodeID = v.StatusID
                                    where v.OrderID = :OrderID
                                  ''';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FDetailNumber2     := UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' + FDetailNumber;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FMargin            := UniMainModule.Query.FieldByName('Margin').Value;
  //FStatus            := UniMainModule.Query.FieldByName('Status').AsString;
  FStatusID          := UniMainModule.Query.FieldByName('StatusID').AsInteger;
  edtWeightKG.Text   := UniMainModule.Query.FieldByName('WeightKG').AsString;
  edtVolumeKG.Text   := UniMainModule.Query.FieldByName('VolumeKG').AsString;
  edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;    // Вес Физический факт
  edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString;    // Вес Объемный факт

  edtDetailNameF.text:= UniMainModule.Query.FieldByName('DetailName').AsString;   //

  cbPrice.text       := UniMainModule.Query.FieldByName('PriceLogo').AsString;    //
  cbDestinationLogo.Value:= UniMainModule.Query.FieldByName('DestinationLogo').AsString; // направление отгрузки
  FFlag              := UniMainModule.Query.FieldByName('Flag').AsInteger;
  FClientID          := UniMainModule.Query.FieldByName('ClientID').AsInteger;

  cbFragile.Checked  := UniMainModule.Query.FieldByName('Fragile').AsBoolean;
  cbNoAir.Checked    := UniMainModule.Query.FieldByName('NoAir').AsBoolean;

  edtMessage.Text    := UniMainModule.Query.FieldByName('Comment').AsString;

  edtCount.Text      := FQuantity.ToString + '/' +
                        UniMainModule.Query.FieldByName('PriceQuantity').AsString;

  edtMargin.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Margin').AsFloat);
  edtMarginF.Text    := FormatFloat('##0%',  UniMainModule.Query.FieldByName('MarginF').AsFloat);
  edtProfit.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('Profit').AsFloat);
  edtPrice.Text      := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').AsFloat);
  edtIncome.Text     := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  FPrice             := UniMainModule.Query.FieldByName('PricePurchase').AsFloat;
  SetIndicatorsStyle(UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  // при загрузке данные совпадают
  edtMargin2.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('Margin').AsFloat);
  edtMarginF2.Text   := FormatFloat('##0%',  UniMainModule.Query.FieldByName('MarginF').AsFloat);
  edtProfit2.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('Profit').AsFloat);
  edtPrice2.Text     := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').AsFloat);
  edtIncome2.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  SetEditDataStyle(UniMainModule.Query.FieldByName('IncomePRC').AsFloat);

  //16 - Онлайн заказ
  MessageContainer.Visible := ((FFlag and 16) = 0)  and (UniMainModule.Query.FieldByName('PriceID').AsInteger = 0);

  Self.Caption:= ' ' +
      UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
      UniMainModule.Query.FieldByName('DetailNumber').AsString+ ' ' +
      UniMainModule.Query.FieldByName('DetailName').AsString;
end;

procedure TOrderF.SetIndicatorsStyle(AIncome: real);
begin
  if AIncome >= 0 then
    edtMarginF.Color :=   $0080FF80
  else
    edtMarginF.Color :=   $008080FF;

  edtProfit.Color :=   edtMarginF.Color;
  edtIncome.Color :=   edtMarginF.Color;
  edtDelivery.Color :=   edtMarginF.Color;
  edtDeliveryClient.Color :=   edtMarginF.Color;
  edtCount.Color :=  edtMarginF.Color;
  edtReliability.Color :=   edtMarginF.Color;
end;

procedure TOrderF.SetEditDataStyle(AIncome: real);
begin
  if AIncome >= 0 then
    edtMarginF2.Color :=   $0080FF80
  else
    edtMarginF2.Color :=   $008080FF;

  edtProfit2.Color :=   edtMarginF2.Color;
  edtIncome2.Color :=   edtMarginF2.Color;
  edtDelivery2.Color :=   edtMarginF2.Color;
  edtDeliveryClient2.Color :=   edtMarginF2.Color;
  edtCount2.Color :=  edtMarginF2.Color;
  edtReliability2.Color :=   edtMarginF2.Color;
end;



procedure TOrderF.edtDetailNameFRemoteQuery(const QueryString: string;
  Result: TStrings);
begin
   sql.Open(
   '''
    select distinct top 50 Name_RUS
      from tPartDescription  (nolock)
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
//  ShowMessage(KEY.ToString);
  if (KEY = 13) then //enter
  begin
     edtVolumeKGF.Value := edtVKG.Value;
  end;
end;

procedure TOrderF.edtWeightKGFExit(Sender: TObject);
begin
//   PriceCalc();
//   GetPartDataFromDB;
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

procedure TOrderF.getPartRatingFromDB2;
var js: string;
     r: string;
begin
  logger.Info('getPartRatingFromDB2 begin');
  logger.Info('getPartRatingFromDB2 DetailNum:' + FDetailNumber);
  logger.Info('getPartRatingFromDB2 PriceLogo:' + cbPrice.Text);
  logger.Info('getPartRatingFromDB2 DestinationLogo:' + cbDestinationLogo.Value);

  sql.Open('''
           select top 1 *,
                  case
                    when p.Available = -1 then 'под заказ'
                    else cast(p.Available as nvarchar)
                  end as AvailableStr -- наличие детали на складе
                 ,f.MarginF
                 ,f.IncomePrc
                 ,f.Profit
             from pFindByNumber p (nolock)
            inner join pOrdersFin f (nolock)
                    on f.spid = @@spid
            where p.spid            = @@spid
              and p.DetailNum       = :DetailNum
              and p.PriceLogo       = :PriceLogo
              --and p.DestinationLogo = :DestinationLogo
            order by p.PercentSupped desc
           ''',
           ['DetailNum', 'PriceLogo'{, 'DestinationLogo'}],
           [FDetailNumber, cbPrice.Text{, cbDestinationLogo.Value}]);

  if sql.Q.RecordCount>0 then
  begin
    edtCount2.Text     := FQuantity.ToString + '/' + sql.Q.FieldByName('AvailableStr').AsString;
    edtMargin2.Text    := FormatFloat('##0%', FMargin);
    edtMarginF2.Text   := FormatFloat('##0%',  sql.q.FieldByName('MarginF').AsFloat);
    edtProfit2.Text    := FormatFloat('##0%', sql.q.FieldByName('Profit').AsFloat);

    var t: Real;
    t:= SimpleRoundTo(sql.q.FieldByName('Price').Value*100/FPrice - 100, -2);


    if t > 0 then
      r := '+'
    else
    if t < 0 then
      r := '-'
    else
      r := '';

    r := r + FloatToStr(t);

    edtPrice2.Text     := FormatFloat('$###,##0.00', sql.q.FieldByName('Price').AsFloat) + ' ('+ r + '%)';
    edtIncome2.Text    := FormatFloat('##0%', sql.q.FieldByName('IncomePrc').AsFloat);

    SetEditDataStyle( sql.q.FieldByName('IncomePRC').AsFloat);
    SetEditDataRating(sql.Q.FieldByName('PercentSupped').AsInteger);

  end;
  logger.Info('getPartRatingFromDB2 end');
end;

procedure TOrderF.getPartRatingFromDB(DetailNumber, PriceLogo: string);
var js: string;
     r: string;
begin
  logger.Info('getPartRatingFromDB');
  sql.Open('''
           select top 1 PercentSupped
             from pFindByNumber (nolock)
            where spid     = @@spid
              and DetailNum=:DetailNum
              and PriceLogo=:PriceLogo
            order by PercentSupped desc
           ''',
           ['DetailNum', 'PriceLogo'],
           [DetailNumber, PriceLogo]);

  if sql.Q.RecordCount>0 then
  begin
    SetRating(sql.Q.FieldByName('PercentSupped').AsInteger);
  end
  else
  begin
     MessageContainer.Visible := (FFlag and 16) > 0; //16 - Онлайн заказ
  end;
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
    //  /*
//          Update pFindByNumber
//             set WeightGr        = isnull(nullif(:WeightGr, -1), 0)
//                ,VolumeAdd       = isnull(nullif(:VolumeAdd, -1), 0)
//                ,DestinationLogo =:DestinationLogo
//                ,Flag      = isnull(Flag, 0) | 512 -- 512 - Вес изменен клиентом
//           where Spid = @@Spid
//
//          exec SearchPriceCalc
//                  @DestinationLogo = :DestinationLogo,
//                  @DetailNum       = :DetailNum
//                        */
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

             and p.DetailNum       = :DetailNum
             and p.PriceLogo       = :PriceLogo

            exec OrdersFinCalc
                   @IsSave = 0,
                   @IsFilled=1

  ''',
  ['DestinationLogo', 'DetailNum', 'PriceLogo', 'WeightGr', 'VolumeAdd', 'OrderID'],
  [cbDestinationLogo.Value, FDetailNumber,  cbPrice.Text, edtWeightKGF.Value, edtVolumeKGF.Value, FID]);
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

  end;

  btnOkToCancel.Enabled := FStatusID in [1, 2, 3, 22];
  btnOkToProc.Enabled := FStatusID in [1, 22];
end;

procedure TOrderF.SetOpenUrl(AUrl: string);
begin
  UniSession.BrowserWindow(AUrl, 0, 0, '_blank');
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

      edtDetailNameF.SetFocus;
    end
  else
    //
  end;

  SetBtnEnabled;
end;

procedure TOrderF.LoadDataPartFromEmex;
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

procedure TOrderF.LoadNextPart;
begin
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

  if sql.Q.RecordCount > 0 then
  begin
    ID := sql.Q.FieldByName('OrderID').AsInteger;

    SetRating(0);
    SetEditDataRating(0);

    LoadDataPart;
    LoadDataPartFromEmex;

  end;
end;

procedure TOrderF.UniFormReady(Sender: TObject);
begin
  LoadDataPartFromEmex;
end;

procedure TOrderF.UniFormShow(Sender: TObject);
begin

  btnOk.Caption := ' Сохранить';

  //ComboBoxFill(cbRestrictions, ' Select Name from tRestrictions (nolock) where Flag&1=1 ');
  ComboBoxFill(cbPrice,        ' Select Name from tPrices (nolock) where Flag&1=1 ');

  LoadDataPart;
end;

procedure TOrderF.UniTimerTimer(Sender: TObject);
begin
  try
    Sql.Open('select 1 from #IsPart (nolock)', [],[]);
    logger.Info('UniTimerTimer IsPart:' + Sql.Q.RecordCount.ToString);

    if Sql.Q.RecordCount > 0 then
    begin

      getPartRatingFromDB(FDetailNumber, FPriceLogo);

      PriceCalc();

      getPartRatingFromDB2();

      UniTimer.Enabled := False;
    end;
  finally
  end;
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
  Emex.Connection := FConnection;
  Emex.FindByDetailNumber(FClientID, FDetailNumber);

  Emex.SQl.Exec('insert #IsPart (IsPart)  select 1', [],[]);

  FreeAndNil(Emex);
end;

end.
