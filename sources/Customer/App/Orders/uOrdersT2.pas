unit uOrdersT2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,
  uCommonType, uniButton, uniBitBtn, uniLabel, uniDBComboBox,
  uniGroupBox, uniDBLookupComboBox, Vcl.StdActns, Vcl.StdCtrls, Vcl.Clipbrd,
  uniSweetAlert, unimSelect, unimDBSelect, uniSegmentedButton,
  System.Generics.Collections, System.MaskUtils, uniDateTimePicker;


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


  TOrdersT2 = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    actMain: TUniActionList;
    actCancelRequest: TAction;
    hdFilter: TUniHiddenPanel;
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    fisBlock: TUniCheckBox;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryOrderID: TFMTBCDField;
    QueryOrderDate: tSqlTimeStampField;
    QueryPriceLogo: TWideStringField;
    QueryisCancel: TBooleanField;
    QueryManufacturer: TWideStringField;
    QueryDetailNumber: TWideStringField;
    QueryQuantity: TIntegerField;
    QueryPrice: TCurrencyField;
    QueryAmount: TCurrencyField;
    QueryWeightKG: TCurrencyField;
    QueryVolumeKG: TCurrencyField;
    QueryWeightKGF: TCurrencyField;
    QueryVolumeKGF: TCurrencyField;
    QueryDeliveryPlanDateSupplier: TSQLTimeStampField;
    QueryDeliveredDateToSupplier: TSQLTimeStampField;
    QueryDeliveryDaysReserve: TIntegerField;
    QueryDeliveryNextDate: TSQLTimeStampField;
    QueryDeliveryDateToCustomer: TSQLTimeStampField;
    QueryDeliveryTermToCustomer: TIntegerField;
    pFilter: TUniPanel;
    gbFilter: TUniGroupBox;
    UniLabel1: TUniLabel;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    qStatus: TFDQuery;
    qPriceLogo: TFDQuery;
    dsStatus: TDataSource;
    dsPriceLogo: TDataSource;
    QueryStatusName: TWideStringField;
    fOrderNum: TUniEdit;
    UniLabel4: TUniLabel;
    QueryStatusID: TFMTBCDField;
    QueryFlag: TIntegerField;
    QueryWarning: TWideStringField;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    QueryReplacementMakeLogo: TWideStringField;
    QueryReplacementDetailNumber: TWideStringField;
    QueryMakeLogo: TWideStringField;
    QueryReplacementManufacturer: TWideStringField;
    UniImageListAdapter: TUniImageListAdapter;
    actProtocol: TAction;
    UniImageList: TUniImageList;
    UniImageList32: TUniImageList;
    actFilter: TAction;
    actFilterClear: TAction;
    actSelect: TAction;
    actUnselect: TAction;
    QueryDetailName: TWideStringField;
    fStatus2: TUniCheckComboBox;
    qPriceLogoPriceLogo: TWideStringField;
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
    QueryReference: TWideStringField;
    QueryComment: TWideStringField;
    QueryDeliveryRestToCustomer: TIntegerField;
    QueryDeliveryRestTermSupplier: TIntegerField;
    QueryOrderNum: TWideStringField;
    actShowMessage: TAction;
    fOrderDate: TUniDateTimePicker;
    UniLabel8: TUniLabel;
    UniPanel: TUniPanel;
    btnCancel: TUniBitBtn;
    QueryDestinationName: TWideStringField;
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
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure actGridSettingLoadExecute(Sender: TObject);
    procedure actGridSettingSaveExecute(Sender: TObject);
    procedure actGridSettingDefaultExecute(Sender: TObject);
    procedure fStatus2Select(Sender: TObject);
    procedure fPriceLogoSelect(Sender: TObject);
    procedure cbCancelSelect(Sender: TObject);
    procedure QueryPricePurchaseGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actShowMessageExecute(Sender: TObject);
    procedure actCancelRequestExecute(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure QueryFlagGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure QueryBeforeRowRequest(DataSet: TFDDataSet);
    procedure QueryBeforeGetRecords(DataSet: TFDDataSet);
    procedure QueryAfterRowRequest(DataSet: TFDDataSet);
    procedure QueryAfterGetRecord(DataSet: TFDDataSet);
    procedure QueryAfterRefresh(DataSet: TDataSet);
    procedure QueryUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
      var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
  private
    { Private declarations }
    FAction: tFormaction;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;

    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
//    procedure OrderFCallBack(Sender: TComponent; AResult:Integer);
    procedure OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);

    procedure CancelRequest();

    /// <summary>
    /// StateActionMenuCreate - Формирование списка меню/действий для состояния
    /// </summary>
    procedure StateActionMenuCreate();

    procedure DoShowMask();
    procedure DoHideMask();

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure FilterStatusCreate();
//    procedure FilterPriceLogoCreate();

  public
    { Public declarations }

    /// <summary>
    /// GridRefresh -
    /// </summary>
    procedure GridRefresh;

    /// <summary>
    ///  GridLayout - сохранение/восстановление настроек грида
    ///  AOperation 0-сохранение
    ///             1-восстановление
    ///</summary>
    procedure GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
  end;

