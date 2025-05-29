unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, unimTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList

  ,uBasket, uSearch, uOrdersT2, Vcl.Imaging.jpeg, uniImage, uniSpeedButton
  ,uBalanceTotalT, uVersion, uStatisticOrders, uStatistics;

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
    tsOrder: TUniTabSheet;
    MainMenuPanel: TUniPanel;
    MainMenu: TUniTreeMenu;
    MainMenuImage: TUniNativeImageList;
    LogoPanel: TUniContainerPanel;
    LogoImage: TUniImage;
    UniContainerPanel1: TUniContainerPanel;
    UniContainerPanel3: TUniContainerPanel;
    UserLabel: TUniLabel;
    UniContainerPanel2: TUniContainerPanel;
    LogoLabel: TUniLabel;
    btnExit: TUniSpeedButton;
    tsBalance: TUniTabSheet;
    pnlInfo: TUniContainerPanel;
    lblVersion: TUniLabel;
    TabStatistics: TUniTabSheet;
    procedure UniFormShow(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditPasExecute(Sender: TObject);
    procedure actinfoExecute(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tsBBeforeActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure UniFormCreate(Sender: TObject);
    procedure tsOrderBeforeActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure tsBBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure tsOrderBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure MainMenuClick(Sender: TObject);
    procedure btnBasketClick(Sender: TObject);
    procedure tsBalanceBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure pcMainChange(Sender: TObject);
    procedure TabStatisticsBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);

  private
    ///<summary>
    ///  Profile - профиль
    ///</summary>
    Profile : TUniTreeNode;

    FSearchF :TSearchF;
    FBasketF :TBasketF;
    FOrdersT2:TOrdersT2;
    FBalance:TBalanceTotalT;
    FStatistics:TStatisticsT;
    ///<summary>
    ///  FormJSNames - список форм
    ///</summary>
//    FormJSNames : TStrings;

//    function CreateImageIndex(filename: string): Integer;

    procedure SetMainMenuMicroName;

    procedure ProfileMenuAdd();

    procedure Version();
  public

  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule,
  LoginEditForm, InfoForm, uLoggerF, uApp, uMainVar, uUtils.Varriant, uUtils.Localizer;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.actEditPasExecute(Sender: TObject);
begin
  LoginEditF.ShowModal();
end;

procedure TMainForm.actExitExecute(Sender: TObject);
var UrlRedirect: string;
begin  // выход из программы
  UniApplication.Cookies.SetCookie(UniMainModule._loginname,'',Date-1);
  UniApplication.Cookies.SetCookie(UniMainModule._pwd,'',      Date-1);
  {$IFDEF Release}
    UrlRedirect := Sql.GetSetting('RedirectOnExit');

    if UrlRedirect <> '' then
      UniSession.UrlRedirect(UrlRedirect);
  {$ELSE}
    UniApplication.Restart();
  {$ENDIF}
end;

procedure TMainForm.actinfoExecute(Sender: TObject);
begin
  Info.ShowModal();
end;

procedure TMainForm.btnBasketClick(Sender: TObject);
begin
  pcMain.ActivePageIndex := 1;
end;

//function TMainForm.CreateImageIndex(filename: string): Integer;
//begin
//  Result := ImageList.AddIconFile(filename);
//end;

procedure TMainForm.MainMenuClick(Sender: TObject);
var  Nd : TUniTreeNode;
begin
  Nd := MainMenu.Selected;

  if Nd.IsFirstNode then
  begin
    MainMenu.Micro := not MainMenu.Micro;

    SetMainMenuMicroName;
    Exit();
  end;

  if Nd.Text = 'Поиск' then
    pcMain.ActivePageIndex := 0
  else
  if Nd.Text = 'Корзина' then pcMain.ActivePageIndex := 1
  else
  if Nd.Text = 'Заказы' then pcMain.ActivePageIndex := 2
  else
  if Nd.Text = 'Баланс и Отгрузки' then pcMain.ActivePageIndex := 3
  else
  if Nd.Text = 'Статиcтика' then pcMain.ActivePageIndex := 4
  else
  // под 999 меню профиль
  if (Nd.Tag = -999) and (Nd.Action <> nil)  then
  begin
    Nd.Action.Execute;
    Exit();
  end
  else
  if Assigned(Nd) and not Nd.IsLeaf  then
  begin
    if Nd.HasChildren then
    begin
      if Nd.Expanded then
      begin
        Nd.Collapse(False);
        Nd.Expanded := False;
      end
      else
      begin
        Nd.Expand(False);
        Nd.Expanded := True;
      end;
    end
  end;// if Assigned(N) then
end;

procedure TMainForm.pcMainChange(Sender: TObject);
begin
  if Assigned(FOrdersT2) then
    if pcmain.ActivePage <> tsOrder then
      FOrdersT2.SetMenuVisible(false);
end;

procedure TMainForm.ProfileMenuAdd;
begin
  Profile := MainMenu.Items.Add(nil, 'Профиль');
  Profile.ImageIndex := 6;
  Profile.Tag:=-999;

//  with MainMenu.Items.Add(Profile, 'О системе') do
//  begin
//      Tag := -999;
//      Action := actinfo;
//      ImageIndex := 18;
//  end;

  with MainMenu.Items.Add(Profile, 'Изменить пароль входа') do
  begin
      Tag := -999;
      Action := actEditPas;
      ImageIndex := 7;
  end;

  with MainMenu.Items.Add(Profile, 'Выйти из программы') do
  begin
      Tag := -999;
      Action := actExit;
      ImageIndex := 5;
  end;
end;

procedure TMainForm.SetMainMenuMicroName;
begin
  if MainMenu.Micro then
  begin
    MainMenu.Items[0].Text := 'Развернуть';
    MainMenuPanel.Width := MainMenu.MicroWidth;
  end
  else
  begin
    MainMenu.Items[0].Text := 'Свернуть';
    MainMenuPanel.Width := 300;
  end;

  UniApplication.Cookies.SetCookie('_MicroWidth', MainMenu.Micro.ToString());
end;

procedure TMainForm.TabStatisticsBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FStatistics) then
  begin
    FStatistics :=  TStatisticsT.Create(Self);
    FStatistics.Align := alClient;
    FStatistics.Parent := TabStatistics;
  end;
