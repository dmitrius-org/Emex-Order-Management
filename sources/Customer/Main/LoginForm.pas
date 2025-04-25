unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniEdit, uniButton,
  uniGUIBaseClasses, uniLabel,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Error, uniCheckBox, uniPanel,
  unimLabel;

type
  TLoginF = class(TUniLoginForm)
    UniPanel1: TUniPanel;
    btnOk: TUniButton;
    edtUser: TUniEdit;
    edtPassword: TUniEdit;
    UniCheckBox1: TUniCheckBox;
    lblReg: TUniLabel;
    lblReset: TUniLabel;
    UniLabel3: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
    procedure lblRegClick(Sender: TObject);
    procedure lblResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginF: TLoginF;

implementation

{$R *.dfm}

uses uniGUIVars, ServerModule, MainModule, uniGUIApplication, uUserRegisterF, uUserResetF;

function LoginF: TLoginF;
begin
  Result := TLoginF(UniMainModule.GetFormInstance(TLoginF));
end;

procedure TLoginF.btnOkClick(Sender: TObject);
begin
  if UniMainModule.CustomerAuthorization(edtUser.Text, edtPassword.Text) then
  begin
    if UniCheckBox1.Checked then
      begin
        UniApplication.Cookies.SetCookie(UniMainModule._loginname, edtUser.Text, Date + 7.0); // Expires 7 days from now
        UniApplication.Cookies.SetCookie(UniMainModule._pwd, edtPassword.Text, Date + 7.0);
      end;

    self.ModalResult:=mrok;
  end;
end;

procedure TLoginF.lblRegClick(Sender: TObject);
var UserRegister:TUserRegisterF;
begin
  UserRegister := TUserRegisterF.Create(UniApplication);
  UserRegister.Show;
end;

procedure TLoginF.lblResetClick(Sender: TObject);
var UserResetF:TUserResetF;
begin
  UserResetF := TUserResetF.Create(UniApplication);
  UserResetF.Show;
end;

procedure TLoginF.UniLoginFormShow(Sender: TObject);
begin
  {$IFDEF DEBUG}
  if FDManager.IsConnectionDef('Connection') then
  begin
    edtUser.Text := FDManager.ConnectionDefs[0].Params.Values['User_nameT'];
    edtPassword.Text := FDManager.ConnectionDefs[0].Params.Values['PasswordT'];
  end;
  {$ENDIF}
end;

initialization
  RegisterAppFormClass(TLoginF);
end.
