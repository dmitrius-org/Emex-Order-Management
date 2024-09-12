unit uNodesT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList,  Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, uCommonType, uniButton, uniBitBtn, uniColorButton,
  uniColorPalette, uniWidgets, uniDBComboBox, uniDBLookupComboBox;

type
  TNodesT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actEdit: TAction;
    PopupMenu: TUniPopupMenu;
    N2: TUniMenuItem;
    ImageList16: TUniImageList;
    hdFilter: TUniHiddenPanel;
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    fisBlock: TUniCheckBox;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton2: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    QueryNodeID: TFMTBCDField;
    QueryFlag: TIntegerField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    QueryDescription: TWideStringField;
    QueryColorID: TWideStringField;
    QueryColor: TWideStringField;
    actInsert: TAction;
    actDelete: TAction;
    actView: TAction;
    UniToolButton1: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    N1: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    QueryTypeDescription: TStringField;
    UniToolButton5: TUniToolButton;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridClearFilters(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure actInsertExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
  private
    { Private declarations }
   // FAction: tFormaction;
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure EditFCallBack(Sender: TComponent; AResult:Integer);

    /// <summary>
    /// </summary>
end;

implementation

uses
  MainModule, uGrantUtils, ServerModule, uNodesF, uMainVar;

{$R *.dfm}

procedure TNodesT.actDeleteExecute(Sender: TObject);
begin
  NodesF.FormAction := TFormAction.acDelete;
  NodesF.ID:=QueryNodeID.AsInteger;
  NodesF.ShowModal(EditFCallBack);
end;

procedure TNodesT.actEditExecute(Sender: TObject);
begin
  NodesF.FormAction := TFormAction.acUpdate;
  NodesF.ID:=QueryNodeID.AsInteger;
  NodesF.ShowModal(EditFCallBack);
end;

procedure TNodesT.actInsertExecute(Sender: TObject);
begin
  NodesF.FormAction := TFormAction.acInsert;
  NodesF.ShowModal(EditFCallBack);
end;

procedure TNodesT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;


procedure TNodesT.actViewExecute(Sender: TObject);
begin
  NodesF.FormAction := TFormAction.acShow;
  NodesF.ID:=QueryNodeID.AsInteger;
  NodesF.ShowModal(EditFCallBack);
end;

procedure TNodesT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TNodesT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TNodesT.GridColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
begin
  if Query.Active then
  begin
    if (Column.Field.DataType = TFieldType.ftBoolean) then  // boolean
      Query.Params.ParamValues[Column.FieldName]:=Value
    else
      Query.Params.ParamValues[Column.FieldName]:='%'+Value+'%';

    Query.Refresh();
  end;
end;

procedure TNodesT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if Column.FieldName = 'Color' then
  begin
    if not Column.Field.IsNull and (QueryColorID.Value <> '') {and not QueryColorID.IsNull} then
    begin
      Attribs.Font.Color:=StringToColor(QueryColorID.Value);
    end
  end;
end;


procedure TNodesT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  Grid.ReadOnly := true; //not actEdit.Enabled;

  Query.Close; Query.Open;
end;

procedure TNodesT.EditFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if NodesF.FormAction = acInsert then
  begin
//    UniMainModule.Query.SQL.Text := ' select u.UserID '+
//                                    '       ,u.Brief        '+
//                                    '       ,u.Name         '+
//                                    '       ,u.isAdmin      '+
//                                    '       ,u.isBlock      '+
//                                    '       ,u.DateBlock    '+
//                                    '       ,u.inDatetime   '+
//                                    '       ,u.updDatetime  '+
//                                    '   from tUser u (nolock)   '+
//                                    '  where u.UserID = :UserID '+
//                                    ' ';
//    UniMainModule.Query.ParamByName('UserID').Value := QueryUserID.AsInteger;
//    UniMainModule.Query.Open;
//
//    Query.Insert ;
//    GridUsers.DataSource.DataSet.Insert;
//    Query.FieldValues['UserID']   := UniMainModule.Query.FieldValues['UserID'];
//    Query.FieldValues['Brief']   := UniMainModule.Query.FieldValues['Brief'];
//    Query.FieldValues['Name']    := UniMainModule.Query.FieldValues['Name'];
//    Query.FieldValues['isBlock'] := UniMainModule.Query.FieldValues['isBlock'];
//    Query.FieldValues['isAdmin']     := UniMainModule.Query.FieldValues['isAdmin'];
//    Query.FieldValues['DateBlock']   := UniMainModule.Query.FieldValues['DateBlock'];
//    Query.FieldValues['inDatetime'] := UniMainModule.Query.FieldValues['inDatetime'];
//    Query.FieldValues['updDatetime'] := UniMainModule.Query.FieldValues['updDatetime'];
   //  GridUsers.DataSource.DataSet.Post;
    Query.Refresh();
  end;
  if NodesF.FormAction = acUpdate then
  begin
//    UniMainModule.Query.SQL.Text := ' select u.*  '+
//                                    '   from vUsers u   '+
//                                    '  where u.UserID = :UserID '+
//                                    ' ';
//    UniMainModule.Query.ParamByName('UserID').Value := QueryUserID.AsInteger;
//    UniMainModule.Query.Open;
//
//    Query.Edit ;
//    Query.FieldValues['Brief']   := UniMainModule.Query.FieldValues['Brief'];
//    Query.FieldValues['Name']    := UniMainModule.Query.FieldValues['Name'];
//    Query.FieldValues['isBlock'] := UniMainModule.Query.FieldValues['isBlock'];
//    //Query.FieldValues['isAdmin']     := UniMainModule.Query.FieldValues['isAdmin'];
//    Query.FieldValues['DateBlock']   := UniMainModule.Query.FieldValues['DateBlock'];
//    Query.FieldValues['updDatetime'] := UniMainModule.Query.FieldValues['updDatetime'];
//    Query.Post;
    Query.Refresh();
  end;
  if NodesF.FormAction = acDelete then
  begin
    // GridUsers.DataSource.DataSet.Delete;
    Query.Refresh();
  end;
end;

initialization
  RegisterClass(TNodesT);
end.
