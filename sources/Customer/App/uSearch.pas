﻿unit uSearch;

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
  uniCheckBox, uniLabel, uniSpinEdit, uniGroupBox, Math,
  System.Generics.Collections;

type

  TSupplierInfo = record
    SuppliersID: Integer;
    GroupName: string;
  end;

  TSupplierInfoList = TList<TSupplierInfo>;

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
    UniHiddenPanel1: TUniHiddenPanel;
    btnAddBasket: TUniButtonWidget;
    QueryID: TFMTBCDField;
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
    UpdateSQL: TFDUpdateSQL;
    QueryPriceLogo: TWideStringField;
    QueryPacking: TIntegerField;
    VKGPanel: TUniGroupBox;
    VolumeSave: TUniButton;
    QueryOurDelivery: TIntegerField;
    QueryAvailable: TIntegerField;
    btnRefresh: TUniButton;
    edtWeight: TUniFormattedNumberEdit;
    edtVolumeAdd: TUniFormattedNumberEdit;
    edtL: TUniFormattedNumberEdit;
    edtW: TUniFormattedNumberEdit;
    edtH: TUniFormattedNumberEdit;
    edtVKG: TUniFormattedNumberEdit;
    QueryMakeLogo: TWideStringField;
    procedure SearchGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnAddBasketClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QueryDeliveryTypeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SearchGridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniFrameReady(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure SearchGridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure SearchGridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure SearchGridDblClick(Sender: TObject);
    procedure SearchGridCellClick(Column: TUniDBGridColumn);
    procedure UniFrameDestroy(Sender: TObject);
    procedure edtSearchRemoteQuery(const QueryString: string; Result: TStrings);
    procedure QueryMakeNameGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure MakeLogoGridDblClick(Sender: TObject);
    procedure TopPanelClick(Sender: TObject);
    procedure edtSearchClick(Sender: TObject);
    procedure SearchGridDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure QueryPercentSuppedGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure edtLChange(Sender: TObject);
    procedure VolumeSaveClick(Sender: TObject);
    procedure QueryOurDeliveryGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryAvailableGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure QueryBeforeOpen(DataSet: TDataSet);
    procedure btnRefreshClick(Sender: TObject);
    procedure SearchGridAfterLoad(Sender: TUniCustomDBGrid);
    procedure edtVKGChange(Sender: TObject);


  private
    { Private declarations }

    FProfilesCustomerID: Integer;
    FDestinationStr: string;

    FMakeName: string;
    FMakeCount: integer; // Количество уникальных брендов
    FDetailNum: string;

    /// <summary>
    /// FInfoButton - для контроля нажатия по кнопке в заготовке столбца.
    /// При клике по кнопке отрабатывает сортировка, по данному параметру отключаем сортировку при нажании кноки <I>
    /// </summary>
//    FInfoButton: Boolean;

    /// <summary>
    /// ACurrColumn - текущая колонка
    /// </summary>
    ACurrColumn: TUniDBGridColumn;

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

    /// </summary>
    /// SetMakeName - получение бренда и детали для показа пользователю
    /// </summary>
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
    /// DestinationLogo - формирование способов доставки для клиента. Заполняет
    ///  поле "Доставка"
    /// </summary>
    procedure DestinationLogo();

    procedure VolumeCalc();

    function GetSupplierInfoList(AClientID: Integer): TSupplierInfoList;
  public
    { Public declarations }
  end;

implementation

uses
  uEmexUtils, MainModule, uMainVar, uToast, uUtils.Grid, uUtils.Logger;

{$R *.dfm}

procedure TSearchF.btnAddBasketClick(Sender: TObject);
begin
  ACurrColumn := nil;
  PartToBasket();
end;

procedure TSearchF.btnSearchClick(Sender: TObject);
begin
  if edtSearch.Text = '' then
  begin
    ShowToast('Введите номер детали для поиска');
    edtSearch.SetFocus;
    Exit;
  end;

  PartSearch;
end;

procedure TSearchF.PriceCalc;
begin
  log('TSearchF.PriceCalc begin', etInfo);
  log('TSearchF.PriceCalc FProfilesCustomerID: ' + FProfilesCustomerID.ToString, etInfo);

  RetVal.Clear;

  Sql.exec('''
    exec SearchPriceCalc
           @ProfilesCustomerID=:ProfilesCustomerID
  ''',
  ['ProfilesCustomerID'],
  [FProfilesCustomerID]);

  log('TSearchF.PriceCalc end', etInfo);
end;

procedure TSearchF.edtLChange(Sender: TObject);
begin
  VolumeCalc;
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

procedure TSearchF.edtVKGChange(Sender: TObject);
begin
  VolumeSave.Enabled := edtVKG.Value > 0;
end;

procedure TSearchF.QueryAfterOpen(DataSet: TDataSet);
begin
//  Query.ResourceOptions.CmdExecMode := amBlocking;
//  DataSource.DataSet := Query;
end;

procedure TSearchF.QueryBeforeOpen(DataSet: TDataSet);
begin
//  DataSource.DataSet := nil;
end;

procedure TSearchF.GridRefresh();
begin
  log('TSearchF.GridRefresh begin', etDebug);
  log('FProfilesCustomerID: ' + FProfilesCustomerID.ToString, etDebug);
  log('FMakeName: ' + FMakeName, etDebug);
  log('FDetailNum: ' + FDetailNum, etDebug);
  // определение количества уникальных брендов
  sql.Open('''
    DECLARE @Count INT;

    SET @Count = dbo.GetReplacementCount();

    SELECT @Count AS ReplacementCount;
  ''', [], [] );

  FMakeCount := sql.Q.Fields[0].AsInteger;

  Query.Close;
  Query.ParamByName('ProfilesCustomerID').Value := FProfilesCustomerID;
  Query.ParamByName('MakeName').Value        := FMakeName;
  Query.ParamByName('DetailNum').Value       := FDetailNum;

 // Query.ResourceOptions.CmdExecMode :=amNonBlocking;
  Query.Open;

  log('TSearchF.GridRefresh end', etDebug);
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
  qMakeLogo.ParamByName('ProfilesCustomerID').AsInteger := FProfilesCustomerID;
  qMakeLogo.ParamByName('MakeName').AsString  := FMakeName;
  qMakeLogo.ParamByName('DetailNum').AsString := FDetailNum;
  qMakeLogo.Open;
end;

procedure TSearchF.MakeLogoGridHide;
begin
  MakeLogoPanel.Visible := False;
end;

procedure TSearchF.MakeLogoGridShow;
begin
  if MakeLogoPanel.Visible  then
  begin
    MakeLogoPanel.Visible:=False;
    Exit;
  end;

  MakeLogoPanel.Left := SearchGrid.Left;

  MakeLogoGrid.Columns.ColumnFromFieldName('MakeName').Width   := SearchGrid.Columns.ColumnFromFieldName('MakeName').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('DetailNum').Width  := SearchGrid.Columns.ColumnFromFieldName('DetailNum').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('PartNameRus').Width:= SearchGrid.Columns.ColumnFromFieldName('PartNameRus').Width;
  MakeLogoGrid.Columns.ColumnFromFieldName('PriceRub').Width   := SearchGrid.Columns.ColumnFromFieldName('PriceRub').Width;

  MakeLogoPanel.Width := MakeLogoGrid.Columns.ColumnFromFieldName('MakeName').Width +
                         MakeLogoGrid.Columns.ColumnFromFieldName('DetailNum').Width+
                         MakeLogoGrid.Columns.ColumnFromFieldName('PartNameRus').Width+
                         MakeLogoGrid.Columns.ColumnFromFieldName('PriceRub').Width+25;

  MakeLogoGridRefresh;

  MakeLogoPanel.Visible := True;
end;

procedure TSearchF.AnalogLblVisible;
begin
  if Query.RecordCount > 0 then
  if FMakeCount > 1 then

    UniSession.AddJS('''
      var el = document.getElementById("makereplacement");
      if (el) {
            el.classList.remove("hide-column");
      }
    ''')
  else
    UniSession.AddJS('''
      var el = document.getElementById("makereplacement");
      if (el) {
            el.classList.add("hide-column");
      }
    ''')
end;

function TSearchF.GetSupplierInfoList(AClientID: Integer): TSupplierInfoList;
var
  Query: TFDQuery;
  Info: TSupplierInfo;
  ResultList: TSupplierInfoList;
begin
  ResultList := TSupplierInfoList.Create;
  Query := TFDQuery.Create(nil);
  try
    try
      Query.Connection := UniMainModule.FDConnection;
      Query.SQL.Text := '''
        SELECT DISTINCT s.SuppliersID, s.GroupName
        FROM tProfilesCustomer pc WITH (NOLOCK)
        INNER JOIN tSuppliers s WITH (NOLOCK)
          ON s.SuppliersID = pc.SuppliersID
         AND ISNULL(s.emexUsername, '') <> ''
         AND ISNULL(s.emexPassword, '') <> ''
         AND ISNULL(s.ApiAddress, '') <> ''
        WHERE pc.ClientID = :ClientID
          AND pc.isActive = 1
      ''';

      Query.ParamByName('ClientID').AsInteger := AClientID;
      Query.Open;

      while not Query.Eof do
      begin
        Info.SuppliersID := Query.FieldByName('SuppliersID').AsInteger;
        Info.GroupName := Query.FieldByName('GroupName').AsString;
        ResultList.Add(Info);
        Query.Next;
      end;

      Result := ResultList;
    except
      ResultList.Free;
      raise;
    end;
  finally
    Query.Free;
  end;
end;


procedure TSearchF.PartSearch;
var
  emex: TEmex;
  SupplierIDs: TSupplierInfoList;
  Item: TSupplierInfo;
begin
  log('TSearchF.PartSearch %s', ['Begin'], etInfo);
  ShowMask('Поиск...');
  UniSession.Synchronize();

  SupplierIDs := GetSupplierInfoList(UniMainModule.AUserID);
  try

    try
      SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);

      for Item in SupplierIDs do
      begin
        if Item.GroupName = 'Emex' then
        begin
          emex := TEmex.Create(UniMainModule.FDConnection);
          emex.FindByDetailNumber(UniMainModule.AUserID, Item.SuppliersID, Trim(edtSearch.Text));

          log('TSearchF.PartSearch %s', ['Получили данные с эмекс'], etInfo);
        end;
      end;

      SetMakeName;

      PriceCalc;

      log('TSearchF.PartSearch %s', ['Расcчитали цены'], etInfo);

      GridRefresh();

      log('TSearchF.PartSearch %s', ['Обновили таблицу'], etInfo);

      if (Query.RecordCount > 1) then
      begin

        if (edtSearch.Items.IndexOf(FDetailNum) < 0 ) then
          edtSearch.Items.Add(FDetailNum);

        SearchHistorySave;

        log('TSearchF.PartSearch %s', ['Обновили историю поиска'], etInfo);
      end;

    finally
      FreeAndNil(emex);
      HideMask;
      UniSession.Synchronize();

      log('TSearchF.PartSearch %s', ['End'], etInfo);
    end;


  finally
    SupplierIDs.Free;
  end;


