unit uUserRegisterF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniButton, uniLabel,
  uniPanel;

type
  TUserRegisterF = class(TUniForm)
    edtEmail: TUniEdit;
    edtPassword: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    edtBrief: TUniEdit;
    edtPhone: TUniEdit;
    edtContactPerson: TUniEdit;
    UniLabel6: TUniLabel;
    UniContainerPanel1: TUniContainerPanel;
    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
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
  uniGUIApplication, uMainVar, MainModule, ServerModule, uEmail.gmail, uFileU;

{$R *.dfm}


procedure TUserRegisterF.btnCancelClick(Sender: TObject);
begin
  self.ModalResult:=mrcancel;
end;

procedure TUserRegisterF.btnOkClick(Sender: TObject);
var Gmail: TxtGmail;
begin

  if (edtEmail.Text = '') or (edtPassword.text = '') or (edtBrief.text = '') or (edtPhone.text = '')
  then
  begin
    MessageDlg('Заполните все обязательные поля!', mtError, [mbOK]);
    Exit;
  end;

  if UniMainModule.dbConnect then
  begin

    sql.Open('''
               declare @R int
                      ,@ClientID numeric(18,0)
                      ,@Hash nvarchar(512)

                exec @R=CustomerRegistrationRequest
                         @ClientID = @ClientID out
                        ,@Hash     = @Hash     out
                        ,@Email    = :Email
                        ,@Password = :Password
                        ,@Brief    = :Brief
                        ,@Phone    = :Phone
                        ,@ContactPerson = :ContactPerson

                Select @R as R, @ClientID as ClientID, @Hash as Hash

             ''' ,
             ['Email', 'Password', 'Brief', 'Phone', 'ContactPerson'],
             [edtEmail.Text,
              edtPassword.text,
              edtBrief.text,
              edtPhone.text,
              edtContactPerson.text]);

    RetVal.Code := sql.Q.FieldByName('R').Value;

    if RetVal.Code = 0 then
    begin
      begin
        var Username: string;
        var Password: string;
        var Host: string;
        var Port: Integer;
        var RegLink: string;
        var FromName: string;
        var FromAlias: string;

        Username := Sql.GetSetting('SMTP_Username');
        Password := Sql.GetSetting('SMTP_Password');
        Host     := Sql.GetSetting('SMTP_Host');
        Port     := Sql.GetSetting('SMTP_Port', 0);
        RegLink  := Sql.GetSetting('SMTP_RegistrationLink');
        FromName := Sql.GetSetting('SMTP_FromName');
        FromAlias:= Sql.GetSetting('SMTP_FromAlias');

        var htmlBody: string;
         RegLink := GetSpecialPath(RegLink, '/');

        htmlBody :=      ''+
          '<html>  '+
          '<head>  '+
          '<title>Подтвердите Email (search.booster.ae)</title>'+
          '</head> '+
          '<body>  '+
          '<p>Для завершения регистрации перейдите по ссылке: <a href="' +
            RegLink + 'confirmed?tokken=' +
            sql.Q.FieldByName('Hash').AsWideString + '">ссылка</a></p> '+
          '</body> '+
          '</html> ';

        Gmail := TxtGmail.Create(Username, Password, FromName, FromAlias, Host, Port);
        try
            try
              Gmail.Connect;
              Gmail.Send([edtEmail.Text], 'Подтвердите Email', '', htmlBody, '');

              MessageDlg('На вашу почту отправлена ссылка для подтверждения регистрации!', mtInformation, [mbOK]);

              UniSession.UrlRedirect('/');
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
