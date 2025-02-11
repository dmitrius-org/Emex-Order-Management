unit uNodesF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniRadioGroup;

type
  TNodesF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    edtComment: TUniEdit;
    lblBruef: TUniLabel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    edtType: TUniRadioGroup;
    edtN: TUniNumberEdit;
    UniLabel3: TUniLabel;
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

function NodesF: TNodesF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uLogger, uMainVar;

function NodesF: TNodesF;
begin
  Result := TNodesF(UniMainModule.GetFormInstance(TNodesF));
end;

{ TUserF }

procedure TNodesF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TNodesF.btnOkClick(Sender: TObject);
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
                '        ,@NodeID numeric(18, 0)     '+
                '                                    '+
                ' exec @r = NodeInsert               '+
                '             @NodeID   = @NodeID out'+
                '            ,@Brief    = :Brief     '+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@Flag     = :Flag      '+
                '            ,@ColorID  = :ColorID   '+
                '            ,@Type     = :Type      '+
                '            ,@N        = :N         '+
                ' select @r as retcode, @NodeID as NodeID      '+
                ' ';

      Sql.Open(sqltext,
               ['Brief','Name','Comment','Flag', 'ColorID', 'Type', 'N'],
               [edtBrief.Text,
                edtName.Text,
                edtComment.Text,
                0,
                '',
                edtType.ItemIndex,
                edtN.Value]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('NodeID').Value;

    end;
    acUpdate:
    begin
      sqltext :='''
                 declare @R      int

                 exec @r = NodeUpdate
                             @NodeID   = :NodeID
                            ,@Name     = :Name
                            ,@Comment  = :Comment
                            ,@Flag     = :Flag
                            ,@ColorID  = :ColorID
                            ,@Type     = :Type
                            ,@N        = :N

                 select @r as retcode
                ''';

      Sql.Open(sqltext,
               ['NodeID','Name','Comment','Flag', 'ColorID', 'Type', 'N'],
               [FID,
                edtName.Text,
                edtComment.Text,
                0,
                '',
                edtType.ItemIndex,
                edtN.Value]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = NodeDelete               '+
                                      '             @NodeID   = :NodeID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('NodeID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
//    TAudit.AuditAdd(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TNodesF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Сокращение] обязательно к заполнению!';

        logger.Info(RetVal.Message);
        Exit();
      end
      else if edtName.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
        Exit();
      end
      else if edtType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Тип] обязателено к заполнению!';
        Exit();
      end;
    end;
  end;
end;

procedure TNodesF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select n.*  '+
                                  '   from vNodes n   '+
                                  '  where n.NodeID = :NodeID '+
                                  ' ';
  UniMainModule.Query.ParamByName('NodeID').Value := FID;
  UniMainModule.Query.Open;


  edtBrief.Text     := UniMainModule.Query.FieldByName('Brief').AsString;
  edtName.Text      := UniMainModule.Query.FieldByName('Name').AsString;
  edtComment.Text   := UniMainModule.Query.FieldByName('Comment').AsString;
  edtType.ItemIndex := UniMainModule.Query.FieldByName('Type').AsInteger;
  edtN.Value        := UniMainModule.Query.FieldByName('N').AsInteger;
end;

procedure TNodesF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TNodesF.UniFormShow(Sender: TObject);
begin
  edtBrief.ReadOnly:= FAction <> acInsert;
  edtType.ReadOnly:= FAction <> acInsert;

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
  else
    //DataLoad;
  end;
end;

end.
