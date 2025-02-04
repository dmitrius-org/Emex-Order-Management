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
  uUniDateRangePicker, uConstant, uToast, uReOrderF, uUtils.Mark;


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
    qStatus: TFDQuery;
    dsStatus: TDataSource;
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
    fStatus2: TUniCheckComboBox;
    pnlGridSelectedCount: TUniPanel;
    UniLabel6: TUniLabel;
    fDetailNum: TUniEdit;
    UniPanel3: TUniPanel;
    lblSelRowCunt: TUniLabel;
    UniPanel4: TUniPanel;
    lblSelRowSum: TUniLabel;
    UniPanel5: TUniPanel;
    lblSelRowSum2: TUniLabel;
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
    procedure fStatus2Select(Sender: TObject);
    procedure fPriceLogoSelect(Sender: TObject);
    procedure cbCancelSelect(Sender: TObject);
    procedure actShowMessageExecute(Sender: TObject);
    procedure actCancelRequestExecute(Sender: TObject);
    procedure QueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryNextDateGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex, NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure QueryDeliveryDateToCustomerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnActionClick(Column: TUniDBGridColumn;
      ButtonId: Integer);
    procedure btnNotificationClick(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure actCancelСonfirmExecute(Sender: TObject);
    procedure actReOrderExecute(Sender: TObject);
    procedure QueryDeliveryPlanDateSupplierGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure QueryDeliveryTermSupplierGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FAction: tFormaction;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;

    FIsNotification: Boolean;

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

    procedure FilterStatusCreate();

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

    procedure OrdersFCallBack;

  public
    { Public declarations }

    /// <summary>
    /// GridRefresh - загрузка данных из БД
    /// </summary>
    procedure GridRefresh;

    procedure SetMenuVisible(AVisible: boolean);overload;

    procedure SetMenuVisible(); overload;
  end;

implementation

uses
  MainModule, uEmexUtils, uSqlUtils, uLogger, uMainVar, uOrdersProtocol_T, Main,
  ServerModule, uError_T, uUtils.Grid, uMessengerF;

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

  Marks.SaveMarksToDB;

  Sql.Exec(' exec CustomerOrderCancelRequest  ', [], []);


  // ОБРАБОТКА ОШИБОК
  // проверка наличия серверных ошибок
  Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
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
  FFilterTextPriceLogo := '';
  FFilterTextClient := '';

  fOrderDate.ClearDateRange;
  fDetailNum.Clear;

  edtComment2.Clear;

  GridRefresh();
end;

procedure TOrdersT2.actFilterExecute(Sender: TObject);
begin
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

//  end;
  ReOrder.ShowModal(ReOrderCallBack);
end;

procedure TOrdersT2.actShowMessageExecute(Sender: TObject);
begin
   MessageF.OrderID := QueryOrderID.AsInteger;
   MessageF.ShowModal();
end;

procedure TOrdersT2.btnNotificationClick(Sender: TObject);
begin
  GetNotificationOrders;

//  if FISNotification then
//  begin
//    UniSession.AddJS(btnNotification.JSName +'.badgeEl.setStyle({'+quotedstr('color')+' : '+quotedstr('orange')+'});');
//
//  end
//  else
//  begin
//
//    UniSession.AddJS(btnNotification.JSName +'.badgeEl.setStyle({'+quotedstr('color')+' : '+quotedstr('white')+'});');
//  end;
end;

procedure TOrdersT2.DoHideMask;
begin
  UniSession.Synchronize;
end;

procedure TOrdersT2.DoShowMask;
begin
  UniSession.Synchronize;
end;

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

  if FIsNotification then
  begin
      Query.MacroByName('IsNotification').Value :=
      '''
        -- and o.[Flag] & 4 /*отказан*/ > 0
        and o.[IsCancel] = 1
        and o.[Flag] & 4096 /*Отказ подтвержден*/= 0
        and o.[Flag] & 8192 /*Перезаказан*/= 0
      ''';
  end
  else
  begin
    Query.MacroByName('IsNotification').Value := '';
    Query.ParamByName('isCancel').Value := cbCancel.ItemIndex;
  end;

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

  if (fOrderDate.DateStart <> NullDate) and (fOrderDate.DateEnd <> NullDate) then
  begin
    Query.MacroByName('OrderDate').Value := ' and o.OrderDate between '''   + FormatDateTime('yyyymmdd', fOrderDate.DateStart) + ''' and '''  +
                                              FormatDateTime('yyyymmdd', fOrderDate.DateEnd) + ''''
  end
  else
  begin
    Query.MacroByName('OrderDate').Value := '';
  end;

  Query.MacroByName('Status').Value :=  FStatus;

  if fDetailNum.Text <> '' then
    if string(fDetailNum.Text)[1] = '!' then
    begin
      Query.MacroByName('DetailNum').Value := ' and o.OrderDetailSubId = :DetailNum';
      Query.ParamByName('DetailNum').AsString := Trim(fDetailNum.Text);
    end
    else
    begin
      Query.MacroByName('DetailNum').Value := ' and (o.DetailNumber like ''%'   + Trim(fDetailNum.Text) + '%''' +
                                              '   or o.ReplacementDetailNumber like ''%'   + Trim(fDetailNum.Text) + '%'')'
    end
  else
    Query.MacroByName('DetailNum').Value := '';

  // комментарий
  if edtComment2.Text <> '' then
    Query.MacroByName('Comment2').Value := ' and o.Comment2 like ''%' + edtComment2.Text + '%'''
  else
    Query.MacroByName('Comment2').Value := '';

  Query.ParamByName('ClientID').Value := UniMainModule.AUserID; //  AUserID- туту ид клиента
  Query.Open();


  SetNotificationCount;
  logger.Info('GridOpen End');
end;

procedure TOrdersT2.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;
end;

procedure TOrdersT2.CancelConfirm;
begin
  Marks.SaveMarksToDB;

  Sql.Exec(' exec CancelConfirm ');

  ToastOK ('Успешно выполнено!', unisession);

  Marks.DataRefresh(True);

  SetNotificationCount;
end;

procedure TOrdersT2.OrdersFCallBack;
begin

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
      logger.Info('TOrdersT2.ReOrderCallBack Ошибка: ' + e.Message);
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

procedure TOrdersT2.QueryDeliveryDateToCustomerGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (not QueryReceiptDate.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-receipt-date-arrow">&#10149;'+
            '</span><span class="x-receipt-date">' + QueryReceiptDate.AsString + '</span>'; // Ожидаемая дата поступления
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
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-detail-number-arrow">&#10149;</span> <span class="x-replacement-detail-number">' + QueryDeliveryTermSupplier2.AsString + '</span>';
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

  // Сообщение от менеджера
  if (Sender.AsInteger and 32) > 0 then
  begin
    t := t + '<span class="x-orders-message" data-qtip="Имеется непрочитанное сообщение от менеджера"><i class="fa fa-bell"></i></span> ';
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

procedure TOrdersT2.QueryManufacturerGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryReplacementManufacturer.Value <> '') then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-replacement-manufacturer-arrow">&#10149;</span><span class="x-replacement-manufacturer">' + QueryReplacementManufacturer.Value + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TOrdersT2.GetNotificationOrders;
begin
  btnCancel.Enabled := FIsNotification;
  cbCancel.Enabled := FIsNotification;

  FIsNotification := not FIsNotification;

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
      'var el = document.querySelector(".order.fa.fa-bell");' +
      'if (el) { el.classList.add("icon-notification"); }' +
      'else { console.error("Element with class fa fa-bell not found"); }'
    );
  end
  else
  begin
    UniMainModule.BrowserOptions := [];
    UniSession.AddJS('document.oncontextmenu = document.body.oncontextmenu = function () { return true; }');

    UniSession.AddJS(

      'var el = document.querySelector(".order.fa.fa-bell");' +
      'if (el) { el.classList.remove("icon-notification"); }' +
      'else { console.error("Element with class fa fa-bell not found"); }'
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
//  if FIsNotification then
//  begin
//    btnNotification.Caption:=   order-notification-btn
//  end
//  else
//  begin
//
//  end;

end;

procedure TOrdersT2.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  logger.Info(EventName);
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
  GridRefresh;
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
  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glLoad);

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
  FIsNotification := false;

  SetNotificationIcon();

  SetNotificationCount;

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
