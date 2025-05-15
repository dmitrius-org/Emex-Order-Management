unit LoginEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FireDAC.Stan.Param,
  uniGUIClasses, uniGUIForm, uniPanel, uniEdit, uniGUIBaseClasses, uniLabel,
  uniButton;

type
  TLoginEditF = class(TUniForm)
    btnOk: TUniButton;
    btnCancel: TUniButton;
    loginbox: TUniContainerPanel;
    edtPas: TUniEdit;
    edtNewPas2: TUniEdit;
    edtNewPas: TUniEdit;
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

  UniMainModule.Query.ParamByName('OldPas').Value := edtPas.Text;
  UniMainModule.Query.ParamByName('NewPas').Value := edtNewPas.Text;
  UniMainModule.Query.Open;
  RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;

  if RetVal.Code = 0then
  begin
      // сбрасываем пароли если их запоминали
      UniApplication.Cookies.SetCookie(UniMainModule._loginname,'',Date-1);
      UniApplication.Cookies.SetCookie(UniMainModule._pwd,'',Date-1);

      MessageDlg('Пароль успешно изменен!', mtInformation, [mbOK]);
      ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

end.
