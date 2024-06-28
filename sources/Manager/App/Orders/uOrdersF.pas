
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
  UniFSCombobox;

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
    edtDetailNameF: TUniEdit;
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
    procedure edtWeightKGFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtWeightKGFExit(Sender: TObject);
    procedure cbDestinationLogoChange(Sender: TObject);


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

    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();


    procedure setOpenUrl(AUrl: string);
  public
    { Public declarations }

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;

    procedure GetPartRatingFromDB(DetailNumber, PriceLogo: string);

    ///<summary>
    ///  GetPartDataFromDB - получение данных по детали после изменения данных
    ///</summary>
    procedure GetPartDataFromDB();

    /// <summary>
    /// PriceCalc - расчет цены и срока поставки
    /// </summary>
    procedure PriceCalc();
  end;

function OrderF: TOrderF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils, uLogger, ServerModule;

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
  //UniSession.BrowserWindow(Format('https://emexdwc.ae/Search.aspx?n=%s&d=$DLV$1', [FDetailNumber]), 0, 0, '_blank');
  setOpenUrl(Format('https://emexdwc.ae/Search.aspx?n=%s&d=$DLV$1', [FDetailNumber]));
end;

procedure TOrderF.btnExistClick(Sender: TObject);
begin
//  UniSession.BrowserWindow(Format('https://www.exist.ru/Price/?pcode=%s', [FDetailNumber]), 0, 0, '_blank');
  setOpenUrl(Format('https://www.exist.ru/Price/?igu=1&pcode=%s', [FDetailNumber]));
end;

procedure TOrderF.btnGoogleImagesClick(Sender: TObject);
begin
 // UniSession.BrowserWindow(Format('https://www.google.com/search?tbm=isch&q=%s+%s', [FManufacturer, FDetailNumber]), 0, 0, '_blank');

 setOpenUrl(Format('https://www.google.com/search?igu=1&tbm=isch&q=%s+%s', [FManufacturer, FDetailNumber]));
end;

procedure TOrderF.btnYandexImagesClick(Sender: TObject);
begin
  //UniSession.BrowserWindow(Format('https://yandex.ru/images/search?from=tabbar&text=%s+%s', [FManufacturer, FDetailNumber]), 0, 0, '_blank');
  setOpenUrl(Format('https://yandex.ru/images/search?igu=1&from=tabbar&text=%s+%s', [FManufacturer, FDetailNumber]));
end;

procedure TOrderF.btnZZAPClick(Sender: TObject);
begin
  //UniSession.BrowserWindow(Format('https://www.zzap.ru/public/search.aspx#rawdata=%s', [FDetailNumber]), 0, 0, '_blank');
  setOpenUrl(Format('https://www.zzap.ru/public/search.aspx#rawdata=%s', [FDetailNumber]));
end;

procedure TOrderF.cbDestinationLogoChange(Sender: TObject);
begin
   PriceCalc();
   GetPartDataFromDB;
end;

procedure TOrderF.cbPriceChange(Sender: TObject);
begin
  //getPartRatingFromDB(FDetailNumber, cbPrice.Text);

  PriceCalc();
  GetPartDataFromDB;

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

