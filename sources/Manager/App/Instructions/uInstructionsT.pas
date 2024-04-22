unit uInstructionsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniPanel, uniHTMLFrame, uniTreeView,
  uniGUIBaseClasses, uniImageList, Vcl.Menus, uniMainMenu, System.Actions,
  Vcl.ActnList, uniToolBar, unimToolbar, ExtPascalUtils, uniButton, uniLabel,
  uniGroupBox ;

type
  TInstructionsT = class(TUniFrame)
    MenuPanel: TUniContainerPanel;
    ContentPanel: TUniContainerPanel;
    edt1: TUniHTMLFrame;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    TreeMenu: TUniTreeView;
    UniPanel1: TUniPanel;
    actAddChild: TAction;
    N3: TUniMenuItem;
    btnArticleEdit: TUniButton;
    actArticleEdit: TAction;
    lblArticle: TUniLabel;
    ArticleContent: TUniContainerPanel;
    UniPanel2: TUniPanel;
    ArticleToolBar: TUniPanel;
    UniNativeImageList1: TUniNativeImageList;
    UniPanel: TUniPanel;
    UniButton1: TUniButton;
    actSave: TAction;
    procedure UniFrameReady(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure TreeMenuClick(Sender: TObject);
    procedure edt1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure actAddChildExecute(Sender: TObject);
    procedure TreeMenuCellContextClick(ANode: TUniTreeNode; X, Y: Integer);
    procedure PopupMenuPopup(Sender: TObject);
    procedure actArticleEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
  private
    { Private declarations }
    SelectedNode : TUniTreeNode;

    IsEdit: Boolean;

    /// <summary>
    ///  ConstructNavigator - создание меню
    ///</summary>
    procedure ConstructNavigator;

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure EditFCallBack(Sender: TComponent; AResult:Integer);
    function FindNodeByID(AID: Integer): TUniTreeNode;

    /// <summary>
    ///  SetButtonEnabled - Управление доступностью меню редактирования сруктуры
    ///</summary>
    procedure SetButtonEnabled;
    procedure SetEditorEnabled;


    procedure SetArticleEditEnabled;
    procedure ArticleSave(Atext: String);

    procedure SetArticleData;
  public
    { Public declarations }
  end;

implementation

uses
  uCommonType, uInstructionsF, ServerModule, MainModule, uLogger, uMainVar;

{$R *.dfm}


procedure TInstructionsT.actAddChildExecute(Sender: TObject);
begin
  InstructionsF.FormAction := TFormAction.acChildInsert;
  InstructionsF.ShowModal(EditFCallBack);
end;

procedure TInstructionsT.actAddExecute(Sender: TObject);
begin
  InstructionsF.FormAction := TFormAction.acInsert;
  InstructionsF.ShowModal(EditFCallBack);
end;

procedure TInstructionsT.actArticleEditExecute(Sender: TObject);
begin
  UniSession.AddJS('tinyMCE.get("myEditor").getBody().setAttribute("contenteditable", false)');
  UniSession.AddJS('tinyMCE.get("myEditor").getBody().setAttribute("toolbar", false)');
//  UniSession.AddJS('tinyMCE.get("myEditor").getBody().setAttribute("menubar", false)');
//   UniSession.AddJS('tinyMCE.get("myEditor").getBody().setAttribute("statusbar", false)');


//tinymce.activeEditor.mode.set("readonly");
  // edt1.HTML.Clear;
  // edt1.HTML.LoadFromFile('./files/tinymce5/index.html');
   IsEdit := True;

   SetArticleData;

   UniSession.AddJS('tinyMCE.get("myEditor").mode.set("design")');

//  UniSession.AddJS('tinymce.activeEditor.setMode("readonly")');

   SetArticleEditEnabled;

  //edt1.HTML.Clear;


end;

procedure TInstructionsT.actDeleteExecute(Sender: TObject);
var Nd : TUniTreeNode;
begin
  try
    if SelectedNode.Tag = 0  then Exit;
  except
    Exit;
  end;
  Nd := SelectedNode;

  InstructionsF.FormAction := TFormAction.acDelete;
  InstructionsF.ID:=Nd.Tag;
  InstructionsF.ShowModal(EditFCallBack);
end;

procedure TInstructionsT.actEditExecute(Sender: TObject);
var Nd : TUniTreeNode;
begin
  try
    if SelectedNode.Tag = 0  then Exit;
  except
    Exit;
  end;
  Nd := SelectedNode;

  InstructionsF.FormAction := TFormAction.acUpdate;
  InstructionsF.ID:=Nd.Tag;
  InstructionsF.ShowModal(EditFCallBack);
end;

procedure TInstructionsT.actRefreshAllExecute(Sender: TObject);
begin
  ConstructNavigator;
end;

procedure TInstructionsT.actSaveExecute(Sender: TObject);
begin
  isEdit:=False;
  UniSession.AddJS('ajaxRequest(' + edt1.JSName + ', "myCustomSaveButton", ["text="+tinyMCE.get("myEditor").getContent()])');
end;

procedure TInstructionsT.ArticleSave(Atext: String);   var sqltext: string;
begin
    sqltext :=  ' declare @R      int                '+
                '                                    '+
                ' exec @r = InstructionsDetailEdit            '+
                '             @InstructionID = :InstructionID '+
                '            ,@Text          = :Text          '+
                '                                    '+
                ' select @r as retcode               '+
                ' ';

    Sql.Open(sqltext,
               ['InstructionID','Text'],
               [SelectedNode.tag,
                Atext]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    if RetVal.Code = 0 then
    begin

    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;
end;

procedure TInstructionsT.ConstructNavigator;
var
  c, Path: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
  iconfile: string;
begin
  SelectedNode := nil;

  TreeMenu.Items.Clear;

  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Add( ' select * from tInstructions (nolock) where Type = 1 order by ParentID ');
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
      ID  := UniMainModule.Query.FieldByName('InstructionID').Value;
      PID := UniMainModule.Query.FieldByName('ParentID').Value;
      c   := UniMainModule.Query.FieldByName('Name').Value;

      Nd := FindNodeByID(PID);

      Nd := TreeMenu.Items.Add(Nd, c);

      Nd.ImageIndex := -1;

      Nd.Tag := ID;

      UniMainModule.Query.Next;
    end;

    if True then

  finally
    if TreeMenu.Items.Count > 0 then
    begin
      TreeMenu.Items[0].Selected := true;
    end;
  end;
end;

procedure TInstructionsT.EditFCallBack(Sender: TComponent; AResult: Integer);
var Nd, NdNew: TUniTreeNode;
begin
  if AResult <> mrOK then Exit;

  if InstructionsF.FormAction = acInsert then
  begin
    NdNew := TreeMenu.Items.Add(nil, InstructionsF.edtName.text);
    NdNew.Tag :=InstructionsF.ID
  end
  else
  if InstructionsF.FormAction = acChildInsert then
  begin
    Nd := SelectedNode;
    NdNew := TreeMenu.Items.Add(Nd, InstructionsF.edtName.text);
    NdNew.Tag :=InstructionsF.ID
  end
  else
  if InstructionsF.FormAction = acUpdate then
  begin
    Nd := SelectedNode;
    Nd.Text := InstructionsF.edtName.text;
  end
  else
  if InstructionsF.FormAction = acDelete then
  begin
    Nd := SelectedNode;
    TreeMenu.Items.Delete(Nd);
    SelectedNode := nil;
  end;

  SetButtonEnabled;
  SetEditorEnabled;
end;

procedure TInstructionsT.edt1AjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var sqltext: string;
begin
  logger.Info('TInstructionsT.edt1AjaxEvent: ' + EventName);

  if EventName = 'myCustomSaveButton' then
  begin
    ArticleSave(Params.Values['text']);
  end;

  if EventName = 'mycustomSaveButtonEnabled' then
  begin
    actSave.Enabled := True;
  end;
end;

function TInstructionsT.FindNodeByID(AID: Integer): TUniTreeNode;
var i:integer;
begin
  result:= nil;
  for i:=0 to TreeMenu.Items.Count-1 do
  begin
    if TreeMenu.Items[i].Tag = AID then
    begin
      result := TreeMenu.Items.Item[i];
      break;
    end;
  end;
end;

procedure TInstructionsT.PopupMenuPopup(Sender: TObject);
begin
  SetButtonEnabled;
end;

procedure TInstructionsT.SetArticleData;
begin
  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Text := ' select i.Name, d.[Text]          ' +
                '   from tInstructions i (nolock)  ' +
                '   left join tInstructionsDetail d (nolock)    ' +
                '          on i.InstructionID = d.InstructionID ' +
                '  where i.InstructionID = :InstructionID       ';

    ParamByName('InstructionID').Value := SelectedNode.Tag;
    Open;

    lblArticle.Caption := FieldByName('Name').asstring;

    if RecordCount = 0 then
    begin
      UniSession.AddJS('tinyMCE.get("myEditor").setContent("")');
      exit;
    end
    else
    begin
      try
        UniSession.AddJS('tinyMCE.get("myEditor").setContent(' + StrToJS(FieldByName('Text').AsString) + ')');
      except
        UniSession.AddJS('tinyMCE.get("myEditor").setContent("")');
      end;
    end;
  end;

  if not IsEdit then
    UniSession.AddJS('tinyMCE.get("myEditor").mode.set("readonly")');
end;

procedure TInstructionsT.SetArticleEditEnabled;
begin
  actArticleEdit.Enabled := ((TreeMenu.Items.Count > 0) and (Assigned(SelectedNode)) and not IsEdit);

  actSave.Enabled := False;
end;

procedure TInstructionsT.SetButtonEnabled;
begin
  actEdit.Enabled := TreeMenu.Items.Count > 0;
  actDelete.Enabled := TreeMenu.Items.Count > 0;
  actAddChild.Enabled := TreeMenu.Items.Count > 0;
end;

procedure TInstructionsT.SetEditorEnabled;
begin
 // edt1. := ((TreeMenu.Items.Count > 0) and (Assigned(SelectedNode)) );
end;

procedure TInstructionsT.TreeMenuCellContextClick(ANode: TUniTreeNode; X,
  Y: Integer);
begin
  SelectedNode := TreeMenu.Selected;
  PopupMenu.Popup(x, y, TreeMenu);
end;

procedure TInstructionsT.TreeMenuClick(Sender: TObject);
begin

  if (IsEdit) then
  if MessageDlg('Изменения в документе не сохранены, сохранить?" ', mtConfirmation, mbYesNo) = mrYes then
  begin
    //
  end
  else
  begin

  end;

  SelectedNode := TreeMenu.Selected;

  IsEdit := False;

  SetArticleData;

  SetArticleEditEnabled;
end;

procedure TInstructionsT.UniFrameReady(Sender: TObject);
var
  js: string;
begin
  logger.Info('TInstructionsT.UniFrameReady');

  lblArticle.Caption := '';

  ConstructNavigator;

  SetEditorEnabled;

  SetButtonEnabled;

  SetArticleEditEnabled;

  edt1.HTML.Clear;
  edt1.HTML.LoadFromFile('./files/tinymce5/index.html');

  js := ' mycustomSaveButtonEnabled = function() { ' + ' ajaxRequest(' + edt1.JSName + ', "mycustomSaveButtonEnabled", []);' + ' } ;';
  UniSession.JSCode(js);
end;

initialization
  RegisterClass(TInstructionsT);
end.
