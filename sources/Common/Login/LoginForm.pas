unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniEdit, uniButton,
  uniGUIBaseClasses, uniLabel,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Error, uniCheckBox, uniPanel;

type
  TLoginF = class(TUniLoginForm)
    loginbox: TUniContainerPanel;
    btnOk: TUniButton;
    edtUser: TUniEdit;
    edtPas: TUniEdit;
    UniCheckBox1: TUniCheckBox;
    lblReset: TUniLabel;
    UniLabel2: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginF: TLoginF;

implementation

{$R *.dfm}

uses uniGUIVars, ServerModule, MainModule, uniGUIApplication;

function LoginF: TLoginF;
begin
  Result := TLoginF(UniMainModule.GetFormInstance(TLoginF));
end;

procedure TLoginF.btnOkClick(Sender: TObject);
begin
  if not UniMainModule.FDConnection.Connected  then
  begin
    if UniMainModule.dbConnect(edtUser.Text, edtPas.Text) then
    begin

       if UniCheckBox1.Checked then
       begin
          UniApplication.Cookies.SetCookie(UniMainModule._loginname, edtUser.Text, Date + 7.0); // Expires 7 days from now
          UniApplication.Cookies.SetCookie(UniMainModule._pwd, edtPas.Text, Date + 7.0);
       end;

      self.ModalResult:=mrok;
    end;
  end
end;

procedure TLoginF.UniLoginFormShow(Sender: TObject);
begin
  {$IFDEF DEBUG}
  if FDManager.IsConnectionDef('Connection') then
  begin
    edtUser.Text := FDManager.ConnectionDefs[0].Params.Values['User_name'];
  end;
  {$ENDIF}
end;

initialization
  RegisterAppFormClass(TLoginF);
end.
