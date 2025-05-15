unit uClientPasswordResetF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, FireDAC.Stan.Param,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniPanel, uniEdit, uniGUIBaseClasses, uniLabel,
  uniButton, uToast;

type
  TClientPasswordResetF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniButton;
    btnCancel: TUniButton;
    UniLabel1: TUniLabel;
    edtNewPas2: TUniEdit;
    UniLabel3: TUniLabel;
    edtNewPas: TUniEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FClientID: Integer;
    { Private declarations }
  public
    { Public declarations }
    property ClientID: Integer read FClientID write FClientID;
  end;

function ClientPasswordResetF: TClientPasswordResetF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uCommonType, uMainVar;

function ClientPasswordResetF: TClientPasswordResetF;
begin
  Result := TClientPasswordResetF(UniMainModule.GetFormInstance(TClientPasswordResetF));
end;

procedure TClientPasswordResetF.btnCancelClick(Sender: TObject);
begin
  self.ModalResult:=mrcancel;
end;

procedure TClientPasswordResetF.btnOkClick(Sender: TObject);
begin

  if (edtNewPas.Text = '') or (edtNewPas2.Text = '')  then
  begin
    MessageDlg('Пароль не может быть пустым!', mtWarning, [mbOK]);
    Exit;
  end
  else
  if edtNewPas.Text <> edtNewPas2.Text  then
  begin
    MessageDlg('Новые пароли должны совпадать!', mtWarning, [mbOK]);
    Exit;
  end;

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text :=
  '''
     declare @R      int

     exec @r = ClientPasswordReset
                 @ClientID = :ClientID
                ,@Password = :Password

     select @r             as retcode
  ''';

  UniMainModule.Query.ParamByName('Password').AsWideString := edtNewPas.Text;
  UniMainModule.Query.ParamByName('ClientID').Value := FClientID;
  UniMainModule.Query.Open;

  RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;

  if RetVal.Code = 0then
  begin
//      MessageDlg('Пароль успешно изменен!', mtInformation, [mbOK]);
      ToastOK('Пароль успешно изменен!', UniSession);
      ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

end.
