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
  uniButton, uniBitBtn, uniLabel, uniDBComboBox,
  uniGroupBox, uniDBLookupComboBox, Vcl.StdActns, Vcl.StdCtrls, Vcl.Clipbrd,
  uAccrualUtils, uniSweetAlert, unimSelect, unimDBSelect, uniSegmentedButton,

  System.Generics.Collections, System.MaskUtils, uniFileUpload,
  uniDateTimePicker, uniScreenMask, uniTimer, uniThreadTimer,
  uGrant, uCommonType, uSqlUtils,
  UniFSCombobox, uniHTMLFrame, uUniExDateRangePicker, uUniADCheckComboBoxEx,
  uOrdersNewDeliveryDateF, uPartProtocol_T, uAllowCreateOrderF, uUserF;

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
    lblStatys: TUniLabel;
    lblPrice: TUniLabel;
    lblClient: TUniLabel;
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
    lblOrderNumber: TUniLabel;
    ppExecuteAction: TUniMenuItem;
    actExecuteAction: TAction;
    actExecuteActionEnabled: TAction;
    QueryStatusID: TFMTBCDField;
    actExecuteActionRollback: TAction;
    N3: TUniMenuItem;
    QueryFlag: TIntegerField;
    QueryOverPricing: TCurrencyField;
    QueryWarning: TWideStringField;
    lblIsCancel: TUniLabel;
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
    qPriceLogoPriceLogo: TWideStringField;
    N12: TUniMenuItem;
    N4: TUniMenuItem;
    pnlGridSelectedCount: TUniPanel;
    lblDEtailNumber: TUniLabel;
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
    lblOrderDate: TUniLabel;
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
    lblUpdDate: TUniLabel;
    edtInvoice: TUniEdit;
    lblInvoce: TUniLabel;
    actGroupSetFragileSign: TAction;
    Fragile1: TUniMenuItem;
    QueryDeliveryNextDate2: TSQLTimeStampField;
    QueryDateDeparture: TSQLTimeStampField;
    QueryDaysInWork: TIntegerField;
    fDetailNum: TUniEdit;
    QueryStatus: TIntegerField;
    actCancellation: TAction;
    N8: TUniMenuItem;
    QueryFragile: TBooleanField;
    TimerProcessedShow: TUniTimer;
    ppExecute: TUniPopupMenu;
    QueryOrderUniqueCount: TIntegerField;
    QueryReplacementPrice: TCurrencyField;
    QueryPercentSupped: TIntegerField;
    actRequestClosed: TAction;
    N9: TUniMenuItem;
    QueryDeliveryTermSupplier: TIntegerField;
    QueryDeliveryDaysReserve2: TIntegerField;
    QueryReceiptDate: TSQLTimeStampField;
    QueryOrderDetailSubId: TWideStringField;
    edtOrderDate: TUniDateRangePicker;
    fClient: TUniADCheckComboBox;
    fPriceLogo: TUniADCheckComboBox;
    QueryDeliveryPlanDateSupplier2: TSQLTimeStampField;
    QueryDeliveryTermSupplier2: TIntegerField;
    QueryDeliveryDateToCustomer2: TSQLTimeStampField;
    QueryDeliveryTermToCustomer2: TIntegerField;
    btnNotification: TUniBitBtn;
    actRequestOpen: TAction;
    N10: TUniMenuItem;
    actPartProtocol: TAction;
    actPartProtocol1: TUniMenuItem;
    actSupplierSpecifyDeliveryTime: TAction;
    N13: TUniMenuItem;
    QueryDeliveryTermFromSupplier: TIntegerField;
    QueryDeliveryTermFromSupplier2: TIntegerField;
    QueryNoAir: TBooleanField;
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
    procedure QueryPricePurchaseGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actRequestClosedExecute(Sender: TObject);
    procedure DeliveryDaysReserveGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDateDeliveryToCustomerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryPlanDateSupplierGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryTermSupplierGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryTermDeliveryToCustomerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnNotificationClick(Sender: TObject);
    procedure actRequestOpenExecute(Sender: TObject);
    procedure actPartProtocolExecute(Sender: TObject);
    procedure actSupplierSpecifyDeliveryTimeExecute(Sender: TObject);
    procedure QueryDeliveryTermFromSupplierGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    FAction: tFormaction;
    FFilterTextStatus: string;

    Marks: TMarks;                  // отметки
    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    FSql: tSQL;
    FAccrual: TAccrual;

    FProcessed: Integer;
    FTotal    : Integer;

    FIsNotification: Boolean;

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
    /// <summary>OrderSetRequestClosed - установка признака: Обращение закрыто</summary>
    procedure OrderSetRequestClosed();
    /// <summary>OrderSetRequestOpen - установка признака: Обращение открыто</summary>
    procedure OrderSetRequestOpen();

    /// <summary>SupplierSpecifyDeliveryTime - уточнить срок поставки у поставщика</summary>
    procedure SupplierSpecifyDeliveryTime();

    /// <summary>
    /// GetNotificationOrders - показать заказы с уведомлениями
    /// </summary>
    procedure GetNotificationOrders();

    procedure SetNotificationIcon();

    /// <summary>
    /// SetNotificationCount - количество уведомлений
    /// </summary>
    procedure SetNotificationCount();

    procedure SetMenuVisible(AVisible: boolean);overload;

    procedure SetMenuVisible(); overload;

    procedure MessageCallBack(Sender: TComponent; AResult: Integer);

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
  MainModule, uGrantUtils, uEmexUtils, uUtils.Logger, uError_T, uMainVar,
  uOrdersProtocol_T, Main, uOrdersF, ServerModule, uToast,uGroupDetailNameEditF,
  uGroupSetFragileSignF, uUtils.Grid, uUtils.Varriant, uStatusForm, uUtils.Date,
  uConstant, uMessengerMessage, uMessengerF, uSpplitForm;

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
  log('TOrdersT.OrderSetCancellation Begin', etDebug) ;

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
  log('TOrdersT.OrderSetCancellation End', etDebug) ;
