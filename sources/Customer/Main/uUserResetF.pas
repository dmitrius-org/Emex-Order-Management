unit uUserResetF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniButton, uniLabel,
  uniPanel;

type
  TUserResetF = class(TUniForm)
    edtEmail: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    UniLabel2: TUniLabel;
    UniContainerPanel1: TUniContainerPanel;
    loginbox: TUniContainerPanel;
    UniLabel1: TUniLabel;
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


procedure TUserResetF.btnCancelClick(Sender: TObject);
begin
  self.ModalResult:=mrcancel;
end;

procedure TUserResetF.btnOkClick(Sender: TObject);
var Gmail: TxtGmail;
begin

  if (edtEmail.Text = '')then
  begin
    MessageDlg('Заполните все поля!', mtError, [mbOK]);
    Exit;
  end;

  if UniMainModule.dbConnect then
  begin

    sql.Open(' declare @R int, @ClientID numeric(18,0) '+
             '        ,@Hash nvarchar(512) ' +
             ' exec @R= CustomerResetPasswordRequest '+
             '          @ClientID = @ClientID out  '+
             '         ,@Hash     = @Hash     out  '+
             '         ,@Email    = :Email         '+
             ''+
             ' Select @R as R, @ClientID as ClientID, @Hash as Hash' ,
             ['Email'],
             [edtEmail.Text]);

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
          '<title>Сброс пароля (search.booster.ae)</title>'+
          '</head> '+
          '<body>  '+
          '<p>Для завершения процедуры сброса пароля перейдите по ссылке: <a href="' +RegLink + 'reset?tokken=' + sql.Q.FieldByName('Hash').AsWideString + '">ссылка</a></p> '+
          '</body> '+
          '</html> ';

        Gmail := TxtGmail.Create(Username, Password, FromName, FromAlias, Host, Port);
        try
            try
              Gmail.Connect;
              Gmail.Send([edtEmail.Text], 'Сброс пароля', '', htmlBody, '');

              MessageDlg('На вашу почту отправлена ссылка для сброса пароля!', mtInformation, [mbOK]);
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

procedure TUserResetF.UniFormShow(Sender: TObject);
begin
  {$IFDEF DEBUG}
  if UniServerModule.FDManager.IsConnectionDef('Connection') then
  begin
    edtEmail.Text := UniServerModule.FDManager.ConnectionDefs[0].Params.Values['User_nameT'];
  end;
  {$ENDIF}
end;

end.
