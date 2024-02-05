unit uOrdersT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, uCommonType, uniButton, uniBitBtn, uniLabel, uniDBComboBox,
  uniGroupBox, uniDBLookupComboBox, Vcl.StdActns, Vcl.StdCtrls, Vcl.Clipbrd,

  uniSweetAlert, unimSelect, unimDBSelect, uniSegmentedButton,

  System.Generics.Collections, System.MaskUtils;



type
  tMarks = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FGrid: TUniDBGrid;
    FMarks: TDictionary <Integer, Integer>;

    procedure DeleteInDB();
    function GetCount: Integer;
  public
    constructor Create(AGrid: TUniDBGrid);
    destructor Destroy; override;

    procedure Select();
    procedure Clear();

    function IsSelected(AID: Integer): Boolean;

    procedure Load();
    procedure DataRefresh();

    property Count: Integer read GetCount;
  end;



  TOrdersT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    actMain: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    ppMain: TUniPopupMenu;
    hdFilter: TUniHiddenPanel;
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    N6: TUniMenuItem;
    fisBlock: TUniCheckBox;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    QueryUserID: TFMTBCDField;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryOrderID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryClientName: TWideStringField;
    QueryOrderDate: tSqlTimeStampField;
    QueryPriceLogo: TWideStringField;
    QueryOrderNum: TWideStringField;
    QueryisCancel: TBooleanField;
    QueryManufacturer: TWideStringField;
    QueryDetailNumber: TWideStringField;
    QueryDetailID: TWideStringField;
    QueryQuantity: TIntegerField;
    QueryPrice: TCurrencyField;
    QueryAmount: TCurrencyField;
    QueryPricePurchase: TCurrencyField;
    QueryAmountPurchase: TCurrencyField;
    QueryPricePurchaseF: TCurrencyField;
    QueryAmountPurchaseF: TCurrencyField;
    QueryWeightKG: TCurrencyField;
    QueryVolumeKG: TCurrencyField;
    QueryWeightKGF: TCurrencyField;
    QueryVolumeKGF: TCurrencyField;
    QueryMargin: TCurrencyField;
    QueryMarginF: TCurrencyField;
    QueryProfit: TCurrencyField;
    QueryIncome: TCurrencyField;
    QueryPlanDate: TSQLTimeStampField;
    QueryRest: TCurrencyField;
    QueryDateDeliveredToSupplier: TSQLTimeStampField;
    QueryDaysReserveDeparture: TIntegerField;
    QueryNextDateDeparture: TSQLTimeStampField;
    QueryDateDeliveryToCustomer: TSQLTimeStampField;
    QueryTermDeliveryToCustomer: TIntegerField;
    QueryRestDeliveryToCustomer: TIntegerField;
    QueryUserName: TWideStringField;
    pFilter: TUniPanel;
    gbFilter: TUniGroupBox;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    qStatus: TFDQuery;
    qPriceLogo: TFDQuery;
    qClient: TFDQuery;
    dsStatus: TDataSource;
    dsPriceLogo: TDataSource;
    dsClient: TDataSource;
    qClientClientID: TFMTBCDField;
    qClientBrief: TWideStringField;
    qClientName: TWideStringField;
    QueryStatusName: TWideStringField;
    fOrderNum: TUniEdit;
    UniLabel4: TUniLabel;
    ppExecute: TUniPopupMenu;
    QueryStatusID: TFMTBCDField;
    QueryFlag: TIntegerField;
    QueryOverPricing: TCurrencyField;
    QueryWarning: TWideStringField;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    QueryReplacementMakeLogo: TWideStringField;
    QueryReplacementDetailNumber: TWideStringField;
    QueryMakeLogo: TWideStringField;
    QueryReplacementManufacturer: TWideStringField;
    UniImageListAdapter: TUniImageListAdapter;
    actProtocol: TAction;
    N2: TUniMenuItem;
    UniToolButton1: TUniToolButton;
    UniImageList: TUniImageList;
    UniImageList32: TUniImageList;
    actFilter: TAction;
    actFilterClear: TAction;
    actSelect: TAction;
    actUnselect: TAction;
    actGridSettingLoad: TAction;
    actGridSettingSave: TAction;
    actGridSettingDefault: TAction;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
    N9: TUniMenuItem;
    N11: TUniMenuItem;
    QueryDetailName: TWideStringField;
    QueryisCancelToClient: TBooleanField;
    fStatus2: TUniCheckComboBox;
    fPriceLogo: TUniCheckComboBox;
    fClient: TUniCheckComboBox;
    qPriceLogoPriceLogo: TWideStringField;
    QueryDetailNameF: TWideStringField;
    N4: TUniMenuItem;
    pnlGridSelectedCount: TUniPanel;
    UniLabel6: TUniLabel;
    fDetailNum: TUniEdit;
    QueryReplacementPrice: TCurrencyField;
    QueryCustomerPriceLogo: TWideStringField;
    UniPanel3: TUniPanel;
    lblSelRowCunt: TUniLabel;
    UniPanel4: TUniPanel;
    lblSelRowSum: TUniLabel;
    UniPanel5: TUniPanel;
    lblSelRowSum2: TUniLabel;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure GridSelectionChange(Sender: TObject);

    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellClick(Column: TUniDBGridColumn);
    procedure QueryDetailNumberGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure QueryMakeLogoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure QueryManufacturerGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actProtocolExecute(Sender: TObject);
    procedure ppMainPopup(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actFilterClearExecute(Sender: TObject);
    procedure actSelectExecute(Sender: TObject);
    procedure actUnselectExecute(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure actGridSettingLoadExecute(Sender: TObject);
    procedure actGridSettingSaveExecute(Sender: TObject);
    procedure actGridSettingDefaultExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure fStatus2Select(Sender: TObject);
    procedure UniFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure fPriceLogoSelect(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
    procedure cbCancelSelect(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure QueryPricePurchaseGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FAction: tFormaction;
  //  FCurrentState: Integer;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;

    /// <summary>
    /// GridOpen -
    /// </summary>
    procedure GridOpen;

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

    /// <summary>
    /// StateActionMenuCreate - Формирование списка меню/действий для состояния
    /// </summary>
    procedure StateActionMenuCreate();


    procedure DoShowMask();
    procedure DoHideMask();

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure MessageOKToast(AMessage: string);

    procedure FilterStatusCreate();
    procedure FilterPriceLogoCreate();
    procedure FilterClientsCreate();

    /// <summary>Select - выделить/ снять выделение с записи</summary>
    procedure Select();
    /// <summary>SelectAll - выделить все записи таблицы</summary>
    procedure SelectAll();
    /// <summary>DeselectAll - снять выделения со всех записей таблицы</summary>
    procedure DeselectAll();

    procedure GetMarksInfo();
  public
    { Public declarations }
    /// <summary>
    ///  GridLayout - сохранение/восстановление настроек грида
    ///  AOperation 0-сохранение
    ///             1-восстановление
    ///</summary>
    procedure GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
  end;

implementation

uses
  MainModule, uGrantUtils, uEmexUtils, uSqlUtils, uLogger, uMainVar, uOrdersProtocol_T, Main, uOrdersF, ServerModule;

  var screenmask: Boolean;
      ClipBoard:TClipBoard;

      var Marks: TMarks;

      ACurrColumn: TUniDBGridColumn;  //текущая колонка

{$R *.dfm}

procedure TOrdersT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TOrdersT.actEditExecute(Sender: TObject);
begin
    OrderF.FormAction := TFormAction.acUpdate;
    OrderF.ID:=QueryOrderID.AsInteger;
    OrderF.ShowModal(UserFCallBack);
end;



procedure TOrdersT.actFilterClearExecute(Sender: TObject);
begin
  fStatus2.ClearSelection;
  fPriceLogo.ClearSelection;
  fClient.ClearSelection;

  FFilterTextStatus := '';
  FFilterTextPriceLogo := '';
  FFilterTextClient := '';

  fOrderNum.Text := '';
  fDetailNum.Text:='';

  GridOpen();
end;

procedure TOrdersT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TOrdersT.actGridSettingDefaultExecute(Sender: TObject);
begin
  Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[self.ClassName +'.' + Grid.Name]);
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TOrdersT.actGridSettingLoadExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TOrdersT.actGridSettingSaveExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glSave);
end;


procedure TOrdersT.actProtocolExecute(Sender: TObject);
begin
  OrdersProtocol_T.ID:= Integer(QueryOrderID.Value);
  OrdersProtocol_T.ShowModal;
end;

procedure TOrdersT.actRefreshAllExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TOrdersT.DoHideMask;
begin
 // UniToolButton5.HideMask();
  UniSession.Synchronize;
end;

procedure TOrdersT.DoShowMask;
begin
  //UniToolButton5.ShowMask('');
  UniSession.Synchronize;
end;

procedure TOrdersT.fClientSelect(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextClient := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      s:= s + integer((Sender as TUniCheckComboBox).Items.Objects[i]).ToString +',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextClient := s;
  GridOpen;
  logger.Info('FFilterTextClient: ' + FFilterTextClient);
end;

procedure TOrdersT.FilterClientsCreate;
begin
  qClient.Open(); // используется в фильтре Клиент

  fClient.Clear;
  qClient.First;
  while not qClient.Eof do
  begin
    fClient.Items.AddObject( qClient.FieldByName('Brief').AsString, Pointer(qClient.FieldByName('ClientID').AsInteger) );
    qClient.Next;
  end;

  fClient.Refresh;
end;

procedure TOrdersT.FilterPriceLogoCreate;
begin
  qPriceLogo.Open(); // используется в фильтре PriceLogo

  fPriceLogo.Clear;
  qPriceLogo.First;
  while not qPriceLogo.Eof do
  begin
    fPriceLogo.Items.AddObject( qPriceLogo.FieldByName('PriceLogo').AsString, Pointer(qPriceLogo.FieldByName('PriceLogo').AsString) );
    qPriceLogo.Next;
  end;

  fPriceLogo.Refresh;
end;

procedure TOrdersT.FilterStatusCreate;
begin
  qStatus.Open(); // используется в фильтре Статус

  fStatus2.Clear;
  qStatus.First;
  while not qStatus.Eof do
  begin
    fStatus2.Items.AddObject( qStatus.FieldByName('Name').AsString, Pointer(qStatus.FieldByName('NodeID').AsInteger) );
    qStatus.Next;
  end;

  fStatus2.Refresh;
end;


procedure TOrdersT.UniFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
//  logger.Info('EventName: ' + EventName);
//  if EventName = 'selEvents' then
//  begin
//    if FindComponent(Params.Values['objName'])<>nil then
//      //(FindComponent(Params.Values['objName']) as TUnimSelect)
//      logger.Info(Params.Values['selIds']);
//  end;
end;


procedure TOrdersT.fPriceLogoSelect(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextPriceLogo := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      s:= s + '''' + string((Sender as TUniCheckComboBox).Items[i]) +''',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextPriceLogo := s;
  GridOpen;
  logger.Info('FFilterTextPriceLogo: ' + FFilterTextPriceLogo) ;
end;

procedure TOrdersT.fStatus2Select(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextStatus := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      s:= s + integer((Sender as TUniCheckComboBox).Items.Objects[i]).ToString +','; //+(Sender as TUniCheckComboBox).Items[i]+#10;
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextStatus := s;
  GridOpen;
  logger.Info('FFilterTextStatus: ' + FFilterTextStatus);
end;

procedure TOrdersT.GridOpen;
var FClient:string;
    FStatus :string;
    FPriceLogo :string;
begin
  logger.Info('GridOpen Begin');
  Query.Close();

  if FFilterTextStatus <> '' then
    FStatus := ' and StatusID in (' + FFilterTextStatus + ')'
  else
    FStatus := '';

  if FFilterTextPriceLogo <> '' then FPriceLogo := ' and PriceLogo in (' + FFilterTextPriceLogo + ')'
  else
    FPriceLogo := '';

  if FFilterTextClient <> '' then FClient := ' and ClientID in (' + FFilterTextClient + ')'
  else
    FClient := '';


  if FStatus <> '' then
  begin
    Grid.Refresh;
    Grid.WebOptions.Paged := True;
    Grid.WebOptions.PageSize:=1000000;
  end
  else
  begin
    Grid.WebOptions.Paged := True;
    Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);
  end;

  Query.MacroByName('Status').Value :=  FStatus;
  Query.MacroByName('PriceLogo').Value := FPriceLogo;
  Query.MacroByName('Client').Value := FClient;
  Query.ParamByName('OrderNum').Value := fOrderNum.Text;
  Query.ParamByName('DetailNum').Value := fDetailNum.Text;
  Query.ParamByName('isCancel').Value := cbCancel.ItemIndex;

  logger.Info('FFilterTextStatus: ' + FFilterTextStatus);
  logger.Info('FFilterTextPriceLogo: ' + FFilterTextPriceLogo);
  logger.Info('FFilterTextClient: ' + FFilterTextClient);

  Query.Open();

  StateActionMenuCreate;

  logger.Info('GridOpen End');
end;

procedure TOrdersT.GridSelectionChange(Sender: TObject);
begin
  logger.Info('GridSelectionChange');

  Marks.Select;
  GetMarksInfo;
end;

procedure TOrdersT.GetMarksInfo;
begin
  lblSelRowCunt.Caption := 'Выделено строк: ' + Grid.SelectedRows.Count.ToString + '  ';

  if Marks.Count > 0 then
  begin
    Sql.Open('Select Amount, AmountPurchase from vMarksSum', [], []);


    lblSelRowSum.Caption  := '  Сумма строк: ' + Sql.Q.FieldByName('Amount').AsString  + '  ₽';
    lblSelRowSum2.Caption := ' ' + Sql.Q.FieldByName('AmountPurchase').AsString+  ' $';
  end
  else
  begin
    lblSelRowSum.Caption  := '  Сумма строк: 0 ₽';
    lblSelRowSum2.Caption := ' 0 $';
  end;
end;

procedure TOrdersT.MessageOKToast(AMessage: string);
var
  acol,
  apesan,
  genMsgID: string;
begin

  acol:='#00A8FFA8';
  genMsgID := FormatDateTime('yyyymmddhhnnsszzz', Now());

  apesan := apesan+'<table style=margin-top:-18px ><td><i class=\"fa fa-info\" aria-hidden=\"true\">   </i>     &nbsp;&nbsp;&nbsp; </td>&nbsp;&nbsp;<td>'+ AMessage +
   '</td></table><span style=\"float:right;margin-top:-18px\"><i  onclick=\"window._msg'+ genMsgID +'.destroy(); window._msg'+genMsgID+'=null; \"   class=\"fa fa-times\" aria-hidden=\"true\"></i></span>';

  UniSession.AddJS('window._msg'+ genMsgID +' = Ext.toast ({html: "<font color=white style=font-size:15px;font-family:segoe ui;>' + apesan +
   '</font>", align: "tr" , header: false, width:300, autoCloseDelay: 3000, hideDuration: 2000, modal: false, bodyStyle:{"background-color":"'+acol+
   ' !important;box-shadow:'+acol+' !important; border-color: 0px solid transparent;padding:0px 0px 0px 0px !important;top:180px !important"}'
   +',listeners: {show: function(){this.paddingY = Ext.getBody().getHeight() - this.getHeight()}}'
   +'});'
   );
end;

procedure TOrdersT.ppMainPopup(Sender: TObject);
begin
  actProtocol.Enabled := (actProtocol.Tag=1) and (Query.RecordCount>0);


end;

procedure TOrdersT.QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'DetailNumber') and (QueryReplacementDetailNumber.Value <> '') then
  begin
    //Text:='<a href="javascript:void(0)" onClick="javascript:someFunction(param0,..,paramN)">Some Text</a>';
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span><span class="x-replacement-detail-number">' + QueryReplacementDetailNumber.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryMakeLogoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'MakeLogo') and (QueryReplacementMakeLogo.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-make-logo-arrow">&#10149;</span><span class="x-replacement-make-logo">' + QueryReplacementMakeLogo.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'Manufacturer') and (QueryReplacementManufacturer.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-manufacturer-arrow">&#10149;</span><span class="x-replacement-manufacturer">' + QueryReplacementManufacturer.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryPricePurchaseGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender.FieldName = 'PricePurchase') and (QueryReplacementPrice.Value > 0)  then
  begin
    Text := '<span>' + FormatFloat('###,##0.00 $', Sender.Value) +  '</span><br><span class="x-replacement-price-arrow">'+
    '&#10149;</span><span class="x-replacement-price">' + FormatFloat('###,##0.00 $', QueryReplacementPrice.Value) + '</span>';
  end
  else
    Text := Sender.AsString;
end;



procedure TOrdersT.GridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;
end;

procedure TOrdersT.GridCellContextClick(Column: TUniDBGridColumn; X,Y: Integer);
begin
  ACurrColumn := Column;

  ppMain.Popup(X, Y, Grid);
end;

procedure TOrdersT.GridDblClick(Sender: TObject);
begin
  if ACurrColumn.FieldName = 'DetailNumber' then
  begin
    UniSession.BrowserWindow(Format('https://www.google.com/search?tbm=isch&q=%s', [QueryDetailNumber.Value]), 0, 0, '_blank');
  end
  else
  if (ACurrColumn.FieldName = 'DetailNameF')
  or (ACurrColumn.FieldName = 'WeightKGF')
  or (ACurrColumn.FieldName = 'VolumeKGF')  then
  begin
    actEditExecute(Sender);
  end;
end;

procedure TOrdersT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
      if (Query.FieldByName('Flag').AsInteger and 1) = 1 then
      begin
        //Attribs.Font.Color:=clMaroon;
        //Attribs.Font.Style:=[fsBold, fsItalic];
        Attribs.Color:= rgb(255, 207, 217);
      end
      else if (Query.FieldByName('Flag').AsInteger and 2) = 2 then
      begin
        Attribs.Color:=rgb(242, 169, 210);
      end;

      if (Query.FieldByName('Flag').AsInteger and 4) > 0 then
      begin
        Attribs.Font.Color:=clGray;
      end;
end;

procedure TOrdersT.GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
var
  i: integer;
  //dbg: TDBGrid;
  SqlText: string;
  Column: TUniBaseDBGridColumn;
begin
  if not (AGrid is TUniDBGrid) then Exit;

  if AOperation=tGridLayout.glSave then
    for i := 0 to AGrid.Columns.count-1 do
    begin

      Sql.Exec('delete from tGridOptions where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[AForm.ClassName +'.' + AGrid.Name]);
      if i = 0 then
        SqlText:= SqlText + ' Insert into tGridOptions (UserID, Grid, [Column], Position, Width, Visible) '
      else
        SqlText:= SqlText + ' Union all ';

       SqlText:= SqlText +
       Format ('select dbo.GetUserID(), ''%s'', ''%s'', %d, %d, %d',
       [AForm.ClassName +'.' + AGrid.Name,
        AGrid.Columns[i].FieldName,
        AGrid.Columns[i].Index,
        AGrid.Columns[i].Width,
        AGrid.Columns[i].Visible.ToInteger
        ]);

        logger.Info(SqlText);
        Sql.Exec(SqlText,[],[]);
    end
  else
  if AOperation=tGridLayout.glLoad then
  begin
    Sql.Q.Close;
    Sql.Open('select * from tGridOptions (nolock) where UserID = dbo.GetUserID() and Grid =:Grid',
            ['Grid'],
            [AForm.ClassName +'.' + AGrid.Name]);
    Sql.Q.First;
    for i:= 0 to Sql.Q.RecordCount-1 do
    begin
      Column := AGrid.Columns.ColumnFromFieldName(Sql.Q.FieldByName('Column').AsString);
      Column.Index := Sql.Q.FieldByName('Position').AsInteger;
      Column.Width := Sql.Q.FieldByName('Width').AsInteger;
      Column.Visible := Sql.Q.FieldByName('Visible').Value;
      Sql.Q.Next;
    end;
  end;

  if AShowResultMessage = True then
    MessageOKToast ('Успешно выполнено!');
end;

procedure TOrdersT.Select;
begin
  Grid.JSInterface.JSCall('getSelectionModel().select', [Grid.CurrRow, true]);
end;

procedure TOrdersT.SelectAll;
begin
   Grid.JSInterface.JSCall('getSelectionModel().selectAll', []);
end;

procedure TOrdersT.DeselectAll;
begin
  Grid.JSInterface.JSCall('getSelectionModel().deselectAll', []);
end;

procedure TOrdersT.StateActionMenuCreate;

begin

end;

procedure TOrdersT.actSelectExecute(Sender: TObject);
begin
  SelectAll;
end;

procedure TOrdersT.actUnselectExecute(Sender: TObject);
begin
  DeselectAll;
end;

procedure TOrdersT.cbCancelSelect(Sender: TObject);
begin
  GridOpen;
end;

procedure TOrdersT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TOrdersT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TOrdersT.UniFrameCreate(Sender: TObject);
var
  I: Integer;
  IndexnameAsc : string;
  IndexnameDes : string;
begin
  logger.Info('UniFrameCreate Begin');
  {$IFDEF Debug}
  TGrant.GrantTemplateCreate(self);
  {$ENDIF}

  TGrant.SetGrant(self, actMain);
  //Grid.ReadOnly := not actEdit.Enabled;

  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

  actSelect.Caption := '';
  actUnSelect.Caption := '';

  ClipBoard:=TClipBoard.Create;

  FilterStatusCreate;
  FilterPriceLogoCreate();
  FilterClientsCreate();

  qPriceLogo.Open();
  qClient.Open();

  GridOpen();

  // индексы для сортировки
  with Query do
  begin
    for I := 0 to Query.FieldCount-1 do
    begin

      IndexnameAsc := Query.Fields[I].FieldName+'_index_asc';
      IndexnameDes := Query.Fields[I].FieldName+'_index_des';

      with Query.Indexes.Add do
      begin
        Name := IndexnameAsc;
        Fields := Query.Fields[I].FieldName;
        Options:=[];
        Active := True;
      end;
      with Query.Indexes.Add do
      begin
        Name := IndexnameDes;
        Fields := Query.Fields[I].FieldName;
        Options:=[soDescending];
        Active := True;
      end;
    end;
  end;

  {$IFDEF Release}
    Grid.Columns.ColumnFromFieldName('Flag').Visible := False;
  {$ENDIF}

  // восстановление настроек грида для пользователя
  GridLayout(Self, Grid, tGridLayout.glLoad, False);

 // actExecuteActionEnabled.Enabled  := Grid.SelectedRows.Count > 0;
 // actExecuteActionRollback.Enabled := Grid.SelectedRows.Count > 0;

  // объект для упраления метками
  Marks := tMarks.Create(Grid);
  Marks.Clear;

  GetMarksInfo;

  logger.Info('UniFrameCreate End');
end;


procedure TOrdersT.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
 // GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TOrdersT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  try
    if OrderF.FormAction = acUpdate then
    begin
      Query.Edit ;
      Query.Post;

      MessageOKToast('Изменение успешно выполнено!');
    end;
  except
    on E: Exception do
      logger.Info('TOrdersT.UserFCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      clipboard.Clear;
      clipboard.AsText:=grid.DataSource.DataSet.FieldByName(ACurrColumn.FieldName).asstring;
      //Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;

  // выделить/снять выделение с строки
  if (KEY = 32) then //пробел
  begin
    if (Sender is Tunidbgrid) then
    begin
      Select;
    end;
  end;

  // выделить все строки
  if (KEY = 32) AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      SelectAll;
    end;
  end;

  // нять выделение со всех строк
  if (KEY = 32) AND (SHIFT=[ssShift]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      DeSelectAll;
    end;
  end;
end;

{ tMarks }

constructor tMarks.Create(AGrid: TUniDBGrid);
begin
  if Assigned(AGrid) then
  begin
    FConnection := TFDConnection(TFDQuery(AGrid.DataSource.DataSet).Connection);
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
    FGrid := AGrid;
  end;
  FMarks := TDictionary <integer, integer>.Create();
end;

procedure tMarks.DataRefresh;
var Key: Integer;
    BM : TBookmark;
begin
  logger.Info('tMarks.DataRefresh Begin');

  begin
      FGrid.DataSource.DataSet.DisableControls;
      BM := FGrid.DataSource.DataSet.GetBookmark;
      try
        for Key in Marks.FMarks.Keys  do
        begin
          if FGrid.DataSource.DataSet.Locate('OrderID', Key, [loCaseInsensitive, loPartialKey]) then
          begin
            tFDQuery(FGrid.DataSource.DataSet).RefreshRecord(False) ;
            FGrid.RefreshCurrentRow();
          end;
        end;

      finally
        FGrid.DataSource.DataSet.GotoBookmark(BM);
        FGrid.DataSource.DataSet.FreeBookmark(BM);
        FGrid.DataSource.DataSet.EnableControls;
      end;
  end;
  logger.Info('tMarks.DataRefresh End');
end;

procedure tMarks.DeleteInDB();
begin
  Sql.Exec('Delete tMarks from tMarks (rowlock) where Spid= @@Spid', [], [])
end;

procedure tMarks.Clear;
begin
  DeleteInDB();
  FMarks.Clear;

  //FGrid.Refresh;
end;

destructor tMarks.Destroy;
begin
  FMarks.Free;
  inherited;
end;

function tMarks.GetCount: Integer;
begin
  Result := FMarks.Count;
end;

function tMarks.IsSelected(AID: Integer):Boolean;
begin
  Result := FMarks.ContainsKey(AID);
end;

procedure tMarks.Load;
var
  i: Integer;
begin
//  FMarks.Clear;
//
//  FQuery.Close;
//  FQuery.SQL.Text:= 'Select * from tMarks (nolock) where Spid = @@spid';
//  FQuery.Open();
//
//  for i := 0 to FQuery.RecordCount - 1 do
//  begin
//    FMarks.Add(FQuery.FieldByName('ID').AsInteger, FQuery.FieldByName('ID').AsInteger);
//  end;

end;

procedure tMarks.Select();
var i, id:Integer;
    SqlText: string;
    BM : TBookmark;
begin
  logger.Info('tMarks.Select Begin');

  SqlText:='';
  Clear;

  if FGrid.SelectedRows.Count>0 then
  begin
    BM := FGrid.DataSource.DataSet.GetBookmark;
    try
      for I := 0 to FGrid.SelectedRows.Count - 1 do
      begin
        FGrid.DataSource.DataSet.Bookmark := FGrid.SelectedRows[I];
        id := FGrid.DataSource.DataSet.FieldByName('OrderID').AsInteger;
        FMarks.Add(id, id);
        if i = 0 then
          SqlText:= SqlText + ' Insert into tMarks (Spid, Type, ID) select @@Spid, 3, '
        else
          SqlText:= SqlText + ' Union all select @@Spid, 3, ';

        SqlText:= SqlText + id.ToString;
      end;
      if SqlText <> '' then Sql.Exec(SqlText ,[], []);

    finally
      FGrid.DataSource.DataSet.GotoBookmark(BM);
      FGrid.DataSource.DataSet.FreeBookmark(BM);
    end;

  end;
  logger.Info('tMarks.Select End');
end;

initialization
  RegisterClass(TOrdersT);
end.