procedure TOrderF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
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
                   select @r as retcode
                  ''';

        Sql.Open(sqltext,
                 ['WeightKGF','VolumeKGF','DetailNameF', 'OrderID', 'Price',
                  'DestinationLogo', 'Fragile', 'NoAir', 'Comment'],
                 [edtWeightKGF.Value,
                  edtVolumeKGF.Value,
                  edtDetailNameF.Text,
                  FID,
                  cbPrice.Text,
                  cbDestinationLogo.text ,
                  cbFragile.Checked,
                  cbNoAir.Checked,
                  edtMessage.Text
                  ]);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      end;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
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
                                    select WeightKG
                                         ,VolumeKG
                                         ,WeightKGF
                                         ,VolumeKGF
                                         ,DetailName as DetailName
                                         ,Manufacturer
                                         ,DetailNumber
                                         ,NoAir
                                         ,Fragile
                                         ,PriceLogo
                                         ,Manufacturer
                                         ,DestinationLogo
                                         ,SuppliersID
                                         ,PriceID
                                         ,ClientID
                                         ,Flag
                                         ,Quantity
                                         ,[Margin]
                                         ,[MarginF]
                                         ,[Profit]
                                         ,[Income]
                                         ,[IncomePRC]
                                         ,[PricePurchase]
                                         ,PriceQuantity
                                         ,Comment
                                     from vOrders
                                    where OrderID = :OrderID
                                  ''';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FDetailNumber2     := UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' + FDetailNumber;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;
  FQuantity          := UniMainModule.Query.FieldByName('Quantity').AsInteger;
  FMargin            := UniMainModule.Query.FieldByName('Margin').Value;

  edtWeightKG.Text   := UniMainModule.Query.FieldByName('WeightKG').AsString;
  edtVolumeKG.Text   := UniMainModule.Query.FieldByName('VolumeKG').AsString;
  edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;    //Вес Физический факт
  edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString;    //Вес Объемный факт

  edtDetailNameF.text:= UniMainModule.Query.FieldByName('DetailName').AsString;  //

  cbPrice.text       := UniMainModule.Query.FieldByName('PriceLogo').AsString;    //
  cbDestinationLogo.Value:= UniMainModule.Query.FieldByName('DestinationLogo').AsString;    // направление отгрузки
  FFlag              := UniMainModule.Query.FieldByName('Flag').AsInteger;
  FClientID          := UniMainModule.Query.FieldByName('ClientID').AsInteger;

  cbFragile.Checked  := UniMainModule.Query.FieldByName('Fragile').AsBoolean;
  cbNoAir.Checked    := UniMainModule.Query.FieldByName('NoAir').AsBoolean;

  edtMessage.Text    := UniMainModule.Query.FieldByName('Comment').AsString;

  edtCount.Text      := FQuantity.ToString + '/' +
                        UniMainModule.Query.FieldByName('PriceQuantity').AsString;

  edtMargin.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('Margin').Value);
  edtMarginF.Text   := FormatFloat('##0%',  UniMainModule.Query.FieldByName('MarginF').Value);
  edtProfit.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('Profit').Value);
  edtPrice.Text     := FormatFloat('$###,##0.00', UniMainModule.Query.FieldByName('PricePurchase').Value);
  edtIncome.Text    := FormatFloat('##0%', UniMainModule.Query.FieldByName('IncomePRC').Value);

  //16 - Онлайн заказ
  MessageContainer.Visible := ((FFlag and 16) = 0)  and (UniMainModule.Query.FieldByName('PriceID').AsInteger = 0);
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
    GetPartDataFromDB;
  end;
end;

procedure TOrderF.GetPartDataFromDB;
var js: string;
     r: string;
begin
  logger.Info('GetPartDataFromDB begin');
  logger.Info('GetPartDataFromDB DetailNum:' + FDetailNumber);
  logger.Info('GetPartDataFromDB PriceLogo:' + cbPrice.Text);
  logger.Info('GetPartDataFromDB DestinationLogo:' + cbDestinationLogo.Value);

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
            inner join pOrdersFin f (nolock) on f.spid = @@spid
            where p.spid = @@spid
              and p.DetailNum = :DetailNum
              and p.PriceLogo = :PriceLogo
              and p.DestinationLogo = :DestinationLogo
            order by PercentSupped desc
           ''',
           ['DetailNum', 'PriceLogo', 'DestinationLogo'],
           [FDetailNumber, cbPrice.Text, cbDestinationLogo.Value]);

  if sql.Q.RecordCount>0 then
  begin
    edtCount2.Text     := FQuantity.ToString + '/' + sql.Q.FieldByName('AvailableStr').Value;


    edtMargin2.Text    := FormatFloat('##0%', FMargin);
    edtMarginF2.Text   := FormatFloat('##0%',  sql.q.FieldByName('MarginF').Value);
    edtProfit2.Text    := FormatFloat('##0%', sql.q.FieldByName('Profit').Value);
    edtPrice2.Text     := FormatFloat('$###,##0.00', sql.q.FieldByName('Price').Value);
    edtIncome2.Text    := FormatFloat('##0%', sql.q.FieldByName('IncomePrc').Value);

    case sql.Q.FieldByName('PercentSupped').AsInteger  of
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
    'ajaxRequest(' + edtReliability2.JSName + ', ''rating2'', [setRatingVal2("' + r + '2", "' + sql.Q.FieldByName('PercentSupped').asstring +'")]);';

    UniSession.JSCode(js);
  end;
  logger.Info('GetPartDataFromDB end');
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

    case sql.Q.FieldByName('PercentSupped').AsInteger  of
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

    js := ' function setRatingVal() ' +
    '{' +
    ' document.getElementById("'+r+'").checked = true; ' +
    ' document.getElementById("prc").innerText = ''' + sql.Q.FieldByName('PercentSupped').AsString + '%''; ' +
    '} ' +
    'ajaxRequest(' + edtReliability.JSName + ', ''rating'', [setRatingVal()]);';

    UniSession.JSCode(js);

  end
  else
  begin
     MessageContainer.Visible := (FFlag and 16) > 0; //16 - Онлайн заказ
  end;