end;

procedure TOrdersT.OrderSetRequestClosed;
begin
  log('TOrdersT.OrderSetRequestClosed Begin', etDebug);

  Sql.Exec(' exec OrderSetRequestClosed  ', [], []);

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
  log('TOrdersT.OrderSetRequestClosed End', etDebug);
end;

procedure TOrdersT.OrderSetRequestOpen;
begin
  log('TOrdersT.OrderSetRequestOpen Begin', etDebug) ;

  Sql.Exec(' exec OrderSetRequestOpen ', [], []);

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
  log('TOrdersT.OrderSetRequestOpen End', etDebug) ;
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
  log('TOrdersT.actEditExecute Begin', etDebug) ;
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
  log('TOrdersT.actEditExecute End', etDebug) ;
end;

procedure TOrdersT.actExecuteActionExecute(Sender: TObject);
var ActionID: Integer;
    Brief, FName: string;

    RecNo: integer;
begin
  log('TOrdersT.actExecuteActionExecute Begin', etDebug) ;
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
    log('TOrdersT.actExecuteActionExecute end', etDebug) ;
end;

procedure TOrdersT.ActionExecute(ActionID: Integer);
var Action: string;
    DateValue: TDateTime;
begin
  log('TOrdersT.ActionExecute Begin', etDebug);

  Sql.Open('''
    delete from #ActionParams;

    insert #ActionParams (ActionID)
    select :NodeID

    -- таблица для возврата количества обработанных записей
    delete from #ProcessedRecords;

    select Brief
      from tNodes with (nolock index=ao1)
     where NodeID = :NodeID;
  ''', ['NodeID'], [ActionID]);

  Action := Sql.F('Brief').AsString;

  if Action = 'SetNewDeliveryDate' then
  begin
    log('TOrdersT.ActionExecute 1 SetNewDeliveryDate', etDebug);

    OrdersNewDeliveryDateF.FormAction := acUpdate;
    OrdersNewDeliveryDateF.ID := ActionID;
    OrdersNewDeliveryDateF.ShowModal;

    if OrdersNewDeliveryDateF.ModalResult <> mrOk then Exit;
  end;

  if Action = 'ToInWork' then //ToInWork	Создать заказ
  begin
    log('TOrdersT.ActionExecute 2 ToInWork', etDebug);
    if sql.GetSetting('AllowCreateOrder', false) = True then
    begin
      AllowCreateOrderF.ShowModal;

      if AllowCreateOrderF.ModalResult <> mrOk then Exit;
    end;
  end;

  if Action = 'ToReturnPartial' then //ToReturnPartial Частичный возврат
  begin
    log('TOrdersT.ActionExecute 3 ToReturnPartial', etDebug);

    if Grid.SelectedRows.Count > 1 then
    begin
      MessageDlg('Необходимо выделить только одну запись!' , mtWarning, [mbOK]);
      Exit;
    end;

    SpplitForm.ID := QueryOrderID.AsInteger;
    SpplitForm.FormAction := TFormAction.acUpdate;
    SpplitForm.Caption    := 'Укажите количество для возврата';
    SpplitForm.lblDetailNameF.Caption := 'Укажите количество для возврата:';

    if SpplitForm.ShowModal() = mrOk then
    begin
      Sql.Exec('''
        exec OrdersToReturnPartial
              @OrderID  = :OrderID
             ,@Quantity = :Quantity
      ''',
      ['OrderID', 'Quantity'],
      [QueryOrderID.AsInteger, SpplitForm.Quantity]);
    end
    else
    begin
      Exit
    end;
  end;

  DoShowMask;

  FAccrual.ShowProgress := False;
  FAccrual.Finished := False;

  FProcessed:= 0;
  FTotal    := 0;

  if ActionID = 14	{ToBasket	Добавить в корзину} then
  begin
    log('TOrdersT.ActionExecute 4', etDebug);
    Sql.exec(' insert #ProcessedRecords with (rowlock) (Processed, Total) select 0, 0 ', [], []);
    FAccrual.ShowProgress := True;
  end;

  TimerProcessedShow.Enabled:=True;

  RetVal.Clear;
  RetVal.Code := FAccrual.ActionExecute(ActionID);

  if (RetVal.Code > 0)then
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

  log('TOrdersT.ActionExecute End', etDebug);
