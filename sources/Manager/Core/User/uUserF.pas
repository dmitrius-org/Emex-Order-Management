unit uUserF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType;

type
  TUserF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    fcUserData: TUniFieldContainer;
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    cbIsActive: TUniCheckBox;
    cbIsBlock: TUniCheckBox;
    edtDataBlock: TUniDateTimePicker;
    lblBrief: TUniLabel;
    lblName: TUniLabel;
    lbDateBlock: TUniLabel;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    edtPass: TUniEdit;
    lblPass: TUniLabel;
    Email: TUniEdit;
    lblEmail: TUniLabel;
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

function UserF: TUserF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar;

function UserF: TUserF;
begin
  Result := TUserF(UniMainModule.GetFormInstance(TUserF));
end;

{ TUserF }

procedure TUserF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TUserF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  DataCheck();

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      sqltext :='''
                 declare @R      int
                        ,@UserID numeric(18, 0)

                 exec @r = UserInsert
                             @UserID   = @UserID out
                            ,@Brief    = :Brief
                            ,@Name     = :Name
                            ,@isBlock  = :isBlock
                            ,@DateBlock= :DateBlock
                            ,@Password = :Password
                            ,@Email    = :Email

                 select @r as retcode
                ''';
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      Sql.Open(UniMainModule.Query,
               ['Brief','Name','isBlock','DateBlock', 'Password', 'Email'],
               [edtBrief.Text,
                edtName.Text,
                cbisBlock.Checked,
                edtDataBlock.DateTime,
                edtPass.Text,
                Email.Text]);

      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;

    end;
    acUpdate:
    begin
      sqltext :='''
                 declare @R      int

                 exec @r = UserUpdate
                             @UserID   = :UserID
                            ,@Brief    = :Brief
                            ,@Name     = :Name
                            ,@isBlock  = :isBlock
                            ,@DateBlock= :DateBlock
                            ,@Email    = :Email

                 select @r as retcode
                ''';
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      Sql.Open(UniMainModule.Query,
               ['UserID', 'Brief','Name','isBlock','DateBlock', 'Email'],
               [FID,
                edtBrief.Text,
                edtName.Text,
                cbisBlock.Checked,
                edtDataBlock.DateTime,
               // edtPass.Text,
                Email.Text]);

      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = UserDelete               '+
                                      '             @UserID   = :UserID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('UserID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    //udit.Add(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TUserF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Логин] обязателен к заполнению!';
        edtBrief.SetFocus;
        Exit();
      end;

      if edtPass.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Пароль] обязателен к заполнению!';
        edtPass.SetFocus;
        Exit();
      end
    end;
    acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Логин] обязателен к заполнению!';
        edtBrief.SetFocus;
        Exit();
      end;
    end;
  end;
end;

procedure TUserF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select u.*  '+
                                  '   from vUsers u   '+
                                  '  where u.UserID = :UserID '+
                                  ' ';
  UniMainModule.Query.ParamByName('UserID').Value := FID;
  UniMainModule.Query.Open;

  // аудит
  edtID.Text           := UniMainModule.Query.FieldValues['UserID'];
  edtInDate.DateTime   := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime  := UniMainModule.Query.FieldValues['updDatetime'];
  edtBrief.Text        := UniMainModule.Query.FieldValues['Brief'];
  edtName.Text         := UniMainModule.Query.FieldValues['Name'];
  cbIsActive.Checked   := UniMainModule.Query.FieldValues['isAdmin'];
  cbisBlock.Checked    := UniMainModule.Query.FieldValues['isBlock'];
  edtDataBlock.DateTime:= UniMainModule.Query.FieldByName('DateBlock').AsDateTime;
  Email.Text           := UniMainModule.Query.FieldValues['Email'];


  Caption := 'Пользователь [' + edtBrief.Text   + ']';
end;

procedure TUserF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TUserF.UniFormShow(Sender: TObject);
begin
  edtBrief.ReadOnly:= FAction <> acInsert;
  fsAudit.Visible:= FAction <> acInsert;


  edtPass.Visible := FAction = acInsert;
  lblPass.Visible := FAction = acInsert;

  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
      edtDataBlock.Text := '';
      edtInDate.Text := '';
      edtUpdDate.Text := '';

      edtPass.Text := 'Q!123456a';

      Caption := 'Создание пользователя';
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
 // else
    //DataLoad;
  end;
end;

end.
