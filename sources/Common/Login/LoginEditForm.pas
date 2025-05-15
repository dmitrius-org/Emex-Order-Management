unit LoginEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FireDAC.Stan.Param,
  uniGUIClasses, uniGUIForm, uniPanel, uniEdit, uniGUIBaseClasses, uniLabel,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  uniButton;

type
  TLoginEditF = class(TUniForm)
    loginbox: TUniContainerPanel;
    edtPas: TUniEdit;
    edtNewPas2: TUniEdit;
    edtNewPas: TUniEdit;
    btnCancel: TUniButton;
    btnOk: TUniButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginEditF: TLoginEditF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uCommonType, Main, uMainVar;

function LoginEditF: TLoginEditF;
begin
  Result := TLoginEditF(UniMainModule.GetFormInstance(TLoginEditF));
end;

procedure TLoginEditF.btnCancelClick(Sender: TObject);
begin
  self.ModalResult:=mrcancel;
end;

procedure TLoginEditF.btnOkClick(Sender: TObject);
begin

  if (edtPas.Text = '') or (edtNewPas.Text = '') or (edtNewPas2.Text = '')  then
  begin
    MessageDlg('Пароль не может быть пустым!', mtWarning, [mbOK]);
    Exit;
  end
  else
  if edtPas.Text = edtNewPas.Text  then
  begin
    MessageDlg('Старый и новый пароли не должны совпадать!', mtWarning, [mbOK]);
    Exit;
  end
  else
  if edtNewPas.Text <> edtNewPas2.Text  then
  begin
    MessageDlg('Новые пароли должны совпадать!', mtWarning, [mbOK]);
    Exit;
  end;

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                  '                                    '+
                                  ' exec @r = UserPassChange           '+
                                  '             @OldPas   = :OldPas    '+
                                  '            ,@NewPas   = :NewPas    '+
                                  '                                    '+
                                  ' select @r             as retcode'+
                                  '       ,dbo.GetLogin() as USR    '+
                                  ' ';

  UniMainModule.Query.ParamByName('OldPas').AsString := edtPas.Text;
  UniMainModule.Query.ParamByName('NewPas').AsString := edtNewPas.Text;
  UniMainModule.Query.Open;
  RetVal.Code := UniMainModule.Query.FieldByName('retcode').AsInteger;

  if RetVal.Code = 0 then
  begin
    // сбрасываем пароли если их запоминали
    UniApplication.Cookies.SetCookie(UniMainModule._loginname,'',Date-1);
    UniApplication.Cookies.SetCookie(UniMainModule._pwd,'',Date-1);

    begin

      try
        UniMainModule.FDConnection.close;
        UniMainModule.FDConnection.Params.Password := edtNewPas2.Text;
        UniMainModule.FDConnection.Open;
      except
        on E: EFDDBEngineException do
        case E.Kind of
          ekUserPwdInvalid:
          begin
             raise Exception.Create('Имя пользователя или пароль неверны!');
          end;
          ekUserPwdExpired:
            raise Exception.Create('Ошибка подключения к БД. Срок действия пароля пользователя истек!');
          ekServerGone:
            raise Exception.Create('Ошибка соединения с базой данных. СУБД недоступна по какой-то причине!');
        else // other issues
          raise Exception.Create('Ошибка соединения с базой данных. Неизвестная ошибка!');
        end;
        on E : Exception do
          raise Exception.Create(E.ClassName+' поднята ошибка, с сообщением: '+#13#10+#13#10+E.Message);
      end;

      MessageDlg('Пароль успешно изменен!', mtInformation, [mbOK]);
      ModalResult:=mrOK;
    end;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

end.
