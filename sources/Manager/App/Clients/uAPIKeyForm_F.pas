unit uAPIKeyForm_F;

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
  UniFSCombobox, Vcl.ExtCtrls, uniSpinEdit;

type
  TAPIKeyForm_F = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    ImageList16: TUniImageList;
    pcCommon: TUniPageControl;
    tabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    lblName: TUniLabel;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniEdit1: TUniEdit;
    UniLabel4: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function APIKeyForm_F: TAPIKeyForm_F;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar;

function APIKeyForm_F: TAPIKeyForm_F;
begin
  Result := TAPIKeyForm_F(UniMainModule.GetFormInstance(TAPIKeyForm_F));
end;

{ TUserF }

procedure TAPIKeyForm_F.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TAPIKeyForm_F.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert:
//    begin
//      sqltext :=' declare @R           int                     '+
//                '        ,@SuppliersID numeric(18, 0)          '+
//                '                                              '+
//                ' exec @r = SupplierInsert                     '+
//                '             @SuppliersID  = @SuppliersID out '+
//                '            ,@Brief        = :Brief           '+
//                '            ,@Name         = :Name            '+
//                '            ,@emexUsername = :emexUsername    '+
//                '            ,@emexPassword = :emexPassword    '+
//                '            ,@Discount     = :Discount        '+
//                '            ,@Commission   = :Commission      '+
//                '            ,@ExtraKurs    = :ExtraKurs       '+
//                '   '+
//                '   '+
//                ' select @r as retcode      ';
//
//      Sql.Open(sqltext,
//               ['Brief','Name','emexUsername', 'emexPassword', 'Discount', 'Commission', 'ExtraKurs'],
//               [edtBrief.Text,
//               '',
//               edtEmexUsername.text,
//               edtEmexPassword.text,
//               edtDiscount.Value,
//               edtCommission.Value,
//               edtExtraKurs.Value
//               ]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//
//    end;
//    acUpdate:
//    begin
//      sqltext :=' declare @R      int                        '+
//                '                                            '+
//                ' exec @r = SupplierUpdate                   '+
//                '             @SuppliersID   = :SuppliersID  '+
//                '            ,@Brief         = :Brief        '+
//                '            ,@Name          = :Name         '+
//                '            ,@emexUsername  = :emexUsername '+
//                '            ,@emexPassword  = :emexPassword '+
//                '            ,@Discount      = :Discount     '+
//                '            ,@Commission    = :Commission   '+
//                '            ,@ExtraKurs     = :ExtraKurs    '+
//                '   '+
//                '   '+
//                ' select @r as retcode      ';
//
//      Sql.Open(sqltext,
//               ['Brief','Name','emexUsername', 'emexPassword', 'Discount', 'Commission', 'ExtraKurs', 'SuppliersID'],
//               [edtBrief.Text,
//               '',
//               edtEmexUsername.text,
//               edtEmexPassword.text,
//               edtDiscount.Value,
//               edtCommission.Value,
//               edtExtraKurs.Value,
//               FID
//               ]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//    end;
//    acDelete:
//    begin
//      sqltext :=  ' declare @R      int                 '+
//                  '                                     '+
//                  ' exec @r = SupplierDelete            '+
//                  '         @SuppliersID = :SuppliersID '+
//                  '                                     '+
//                  ' select @r as retcode                '+
//                  ' ';
//
//      Sql.Open(sqltext, ['SuppliersID'], [FID]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//    end;
//  end;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TAPIKeyForm_F.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *  '+
                                  '   from tSuppliers (nolock) '+
                                  '  where SuppliersID = :SuppliersID '+
                                  ' ';
  UniMainModule.Query.ParamByName('SuppliersID').Value := FID;
  UniMainModule.Query.Open;

  edtBrief.Text:= UniMainModule.Query.FieldByName('Brief').AsString;
//
//  edtDiscount.Value:= UniMainModule.Query.FieldByName('Discount').AsFloat;
//  edtCommission.Value:= UniMainModule.Query.FieldByName('Commission').AsFloat;
//  edtExtraKurs.Value:= UniMainModule.Query.FieldByName('ExtraKurs').AsFloat;
//
//  edtEmexUsername.Text:= UniMainModule.Query.FieldByName('emexUsername').AsString;
//  edtEmexPassword.Text:= UniMainModule.Query.FieldByName('emexPassword').AsString;

  // аудит
  edtID.Text         := UniMainModule.Query.FieldValues['UserID'];
  edtInDate.DateTime := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime:= UniMainModule.Query.FieldValues['updDatetime'];
end;

procedure TAPIKeyForm_F.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TAPIKeyForm_F.UniFormCreate(Sender: TObject);
begin
 // with Grid, Grid.JSInterface do
 //   if RowEditor then
 //     JSConfigPlugin('Ext.grid.plugin.RowEditing', ['saveBtnText', 'Сохранить', 'cancelBtnText', 'Отменить'])
end;

procedure TAPIKeyForm_F.UniFormShow(Sender: TObject);
begin
  fsAudit.Visible:= FAction <> acInsert;

  pcCommon.ActivePage := tabCommon;

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

  Self.Caption := 'API Ключ: ' + edtBrief.Text;


end;

end.
