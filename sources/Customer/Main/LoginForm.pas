unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniEdit, uniButton,
  uniGUIBaseClasses, uniLabel,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Error, uniCheckBox, uniPanel,
  unimLabel, uniMultiItem, uniComboBox, uUniExComboBox,
  System.Net.UrlClient, System.Net.HttpClient, System.JSON, uniImageList;

type
  TLoginF = class(TUniLoginForm)
    UniPanel1: TUniPanel;
    btnOk: TUniButton;
    edtUser: TUniEdit;
    edtPassword: TUniEdit;
    cbRemember: TUniCheckBox;
    lblReg: TUniLabel;
    lblReset: TUniLabel;
    lblLoginTitle: TUniLabel;
    cmbLanguage: TUniExComboBox;
    ImageList: TUniNativeImageList;
    procedure btnOkClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
    procedure lblRegClick(Sender: TObject);
    procedure lblResetClick(Sender: TObject);
    procedure UniLoginFormCreate(Sender: TObject);
    procedure cmbLanguageChangeValue(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginF: TLoginF;

implementation

{$R *.dfm}

uses uniGUIVars, ServerModule, MainModule, uniGUIApplication, uUserRegisterF, uUserResetF, uUtils.Localizer,
  System.IOUtils, uMainVar;

function LoginF: TLoginF;
begin
  Result := TLoginF(UniMainModule.GetFormInstance(TLoginF));
end;

procedure TLoginF.btnOkClick(Sender: TObject);
begin
  if UniMainModule.CustomerAuthorization(edtUser.Text, edtPassword.Text) then
  begin
    if cbRemember.Checked then
      begin
        UniApplication.Cookies.SetCookie(UniMainModule._loginname, edtUser.Text, Date + 7.0); // Expires 7 days from now
        UniApplication.Cookies.SetCookie(UniMainModule._pwd, edtPassword.Text, Date + 7.0);
      end;

    self.ModalResult:=mrok;
  end;
end;

procedure TLoginF.cmbLanguageChange(Sender: TObject);
begin
  if cmbLanguage.ItemIndex >= 0 then
  begin
    UniApplication.Cookies.SetCookie(UniMainModule._lang, TLocalizer.Instance.LanguageCode, Date + 30.0);

    TLocalizer.Instance.ApplyLocalization(self);
  end;
end;

procedure TLoginF.cmbLanguageChangeValue(Sender: TObject);
begin
  if cmbLanguage.ItemIndex >= 0 then
  begin
    TLocalizer.Instance.LanguageCode := cmbLanguage.Value;
    RetVal.Language:= cmbLanguage.Value;
  end;
end;

procedure TLoginF.lblRegClick(Sender: TObject);
var UserRegister:TUserRegisterF;
begin
  UserRegister := TUserRegisterF.Create(UniApplication);
  UserRegister.ShowModal;
end;

procedure TLoginF.lblResetClick(Sender: TObject);
var UserResetF:TUserResetF;
begin
  UserResetF := TUserResetF.Create(UniApplication);
  UserResetF.ShowModal;
end;

procedure TLoginF.UniLoginFormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
    TLocalizer.Instance.ExportFormLocalization(self);
  {$ENDIF}

  TLocalizer.Instance.FillLanguageList(cmbLanguage);
end;

procedure TLoginF.UniLoginFormShow(Sender: TObject);
var
  AcceptLang, UserLang: string;
begin
  UserLang := UniApplication.Cookies.Values[UniMainModule._lang];

  if UserLang = '' then
  begin
    AcceptLang := UniSession.RequestHeader['Accept-Language'];  // например: "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"
    UniServerModule.Logger.AddLog('TLoginF.UniLoginFormShow AcceptLang', AcceptLang);

    if AcceptLang <> '' then
    begin
      // Извлекаем первую часть
      UserLang := Copy(AcceptLang, 1, 2); // "ru", "en", ...
    end;
  end;

  UniServerModule.Logger.AddLog('TLoginF.UniLoginFormShow UserLang', UserLang);

  // Проверяем, доступен ли такой язык
  if ((UserLang <> '') and (TFile.Exists(UniServerModule.StartPath + UniServerModule.FilesFolder + 'locales\' + UserLang + '.json'))) then
    cmbLanguage.Value := UserLang
  else
    cmbLanguage.Value := 'en';

  cmbLanguage.Visible := UserLang = 'ru';

  TLocalizer.Instance.ApplyLocalization(self);

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