end;

procedure TSearchF.SetMakeName;
begin
  log('TSearchF.SetMakeName begin', etDebug);
  sql.Open('''
           select top 1 p.DetailNum, p.MakeName
             from vFindByNumber p
            order by case
                       when p.DetailNum = :DetailNum then 0
                       else 2
                     end
                    ,p.ID
           ''', ['DetailNum'] , [Trim(edtSearch.Text)]);

  FMakeName := sql.Q.FieldByName('MakeName').AsString;
  FDetailNum:= sql.Q.FieldByName('DetailNum').AsString;

  log('TSearchF.SetMakeName MakeName: ' + FMakeName, etDebug);
  log('TSearchF.SetMakeName DetailNum: ' + FDetailNum, etDebug);
  log('TSearchF.SetMakeName end', etDebug);
end;

procedure TSearchF.PartToBasket;
begin
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

procedure TSearchF.QueryAvailableGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.Value = -1 then
  begin
    Text := '<span class="">под заказ</span>';
  end
  else
    Text := '<span>' + Sender.AsString + '</span>';
end;

procedure TSearchF.QueryDeliveryTypeGetText(Sender: TField; var Text: string;  DisplayText: Boolean);
begin
  Text := FDestinationStr
end;

procedure TSearchF.DestinationLogo; var i: Integer;
begin
  log('TSearchF.DestinationLogo begin', etDebug);
  sql.Open('''
     Select *
       from vDestinationLogo
      where ClientID = :ClientID
      order by DestinationLogo
   ''',
   ['ClientID'],
   [UniMainModule.AUserID]);
           
  FDestinationStr := '<form id="frmDestLogo" method="post" action=""> ' +
                     '<div class="radio-form">';
  sql.Q.First;
  for I := 0 to sql.Q.RecordCount - 1 do
  begin
    FDestinationStr := FDestinationStr +
    '   <label class="radio-control" data-qtip="' + sql.Q.FieldByName('ImageHelp').AsString + '">' +
    '       <input type="radio" value="' + sql.Q.FieldByName('ProfilesCustomerID').AsString + '" onchange="setDestLogo(value)" /> ' +
    '       <span class="radio-input">' + sql.Q.FieldByName('Image').AsString + '</span> ' +
    '   </label>';
    sql.Q.Next; 
  end;
  
  FDestinationStr := FDestinationStr + '</div>' + '</form>';

  FDestinationStr := StringReplace(FDestinationStr,
                                   FProfilesCustomerID.ToString + '"',
                                   FProfilesCustomerID.ToString + '" checked', []);
