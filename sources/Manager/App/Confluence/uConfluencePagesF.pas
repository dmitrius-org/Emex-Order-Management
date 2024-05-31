unit uConfluencePagesF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniRadioGroup, uniMemo;

type
  TConfluencePagesF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    UniFieldContainer1: TUniFieldContainer;
    edtName: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    edtComment: TUniMemo;
    AuditPanel: TUniPanel;
    lblUserName: TUniLabel;
    lblInDateTime: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    FArticleType: Integer;
    FPID: Integer;
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
    property PID: Integer read FPID write FPID;
    property ArticleType: Integer read FArticleType write FArticleType;
  end;

function ConfluencePagesF: TConfluencePagesF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uLogger, uMainVar;

function ConfluencePagesF: TConfluencePagesF;
begin
  Result := TConfluencePagesF(UniMainModule.GetFormInstance(TConfluencePagesF));
end;

{ TUserF }

procedure TConfluencePagesF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TConfluencePagesF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  DataCheck();

  if RetVal.Code = 0 then
  case FAction of
    acInsert, acChildInsert:
    begin

      sqltext :=' declare @R      int                '+
                '        ,@ArticleID numeric(18, 0)  '+
                '                                    '+
                ' exec @r = ArticleAdd        '+
                '             @ArticleID = @ArticleID out'+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@ParentID = :ParentID  '+
                '            ,@Type     = :Type      '+
                ' select @r as retcode, @ArticleID as ArticleID '+
                ' ';

      Sql.Open(sqltext,
               ['Name','Comment','ParentID','Type'],
               [edtName.Text,
                edtComment.Text,
                FPID,
                FArticleType]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('ArticleID').Value;

    end;
    acUpdate:
    begin
      sqltext :=' declare @R      int                '+
                '                                    '+
                ' exec @r = ArticleUpdate            '+
                '             @ArticleID= :ArticleID '+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@ParentID = :ParentID  '+
                '                                    '+
                ' select @r as retcode               '+
                ' ';

      Sql.Open(sqltext,
               ['ArticleID','Name','Comment','ParentID'],
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
                                      ' exec @r = ArticleDelete   '+
                                      '             @ArticleID = :ArticleID '+
                                      '                               '+
                                      ' select @r as retcode          '+
                                      ' ';

      UniMainModule.Query.ParamByName('ArticleID').Value := FID;
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

procedure TConfluencePagesF.DataCheck;
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

procedure TConfluencePagesF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select t.*, u.Name as UserName '+
                                  '   from tArticles t  (nolock) '+
                                  '  inner join tUser u (nolock)   '+
                                  '          on u.UserID = t.UserID  '+
                                  '  where t.ArticleID = :InstructionID '+
                                  ' ';
  UniMainModule.Query.ParamByName('InstructionID').Value := FID;
  UniMainModule.Query.Open;

  edtName.Text:= UniMainModule.Query.FieldByName('Name').AsString;
  edtComment.Text:= UniMainModule.Query.FieldByName('Comment').AsString;

  lblUserName.Caption:= 'Создал: '+UniMainModule.Query.FieldByName('UserName').AsString;
  lblInDateTime.Caption:= 'Дата создания: '+UniMainModule.Query.FieldByName('InDateTime').AsString;
end;

procedure TConfluencePagesF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TConfluencePagesF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate, acChildInsert:
    begin
      btnOk.Caption := ' Сохранить';

      AuditPanel.Visible:=False;
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
