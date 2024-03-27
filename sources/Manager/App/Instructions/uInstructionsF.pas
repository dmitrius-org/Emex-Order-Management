unit uInstructionsF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniRadioGroup, uniMemo;

type
  TInstructionsF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    UniFieldContainer1: TUniFieldContainer;
    edtName: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    edtComment: TUniMemo;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
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
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function InstructionsF: TInstructionsF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uLogger, uMainVar;

function InstructionsF: TInstructionsF;
begin
  Result := TInstructionsF(UniMainModule.GetFormInstance(TInstructionsF));
end;

{ TUserF }

procedure TInstructionsF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TInstructionsF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;
  logger.Info(RetVal.Message);
  DataCheck();
  logger.Info(RetVal.Message);
  logger.Info(RetVal.Code.ToString);
  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      sqltext :=' declare @R      int                '+
                '        ,@InstructionID numeric(18, 0) '+
                '                                    '+
                ' exec @r = InstructionInsert        '+
                '             @InstructionID = @InstructionID out'+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@ParentID = :ParentID  '+
                '                                    '+
                ' select @r as retcode, @InstructionID as InstructionID '+
                ' ';

      Sql.Open(sqltext,
               ['Name','Comment','ParentID'],
               [edtName.Text,
                edtComment.Text,
                0]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('InstructionID').Value;

    end;
    acUpdate:
    begin
      sqltext :=' declare @R      int                '+
                '                                    '+
                ' exec @r = InstructionUpdate                 '+
                '             @InstructionID = :InstructionID '+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@ParentID = :ParentID  '+
                '                                    '+
                ' select @r as retcode               '+
                ' ';

      Sql.Open(sqltext,
               ['InstructionID','Name','Comment','ParentID'],
               [FID,
                edtName.Text,
                edtComment.Text,
                null]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int           '+
                                      '         '+
                                      ' exec @r = InstructionDelete   '+
                                      '             @InstructionID   = :InstructionID '+
                                      '                               '+
                                      ' select @r as retcode          '+
                                      ' ';

      UniMainModule.Query.ParamByName('InstructionID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
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

procedure TInstructionsF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtName.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательна к заполнению!';
        Exit();
      end;
    end;
  end;
end;

procedure TInstructionsF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select t.*  '+
                                  '   from tInstructions t   '+
                                  '  where t.InstructionID = :InstructionID '+
                                  ' ';
  UniMainModule.Query.ParamByName('InstructionID').Value := FID;
  UniMainModule.Query.Open;

  edtName.Text:= UniMainModule.Query.FieldByName('Name').AsString;
  edtComment.Text:= UniMainModule.Query.FieldByName('Comment').AsString;

end;

procedure TInstructionsF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TInstructionsF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
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
