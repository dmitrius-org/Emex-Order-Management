unit uOrdersF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  unimURLFrame;

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
    edtWeightKGF: TUniNumberEdit;
    edtVolumeKGF: TUniNumberEdit;
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
    UniLabel2: TUniLabel;
    cbRestrictions: TUniComboBox;
    cbPrice: TUniComboBox;
    ImageList16: TUniImageList;
    UniBitBtn1: TUniBitBtn;
    UniGroupBox4: TUniGroupBox;
    UniHTMLFrame: TUniHTMLFrame;
    UniTimer: TUniTimer;
    btnNumber: TUniButton;
    btnNumber2: TUniButton;
    cbDestinationLogo: TUniComboBox;
    btnDestinationLogo: TUniBitBtn;
    MessageContainer: TUniFieldContainer;
    UniLabel3: TUniLabel;
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


  private
    FAction: TFormAction;
    FID: Integer;
    FFlag: Integer;
    FClientID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;
    FManufacturer:string;

    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

//    procedure getPartRatingFromEmex(AConnection: tFDConnection; AClientID: Integer; ADetailNumber: string);


    procedure setOpenUrl(AUrl: string);
  public
    { Public declarations }
    { Public declarations }

   // IsParts: Boolean;

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;

    procedure getPartRatingFromDB(DetailNumber, PriceLogo: string);
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

procedure TOrderF.cbPriceChange(Sender: TObject);
begin
  getPartRatingFromDB(FDetailNumber, cbPrice.Text);
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
        sqltext :=' declare @R      int                       '+
                  '                                           '+
                  ' exec @r = OrderUpdate                     '+
                  '             @OrderID      = :OrderID      '+
                  '            ,@DetailNameF  = :DetailNameF  '+
                  '            ,@WeightKGF    = :WeightKGF    '+
                  '            ,@VolumeKGF    = :VolumeKGF    '+
                  '            ,@Restriction  = :Restriction  '+
                  '            ,@Price        = :Price        '+
                  '            ,@DestinationLogo=:DestinationLogo '+
                  ' select @r as retcode '+
                  ' ';

        Sql.Open(sqltext,
                 ['WeightKGF','VolumeKGF','DetailNameF', 'OrderID', 'Restriction', 'Price','DestinationLogo'],
                 [edtWeightKGF.Value,
                  edtVolumeKGF.Value,
                  edtDetailNameF.Text,
                  FID,
                  cbRestrictions.Text,
                  cbPrice.Text,
                  cbDestinationLogo.text
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
  UniMainModule.Query.SQL.Text := ' select isnull(WeightKGF, WeightKG) as WeightKGF  '+
                                  '       ,isnull(VolumeKGF, VolumeKG) as VolumeKGF  ' +
                                  '       ,DetailName as DetailName '+
                                  '       ,Manufacturer    ' +
                                  '       ,DetailNumber    ' +
                                  '       ,Restrictions    ' +
                                  '       ,PriceLogo       ' +
                                  '       ,Manufacturer    ' +
                                  '       ,DestinationLogo ' +
                                  '       ,SuppliersID     ' +
                                  '       ,PriceID         ' +
                                  '       ,ClientID        ' +
                                  '       ,Flag            ' +
                                  '   from vOrders         '+
                                  '  where OrderID = :OrderID '+
                                  ' ';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
  FDetailNumber2     := UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' + FDetailNumber;
  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FPriceLogo         := UniMainModule.Query.FieldByName('PriceLogo').AsString;

  edtWeightKGF.Text  := UniMainModule.Query.FieldByName('WeightKGF').AsString;    //Вес Физический факт
  edtVolumeKGF.Text  := UniMainModule.Query.FieldByName('VolumeKGF').AsString;    //Вес Объемный факт
  edtDetailNameF.text:= UniMainModule.Query.FieldByName('DetailName').AsString;  //
  cbRestrictions.text:= UniMainModule.Query.FieldByName('Restrictions').AsString; //Ограничение
  cbPrice.text       := UniMainModule.Query.FieldByName('PriceLogo').AsString;    //
  cbDestinationLogo.text:= UniMainModule.Query.FieldByName('DestinationLogo').AsString;    // направление отгрузки
  FFlag              := UniMainModule.Query.FieldByName('Flag').AsInteger;
  FClientID          := UniMainModule.Query.FieldByName('ClientID').AsInteger;

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
  ShowMessage(KEY.ToString);
  if (KEY = 13) then //enter
  begin
     edtVolumeKGF.Value := edtVKG.Value;
  end;
end;

procedure TOrderF.getPartRatingFromDB(DetailNumber, PriceLogo: string);
var js: string;
     r: string;
begin
  logger.Info('getPartRatingFromDB');
  sql.Open('select top 1 PercentSupped   ' +
           '  from pFindByNumber (nolock)' +
           ' where spid     = @@spid     ' +
           '   and DetailNum=:DetailNum  ' +
           '   and PriceLogo=:PriceLogo  ' +
           ' order by PercentSupped desc ',
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
    'ajaxRequest(' + UniHTMLFrame.JSName + ', ''rating'', [setRatingVal()]);';

    UniSession.JSCode(js);

  end
  else
  begin
     MessageContainer.Visible := (FFlag and 16) > 0; //16 - Онлайн заказ
  end;
end;

//procedure TOrderF.getPartRatingFromEmex(AConnection: tFDConnection; AClientID: Integer; ADetailNumber: string);
//var Emex:TEmex;
//begin
//  Emex := TEmex.Create;
//  Emex.Connection := AConnection;
//  Emex.FindByDetailNumber(FClientID, FDetailNumber);
//  FreeAndNil(Emex);
//end;


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

  ComboBoxFill(cbRestrictions, ' Select Name from tRestrictions (nolock) where Flag&1=1 ');
  ComboBoxFill(cbPrice,        ' Select Name from tPrices       (nolock) where Flag&1=1 ');

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      DataLoad;

      Self.Caption:= 'Изменение детали ' +
      UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
      UniMainModule.Query.FieldByName('DetailNumber').AsString;

      edtDetailNameF.SetFocus;

      ComboBoxFill(cbDestinationLogo,' SELECT distinct [DestinationLogo] as Name FROM tSupplierDeliveryProfiles (nolock) where SuppliersID = ' + UniMainModule.Query.FieldByName('SuppliersID').AsString );
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
      UniMainModule.MemTable.EmptyDataSet;

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