implementation

uses
  MainModule, uEmexUtils, uSqlUtils, uLogger, uMainVar, uOrdersProtocol_T, Main,
  ServerModule, uOrdersMessageF, uError_T, uGridUtils;

  var screenmask: Boolean;
  var Marks: TMarks;

{$R *.dfm}

procedure TOrdersT2.actCancelRequestExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите отказаться от выбранных деталей?' , mtConfirmation, mbYesNo,
  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes : CancelRequest;
      mrNo  : Exit;
    end;
  end);
end;

procedure TOrdersT2.CancelRequest;
begin
  logger.Info('actCancelRequestExecute:') ;

  Sql.Exec(' exec CustomerOrderCancelRequest  ', [], []);

  // ОБРАБОТКА ОШИБОК
  // проверка наличия серверных ошибок
  Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
  var ServerErr:integer;
  ServerErr := Sql.Q.RecordCount;

  if (ServerErr = 0) then
  begin
    //MessageDlg('Запрос успешно выполнен! ', TMsgDlgType.mtConfirmation, mbOK);
    OrdersMessageFCallBack(self, mrOk)
  end
  else
  begin
    Error_T.ShowModal;
  end;
end;

procedure TOrdersT2.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TOrdersT2.actFilterClearExecute(Sender: TObject);
begin
  fStatus2.ClearSelection;

  FFilterTextStatus := '';
  FFilterTextPriceLogo := '';
  FFilterTextClient := '';

  fOrderDate.Text:= '';
  fOrderNum.Text := '';
  fDetailNum.Text:='';

  GridRefresh();
end;

procedure TOrdersT2.actFilterExecute(Sender: TObject);
begin
  GridRefresh();
end;

procedure TOrdersT2.actGridSettingDefaultExecute(Sender: TObject);
begin
 // Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[self.ClassName +'.' + Grid.Name]);
 // GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TOrdersT2.actGridSettingLoadExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TOrdersT2.actGridSettingSaveExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TOrdersT2.actProtocolExecute(Sender: TObject);
begin
  OrdersProtocol_T.ID:= Integer(QueryOrderID.Value);
  OrdersProtocol_T.ShowModal;
end;

procedure TOrdersT2.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh();
end;

procedure TOrdersT2.actShowMessageExecute(Sender: TObject);
begin
  OrdersMessageF.FormAction := TFormAction.acMessage;
  OrdersMessageF.ID:=QueryOrderID.AsInteger;
  OrdersMessageF.ShowModal(OrdersMessageFCallBack);
end;

procedure TOrdersT2.DoHideMask;
begin
  UniSession.Synchronize;
end;

procedure TOrdersT2.DoShowMask;
begin
  UniSession.Synchronize;
end;

//procedure TOrdersT2.FilterPriceLogoCreate;
//begin
////  qPriceLogo.Open(); // используется в фильтре PriceLogo
////
////  fPriceLogo.Clear;
////  qPriceLogo.First;
////  while not qPriceLogo.Eof do
////  begin
////    fPriceLogo.Items.AddObject( qPriceLogo.FieldByName('PriceLogo').AsString, Pointer(qPriceLogo.FieldByName('PriceLogo').AsString) );
////    qPriceLogo.Next;
////  end;
////
////  fPriceLogo.Refresh;
//end;