end;

procedure TOrderF.PriceCalc;
begin
  RetVal.Clear;

  Sql.exec(
  '''
          Update pFindByNumber
             set WeightGr  = isnull(nullif(:WeightGr, -1), 0)
                ,VolumeAdd = isnull(nullif(:VolumeAdd, -1), 0)
                ,DestinationLogo=:DestinationLogo
                ,Flag      = isnull(Flag, 0) | 512 -- 512 - Вес изменен клиентом
           where Spid = @@Spid

          exec SearchPriceCalc
                  @DestinationLogo = :DestinationLogo,
                  @DetailNum       = :DetailNum

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
                )
          Select @@spid
                ,cast(getdate() as date)
                ,p.ClientID
                ,p.PriceRub -- цена продажи в рублях
                ,p.Price-- цена закупки в долларах
                ,isnull(o.WeightKG,  0)
                ,isnull(o.VolumeKG , 0)
                ,isnull(p.WeightGr, 0)
                ,isnull(p.VolumeAdd, 0)
                ,isnull(o.Taxes, c.Taxes)    -- Комиссия + Налоги
                ,isnull(p.Commission, 0)/100 -- Комиссия за оплату  Comission ExtraKurs
                ,isnull(p.Margin, 0)/100     -- Наценка             Margin
                ,isnull(p.ExtraKurs, 0)/100  -- Комиссия на курс    ExtraKurs
                ,pd.WeightKG                 -- Стоимость кг
                ,pd.VolumeKG                 -- Стоимость vкг
            from pFindByNumber p (nolock)
           inner join tOrders o (nolock)
                   on o.OrderID = :OrderID
           inner join tClients c (nolock)
                   on c.ClientID = o.ClientID
           inner join tSupplierDeliveryProfiles pd (nolock)
                   on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
           where p.spid = @@spid
             and p.DetailNum = :DetailNum
             and p.PriceLogo = :PriceLogo
             and p.DestinationLogo = :DestinationLogo


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

procedure TOrderF.setOpenUrl(AUrl: string);
begin
  logger.Info(AUrl);

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

procedure TOrderF.UniFormReady(Sender: TObject);
var t: TSQLQueryThread;
begin
  try
    sql.Exec('if OBJECT_ID(''tempdb..#IsPart'') is not null drop table #IsPart CREATE TABLE #IsPart (IsPart bit);', [], []);

    t := TSQLQueryThread.Create(UniMainModule.FDConnection, FClientID, FDetailNumber, FPriceLogo);
    t.FreeOnTerminate := true; // Экземпляр должен само уничтожиться после выполнения
    t.Priority := tThreadPriority.tpNormal; // Выставляем приоритет потока

    t.Resume; // непосредственно ручной запуск потока
  finally
  end;
end;

procedure TOrderF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
    end;
    acUpdate, acReportEdit, acUserAction:
    begin
      btnOk.Caption := ' Сохранить';
    end;
    acDelete:
      btnOk.Caption := ' Удалить';
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption := ' Выполнить';
  end;

  //ComboBoxFill(cbRestrictions, ' Select Name from tRestrictions (nolock) where Flag&1=1 ');
  ComboBoxFill(cbPrice,        ' Select Name from tPrices (nolock) where Flag&1=1 ');

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

      Self.Caption:= ' ' +
      UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
      UniMainModule.Query.FieldByName('DetailNumber').AsString+ ' ' +
      UniMainModule.Query.FieldByName('DetailName').AsString;

      edtDetailNameF.SetFocus;
    end
  else
    //
  end;
end;

procedure TOrderF.UniTimerTimer(Sender: TObject);
begin
  try
    Sql.Open('select 1 from #IsPart (nolock)', [],[]);
    logger.Info('UniTimerTimer IsPart:' + Sql.Q.RecordCount.ToString);
    if Sql.Q.RecordCount > 0 then
    begin
      getPartRatingFromDB(FDetailNumber, FPriceLogo);

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
