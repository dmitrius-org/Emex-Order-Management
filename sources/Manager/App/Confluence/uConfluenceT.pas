unit uConfluenceT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,FireDAC.Stan.Param,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniPanel, uniHTMLFrame, uniTreeView,
  uniGUIBaseClasses, uniImageList, Vcl.Menus, uniMainMenu, System.Actions,
  Vcl.ActnList, uniToolBar, unimToolbar, ExtPascalUtils, uniButton, uniLabel,
  uniGroupBox ;

type
  TConfluenceT = class(TUniFrame)
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
    procedure ArticleSave(AArticleID:Integer; Atext: String);

    procedure SetArticleData;

    function GetEditor(): string;
  public
    { Public declarations }
    ArticleType: Integer;
  end;

implementation

uses
  uCommonType, uConfluencePagesF, ServerModule, MainModule, uMainVar;

{$R *.dfm}


procedure TConfluenceT.actAddChildExecute(Sender: TObject);
var Nd : TUniTreeNode;
begin
  try
    if SelectedNode.Tag = 0  then Exit;
  except
    Exit;
  end;
  Nd := SelectedNode;

  ConfluencePagesF.FormAction := TFormAction.acChildInsert;
  ConfluencePagesF.PID := Nd.Tag;
  ConfluencePagesF.ShowModal(EditFCallBack);
end;

procedure TConfluenceT.actAddExecute(Sender: TObject);
begin
  ConfluencePagesF.FormAction := TFormAction.acInsert;
  ConfluencePagesF.ArticleType:= ArticleType;
  ConfluencePagesF.ShowModal(EditFCallBack);
end;

procedure TConfluenceT.actArticleEditExecute(Sender: TObject);
begin
  UniSession.AddJS('tinyMCE.get("' + GetEditor + '").getBody().setAttribute("contenteditable", false)');
  UniSession.AddJS('tinyMCE.get("' + GetEditor + '").getBody().setAttribute("toolbar", false)');

   IsEdit := True;

   SetArticleData;

   UniSession.AddJS('tinyMCE.get("' + GetEditor + '").mode.set("design")');


   SetArticleEditEnabled;
end;

procedure TConfluenceT.actDeleteExecute(Sender: TObject);
var Nd : TUniTreeNode;
begin
  try
    if SelectedNode.Tag = 0  then Exit;
  except
    Exit;
  end;
  Nd := SelectedNode;

  ConfluencePagesF.FormAction := TFormAction.acDelete;
  ConfluencePagesF.ID:=Nd.Tag;
  ConfluencePagesF.ShowModal(EditFCallBack);
end;

procedure TConfluenceT.actEditExecute(Sender: TObject);
var Nd : TUniTreeNode;
begin
  try
    if SelectedNode.Tag = 0  then Exit;
  except
    Exit;
  end;
  Nd := SelectedNode;

  ConfluencePagesF.FormAction := TFormAction.acUpdate;
  ConfluencePagesF.ID:=Nd.Tag;
  ConfluencePagesF.ShowModal(EditFCallBack);
end;

procedure TConfluenceT.actRefreshAllExecute(Sender: TObject);
begin
  ConstructNavigator;
end;

procedure TConfluenceT.actSaveExecute(Sender: TObject);
begin
  isEdit:=False;

  UniSession.AddJS('ajaxRequest(' + edt1.JSName + ', "myCustomSaveButton", ["text="+tinyMCE.get("' + GetEditor + '").getContent(), "ArticleID=' + SelectedNode.tag.ToString +'"])');
end;

