unit uInstructionsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniPanel, uniHTMLFrame, uniTreeView,
  uniGUIBaseClasses, uniImageList, Vcl.Menus, uniMainMenu, System.Actions,
  Vcl.ActnList, uniToolBar, unimToolbar;

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
    ImageList32: TUniImageList;
    ImageList16: TUniImageList;
    TreeMenu: TUniTreeView;
    UniPanel1: TUniPanel;
    actAddChild: TAction;
    N3: TUniMenuItem;
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
  private
    { Private declarations }
    SelectedNode : TUniTreeNode;
    /// <summary>
    ///  ConstructNavigator - создание меню
    ///</summary>
    procedure ConstructNavigator;

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure EditFCallBack(Sender: TComponent; AResult:Integer);
    function FindNodeByID(AID: Integer): TUniTreeNode;


    procedure SetButtonEnabled;
    procedure SetEditorEnabled;
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

procedure TInstructionsT.ConstructNavigator;
var
  c, Path: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
  iconfile: string;
begin
  TreeMenu.Items.Clear;
  Path := UniServerModule.StartPath + 'files\';
  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Add( '  select * from tInstructions (nolock) order by ParentID ');
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

//      if (UniMainModule.Query.FieldByName('Icon').AsWideString <> '' ) then
//      begin
//        Nd.ImageIndex := UniMainModule.Query.FieldByName('Icon').AsWideString.ToInteger;
//      end
//      else
      Nd.ImageIndex := -1;

      Nd.Tag := ID;

      UniMainModule.Query.Next;
    end;
  finally
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

  if EventName = 'mycustomSaveButton' then
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
                Params.Values['text']]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    if RetVal.Code = 0 then
    begin

    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;
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

procedure TInstructionsT.SetButtonEnabled;
begin
  actEdit.Enabled := TreeMenu.Items.Count > 0;
  actDelete.Enabled := TreeMenu.Items.Count > 0;
  actAddChild.Enabled := TreeMenu.Items.Count > 0;
end;

procedure TInstructionsT.SetEditorEnabled;
begin
  edt1.Enabled := TreeMenu.Items.Count > 0;
end;

procedure TInstructionsT.TreeMenuCellContextClick(ANode: TUniTreeNode; X,
  Y: Integer);
begin
  SelectedNode := TreeMenu.Selected;
  PopupMenu.Popup(x, y, TreeMenu);
end;

procedure TInstructionsT.TreeMenuClick(Sender: TObject);
begin

  SelectedNode := TreeMenu.Selected;

  with UniMainModule.Query do
  begin
    close;
    sql.Clear;
    sql.Text := ' select [Text] from tInstructionsDetail (nolock) where InstructionID = :InstructionID ';
    ParamByName('InstructionID').Value := SelectedNode.Tag;
    open;
    if RecordCount = 0 then
    begin
      UniSession.AddJS('tinyMCE.get("myEditor").setContent("")');
      exit
    end
    else
    begin
      logger.Info(' TInstructionsT.TreeMenuClick: ' + FieldByName('Text').Value );
      UniSession.AddJS('tinyMCE.get(''myEditor'').setContent(''' + FieldByName('Text').AsString + ''')');
//      UniSession.AddJS('tinyMCE.get("myEditor").getBody().innerHTML = "' + FieldByName('Text').AsString + '"');


    end;
  end;
end;

procedure TInstructionsT.UniFrameReady(Sender: TObject);
var
  js: string;
begin
  logger.Info('TInstructionsT.UniFrameReady');

  ConstructNavigator;

  SetEditorEnabled;
  SetButtonEnabled;

  edt1.HTML.LoadFromFile('./files/tinymce5/index.html');
//  edt1.AfterScript.LoadFromFile('./files/tinyMCE5/index.js');

  js := ' mycustomSaveButton = function() { ' + ' ajaxRequest(' + edt1.JSName + ', "mycustomSaveButton", [ "text=" + tinyMCE.get("myEditor").getContent() ]);' + ' } ;';
  //js := ' mycustomSaveButton = function() { ' + ' ajaxRequest(' + edt1.JSName + ', "mycustomSaveButton", [ "text=" + tinyMCE.get("myEditor").getBody().innerHTML ]);' + ' } ;';
  UniSession.JSCode(js);
end;

initialization
  RegisterClass(TInstructionsT);
end.
