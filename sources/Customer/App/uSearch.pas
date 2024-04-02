unit uSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniEdit, uniGUIBaseClasses, uniPanel,
  uniImageList, System.ImageList, Vcl.ImgList,
  uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniWidgets, System.Actions,
  Vcl.ActnList, uniMainMenu, uniHTMLFrame, uniButton, uniMultiItem, uniComboBox;

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
    QueryDelivery: TIntegerField;
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
    procedure SearchGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnAddBasketClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QueryDeliveryTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SearchGridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniHTMLFrameAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
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

  private
    { Private declarations }

    FDestinationLogo: string;
    FMakeName: string;

    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    procedure PartSearch();

    procedure GridRefresh();
    procedure MakeLogoGridRefresh();

    procedure PartToBasket();
    /// <summary>
    /// CustomerPriceCalc - расчет цены
    /// </summary>
    procedure CustomerPriceCalc();

    procedure SearchHistoryLoad();

    procedure SetMakeName();
    procedure MakeLogoGridShow();
    procedure MakeLogoGridHide();


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

procedure TSearchF.CustomerPriceCalc;
begin
    RetVal.Clear;
    Sql.exec('exec CustomerPriceCalc @DestinationLogo=:DestinationLogo', ['DestinationLogo'], [FDestinationLogo]);
end;

procedure TSearchF.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if edtSearch.Text = '' then Exit;

    PartSearch;
  end;
end;

procedure TSearchF.edtSearchRemoteQuery(const QueryString: string;
  Result: TStrings);
begin
  if Trim(QueryString)='' then Exit;

  qSearchHistory.Filter:='DetailNum LIKE ''%'+QueryString+'%''';
  qSearchHistory.Filtered := True;


  qSearchHistory.First;
  while not qSearchHistory.Eof do
  begin
    Result.Add( qSearchHistory.FieldByName('DetailNum').AsString);
    qSearchHistory.Next;
  end;
end;

procedure TSearchF.GridRefresh();
begin
  Query.Close;

  Query.ParamByName('DestinationLogo').Value := FDestinationLogo;
  Query.ParamByName('MakeName').Value := FMakeName;

  Query.Open;
end;

procedure TSearchF.MakeLogoGridDblClick(Sender: TObject);
begin
  MakeLogoPanel.Visible := False;

  if qMakeLogo.RecordCount > 0 then
  begin
    FMakeName := qMakeLogo.FieldByName('MakeName').AsString;

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

  qMakeLogo.Open;
end;

procedure TSearchF.MakeLogoGridShow;
begin
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

    CustomerPriceCalc;

    //получаем текущий бренд
    SetMakeName;

    GridRefresh();

    SearchHistoryLoad;

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
//<span class="hint  hint--bottom  hint--info" data-hint="О, это подсказка">Наведи на меня</span>
  Text := StringReplace('<form id="frmDestLogo" method="post" action=""> ' +
    '<div class="radio-form">' +
    '   <label class="radio-control">  ' +
    '       <input type="radio" value="0001" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input hint hint--bottom hint--info" data-hint="Экспресс доставка: “Прямая авиадоставка: быстро и дорого. Этим способом выгодно заказывать небольшие детали без объемного веса. К доставке не принимается' +
    ' опасный груз. Внизу поставить перечеркнутые логотипчики как в брошуре самолета, что нельзя возить взрывоопасные и легковоспламеняющиеся товары ( масла, подушки безопасности и т.д.)"><i class="fa fa-plane"></i></span> ' +
    '   </label>    ' +
    '   <label class="radio-control">  ' +
    '       <input type="radio" value="0002" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input hint hint--bottom hint--info" data-hint="Стандартная доставка: “Непрямая авиадоставка с пересадкой и перегрузкой в грузовой транспорт.' +
    ' Этим способом выгодно доставлять 90% деталей, но для доставки деталей с большим объемным весом лучше выбрать Контейнерную доставку.">  ' +
    '           <i class="fa fa-car"></i> ' + '       </span>   ' +
    '   </label>      ' +
    '   <label class="radio-control"> ' +
    '       <input type="radio"  value="0003" onchange="setDestLogo(value)" />  '  +
    '       <span class="radio-input hint hint--bottom hint--info" data-hint="Контейнерная доставка: Самый дешевый способ доставки грузов, он же и самый долгий. Этот способ подходит для доставки тяжелых или крупных деталей с большим объемом. ' +
    'Также можно доставлять любой опасный груз: масла, подушки безопасности с пиропатронами и так далее"> ' +
    '          <i class="fa fa-ship"></i>  ' +
    '       </span>    ' +
    '   </label>' +
    '</div>' +
    '</form>', FDestinationLogo + '"',
    FDestinationLogo + '" checked', []);
end;

procedure TSearchF.QueryMakeNameGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
 // if (Sender.FieldName = 'MakeLogo') {and (QueryMakeName.Value <> '')} then
  begin
    Text := '<span><i class="fa fa-caret-down fa-lg makelogo-caret-down"></i><span>' + Sender.AsString + '</span></span>';
  end
  //else
   // Text := Sender.AsString;
end;

procedure TSearchF.SearchGridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName = 'setDestLogo' then
  begin
    FDestinationLogo := Params.Values['P1'];

    CustomerPriceCalc();

    GridRefresh();
  end;
end;

procedure TSearchF.SearchGridBodyClick(Sender: TObject);
begin
    MakeLogoGridHide;
end;

procedure TSearchF.SearchGridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;

  if Assigned(ACurrColumn) then

  if (
       (ACurrColumn.FieldName = 'MakeName')
       )
  then
  begin
    MakeLogoGridShow;
  end;
end;

procedure TSearchF.SearchGridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ACurrColumn := Column;
end;

procedure TSearchF.SearchGridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TSearchF.SearchGridDblClick(Sender: TObject);
begin
 if (Assigned(ACurrColumn)) and (not MakeLogoPanel.Visible )then
  if (
       //(ACurrColumn.FieldName = 'MakeName') or    MakeLogoGridVisible
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
  qSearchHistory.Open();
end;

procedure TSearchF.SetMakeName;
begin
  sql.Open('select top 1 * from pFindByNumber pp  with (nolock index=ao2) where pp.Spid = @@spid', [] , []);
  FMakeName := sql.Q.FieldByName('MakeName').AsString;
end;

procedure TSearchF.TopPanelClick(Sender: TObject);
begin
   MakeLogoGridHide;
end;

procedure TSearchF.UniFrameCreate(Sender: TObject);
var
  js: string;
begin
  {$IFDEF Realese}
    SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  {$ENDIF}

  js := ' setDestLogo = function(AVal) { ' + ' ajaxRequest(' + SearchGrid.JSName
      + ', "setDestLogo", [ "P1=" + AVal ]);' + ' } ;';
  UniSession.JSCode(js);

  GridExt.SortColumnCreate(SearchGrid);
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

procedure TSearchF.UniHTMLFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  logger.Info(Sender.Name + ': ' + EventName)
end;

initialization

RegisterClass(TSearchF);

end.