end;

procedure TOrdersT.actExecuteActionRollbackExecute(Sender: TObject);
var Accrual: TAccrual;
begin
  log('TOrdersT.actExecuteActionRollbackExecute Begin', etDebug);
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
  log('TOrdersT.actExecuteActionRollbackExecute Begin', etDebug);
end;

procedure TOrdersT.actFilterClearExecute(Sender: TObject);
begin
  log('TOrdersT.actFilterClearExecute Begin', etDebug);
  DoShowMask;

  fStatus2.ClearSelection;
  fPriceLogo.ClearSelection;
  fClient.ClearSelection;

  FFilterTextStatus := '';
  fOrderNum.Text := '';
  fDetailNum.Text:='';

  edtOrderDate.ClearDateRange;

  edtUpdDate.Text := '';
  edtInvoice.Text := '';

  DoHideMask;
  log('TOrdersT.actFilterClearExecute End', etInfo);
end;

procedure TOrdersT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TOrdersT.actGridSettingDefaultExecute(Sender: TObject);
begin
  log('TOrdersT.actGridSettingDefaultExecute Begin', etDebug);
  Sql.Exec('''
      delete tGridOptions
        from tGridOptions (rowlock)
       where UserID = dbo.GetUserID()
         and Grid   = :Grid
  ''',
  ['Grid'],
  [self.ClassName +'.' + Grid.Name]);
  GridLayout(Self, Grid, tGridLayout.glLoad);
  log('TOrdersT.actGridSettingDefaultExecute Begin', etDebug);
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
  log('TOrdersT.ActionExecuteEnabled Begin', etDebug);
  //добавляем метки в таблицу
  try
    Sql.Q.Close;
    Sql.Open('Select distinct StatusID, IsStartState from vMarkOrderState where spid = :Spid and Type = 3', ['Spid'], [SPID]);

    // контроль доступности меню действий, если 2 разных состояния, то меню не доступно
    actExecuteActionEnabled.Enabled := (actExecuteActionEnabled.Tag = 1) and (marks.Count > 0) and (Sql.Q.RecordCount = 1);

    actExecuteActionRollback.Enabled  := (actExecuteActionRollback.Tag = 1) and  (marks.Count > 0)
      and (Sql.Q.RecordCount = 1)
      and (Sql.Q.FieldByName('IsStartState').AsInteger <> Integer(tInstrumentFlag.isStartState));

    StateActionMenuCreate;

  finally
    log('TOrdersT.ActionExecuteEnabled End', etDebug);
  end;
