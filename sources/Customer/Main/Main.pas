unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniBitBtn, uniPanel, uniSplitter, uniLabel, uniImageList, uniTreeView,
  uniTreeMenu, unimTreeMenu, Vcl.Menus, uniMainMenu, uniPageControl, uniGUIFrame,
  uniWidgets, uniMenuButton, System.Actions, Vcl.ActnList


  , uBasket, uSearch, uOrdersT2
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
    procedure UniFormShow(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditPasExecute(Sender: TObject);
    procedure actinfoExecute(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tsBBeforeActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure UniFormCreate(Sender: TObject);
    procedure tsOBeforeActivate(Sender: TObject; var AllowActivate: Boolean);

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

//    function FindNodeByID(AID: Integer): TUniTreeNode;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule,
  LoginEditForm, InfoForm, uLoggerF, uLogger, uApp;

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


function TMainForm.CreateImageIndex(filename: string): Integer;
begin
  Result := ImageList.AddIconFile(filename);
end;

procedure TMainForm.tsBBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(FOrdersT2) then
  begin
    FBasketF :=  TBasketF.Create(Self);
    FBasketF.Align := alClient;
    FBasketF.Parent := tsB;
  end;

  FBasketF.GridRefresh;
end;

procedure TMainForm.tsOBeforeActivate(Sender: TObject;
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

  if not Assigned(FSearchF) then
  begin
    FSearchF :=  TSearchF.Create(Self);
    FSearchF.Align := alClient;
    FSearchF.Parent := tbS;
  end;
//
//  if not Assigned(FBasketF) then
//  begin
//    FBasketF :=  TBasketF.Create(Self);
//    FBasketF.Align := alClient;
//    FBasketF.Parent := tsB;
//  end;
//
//  if not Assigned(FOrdersF) then
//  begin
//    FOrdersF :=  TOrdersT2.Create(Self);
//    FOrdersF.Align := alClient;
//    FOrdersF.Parent := tsO;
//  end;


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


end;

initialization
  RegisterAppFormClass(TMainForm);

end.
