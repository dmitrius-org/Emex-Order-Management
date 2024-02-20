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
  uniMemo;

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
    edtPeriodType: TUniRadioGroup;
    edtDateBegin: TUniDateTimePicker;
    UniLabel2: TUniLabel;
    edtTaskType: TUniRadioGroup;
    ebtIsActive: TUniCheckBox;
    FDQuery: TFDQuery;
    DataSource: TDataSource;
    PeriodType1: TUniPanel;
    edtTimePeriod: TUniDateTimePicker;
    UniLabel3: TUniLabel;
    edtDayPeriod: TUniSpinEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    gbLink: TUniGroupBox;
    edtLinkID: TUniDBLookupComboBox;
    edtLink: TUniEdit;
    pnlInteval: TUniPanel;
    lblStartTime: TUniLabel;
    edtTimeBegin: TUniDateTimePicker;
    edtTimeEnd: TUniDateTimePicker;
    MainPage: TUniPageControl;
    MainSheet: TUniTabSheet;
    AuditSheet: TUniTabSheet;
    edtID: TUniEdit;
    UniLabel6: TUniLabel;
    edtInDateTime: TUniDateTimePicker;
    UniLabel7: TUniLabel;
    cbExecuteHide: TUniCheckBox;
    edtCMD: TUniMemo;
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtTaskTypeClick(Sender: TObject);
    procedure edtPeriodTypeClick(Sender: TObject);
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

    procedure SetTaskTypeProperty();
    procedure SetPeriodTypeProperty();
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
  MainModule, uniGUIApplication, uLogger, uSqlUtils, uVarUtils, uMainVar;

function Task_F: TTask_F;
begin
  Result := TTask_F(UniMainModule.GetFormInstance(TTask_F));
end;

{ TTask_F }

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
   case edtTaskType.ItemIndex of
    Integer(tTaskType.ttProc):
    begin
     // Field := edtProcName.Text;
    end;
    Integer(tTaskType.ttBat):
    begin
      Field := edtLink.Text;
    end;
    Integer(tTaskType.ttSQL):
    begin
      Field := edtCMD.Text;
    end;
   end;

