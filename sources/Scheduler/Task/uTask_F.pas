unit uTask_F;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uCommonType, uniDateTimePicker, uniRadioGroup,
  uniLabel, uniEdit, uniPanel, uniFieldSet, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniCheckBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox, uniSpinEdit, uniGroupBox, uniPageControl,
  uniMemo, uniToolBar, uniBasicGrid, uniDBGrid, Vcl.Menus, uniMainMenu,
  uniImageList, System.Actions, Vcl.ActnList;

type
  TTask_F = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    tabCommon: TUniFieldContainer;
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    lblBruef: TUniLabel;
    UniLabel1: TUniLabel;
    edtDateBegin: TUniDateTimePicker;
    UniLabel2: TUniLabel;
    ebtIsActive: TUniCheckBox;
    FDQueryAction: TFDQuery;
    DataSourceAction: TDataSource;
    pnlInteval: TUniPanel;
    lblStartTime: TUniLabel;
    edtTimeBegin: TUniDateTimePicker;
    edtTimeEnd: TUniDateTimePicker;
    MainPage: TUniPageControl;
    MainSheet: TUniTabSheet;
    AuditSheet: TUniTabSheet;
    TaskPage: TUniTabSheet;
    UniPanel3: TUniPanel;
    ActionGrid: TUniDBGrid;
    ActionTool: TUniToolBar;
    UniToolButton7: TUniToolButton;
    UniToolButton8: TUniToolButton;
    UniToolButton9: TUniToolButton;
    ActionList: TUniActionList;
    actAddActionProc: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    ILAction16: TUniImageList;
    pmTaskAction: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    FDQueryActionID: TFMTBCDField;
    FDQueryActionBrief: TWideStringField;
    FDQueryActionIsActive: TBooleanField;
    FDQueryActionTaskTypeName: TStringField;
    pmTaskActionAdd: TUniPopupMenu;
    N6: TUniMenuItem;
    FDQueryActionTaskType: TIntegerField;
    FDQueryActionNumber: TIntegerField;
    actAddActionBat: TAction;
    actAddActionSQL: TAction;
    Bat1: TUniMenuItem;
    SQL1: TUniMenuItem;
    pnlPeriodType: TUniContainerPanel;
    edtPeriodType: TUniRadioGroup;
    PeriodType1: TUniPanel;
    edtTimePeriod: TUniDateTimePicker;
    UniLabel3: TUniLabel;
    edtDayPeriod: TUniSpinEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniContainerPanel1: TUniContainerPanel;
    UniLabel6: TUniLabel;
    edtID: TUniEdit;
    UniLabel7: TUniLabel;
    edtInDateTime: TUniDateTimePicker;
    N7: TUniMenuItem;
    BAT2: TUniMenuItem;
    SQL2: TUniMenuItem;
    FDUpdateSQL: TFDUpdateSQL;
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtPeriodTypeClick(Sender: TObject);
    procedure actAddActionProcExecute(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure actEditExecute(Sender: TObject);
    procedure ActionGridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actDeleteExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddActionSQLExecute(Sender: TObject);
    procedure actAddActionBatExecute(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;

    FFlag:Integer;
    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

    procedure SetPeriodTypeProperty();

    procedure ActionGridCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function Task_F: TTask_F;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uLogger, uSqlUtils, uUtils.Varriant, uMainVar,
  uTaskProcedure_F, uTaskSQL_F, uTaskBat_F;

function Task_F: TTask_F;
begin
  Result := TTask_F(UniMainModule.GetFormInstance(TTask_F));
end;

{ TTask_F }
procedure TTask_F.actAddActionBatExecute(Sender: TObject);
begin
  TaskBAT_F.FormAction := TFormAction.acInsert;
  TaskBAT_F.ShowModal(ActionGridCallBack);
end;

procedure TTask_F.actAddActionProcExecute(Sender: TObject);
begin
  TaskProcedure_F.FormAction := TFormAction.acInsert;
  TaskProcedure_F.ShowModal(ActionGridCallBack);
end;

procedure TTask_F.actAddActionSQLExecute(Sender: TObject);
begin
  TaskSQL_F.FormAction := TFormAction.acInsert;
  TaskSQL_F.ShowModal(ActionGridCallBack);
end;

procedure TTask_F.actDeleteExecute(Sender: TObject);
begin
  if FDQueryAction.FieldByName('TaskType').AsInteger = 0 then
  begin
    TaskProcedure_F.FormAction := TFormAction.acDelete;
    TaskProcedure_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskProcedure_F.ShowModal(ActionGridCallBack);
  end
  else if FDQueryAction.FieldByName('TaskType').AsInteger = 1 then
  begin
    TaskBAT_F.FormAction := TFormAction.acDelete;
    TaskBAT_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskBAT_F.ShowModal(ActionGridCallBack);
  end
  else if FDQueryAction.FieldByName('TaskType').AsInteger = 2 then
  begin
    TaskSQL_F.FormAction := TFormAction.acDelete;
    TaskSQL_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskSQL_F.ShowModal(ActionGridCallBack);
  end;
end;

procedure TTask_F.actEditExecute(Sender: TObject);
begin
  if FDQueryAction.FieldByName('TaskType').AsInteger = 0 then
  begin
    TaskProcedure_F.FormAction := TFormAction.acUpdate;
    TaskProcedure_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskProcedure_F.ShowModal(ActionGridCallBack);
  end
  else if FDQueryAction.FieldByName('TaskType').AsInteger = 1 then
  begin
    TaskBAT_F.FormAction := TFormAction.acUpdate;
    TaskBAT_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskBAT_F.ShowModal(ActionGridCallBack);
  end
  else if FDQueryAction.FieldByName('TaskType').AsInteger = 2 then
  begin
    TaskSQL_F.FormAction := TFormAction.acUpdate;
    TaskSQL_F.ID         :=  FDQueryAction.FieldByName('ID').AsInteger;
    TaskSQL_F.ShowModal(ActionGridCallBack);
  end;
end;

procedure TTask_F.ActionGridCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  FDQueryAction.Refresh();
end;

procedure TTask_F.ActionGridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
begin
  pmTaskAction.Popup(x, y, ActionGrid);
end;

procedure TTask_F.actRefreshAllExecute(Sender: TObject);
begin
  FDQueryAction.Refresh();
end;

procedure TTask_F.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TTask_F.btnOkClick(Sender: TObject);
 var sqltext: string;
       Field: string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
   case FAction of
    acInsert:
    begin
      sqltext :=' declare @R      int                 '+
                '        ,@TaskID numeric(18, 0)      '+
                '                                     '+
                ' exec @r = TaskInsert                '+
                '             @TaskID    = @TaskID out'+
                '            ,@Brief     = :Brief     '+
                '            ,@Name      = :Name      '+
                '            ,@PeriodType= :PeriodType'+
                '            ,@DateBegin = :DateBegin '+
                '            ,@IsActive  = :IsActive  '+
                '            ,@TimeBegin = :TimeBegin '+
                '            ,@TimeEnd   = :TimeEnd   '+
                '            ,@DayPeriod = :DayPeriod '+
                '            ,@TimePeriod= :TimePeriod'+
                '            ,@Flag      = :Flag      '+
                '                                     '+
                ' select @r      as retcode,          '+
                '        @TaskID as TaskID ';

      Sql.Open(sqltext,
               ['Brief','Name', 'PeriodType', 'DateBegin', 'IsActive', 'TimeBegin', 'TimeEnd',  'DayPeriod', 'TimePeriod', 'Flag'],
               [edtBrief.Text,
                edtName.Text,
                edtPeriodType.ItemIndex,
                edtDateBegin.DateTime,
                ebtIsActive.Checked,
                edtTimeBegin.DateTime,
                edtTimeEnd.DateTime,
                edtDayPeriod.Value,
                edtTimePeriod.DateTime,
                FFlag
                ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('TaskID').Value;

    end;
    acUpdate:
    begin
      sqltext :=' declare @R      int                 '+
                '                                     '+
                ' exec @r = TaskUpdate                '+
                '             @TaskID    = :TaskID    '+
                '            ,@Brief     = :Brief     '+
                '            ,@Name      = :Name      '+
                '            ,@PeriodType= :PeriodType'+
                '            ,@DateBegin = :DateBegin '+
                '            ,@IsActive  = :IsActive  '+
                '            ,@TimeBegin = :TimeBegin '+
                '            ,@TimeEnd   = :TimeEnd   '+
                '            ,@DayPeriod = :DayPeriod '+
                '            ,@TimePeriod= :TimePeriod'+
                '            ,@Flag      = :Flag      '+
                '                                     '+
                ' select @r as retcode                ';

      Sql.Open(sqltext,
               ['TaskID', 'Brief','Name','PeriodType', 'DateBegin',
                'IsActive', 'TimeBegin', 'TimeEnd',
                'DayPeriod', 'TimePeriod', 'Flag'],
               [FID,
                edtBrief.Text,
                edtName.Text,
                edtPeriodType.ItemIndex,
                edtDateBegin.DateTime,
                ebtIsActive.Checked,
                edtTimeBegin.DateTime,
                edtTimeEnd.DateTime,
                edtDayPeriod.Value,
                edtTimePeriod.DateTime,
                FFlag
                ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = TaskDelete               '+
                                      '             @TaskID   = :TaskID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('TaskID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
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

procedure TTask_F.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Сокращение] обязательна к заполнению!'; Exit();
      end
      else if edtName.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательна к заполнению!'; Exit();
      end
      else if edtPeriodType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Период выполнения] обязателена к заполнению!'; Exit();
      end;
    end;
  end;
end;

procedure TTask_F.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := 'exec TaskActionLoad      '+
                                  '        @TaskID = :TaskID'+
                                  '       ,@Direction = 0   '+
                                  '               '+
                                  ' select *                '+
                                  '   from tTask (nolock)   '+
                                  '  where TaskID = :TaskID '+
                                  ' ';
  UniMainModule.Query.ParamByName('TaskID').Value := FID;
  UniMainModule.Query.Open;

  edtBrief.Text:= UniMainModule.Query.FieldByName('Brief').AsString;
  edtName.Text:= UniMainModule.Query.FieldByName('Name').AsString;
  edtDateBegin.DateTime:= UniMainModule.Query.FieldByName('DateBegin').AsDateTime;
  edtPeriodType.ItemIndex:= UniMainModule.Query.FieldByName('PeriodType').AsInteger;
  ebtIsActive.Checked:= UniMainModule.Query.FieldByName('IsActive').AsBoolean;
  edtTimeBegin.DateTime:= UniMainModule.Query.FieldByName('TimeBegin').AsDateTime;
  edtTimeEnd.DateTime:= UniMainModule.Query.FieldByName('TimeEnd').AsDateTime;
  edtTimePeriod.DateTime:= UniMainModule.Query.FieldByName('TimePeriod').AsDateTime;
  edtDayPeriod.Value:= UniMainModule.Query.FieldByName('DayPeriod').AsInteger;
  edtID.Text:= UniMainModule.Query.FieldByName('TaskID').AsString;
  edtInDateTime.DateTime:= UniMainModule.Query.FieldByName('InDateTime').AsDateTime;

  SetPeriodTypeProperty;
end;

procedure TTask_F.edtPeriodTypeClick(Sender: TObject);
begin
   SetPeriodTypeProperty
end;

procedure TTask_F.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TTask_F.SetPeriodTypeProperty; // период выполнения
begin
  PeriodType1.Visible:=False;

  case edtPeriodType.ItemIndex of
    Integer(tTaskPeriod.tpSelect):
    begin
      lblStartTime.Text := 'Интервал времени в течении дня:';
      PeriodType1.Visible:= True;
      pnlInteval.Visible := True;
    end;
  else
   // lblStartTime.Text := 'Время выполнения:';
    PeriodType1.Visible:= False;
    pnlInteval.Visible := False;
  end;
end;


procedure TTask_F.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDQueryAction.Close;
  {$IFDEF Release}
    Sql.Exec('delete pTaskActions  from pTaskActions  (rowlock) where spid = @@spid;', [], []);
  {$ENDIF}
end;

procedure TTask_F.UniFormShow(Sender: TObject);
begin
  MainPage.ActivePage := MainSheet;

  case FAction of
    acInsert, acReportCreate:
    begin
      Sql.Exec('delete pTaskActions  from pTaskActions  (rowlock) where spid = @@spid;', [], []);
      btnOk.Caption := ' Добавить';
      edtDateBegin.DateTime := Now();
      edtTimeBegin.Text := '00:00:00';
      edtTimeEnd.Text   := '23:59:59';

      edtTimeEnd.Text := '';
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' Сохранить';
    acDelete:
      btnOk.Caption := ' Удалить';
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption := ' Выполнить';
  end;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  end;

  FDQueryAction.Open();
end;

end.