end;

procedure TSearchF.QueryMakeNameGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  // иконка для выбора аналогов
  if FMakeCount > 1 then
  begin
    Text := '<form method="post" action="">' +
            '<span class="makelogo-caret-down" data-qtip="Замены"><a>'+
            '<button type="button" onclick="setMakelogo()" style="border: 0; background: none;"> '+
            '  <i class="fa fa-caret-down fa-lg"></i>'+
            '</button>'+
            '</a></span>'+
            '<span data-qtip="hint">' + Sender.AsString + '</span>' +
            '</form>';
  end
  else
    Text := '<span data-qtip="hint">' + Sender.AsString + '</span>';

  Text := Text.Replace('hint', QueryMakeName.Value + ' (' + QueryMakeLogo.Value + ')');
end;

procedure TSearchF.QueryOurDeliveryGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := '<span>' + Query.FieldByName('OurDeliverySTR').AsString + '</span>';
end;

procedure TSearchF.QueryPercentSuppedGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := '''
            <span class="" data-qtip="Прайс: PriceLogo <br> Количество в упаковке: Packing">
              <fieldset class="rating">
          ''';

  if (Sender.Value > 90) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star5"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star5"></label>';

  if (Sender.Value > 80) then
     Text := Text + '<input type="radio" checked /><label class="half" for="star4half"></label>'
  else
     Text := Text +'<input type="radio" /><label class="half" for="star4half"></label>';

  if (Sender.Value > 70) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star4"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star4"></label>';

  if (Sender.Value > 60) then
     Text := Text + '<input type="radio" checked /><label class="half" for="star3half"></label>'
  else
     Text := Text +'<input type="radio" /><label class="half" for="star3half"></label>';

  if (Sender.Value > 50) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star3"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star3"></label>';

  if (Sender.Value > 40) then
     Text := Text + '<input type="radio" checked /><label class="half" for="star2half"></label>'
  else
     Text := Text +'<input type="radio" /><label class="half" for="star2half"></label>';

  if (Sender.Value > 30) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star2"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star2"></label>';

  if (Sender.Value > 20) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star1half"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star1half"></label>';

  if (Sender.Value > 10) then
     Text := Text + '<input type="radio" checked /><label class="full" for="star1"></label>'
  else
     Text := Text +'<input type="radio" /><label class="full" for="star1"></label>';

  if (Sender.Value > 0) then
     Text := Text + '<input type="radio" checked /><label class="half" for="star0half"></label>'
  else
     Text := Text +'<input type="radio" /><label class="half" for="star0half"></label>';

  Text := Text +'</fieldset></span><label id="prc" class="ratingprc">PercentSupped%</label>';

  Text := StringReplace(Text, 'PriceLogo' , Query.FieldByName('PriceLogo').AsString, [] );
  Text := StringReplace(Text, 'PercentSupped' , Sender.AsString, [rfReplaceAll] );
  Text := StringReplace(Text, 'Packing' ,  Query.FieldByName('Packing').AsString, [rfReplaceAll] );
