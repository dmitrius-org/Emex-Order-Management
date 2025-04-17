unit uEmployeeParametersF;

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
  uniMainMenu, uniMultiItem, uniComboBox, uniWidgets, uniDBComboBox,
  uniDBLookupComboBox, Vcl.Menus, uniMemo, UniFSCombobox;

type
  TEmployeeParametersF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    pcCommon: TUniPageControl;
    tabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    lblName: TUniLabel;
    tabAudit: TUniTabSheet;
    Query: TFDQuery;
    ImageList16: TUniImageList;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    QueryID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryEmployeeID: TFMTBCDField;
    QueryClientBrief: TWideStringField;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    edtProcessedVal: TUniNumberEdit;
    edtIncorrectVal: TUniNumberEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    edtConfirmedVal: TUniNumberEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    FClientID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();
    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ClientID: Integer read FClientID write FClientID;
    property ID: Integer read FID write FID;
  end;

function EmployeeParametersF: TEmployeeParametersF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar, uUtils.Controll;

function EmployeeParametersF: TEmployeeParametersF;
begin
  Result := TEmployeeParametersF(UniMainModule.GetFormInstance(TEmployeeParametersF));
end;

{ TBalanceAddF }

procedure TEmployeeParametersF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TEmployeeParametersF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  DataCheck;

  if RetVal.Code = 0 then
  case FAction of
    acUpdate:
    begin
      sqltext :='''
                 declare @R           int

                  EXEC @r = EmployeeParametersUpdate
                      @EmployeeID = :EmployeeID,
                      @ProcessedVal = :ProcessedVal,
                      @IncorrectVal = :IncorrectVal,
                      @ConfirmedVal = :ConfirmedVal

                 select @r as retcode
      ''';

      Sql.Open(sqltext,
               ['EmployeeID','ProcessedVal','IncorrectVal','ConfirmedVal'],
               [FID
               ,edtProcessedVal.value
               ,edtIncorrectVal.value
               ,edtConfirmedVal.value
               ]);

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

procedure TEmployeeParametersF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin

//      if cbClient.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := 'Поле [Клиент] обязательно к заполнению!';
//        cbClient.SetFocus;
//        Exit();
//      end;

    end;
  end;
end;

procedure TEmployeeParametersF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := '''
    select *
      from vEmployeeParameters
     where EmployeeID = :EmployeeID
  ''';
  UniMainModule.Query.ParamByName('EmployeeID').Value := FID;
  UniMainModule.Query.Open;

  if UniMainModule.Query.RecordCount > 0 then
  begin
    edtProcessedVal.Value := UniMainModule.Query.FieldByName('ProcessedVal').AsFloat;
    edtIncorrectVal.Value := UniMainModule.Query.FieldByName('IncorrectVal').AsFloat;
    edtConfirmedVal.Value := UniMainModule.Query.FieldByName('ConfirmedVal').AsFloat;

    edtID.Text         := UniMainModule.Query.FieldByName('UserID').AsString;
    edtInDate.DateTime := UniMainModule.Query.FieldByName('inDateTime').asDatetime;
    edtUpdDate.DateTime:= UniMainModule.Query.FieldByName('updDateTime').asDatetime;
  end;

  tabAudit.TabVisible:= UniMainModule.Query.RecordCount > 0;
end;

procedure TEmployeeParametersF.edtAmountKeyPress(Sender: TObject; var Key: Char);
begin
//  // Если нажата запятая, заменяем её на точку
//  if Key = '.' then
//  begin
//    Key := ',';
//  end;
end;

procedure TEmployeeParametersF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TEmployeeParametersF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption   := ' Сохранить';
      edtInDate.Text  := '';
      edtUpdDate.Text := '';
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' Сохранить';
    acDelete:
    begin
      btnOk.Caption := ' Удалить';
    end;
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption   := ' Выполнить';
  end;

  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      DataLoad;
    end
  else
    //
  end;

end;

end.
