unit uUserRegisterF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniButton, uniLabel;

type
  TUserRegisterF = class(TUniForm)
    edtEmail: TUniEdit;
    edtPassword: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIApplication, uMainVar, MainModule, uLogger, ServerModule, uEmail.gmail, uFileU;

{$R *.dfm}


procedure TUserRegisterF.btnCancelClick(Sender: TObject);
begin
  self.ModalResult:=mrcancel;
end;

procedure TUserRegisterF.btnOkClick(Sender: TObject);
var Gmail: TcfsGmail;
begin

  if (edtEmail.Text = '') or (edtPassword.text = '') then
  begin
    MessageDlg('Заполните все поля!', mtError, [mbOK]);
    Exit;
  end;

  if UniMainModule.dbConnect then
  begin

    sql.Open(' declare @R int, @ClientID numeric(18,0) '+
             '        ,@Hash nvarchar(512) ' +
             ' exec @R=  ClientRegistrationRequest '+
             '          @ClientID = @ClientID out  '+
             '         ,@Hash     = @Hash     out  '+
             '         ,@Email    = :Email         '+
             '         ,@Password = :Password      '+
             ''+
             ' Select @R as R, @ClientID as ClientID, @Hash as Hash' ,
             ['Email', 'Password'],
             [edtEmail.Text, edtPassword.text]);

    RetVal.Code := sql.Q.FieldByName('R').Value;

    if RetVal.Code = 0 then
    begin
      begin
        var Username: string;
        var Password: string;
        var Host: string;
        var Port: Integer;
        var RegLink: string;

        Username := Sql.GetSetting('SMTP_Username');
        Password := Sql.GetSetting('SMTP_Password');
        Host     := Sql.GetSetting('SMTP_Host');
        Port     := Sql.GetSetting('SMTP_Port', 0);
        RegLink  := Sql.GetSetting('SMTP_RegistrationLink');


        var htmlBody: string;
         RegLink := GetSpecialPath(RegLink, '/');

        htmlBody :=      ''+
          '<html>  '+
          '<head>  '+
          '<title>Подтвердите Email (booster.ae)</title>'+
          '</head> '+
          '<body>  '+
          '<p>Для завершения регистрации перейдите по ссылке: <a href="' +RegLink + '/confirmed?tokken=' + sql.Q.FieldByName('Hash').AsWideString + '">ссылка</a></p> '+
          '</body> '+
          '</html> ';

        Gmail := TcfsGmail.Create(Username, Password, 'Booster.ae', Host, Port);
        try
            try
              Gmail.Connect;
              Gmail.Send([edtEmail.Text], 'Подтвердите Email', '', htmlBody, '');

              MessageDlg('На вашу почту отправлена ссылка для подтверждения регистрации!', mtInformation, [mbOK]);
            except
              on E: Exception do
                 raise Exception.Create(E.Message);
            end;
        finally
            Gmail.Free;
        end;
      end;
    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;
  end;
end;

procedure TUserRegisterF.UniFormShow(Sender: TObject);
begin
  {$IFDEF DEBUG}
  if UniServerModule.FDManager.IsConnectionDef('Connection') then
  begin
    edtEmail.Text := UniServerModule.FDManager.ConnectionDefs[0].Params.Values['User_nameT'];
    edtPassword.Text := UniServerModule.FDManager.ConnectionDefs[0].Params.Values['PasswordT'];
  end;
  {$ENDIF}
end;

end.
