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
  uniCheckBox, uniLabel, uniSpinEdit;

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
    lblAnalog: TUniLabel;
    UpdateSQL: TFDUpdateSQL;
    UniNumberEdit1: TUniNumberEdit;
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
    procedure SearchGridAfterLoad(Sender: TUniCustomDBGrid);
    procedure edtSearchClick(Sender: TObject);
    procedure lblAnalogClick(Sender: TObject);
    procedure SearchGridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);


  private
    { Private declarations }

    FDestinationLogo: string;
    FDestinationStr: string;

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

    /// <summary>
    /// SearchHistoryLoad - Загрузка истории поиска
    /// </summary>
    procedure SearchHistoryLoad();

    /// <summary>
    /// SearchHistorySave - сохранение истории поиска
    /// </summary>
    procedure SearchHistorySave();

    procedure SetMakeName();

    /// <summary>
    /// MakeLogoGridShow - показать таблицу выбора замен
    /// </summary>
    procedure MakeLogoGridShow();
    /// <summary>
    /// MakeLogoGridHide - скрыть таблицу выбора замен
    /// </summary>
    procedure MakeLogoGridHide();
    procedure MakeLogoGridRefresh();

    procedure AnalogLblVisible();

    /// <summary>
    /// DestinationLogo - формирование способов доставки для клиента
    /// </summary>
    procedure DestinationLogo();


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
          ['DestinationLogo',
           'DetailNum'],
          [FDestinationLogo, FDetailNum ]);
end;

procedure TSearchF.edtSearchClick(Sender: TObject);
begin
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
  Query.ParamByName('MakeName').Value        := FMakeName;
  Query.ParamByName('DetailNum').Value       := FDetailNum;
  Query.Open;

  AnalogLblVisible;
end;

procedure TSearchF.lblAnalogClick(Sender: TObject);
begin
  MakeLogoGridShow;
end;

procedure TSearchF.MakeLogoGridDblClick(Sender: TObject);
begin
  MakeLogoGridHide;

  if qMakeLogo.RecordCount > 0 then
  begin
    FMakeName := qMakeLogo.FieldByName('MakeName').AsString;
    FDetailNum:= qMakeLogo.FieldByName('DetailNum').AsString;

    GridRefresh();
  end;
end;

procedure TSearchF.MakeLogoGridRefresh;
begin
  qMakeLogo.Close;
  qMakeLogo.ParamByName('DestinationLogo').Value := FDestinationLogo;
  qMakeLogo.ParamByName('MakeName').Value  := FMakeName;
  qMakeLogo.ParamByName('DetailNum').Value := FDetailNum;
  qMakeLogo.Open;
end;

procedure TSearchF.MakeLogoGridHide;
begin
  MakeLogoPanel.Visible := False;

  AnalogLblVisible;
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

  AnalogLblVisible;
end;

procedure TSearchF.AnalogLblVisible;
begin
  logger.Info(FMakeCount.ToString);
  lblAnalog.Visible :=(not MakeLogoPanel.Visible) and (FMakeCount > 1) and (Query.RecordCount > 0);
end;

procedure TSearchF.PartSearch;
var
  emex: TEmex;
begin
  emex := TEmex.Create;
  ShowMask('Поиск...');
  UniSession.Synchronize();
  try
    emex.Connection := UniMainModule.FDConnection;
    emex.FindByDetailNumber(UniMainModule.AUserID, Trim(edtSearch.Text));

    SetMakeName;

    PriceCalc;

    GridRefresh();

    if (Query.RecordCount > 1) then
    begin

      if (edtSearch.Items.IndexOf(FDetailNum) < 0 ) then
        edtSearch.Items.Add(FDetailNum);

      SearchHistorySave;
    end;
  finally
    FreeAndNil(emex);
    HideMask;
    UniSession.Synchronize();
  end;
end;

procedure TSearchF.SetMakeName;
begin
  sql.Open('select top 1 * '+
           '  from pFindByNumber pp with (nolock index=ao2) ' +
           ' where pp.Spid = @@spid ' +
           ' order by case '+
           '            when DetailNum = :DetailNum then 0'+
           '            else 2 '+
           '          end'+
//           '         ,case '+
//           '            when MakeName = :MakeName   then 0'+
//           '            else 2 '+
//           '          end'+
           '', ['DetailNum'] , [Trim(edtSearch.Text)]);

  FMakeName := sql.Q.FieldByName('MakeName').AsString;
  FDetailNum:= sql.Q.FieldByName('DetailNum').AsString;
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

procedure TSearchF.QueryDeliveryTypeGetText(Sender: TField; var Text: string;  DisplayText: Boolean);
begin
  Text := FDestinationStr
end;

procedure TSearchF.DestinationLogo; var i: Integer;
begin
  logger.Info('TSearchF.DestinationLogo'); 
  sql.Open(' Select sp.*  '+
           '   from tClients c (nolock)  '+
           '  inner join tSupplierDeliveryProfiles sp (nolock)  '+
           '          on sp.SuppliersID = c.SuppliersID   '+
           '         and sp.IsActive    = 1   '+
           '   where c.ClientID = :ClientID   '+
           '   order by sp.DestinationLogo  ', ['ClientID'], [UniMainModule.AUserID]);
           
  FDestinationStr := '<form id="frmDestLogo" method="post" action=""> ' +
                     '<div class="radio-form">';
  sql.Q.First;
  for I := 0 to sql.Q.RecordCount - 1 do
  begin
    FDestinationStr := FDestinationStr +
    '   <label class="radio-control" data-qtip="' + sql.Q.FieldByName('ImageHelp').AsString + '">' +
    '       <input type="radio" value="' + sql.Q.FieldByName('DestinationLogo').AsString + '" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input">' + sql.Q.FieldByName('Image').AsString + '</span> ' +
    '   </label>';
    sql.Q.Next; 
  end;
  
  FDestinationStr := FDestinationStr + '</div>' + '</form>';

  FDestinationStr := StringReplace(FDestinationStr, FDestinationLogo + '"',  FDestinationLogo + '" checked', []);

  logger.Info(FDestinationStr); 
