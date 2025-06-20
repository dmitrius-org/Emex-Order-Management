﻿unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, unimTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, uniImage, Vcl.Imaging.jpeg, uniSpeedButton, uniTimer
  ;

type
  TMainForm = class(TUniForm)
    pmProfile: TUniPopupMenu;
    ActionList: TUniActionList;
    actExit: TAction;
    N1: TUniMenuItem;
    actEditPas: TAction;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    actinfo: TAction;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    MainMenuImage: TUniNativeImageList;
    MainMenu: TUniTreeMenu;
    MainMenuPanel: TUniPanel;
    MainMenuPanelDetail: TUniPanel;
    UniContainerPanel: TUniContainerPanel;
    UniPanel: TUniPanel;
    pcMain: TUniPageControl;
    btnExit: TUniSpeedButton;
    UniContainerPanel1: TUniContainerPanel;
    UserLabel: TUniLabel;
    LogoLabel: TUniLabel;
    UniContainerPanel3: TUniContainerPanel;
    UniContainerPanel2: TUniContainerPanel;
    LogoImage: TUniImage;
    LogoPanel: TUniContainerPanel;
    actProfile: TAction;
    actServerControlPanel: TAction;
    pnlInfo: TUniContainerPanel;
    lblVersion: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure MainMenuClick(Sender: TObject);
    procedure TabMainClose(Sender: TObject; var AllowClose: Boolean);
    procedure UniFormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditPasExecute(Sender: TObject);
    procedure actinfoExecute(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key:Word; Shift: TShiftState);
    procedure UniFormCreate(Sender: TObject);
    procedure actProfileExecute(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormBroadcastMessage(const Sender: TComponent;
      const Msg: string; const Params: TUniStrings);
    procedure actServerControlPanelExecute(Sender: TObject);
  private
    { Private declarations }
    FormNames : TStrings;

    Profile : TUniTreeNode;

    /// <summary>
    ///  ConstructNavigator - создание меню пользователя (дианамическое меню, зависящее от прав)
    ///</summary>
    procedure ConstructNavigator;

    procedure SetMainMenuMicroName;

    /// <summary>
    ///  ProfileMenuAdd - создание меню по умолчанию
    ///</summary>
    procedure ProfileMenuAdd();

//    function CreateImageIndex(filename: string): Integer;

    function FindNodeByID(AID: Integer): TUniTreeNode;

    procedure SetUserLabel();

    /// <summary>
    ///  ProfileCallBack - CallBack обработчик действия на форме профили пользователя
    ///</summary>
    procedure ProfileCallBack(Sender: TComponent; AResult:Integer);

    procedure Version();
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, uGrantUtils,
  LoginEditForm, InfoForm, uLoggerF, uMainVar, uUtils.Varriant,
  uUserProfile, uCommonType, uUtils.WS, uUtils.Logger, uVersion;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

function TMainForm.FindNodeByID(AID: Integer): TUniTreeNode;
var i:integer;
begin
  result:= nil;
  for i:=0 to MainMenu.Items.Count-1 do
  begin
    if MainMenu.Items[i].Tag = AID then
    begin
      result := MainMenu.Items.Item[i];
      break;
    end;
  end;
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

procedure TMainForm.actProfileExecute(Sender: TObject);
begin
  UserProfile.FormAction := acUpdate;
  UserProfile.ID := UniMainModule.AUserID;
  UserProfile.ShowModal(ProfileCallBack);
end;

procedure TMainForm.actServerControlPanelExecute(Sender: TObject);
begin
  UniSession.AddJS('window.open("/server", "_blank")');
end;

procedure TMainForm.ConstructNavigator;
var
  c, Path: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
begin
  FormNames := TStringList.Create;

  Path := UniServerModule.StartPath + 'files\';
  with UniMainModule.Query do
  begin
    Close;
    Sql.Clear;
    Sql.text :=
     '''
       declare @UserID numeric(18, 0);
               select @UserID = dbo.GetUserID();

       Select *
         from vGrant
        where ObjectID = @UserID
          and type  = 0
          and (value = 1
            or GroupValue = 1 or menuid =  600)
        order by N
     ''';

    Open;

    if RecordCount = 0 then
    begin
      Exit
    end;
  end;

  try
    UniMainModule.Query.First;
    for I := 0 to UniMainModule.Query.RecordCount -1  do
    begin
      ID  := UniMainModule.Query.FieldByName('MenuID').Value;
      PID := UniMainModule.Query.FieldByName('ParentID').Value;
      c   := UniMainModule.Query.FieldByName('Caption').Value;

      // сохраняем форму, которая будет открываться по клику на элементе меню
      FormNames.Values[c] :=  UniMainModule.Query.FieldByName('Name').Value;

      Nd := FindNodeByID(PID);

      if (not Assigned(Nd)) and (PID > 0) then
      begin
        UniMainModule.Query.Next;
        Continue;
      end;

      Nd := MainMenu.Items.Add(Nd, c);

      if (UniMainModule.Query.FieldByName('Icon').AsWideString <> '' ) then
      begin
        Nd.ImageIndex := UniMainModule.Query.FieldByName('Icon').AsWideString.ToInteger;
      end
      else
        Nd.ImageIndex := -1;

      Nd.Tag := ID;

      UniMainModule.Query.Next;
    end;
  except
  end;
end;

//function TMainForm.CreateImageIndex(filename: string): Integer;
//begin
//  Result := MainMenuImage.AddImageFile(filename);
//end;

procedure TMainForm.MainMenuClick(Sender: TObject);
var
  Nd : TUniTreeNode;
  Ts : TUniTabSheet;
  FrC :  TUniFrameClass;
  Fr : TUniFrame;
  FClassName: string;
begin
  Log('TMainForm.MainMenuClick begin', etDebug);
  Nd := MainMenu.Selected;

  if Nd.IsFirstNode then
  begin
    MainMenu.Micro := not MainMenu.Micro;

    SetMainMenuMicroName;
    Exit();
  end;

  // под 999 меню профиль
  if (Nd.Tag = -999) and (Nd.Action <> nil)  then
  begin
    Nd.Action.Execute;
    Exit();
  end;

  if ((Nd.Count = 0) and (Nd.Text <> '') and (Nd.Tag<>-999)) then
  begin
    Ts := Nd.Data;

    if not Assigned(Ts) then
    begin

      FClassName := FormNames.Values[Nd.Text];
      if FClassName <> '' then
      begin

        Ts := TUniTabSheet.Create(Self);
        Ts.PageControl := pcMain;

        if Nd.Text <> 'Главная' then
          Ts.Closable   := True;

        Ts.OnClose    := TabMainClose;
        Ts.Tag        := NativeInt(Nd);
        Ts.Caption    := Nd.Text;
        Ts.ImageIndex := Nd.ImageIndex;
        Ts.BorderStyle:=ubsNone;
        Ts.Layout     := 'fit';

        FrC := TUniFrameClass(FindClass(FClassName));

        Fr := FrC.Create(Self);
        Fr.Align := alClient;
        Fr.Parent := Ts;

        Nd.Data := Ts;
      end;
    end;

    pcMain.ActivePage := Ts;
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


procedure TMainForm.ProfileCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  SetUserLabel();
end;

procedure TMainForm.ProfileMenuAdd;
begin
//  Profile := MainMenu.Items.Add(Profile, 'О системе');// FindNodeByID(600);
//  Profile.Tag := 600;
//  Profile.ImageIndex := 2;

  Profile := FindNodeByID(600);

  if Assigned(Profile) then
  begin
    with MainMenu.Items.Add(Profile, 'О системе') do
    begin
      Tag := -999;
      Action := actinfo;
      ImageIndex := 18;
    end;

    with MainMenu.Items.Add(Profile, 'Профиль пользователя') do
    begin
      Tag := -999;
      Action := actProfile;
      ImageIndex := 21;
    end;

    with MainMenu.Items.Add(Profile, 'Изменить пароль входа') do
    begin
      Tag := -999;
      Action := actEditPas;
      ImageIndex := 16;
    end;

//    if actServerControlPanel.Tag = 1 then
//    with MainMenu.Items.Add(Profile, 'Панель управления сервером') do
//    begin
//      Tag := -999;
//      Action := actServerControlPanel;
//      ImageIndex := 23;
//    end;

  end
end;

procedure TMainForm.SetMainMenuMicroName;
begin
  if MainMenu.Micro then
  begin
      MainMenu.Items[0].Text := 'Развернуть';
      MainMenuPanel.Width := MainMenu.MicroWidth;
      btnExit.Visible :=  false;
  end
  else
  begin
      MainMenu.Items[0].Text := 'Свернуть';
      MainMenuPanel.Width := 300;
      btnExit.Visible :=  True;
  end;

  UniApplication.Cookies.SetCookie('_MicroWidth', MainMenu.Micro.ToString());
end;

procedure TMainForm.SetUserLabel;
begin
  UserLabel.Caption := UniMainModule.FDConnection.ExecSQLScalar('select Name + ''('' + Brief + '')'' from tUser (nolock) where UserID=dbo.GetUserID()');
end;

procedure TMainForm.TabMainClose(Sender: TObject; var AllowClose: Boolean);
var
  Ts : TUniTabSheet;
  Nd : TUniTreeNode;
begin
  Ts := Sender as TUniTabSheet;
  Nd := Pointer(Ts.Tag);
  if Assigned(Nd) then
  begin
    Nd.Data := nil;
    if MainMenu.Selected = Nd then
      MainMenu.Selected := nil;
  end;
end;

procedure TMainForm.UniFormAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
//var
//  JSONData, EventType: string;
begin
//  Log('TMainForm.UniFormAjaxEvent Begin ' + EventType, etWarning);
//  if EventName = 'ws_message' then
//  begin
//    JSONData := Params.Values['message'];
//
//    // Вытащить тип события из JSON
////    EventType := UniMainModule.WS.ExtractEventType(JSONData);
//
//    // Вызвать обработчик по типу
//    if UniMainModule.WS.Handlers.ContainsKey(EventType) then
//      UniMainModule.WS.Handlers[EventType](JSONData)
//    else
//      Log('No handler registered for event type: ' + EventType, etWarning);
//  end;
end;

procedure TMainForm.UniFormBroadcastMessage(const Sender: TComponent;
  const Msg: string; const Params: TUniStrings);
begin
  log('TMainForm.UniFormBroadcastMessage', etDebug);
  log(Msg, etDebug);

  if Msg = 'LoggerManagerRefresh' then
  begin
    log('Refresh: ' + Params.Values['Refresh'], etDebug);
    log('UserID: ' + Params.Values['UserID'], etDebug);
    log('AppName: ' + Params.Values['AppName'], etDebug);

    if Params.Values['UserID'].ToInteger() > 0 then
      UniMainModule.CreateLogger(Params.Values['UserID'].ToInteger(),
                                 Params.Values['AppName']);
  end
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  {$IFDEF Debug}
    Grant.GrantTemplateCreate(self);
  {$ENDIF}

  LogoLabel.Caption := sql.GetSetting('AppProfilesName');

  SetUserLabel();
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
      begin
        LoggerF.UserID := UniMainModule.AUserID;
        LoggerF.AppName:= UniMainModule.AAppName;

        LoggerF.ShowModal;
      end;
  end;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  pcMain.Layout := 'fit';

  Grant.UserGrantLoad;
//  Grant.SetGrant(self, ActionList);

  MainMenu.Width := 300;
  MainMenu.Items[0].Tag := -1;

  MainMenu.Micro := VarToBoolDef(UniApplication.Cookies.Values['_MicroWidth'], false);

  SetMainMenuMicroName;

  ConstructNavigator;

  ProfileMenuAdd;

  if MainMenu.Items.Count > 1 then
  begin
    MainMenu.Selected := MainMenu.Items[1];
    {$IFDEF Debug}
       MainMenu.Selected := MainMenu.Items[6];
    {$ENDIF}
    MainMenuClick(Sender);
  end;

  Version;
end;

procedure TMainForm.Version;
begin
  lblVersion.Caption := FileVersion;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
