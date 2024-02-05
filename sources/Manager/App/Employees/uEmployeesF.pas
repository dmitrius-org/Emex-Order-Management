unit uEmployeesF;

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
  uniDBLookupComboBox, Vcl.Menus;

type
  TEmployeesF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    pcCommon: TUniPageControl;
    tabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    lblName: TUniLabel;
    tabClients: TUniTabSheet;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    Query: TFDQuery;
    DataSource: TDataSource;
    UpdateSQL: TFDUpdateSQL;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    ImageList16: TUniImageList;
    UniPanel1: TUniPanel;
    Grid: TUniDBGrid;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    QueryID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryEmployeeID: TFMTBCDField;
    QueryClientBrief: TWideStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    LookupClients: TUniDBLookupComboBox;
    qClients: TFDQuery;
    dsClients: TDataSource;
    qClientsClientID: TFMTBCDField;
    qClientsBrief: TWideStringField;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure QueryAfterInsert(DataSet: TDataSet);
    procedure QueryAfterPost(DataSet: TDataSet);
    procedure QueryAfterRowRequest(DataSet: TFDDataSet);
    procedure QueryNewRecord(DataSet: TDataSet);
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
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

    procedure ClientsDataRefresh();
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function EmployeesF: TEmployeesF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar, uLogger;

function EmployeesF: TEmployeesF;
begin
  Result := TEmployeesF(UniMainModule.GetFormInstance(TEmployeesF));
end;

{ TEmployeesF }

procedure TEmployeesF.actAddExecute(Sender: TObject);
begin
  qClients.Refresh;

  Query.Insert;
  Query.FieldByName('EmployeeID').AsInteger := FID;

end;

procedure TEmployeesF.actDeleteExecute(Sender: TObject);
begin
  qClients.Refresh;
  Query.Delete;
end;

procedure TEmployeesF.actEditExecute(Sender: TObject);
begin
  qClients.Refresh;
  Query.Edit;
end;

procedure TEmployeesF.actRefreshAllExecute(Sender: TObject);
begin
  ClientsDataRefresh;
end;

procedure TEmployeesF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TEmployeesF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  DataCheck;

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      sqltext :=' declare @R           int                     '+
                '        ,@EmployeeID numeric(18, 0)           '+
                '                                              '+
                ' exec @r = EmployeeInsert                     '+
                '             @EmployeeID   = @EmployeeID out  '+
                '            ,@Brief        = :Brief           '+
                '            ,@Name         = :Name            '+
                '                                              '+
                ' select @r as retcode      ';

      Sql.Open(sqltext,
               ['Brief','Name'],
               [edtBrief.Text,
               ''
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    end;
    acUpdate:
    begin
      sqltext :=' declare @R      int                      '+
                '                                          '+
                ' exec @r = EmployeeUpdate                 '+
                '             @EmployeeID   = :EmployeeID  '+
                '            ,@Brief        = :Brief       '+
                '            ,@Name         = :Name        '+
                '                                          '+
                ' select @r as retcode      ';

      Sql.Open(sqltext,
               ['Brief','Name', 'EmployeeID'],
               [edtBrief.Text,
               '',
               FID
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      sqltext :=  ' declare @R      int                 '+
                  '                                     '+
                  ' exec @r = EmployeeDelete            '+
                  '         @EmployeeID = :EmployeeID   '+
                  '                                     '+
                  ' select @r as retcode                '+
                  ' ';

      Sql.Open(sqltext, ['EmployeeID'], [FID]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    //Audit.Add(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TEmployeesF.ClientsDataRefresh;
begin
  qClients.Close;
  qClients.Open;

  Query.Close;
  Query.Open;
end;

procedure TEmployeesF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательна к заполнению!';
        edtBrief.SetFocus;
        Exit();
      end;
    end;
  end;
end;

procedure TEmployeesF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *  '+
                                  '   from tEmployees (nolock) '+
                                  '  where EmployeeID = :EmployeeID '+
                                  ' ';
  UniMainModule.Query.ParamByName('EmployeeID').Value := FID;
  UniMainModule.Query.Open;

  // аудит
  edtID.Text         := UniMainModule.Query.FieldValues['UserID'];
  edtInDate.DateTime := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime:= UniMainModule.Query.FieldValues['updDatetime'];

  edtBrief.Text:= UniMainModule.Query.FieldValues['Brief'];

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' exec ClientReliationload @LinkID = :LinkID, @LinkType=5, @Direction = 0 ';
  UniMainModule.Query.ParamByName('LinkID').Value := FID;
  UniMainModule.Query.ExecSQL;
end;

procedure TEmployeesF.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
    PopupMenu.Popup(X, Y, Grid);
end;

procedure TEmployeesF.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TEmployeesF.QueryAfterInsert(DataSet: TDataSet);
begin
//  Logger.Info('QueryAfterInsert');
end;

procedure TEmployeesF.QueryAfterPost(DataSet: TDataSet);
begin
//  Logger.Info('QueryAfterPost');
//  ClientsDataRefresh
  Query.Refresh;
end;


procedure TEmployeesF.QueryAfterRowRequest(DataSet: TFDDataSet);
begin
//   Logger.Info('QueryAfterRowRequest');
end;

procedure TEmployeesF.QueryNewRecord(DataSet: TDataSet);
begin
// Logger.Info('QueryNewRecord');
end;

procedure TEmployeesF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TEmployeesF.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF Release}
  Sql.Exec('delete pClientReliation from pClientReliation (rowlock) where spid = @@spid', [], []);
  {$ENDIF}

end;

procedure TEmployeesF.UniFormShow(Sender: TObject);
begin
  //edtBrief.ReadOnly:= FAction <> acInsert;
  fsAudit.Visible:= FAction <> acInsert;

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
  else
    //
  end;

  Self.Caption := 'Сотрудник: ' + edtBrief.Text;

  ClientsDataRefresh();
end;

end.
