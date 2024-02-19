unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, unimTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList
  ;

type
  TMainForm = class(TUniForm)
    UniPanelParent: TUniPanel;
    UniPanelLeft: TUniPanel;
    UniPanelCentral: TUniPanel;
    UniContainerPanel: TUniContainerPanel;
    MainMenu: TUnimTreeMenu;
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
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    procedure UniFormShow(Sender: TObject);
    procedure MainMenuClick(Sender: TObject);
    procedure TabMainClose(Sender: TObject; var AllowClose: Boolean);
    procedure UniFormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditPasExecute(Sender: TObject);
    procedure actinfoExecute(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FormNames : TStrings;
    /// <summary>
    ///  ConstructNavigator - создание меню пользователя
    ///</summary>
    procedure ConstructNavigator;

    function CreateImageIndex(filename: string): Integer;

    function FindNodeByID(AID: Integer): TUniTreeNode;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, uGrantUtils,
  LoginEditForm, InfoForm, uLoggerF, uMainVar;

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
  LoginEditF.ShowModal();      //UserFCallBack
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  UniApplication.Cookies.SetCookie('_loginname','',Date-1);
  UniApplication.Cookies.SetCookie('_pwd','',Date-1);
  UniApplication.Restart();
end;

procedure TMainForm.actinfoExecute(Sender: TObject);
begin
  Info.ShowModal();
end;

procedure TMainForm.ConstructNavigator;
var
  c, Path: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
begin
  FormNames := TStringList.Create;

  Path := UniServerModule.StartPath + '';
  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Add( '  declare @UserID numeric(18, 0);      '+
             '   select @UserID = dbo.GetUserID();   ');

    sql.Add( '  Select *      '+
             '    from vGrant '+
             '   where ObjectID = @UserID '+
             '     and MenuID=200         '+
             '   order by N      ');

    open;
    if RecordCount = 0 then
    begin
      exit
    end;
  end;

  try
    UniMainModule.Query.First;
    for I := 0 to UniMainModule.Query.RecordCount -1  do
    begin
      ID  := UniMainModule.Query.FieldByName('MenuID').Value;
      PID := UniMainModule.Query.FieldByName('ParentID').Value;
      c   := UniMainModule.Query.FieldByName('Caption').Value;

      begin
        // сохраняем форму, которая будет открываться по клику на элементе меню
        FormNames.Values[c] :=  UniMainModule.Query.FieldByName('Name').Value;

        Nd := FindNodeByID(PID);
        if Nd = nil then
        begin
          Nd := MainMenu.Items.Add(nil, c);
          Nd.ImageIndex := -1;
        end
        else
        begin
//
//        iconfile := Path + 'Icons\' + FileNames.Values[SubS] + '.ico';
//        if FileExists(iconfile) then
//          index := CreateImageIndex(iconfile)
//        else
//          index := -1;
//
          Nd := MainMenu.Items.Add(Nd, c);
          Nd.ImageIndex := -1;
        end;
        Nd.Tag := ID;
      end;
      UniMainModule.Query.Next;
    end;
  finally
//    Ls.Free;
  end;
end;

function TMainForm.CreateImageIndex(filename: string): Integer;
begin
  Result := ImageList.AddIconFile(filename);
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
  if ((Nd.Count = 0) and (Nd.Text <> '')) then
  begin
    Ts := Nd.Data;
    if not Assigned(Ts) then
    begin
      Ts := TUniTabSheet.Create(Self);
      Ts.PageControl := pcMain;

      if Nd.Text <> 'Главная' then
        Ts.Closable   := True;
      Ts.OnClose    := TabMainClose;
      Ts.Tag        := NativeInt(Nd);
      Ts.Caption    := Nd.Text;
      Ts.ImageIndex := Nd.ImageIndex;

      FClassName := FormNames.Values[Nd.Text];
      FrC := TUniFrameClass(FindClass(FClassName));

      Fr := FrC.Create(Self);
      Fr.Align := alClient;
      Fr.Parent := Ts;

      Nd.Data := Ts;
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

  Grant.UserGrantLoad;

  ConstructNavigator;

  if MainMenu.Items.Count > 0 then
  begin
    MainMenu.Items[0].Selected := True;
    MainMenuClick(Sender);
  end;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