end;

procedure TSearchF.btnRefreshClick(Sender: TObject);
begin
  GridRefresh();
end;

procedure TSearchF.UniFrameCreate(Sender: TObject);
var
  js: string;
begin
  {$IFDEF Debug}
    btnRefresh.visible := True;
  {$ENDIF}

  {$IFDEF Realese}
    btnRefresh.Enabled := True;
    SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);
  {$ENDIF}

  js := ' setDestLogo = function(AVal) { ajaxRequest(' + SearchGrid.JSName + ', "setDestLogo", [ "P1=" + AVal ]); } ;';
  UniSession.JSCode(js);

  js := ' setMakelogo = function() { ajaxRequest(' + SearchGrid.JSName    + ', "MakeLogoGridShow", []); } ;';
  UniSession.JSCode(js);

  js := ' clickInfoButton = function(AVal) { ajaxRequest(' + SearchGrid.JSName    + ', "clickInfoButton", [ "P1=" + AVal ]); } ;';
  UniSession.JSCode(js);

  GridExt.SortColumnCreate(SearchGrid);

  js := '<span class="column-info">  '+
        '<span>ColName</span>        '+
        '<span class="" data-qtip="ColDataQtip">'+
        '<i class="fa fa-info-circle column-btn-info"></i> </span> '+
        '</span> ';

  SearchGrid.Columns.ColumnFromFieldName('Weight').Title.Caption := StringReplace(StringReplace (js, 'ColName', 'Вес', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoWeight'), []);
  SearchGrid.Columns.ColumnFromFieldName('VolumeAdd').Title.Caption := StringReplace(StringReplace (js, 'ColName', 'Объем', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoVolume'), []);
  SearchGrid.Columns.ColumnFromFieldName('DeliveryType').Title.Caption  := StringReplace(StringReplace (js, 'ColName', 'Доставка', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoDeliveryType'), []);
  SearchGrid.Columns.ColumnFromFieldName('OurDelivery').Title.Caption   := StringReplace(StringReplace (js, 'ColName', 'Срок доставки', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoDelivery'), []);
  SearchGrid.Columns.ColumnFromFieldName('PercentSupped').Title.Caption := StringReplace(StringReplace (js, 'ColName', 'Вероятность поставки', []), 'ColDataQtip', sql.GetSetting('SearchColumnInfoRating'), []);
end;

procedure TSearchF.SearchGridAfterLoad(Sender: TUniCustomDBGrid);
begin
  AnalogLblVisible;
end;

procedure TSearchF.SearchGridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  log('TSearchF.SearchGridAjaxEvent EventName: ' + EventName, etDebug);

  if EventName = 'setDestLogo' then
  begin
    log('TSearchF.SearchGridAjaxEvent setDestLogo begin ', etDebug);
    ShowMask('Поиск...');
    UniSession.Synchronize();
    try
      log('setDestLogo FProfilesCustomerID: ' + Params.Values['P1'], etDebug);
      FProfilesCustomerID := Params.Values['P1'].ToInteger;

      DestinationLogo;  // тут переделать через js

      PriceCalc();

      GridRefresh();
    finally
      HideMask;
      UniSession.Synchronize();
    end;
    log('TSearchF.SearchGridAjaxEvent setDestLogo end ', etDebug);
  end
  else
  if EventName = 'MakeLogoGridShow' then
  begin
    MakeLogoGridShow;
  end
  else
  if EventName = 'MakeLogoPanelVisibleFalse' then
  begin
    MakeLogoGridHide();
  end
  else
  if EventName = 'VKGPanelVisibleFalse' then
  begin
    VKGPanel.Visible := False;
  end
  else
  if (EventName = 'edit') and (Query.State  in [dsEdit, dsInsert] ) then
  begin
    if Params.ValueFromIndex[8].ToInteger = 2 then // поле описание
    begin
      sql.Exec('''
        exec FindByNumberUpdate_PartNameRus @PartNameRus=:PartNameRus
      ''', ['PartNameRus'], [Params.ValueFromIndex[5]]);
    end;

    if Params.ValueFromIndex[8].ToInteger = 3 then // поле вес
    begin
      sql.Exec('''
        exec FindByNumberUpdate_WeightGr @WeightGr=:WeightGr
      ''', ['WeightGr'], [Params.ValueFromIndex[5]]);

      PriceCalc();
      GridRefresh();
    end;

    if Params.ValueFromIndex[8].ToInteger = 4 then // поле объем
    begin
      sql.Exec('''
        exec FindByNumberUpdate_VolumeAdd @VolumeAdd=:VolumeAdd
      ''', ['VolumeAdd'], [Params.ValueFromIndex[5]]);

      PriceCalc();
      GridRefresh();
    end;
  end
  else
  if (EventName = 'VKGPanelLeft') then
  begin
    edtL.Clear;
    edtH.Clear;
    edtW.Clear;
    edtVKG.Clear;

    VKGPanel.Left :=  Params.Values['VKGPanelLeft'].ToInteger;
    VKGPanel.Visible := True;
  end;
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
  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TSearchF.SearchGridDblClick(Sender: TObject);
begin
  if (Assigned(ACurrColumn)) and (not MakeLogoPanel.Visible )then
    if ( (ACurrColumn.FieldName = 'MakeName' ) or
         (ACurrColumn.FieldName = 'DetailNum') )
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
  log('TSearchF.SearchHistorySave begin', etDebug);

  Sql.Exec('''
  insert tSearchHistory (ClientID, DetailNum)
  select distinct
         f.ClientID
        ,f.DetailNum
    from pFindByNumber f with (nolock index=ao1)
   where f.Spid      = @@Spid
     and f.DetailNum = :DetailNum
  ''',
  ['DetailNum'],
  [FDetailNum]);
  log('TSearchF.SearchHistorySave end', etDebug);
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
  sql.Open('''
   Select top 1 ProfilesCustomerID
     from vDestinationLogo
    where ClientID = :ClientID
    order by DestinationLogo
  ''',
  ['ClientID'], [UniMainModule.AUserID]);

  if sql.Q.RecordCount > 0 then
    FProfilesCustomerID := sql.Q.FieldByName('ProfilesCustomerID').AsInteger;

  DestinationLogo;

  GridRefresh();

  SearchHistoryLoad();

  with SearchGrid do
  begin
    Options := Options + [dgDontShowSelected];
    JSInterface.JSConfig('disableSelection', [True]);
  end;
end;

procedure TSearchF.VolumeCalc;
begin
  edtVKG.Value := SimpleRoundTo(( (edtL.Value * edtW.Value * edtH.Value) / 5000 ), -3);

  VolumeSave.Enabled := edtVKG.Value > 0;
end;

procedure TSearchF.VolumeSaveClick(Sender: TObject);
begin
  QueryVolumeAdd.DataSet.Edit;
  QueryVolumeAdd.Value := edtVKG.Value;
  QueryVolumeAdd.DataSet.Post;

  VKGPanel.Visible := False;
end;

initialization
  RegisterClass(TSearchF);

end.