end;

procedure TOrdersT.actPartProtocolExecute(Sender: TObject);
begin
  PartProtocol_T.ID:= Integer(QueryOrderID.Value);
  PartProtocol_T.ShowModal;
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

procedure TOrdersT.actRequestClosedExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите проставить признак "Обращение закрыто"? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : OrderSetRequestClosed;
        mrNo  : Exit;
      end;
    end
  );
end;

procedure TOrdersT.actRequestOpenExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите проставить признак "Обращение открыто"? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : OrderSetRequestOpen;
        mrNo  : Exit;
      end;
    end
  );
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

  if (s<> '') and  (s[length(s)]=',') then delete(s,length(s),1);

  FFilterTextStatus := s;

  log('FFilterTextStatus: ' + FFilterTextStatus, etInfo);
end;

procedure TOrdersT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TOrdersT.GridOpen;
var FStatus :string;
    FilterIsCancel: Integer;
begin
  log('TOrdersT.GridOpen Begin', etDebug);
  DoShowMask;
  try
    Query.Close();

    if FIsNotification then
    begin
        Query.MacroByName('Form').Value :=
        '''
           vOrderNotificationFilter onf
         inner join [vOrders] o
                 on o.OrderID = onf.OrderID
        ''';
    end
    else
    begin
        Query.MacroByName('Form').Value :=
        '''
           [vOrders] o
        ''';
    end;

    if FFilterTextStatus <> '' then
      FStatus := ' and StatusID in (' + FFilterTextStatus + ')'
    else
      FStatus := '';

    if fClient.SelCount > 0 then
      Query.MacroByName('Client').Value  := ' and ClientID in (' + fClient.SelectedKeys + ')'
    else
      Query.MacroByName('Client').Value  := '';

    if fPriceLogo.SelCount > 0 then
      Query.MacroByName('PriceLogo').Value := ' and PriceLogo in (' + fPriceLogo.SelectedNames(True) + ')'
    else
      Query.MacroByName('PriceLogo').Value := '';

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
    //Query.MacroByName('PriceLogo').Value := FPriceLogo;
    //Query.MacroByName('Client').Value    := FClient;

    if fOrderNum.Text <> '' then
      Query.MacroByName('OrderNum').Value := ' and o.OrderNum like '''   + fOrderNum.Text + ''''
    else
      Query.MacroByName('OrderNum').Value := '';

    if fDetailNum.Text <> '' then
      if string(fDetailNum.Text)[1] = '!' then
      begin
        Query.MacroByName('DetailNum').Value := ' and o.OrderDetailSubId = :DetailNum';
        Query.ParamByName('DetailNum').AsString := Trim(fDetailNum.Text);
      end
      else
      begin
        Query.MacroByName('DetailNum').Value := ' and (o.DetailNumber like '''   + Trim(fDetailNum.Text) + '%''' +
                                                '   or o.ReplacementDetailNumber like '''   + Trim(fDetailNum.Text) + '%'')'
      end
    else
      Query.MacroByName('DetailNum').Value := '';

    if cbCancel.ItemIndex in [0, 1] then
      Query.MacroByName('isCancel').Value := ' and o.isCancel = ' + cbCancel.ItemIndex.ToString
    else
      Query.MacroByName('isCancel').Value := '';

    Query.MacroByName('Flags').Value := '';

    if cbCancel.ItemIndex in [2] then // Запрошен отказ
    begin

      FilterIsCancel := sql.GetSetting('ShowOrdersWithFilterIsCancel', 0);

      if FilterIsCancel = 0 then
        Query.MacroByName('Flags').Value := ' and (o.Flag & 64 > 0 or o.Flag & 128 > 0)'
      else
      if FilterIsCancel = 1 then
        Query.MacroByName('Flags').Value := ' and o.Flag & 128 > 0'
      else
      if FilterIsCancel = 2 then
        Query.MacroByName('Flags').Value := ' and o.Flag & 64 > 0';
    end;

    if (edtOrderDate.DateStart <> NullDate) and (edtOrderDate.DateEnd <> NullDate) then
      Query.MacroByName('OrderDate').Value := ' and o.OrderDate between ''' + FormatDateTime('yyyymmdd', edtOrderDate.DateStart) + ''' and ''' + FormatDateTime('yyyymmdd', edtOrderDate.DateEnd) + ''''
    else
      Query.MacroByName('OrderDate').Value := '';

    if (edtUpdDate.Text <> '') and (edtUpdDate.Text <> '30.12.1899') then
      Query.MacroByName('updDateTime').Value := ' and cast(o.updDateTime as date) = ''' + FormatDateTime('yyyymmdd', edtUpdDate.DateTime) + ''''
    else
      Query.MacroByName('updDateTime').Value := '';

    if edtInvoice.Text <> '' then
      Query.MacroByName('Invoice').Value := ' and o.Invoice like ''' + edtInvoice.Text + ''''
    else
      Query.MacroByName('Invoice').Value := '';

    Query.Open();

    StateActionMenuCreate;

    SetNotificationCount;

  finally
    DoHideMask();
    //UniSession.Synchronize;
    log('TOrdersT.GridOpen End', etDebug);
  end;
end;

procedure TOrdersT.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;

  GetMarksInfo;

  ActionExecuteEnabled;
end;

procedure TOrdersT.GroupDetailNameEditCallBack(Sender: TComponent;
  AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  try
    if GroupDetailNameEditF.FormAction = acUpdate then
    begin
      Marks.DataRefresh;

      ToastOK('Изменения успешно внесены!', unisession);
    end;
  except
    on E: Exception do
      log('TOrdersT.GroupDetailNameEditCallBack Ошибка: ' + e.Message, etException);
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
      log('TOrdersT.GroupSetFragileSignCallBack Ошибка: ' + e.Message, etException);
  end;
end;

procedure TOrdersT.MessageCallBack(Sender: TComponent;   AResult: Integer);
begin
  try
     Query.RefreshRecord(False) ;
     Grid.RefreshCurrentRow();
  except
    on E: Exception do
      log('TOrdersT.MessageCallBack Ошибка: ' + e.Message, etException);
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

procedure TOrdersT.GetNotificationOrders;
begin
 // btnCancel.Enabled := FIsNotification;
  //cbCancel.Enabled := FIsNotification;

  FIsNotification := not FIsNotification;

  if FIsNotification then
    GridOpen;

  SetMenuVisible(FIsNotification);
end;

procedure TOrdersT.ppMainPopup(Sender: TObject);
begin
  actProtocol.Enabled := (actProtocol.Tag=1) and (Query.RecordCount>0);

  actGroupDetailNameEdit.Enabled := (actGroupDetailNameEdit.Tag=1) and (Marks.Count>0);
  actGroupSetFragileSign.Enabled := (actGroupSetFragileSign.Tag=1) and (Marks.Count>0);

  actExecuteActionEnabled.Enabled  := (actExecuteActionEnabled.Tag = 1) and (Marks.Count > 0);
  actExecuteActionRollback.Enabled := (actExecuteActionRollback.Tag= 1) and (Marks.Count > 0);

  actCancellation.Enabled := (actCancellation.Tag = 1) and (Marks.Count > 0);
  actRequestOpen.Enabled  := (actRequestOpen.Tag = 1) and  (marks.Count > 0);
  actRequestClosed.Enabled:= (actRequestClosed.Tag = 1) and(marks.Count > 0);

  actSupplierSpecifyDeliveryTime.Enabled:= (actSupplierSpecifyDeliveryTime.Tag = 1) and(marks.Count = 1);
end;

procedure TOrdersT.QueryDateDeliveryToCustomerGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryDateToCustomer2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-date-delivery-to-customer-arrow">&#10149;'+
            '</span><span class="x-date-delivery-to-customer">' + QueryDeliveryDateToCustomer2.AsString + '</span>'; //
  end
  else
  if (not QueryReceiptDate.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-date-delivery-to-customer-arrow">&#10149;'+
            '</span><span class="x-date-delivery-to-customer">' + QueryReceiptDate.AsString + '</span>';
  end
  else
    Text := Sender.AsString; // Дата поставки клиенту
end;

procedure TOrdersT.QueryDeliveryPlanDateSupplierGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryPlanDateSupplier2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryPlanDateSupplier2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryDeliveryTermFromSupplierGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryTermFromSupplier2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryTermFromSupplier2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryDeliveryTermSupplierGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryTermSupplier2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryTermSupplier2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementDetailNumber.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span><span class="x-replacement-detail-number">' + QueryReplacementDetailNumber.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryMakeLogoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementMakeLogo.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-make-logo-arrow">&#10149;</span><span class="x-replacement-make-logo">' + QueryReplacementMakeLogo.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementManufacturer.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-manufacturer-arrow">&#10149;</span><span class="x-replacement-manufacturer">' + QueryReplacementManufacturer.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryNextDateDepartureGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin // Ближайшая дата вылета
  if (not QueryDeliveryNextDate2.IsNull) then
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
    Text := '<span>' +FormatFloat('###,##0.00 $', Sender.Value) +  '</span><br><span class="x-replacement-price">&#10149;'+
            '</span><span class="x-replacement-price">' + FormatFloat('###,##0.00 $', QueryReplacementPrice.Value) + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.QueryStatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var t: string;
begin
  t := '';
  //Сообщение от менеджера клиенту
  if (Sender.AsInteger and 32) > 0 then
  begin
    t := t + '<span class="grid-order-message" data-qtip="Отправлено сообщение клиенту"><i class="fa fa-exclamation-triangle"></i></span> ';
  end;
  //Сообщение от клиента
  if (Sender.AsInteger and 2048) > 0 then
  begin
    t := t + '<span class="grid-order-message" data-qtip="Имеется непрочитанное сообщение от клиента"><i class="fa fa-bell"></i></span> ';
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
  if (Sender.AsInteger and 1024) > 0 then
  begin
    t := t + '<span class="grid-order-request-close" data-qtip="Обращение закрыто"><i class="fa fa-check"></i></span> ';
  end;
  if (Sender.AsInteger and 131072) > 0 then
  begin
    t := t + '<span class="grid-order-request-open" data-qtip="Обращение открыто"><i class="fa fa-exclamation"></i></span> ';
  end;
  if (Sender.AsInteger and 2097152) > 0 then //2097152 - ТОЛЬКО ЭТОТ БРЕНД. Без замен
  begin
    t := t + '<span class="grid-order-only-this-brand" data-qtip="Без замен"><i class="fa fa-minus-square"></i></span> ';
  end;
  if Query.FieldByName('Fragile').AsBoolean then
  begin
    t := t + '<span class="grid-order-fragile" data-qtip="Fragile - Хрупкий товар"><i class="fa fa-fragile"></i></span> ';
  end;
  if ((Sender.AsInteger and 4194304) > 0) or (Query.FieldByName('NoAir').AsBoolean) then
  begin
    t := t + '<span class="grid-order-no-air" data-qtip="NoAir - Запрещено к авиаперевозке"><i class="fa fa-plane"></i></span> ';
  end;
  Text := t;
end;

procedure TOrdersT.QueryTermDeliveryToCustomerGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryTermToCustomer2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryTermToCustomer2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  log(EventName, etInfo);
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
  end
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
  if (assigned(ACurrColumn)) and  (ACurrColumn.FieldName = 'DetailNumber') then
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
  if (Query.FieldByName('Flag').AsInteger and 1) > 0 then // Превышение цены
  begin
    Attribs.Color:= rgb(255, 207, 217);
  end
  else
  if (Query.FieldByName('Flag').AsInteger and 2) > 0 then // Нет цены
  begin
    Attribs.Color:=rgb(242, 169, 210);
  end
  else
  if (Query.FieldByName('Flag').AsInteger and 16384) > 0 then // Несоответствие упаковке
  begin
    Attribs.Color:=rgb(242,169,210);
  end
  else
  if (Query.FieldByName('Flag').AsInteger and 32768) > 0 then // Нет в наличии
  begin
    Attribs.Color:=rgb(255,255,0);
  end
  else
  if (Query.FieldByName('Flag').AsInteger and 262144) > 0 then // Измените метод отправки
  begin
    Attribs.Color:=rgb(200,94,108) ;
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
          log('TOrdersT.GridLayout Ошибка: ' + e.Message, etException);
          log('TOrdersT.GridLayout Column: ' + Sql.Q.FieldByName('Column').AsString, etException);
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

procedure TOrdersT.SetMenuVisible;
begin
  SetMenuVisible(FIsNotification);
end;

procedure TOrdersT.SetMenuVisible(AVisible: boolean);
begin
  if AVisible then
  begin
    UniSession.AddJS(
      'var el = document.querySelector(".order.fa.fa-bell");' +
      'if (el) { el.classList.add("icon-notification"); }' +
      'else { console.error("Element with class fa fa-bell not found"); }'
    );
  end
  else
  begin
    UniSession.AddJS(
      'var el = document.querySelector(".order.fa.fa-bell");' +
      'if (el) { el.classList.remove("icon-notification"); }' +
      'else { console.error("Element with class fa fa-bell not found"); }'
    );
  end;

  SetNotificationCount;
end;

procedure TOrdersT.SetNotificationCount;
var
  bJSName: string;
begin
  Sql.Open('exec GetOrderNotificationCount', [], []);

  if Sql.Count > 0 then
  begin
     bJSName := btnNotification.JSName;
     UniSession.AddJS(bJSName + '.setBadgeText(' + Sql.Q.FieldByName('NotificationCount').AsString +  ');');
  end;
end;

procedure TOrdersT.SetNotificationIcon;
begin
  //
end;

procedure TOrdersT.DeliveryDaysReserveGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (not QueryDeliveryDaysReserve2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryDaysReserve2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
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
  log('TOrdersT.StateActionMenuCreate Begin', etDebug);
  ppExecute.Items.Clear;
  ppExecuteAction.Clear;

  Sql.Open(' exec GetMarkOrderStateAction ', [], []);

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
  log('TOrdersT.StateActionMenuCreate End', etDebug);
end;

procedure TOrdersT.SupplierSpecifyDeliveryTime;
begin
  log('SupplierSpecifyDeliveryTime Begin', etDebug) ;

  Sql.Exec(' exec SupplierSpecifyDeliveryTime ', [], []);

  // ОБРАБОТКА ОШИБОК
  // проверка наличия серверных ошибок
  Sql.Open('''
    select 1
      from pAccrualAction with (nolock index=ao2)
     where Spid = @@spid
       and Retval <> 0
  ''', [], []);

  var ServerErr:integer;
  ServerErr := Sql.Q.RecordCount;

  if (ServerErr = 0) then
  begin
    Marks.DataRefresh;
    ToastOK ('Операция успешно выполнена!', UniSession);
  end
  else
  begin
    Error_T.ShowModal;
  end;
  log('SupplierSpecifyDeliveryTime End', etDebug) ;
end;

procedure TOrdersT.actSelectExecute(Sender: TObject);
begin
  SelectAll;
end;

procedure TOrdersT.actSetCommentExecute(Sender: TObject);
begin
   MessageF.OrderID := QueryOrderID.AsInteger;
   MessageF.ShowModal(MessageCallBack);
end;

procedure TOrdersT.actSupplierSpecifyDeliveryTimeExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите создать запрос на уточнение срока поставки"? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : SupplierSpecifyDeliveryTime;
        mrNo  : Exit;
      end;
    end
  );
end;

procedure TOrdersT.actUnselectExecute(Sender: TObject);
begin
  DeselectAll;
end;

procedure TOrdersT.btnNotificationClick(Sender: TObject);
begin
  GetNotificationOrders;
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
  log('TOrdersT.UniFrameCreate Begin', etDebug);

  {$IFDEF Debug}
    Grant.GrantTemplateCreate(self);
  {$ENDIF}

  Grant.SetGrant(self, actMain);

  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

  actSelect.Caption   := '';
  actUnSelect.Caption := '';
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


//  Grid.JSInterface.JSConfig('bufferedRenderer', [False]);
  log('TOrdersT.UniFrameCreate End', etDebug);
end;

procedure TOrdersT.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
  FAccrual.Free;
end;

procedure TOrdersT.UniFrameReady(Sender: TObject);
begin
  log('TOrdersT.UniFrameReady Begin', etDebug);
  {$IFDEF Debug}
    // fOrderDate.DateTime := date();
    // fClient.Text := 'egud@mail.ru';
    // fDetailNum.Text := '32008XJ';
  {$ENDIF}

  SetNotificationCount;
  log('TOrdersT.UniFrameReady End', etDebug);
end;

procedure TOrdersT.TimerProcessedShowTimer(Sender: TObject);
begin
  log('TOrdersT.TimerProcessedShowTimer Begin', etDebug);
  try

    if FAccrual.ShowProgress then
    begin
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
    if FAccrual.Finished then
    begin
      // ОБРАБОТКА ОШИБОК
      // проверка наличия серверных ошибок
      Sql.Open('select 1 from pAccrualAction (nolock) where Spid = @@spid and Retval <> 0', [], []);
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

    log('TOrdersT.TimerProcessedShowTimer End', etDebug);
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
      log('TOrdersT.OrdersFCallBack Ошибка: ' + e.Message, etException);
  end;
end;

procedure TOrdersT.OrdersMessageFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
//    if OrdersMessageF.FormAction = acUpdate then
//    begin
//      Query.Edit ;
//      Query.Post;
//
//      ToastOK('Комментарий успешно сохранен!', unisession);
//    end;
  except
    on E: Exception do
      log('TOrdersT.OrdersMessageFCallBack Ошибка: ' + e.Message, etException);
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

  if (CHAR(KEY)='M') AND (SHIFT=[SSCTRL]) then
  begin
    actSetCommentExecute(Sender);
  end;
end;

{ tMarks }
constructor tMarks.Create(AGrid: TUniDBGrid);
begin
  log('tMarks.Create Begin', etDebug);
  if Assigned(AGrid) then
  begin
    FConnection := TFDConnection(TFDQuery(AGrid.DataSource.DataSet).Connection);
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
    FGrid := AGrid;
  end;
  FMarks := TDictionary <integer, integer>.Create();
  log('tMarks.Create End', etDebug);
end;

procedure tMarks.DataRefresh;
var Key: Integer;
    BM : TBookmark;
begin
  log('tMarks.DataRefresh Begin', etDebug);
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
  log('tMarks.DataRefresh End', etDebug);
end;

procedure tMarks.DeleteInDB();
begin
  Sql.Exec('exec MarksDelete @Type = 3 ', [], [])
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
  log('tMarks.Select Begin', etDebug);

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
          SqlText:= SqlText + ' Insert into tMarks with (rowlock) (Spid, Type, ID) select @@Spid, 3, '
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
  log('tMarks.Select End', etDebug);
end;

initialization
  RegisterClass(TOrdersT);

end.