procedure TOrdersT2.FilterStatusCreate;
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


procedure TOrdersT2.fPriceLogoSelect(Sender: TObject);
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
  GridRefresh;
  logger.Info('FFilterTextPriceLogo: ' + FFilterTextPriceLogo) ;
end;

procedure TOrdersT2.fStatus2Select(Sender: TObject);
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
  GridRefresh;
  logger.Info('FFilterTextStatus: ' + FFilterTextStatus);
end;

procedure TOrdersT2.GridRefresh;
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

  if (fOrderDate.Text <> '') and (fOrderDate.Text <> '30.12.1899') then
     Query.MacroByName('OrderDate').Value := ' and o.OrderDate = '''   + FormatDateTime('yyyymmdd', fOrderDate.DateTime) + ''''
  else
     Query.MacroByName('OrderDate').Value := '';

  Query.MacroByName('Status').Value :=  FStatus;
  Query.MacroByName('PriceLogo').Value := FPriceLogo;
  Query.ParamByName('OrderNum').Value := fOrderNum.Text;
  Query.ParamByName('DetailNum').Value := fDetailNum.Text;
  Query.ParamByName('isCancel').Value := cbCancel.ItemIndex;
  Query.ParamByName('ClientID').Value := UniMainModule.AUserID; //  AUserID- туту ид клиента
  Query.Open();

  logger.Info('GridOpen End');
end;

procedure TOrdersT2.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;
 // GetMarksInfo;
end;

procedure TOrdersT2.OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);
begin
  logger.Info('OrdersMessageFCallBack begin');
  if AResult <> mrOK then Exit;

//  try
   // if OrdersMessageF.FormAction = acMessage then
    begin
      //Query.Edit ;
      //Query.Post;

      Marks.DataRefresh;

//      ToastOK('Комментарий успешно сохранен!', unisession);
    end;
    logger.Info('OrdersMessageFCallBack end');
//  except
//    on E: Exception do
//      logger.Info('TOrdersT2.OrdersMessageFCallBack Ошибка: ' + e.Message);
//  end;
end;

//procedure TOrdersT2.GetMarksInfo;
//begin
//  lblSelRowCunt.Caption := 'Выделено строк: ' + Grid.SelectedRows.Count.ToString + '  ';
//
//  if Marks.Count > 0 then
//  begin
//    Sql.Open('Select Amount, AmountPurchase from vMarksSum', [], []);
//
//    lblSelRowSum.Caption  := '  Сумма строк: ' + Sql.Q.FieldByName('Amount').AsString  + '  ₽';
//    lblSelRowSum2.Caption := ' ' + Sql.Q.FieldByName('AmountPurchase').AsString+  ' $';
//  end
//  else
//  begin
//    lblSelRowSum.Caption  := '  Сумма строк: 0 ₽';
//    lblSelRowSum2.Caption := ' 0 $';
//  end;
//end;

procedure TOrdersT2.ppMainPopup(Sender: TObject);
begin
  actProtocol.Visible := Query.RecordCount>0;

  actShowMessage.Visible:= (Query.RecordCount>0 ) and
                          ((Query.FieldByName('Flag').AsInteger and 32) = 32);
end;

procedure TOrdersT2.QueryAfterGetRecord(DataSet: TFDDataSet);
begin
  logger.Info('QueryAfterGetRecord: ');
end;

procedure TOrdersT2.QueryAfterRefresh(DataSet: TDataSet);
begin
  logger.Info('QueryAfterRefresh: ');
end;

procedure TOrdersT2.QueryAfterRowRequest(DataSet: TFDDataSet);
begin
  logger.Info('QueryAfterRowRequest: ');
end;

procedure TOrdersT2.QueryBeforeGetRecords(DataSet: TFDDataSet);
begin
  logger.Info('QueryBeforeGetRecords: ');
end;

procedure TOrdersT2.QueryBeforeRowRequest(DataSet: TFDDataSet);
begin
  logger.Info('QueryBeforeRowRequest: ');
end;

procedure TOrdersT2.QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'DetailNumber') and (QueryReplacementDetailNumber.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span><span class="x-replacement-detail-number">' + QueryReplacementDetailNumber.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var t: string;
begin
  logger.Info('QueryFlagGetText: ');
  t := '';

  if (Sender.AsInteger and 32) > 0 then
  begin
    t := t + '<div class="x-orders-message"><i class="fa fa-exclamation-triangle"></i></div> ';
  end;

  // запрошен отказ по детали
  if (Sender.AsInteger and 64) > 0 then
  begin
    t := t + '<span class="x-request-cancellation" data-qtip="Запрос отказа"><i class="fa fa-question-circle"></i></span> ';
  end;

   // отказ по детали
  if (Sender.AsInteger and 128) > 0 then
  begin
    t := t + '<span class="x-cancellation" data-qtip="Отказ по детали"><i class="fa fa-ban"></i></span> ';
  end;

  Text := t;
end;

procedure TOrdersT2.QueryMakeLogoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'MakeLogo') and (QueryReplacementMakeLogo.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-make-logo-arrow">&#10149;</span><span class="x-replacement-make-logo">' + QueryReplacementMakeLogo.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'Manufacturer') and (QueryReplacementManufacturer.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-manufacturer-arrow">&#10149;</span><span class="x-replacement-manufacturer">' + QueryReplacementManufacturer.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryPricePurchaseGetText(Sender: TField; var Text: string;
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

procedure TOrdersT2.QueryUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  logger.Info('QueryUpdateRecord: ');
end;

procedure TOrdersT2.GridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;
end;

procedure TOrdersT2.GridCellContextClick(Column: TUniDBGridColumn; X,Y: Integer);
begin
  ACurrColumn := Column;
end;

procedure TOrdersT2.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (Query.FieldByName('Flag').AsInteger and 1) = 1 then
  begin
    Attribs.Color:= rgb(255, 207, 217);
  end
  else if (Query.FieldByName('Flag').AsInteger and 2) = 2 then
  begin
    Attribs.Color:=rgb(242, 169, 210);
  end;
//  else if (Query.FieldByName('Flag').AsInteger and 32) = 32 then
//  begin
//    Attribs.Color:=rgb(0,191,255);
//  end;
//  else if (Query.FieldByName('Flag').AsInteger and 64) = 64 then // Горчичный
//  begin
//    Attribs.Color:=rgb(255,219,88); //#F34723
//  end;


  if (Query.FieldByName('Flag').AsInteger and 4) > 0 then // отказан
  begin
    Attribs.Font.Color:=clGray;
  end;
end;

procedure TOrdersT2.GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
begin

end;

procedure TOrdersT2.StateActionMenuCreate;
begin

end;

procedure TOrdersT2.cbCancelSelect(Sender: TObject);
begin
  GridRefresh;
end;

procedure TOrdersT2.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TOrdersT2.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TOrdersT2.UniFrameCreate(Sender: TObject);
var
  I: Integer;
  IndexnameAsc : string;
  IndexnameDes : string;
begin
  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

  actSelect.Caption := '';
  actUnSelect.Caption := '';
  fOrderDate.Text     := '';

  FilterStatusCreate;

  // индексы для сортировки
    // индексы для сортировки
//  GridExt.SortColumnCreate(Grid);

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

  // восстановление настроек грида для пользователя
  GridLayout(Self, Grid, tGridLayout.glLoad, False);

 // actExecuteActionEnabled.Enabled  := Grid.SelectedRows.Count > 0;
 // actExecuteActionRollback.Enabled := Grid.SelectedRows.Count > 0;

  // объект для упраления метками
  Marks := tMarks.Create(Grid);
  Marks.Clear;

  //GetMarksInfo;

  logger.Info('UniFrameCreate End');
end;

procedure TOrdersT2.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
end;

procedure TOrdersT2.UniFrameReady(Sender: TObject);
begin
  qPriceLogo.Open();
end;

//procedure TOrdersT2.OrderFCallBack(Sender: TComponent; AResult: Integer);
//begin
//
//end;

procedure TOrdersT2.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
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

procedure tMarks.DeleteInDB();
begin
  Sql.Exec('Delete tMarks from tMarks with (rowlock index=pk_tMarks) where Spid=@@Spid', [], [])
end;

procedure tMarks.Clear;
begin
  DeleteInDB();
  FMarks.Clear;
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
begin
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
  RegisterClass(TOrdersT2);
end.
