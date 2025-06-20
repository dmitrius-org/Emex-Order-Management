﻿unit uSuppliersF;

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
  uniMainMenu, uniMultiItem, uniComboBox, Vcl.Menus, uniDBComboBox,
  uUniExComboBox, Vcl.ExtCtrls, uniSpinEdit, uUniExComboBoxHelper,
  uSuppliersPriceT;

type
  TSuppliersF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    pcCommon: TUniPageControl;
    tabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    lblName: TUniLabel;
    tabDelivery: TUniTabSheet;
    tabSuppliers: TUniTabSheet;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    edtEmexUsername: TUniEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    DataSource: TDataSource;
    UpdateSQL: TFDUpdateSQL;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel1: TUniPanel;
    Grid: TUniDBGrid;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    qDelivery: TFDQuery;
    dsDelivery: TDataSource;
    qDeliveryProfilesDeliveryID: TFDAutoIncField;
    qDeliverySuppliersID: TFMTBCDField;
    qDeliveryName: TStringField;
    qDeliveryWeightKG: TFloatField;
    qDeliveryVolumeKG: TFloatField;
    qDeliveryPDelivery1: TIntegerField;
    qDeliveryPDelivery2: TIntegerField;
    qDeliveryPDelivery3: TIntegerField;
    qDeliveryVolumeKG_Rate1: TBCDField;
    qDeliveryVolumeKG_Rate2: TBCDField;
    qDeliveryVolumeKG_Rate3: TBCDField;
    qDeliveryVolumeKG_Rate4: TBCDField;
    qDeliveryDestinationLogo: TWideStringField;
    qDeliveryRestrictions: TBooleanField;
    qDeliveryIsActive: TBooleanField;
    qDeliveryID: TFDAutoIncField;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    UniHiddenPanel3: TUniHiddenPanel;
    qDeliveryDenVyleta: TWideStringField;
    cbDenVileta: TUniCheckComboBox;
    qDeliveryDelivery: TIntegerField;
    qDeliveryImage: TWideStringField;
    cbImage: TUniComboBox;
    qDeliveryImageHelp: TWideStringField;
    edtDiscount: TUniNumberEdit;
    UniLabel6: TUniLabel;
    edtCommission: TUniNumberEdit;
    edtExtraKurs: TUniNumberEdit;
    UniLabel7: TUniLabel;
    UniLabel8: TUniLabel;
    edtEmexPassword: TUniEdit;
    qDeliveryisMyDelivery: TBooleanField;
    qDeliveryisIgnore: TBooleanField;
    qDeliveryFragile: TFloatField;
    qDeliveryBrief: TWideStringField;
    edtDelivery: TUniSpinEdit;
    lblGroupName: TUniLabel;
    UniLabel10: TUniLabel;
    edtApiAddress: TUniEdit;
    edtGroupName: TUniExComboBox;
    tabPrices: TUniTabSheet;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure qDeliveryAfterInsert(DataSet: TDataSet);
    procedure qDeliveryAfterDelete(DataSet: TDataSet);
    procedure qDeliveryAfterEdit(DataSet: TDataSet);
    procedure qDeliveryAfterPost(DataSet: TDataSet);
    procedure UniFormCreate(Sender: TObject);
    procedure tabPricesBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();
    procedure DeliveryDataLoad();

    procedure RefreshDeliveryMenu;

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function SuppliersF: TSuppliersF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar;

function SuppliersF: TSuppliersF;
begin
  Result := TSuppliersF(UniMainModule.GetFormInstance(TSuppliersF));
end;

{ TUserF }

procedure TSuppliersF.actAddExecute(Sender: TObject);
begin
  qDelivery.Insert;
  qDelivery.FieldByName('SuppliersID').AsInteger := FID;
end;

procedure TSuppliersF.actDeleteExecute(Sender: TObject);
begin
 // FAction:=TFormAction.acDelete;
  qDelivery.Delete;
end;

procedure TSuppliersF.actEditExecute(Sender: TObject);
begin
 // FAction:=TFormAction.acUpdate;
  qDelivery.Edit;
end;

procedure TSuppliersF.actRefreshAllExecute(Sender: TObject);
begin
  DeliveryDataLoad;
end;

