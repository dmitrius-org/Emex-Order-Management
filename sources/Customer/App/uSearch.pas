unit uSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, System.StrUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniEdit, uniGUIBaseClasses, uniPanel,
  uniImageList, System.ImageList, Vcl.ImgList,
  uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniWidgets, System.Actions,
  Vcl.ActnList, uniMainMenu, uniHTMLFrame, uniButton, uniMultiItem, uniComboBox,
  uniCheckBox;

type
  TSearchF = class(TUniFrame)
    TopPanel: TUniPanel;
    MainPanel: TUniPanel;
    SearchGrid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    qSearchHistory: TFDQuery;
    QueryMakeName: TWideStringField;
    QueryDetailNum: TWideStringField;
    QueryPartNameRus: TWideStringField;
    QueryDeliveryType: TIntegerField;
    QueryPercentSupped: TIntegerField;
    QueryPrice: TCurrencyField;
    QueryAvailable: TWideStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    btnAddBasket: TUniButtonWidget;
    QueryID: TFMTBCDField;
    QueryRating: TStringField;
    btnSearch: TUniButton;
    QueryWeight: TCurrencyField;
    QueryVolumeAdd: TCurrencyField;
    edtSearch: TUniComboBox;
    UniComboBox1: TUniComboBox;
    MakeLogoPanel: TUniContainerPanel;
    MakeLogoGrid: TUniDBGrid;
    qMakeLogo: TFDQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    dsMakeLogo: TDataSource;
    qMakeLogoPriceRub: TCurrencyField;
    UniCheckBox1: TUniCheckBox;
    QueryOurDeliverySTR: TWideStringField;
    procedure SearchGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnAddBasketClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QueryDeliveryTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SearchGridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniFrameReady(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure SearchGridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure SearchGridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure SearchGridDblClick(Sender: TObject);
    procedure SearchGridCellClick(Column: TUniDBGridColumn);
    procedure UniFrameDestroy(Sender: TObject);
    procedure edtSearchRemoteQuery(const QueryString: string; Result: TStrings);
    procedure QueryMakeNameGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure MakeLogoGridDblClick(Sender: TObject);
    procedure TopPanelClick(Sender: TObject);
    procedure SearchGridBodyClick(Sender: TObject);
    procedure SearchGridBeforeLoad(Sender: TUniCustomDBGrid);
    procedure SearchGridAfterLoad(Sender: TUniCustomDBGrid);
    procedure edtSearchClick(Sender: TObject);

  private
    { Private declarations }

    FDestinationLogo: string;
    FMakeName: string;
    FMakeCount: integer; // Количество уникальных брендов
    FDetailNum: string;

    /// <summary>
    /// FInfoButton - для контроля нажатия по кнопке в заготовке столбца.
    /// При клике по кнопке отрабатывает сортировка, по данному параметру отключаем сортировку при нажании кноки <I>
    /// </summary>
    FInfoButton: Boolean;

    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    /// <summary>
    /// PartSearch - поиск детали по номеру
    /// </summary>
    procedure PartSearch();
    /// <summary>
    /// GridRefresh -обновление таблицы
    /// </summary>
    procedure GridRefresh();
    /// <summary>
    /// PartToBasket - добавление детали в корзину
    /// </summary>
    procedure PartToBasket();
    /// <summary>
    /// PriceCalc - расчет цены и срока поставки
    /// </summary>
    procedure PriceCalc();

    procedure SearchHistoryLoad();

    procedure SetMakeName();

    procedure MakeLogoGridShow();
    procedure MakeLogoGridHide();
    procedure MakeLogoGridRefresh();


  public
    { Public declarations }
  end;

implementation

uses
  uEmexUtils, MainModule, uMainVar, uLogger, uToast, uGridUtils;

{$R *.dfm}

procedure TSearchF.btnAddBasketClick(Sender: TObject);
begin
  ACurrColumn := nil;
  PartToBasket();
end;

procedure TSearchF.btnSearchClick(Sender: TObject);
begin
  if edtSearch.Text = '' then
    Exit;

  PartSearch;
end;

procedure TSearchF.PriceCalc;
begin
  RetVal.Clear;
  Sql.exec('exec SearchPriceCalc @DestinationLogo=:DestinationLogo, @DetailNum = :DetailNum',
          ['DestinationLogo', 'DetailNum'],
          [FDestinationLogo, FDetailNum ]);
end;

procedure TSearchF.edtSearchClick(Sender: TObject);
begin
 // edtSearch.RemoteUpdate := true;

  edtSearch.Expand;

end;

procedure TSearchF.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    btnSearch.OnClick(btnSearch);
  end;
end;

procedure TSearchF.edtSearchRemoteQuery(const QueryString: string;
  Result: TStrings);
begin
  //qSearchHistory.Filter:='DetailNum LIKE ''%'+QueryString+'%''';
  //qSearchHistory.Filtered := True;

//  qSearchHistory.First;
//  while not qSearchHistory.Eof do
//  begin
//    Result.Add( qSearchHistory.FieldByName('DetailNum').AsString );
//    qSearchHistory.Next;
//  end;
end;

procedure TSearchF.GridRefresh();
begin
  // определение количества уникальных брендов
  sql.Open('Select Count(distinct Make) from pFindByNumber (nolock) where Spid=@@Spid', [], [] );
  FMakeCount := sql.Q.Fields[0].AsInteger;


  Query.Close;

  Query.ParamByName('DestinationLogo').Value := FDestinationLogo;
  Query.ParamByName('MakeName').Value  := FMakeName;
  Query.ParamByName('DetailNum').Value := FDetailNum;

  Query.Open;
end;

procedure TSearchF.MakeLogoGridDblClick(Sender: TObject);
begin
  MakeLogoPanel.Visible := False;

  if qMakeLogo.RecordCount > 0 then
  begin
    FMakeName := qMakeLogo.FieldByName('MakeName').AsString;
    FDetailNum:= qMakeLogo.FieldByName('DetailNum').AsString;

    GridRefresh();
  end;
end;

procedure TSearchF.MakeLogoGridHide;
begin
  MakeLogoPanel.Visible := False;
end;

procedure TSearchF.MakeLogoGridRefresh;
begin
  qMakeLogo.Close;

  qMakeLogo.ParamByName('DestinationLogo').Value := FDestinationLogo;
  qMakeLogo.ParamByName('MakeName').Value := FMakeName;
  qMakeLogo.ParamByName('DetailNum').Value := FDetailNum;

  qMakeLogo.Open;
end;

procedure TSearchF.MakeLogoGridShow;
begin
  if MakeLogoPanel.Visible  then
  begin
    MakeLogoPanel.Visible:=False;
    Exit;
  end;

  MakeLogoPanel.Left := SearchGrid.Left;

  MakeLogoGrid.Columns.ColumnFromFieldName('MakeName').Width := SearchGrid.Columns.ColumnFromFieldName('MakeName').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('DetailNum').Width := SearchGrid.Columns.ColumnFromFieldName('DetailNum').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('PartNameRus').Width := SearchGrid.Columns.ColumnFromFieldName('PartNameRus').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('PriceRub').Width := SearchGrid.Columns.ColumnFromFieldName('PriceRub').Width;

  MakeLogoPanel.Width := MakeLogoGrid.Columns.ColumnFromFieldName('MakeName').Width +
                         MakeLogoGrid.Columns.ColumnFromFieldName('DetailNum').Width+
                         MakeLogoGrid.Columns.ColumnFromFieldName('PartNameRus').Width+
                         MakeLogoGrid.Columns.ColumnFromFieldName('PriceRub').Width+25;

  MakeLogoGridRefresh;
  MakeLogoPanel.Visible := True;
end;

procedure TSearchF.PartSearch;
var
  emex: TEmex;
begin
  emex := TEmex.Create;
  btnSearch.ScreenMask.ShowMask();
  try
    emex.Connection := UniMainModule.FDConnection;
    emex.FindByDetailNumber(UniMainModule.AUserID, edtSearch.Text);

    PriceCalc;

    SetMakeName;

    SearchHistoryLoad;

    GridRefresh();
  finally
    FreeAndNil(emex);
    btnSearch.ScreenMask.HideMask;
  end;
end;

procedure TSearchF.PartToBasket;
begin
  logger.Info('ClientID: ' + UniMainModule.AUserID.ToString);
  logger.Info('SPID: ' + UniMainModule.ASPID.ToString);

  RetVal.Clear;
  Sql.Open('declare @R int exec @R=PartToBasket @ClientID = :ClientID, @PartID=:PartID  select @R as retval',
          ['PartID', 'ClientID'],
          [QueryID.AsInteger, UniMainModule.AUserID]);

  RetVal.Code := Sql.Q.FieldByName('retval').Value;

  if RetVal.Code = 0 then
  begin
    ToastOK('Деталь успешно добавлена в корзину!', UniSession);
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TSearchF.QueryDeliveryTypeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin

  Text := StringReplace('<form id="frmDestLogo" method="post" action=""> ' +
    '<div class="radio-form">' +
    '   <label class="radio-control" data-qtip="' +sql.GetSetting('DeliveryInfoExpress')+ '">' +
    '       <input type="radio" value="0001" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input"><i class="fa fa-plane"></i></span> ' +
    '   </label>    ' +
    '   <label class="radio-control" data-qtip="' +sql.GetSetting('DeliveryInfoCharter')+ '">' +
    '       <input type="radio" value="0002" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input"><i class="fa fa-car"></i></span>  ' +
    '   </label>      ' +
    '   <label class="radio-control" data-qtip="' +sql.GetSetting('DeliveryInfoContainer')+ '">' +
    '       <input type="radio"  value="0003" onchange="setDestLogo(value)" />  '  +
    '       <span class="radio-input"><i class="fa fa-ship"></i></span> ' +
    '   </label>' +
    '</div>' +
    '</form>', FDestinationLogo + '"',
    FDestinationLogo + '" checked', []);
end;

procedure TSearchF.QueryMakeNameGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  // иконка для выбора аналогов
  if FMakeCount > 1 then
  begin
    Text := '<form method="post" action="">' +
            '<span class="makelogo-caret-down"><a>'+
            '<button type="button" onclick="setMakelogo()" style="border: 0; background: none;"> '+
            '  <i class="fa fa-caret-down fa-lg"></i>'+
            '</button>'+
            '</a> </span>'+
            '<span>' + Sender.AsString + ' </span>' +
            '</form>';
  end
  else
    Text := '<span>' + Sender.AsString + ' </span>';
end;

procedure TSearchF.UniFrameCreate(Sender: TObject);
var
  js: string;
begin
  {$IFDEF Realese}
    SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  {$ENDIF}

  js := ' setDestLogo = function(AVal) { ajaxRequest(' + SearchGrid.JSName + ', "setDestLogo", [ "P1=" + AVal ]); } ;';
  UniSession.JSCode(js);

  js := ' setMakelogo = function() {  ajaxRequest(' + SearchGrid.JSName    + ', "setMakelogo", []); } ;';
  UniSession.JSCode(js);

  js := ' clickInfoButton = function(AVal) {  ajaxRequest(' + SearchGrid.JSName    + ', "clickInfoButton", [ "P1=" + AVal ]); } ;';
  UniSession.JSCode(js);

  GridExt.SortColumnCreate(SearchGrid);

  js := '<span class="column-info">  '+
        '<span>ColName</span>        '+
       // '<form class="column-info" method="post" action=""> '+
        '' +
       // '<button type="button" onclick="clickInfoButton(''ColInfo'')" style="border: 0; background: none;"> '+
        '<span class="" data-qtip="ColDataQtip">'+
        '<i class="fa fa-info-circle column-btn-info"></i> </span> '+
       // '</button>'+
       // '</form> '+        data-qtip="Ghbdtn"
        '</span> ';

  SearchGrid.Columns.ColumnFromFieldName('Weight').Title.Caption :=  StringReplace(StringReplace (js, 'ColName', 'Вес', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoWeight'), []);
  SearchGrid.Columns.ColumnFromFieldName('VolumeAdd').Title.Caption :=  StringReplace(StringReplace (js, 'ColName', 'Объем', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoVolume'), []);
  SearchGrid.Columns.ColumnFromFieldName('DeliveryType').Title.Caption :=  StringReplace(StringReplace (js, 'ColName', 'Доставка', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoDeliveryType'), []);
  SearchGrid.Columns.ColumnFromFieldName('OurDeliverySTR').Title.Caption :=  StringReplace(StringReplace (js, 'ColName', 'Срок доставки', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoDelivery'), []);
  SearchGrid.Columns.ColumnFromFieldName('Rating').Title.Caption :=  StringReplace(StringReplace (js, 'ColName', 'Вероятность поставки', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoRating'), []);
end;

procedure TSearchF.SearchGridAfterLoad(Sender: TUniCustomDBGrid);
begin
   logger.Info('TSearchF.SearchGridAfterLoad');
end;

procedure TSearchF.SearchGridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  logger.Info('TSearchF.SearchGridAjaxEvent');
  logger.Info('TSearchF.SearchGridAjaxEvent EventName: ' + EventName);

  if EventName = 'setDestLogo' then
  begin
    FDestinationLogo := Params.Values['P1'];

    PriceCalc();

    GridRefresh();
  end;

  if EventName = 'setMakelogo' then
  begin
    MakeLogoGridShow;
  end;

//  if EventName = 'clickInfoButton' then
//  begin
//    logger.Info('TSearchF.SearchGridAjaxEvent Params: ' + Params.Values['P1']);
//
//    FInfoButton := True;
//
//    with SearchGrid.JSInterface do
//    begin
//      JSCall('getStore().sorters.clear', []);
//      //JSCall('getStore().reload', []);
//    end;
//  end;

  if EventName = 'MakeLogoPanelVisibleFalse' then
  begin
    logger.Info('TSearchF.SearchGridAjaxEvent');

    MakeLogoGridHide();
  end;

end;

procedure TSearchF.SearchGridBeforeLoad(Sender: TUniCustomDBGrid);
begin
  Logger.Info('TSearchF.SearchGridBeforeLoad');
end;

procedure TSearchF.SearchGridBodyClick(Sender: TObject);
begin
  Logger.Info('TSearchF.SearchGridBodyClick');
end;

procedure TSearchF.SearchGridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;
end;

procedure TSearchF.SearchGridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ACurrColumn := Column;
end;

procedure TSearchF.SearchGridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  Logger.Info('TSearchF.SearchGridColumnSort');
  Logger.Info('TSearchF.SearchGridColumnSort FInfoButton ' + FInfoButton.ToString());

  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TSearchF.SearchGridDblClick(Sender: TObject);
begin
 if (Assigned(ACurrColumn)) and (not MakeLogoPanel.Visible )then
  if (
       (ACurrColumn.FieldName = 'MakeName') or
       (ACurrColumn.FieldName = 'DetailNum') or
       (ACurrColumn.FieldName = 'PartNameRus') )
  then
  begin
    UniSession.BrowserWindow(Format('https://www.google.com/search?tbm=isch&q=%s+%s', [QueryMakeName.Value, QueryDetailNum.Value]), 0, 0, '_blank');
  end;
end;

procedure TSearchF.SearchGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(Key) = 'C') AND (Shift = [SSCTRL]) then
  begin
    if (Sender is TUniDBGrid) then
    begin
      SearchGrid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TSearchF.SearchHistoryLoad;
begin
  qSearchHistory.Close;
  qSearchHistory.ParamByName('ClientID').Value := UniMainModule.AUserID;
  qSearchHistory.ParamByName('DetailNum').Value :=FDetailNum;
  qSearchHistory.Open();

  edtSearch.Items.Clear;
  qSearchHistory.First;
  while not qSearchHistory.Eof do
  begin
    edtSearch.Items.Add( qSearchHistory.FieldByName('DetailNum').AsString );
    qSearchHistory.Next;
  end;
end;

procedure TSearchF.SetMakeName;
begin
  sql.Open('select top 1 * from pFindByNumber pp with (nolock index=ao2) where pp.Spid = @@spid', [] , []);
  FMakeName := sql.Q.FieldByName('MakeName').AsString;
  FDetailNum:= sql.Q.FieldByName('DetailNum').AsString;
end;

procedure TSearchF.TopPanelClick(Sender: TObject);
begin
   MakeLogoGridHide;
end;

procedure TSearchF.UniFrameDestroy(Sender: TObject);
begin
  {$IFDEF Realese}
    SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  {$ENDIF}
end;

procedure TSearchF.UniFrameReady(Sender: TObject);
begin
  {$IFDEF Debug}
    Sql.exec('update pFindByNumber set spid = @@spid', [], []);
  {$ENDIF}

  FDestinationLogo := '0001';

  //получаем текущий бренд
  SetMakeName;

  GridRefresh();

  SearchHistoryLoad();

  with SearchGrid do
  begin
    Options := Options + [dgDontShowSelected];
    JSInterface.JSConfig('disableSelection', [True]);
  end;
end;

initialization

RegisterClass(TSearchF);

end.
