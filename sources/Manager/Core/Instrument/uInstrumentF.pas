unit uInstrumentF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniMultiItem, uniComboBox, uniDBComboBox,
  uniDBLookupComboBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniSpinEdit;

type
  TUnstrumentF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    dsInstrumentType: TDataSource;
    qInstrumentType: TFDQuery;
    qObjectType: TFDQuery;
    dsObjectType: TDataSource;
    fObjectType: TUniFieldContainer;
    fBrief: TUniFieldContainer;
    fInstrumentType: TUniFieldContainer;
    edtBrief: TUniEdit;
    fNode: TUniFieldContainer;
    edtName: TUniEdit;
    lkpObject: TUniDBLookupComboBox;
    lkpInstType: TUniDBLookupComboBox;
    UniLabel5: TUniLabel;
    lkpNode: TUniDBLookupComboBox;
    fState: TUniFieldContainer;
    lkpState: TUniDBLookupComboBox;
    qState: TFDQuery;
    dsqState: TDataSource;
    qNode: TFDQuery;
    dsNode: TDataSource;
    cbIsStart: TUniCheckBox;
    lkpTargerState: TUniDBLookupComboBox;
    qTargerState: TFDQuery;
    dsTargerState: TDataSource;
    cbIsCancel: TUniCheckBox;
    edtN: TUniSpinEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure lkpInstTypeChange(Sender: TObject);
    procedure lkpStateChange(Sender: TObject);
    procedure lkpNodeChange(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    FPType: Integer;
    FPID: Integer;
    FIType: Integer;
    FSID: Integer;
    FFlag: Integer;

    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

    procedure SetControlVisible();
  public
    { Public declarations }
    /// <summary>
    /// FormAction - тип действия над формой. acInsert, acUpdate ...
    /// </summary>
    property FormAction: TFormAction read FAction write SetAction;

    property SID: Integer read FSID write FSID;

    property ID: Integer read FID write FID;
    property IType: Integer read FIType write FIType;

    property PID: Integer read FPID write FPID;
    property PType: Integer read FPType write FPType;
  end;

function UnstrumentF: TUnstrumentF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uUtils.Varriant, uMainVar;

function UnstrumentF: TUnstrumentF;
begin
  Result := TUnstrumentF(UniMainModule.GetFormInstance(TUnstrumentF));
end;

{ TUserF }

procedure TUnstrumentF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TUnstrumentF.btnOkClick(Sender: TObject);
var sqltext: string;
    flag: Integer;
begin
  RetVal.Clear;

  DataCheck();

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      if Integer(lkpInstType.KeyValue) in [1,2,3,4,5] then
      begin
        Sql.Q.Close;
        flag :=0;

        sqltext :=' declare @R      int                               '+
                  '        ,@InstrumentID numeric(18, 0)              '+
                  ''+
                  ' exec @r = InstrumentCreate                        '+
                  '             @InstrumentID     = @InstrumentID out '+
                  '            ,@Brief            = :Brief            '+
                  '            ,@Name             = :Name             '+
                  '            ,@InstrumentTypeID = :InstrumentTypeID '+
                  '            ,@PID              = :PID              '+
                  '            ,@Flag             = :Flag             '+
                  '            ,@ObjectTypeID     = :ObjectTypeID     '+
                  ''+
                  ' select @r as retcode       ' +
                  '       ,@InstrumentID as ID '+
                  ' ';

        Sql.Open(sqltext,
                 ['Brief','Name','InstrumentTypeID', 'PID', 'Flag', 'ObjectTypeID'],
                 [edtBrief.Text,
                  edtName.Text,
                  lkpInstType.KeyValue,
                  PID,
                  flag,
                  lkpObject.KeyValue]);
      end;
      if Integer(lkpInstType.KeyValue) in [6,7] then
      begin

        if cbIsStart.Checked then
          flag := Integer(tInstrumentFlag.isStartState)
        else
          flag := 0;

        if cbIsCancel.Checked then
          flag := flag + Integer(tInstrumentFlag.isCanceled);


        Sql.Q.Close;
        sqltext :='''
          declare @R       int
                 ,@ModelID numeric(18, 0)

          exec @r = ModelCreate
                      @ModelID      = @ModelID out
                     ,@InstrumentID = :InstrumentID
                     ,@StateID      = :StateID
                     ,@ActionID     = :ActionID
                     ,@TargetStateID= :TargetStateID
                     ,@InstrumentTypeID = :InstrumentTypeID
                     ,@Flag         = :Flag
                     ,@Number       = :Number

          select @r as retcode
                ,@ModelID as ID
       ''';

        Sql.Open(sqltext,
                 ['InstrumentID','StateID','ActionID', 'InstrumentTypeID', 'Flag', 'TargetStateID', 'Number'],
                 [FPID,
                  VarToInt(lkpState.KeyValue),
                  VarToInt(lkpNode.KeyValue),
                  lkpInstType.KeyValue,
                  flag,
                  VarToInt(lkpTargerState.KeyValue),
                  edtN.Value]);
      end;

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      FID :=  Sql.Q.FieldByName('ID').Value;
      FIType:= lkpInstType.KeyValue;
    end;
    acUpdate:
    begin
      if Integer(lkpInstType.KeyValue) in [1,2,3,4,5] then
      begin
        Sql.Q.Close;
        flag := 0;
        sqltext :='''
                   declare @R      int

                   exec @r = InstrumentUpdate
                               @InstrumentID  = :InstrumentID
                              ,@Brief         = :Brief
                              ,@Name          = :Name
                              ,@ObjectTypeID  = :ObjectTypeID
                              ,@Flag          = :Flag
                   select @r as retcode
                  ''';

        Sql.Open(sqltext,
                  ['Brief','Name','InstrumentID', 'ObjectTypeID', 'Flag'],
                 [edtBrief.Text,
                  edtName.Text,
                  FID,
                  lkpObject.KeyValue,
                  flag]);
      end;
      if Integer(lkpInstType.KeyValue) in [6,7] then
      begin
        if cbIsStart.Checked then
          flag := Integer(tInstrumentFlag.isStartState)
        else
          flag := 0;

        if cbIsCancel.Checked then
          flag := flag + Integer(tInstrumentFlag.isCanceled);

        Sql.Q.Close;
        sqltext :=
        '''
           declare @R      int

           exec @r = ModelUpdate
                       @ModelID      = :ModelID
                      ,@InstrumentID = null
                      ,@StateID      = :StateID
                      ,@ActionID     = :ActionID
                      ,@TargetStateID= :TargetStateID
                      ,@InstrumentTypeID = :InstrumentTypeID
                      ,@Flag         = :Flag
                      ,@Number       = :Number

           select @r as retcode
        ''';

        Sql.Open(sqltext,
                 ['ModelID','StateID','ActionID', 'InstrumentTypeID', 'Flag', 'TargetStateID', 'Number'],
                 [FID,
                 // FPID,
                  VarToInt(lkpState.KeyValue),
                  VarToInt(lkpNode.KeyValue),
                  lkpInstType.KeyValue,
                  flag,
                  VarToInt(lkpTargerState.KeyValue),
                  edtN.Value]);
      end;
      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      if Integer(lkpInstType.KeyValue) in [1,2,3,4,5] then
      begin
        Sql.Q.Close;
        sqltext :=' declare @R      int                           '+
                  '                                               '+
                  ' exec @r = InstrumentDelete                    '+
                  '             @InstrumentID = :InstrumentID '+
                  ' select @r as retcode      '+
                  ' ';

        Sql.Open(sqltext, ['InstrumentID'], [FID]);
      end;
      if Integer(lkpInstType.KeyValue) in [6,7] then
      begin
        Sql.Q.Close;
        sqltext :=' declare @R      int                           '+
                  '                                               '+
                  ' exec @r = ModelDelete                    '+
                  '             @ModelID = :ModelID '+
                  ' select @r as retcode      '+
                  ' ';

        Sql.Open(sqltext, ['ModelID'], [FID]);
      end;
      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    //TAudit.AuditAdd(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;


procedure TUnstrumentF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin

      if lkpInstType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [' + lkpInstType.FieldLabel + '] обязателен к заполнению!';
        Exit();
      end;

      if not lkpInstType.IsBlank then
      case(lkpInstType.KeyValue)  of
        3, 4: //StateGroups, SettingGroups
        begin
          if edtBrief.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [Сокращение] обязательно к заполнению!';
            Exit();
          end
          else if edtName.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
            Exit();
          end
        end;
        5: //StateModel
        begin
          if edtBrief.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [Сокращение] обязательно к заполнению!';
            Exit();
          end
          else if edtName.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
            Exit();
          end
          else if lkpObject.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [' + lkpObject.FieldLabel + '] обязателено к заполнению!';
            Exit();
          end;
        end;
        6: //State
        begin
          if lkpState.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле [Состояние] обязательно к заполнению!';
            Exit();
          end

        end;
        7: //Action
        begin
          if lkpNode.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле  [' + lkpNode.FieldLabel + '] обязательнo к заполнению!';
            Exit();
          end
          else
          if lkpTargerState.IsBlank then
          begin
            RetVal.Code := 1;
            RetVal.Message := 'Поле  [' + lkpTargerState.FieldLabel + '] обязательнo к заполнению!';
            Exit();
          end
        end;
      end;
    end;
  else
    btnOk.Caption := ' Выполнить';
  end;
end;

procedure TUnstrumentF.DataLoad;
begin
  FFlag := 0;

  UniMainModule.Query.Close;
  if IType in [1,2,3,4,5] then
  begin
    UniMainModule.Query.SQL.Text := ' select * FROM [tInstrument] (nolock) where InstrumentID = :InstrumentID ';
    UniMainModule.Query.ParamByName('InstrumentID').Value := FID;
    UniMainModule.Query.Open;

    lkpInstType.KeyValue:= UniMainModule.Query.FieldValues['InstrumentTypeID'];

    edtBrief.Text       := UniMainModule.Query.FieldValues['Brief'];
    edtName.Text        := UniMainModule.Query.FieldValues['Name'];
    lkpObject.KeyValue  := UniMainModule.Query.FieldValues['ObjectTypeID'];
  end;

  if IType in [6, 7] then // состояния и действия
  begin
    UniMainModule.Query.SQL.Text := ' select * FROM [tModel] (nolock) where ModelID = :ModelID ';
    UniMainModule.Query.ParamByName('ModelID').Value := FID;
    UniMainModule.Query.Open;

    FFlag := UniMainModule.Query.FieldByName('Flag').AsInteger;

    cbIsStart.Checked   := ((FFlag and Integer(tInstrumentFlag.isStartState)) > 0);
    cbIsCancel.Checked  := ((FFlag and Integer(tInstrumentFlag.isCanceled)) > 0);

    lkpInstType.KeyValue:= UniMainModule.Query.FieldValues['InstrumentTypeID'];
    lkpState.KeyValue   := UniMainModule.Query.FieldValues['StateID'];
    lkpNode.KeyValue    := UniMainModule.Query.FieldValues['ActionID'];
    edtN.Value          := UniMainModule.Query.FieldByName('Number').AsInteger;
  end;


  if IType in [7] then
  begin
    qTargerState.Close;
    qTargerState.ParamByName('InstrumentID').AsInteger := UniMainModule.Query.FieldValues['InstrumentID'];
    qTargerState.Open;

    lkpTargerState.KeyValue:= UniMainModule.Query.FieldValues['TargetStateID'];
  end;

  // аудит
  edtID.Text          := UniMainModule.Query.FieldByName('UserID').AsString;
  edtInDate.DateTime  := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime := UniMainModule.Query.FieldValues['updDatetime'];
end;

procedure TUnstrumentF.lkpInstTypeChange(Sender: TObject);
begin
    SetControlVisible
end;

procedure TUnstrumentF.lkpNodeChange(Sender: TObject);
begin
  edtBrief.Text:= qNode.FieldValues['Brief'];
  edtName.Text:= qNode.FieldValues['Name'];
end;

procedure TUnstrumentF.lkpStateChange(Sender: TObject);
begin
  edtBrief.Text:= qState.FieldValues['Brief'];
  edtName.Text:= qState.FieldValues['Name'];
end;

procedure TUnstrumentF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TUnstrumentF.SetControlVisible;
begin
  fBrief.Visible      := False;
  fObjectType.Visible := False;
  fState.Visible      := False;
  fNode.Visible       := False;

  try
    //if not lkpInstType.IsBlank then
    case vartoint((lkpInstType.KeyValue))  of
      3, 4: //StateGroups, SettingGroups
      begin
        fBrief.Visible  := True;
      end;
      5: //StateModel
      begin
        fBrief.Visible  := True;
        fObjectType.Visible := True;
      end;
      6: //State
      begin
        fState.Visible  := True;
      end;
      7: //Action
      begin
        fNode.Visible  := True;

        lkpState.KeyValue := FSID;
      end;
    else
    end;
  except

  end;
end;

procedure TUnstrumentF.UniFormShow(Sender: TObject);
begin
  //edtBrief.ReadOnly:= FAction <> acInsert;
  //lkpInstType.ReadOnly:= FAction <> acInsert;
  //
  edtBrief.Enabled:= FAction = acInsert;
  lkpInstType.Enabled:= FAction = acInsert;

  fsAudit.Visible:= FAction <> acInsert;

  qInstrumentType.Close;
  case FAction of
    acInsert, acReportCreate:
    begin
      Self.Caption := 'Добавление объекта';
      btnOk.Caption := ' Добавить';
      edtInDate.Text := '';
      edtUpdDate.Text := '';

      qInstrumentType.ParamByName('Filters').Value := FPType;
    end;
    acUpdate, acReportEdit, acUserAction:
    begin
      btnOk.Caption := ' Сохранить';
      Self.Caption := 'Изменение объекта';

      qInstrumentType.ParamByName('Filters').Value := '';
    end;
    acDelete:
    begin
      btnOk.Caption := ' Удалить';
      Self.Caption := 'Удаление объекта';
    end;
    acShow:
    begin
      btnOk.Caption := ' Закрыть';
      Self.Caption := 'Просмотр объекта';
    end
  else
    btnOk.Caption := ' Выполнить';
  end;

  qInstrumentType.Open;
  qObjectType.Open();
  qState.Open();
  qNode.Open();

  case FAction of
    acInsert, acReportCreate:
    begin
      qTargerState.Close;
      qTargerState.ParamByName('InstrumentID').AsInteger := FPID;
      qTargerState.Open;
    end;
  else
//      qTargerState.Close;
//      qTargerState.ParamByName('InstrumentID').AsInteger := FPID;
//      qTargerState.Open;
  end;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  else
    //DataLoad;
  end;



  SetControlVisible;

end;

end.
