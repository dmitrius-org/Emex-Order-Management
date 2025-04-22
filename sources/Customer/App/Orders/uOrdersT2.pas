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
  System.Generics.Collections, System.MaskUtils, uniDateTimePicker,
  uUniDateRangePicker, uConstant, uToast, uReOrderF, uUtils.Mark,
  uUniADCheckComboBoxEx, uUniADCheckComboBoxHelper, uniSpinEdit;


type

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
    QueryDeliveryNextDate: TSQLTimeStampField;
    QueryDeliveryDateToCustomer: TSQLTimeStampField;
    QueryDeliveryTermToCustomer: TIntegerField;
    pFilter: TUniPanel;
    gbFilter: TUniGroupBox;
    UniLabel1: TUniLabel;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    QueryStatusName: TWideStringField;
    QueryStatusID: TFMTBCDField;
    QueryFlag: TIntegerField;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    QueryReplacementDetailNumber: TWideStringField;
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
    pnlGridInfo: TUniPanel;
    UniLabel6: TUniLabel;
    fDetailNum: TUniEdit;
    pnlPageL: TUniPanel;
    pnlPageR: TUniPanel;
    QueryComment: TWideStringField;
    QueryDeliveryRestToCustomer: TIntegerField;
    QueryDeliveryRestTermSupplier: TIntegerField;
    QueryOrderNum: TWideStringField;
    actShowMessage: TAction;
    UniLabel8: TUniLabel;
    UniPanel: TUniPanel;
    btnCancel: TUniBitBtn;
    QueryDestinationName: TWideStringField;
    QueryDeliveryTermSupplier: TIntegerField;
    QueryDeliveryNextDate2: TSQLTimeStampField;
    QueryDeliveryDaysReserve2: TIntegerField;
    QueryReceiptDate: TSQLTimeStampField;
    QueryOrderDetailSubId: TWideStringField;
    QueryUnreadMessagesCount: TIntegerField;
    QueryComment2: TStringField;
    edtComment2: TUniEdit;
    UniLabel2: TUniLabel;
    fOrderDate: TUniDateRangePicker;
    btnNotification: TUniBitBtn;
    ppMain: TUniPopupMenu;
    actCancelСonfirm: TAction;
    N1: TUniMenuItem;
    actReOrder: TAction;
    N2: TUniMenuItem;
    QueryisCancel: TBooleanField;
    QueryDeliveryPlanDateSupplier2: TSQLTimeStampField;
    QueryDeliveryTermSupplier2: TIntegerField;
    QueryDeliveryDateToCustomer2: TSQLTimeStampField;
    QueryDeliveryTermToCustomer2: TIntegerField;
    QueryAllMessageCount: TIntegerField;
    fStatus2: TUniADCheckComboBox;
    btnLast: TUniButton;
    btnNext: TUniButton;
    btnPrevious: TUniButton;
    btnFirst: TUniButton;
    UniLabel3: TUniLabel;
    lblAllCount: TUniLabel;
    pnlPage: TUniPanel;
    UniContainerPanel1: TUniContainerPanel;
    UniContainerPanel2: TUniContainerPanel;
    edtPage: TUniSpinEdit;
    pnlInfo: TUniContainerPanel;
    lblRow: TUniLabel;
    pnlNavigation: TUniContainerPanel;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure GridSelectionChange(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellClick(Column: TUniDBGridColumn);
    procedure QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actProtocolExecute(Sender: TObject);
    procedure ppMainPopup(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actFilterClearExecute(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure cbCancelSelect(Sender: TObject);
    procedure actShowMessageExecute(Sender: TObject);
    procedure actCancelRequestExecute(Sender: TObject);
    procedure QueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryNextDateGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex, NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure QueryDeliveryDateToCustomerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure GridColumnActionClick(Column: TUniDBGridColumn; ButtonId: Integer);
    procedure btnNotificationClick(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure actCancelСonfirmExecute(Sender: TObject);
    procedure actReOrderExecute(Sender: TObject);
    procedure QueryDeliveryPlanDateSupplierGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryTermSupplierGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryUnreadMessagesCountGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryTermToCustomerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure edtPageKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FAction: tFormaction;

    FFilterTextStatus: string;
    FIsNotification: Boolean;

    FAllPage: Integer;

    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);

    procedure CancelRequest();

    /// <summary>
    /// StateActionMenuCreate - Формирование списка меню/действий для состояния
    /// </summary>
    procedure StateActionMenuCreate();

    procedure DoShowMask();
    procedure DoHideMask();

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    /// <summary>
    /// GetNotificationOrders - показать заказы с уведомлениями
    /// </summary>
    procedure GetNotificationOrders();

    procedure SetNotificationIcon();

    /// <summary>
    /// SetNotificationCount - количество уведомлений
    /// </summary>
    procedure SetNotificationCount();

    /// <summary>
    /// CancelConfirm -подтверждение отказа от заказа
    /// </summary>
    procedure CancelConfirm();

    /// <summary>
    ///  ReOrderCallBack - CallBack постобработчик действия на форме редактирования данных
    ///</summary>
    procedure ReOrderCallBack(Sender: TComponent; AResult:Integer);

    /// <summary>
    ///  ReOrderCallBack - CallBack постобработчик добавления/просмотра сообщений
    ///</summary>
    procedure MessageCallBack(Sender: TComponent; AResult: Integer);

    procedure OrdersBtnCancelEnabled;


  public
    { Public declarations }

    /// <summary>
    /// GridRefresh - загрузка данных из БД
    /// </summary>
    procedure GridRefresh;

    procedure Page();
    procedure PageNavigation();

    procedure SetMenuVisible(AVisible: boolean);overload;

    procedure SetMenuVisible(); overload;
  end;

implementation

uses
  MainModule, uEmexUtils, uSqlUtils, uMainVar, uOrdersProtocol_T, Main,
  ServerModule, uError_T, uUtils.Grid, uMessengerF, uUtils.Logger;

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
  Marks.SaveMarksToDB;

  Sql.Exec(' exec CustomerOrderCancelRequest  ', [], []);

  // ОБРАБОТКА ОШИБОК
  // проверка наличия серверных ошибок
  Sql.Open('select 1 from pAccrualAction p with (nolock index=ao2) where p.Spid = @@spid and p.Retval <> 0', [], []);
  var ServerErr:integer;
  ServerErr := Sql.Q.RecordCount;

  if (ServerErr = 0) then
  begin
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
  fOrderDate.ClearDateRange;
  fDetailNum.Clear;

  edtComment2.Clear;

  Page;
  GridRefresh();
end;

procedure TOrdersT2.actFilterExecute(Sender: TObject);
begin
  Page();

  GridRefresh();
end;

procedure TOrdersT2.actCancelСonfirmExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно подтверждаете отказ?' , mtConfirmation, mbYesNo,
  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes : CancelConfirm;
      mrNo  : Exit;
    end;
  end);
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

procedure TOrdersT2.actReOrderExecute(Sender: TObject);
var y: Integer;
   BM: TBookmark;
   SqlText: string;
begin
  ReOrder.FormAction := TFormAction.acUpdate;
  ReOrder.ID:=QueryOrderID.AsInteger;

//  begin
    ReOrder.IsCounter := True;

    BM := Query.GetBookmark;
    Query.DisableControls;
    try

      Query.first;
      for y := 0 to Query.RecordCount - 1 do
      begin

        //if Query.FieldByName('StatusID').AsInteger in [1] then  continue;
        if ((Query.FieldByName('Flag').AsInteger and 4) = 0)  then  continue;

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

    log(SqlText,etInfo);

    sql.Exec('''
                if OBJECT_ID('tempdb..#CounterPart') is not null
                  drop table #CounterPart;

                 CREATE TABLE #CounterPart (OrderID   Numeric(18, 0)
                                           ,N         int
                                           ,Processed bit
                                           );
             ''' + SqlText
             , [], []);

  ReOrder.ShowModal(ReOrderCallBack);
end;

procedure TOrdersT2.actShowMessageExecute(Sender: TObject);
begin
   MessageF.OrderID := QueryOrderID.AsInteger;
   MessageF.ShowModal(MessageCallBack);
end;

procedure TOrdersT2.btnFirstClick(Sender: TObject);
begin
  edtPage.Value := edtPage.MinValue;
  GridRefresh;
end;

procedure TOrdersT2.btnLastClick(Sender: TObject);
begin
  edtPage.Value := edtPage.MaxValue;
  GridRefresh;
end;

procedure TOrdersT2.btnNextClick(Sender: TObject);
begin
  edtPage.Value := edtPage.Value + 1;
  if edtPage.Value > edtPage.MaxValue then edtPage.Value :=edtPage.MaxValue;

  GridRefresh;
end;

procedure TOrdersT2.btnNotificationClick(Sender: TObject);
begin
  GetNotificationOrders;
end;

procedure TOrdersT2.DoHideMask;
begin
  UniSession.Synchronize;
end;

procedure TOrdersT2.DoShowMask;
begin
  UniSession.Synchronize;
end;

procedure TOrdersT2.edtPageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((KEY)=VK_RETURN) then
  begin
    GridRefresh;
  end;
end;

procedure TOrdersT2.Page;
begin
  log('TOrdersT2.Page begin', etInfo);

  sql.Open(
  '''
    DECLARE @Status as ID

    if :Status <> ''
      INSERT INTO @Status (ID)
      SELECT CAST(value AS NUMERIC(18, 0))
        FROM STRING_SPLIT(:Status, ',');

    exec CustomerOrdersPage
           @ClientID        = :ClientID
          ,@Status          = @Status
          ,@DetailNum       = :DetailNum
          ,@Comment2        = :Comment2
          ,@OrderDateStart  = :OrderDateStart
          ,@OrderDateEnd    = :OrderDateEnd
          ,@isCancel        = :isCancel
          ,@IsNotification  = :IsNotification
          ,@PageSize        = :PageSize

    select
           count(OrderID)  as AllRow,
           max(Page) as MaxPage,
           min(Page) as MinPage
      from #OrderPage with (nolock)
  ''',
  ['ClientID', 'Status', 'DetailNum', 'Comment2', 'OrderDateStart', 'OrderDateEnd', 'isCancel', 'IsNotification', 'PageSize'],
  [UniMainModule.AUserID,
   fStatus2.SelectedKeys,
   fDetailNum.Text,
   edtComment2.Text,
   fOrderDate.DateStart,
   fOrderDate.DateEnd,
   cbCancel.ItemIndex,
   FIsNotification,
   Grid.WebOptions.PageSize
  ]);

  FAllPage := sql.F('AllRow').AsInteger;

  if sql.Count > 0 then
  begin
    edtPage.MinValue := sql.F('MinPage').AsInteger;
    edtPage.MaxValue := sql.F('MaxPage').AsInteger;

    edtPage.Enabled := edtPage.MaxValue > 1;
    edtPage.Value   := edtPage.MinValue;

    lblAllCount.Text := ' из ' + edtPage.MaxValue.ToString;
  end
  else
  begin
    edtPage.MinValue := 0;
    edtPage.MaxValue := 0;

    edtPage.Enabled := edtPage.MaxValue > 0;
    edtPage.Value   := 0;

    lblAllCount.Text := ' из 0';
  end;

  PageNavigation;

  log('TOrdersT2.Page end', etInfo);
end;

procedure TOrdersT2.PageNavigation;
begin
  edtPage.Enabled := edtPage.MaxValue > 0;

  btnNext.Enabled := edtPage.Value < edtPage.MaxValue;
  btnPrevious.Enabled := edtPage.Value > edtPage.MinValue;

  btnLast.Enabled := edtPage.Value <> edtPage.MaxValue;
  btnFirst.Enabled := edtPage.Value <> edtPage.MinValue;
end;

procedure TOrdersT2.GridRefresh;
var FClient:string;
    FStatus :string;
    FPriceLogo :string;
begin
  log('GridOpen Begin', etInfo);

  Query.Close();
  Query.ParamByName('Page').AsInteger := edtPage.Value;
  Query.Open();

  SetNotificationCount();

  PageNavigation();

  if edtPage.Value = 0 then
    lblRow.Text := ''
  else
    lblRow.Text:= Format('Отображаются записи с %d по %d, всего %d',
    [(edtPage.Value-1) * Grid.WebOptions.PageSize + 1,
     (edtPage.Value-1) * Grid.WebOptions.PageSize + Query.RecordCount,
     FAllPage]);

  log('GridOpen End', etInfo);
end;

procedure TOrdersT2.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;

  OrdersBtnCancelEnabled();
end;

procedure TOrdersT2.MessageCallBack(Sender: TComponent; AResult: Integer);
begin
  try
     Query.RefreshRecord(False) ;
     Grid.RefreshCurrentRow();
  except
    on E: Exception do
      log('TOrdersT.MessageCallBack Ошибка: ' + e.Message, etException);
  end;
end;

procedure TOrdersT2.CancelConfirm;
begin
  Marks.SaveMarksToDB;

  Sql.Exec(' exec CancelConfirm ');

  ToastOK ('Успешно выполнено!', unisession);

  Marks.DataRefresh(True);

  SetNotificationCount;
end;


procedure TOrdersT2.OrdersBtnCancelEnabled;
begin
  btnCancel.Enabled := Grid.SelectedRows.Count > 0;
end;

procedure TOrdersT2.OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);
begin
  if AResult <> mrOK then Exit;
    begin
      Marks.DataRefresh;
    end;
end;

procedure TOrdersT2.ReOrderCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then
    Exit;

  try
    if ReOrder.FormAction = acUpdate then
    begin

      if ReOrder.IsCounter then
        GridRefresh
      else
      begin
        Marks.DataRefresh(True);
       // Query.Delete;
       // Grid.RefreshCurrentRow();
      end;

      SetNotificationCount;
    end;
  except
    on E: Exception do
      log('TOrdersT2.ReOrderCallBack Ошибка: ' + e.Message, etException);
  end;
end;

procedure TOrdersT2.ppMainPopup(Sender: TObject);
begin
  begin
    actCancelСonfirm.Enabled:= (Marks.Count>0 ) and
                               (Query.FieldByName('IsCancel').AsBoolean);


    actReOrder.Enabled:= (Marks.Count>0 ) and
                         (Query.FieldByName('IsCancel').AsBoolean);
  end;
end;

procedure TOrdersT2.btnPreviousClick(Sender: TObject);
begin
  edtPage.Value := edtPage.Value - 1;
  if edtPage.Value < edtPage.MaxValue then edtPage.Value :=edtPage.MinValue;

  GridRefresh;
end;

procedure TOrdersT2.QueryDeliveryDateToCustomerGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin

  if (not QueryDeliveryDateToCustomer2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-receipt-date-arrow">&#10149;'+
            '</span><span class="x-receipt-date">' + QueryDeliveryDateToCustomer2.AsString + '</span>'; //
  end
  else
  if (not QueryReceiptDate.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-receipt-date-arrow">&#10149;'+
            '</span><span class="x-receipt-date">' + QueryReceiptDate.AsString + '</span>';
  end
  else
    Text := Sender.AsString; // Дата поставки клиенту
end;

procedure TOrdersT2.QueryDeliveryNextDateGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  // Ближайшая дата вылета
  if (not QueryDeliveryNextDate2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-delivery-next-date-arrow">&#10149;'+
            '</span><span class="x-delivery-next-date">' + QueryDeliveryNextDate2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryDeliveryPlanDateSupplierGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryPlanDateSupplier2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span> <span class="x-replacement-detail-number">' + QueryDeliveryPlanDateSupplier2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryDeliveryTermSupplierGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryDeliveryTermSupplier2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-receipt-date-arrow">&#10149;</span> <span class="x-replacement-detail-number">' + QueryDeliveryTermSupplier2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryDeliveryTermToCustomerGetText(Sender: TField;
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

procedure TOrdersT2.QueryDetailNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementDetailNumber.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span> <span class="x-replacement-detail-number">' + QueryReplacementDetailNumber.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var t: string;
begin
  t := '';

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

procedure TOrdersT2.QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementManufacturer.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-manufacturer-arrow">&#10149;</span><span class="x-replacement-manufacturer">' + QueryReplacementManufacturer.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.QueryUnreadMessagesCountGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if QueryUnreadMessagesCount.Value > 0 then
    Text := '<i class="mail-envelope"></i>'
  else
    Text := '<i class="mail-envelope-o"></i>';

  if QueryAllMessageCount.Value > 0 then
    Text := Text +'<sup> ' + QueryAllMessageCount.Value.ToString + '</sup>';
  Text:= '<button type="button" onclick="showEmail(' + QueryOrderID.AsString + ')" style="border: 0; background: none;"> '+ Text + '</button>';
end;

procedure TOrdersT2.GetNotificationOrders;
begin
  btnCancel.Enabled := FIsNotification;
  cbCancel.Enabled := FIsNotification;

  FIsNotification := not FIsNotification;

  Page;
  GridRefresh;

  SetMenuVisible(FIsNotification);
end;

procedure TOrdersT2.SetMenuVisible(AVisible: boolean); var bJSName: string;
begin
  if AVisible then
  begin
    UniMainModule.BrowserOptions := [boDisableMouseRightClick];
    UniSession.AddJS('document.oncontextmenu = document.body.oncontextmenu = function () { return false; }');

    UniSession.AddJS(
      'var el = document.querySelector(".icon-notification");' +
      'if (el) { el.classList.add("color"); }'
    );
  end
  else
  begin
    UniMainModule.BrowserOptions := [];
    UniSession.AddJS('document.oncontextmenu = document.body.oncontextmenu = function () { return true; }');

    UniSession.AddJS(
      'var el = document.querySelector(".icon-notification");' +
      'if (el) { el.classList.remove("color"); }'
    );
  end;

  SetNotificationCount;
end;

procedure TOrdersT2.SetMenuVisible;
begin
  SetMenuVisible(FIsNotification);
end;

procedure TOrdersT2.SetNotificationCount;
var
  bJSName: string;
begin

  Sql.Open('exec GetNotificationCount @ClientID=:ClientID', ['ClientID'], [UniMainModule.AUserID]);

  if Sql.Count > 0 then
  begin
     bJSName := btnNotification.JSName;
     UniSession.AddJS(bJSName + '.setBadgeText(' + Sql.Q.FieldByName('NotificationCount').AsString +  ');');
  end;
end;

procedure TOrdersT2.SetNotificationIcon;
begin
end;

procedure TOrdersT2.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if (EventName = '_columnhide') then
  begin
      Sql.Exec('''
               exec CustomerGridOptionsVisible
                      @Grid   = :Grid
                     ,@Column = :Column
                     ,@Visible= 0
                     ,@ClientID=:ClientID
               ''',
              ['Grid', 'Column', 'ClientID'],
              [self.ClassName +'.' + Grid.Name,
               Grid.Columns[Params['column'].Value.ToInteger].FieldName,
               UniMainModule.AUserID]);
  end
  else
  if (EventName = '_columnshow') then
  begin
    Sql.Exec('''
              exec CustomerGridOptionsVisible
                    @Grid   = :Grid
                   ,@Column = :Column
                   ,@Visible= 1
                   ,@ClientID=:ClientID
            ''',
            ['Grid', 'Column', 'ClientID'],
            [self.ClassName +'.' + Grid.Name,
             Grid.Columns[Params['column'].Value.ToInteger].FieldName,
             UniMainModule.AUserID]);
  end
  else
  if (EventName = 'showEmail') then
  begin
    //actShowMessageExecute(Self);
    MessageF.OrderID := Params.Values['P1'].ToInteger;
    MessageF.ShowModal(MessageCallBack);
  end
end;

procedure TOrdersT2.GridCellClick(Column: TUniDBGridColumn);
begin
  ACurrColumn := Column;
end;

procedure TOrdersT2.GridCellContextClick(Column: TUniDBGridColumn; X,Y: Integer);
begin
  ACurrColumn := Column;

  if FIsNotification then
    ppMain.Popup(X, Y, Column.Grid);
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

  if (Query.FieldByName('Flag').AsInteger and 4) > 0 then // отказан
  begin
    Attribs.Font.Color:=clGray;
  end;
end;

procedure TOrdersT2.StateActionMenuCreate;
begin

end;

procedure TOrdersT2.cbCancelSelect(Sender: TObject);
begin
//  GridRefresh;
end;

procedure TOrdersT2.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TOrdersT2.GridColumnActionClick(Column: TUniDBGridColumn;
  ButtonId: Integer);
begin
  //
end;

procedure TOrdersT2.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glSave);
end;

procedure TOrdersT2.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glSave);
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
  Grid.WebOptions.PageSize := sql.GetSetting('CustomerOrdersGridRowCount', 100);

  actSelect.Caption := '';
  actUnSelect.Caption := '';
  fOrderDate.Text     := '';

  fStatus2.FillFromSQL('''
    DECLARE @R table (NodeID numeric(18, 0), Name varchar(256)) ;

    insert @R
    exec OrderFilter_Status

    SELECT NodeID as ID, Name from @R;
  '''
  );

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
  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glLoad);

  // объект для упраления метками
  Marks := tMarks.Create(Grid, 3);
  Marks.Clear;

  UniSession.JSCode(' showEmail = function(AVal) {  ajaxRequest(' + Grid.JSName    + ', "showEmail", ["P1=" + AVal]); } ;');

  log('TOrdersT2.UniFrameCreate End', etInfo);
end;

procedure TOrdersT2.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
end;

procedure TOrdersT2.UniFrameReady(Sender: TObject);
begin
  FIsNotification := false;

  SetNotificationIcon();

  SetNotificationCount();

  PageNavigation();

  OrdersBtnCancelEnabled();

  UniSession.AddJS('Ext.getCmp("' + N2.JSId + '").addCls("menu-item-ok");');
  UniSession.AddJS('Ext.getCmp("' + N1.JSId + '").addCls("menu-item-cancel");');
end;

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


initialization
  RegisterClass(TOrdersT2);
end.
