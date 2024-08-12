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
  uniMainMenu, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, uCommonType, uniButton, uniBitBtn, uniLabel, uniDBComboBox,
  uniGroupBox, uniDBLookupComboBox, Vcl.StdActns, Vcl.StdCtrls, Vcl.Clipbrd,

  uAccrualUtils, uniSweetAlert, unimSelect, unimDBSelect, uniSegmentedButton,

  System.Generics.Collections, System.MaskUtils, uniFileUpload,
  uniDateTimePicker, uniScreenMask, uniTimer, uniThreadTimer, uSqlUtils;

type
  tMarks = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FGrid: TUniDBGrid;

    FMarks: TDictionary <Integer, Integer>;

    procedure DeleteInDB();
    function GetCount: Integer;

    property Count: Integer read GetCount;
  public
    constructor Create(AGrid: TUniDBGrid);
    destructor Destroy; override;

    procedure Select();
    procedure Clear();


    procedure DataRefresh();
  end;



  TOrdersT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    actMain: TUniActionList;
    actEdit: TAction;
    ppMain: TUniPopupMenu;
    actRefreshAll: TAction;
    N6: TUniMenuItem;
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
    QueryDeliveryPlanDateSupplier: TSQLTimeStampField;
    QueryDeliveredDateToSupplier: TSQLTimeStampField;
    DeliveryDaysReserve: TIntegerField;
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
    ppExecuteAction: TUniMenuItem;
    actExecuteAction: TAction;
    actExecuteActionEnabled: TAction;
    QueryStatusID: TFMTBCDField;
    actExecuteActionRollback: TAction;
    N3: TUniMenuItem;
    QueryFlag: TIntegerField;
    QueryOverPricing: TCurrencyField;
    QueryWarning: TWideStringField;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    QueryReplacementMakeLogo: TWideStringField;
    QueryReplacementDetailNumber: TWideStringField;
    QueryMakeLogo: TWideStringField;
    QueryReplacementManufacturer: TWideStringField;
    UniImageListAdapter: TUniImageListAdapter;
    actProtocol: TAction;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    UniImageList: TUniImageList;
    UniImageList32: TUniImageList;
    actFilter: TAction;
    actFilterClear: TAction;
    actSelect: TAction;
    actUnselect: TAction;
    actGridSettingDefault: TAction;
    N7: TUniMenuItem;
    N11: TUniMenuItem;
    QueryDetailName: TWideStringField;
    fStatus2: TUniCheckComboBox;
    fPriceLogo: TUniCheckComboBox;
    fClient: TUniCheckComboBox;
    qPriceLogoPriceLogo: TWideStringField;
    N12: TUniMenuItem;
    N4: TUniMenuItem;
    pnlGridSelectedCount: TUniPanel;
    UniLabel6: TUniLabel;
    QueryCustomerPriceLogo: TWideStringField;
    UniPanel3: TUniPanel;
    lblSelRowCunt: TUniLabel;
    UniPanel4: TUniPanel;
    lblSelRowSum: TUniLabel;
    UniPanel5: TUniPanel;
    N5: TUniMenuItem;
    QueryDestinationLogo: TWideStringField;
    QueryInvoice: TWideStringField;
    lblRowSum2: TUniLabel;
    lblRowSum1: TUniLabel;
    UniLabel7: TUniLabel;
    lblWeightKG: TUniLabel;
    lblVolumeKG: TUniLabel;
    QueryFileDate: TSQLTimeStampField;
    QueryIncomePRC: TCurrencyField;
    actSetComment: TAction;
    N14: TUniMenuItem;
    fOrderDate: TUniDateTimePicker;
    UniLabel8: TUniLabel;
    actGroupDetailNameEdit: TAction;
    N15: TUniMenuItem;
    N16: TUniMenuItem;
    actGroupAction: TAction;
    QueryDeliveryRestTermSupplier: TIntegerField;
    QueryOverVolume: TCurrencyField;
    UniPanel1: TUniPanel;
    UniLabel9: TUniLabel;
    lblOverVolume: TUniLabel;
    edtUpdDate: TUniDateTimePicker;
    UniLabel10: TUniLabel;
    edtInvoice: TUniEdit;
    UniLabel11: TUniLabel;
    actGroupSetFragileSign: TAction;
    Fragile1: TUniMenuItem;
    QueryDeliveryNextDate2: TSQLTimeStampField;
    QueryDateDeparture: TSQLTimeStampField;
    QueryDaysInWork: TIntegerField;
    UniHiddenPanel1: TUniHiddenPanel;
    fDetailNum: TUniEdit;
    QueryStatus: TIntegerField;
    actCancellation: TAction;
    N8: TUniMenuItem;
    QueryFragile: TBooleanField;
    TimerProcessedShow: TUniTimer;
    ppExecute: TUniPopupMenu;
    QueryOrderUniqueCount: TIntegerField;
    QueryReplacementPrice: TCurrencyField;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure GridSelectionChange(Sender: TObject);
    procedure actExecuteActionExecute(Sender: TObject);
    procedure actExecuteActionRollbackExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellClick(Column: TUniDBGridColumn);
    procedure QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryMakeLogoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actProtocolExecute(Sender: TObject);
    procedure ppMainPopup(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actFilterClearExecute(Sender: TObject);
    procedure actSelectExecute(Sender: TObject);
    procedure actUnselectExecute(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure actGridSettingDefaultExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure fStatus2Select(Sender: TObject);
    procedure fPriceLogoSelect(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
    procedure actEditExecute(Sender: TObject);

    procedure actSetCommentExecute(Sender: TObject);
    procedure actGroupDetailNameEditExecute(Sender: TObject);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex, NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure fStatus2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actGroupSetFragileSignExecute(Sender: TObject);
    procedure QueryNextDateDepartureGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actCancellationExecute(Sender: TObject);
    procedure QueryPricePurchaseFGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure UniFrameReady(Sender: TObject);
    procedure TimerProcessedShowTimer(Sender: TObject);
    procedure QueryPricePurchaseGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FAction: tFormaction;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;
    Marks: TMarks;                  // отметки
    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    FSql: tSQL;
    FAccrual: TAccrual;

    FProcessed: Integer;
    FTotal    : Integer;

    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

    /// <summary>
    ///  OrdersFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure OrdersFCallBack(Sender: TComponent; AResult:Integer);
    procedure OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);
    /// <summary>
    ///  GroupDetailNameEditCallBack - CallBack обработчик группового изменения наименования детали
    ///</summary>
    procedure GroupDetailNameEditCallBack(Sender: TComponent; AResult:Integer);
    /// <summary>
    ///  GroupSetFragileSignCallBack - CallBack обработчик группового изменения признака Fragile (хрупкий)
    ///</summary>
    procedure GroupSetFragileSignCallBack(Sender: TComponent; AResult:Integer);
    /// <summary>
    /// StateActionMenuCreate - Формирование списка меню/действий для состояния
    /// </summary>
    procedure StateActionMenuCreate();
    procedure ActionExecuteEnabled();

    /// <summary> ActionExecute - запуск выполнения действия. Набор данных в pAccrualAction </summary>
    procedure ActionExecute(ActionID: Integer);

    procedure DoShowMask(Astr: string = 'Ждите, операция выполняется');
    procedure DoHideMask();

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure FilterStatusCreate();
    procedure FilterPriceLogoCreate();
    procedure FilterClientsCreate();

    /// <summary>Select - выделить/ снять выделение с записи</summary>
    procedure Select();
    /// <summary>SelectAll - выделить все записи таблицы</summary>
    procedure SelectAll();
    /// <summary>DeselectAll - снять выделения со всех записей таблицы</summary>
    procedure DeselectAll();
    /// <summary>GetMarksInfo - получение информации по выделенным строкам (сумма, количество)</summary>
    procedure GetMarksInfo();
    /// <summary>OrderSetCancellation - установка признака: Запрошен отказ</summary>
    procedure OrderSetCancellation();
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
  MainModule, uGrantUtils, uEmexUtils, uLogger, uError_T, uMainVar, uOrdersProtocol_T, Main, uOrdersF, ServerModule,  uToast, uOrdersMessageF, uGroupDetailNameEditF, uGroupSetFragileSignF, uGridUtils, uVarUtils, uStatusForm;

{$R *.dfm}

procedure TOrdersT.actCancellationExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите проставить признак "Запрошен отказ"? ' , mtConfirmation, mbYesNo,

  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes : OrderSetCancellation;
      mrNo  : Exit;
    end;
  end

  );
end;

procedure TOrdersT.OrderSetCancellation;
begin
  logger.Info('OrderSetCancellation:') ;

  Sql.Exec(' exec OrderSetCancellation  ', [], []);

  // ОБРАБОТКА ОШИБОК
  // проверка наличия серверных ошибок
  Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
  var ServerErr:integer;
  ServerErr := Sql.Q.RecordCount;

  if (ServerErr = 0) then
  begin

    Marks.DataRefresh;
    ToastOK ('Операция успешно выполнена!', UniSession);
    //OrdersMessageFCallBack(self, mrOk)
  end
  else
  begin
    Error_T.ShowModal;
  end;
end;

procedure TOrdersT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TOrdersT.actEditExecute(Sender: TObject);
var i, y: Integer;
   BM: TBookmark;
   SqlText: string;
begin
  OrderF.FormAction := TFormAction.acUpdate;
  OrderF.ID:=QueryOrderID.AsInteger;

  OrderF.IsCounter := False;

  if fStatus2.SelCount = 1 then
  begin
    for i:= 0 to fStatus2.Items.Count-1 do
    begin
      if ((fStatus2.Selected[i] = True) and
          (integer(fStatus2.Items.Objects[i]) in [1, //	New	Новый
                                                  2, //	InChecked	Проверено
                                                  22 //	Preparation	Предварительный
                                                  ]))
      then
      begin
        OrderF.IsCounter := True;


        BM := Query.GetBookmark;
        Query.DisableControls;
        try

          Query.first;
          for y := 0 to Query.RecordCount - 1 do
          begin
            if y = 0 then
              SqlText:= SqlText + ' Insert into #CounterPart (OrderID, N) '
            else
              SqlText:= SqlText + ' Union all ';

            SqlText:= SqlText + ' select ' + Query.FieldByName('OrderID').AsString + ', ' + y.ToString;

            Query.Next;
          end;

        finally
          Query.GotoBookmark(BM);
          Query.FreeBookmark(BM);
          Query.EnableControls;
        end;

        logger.Info(SqlText);

        sql.Exec('''
                    if OBJECT_ID('tempdb..#CounterPart') is not null
                      drop table #CounterPart

                     CREATE TABLE #CounterPart (OrderID   Numeric(18, 0)
                                               ,N         int
                                               ,Processed bit
                                               );

                 ''' + SqlText
                 , [], []);


        Continue;
      end;
    end;
  end;

  OrderF.ShowModal(OrdersFCallBack);
end;

procedure TOrdersT.actExecuteActionExecute(Sender: TObject);
var ActionID: Integer;
    Brief, FName: string;

    RecNo: integer;
begin
  Query.DisableControls;

  RecNo:=Query.RecNo;
  try
    ActionID := (Sender as TAction).ActionComponent.Tag;

    if ActionID > 0 then
    begin
      Sql.Open('Select Brief, Name from tNodes (nolock) where NodeID=:NodeID', ['NodeID'], [ActionID]);
      Brief    := Sql.Q.FieldByName('Brief').AsString;
      FName    := Sql.Q.FieldByName('Name').AsString;
      Sql.Q.Close;

      if Brief = 'ToInWork' then   //ToInWork	Создать заказ
      begin
        MessageDlg('Действие [' + FName + '] создает заказ по всем деталям в состоянии "В корзине", даже если заказ не отмечен!' +#13+#10 +#13+#10+
                   'Продолжить выполнение операции?' , mtConfirmation, mbYesNo,
          procedure(Sender: TComponent; Res: Integer)
          begin
            case Res of
              mrYes : ActionExecute(ActionID);
              mrNo  : Exit;
            end;
          end);
      end
      else
      begin
        ActionExecute(ActionID);
      end;
    end;
  finally
    Query.RecNo:=RecNo;
    Query.EnableControls;
  end;
end;

procedure TOrdersT.ActionExecute(ActionID: Integer);
begin
  logger.Info('TOrdersT.ActionExecute Begin');

  DoShowMask;

  FAccrual.ShowProgress := False;
  FAccrual.Finished := False;

  FProcessed:= 0;
  FTotal    := 0;


  Sql.exec(
  '''
    -- таблица для возврата количества обработанных записей
    delete from #ProcessedRecords

  ''', [], []);

  if ActionID = 14	{ToBasket	Добавить в корзину} then
  begin
    logger.Info('TOrdersT.ActionExecute 1');
    Sql.exec(' insert #ProcessedRecords (Processed, Total) select 0, 0 ', [], []);
    FAccrual.ShowProgress := True;
  end;

  TimerProcessedShow.Enabled:=True;

  RetVal.Clear;
  RetVal.Code := FAccrual.ActionExecute(ActionID);

  if (RetVal.Code > 0)then
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

  logger.Info('TOrdersT.ActionExecute End');
end;

procedure TOrdersT.actExecuteActionRollbackExecute(Sender: TObject);
var Accrual: TAccrual;
begin
  logger.Info('TOrdersT.actExecuteActionRollbackExecute Begin');
  Query.DisableControls;
  try
    case (MessageDlg('Вы действительно хотите отменить операцию?' , mtConfirmation, mbYesNo))  of
      mrNo:
      begin
        Exit;
      end;
    end;

    DoShowMask;

    Accrual := TAccrual.Create(UniMainModule.FDConnection);
    if Accrual.ActionExecuteRollback() = 0 then
    begin
      GridOpen();

      ToastOK('Операция успешно выполнена!', UniSession);
    end;
  finally
    Query.EnableControls;
    DoHideMask;
  end;
  logger.Info('TOrdersT.actExecuteActionRollbackExecute Begin');
end;

procedure TOrdersT.actFilterClearExecute(Sender: TObject);
begin
  DoShowMask;

  fStatus2.ClearSelection;
  fPriceLogo.ClearSelection;
  fClient.ClearSelection;

  FFilterTextStatus := '';
  FFilterTextPriceLogo := '';
  FFilterTextClient := '';

  fOrderNum.Text := '';
  fDetailNum.Text:='';

  fOrderDate.Text := '';
  edtUpdDate.Text := '';
  edtInvoice.Text := '';

  DoHideMask;
end;

procedure TOrdersT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TOrdersT.actGridSettingDefaultExecute(Sender: TObject);
begin
  Sql.Exec('''
              delete tGridOptions
                from tGridOptions (rowlock)
               where UserID = dbo.GetUserID()
                 and Grid   = :Grid
           ''',
           ['Grid'],
           [self.ClassName +'.' + Grid.Name]);
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TOrdersT.actGroupDetailNameEditExecute(Sender: TObject);
begin
  // групповое изменение наименования детали
  GroupDetailNameEditF.FormAction := TFormAction.acUpdate;
  GroupDetailNameEditF.ShowModal(GroupDetailNameEditCallBack);
end;

procedure TOrdersT.actGroupSetFragileSignExecute(Sender: TObject);
begin
  //Групповое изменение признака Fragile
  GroupSetFragileSignF.FormAction := TFormAction.acUpdate;
  GroupSetFragileSignF.ShowModal(GroupSetFragileSignCallBack);
end;

 procedure TOrdersT.ActionExecuteEnabled;
begin
  logger.Info('TOrdersT.ActionExecuteEnabled Begin');
  //добавляем метки в таблицу
  try
    Sql.Q.Close;
    Sql.Open('Select distinct StatusID, IsStartState from vMarkOrderState where spid = :Spid and Type = 3', ['Spid'], [SPID]);

    logger.Info('marks.Count: ' + marks.Count.ToString);
    logger.Info('SPID: ' + SPID.ToString);
    logger.Info('RecordCount: ' + Sql.Q.RecordCount.ToString);
    logger.Info('IsStartState:' + Sql.Q.FieldByName('IsStartState').AsString);

    // контроль доступности меню действий, если 2 разных состояния, то меню не доступно
    actExecuteActionEnabled.Enabled := (actExecuteActionEnabled.Tag = 1) and (marks.Count > 0) and (Sql.Q.RecordCount = 1);

    actExecuteActionRollback.Enabled  := (actExecuteActionRollback.Tag = 1) and  (marks.Count > 0)
      and (Sql.Q.RecordCount = 1)
      and (Sql.Q.FieldByName('IsStartState').AsInteger <> Integer(tInstrumentFlag.isStartState));

    StateActionMenuCreate;

  finally
    logger.Info('TOrdersT.ActionExecuteEnabled End');
  end;
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
  HideMask();
  UniSession.Synchronize
end;

procedure TOrdersT.DoShowMask(Astr: string = 'Ждите, операция выполняется');
begin
  ShowMask(Astr);
  UniSession.Synchronize
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

  logger.Info('FFilterTextPriceLogo: ' + FFilterTextPriceLogo) ;
end;

procedure TOrdersT.fStatus2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridOpen(Key);
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

  logger.Info('FFilterTextStatus: ' + FFilterTextStatus);
end;

procedure TOrdersT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TOrdersT.GridOpen;
var FClient:string;
    FStatus :string;
    FPriceLogo :string;
begin
  logger.Info('TOrdersT.GridOpen Begin');
  DoShowMask;
  try
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

    if (FStatus <> '') or (not edtInvoice.IsBlank )then
    begin
      Grid.Refresh;
      Grid.WebOptions.Paged := True;
      Grid.WebOptions.PageSize:=100000;
    end
    else
    begin
      Grid.WebOptions.Paged := True;
      Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);
    end;

    Query.MacroByName('Status').Value    := FStatus;
    Query.MacroByName('PriceLogo').Value := FPriceLogo;
    Query.MacroByName('Client').Value    := FClient;

    if fOrderNum.Text <> '' then
      Query.MacroByName('OrderNum').Value := ' and o.OrderNum like '''   + fOrderNum.Text + ''''
    else
      Query.MacroByName('OrderNum').Value := '';

    if fDetailNum.Text <> '' then
      Query.MacroByName('DetailNum').Value := ' and (o.DetailNumber like '''   + Trim(fDetailNum.Text) + '''' +
                                              '   or o.ReplacementDetailNumber like '''   + Trim(fDetailNum.Text) + ''')'
    else
      Query.MacroByName('DetailNum').Value := '';

    if cbCancel.ItemIndex > -1 then
      Query.MacroByName('isCancel').Value := ' and o.isCancel = ' + cbCancel.ItemIndex.ToString
    else
      Query.MacroByName('isCancel').Value := '';

    if (fOrderDate.Text <> '') and (fOrderDate.Text <> '30.12.1899') then
      Query.MacroByName('OrderDate').Value := ' and o.OrderDate = '''   + FormatDateTime('yyyymmdd', fOrderDate.DateTime) + ''''
    else
      Query.MacroByName('OrderDate').Value := '';

    if (edtUpdDate.Text <> '') and (edtUpdDate.Text <> '30.12.1899') then
      Query.MacroByName('updDateTime').Value := ' and cast(o.updDateTime as date) = '''   + FormatDateTime('yyyymmdd', edtUpdDate.DateTime) + ''''
    else
      Query.MacroByName('updDateTime').Value := '';

    if edtInvoice.Text <> '' then
      Query.MacroByName('Invoice').Value := ' and o.Invoice like '''   + edtInvoice.Text + ''''
    else
      Query.MacroByName('Invoice').Value := '';

    Query.Open();

    StateActionMenuCreate;

  finally
    DoHideMask();
    UniSession.Synchronize;
    logger.Info('TOrdersT.GridOpen End');
  end;
end;

procedure TOrdersT.GridSelectionChange(Sender: TObject);
begin
  logger.Info('TOrdersT.GridSelectionChange Begin');

  Marks.Select;

  GetMarksInfo;

  ActionExecuteEnabled;

  logger.Info('TOrdersT.GridSelectionChange End');
end;

procedure TOrdersT.GroupDetailNameEditCallBack(Sender: TComponent;
  AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  try
    if GroupDetailNameEditF.FormAction = acUpdate then
    begin
      //Query.Edit ;
      //Query.Post;
      Marks.DataRefresh;

      ToastOK('Изменения успешно внесены!', unisession);
    end;
  except
    on E: Exception do
      logger.Info('TOrdersT.GroupDetailNameEditCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.GroupSetFragileSignCallBack(Sender: TComponent;
  AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  try
    if GroupSetFragileSignF.FormAction = acUpdate then
    begin

      ToastOK('Изменения успешно внесены!', unisession);
    end;
  except
    on E: Exception do
      logger.Info('TOrdersT.GroupSetFragileSignCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.GetMarksInfo;
begin
  lblSelRowCunt.Caption := 'Выделено строк: ' + Grid.SelectedRows.Count.ToString + '  ';

  if Marks.Count > 0 then
  begin
    Sql.Open('Select Amount, AmountPurchase, WeightKG, VolumeKG, OverVolume from vMarksSum', [], []);

    lblRowSum1.Caption := FormatFloat('###,##0.00 ₽', Sql.Q.FieldByName('Amount').Value );
    lblRowSum2.Caption := FormatFloat('###,##0.00 $', Sql.Q.FieldByName('AmountPurchase').Value);

    lblWeightKG.Caption := Sql.Q.FieldByName('WeightKG').AsString+  ' Кг';
    lblVolumeKG.Caption := Sql.Q.FieldByName('VolumeKG').AsString+  ' V';

    lblOverVolume.Caption := Sql.Q.FieldByName('OverVolume').AsString+  ' V';
  end
  else
  begin
    lblRowSum1.Caption := '0 ₽';
    lblRowSum2.Caption := '0 $';

    lblWeightKG.Caption:= '0 Кг';
    lblVolumeKG.Caption:= '0 V';

    lblOverVolume.Caption:= '0 V';
  end;
end;

procedure TOrdersT.ppMainPopup(Sender: TObject);
begin
  actProtocol.Enabled := (actProtocol.Tag=1) and (Query.RecordCount>0);

  actGroupDetailNameEdit.Enabled := (actGroupDetailNameEdit.Tag=1) and (Marks.Count>0);
  actGroupSetFragileSign.Enabled := (actGroupSetFragileSign.Tag=1) and (Marks.Count>0);

  actExecuteActionEnabled.Enabled  := (actExecuteActionEnabled.Tag = 1) and (Marks.Count > 0);
  actExecuteActionRollback.Enabled := (actExecuteActionRollback.Tag= 1) and (Marks.Count > 0);

  actCancellation.Enabled :=  (actCancellation.Tag = 1) and (Marks.Count > 0);
end;

procedure TOrdersT.QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (Sender.FieldName = 'DetailNumber') and (QueryReplacementDetailNumber.Value <> '') then
  begin
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

procedure TOrdersT.QueryNextDateDepartureGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  // Ближайшая дата вылета
  if (Sender.FieldName = 'DeliveryNextDate') and (not QueryDeliveryNextDate2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryNextDate2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryPricePurchaseFGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if not IsEmptyOrNull(Sender.Value) then
  begin
    if (Sender.Value > QueryPricePurchase.Value)  then
      Text := '<span class="x-replacement-price-arrow-inc">&#11014; </span><span class="x-replacement-price">' +FormatFloat('###,##0.00 $', Sender.Value) + '</span>'
    else
    if  (Sender.Value < QueryPricePurchase.Value)  then
      Text := '<span class="x-replacement-price-arrow-dec">&#11015; </span><span class="x-replacement-price">' + FormatFloat('###,##0.00 $', Sender.Value) + '</span>'
    else
      Text := Sender.AsString;
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryPricePurchaseGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (not QueryReplacementPrice.IsNull) then
  begin
    Text := '<span>' +FormatFloat('###,##0.00 $', Sender.AsFloat) +  '</span><br><span class="x-replacement-price">&#10149;'+
            '</span><span class="x-replacement-price">' + FormatFloat('###,##0.00 $', QueryReplacementPrice.Value) + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var t: string;
begin
 // logger.Info('QueryFlagGetText: ');
  t := '';

  if (Sender.AsInteger and 32) > 0 then
  begin
    t := t + '<div class="grid-order-message" data-qtip="Сообщение клиенту"><i class="fa fa-exclamation-triangle"></i></div> ';
  end;

  if (Sender.AsInteger and 64) > 0 then
  begin
    t := t + '<span class="grid-order-request-cancellation" data-qtip="Клиент запросил отказ по детали"><i class="fa fa-question-circle"></i></span> ';
  end;

  if (Sender.AsInteger and 128) > 0 then
  begin
    t := t + '<span class="grid-order-cancellation" data-qtip="Запрошен отказ"><i class="fa fa-ban"></i></span> ';
  end;

  if (Sender.AsInteger and 512) > 0 then
  begin
    t := t + '<span class="grid-order-balance-scale" data-qtip="Клиент изменил вес детали"><i class="fa fa-balance-scale"></i></span> ';
  end;

  if Query.FieldByName('Fragile').AsBoolean then
  begin
    t := t + '<span class="grid-order-fragile" data-qtip="Fragile - Хрупкий товар"><i class="fa fa-fragile"></i></span> ';
  end;

  Text := t;
end;

procedure TOrdersT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  logger.Info(EventName);
  if (EventName = '_columnhide')
  then
  begin
      Sql.Exec('exec GridOptionsVisible ' +
               '       @Grid   = :Grid'+
               '      ,@Column = :Column '+
               '      ,@Visible= 0 ',
              ['Grid', 'Column'],
              [self.ClassName +'.' + Grid.Name,
               Grid.Columns[Params['column'].Value.ToInteger].FieldName ]);
  end
  else
  if (EventName = '_columnshow')
  then
  begin
    Sql.Exec('exec GridOptionsVisible ' +
             '       @Grid   = :Grid'+
             '      ,@Column = :Column '+
             '      ,@Visible= 1 ',
            ['Grid', 'Column'],
            [self.ClassName +'.' + Grid.Name,
             Grid.Columns[Params['column'].Value.ToInteger].FieldName ]);
  end
  else
  if (EventName = 'btnStatusFormShow')
  then
  begin
    var StatusForm: TStatusForm;

    StatusForm := TStatusForm.Create(UniSession.UniApplication);
    StatusForm.StatusFile := UniServerModule.StartPath + '\files\html\OrderStatus.html';

    StatusForm.ShowModal();
   // StatusForm.Free;
  end;
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
    UniSession.BrowserWindow(Format('https://www.google.com/search?tbm=isch&q=%s+%s', [QueryManufacturer.Value, QueryDetailNumber.Value]), 0, 0, '_blank');
  end
  else
  if ( (ACurrColumn.FieldName = 'DetailName')
    or (ACurrColumn.FieldName = 'WeightKGF')
    or (ACurrColumn.FieldName = 'VolumeKGF') )
  then
  begin
    actEditExecute(Sender);
  end;
end;

procedure TOrdersT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (Query.FieldByName('Flag').AsInteger and 1) = 1 then // 1 - Превышение цены
  begin
    //Attribs.Font.Color:=clMaroon;
    //Attribs.Font.Style:=[fsBold, fsItalic];
    Attribs.Color:= rgb(255, 207, 217);
  end
  else if (Query.FieldByName('Flag').AsInteger and 2) = 2 then // 2 - Нет цены
  begin
    Attribs.Color:=rgb(242, 169, 210);
  end;

  if (Query.FieldByName('IsCancel').AsBoolean) then // отказан
  begin
    Attribs.Font.Color:=clGray;
  end;
end;

procedure TOrdersT.GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
var
  i: integer;
  SqlText: string;
  Column: TUniBaseDBGridColumn;
begin
  if not (AGrid is TUniDBGrid) then Exit;

  if AOperation=tGridLayout.glSave then
  begin
    Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid',
            ['Grid'],
            [AForm.ClassName +'.' + AGrid.Name]);

    SqlText:='';

    for i := 0 to AGrid.Columns.count-1 do
    begin
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
          //AGrid.Columns[i].Locked.ToInteger Locking
        ]);
    end;

    logger.Info(SqlText);
    Sql.Exec(SqlText,[],[]);

  end
  else
  if AOperation=tGridLayout.glLoad then
  begin
    Sql.Q.Close;
    Sql.Open('select * '+
             '  from tGridOptions (nolock) '+
             ' where UserID = dbo.GetUserID() '+
             '   and Grid =:Grid '+
             ' order by Position ',
            ['Grid'], [AForm.ClassName +'.' + AGrid.Name]);
    Sql.Q.First;
    for i:= 0 to Sql.Q.RecordCount-1 do
    begin
      try
        Column := AGrid.Columns.ColumnFromFieldName(Sql.Q.FieldByName('Column').AsString);
        Column.Index  := Sql.Q.FieldByName('Position').AsInteger;
        Column.Width  := Sql.Q.FieldByName('Width').AsInteger;
        Column.Visible:= Sql.Q.FieldByName('Visible').AsBoolean;
      except
        on E: Exception do
        begin
          logger.Info('TOrdersT.GridLayout Ошибка: ' + e.Message);
          logger.Info('TOrdersT.GridLayout Column: ' + Sql.Q.FieldByName('Column').AsString);
        end;
      end;
      Sql.Q.Next;
    end;
  end;

  if AShowResultMessage = True then
    ToastOK ('Успешно выполнено!', unisession);
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
var
  newitem: TUnimenuitem;
  i: Integer;
begin
  ppExecute.Items.Clear;
  ppExecuteAction.Clear;

  Sql.Open('Select distinct ActionID, ActionName from vMarkOrderStateAction', [], []);
  if Sql.Q.RecordCount > 0 then
  begin
    Sql.Q.First;
    for I := 0 to Sql.Q.RecordCount-1 do
    begin
      newitem := TUnimenuitem.create(ppExecute);
      newitem.Action  := actExecuteAction;
      newitem.caption := Sql.Q.FieldByName('ActionName').AsString;
      newitem.Tag     := Sql.Q.FieldByName('ActionID').AsInteger;
      ppExecute.items.insert(ppExecute.items.count, newitem);

      newitem := TUnimenuitem.create(ppExecute);
      newitem.Action  := actExecuteAction;
      newitem.caption := Sql.Q.FieldByName('ActionName').AsString;
      newitem.Tag     := Sql.Q.FieldByName('ActionID').AsInteger;
      ppExecuteAction.Insert(ppExecuteAction.count, newitem);

      Sql.Q.Next;
    end;
  end;
end;

procedure TOrdersT.actSelectExecute(Sender: TObject);
begin
  SelectAll;
end;

procedure TOrdersT.actSetCommentExecute(Sender: TObject);
begin
  OrdersMessageF.FormAction := TFormAction.acUpdate;
  OrdersMessageF.ID:=QueryOrderID.AsInteger;
  OrdersMessageF.ShowModal(OrdersMessageFCallBack);
end;

procedure TOrdersT.actUnselectExecute(Sender: TObject);
begin
  DeselectAll;
end;

procedure TOrdersT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TOrdersT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridLayout(Self, Grid, tGridLayout.glSave, False);
end;

procedure TOrdersT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridLayout(Self, Grid, tGridLayout.glSave, False);
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
  logger.Info('TOrdersT.UniFrameCreate Begin');

  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}

  Grant.SetGrant(self, actMain);

  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

  actSelect.Caption   := '';
  actUnSelect.Caption := '';
  fOrderDate.Text     := '';
  edtUpdDate.Text     := '';

  FilterStatusCreate;
  FilterPriceLogoCreate();
  FilterClientsCreate();

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

  {$IFDEF Release}
    Grid.Columns.ColumnFromFieldName('Flag').Visible := False;
  {$ENDIF}

  // восстановление настроек грида для пользователя
  GridLayout(Self, Grid, tGridLayout.glLoad, False);

  // объект для упраления метками
  Marks := tMarks.Create(Grid);
  Marks.Clear;

  GetMarksInfo;

  FSql:= tSQL.Create(UniMainModule.FDConnection);

  FAccrual := TAccrual.Create(UniMainModule.FDConnection);

  logger.Info('TOrdersT.UniFrameCreate End');
end;


procedure TOrdersT.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
  FAccrual.Free;
end;

procedure TOrdersT.UniFrameReady(Sender: TObject);
begin
  {$IFDEF Debug}
     fOrderDate.DateTime := date();
    // fDetailNum.Text := '32008XJ';
  {$ENDIF}
end;

procedure TOrdersT.TimerProcessedShowTimer(Sender: TObject);
begin
  logger.Info('TOrdersT.TimerProcessedShowTimer begin');
  try
    logger.Info('TOrdersT.TimerProcessedShowTimer ShowProgress: ' + FAccrual.ShowProgress.ToString());
    if FAccrual.ShowProgress then
    begin
      logger.Info('TOrdersT.TimerProcessedShowTimer ShowProgress');

      FSql.Open('''
          select top 1 Processed, Total
            from #ProcessedRecords (nolock)
        ''', [], []);

      if FSql.q.RecordCount > 0 then
      begin
        HideMask();
        try
          FProcessed:= FSql.Q.FieldByName('Processed').AsInteger;
          FTotal    := FSql.Q.FieldByName('Total').AsInteger;
        finally
          DoShowMask(Format('Обработано деталей %d из %d', [FProcessed, FTotal]));
        end;
      end;

    end;

  finally
    logger.Info('TOrdersT.TimerProcessedShowTimer Finished: ' + FAccrual.Finished.ToString());
    if FAccrual.Finished then
    begin

      // ОБРАБОТКА ОШИБОК
      // проверка наличия серверных ошибок
      Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
      var ServerErr:integer;
      ServerErr := Sql.Q.RecordCount;

      if (ServerErr <> 0) then
      begin
        Error_T.ShowModal;
      end
      else
      begin
        ToastOK('Операция успешно выполнена!', unisession);
        GridOpen();
      end;

      DoHideMask();
      TimerProcessedShow.Enabled := False;
    end;
  end;
end;

procedure TOrdersT.OrdersFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
    if OrderF.FormAction = acUpdate then
    begin
      Query.Edit ;
      Query.Post;
    end;
  except
    on E: Exception do
      logger.Info('TOrdersT.UserFCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.OrdersMessageFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
    if OrdersMessageF.FormAction = acUpdate then
    begin
      Query.Edit ;
      Query.Post;

      ToastOK('Комментарий успешно сохранен!', unisession);
    end;
  except
    on E: Exception do
      logger.Info('TOrdersT.OrdersMessageFCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
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

  if (KEY = 117) then   // F6
  begin
    if (Sender is Tunidbgrid) then
    begin
      actProtocolExecute(Sender);
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
          for Key in FMarks.Keys  do
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
    Sql.Exec('Delete tMarks from tMarks (rowlock) where Spid=@@Spid and Type=3', [], [])
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