procedure TConfluenceT.ArticleSave(AArticleID:Integer; Atext: String);   var sqltext: string;
begin
    sqltext :=  ' declare @R int  '+
                ''+
                ' exec @r = ArticleDetailEdit         '+
                '             @ArticleID = :ArticleID '+
                '            ,@Text      = :Text      '+
                ''+
                ' select @r as retcode ';

    Sql.Open(sqltext,
               ['ArticleID','Text'],
               [AArticleID, Atext]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    if RetVal.Code = 0 then
    begin

    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;
end;

procedure TConfluenceT.ConstructNavigator;
var
  c: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
//  iconfile: string;
begin
  SelectedNode := nil;

  TreeMenu.Items.Clear;

  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Add( ' select * from tArticles (nolock) where Type = ' + ArticleType.ToString + ' order by ParentID ');
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
      ID  := UniMainModule.Query.FieldByName('ArticleID').Value;
      PID := UniMainModule.Query.FieldByName('ParentID').Value;
      c   := UniMainModule.Query.FieldByName('Name').Value;

      Nd := FindNodeByID(PID);

      Nd := TreeMenu.Items.Add(Nd, c);

      Nd.ImageIndex := -1;

      Nd.Tag := ID;

      UniMainModule.Query.Next;
    end;

  finally
    if TreeMenu.Items.Count > 0 then
    begin
      TreeMenu.Items[0].Selected := true;
    end;
  end;
end;

procedure TConfluenceT.EditFCallBack(Sender: TComponent; AResult: Integer);
var Nd, NdNew: TUniTreeNode;
begin
  if AResult <> mrOK then Exit;

  if ConfluencePagesF.FormAction = acInsert then
  begin
    NdNew := TreeMenu.Items.Add(nil, ConfluencePagesF.edtName.text);
    NdNew.Tag :=ConfluencePagesF.ID
  end
  else
  if ConfluencePagesF.FormAction = acChildInsert then
  begin
    Nd := SelectedNode;
    NdNew := TreeMenu.Items.Add(Nd, ConfluencePagesF.edtName.text);
    NdNew.Tag :=ConfluencePagesF.ID
  end
  else
  if ConfluencePagesF.FormAction = acUpdate then
  begin
    Nd := SelectedNode;
    Nd.Text := ConfluencePagesF.edtName.text;
  end
  else
  if ConfluencePagesF.FormAction = acDelete then
  begin
    Nd := SelectedNode;
    TreeMenu.Items.Delete(Nd);
    SelectedNode := nil;
  end;

  SetButtonEnabled;
  SetEditorEnabled;
end;

procedure TConfluenceT.edt1AjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName = 'myCustomSaveButton' then
  begin
    actSave.Enabled := False;
    ArticleSave(Params.Values['ArticleID'].ToInteger, Params.Values['text']);
  end;

  if EventName = 'ArticleSaveButtonEnabled' then
  begin
    actSave.Enabled := True;
    isEdit:=True;
  end;
end;

function TConfluenceT.FindNodeByID(AID: Integer): TUniTreeNode;
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

function TConfluenceT.GetEditor: string;
begin
  Result := 'myEditor' + ArticleType.ToString;
end;

procedure TConfluenceT.PopupMenuPopup(Sender: TObject);
begin
  SetButtonEnabled;
end;

procedure TConfluenceT.SetArticleData;
begin
  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Text := ' select i.Name, d.[Text]          ' +
                '   from tArticles i (nolock)  ' +
                '   left join tArticleDetail d (nolock)    ' +
                '          on i.ArticleID = d.ArticleID ' +
                '  where i.ArticleID = :ArticleID       ';

    ParamByName('ArticleID').AsInteger := SelectedNode.Tag;
    Open;

    lblArticle.Caption := FieldByName('Name').asstring;

    if RecordCount = 0 then
    begin
      UniSession.AddJS('tinyMCE.get("' + GetEditor + '").setContent("")');
      exit;
    end
    else
    begin
      try
        UniSession.AddJS('tinyMCE.get("' + GetEditor + '").setContent(' + StrToJS(FieldByName('Text').AsString) + ')');
      except
        UniSession.AddJS('tinyMCE.get("' + GetEditor + '").setContent("")');
      end;
    end;
  end;

  if not IsEdit then
    UniSession.AddJS('tinyMCE.get("' + GetEditor + '").mode.set("readonly")');
end;

procedure TConfluenceT.SetArticleEditEnabled;
begin
  actArticleEdit.Enabled := ((TreeMenu.Items.Count > 0) and (Assigned(SelectedNode)) and not IsEdit);

  actSave.Enabled := False;
end;

procedure TConfluenceT.SetButtonEnabled;
begin
  actEdit.Enabled := TreeMenu.Items.Count > 0;
  actDelete.Enabled := TreeMenu.Items.Count > 0;
  actAddChild.Enabled := TreeMenu.Items.Count > 0;
end;

procedure TConfluenceT.SetEditorEnabled;
begin
 // edt1. := ((TreeMenu.Items.Count > 0) and (Assigned(SelectedNode)) );
end;

procedure TConfluenceT.TreeMenuCellContextClick(ANode: TUniTreeNode; X,
  Y: Integer);
begin
  SelectedNode := TreeMenu.Selected;
  PopupMenu.Popup(x, y, TreeMenu);
end;

procedure TConfluenceT.TreeMenuClick(Sender: TObject);
begin

  if (IsEdit) then
  if MessageDlg('Изменения в документе не сохранены, сохранить?" ', mtConfirmation, mbYesNo) = mrYes then
  begin
    actSaveExecute(Sender);
  end;

  SelectedNode := TreeMenu.Selected;

  IsEdit := False;

  SetArticleData;

  SetArticleEditEnabled;
end;

procedure TConfluenceT.UniFrameReady(Sender: TObject);
var
  js: string;
  tmp : TStringList;
begin
  lblArticle.Caption := '';

  ConstructNavigator;

  SetEditorEnabled;

  SetButtonEnabled;

  SetArticleEditEnabled;
  tmp := TStringList.Create;
  tmp.LoadFromFile(UniServerModule.StartPath + '\files\tinymce5\index.html');

  tmp.Text := StringReplace(tmp.Text, 'myEditor', GetEditor, [rfReplaceAll]);
  edt1.HTML.Clear;
  edt1.HTML.SetStrings(tmp);
  tmp.Free;

  js := GetEditor + '_ArticleSaveButtonEnabled = function() { ' + ' ajaxRequest(' + edt1.JSName + ', "ArticleSaveButtonEnabled", []);' + ' } ;';
  UniSession.JSCode(js);
end;

initialization
  RegisterClass(TConfluenceT);
end.
