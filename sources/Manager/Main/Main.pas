unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, uniImage, Vcl.Imaging.jpeg, uniSpeedButton, uniTimer,
  uTreeMenuHelper;

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
    UniNativeImageList1: TUniNativeImageList;
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
    procedure UniFormBroadcastMessage(const Sender: TComponent;
      const Msg: string; const Params: TUniStrings);
  private
    { Private declarations }
    FormNames : TStrings;

    Profile : TUniTreeNode;

    /// <summary>
    ///  ConstructNavigator - создание меню пользователя
    ///</summary>
    procedure ConstructNavigator;

    procedure SetMainMenuMicroName;

    procedure ProfileMenuAdd();

    function CreateImageIndex(filename: string): Integer;

//    function FindNodeByID(AID: Integer): TUniTreeNode;

    /// <summary>
    ///  SetChatsMessageIsRead - установка количества непрочитанных сообщений на меню Уведомления
    ///</summary>
    procedure SetChatsMessageIsRead();
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, uGrantUtils,
  LoginEditForm, InfoForm, uLoggerF, uMainVar, uLogger, uUtils.Varriant,
  uUserProfile, uCommonType;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormBroadcastMessage(const Sender: TComponent;
  const Msg: string; const Params: TUniStrings);
begin
  logger.Info('TMainForm.UniFormBroadcastMessage');
  logger.Info(Msg);

  // просталяем количество непрочитанных сообщений
  if Msg = 'ChatsMessageIsRead' then
  begin
    SetChatsMessageIsRead();
  end

end;

//function TMainForm.FindNodeByID(AID: Integer): TUniTreeNode;
//var i:integer;
//begin
//  result:= nil;
//  for i:=0 to MainMenu.Items.Count-1 do
//  begin
//    if MainMenu.Items[i].Tag = AID then
//    begin
//      result := MainMenu.Items.Item[i];
//      break;
//    end;
//  end;
//
//end;

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
  UserProfile.ShowModal();
end;

procedure TMainForm.ConstructNavigator;
var
  c, Path: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
  iconfile: string;
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

      Nd := MainMenu.FindNodeByID(PID);

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
    //
  end;

end;

function TMainForm.CreateImageIndex(filename: string): Integer;
begin
  Result := MainMenuImage.AddImageFile(filename);
end;

procedure TMainForm.MainMenuClick(Sender: TObject);
var
  Nd : TUniTreeNode;
  Ts : TUniTabSheet;
  FrC :  TUniFrameClass;
  Fr : TUniFrame;
  FClassName: string;
begin
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


procedure TMainForm.ProfileMenuAdd;
begin

  Profile := MainMenu.FindNodeByID(600);

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
  end

end;

procedure TMainForm.SetChatsMessageIsRead;
var ParentNode, CNT: Integer;
    Node:TUniTreeNode;
begin
  Node :=  MainMenu.FindNodeByID(67);

  if Assigned(Node) then
  begin
    ParentNode :=  Node.Id;

    Sql.Open('''

      Select count(*) CNT
        from vUnreadMessages
       where isnull(ClientID, 0) > 0
         and flag&1=0 -- клиентское сообщение
         and flag&2=0 -- не прочитано

    ''', [], []);

    CNT := Sql.f('CNT').asInteger;

    if CNT = 0 then
      MainMenu.Items[ParentNode].Text := 'Уведомления'
    else
      MainMenu.Items[ParentNode].Text := 'Уведомления <div class="badge-chats-count">' + CNT.ToString + '</div>';
  end;

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

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  LogoLabel.Caption := sql.GetSetting('AppProfilesName');

  UserLabel.Caption := UniMainModule.FDConnection.ExecSQLScalar('select Name from tUser (nolock) where UserID=dbo.GetUserID()') + ' (' + UniMainModule.AUserName + ')';
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
  pcMain.Layout := 'fit';

  Grant.UserGrantLoad;

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

  SetChatsMessageIsRead();

end;

initialization
  RegisterAppFormClass(TMainForm);

end.
