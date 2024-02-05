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
  uniDateTimePicker;



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
    UniToolButton5: TUniToolButton;
    tbActionExecute: TUniToolButton;
    ppExecute: TUniPopupMenu;
    ppExecuteAction: TUniMenuItem;
    actExecuteAction: TAction;
    actExecuteActionEnabled: TAction;
    QueryStatusID: TFMTBCDField;
    actExecuteActionRollback: TAction;
    N3: TUniMenuItem;
    N10: TUniMenuItem;
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
    N1: TUniMenuItem;
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
    N12: TUniMenuItem;
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
    actFormRefusalsOpen: TAction;
    N5: TUniMenuItem;
    N13: TUniMenuItem;
    QueryDestinationLogo: TWideStringField;
    actUploadingRefusalsEmex: TAction;
    Emex1: TUniMenuItem;
    UniFileUpload: TUniFileUpload;
    UniToolButton2: TUniToolButton;
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
    procedure fPriceLogoSelect(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
    procedure cbCancelSelect(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure QueryPricePurchaseGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actFormRefusalsOpenExecute(Sender: TObject);
    procedure actUploadingRefusalsEmexExecute(Sender: TObject);
    procedure UniFileUploadMultiCompleted(Sender: TObject;
      Files: TUniFileInfoArray);
    procedure actSetCommentExecute(Sender: TObject);
    procedure actGroupDetailNameEditExecute(Sender: TObject);
  private
    { Private declarations }
    FAction: tFormaction;
    FAccrual: TAccrual;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;

    Marks: TMarks;                  // отметки

    ACurrColumn: TUniDBGridColumn;  //текущая колонка

    /// <summary>
    /// GridOpen -
    /// </summary>
    procedure GridOpen;

    /// <summary>
    ///  OrdersFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure OrdersFCallBack(Sender: TComponent; AResult:Integer);
    procedure OrdersMessageFCallBack(Sender: TComponent; AResult:Integer);
    procedure GroupDetailNameEditCallBack(Sender: TComponent; AResult:Integer);
    /// <summary>
    /// StateActionMenuCreate - Формирование списка меню/действий для состояния
    /// </summary>
    procedure StateActionMenuCreate();
    procedure ActionExecuteEnabled();

    /// <summary>
    ///  ActionExecuteAfter - постобработчик действия. Набор данных в pAccrualAction
    ///</summary>
    procedure ActionExecuteAfter(AResult:TFormAction);
    procedure ActionExecute(ActionID: Integer);

    procedure DoShowMask();
    procedure DoHideMask();

    function Accrual :TAccrual;

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
  MainModule, uGrantUtils, uEmexUtils, uSqlUtils, uLogger, uError_T, uMainVar, uOrdersProtocol_T, Main, uOrdersF, ServerModule, uRefusalsT, uUploadingRefusals, uToast, uOrdersMessageF, uGroupDetailNameEditF;

{$R *.dfm}

function TOrdersT.Accrual: TAccrual;
begin
  if not Assigned(FAccrual) then
  begin
    FAccrual := TAccrual.Create(TFDConnection(Query.Connection));
  end;

  Result := FAccrual;
end;

procedure TOrdersT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TOrdersT.actEditExecute(Sender: TObject);
begin
    OrderF.FormAction := TFormAction.acUpdate;
    OrderF.ID:=QueryOrderID.AsInteger;
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
//    DeselectAll;

    Query.EnableControls;
  end;
end;

procedure TOrdersT.ActionExecute(ActionID: Integer);
begin
  logger.Info('TOrdersT.ActionExecute Begin');
  DoShowMask;
  try
    if Accrual.ActionExecute(ActionID) = 0 then
      begin
        ActionExecuteAfter(acRefresh);

        ToastOK ('Операция успешно выполнена!', UniSession);
      end;
  finally
    DoHideMask;
  end;
  logger.Info('TOrdersT.ActionExecute Begin');
end;

procedure TOrdersT.actExecuteActionRollbackExecute(Sender: TObject);
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

    if Accrual.ActionExecuteRollback() = 0 then
    begin
      ActionExecuteAfter(acRefresh);

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
  fStatus2.ClearSelection;
  fPriceLogo.ClearSelection;
  fClient.ClearSelection;

  FFilterTextStatus := '';
  FFilterTextPriceLogo := '';
  FFilterTextClient := '';

  fOrderNum.Text := '';
  fDetailNum.Text:='';

  fOrderDate.Text := '';

  GridOpen();
end;

procedure TOrdersT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TOrdersT.actFormRefusalsOpenExecute(Sender: TObject);
begin
  RefusalsT.ShowModal;
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

procedure TOrdersT.actGroupDetailNameEditExecute(Sender: TObject);
begin
  // групповое изменение наименования детали
  GroupDetailNameEditF.FormAction := TFormAction.acUpdate;
  GroupDetailNameEditF.ShowModal(GroupDetailNameEditCallBack);
end;

procedure TOrdersT.ActionExecuteAfter(AResult: TFormAction);
begin
  if AResult = acRefresh then
  begin
    GridOpen();
  end;
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
  UniToolButton5.HideMask();
  UniSession.Synchronize;
end;

procedure TOrdersT.DoShowMask;
begin
  UniToolButton5.ShowMask('');
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


procedure TOrdersT.UniFileUploadMultiCompleted(Sender: TObject;
  Files: TUniFileInfoArray);
var f:TUniFileInfoClass;
    DestName : string;
    DestFolder : string;

    AFnabled : Boolean;
begin
  logger.Info('TOrdersT.UniFileUpload1MultiCompleted Begin');
  for f in Files do
  begin
    logger.Info('UniFileUpload1Completed ' + f.FileName);
    logger.Info(ExtractFileName(f.FileName));

    RetVal.Clear;

    DestFolder:= UniServerModule.StartPath+'temp\';
    DestName  := DestFolder+ExtractFileName(f.FileName);

    AFnabled  := CopyFile(PChar(f.Stream.FileName), PChar(DestName), False);

    Sql.Q.Close;
    Sql.Open(' declare @R      int                  ' +
             '                                      ' +
             ' exec @r = OrderRefusalsInsert        ' +
             '             @FileName = :FileName    ' +
             '                                      ' +
             ' select @r as retcode ',
            ['FileName'],
            [DestName]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    if RetVal.Code = 0 then
    begin

      var e:tUploadingRefusals;
      e:= tUploadingRefusals.Create(UniMainModule.FDConnection);
      try

        RetVal.Code := e.Uploading(SPID);

        if  RetVal.Code > 0   then
          ToastERR(RetVal.Message, UniSession)
        else
          ToastOK('Ответ сформирован!', UniSession)

      finally
        FreeAndNil(e)
      end;

    end
    else
      ToastERR(RetVal.Message, UniSession);

  end;
  logger.Info('TOrdersT.UniFileUpload1MultiCompleted End');
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

    if FStatus <> '' then
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
      Query.MacroByName('OrderNum').Value := ' and o.OrderNum like ''%'   + fOrderNum.Text + '%'''
    else
      Query.MacroByName('OrderNum').Value := '';

    if fDetailNum.Text <> '' then
      Query.MacroByName('DetailNum').Value := ' and o.DetailNumber like ''%'   + fDetailNum.Text + '%'''
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

    Query.Open();

    StateActionMenuCreate;

  finally
    DoHideMask();
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
      logger.Info('TOrdersT.UserFCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TOrdersT.GetMarksInfo;
begin
  lblSelRowCunt.Caption := 'Выделено строк: ' + Grid.SelectedRows.Count.ToString + '  ';

  if Marks.Count > 0 then
  begin
    Sql.Open('Select Amount, AmountPurchase, WeightKG, VolumeKG, OverVolume from vMarksSum', [], []);

    lblRowSum1.Caption := Sql.Q.FieldByName('Amount').AsString+  ' ₽';
    lblRowSum2.Caption := Sql.Q.FieldByName('AmountPurchase').AsString+  ' $';

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
  if (Query.FieldByName('Flag').AsInteger and 1) = 1 then
  begin
    //Attribs.Font.Color:=clMaroon;
    //Attribs.Font.Style:=[fsBold, fsItalic];
    Attribs.Color:= rgb(255, 207, 217);
  end
  else if (Query.FieldByName('Flag').AsInteger and 2) = 2 then
  begin
    Attribs.Color:=rgb(242, 169, 210);
  end
  else if (Query.FieldByName('Flag').AsInteger and 64) = 64 then // Горчичный
  begin
    Attribs.Color:=rgb(255,219,88); //#F34723
  end;

  if (Query.FieldByName('IsCancel').AsBoolean) then
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
    for i := 0 to AGrid.Columns.count-1 do
    begin
      Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[AForm.ClassName +'.' + AGrid.Name]);
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
     // Column.Locked := Sql.Q.FieldByName('Locking').AsBoolean;

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
 // logger.Info('TOrdersT.StateActionMenuCreate begin');
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
//  logger.Info('TOrdersT.StateActionMenuCreate End');
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

procedure TOrdersT.actUploadingRefusalsEmexExecute(Sender: TObject);
begin
  UniFileUpload.Execute;
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
  logger.Info('TOrdersT.UniFrameCreate Begin');

  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}

  Grant.SetGrant(self, actMain);

  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

  actSelect.Caption   := '';
  actUnSelect.Caption := '';
  fOrderDate.Text     := '';

  FilterStatusCreate;
  FilterPriceLogoCreate();
  FilterClientsCreate();

 // qPriceLogo.Open();
 // qClient.Open();

  // индексы для сортировки
  //with Query do
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

  actExecuteActionEnabled.Enabled  := (actExecuteActionEnabled.Tag = 1) and (Grid.SelectedRows.Count > 0);
  actExecuteActionRollback.Enabled := (actExecuteActionRollback.Tag= 1) and (Grid.SelectedRows.Count > 0);

  // объект для упраления метками
  Marks := tMarks.Create(Grid);
  Marks.Clear;

  GetMarksInfo;

  logger.Info('TOrdersT.UniFrameCreate End');
end;


procedure TOrdersT.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
end;

procedure TOrdersT.OrdersFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
    if OrderF.FormAction = acUpdate then
    begin
      Query.Edit ;
      Query.Post;

      ToastOK('Изменение успешно выполнено!', unisession);
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
  Sql.Exec('Delete tMarks from tMarks (rowlock) where Spid= @@Spid and Type=3', [], [])
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