//   if cbExecuteHide.Checked then
//   Begin
//     if (FFlag and 1) <> 1 then FFlag := (FFlag or 1)
//   end
//   else
//   Begin
//     if (FFlag and 1) = 1 then FFlag := (FFlag xor 1);
//   end;

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
                '            ,@TaskType  = :TaskType  '+
                '            ,@PeriodType= :PeriodType'+
                '            ,@DateBegin = :DateBegin '+
                '            ,@IsActive  = :IsActive  '+
                '            ,@Field     = :Field     '+
                '            ,@LinkID    = :LinkID    '+
                '            ,@TimeBegin = :TimeBegin '+
                '            ,@TimeEnd   = :TimeEnd   '+
                '            ,@DayPeriod = :DayPeriod '+
                '            ,@TimePeriod= :TimePeriod'+
                '            ,@Flag      = :Flag      '+
                '                                     '+
                ' select @r as retcode, @TaskID as TaskID      '+
                ' ';

      Sql.Open(sqltext,
               ['Brief','Name','TaskType', 'PeriodType', 'DateBegin',
                'IsActive', 'Field', 'LinkID', 'TimeBegin', 'TimeEnd',
                'DayPeriod', 'TimePeriod', 'Flag'],
               [edtBrief.Text,
                edtName.Text,
                edtTaskType.ItemIndex,
                edtPeriodType.ItemIndex,
                edtDateBegin.DateTime,
                ebtIsActive.Checked,
                Field,
                vartoint(edtLinkID.KeyValue),
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
                '            ,@TaskType  = :TaskType  '+
                '            ,@PeriodType= :PeriodType'+
                '            ,@DateBegin = :DateBegin '+
                '            ,@IsActive  = :IsActive  '+
                '            ,@Field     = :Field     '+
                '            ,@LinkID    = :LinkID    '+
                '            ,@TimeBegin = :TimeBegin '+
                '            ,@TimeEnd   = :TimeEnd   '+
                '            ,@DayPeriod = :DayPeriod '+
                '            ,@TimePeriod= :TimePeriod'+
                '            ,@Flag      = :Flag      '+
                '                                     '+
                ' select @r as retcode                '+
                ' ';

      Sql.Open(sqltext,
               ['TaskID', 'Brief','Name','TaskType', 'PeriodType', 'DateBegin',
                'IsActive', 'Field', 'LinkID', 'TimeBegin', 'TimeEnd',
                'DayPeriod', 'TimePeriod', 'Flag'],
               [FID,
                edtBrief.Text,
                edtName.Text,
                edtTaskType.ItemIndex,
                edtPeriodType.ItemIndex,
                edtDateBegin.DateTime,
                ebtIsActive.Checked,
                Field,
                vartoint(edtLinkID.KeyValue),
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
      end
      else if edtTaskType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Тип задачи] обязателена к заполнению!'; Exit();
      end;
    end;
  end;
end;

procedure TTask_F.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *  '+
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

  edtTaskType.ItemIndex:= UniMainModule.Query.FieldByName('TaskType').AsInteger;
  case edtTaskType.ItemIndex of
    Integer(tTaskType.ttProc):
    begin
     edtLinkID.KeyValue:=  UniMainModule.Query.FieldByName('LinkID').AsInteger;
    end;
    Integer(tTaskType.ttBat):
    begin
      edtLink.Text:=  UniMainModule.Query.FieldByName('Field').AsString;
    end;
    Integer(tTaskType.ttSQL):
    begin
      edtCMD.Text:=  UniMainModule.Query.FieldByName('Field').AsString;
    end;
  end;

  edtTimeBegin.DateTime:= UniMainModule.Query.FieldByName('TimeBegin').AsDateTime;
  edtTimeEnd.DateTime:= UniMainModule.Query.FieldByName('TimeEnd').AsDateTime;
  edtTimePeriod.DateTime:= UniMainModule.Query.FieldByName('TimePeriod').AsDateTime;
  edtDayPeriod.Value:= UniMainModule.Query.FieldByName('DayPeriod').AsInteger;

  edtID.Text:= UniMainModule.Query.FieldByName('TaskID').AsString;
  edtInDateTime.DateTime:= UniMainModule.Query.FieldByName('InDateTime').AsDateTime;

  //FFlag:= UniMainModule.Query.FieldByName('Flag').AsInteger;

  //cbExecuteHide.Checked := (FFlag And 1) > 0;

  SetTaskTypeProperty;
  SetPeriodTypeProperty;
end;

procedure TTask_F.edtPeriodTypeClick(Sender: TObject);
begin
   SetPeriodTypeProperty
end;

procedure TTask_F.edtTaskTypeClick(Sender: TObject);
begin
  SetTaskTypeProperty;
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

procedure TTask_F.SetTaskTypeProperty; // тип задачи
begin
  edtLinkID.Visible:=False;
  edtLink.Visible:=False;
  cbExecuteHide.Visible := False;
  edtCMD.Visible := False;


  case edtTaskType.ItemIndex of
    Integer(tTaskType.ttProc):
    begin
      FDQuery.Close;
      FDQuery.SQL.Text := 'select PropertyID, Brief, Name from tProperty (nolock) where ObjectTypeID = :ObjectTypeID';
      FDQuery.ParamByName('ObjectTypeID').AsInteger := 101;
      FDQuery.Open;

      edtLinkID.Visible:=True;

    end;
    Integer(tTaskType.ttBat):
    begin
      edtLink.Visible:=True;
      //cbExecuteHide.Visible := True;
    end;
    Integer(tTaskType.ttSQL):
    begin
      edtCMD.Visible:=True;
      //cbExecuteHide.Visible := True;
    end;
  else
  end;

end;

procedure TTask_F.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';


      edtDateBegin.DateTime := Now();
      edtTimeBegin.Text := '';
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
end;

end.