end;

procedure TSearchF.QueryMakeNameGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  // иконка для выбора аналогов
  if FMakeCount > 1 then
  begin
    Text := '<form method="post" action="">' +
            '<span class="makelogo-caret-down"><a>'+
            '<button type="button" onclick="setMakelogo()" style="border: 0; background: none;"> '+
            '  <i class="fa fa-caret-down fa-lg"></i>'+
            '</button>'+
            '</a></span>'+
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

  js := ' setMakelogo = function() {  ajaxRequest(' + SearchGrid.JSName    + ', "MakeLogoGridShow", []); } ;';
  UniSession.JSCode(js);

  js := ' clickInfoButton = function(AVal) {  ajaxRequest(' + SearchGrid.JSName    + ', "clickInfoButton", [ "P1=" + AVal ]); } ;';
  UniSession.JSCode(js);

  GridExt.SortColumnCreate(SearchGrid);

  js := '<span class="column-info">  '+
        '<span>ColName</span>        '+
        '<span class="" data-qtip="ColDataQtip">'+
        '<i class="fa fa-info-circle column-btn-info"></i> </span> '+
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
  logger.Info('TSearchF.SearchGridAjaxEvent EventName: ' + EventName);

  if EventName = 'setDestLogo' then
  begin
    FDestinationLogo := Params.Values['P1'];
    DestinationLogo;
    
    PriceCalc();

    GridRefresh();
  end;

  if EventName = 'MakeLogoGridShow' then
  begin
    MakeLogoGridShow;
  end;

  if EventName = 'MakeLogoPanelVisibleFalse' then
  begin
    MakeLogoGridHide();
  end;

  if (EventName = 'edit') and (Query.State  in [dsEdit, dsInsert] ) then
  begin
    Query.Post;

    PriceCalc();

    GridRefresh();
  end;

//  if EventName = 'getRowCheck' then
//  begin
//    logger.Info('TSearchF.SearchGridAjaxEvent Query.RecNo: ' + SearchGrid.CurrRow.ToString);
//    if Query.RecNo = 1 then
//      UniSession.SendResponse('true')
//    else
//      UniSession.SendResponse('false');
//  end;
end;

procedure TSearchF.SearchGridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;

//  if Query.RecNo = 1 then
//    SearchGrid.Options := SearchGrid.Options + [dgEditing] // Разрешаем редактирование
//  else
//    SearchGrid.Options := SearchGrid.Options - [dgEditing]

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

procedure TSearchF.SearchGridDrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if Column.FieldName  = 'VolumeAdd' then
   Attribs.Style.Style := 'cursor:pointer;' ;
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
  if not qSearchHistory.Active then
  begin
    qSearchHistory.Close;
    qSearchHistory.ParamByName('ClientID').Value := UniMainModule.AUserID;
    qSearchHistory.ParamByName('DetailNum').Value :=FDetailNum;
    qSearchHistory.Open();
  end;

  edtSearch.Items.Clear;

  qSearchHistory.First;
  while not qSearchHistory.Eof do
  begin
    edtSearch.Items.Add( qSearchHistory.FieldByName('DetailNum').AsString );
    qSearchHistory.Next;
  end;
end;

procedure TSearchF.SearchHistorySave;
begin
  Sql.Exec('insert tSearchHistory (ClientID, DetailNum) '+
  'select distinct      '+
  '       f.ClientID    '+
  '      ,f.DetailNum   '+
  '  from pFindByNumber f with (nolock index=ao1) '+
  ' where f.Spid      = @@Spid    '+
  '   and f.DetailNum = :DetailNum  '+
  '   and not exists (select 1      '+
  '                     from tSearchHistory sh with (nolock index=ao1) '+
  '                    where sh.ClientID  = f.ClientID   '+
  '                      and sh.DetailNum = f.DetailNum) '+
  '',
  ['DetailNum'],
  [FDetailNum]);
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
    sql.Open(' update pFindByNumber set spid = @@spid; ' +
             ' Select top 1 * from pFindByNumber (nolock) where Spid=@@Spid', [], [] );

    if sql.q.RecordCount > 0 then
    begin
      FDestinationLogo := sql.q.FieldByName('DestinationLogo').AsString;
      FMakeName        := sql.q.FieldByName('Make').Value;
      FDetailNum       := sql.q.FieldByName('DetailNum').Value;
    end;
  {$ENDIF}

  sql.Open(' Select sp.DestinationLogo  '+
           '   from tClients c (nolock)  '+
           '  inner join tSupplierDeliveryProfiles sp (nolock)  '+
           '          on sp.SuppliersID = c.SuppliersID   '+
           '         and sp.IsActive    = 1  '+
           '   where c.ClientID = :ClientID  '+
           '   order by sp.DestinationLogo  ', ['ClientID'], [UniMainModule.AUserID]);
  
  if sql.Q.RecordCount > 0 then
    FDestinationLogo := sql.Q.FieldByName('DestinationLogo').AsString; 

  DestinationLogo;

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
