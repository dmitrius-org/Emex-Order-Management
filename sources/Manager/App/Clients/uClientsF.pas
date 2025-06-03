unit uClientsF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniTabControl, uniPageControl, uniBasicGrid,
  uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox,
  Vcl.Menus, uUniExComboBox;

type
  TClientsF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    pcCommon: TUniPageControl;
    tabHome: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    cbIsActive: TUniCheckBox;
    lblName: TUniLabel;
    pcOrders: TUniTabSheet;
    pcRefusals: TUniTabSheet;
    pcSuppliers: TUniTabSheet;
    pcCommision: TUniTabSheet;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    Query: TFDQuery;
    QueryFolder: TWideStringField;
    QueryFirstline: TIntegerField;
    QueryManufacturer: TIntegerField;
    QueryDetailNumber: TIntegerField;
    QueryQuantity: TIntegerField;
    QueryDetailID: TIntegerField;
    QuerytDetailName: TIntegerField;
    QueryPrice: TIntegerField;
    QueryAmount: TIntegerField;
    QueryOrderNum: TWideStringField;
    QueryOrderDate: TWideStringField;
    QueryPriceNum: TWideStringField;
    QueryCommission: TCurrencyField;
    QueryIsActive: TBooleanField;
    QueryCustomerSubID: TStringField;
    QueryReference: TStringField;
    DataSource: TDataSource;
    UpdateSQL: TFDUpdateSQL;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    QueryOrderFileFormatID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryID: TFMTBCDField;
    UniPanel1: TUniPanel;
    Grid: TUniDBGrid;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    UniLabel6: TUniLabel;
    edtTaxes: TUniFormattedNumberEdit;
    UniLabel7: TUniLabel;
    UniLabel8: TUniLabel;
    UniLabel9: TUniLabel;
    cbResponseType: TUniComboBox;
    cbNotificationMethod: TUniComboBox;
    edtNotificationAddress: TUniEdit;
    cbSuppliers: TUniDBLookupComboBox;
    qSuppliers: TFDQuery;
    dsSuppliers: TDataSource;
    qSuppliersSuppliersID: TFMTBCDField;
    qSuppliersBrief: TWideStringField;
    tabManager: TUniTabSheet;
    UniPanel2: TUniPanel;
    UniHiddenPanel1: TUniHiddenPanel;
    LookupClients: TUniDBLookupComboBox;
    dsManagerList: TDataSource;
    qManagerList: TFDQuery;
    qManagerListClientID: TFMTBCDField;
    qManagerListBrief: TWideStringField;
    qManager: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    QueryEmployeeID: TFMTBCDField;
    QueryClientBrief: TWideStringField;
    dsManager: TDataSource;
    uManager: TFDUpdateSQL;
    ManagerGrid: TUniDBGrid;
    UniToolBar1: TUniToolBar;
    UniToolButton3: TUniToolButton;
    UniToolButton5: TUniToolButton;
    UniToolButton6: TUniToolButton;
    pmManager: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    actManagerAdd: TAction;
    actManagerEdit: TAction;
    actManagerDelete: TAction;
    actManagerRefresh: TAction;
    UniHiddenPanel2: TUniHiddenPanel;
    LookupManager: TUniDBLookupComboBox;
    UniLabel5: TUniLabel;
    tabPriceProfiles: TUniTabSheet;
    UniToolBar2: TUniToolBar;
    UniToolButton7: TUniToolButton;
    UniToolButton8: TUniToolButton;
    UniToolButton9: TUniToolButton;
    UniPanel3: TUniPanel;
    ProfilesCustomerGrid: TUniDBGrid;
    qProfilesCustomer: TFDQuery;
    dsProfilesCustomer: TDataSource;
    uProfilesCustomer: TFDUpdateSQL;
    qProfilesCustomerSpid: TIntegerField;
    qProfilesCustomerProfilesCustomerID: TIntegerField;
    qProfilesCustomerClientID: TFMTBCDField;
    qProfilesCustomerProfilesDeliveryID: TIntegerField;
    qProfilesCustomerMargin: TCurrencyField;
    qProfilesCustomerReliability: TCurrencyField;
    qProfilesCustomerUploadFolder: TStringField;
    qProfilesCustomerUploadPriceName: TStringField;
    qProfilesCustomerUploadFileName: TStringField;
    qProfilesCustomerisActive: TBooleanField;
    qProfilesCustomerClientPriceLogo: TWideStringField;
    qProfilesCustomerUploadDelimiterID: TIntegerField;
    qProfilesCustomerID: TFMTBCDField;
    actPriceProfilesAdd: TAction;
    actPriceProfilesEdit: TAction;
    actPriceProfilesDelete: TAction;
    actPriceProfilesRefresh: TAction;
    UniToolButton10: TUniToolButton;
    qProfilesCustomerUploadDelimiter: TStringField;
    qProfilesDeliveryList: TFDQuery;
    qProfilesDeliveryListProfilesDeliveryID: TFDAutoIncField;
    qProfilesDeliveryListDestinationName: TWideStringField;
    qDelimiterList: TFDQuery;
    qDelimiterListDelimiterID: TFDAutoIncField;
    qDelimiterListName: TStringField;
    UniHiddenPanel3: TUniHiddenPanel;
    lkPriceProfiles: TUniDBLookupComboBox;
    dsProfilesDeliveryList: TDataSource;
    dsDelimiterList: TDataSource;
    lkUploadDelimiter: TUniDBLookupComboBox;
    qProfilesCustomerProfilesDeliveryName: TWideStringField;
    cbClientType: TUniExComboBox;
    qProfilesCustomerBrief: TStringField;
    pmProfilesCustomer: TUniPopupMenu;
    UniMenuItem4: TUniMenuItem;
    UniMenuItem5: TUniMenuItem;
    actMarginEdit: TAction;
    actReliabilityEdit: TAction;
    N6: TUniMenuItem;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
    N9: TUniMenuItem;
    N10: TUniMenuItem;
    N11: TUniMenuItem;
    qProfilesCustomerDeliveryTermCustomer: TIntegerField;
    tabShipments: TUniTabSheet;
    cbStatusRequiringPayment: TUniCheckComboBox;
    UniLabel10: TUniLabel;
    qManagerObjectType: TIntegerField;
    UniLabel11: TUniLabel;
    edtEmail: TUniEdit;
    edtPhone: TUniEdit;
    UniLabel13: TUniLabel;
    edtContactPerson: TUniEdit;
    UniLabel14: TUniLabel;
    QueryOnlyThisBrand: TIntegerField;
    edtNotificationScript: TUniEdit;
    UniLabel12: TUniLabel;
    QueryCustomerClientNum: TIntegerField;
    QueryCustomerClientSign: TIntegerField;
    QueryCustomerOrder: TIntegerField;
    edtCommission: TUniFormattedNumberEdit;
    edtMargin: TUniFormattedNumberEdit;
    edtReliability: TUniFormattedNumberEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ManagerGridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actManagerAddExecute(Sender: TObject);
    procedure actManagerEditExecute(Sender: TObject);
    procedure actManagerDeleteExecute(Sender: TObject);
    procedure actManagerRefreshExecute(Sender: TObject);
    procedure qManagerAfterPost(DataSet: TDataSet);
    procedure actPriceProfilesAddExecute(Sender: TObject);
    procedure actPriceProfilesEditExecute(Sender: TObject);
    procedure actPriceProfilesDeleteExecute(Sender: TObject);
    procedure actPriceProfilesRefreshExecute(Sender: TObject);
    procedure ProfilesCustomerGridColumnSort(Column: TUniDBGridColumn;
      Direction: Boolean);
    procedure ManagerGridColumnSort(Column: TUniDBGridColumn;
      Direction: Boolean);
    procedure tabPriceProfilesBeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure cbSuppliersChange(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure ProfilesCustomerGridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actMarginEditExecute(Sender: TObject);
    procedure actReliabilityEditExecute(Sender: TObject);
    procedure qManagerObjectTypeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ManagerGridCellClick(Column: TUniDBGridColumn);
    procedure pmManagerPopup(Sender: TObject);
    procedure cbResponseTypeChange(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  ManagerGridRefresh - Обновление таблицы: Менеджеры
    ///</summary>
    procedure ManagerGridRefresh();
    /// <summary>
    ///  PriceProfilesGridRefresh - Обновление таблицы: Профили обработки прайслистов
    ///</summary>
    procedure PriceProfilesGridRefresh();
    /// <summary>
    ///  ProfilesDeliveryList - получение списка поставщиков
    ///</summary>
    procedure ProfilesDeliveryList();
    /// <summary>
    ///  DelimiterList - Список разделителей
    ///</summary>
    procedure DelimiterList();

    procedure PromptMarginEditCallBack(Sender: TComponent; AResult:Integer);

    procedure ManagerEditEnabled();
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function ClientsF: TClientsF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar, uUtils.Grid,
  uPromptMarginEdit, uPromptReliabilityEdit;

function ClientsF: TClientsF;
begin
  Result := TClientsF(UniMainModule.GetFormInstance(TClientsF));
end;

{ TUserF }

procedure TClientsF.actAddExecute(Sender: TObject);
begin
  Query.Insert;
  Query.FieldByName('ClientID').AsInteger := FID;
end;

procedure TClientsF.actDeleteExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TClientsF.actEditExecute(Sender: TObject);
begin
  Query.Edit;
end;

procedure TClientsF.actManagerAddExecute(Sender: TObject);
begin
  qManagerList.Refresh;

  qManager.Insert;
  qManager.FieldByName('ClientID').AsInteger := FID;
end;

procedure TClientsF.actManagerDeleteExecute(Sender: TObject);
begin
  qManagerList.Refresh;

  qManager.Delete;
end;

procedure TClientsF.actManagerEditExecute(Sender: TObject);
begin
  qManagerList.Refresh;

  qManager.Edit;
end;

procedure TClientsF.actManagerRefreshExecute(Sender: TObject);
begin
  ManagerGridRefresh;
end;

procedure TClientsF.actMarginEditExecute(Sender: TObject);
begin
  PromptMarginEdit.ShowModal(PromptMarginEditCallBack);
end;

procedure TClientsF.actPriceProfilesAddExecute(Sender: TObject);
begin
  ProfilesDeliveryList;

  qProfilesCustomer.Insert;
  qProfilesCustomer.FieldByName('ClientID').AsInteger := FID;
end;

procedure TClientsF.actPriceProfilesDeleteExecute(Sender: TObject);
begin
 qProfilesCustomer.Delete;
end;

procedure TClientsF.actPriceProfilesEditExecute(Sender: TObject);
begin
 ProfilesDeliveryList;
 qProfilesCustomer.Edit;
end;

procedure TClientsF.actPriceProfilesRefreshExecute(Sender: TObject);
begin
  PriceProfilesGridRefresh;
end;

procedure TClientsF.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close;
  Query.Open;
end;

procedure TClientsF.actReliabilityEditExecute(Sender: TObject);
begin
  PromptReliabilityEdit.ShowModal(PromptMarginEditCallBack);
end;

procedure TClientsF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TClientsF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  case FAction of
    acInsert:
    begin
      sqltext :='''
                 declare @R      int
                        ,@ClientID numeric(18, 0)

                 exec @r = ClientInsert
                             @ClientID  = @ClientID out
                            ,@Brief     = :Brief
                            ,@Name      = :Name
                            ,@IsActive  = :IsActive
                            ,@SuppliersID   = :SuppliersID
                            ,@Taxes         = :Taxes
                            ,@ResponseType  = :ResponseType
                            ,@NotificationMethod  = :NotificationMethod
                            ,@NotificationAddress = :NotificationAddress
                            ,@ClientTypeID	      = :ClientTypeID
                            ,@Email	              = :Email
                            ,@Phone	              = :Phone
                            ,@ContactPerson       = :ContactPerson
                            ,@NotificationScript  = :NotificationScript

                 select @r as retcode
      ''';

      Sql.Open(sqltext,
               ['Brief','Name','IsActive','SuppliersID', 'Taxes', 'ResponseType',
                'NotificationMethod', 'NotificationAddress', 'ClientTypeID', 'Email',
                'Phone', 'ContactPerson', 'NotificationScript'],
               [edtBrief.Text,
               '',
               cbIsActive.Checked,
               cbSuppliers.KeyValue,
               edtTaxes.Value,
               cbResponseType.ItemIndex,
               cbNotificationMethod.ItemIndex,
               edtNotificationAddress.Text,
               cbClientType.Value,
               edtEmail.Text,
               edtPhone.Text,
               edtContactPerson.text,
               edtNotificationScript.text
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    end;
    acUpdate:
    begin
      sqltext :='''
                  declare @R      int

                  exec @r = ClientUpdate
                             @ClientID              = :ClientID
                            ,@Brief                 = :Brief
                            ,@Name                  = :Name
                            ,@IsActive              = :IsActive
                            ,@SuppliersID           = :SuppliersID
                            ,@Taxes                 = :Taxes
                            ,@ResponseType          = :ResponseType
                            ,@NotificationMethod    = :NotificationMethod
                            ,@NotificationAddress   = :NotificationAddress
                            ,@ClientTypeID	        = :ClientTypeID
                            ,@StatusRequiringPayment= :StatusRequiringPayment
                            ,@Email	                = :Email
                            ,@Phone	                = :Phone
                            ,@ContactPerson         = :ContactPerson
                            ,@NotificationScript    = :NotificationScript
                 select @r as retcode
      ''';

      Sql.Open(sqltext,
               ['Brief','Name','IsActive','SuppliersID','ClientID', 'Taxes',
               'ResponseType', 'NotificationMethod', 'NotificationAddress',
               'ClientTypeID', 'StatusRequiringPayment', 'Email',
                'Phone', 'ContactPerson', 'NotificationScript'],
               [edtBrief.Text,
               '',
               cbIsActive.Checked,
               cbSuppliers.KeyValue,
               FID,
               edtTaxes.Value,
               cbResponseType.ItemIndex,
               cbNotificationMethod.ItemIndex,
               edtNotificationAddress.Text,
               cbClientType.value,
               cbStatusRequiringPayment.Text,
               edtEmail.Text,
               edtPhone.Text,
               edtContactPerson.text,
               edtNotificationScript.text
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      sqltext :=  ' declare @R      int                 '+
                  '                                     '+
                  ' exec @r = ClientDelete              '+
                  '             @ClientID   = :ClientID '+
                  '                                     '+
                  ' select @r as retcode                '+
                  ' ';

      Sql.Open(sqltext, ['ClientID'], [FID]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TClientsF.cbResponseTypeChange(Sender: TObject);
begin
  edtNotificationScript.Enabled := cbResponseType.ItemIndex = 2;
end;

procedure TClientsF.cbSuppliersChange(Sender: TObject);
begin
  Sql.Exec(' exec ProfilesCustomerRefresh @SuppliersID = :SuppliersID, @ClientID = :ClientID',
           ['SuppliersID', 'ClientID'], [cbSuppliers.KeyValue, FID ]);

  PriceProfilesGridRefresh;

  ProfilesDeliveryList;

  MessageDlg('При изменении поставщика автоматически обновляются способы доставки, проверьте настройки на вкладке "' +
             tabPriceProfiles.Caption + '" ', TMsgDlgType.mtWarning, [mbOK]);
end;

procedure TClientsF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
     exec OrderFileFormat_load
            @ClientID = :ClientID
           ,@Direction= 0

    exec EmployeeReliationload
           @ClientID = :ClientID
          ,@Direction= 0

    exec ProfilesCustomerLoad
           @ClientID = :ClientID
          ,@Direction= 0

   select *
     from vClientEdit
    where ClientID = :ClientID
  ''';
  UniMainModule.Query.ParamByName('ClientID').Value := FID;
  UniMainModule.Query.Open;

  // аудит
  edtID.Text           := UniMainModule.Query.FieldValues['UserID'];
  edtInDate.DateTime   := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime  := UniMainModule.Query.FieldValues['updDatetime'];
  edtBrief.Text        := UniMainModule.Query.FieldValues['Brief'];
  cbIsActive.Checked   := UniMainModule.Query.FieldValues['IsActive'];
  edtTaxes.Value       := UniMainModule.Query.FieldByName('Taxes').AsFloat; // налоги
  cbSuppliers.KeyValue := UniMainModule.Query.FieldValues['SuppliersID'];
  cbResponseType.ItemIndex       := UniMainModule.Query.FieldByName('ResponseType').AsInteger;
  cbNotificationMethod.ItemIndex := UniMainModule.Query.FieldByName('NotificationMethod').AsInteger;
  edtNotificationAddress.Text    := UniMainModule.Query.FieldByName('NotificationAddress').AsString;
  cbStatusRequiringPayment.Text  := UniMainModule.Query.FieldByName('StatusRequiringPayment').AsString;
  edtNotificationScript.Text     := UniMainModule.Query.FieldByName('NotificationScript').AsString;
  edtEmail.Text        := UniMainModule.Query.FieldByName('Email').AsString;
  edtPhone.Text        := UniMainModule.Query.FieldByName('Phone').AsString;
  edtContactPerson.Text:= UniMainModule.Query.FieldByName('ContactPerson').AsString;

  //
  cbClientType.Value   :=  UniMainModule.Query.FieldByName('ClientTypeID').AsString;

  ManagerGridRefresh;
end;

procedure TClientsF.DelimiterList;
begin
  qDelimiterList.Close;
  qDelimiterList.Open;
end;

procedure TClientsF.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TClientsF.ManagerEditEnabled;
begin
  actManagerEdit.Enabled := qManagerObjectType.Value = 0;
  actManagerDelete.Enabled := qManagerObjectType.Value = 0;
end;

procedure TClientsF.ManagerGridCellClick(Column: TUniDBGridColumn);
begin
  ManagerEditEnabled;
end;

procedure TClientsF.ManagerGridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  pmManager.Popup(X, Y, ManagerGrid);
end;

procedure TClientsF.ManagerGridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    qManager.IndexName := Column.FieldName+'_index_asc'
  else
    qManager.IndexName := Column.FieldName+'_index_des';
end;

procedure TClientsF.ManagerGridRefresh;
begin
  qManagerList.Close;
  qManagerList.Open;

  qManager.Close;
  qManager.Open;
end;

procedure TClientsF.pmManagerPopup(Sender: TObject);
begin
  ManagerEditEnabled;
end;

procedure TClientsF.PriceProfilesGridRefresh;
begin
  qProfilesCustomer.Close;
  qProfilesCustomer.Open;
end;

procedure TClientsF.ProfilesDeliveryList;
begin
  qProfilesDeliveryList.Close;
  qProfilesDeliveryList.ParamByName('SuppliersID').Value :=cbSuppliers.KeyValue;
  qProfilesDeliveryList.Open;
end;

procedure TClientsF.PromptMarginEditCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult = mrOK then
  begin
    PriceProfilesGridRefresh
  end;
end;

procedure TClientsF.qManagerAfterPost(DataSet: TDataSet);
begin
  ManagerGridRefresh
end;

procedure TClientsF.qManagerObjectTypeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender.AsInteger = 1) then
  begin
    Text := '<div class="grid-order-message" data-qtip="Права на группе пользователей"><i class="fa fa-users"></i></div> ';
  end
  else
    Text := '';
end;

procedure TClientsF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TClientsF.tabPriceProfilesBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
 // actPriceProfilesAdd.Enabled := cbClientType.Value = '3';
//  actPriceProfilesEdit.Enabled := cbClientType.Value = '3';
 // actPriceProfilesDelete.Enabled := cbClientType.Value = '3';
//
//  ProfilesCustomerGrid.ReadOnly :=  cbClientType.Value <> '3';
 // qProfilesCustomerProfilesDeliveryName.ReadOnly := cbClientType.Value <> '3';
 // qProfilesCustomerProfilesDeliveryID.ReadOnly := cbClientType.Value <> '3';
end;

procedure TClientsF.ProfilesCustomerGridCellContextClick(
  Column: TUniDBGridColumn; X, Y: Integer);
begin
  pmProfilesCustomer.Popup(X, Y, ProfilesCustomerGrid);
end;

procedure TClientsF.ProfilesCustomerGridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    qProfilesCustomer.IndexName := Column.FieldName+'_index_asc'
  else
    qProfilesCustomer.IndexName := Column.FieldName+'_index_des';
end;

procedure TClientsF.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF Release}
  Sql.Exec('delete pOrderFileFormat  from pOrderFileFormat  (rowlock) where spid = @@spid;' +
           'delete pClientReliation  from pClientReliation  (rowlock) where spid = @@spid;' +
           'delete pProfilesCustomer from pProfilesCustomer (rowlock) where spid = @@spid;', [], []);
  {$ENDIF}
end;

procedure TClientsF.UniFormCreate(Sender: TObject);
begin
  with Grid, Grid.JSInterface do
    if RowEditor then
      JSConfigPlugin('Ext.grid.plugin.RowEditing', ['saveBtnText', 'Сохранить', 'cancelBtnText', 'Отменить']);

  with ProfilesCustomerGrid, ProfilesCustomerGrid.JSInterface do
    if RowEditor then
      JSConfigPlugin('Ext.grid.plugin.RowEditing', ['saveBtnText', 'Сохранить', 'cancelBtnText', 'Отменить']);

  with ManagerGrid, ManagerGrid.JSInterface do
    if RowEditor then
      JSConfigPlugin('Ext.grid.plugin.RowEditing', ['saveBtnText', 'Сохранить', 'cancelBtnText', 'Отменить'])
end;

procedure TClientsF.UniFormShow(Sender: TObject);
begin
 // edtBrief.ReadOnly:= FAction <> acInsert;
  fsAudit.Visible:= FAction <> acInsert;
  pcCommon.ActivePage := tabHome;

  ComboBoxFill(cbClientType,   ' select ClientTypeID as ID, Name from tClientType (nolock) ');

  ComboBoxFill(cbStatusRequiringPayment,   ' select distinct SearchBrief as name, SearchID as ID from tNodes (nolock) where Type = 0 and SearchID <> 8 order by ID ');

  ComboBoxFill(cbResponseType,   ' select Brief Name from tProperty (nolock)  where ObjectTypeID = 13 order by PropertyID ');

  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
      edtInDate.Text := '';
      edtUpdDate.Text := '';
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' Сохранить';
    acDelete:
      btnOk.Caption := ' Удалить';
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption   := ' Выполнить';
  end;

  qSuppliers.Close;
  qSuppliers.Open;

  GridExt.SortColumnCreate(ProfilesCustomerGrid);//(qPriceProfiles);
  GridExt.SortColumnCreate(ManagerGrid);//(qManager);

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  end;

  Self.Caption := 'Клиент: ' + edtBrief.Text;

  ProfilesDeliveryList; // способ доставки
  DelimiterList;
  PriceProfilesGridRefresh; // профили выгрузки/загрузки
  ManagerGridRefresh;

  Query.Close;
  Query.ParamByName('ClientID').AsInteger := FID;
  Query.Open;
end;

end.