procedure TSuppliersF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSuppliersF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  DataCheck;

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      sqltext :='''
                 declare @R           int
                        ,@SuppliersID numeric(18, 0)

                 exec @r = SupplierInsert
                             @SuppliersID  = @SuppliersID out
                            ,@Brief        = :Brief
                            ,@Name         = :Name
                            ,@emexUsername = :emexUsername
                            ,@emexPassword = :emexPassword
                            ,@Discount     = :Discount
                            ,@Commission   = :Commission
                            ,@ExtraKurs    = :ExtraKurs
                            ,@GroupName    = :GroupName
                            ,@ApiAddress   = :ApiAddress

                 select @r as retcode
      ''';

      Sql.Open(sqltext,
               ['Brief','Name','emexUsername', 'emexPassword', 'Discount',
                'Commission', 'ExtraKurs', 'GroupName', 'ApiAddress'],
               [edtBrief.Text,
               '',
               edtEmexUsername.text,
               edtEmexPassword.text,
               edtDiscount.Value,
               edtCommission.Value,
               edtExtraKurs.Value,
               edtGroupName.Text,
               edtApiAddress.text
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    end;
    acUpdate:
    begin
      sqltext :='''
                declare @R      int

                 exec @r = SupplierUpdate
                             @SuppliersID   = :SuppliersID
                            ,@Brief         = :Brief
                            ,@Name          = :Name
                            ,@emexUsername  = :emexUsername
                            ,@emexPassword  = :emexPassword
                            ,@Discount      = :Discount
                            ,@Commission    = :Commission
                            ,@ExtraKurs     = :ExtraKurs
                            ,@GroupName     = :GroupName
                            ,@ApiAddress    = :ApiAddress

                 select @r as retcode
     ''';

      Sql.Open(sqltext,
               ['Brief','Name','emexUsername', 'emexPassword', 'Discount',
                'Commission', 'ExtraKurs', 'SuppliersID', 'GroupName', 'ApiAddress'],
               [edtBrief.Text,
               '',
               edtEmexUsername.text,
               edtEmexPassword.text,
               edtDiscount.Value,
               edtCommission.Value,
               edtExtraKurs.Value,
               FID,
               edtGroupName.Text,
               edtApiAddress.text
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      sqltext :=  '''
                   declare @R      int

                   exec @r = SupplierDelete @SuppliersID = :SuppliersID

                   select @r as retcode
      ''';

      Sql.Open(sqltext, ['SuppliersID'], [FID]);

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

procedure TSuppliersF.DataCheck;
begin
 RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
        edtBrief.SetFocus;
        Exit();
      end
      else if edtGroupName.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Группа поставщиков] обязательно к заполнению!';
        edtGroupName.SetFocus;
        Exit();
      end
    end;
  end;
end;

procedure TSuppliersF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
                                   select *
                                     from vSuppliers
                                    where SuppliersID = :SuppliersID
  ''';
  UniMainModule.Query.ParamByName('SuppliersID').Value := FID;
  UniMainModule.Query.Open;

  edtBrief.Text:= UniMainModule.Query.FieldByName('Brief').AsString;

  edtDiscount.Value:= UniMainModule.Query.FieldByName('Discount').AsFloat;
  edtCommission.Value:= UniMainModule.Query.FieldByName('Commission').AsFloat;
  edtExtraKurs.Value:= UniMainModule.Query.FieldByName('ExtraKurs').AsFloat;

  edtEmexUsername.Text:= UniMainModule.Query.FieldByName('emexUsername').AsString;
  edtEmexPassword.Text:= UniMainModule.Query.FieldByName('emexPassword').AsString;
  edtGroupName.Text:= UniMainModule.Query.FieldByName('GroupName').AsString;
  edtApiAddress.Text:= UniMainModule.Query.FieldByName('ApiAddress').AsString;


  // аудит
  edtID.Text         := UniMainModule.Query.FieldValues['UserID'];
  edtInDate.DateTime := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime:= UniMainModule.Query.FieldValues['updDatetime'];
end;

procedure TSuppliersF.DeliveryDataLoad;
begin
  qDelivery.Close;
  //qDelivery.ParamByName('SuppliersID').AsInteger := FID;
  qDelivery.Open;

  RefreshDeliveryMenu;
end;

procedure TSuppliersF.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TSuppliersF.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TSuppliersF.qDeliveryAfterDelete(DataSet: TDataSet);
begin
  RefreshDeliveryMenu
end;

procedure TSuppliersF.qDeliveryAfterEdit(DataSet: TDataSet);
begin
  RefreshDeliveryMenu
end;

procedure TSuppliersF.qDeliveryAfterInsert(DataSet: TDataSet);
begin
  RefreshDeliveryMenu
end;

procedure TSuppliersF.qDeliveryAfterPost(DataSet: TDataSet);
begin
  RefreshDeliveryMenu;
end;

procedure TSuppliersF.RefreshDeliveryMenu;
begin
  actEdit.Enabled := (qDelivery.RecordCount >0);
  actDelete.Enabled := (qDelivery.RecordCount >0);
end;

procedure TSuppliersF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TSuppliersF.tabPricesBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
//  var SuppliersPriceT:TSuppliersPriceT;
begin
  if not Assigned(SuppliersPriceT) then
  begin
    SuppliersPriceT :=  TSuppliersPriceT.Create(Self);
  end;

  SuppliersPriceT.Align := alClient;
  SuppliersPriceT.Parent := tabPrices;

  SuppliersPriceT.DataRefresh();

end;

procedure TSuppliersF.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(SuppliersPriceT);

  Sql.Exec('exec SupplierPTableClear', [], []);
end;

procedure TSuppliersF.UniFormCreate(Sender: TObject);
begin
  with Grid, Grid.JSInterface do
    if RowEditor then
      JSConfigPlugin('Ext.grid.plugin.RowEditing', ['saveBtnText', 'Сохранить', 'cancelBtnText', 'Отменить'])
end;

procedure TSuppliersF.UniFormShow(Sender: TObject);
begin
  fsAudit.Visible:= FAction <> acInsert;

  pcCommon.ActivePage := tabCommon;

  edtGroupName.FillFromSQL('select Brief ID, Brief Name  from tProperty (nolock) where ObjectTypeID = 14');

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

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  end;

  Self.Caption := 'Поставщик: ' + edtBrief.Text;

  Sql.Exec('exec SupplierDeliveryProfilesLoad @SuppliersID = :SuppliersID', ['SuppliersID'], [FID]);
  Sql.Exec('exec SupplierPricesLoad @SuppliersID = :SuppliersID', ['SuppliersID'], [FID]);

  DeliveryDataLoad;
end;

end.
