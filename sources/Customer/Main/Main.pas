unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, unimTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList


  , uBasket, uSearch, uOrdersT2, Vcl.Imaging.jpeg, uniImage
  ;

type
  TMainForm = class(TUniForm)
    UniPanelParent: TUniPanel;
    UniPanelCentral: TUniPanel;
    UniContainerPanel: TUniContainerPanel;
    Menu: TUniMenuItems;
    mnHome: TUniMenuItem;
    pcMain: TUniPageControl;
    mnUser: TUniMenuItem;
    mnSettings: TUniMenuItem;
    mnTasks: TUniMenuItem;
    ImageList: TUniNativeImageList;
    UniPanelTop: TUniPanel;
    UniPanel: TUniPanel;
    btnProfile: TUniMenuButton;
    pmProfile: TUniPopupMenu;
    ActionList: TUniActionList;
    actExit: TAction;
    N1: TUniMenuItem;
    actEditPas: TAction;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    actinfo: TAction;
    tbS: TUniTabSheet;
    tsB: TUniTabSheet;
    tsO: TUniTabSheet;
    MainMenuPanel: TUniPanel;
    LogoPanel: TUniSimplePanel;
    LogoImage: TUniImage;
    LogoLabel: TUniLabel;
    MainMenu: TUniTreeMenu;
    MainMenuImage: TUniNativeImageList;
    btnFavorit: TUniButton;
    btnBasket: TUniButton;
    procedure UniFormShow(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditPasExecute(Sender: TObject);
    procedure actinfoExecute(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tsBBeforeActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure UniFormCreate(Sender: TObject);
    procedure tsOBeforeActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure tsBBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure tsOBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure MainMenuClick(Sender: TObject);
    procedure btnBasketClick(Sender: TObject);

  private
    { Private declarations }
    ///<summary>
    ///  FormNames - список форм
    ///</summary>
    FormNames : TStrings;

    FSearchF :TSearchF;
    FBasketF :TBasketF;
    FOrdersT2:TOrdersT2;
    ///<summary>
    ///  FormJSNames - список форм
    ///</summary>
    FormJSNames : TStrings;

    function CreateImageIndex(filename: string): Integer;

    procedure SetMainMenuMicroName;

//    function FindNodeByID(AID: Integer): TUniTreeNode;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule,
  LoginEditForm, InfoForm, uLoggerF, uLogger, uApp, uMainVar;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;


procedure TMainForm.actEditPasExecute(Sender: TObject);
begin
  LoginEditF.ShowModal();
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  UniApplication.Cookies.SetCookie(UniMainModule._loginname,'',Date-1);
  UniApplication.Cookies.SetCookie(UniMainModule._pwd,'',Date-1);
  UniApplication.Restart();
end;

procedure TMainForm.actinfoExecute(Sender: TObject);
begin
  Info.ShowModal();
end;


procedure TMainForm.btnBasketClick(Sender: TObject);
begin
  pcMain.ActivePageIndex := 1;
end;

function TMainForm.CreateImageIndex(filename: string): Integer;
begin
  Result := ImageList.AddIconFile(filename);
end;

procedure TMainForm.MainMenuClick(Sender: TObject);
var
  Nd : TUniTreeNode;
begin
  Nd := MainMenu.Selected;

  if Nd.IsFirstNode then
  begin
    MainMenu.Micro := not MainMenu.Micro;

    SetMainMenuMicroName;
    Exit();
  end;

  if Nd.Text = 'Поиск' then pcMain.ActivePageIndex := 0;
  if Nd.Text = 'Корзина' then pcMain.ActivePageIndex := 1;
  if Nd.Text = 'Заказы' then pcMain.ActivePageIndex := 2;
end;

procedure TMainForm.SetMainMenuMicroName;
begin
  if MainMenu.Micro then
  begin
      MainMenu.Items[0].Text := 'Развернуть';
      MainMenuPanel.Width := MainMenu.MicroWidth ;
  end
  else
  begin
      MainMenu.Items[0].Text := 'Свернуть';
      MainMenuPanel.Width := 300;
  end;
end;

procedure TMainForm.tsBBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  Logger.Info('TMainForm.tsBBeforeActivate');
  FBasketF.GridRefresh;
end;

procedure TMainForm.tsBBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  Logger.Info('TMainForm.tsBBeforeFirstActivate');
  if not Assigned(FBasketF) then
  begin
    FBasketF :=  TBasketF.Create(Self);
    FBasketF.Align := alClient;
    FBasketF.Parent := tsB;
  end;
end;

procedure TMainForm.tsOBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  FOrdersT2.GridRefresh;
end;

procedure TMainForm.tsOBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FOrdersT2) then
  begin
    FOrdersT2 :=  TOrdersT2.Create(Self);
    FOrdersT2.Align := alClient;
    FOrdersT2.Parent := tsO;
  end;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
//  lblVersion.Caption := GetAppVersionStr();
  LogoLabel.Caption := sql.GetSetting('AppProfilesName');

  if not Assigned(FSearchF) then
  begin
    FSearchF :=  TSearchF.Create(Self);
    FSearchF.Align := alClient;
    FSearchF.Parent := tbS;
  end;
end;

procedure TMainForm.UniFormDestroy(Sender: TObject);
begin
  FormNames.Free;
end;

procedure TMainForm.UniFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
    76 : // 'l'
      if (ssCtrl in Shift) and (ssAlt in Shift) then
        LoggerF.ShowModal;
  end;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  btnProfile.Caption := UniMainModule.AUserName;

  SetMainMenuMicroName;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