end;

procedure TMainForm.tsBalanceBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FBalance) then
  begin
    FBalance := TBalanceTotalT.Create(Self);
    FBalance.Align := alClient;
    FBalance.Parent := tsBalance;
    FBalance.ClientID := UniMainModule.AUserID;

    FBalance.PlanShipmentsShow := sql.GetSetting('PlanShipmentsShow', False); //Показывать плановые оттрузки
  end;

  FBalance.GridRefresh;
end;

procedure TMainForm.tsBBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  FBasketF.GridRefresh;
end;

procedure TMainForm.tsBBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FBasketF) then
  begin
    FBasketF :=  TBasketF.Create(Self);
    FBasketF.Align := alClient;
    FBasketF.Parent := tsB;
  end;
end;

procedure TMainForm.tsOrderBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  FOrdersT2.SetMenuVisible;
end;

procedure TMainForm.tsOrderBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FOrdersT2) then
  begin
    FOrdersT2 :=  TOrdersT2.Create(Self);
    FOrdersT2.Align := alClient;
    FOrdersT2.Parent := tsOrder;

    FOrdersT2.Page;
    FOrdersT2.GridRefresh;
  end;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin


  LogoLabel.Caption := sql.GetSetting('AppProfilesName');
  UserLabel.Caption := UniMainModule.FDConnection.ExecSQLScalar('select case when Brief <> email then Brief + '' (''+ email + '')'' else Brief  end from tClients (nolock) where ClientID=' + UniMainModule.AUserID.ToString );

  if not Assigned(FSearchF) then
  begin
    FSearchF :=  TSearchF.Create(Self);
    FSearchF.Align := alClient;
    FSearchF.Parent := tbS;
  end;
end;

procedure TMainForm.UniFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
    76 : // 'l'
      if (ssCtrl in Shift) and (ssAlt in Shift) then
      begin
        LoggerF.UserID := UniMainModule.AUserID;
        LoggerF.AppName:= UniMainModule.AAppName;

        LoggerF.ShowModal;
      end;
  end;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  ProfileMenuAdd;

  //unisession.AddJS('{var menu = Ext.ComponentQuery.query("container[cls=x-treelist x-unselectable x-treelist-nav x-treelist-floater]");if (menu.length >0) {Ext.get(menu[0].id).hide();}}');

  MainMenu.Micro := VarToBoolDef(UniApplication.Cookies.Values['_MicroWidth'], false);
  SetMainMenuMicroName;

  pcMain.ActivePageIndex := 0;

  Version;
end;

procedure TMainForm.Version;
begin
  lblVersion.Caption := FileVersion;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
