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
  uniColorPalette, uniWidgets, uniDBComboBox, uniDBLookupComboBox, UniFSCombobox;

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
    UpdateSQL: TFDUpdateSQL;
    QueryN: TIntegerField;
    QueryType: TIntegerField;
    UniHiddenPanel1: TUniHiddenPanel;
    cbNodeType: TUniComboBox;
    flNodeBrief: TUniEdit;
    flNodeName: TUniEdit;
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
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridDropRowsEvent(SrcGrid, DstGrid: TUniDBGrid;
      Rows: TUniBookmarkList; Params: TUniDragDropParams; var Handled: Boolean);
    procedure GridEndDrag(Sender: TUniControl; Left, Top: Integer);
  private
    { Private declarations }
    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure RecalculateRowNumbers();

    procedure GridRefresh();

  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действи€ на форме редактировани€ данных
    ///</summary>
    procedure EditFCallBack(Sender: TComponent; AResult:Integer);

    /// <summary>
    /// </summary>
end;

implementation

uses
  MainModule, uGrantUtils, ServerModule, uNodesF, uMainVar, uUtils.Grid, uLogger;

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

procedure TNodesT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  GridExt.GridLayoutSave(self, Grid, Params, EventName);
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
//    if (Column.Filtering.Editor is TUniEdit) then  // boolean
      Query.Params.ParamValues[Column.FieldName]:='%'+Value+'%';
//    else
//    if (Column.Filtering.Editor is TUniComboBox) then  // boolean
//      Query.Params.ParamValues[Column.FieldName]:=Value;

    Query.Refresh();
  end;
end;

procedure TNodesT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TNodesT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TNodesT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
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


procedure TNodesT.GridDropRowsEvent(SrcGrid, DstGrid: TUniDBGrid;
  Rows: TUniBookmarkList; Params: TUniDragDropParams; var Handled: Boolean);

var
  SourceRowNumber, TargetRowNumber: Integer;
  Bookmark: TBookmark;
  i: Integer;
begin
  Logger.Info('GridDropRowsEvent');
  Logger.Info('GridDropRowsEvent ' + Params.OverIndex.ToString);

  Handled := true; // ”казываем, что событие обработано
  //Params.Effect := deCopy:

  // ѕроходим по всем перетаскиваемым строкам
  for i := 0 to Rows.Count - 1 do
  begin
    // ”станавливаем текущий Bookmark дл€ строки, которую нужно переместить
    Bookmark := Rows[i];

    // ѕереходим к строке по еЄ закладке (Bookmark)
    SrcGrid.DataSource.DataSet.GotoBookmark(Bookmark);

    // ѕолучаем пор€дковый номер перемещаемой строки
    SourceRowNumber := SrcGrid.DataSource.DataSet.FieldByName('N').AsInteger;

    // ѕереходим к строке перед которой происходит вставка
    DstGrid.DataSource.DataSet.RecNo := Params.OverIndex;

    // ѕолучаем пор€дковый номер строки, перед которой вставл€ем
    TargetRowNumber := DstGrid.DataSource.DataSet.FieldByName('N').AsInteger;

    // ¬озвращаемс€ к перемещаемой строке по еЄ Bookmark
    SrcGrid.DataSource.DataSet.GotoBookmark(Bookmark);

    // ѕрисваиваем перемещаемой строке новый пор€дковый номер
    SrcGrid.DataSource.DataSet.Edit;
    SrcGrid.DataSource.DataSet.FieldByName('N').AsInteger := TargetRowNumber+1;
    SrcGrid.DataSource.DataSet.Post;
  end;

  // ќбновл€ем пор€дковые номера всех строк после перемещени€, если нужно
  RecalculateRowNumbers();

  GridRefresh;
end;

procedure TNodesT.GridEndDrag(Sender: TUniControl; Left, Top: Integer);
begin
  Logger.Info('GridEndDrag');
end;

procedure TNodesT.GridRefresh;
begin
  Query.Close;
  Query.Open;
end;

procedure TNodesT.RecalculateRowNumbers();
var
  i: Integer;
begin
  // ѕереиндексаци€ строк в гриде после завершени€ перетаскивани€
//  Grid.DataSource.DataSet.DisableControls;
//  try
//    Grid.DataSource.DataSet.First;
//    i := 1;
//    while not Grid.DataSource.DataSet.Eof do
//    begin
//      Grid.DataSource.DataSet.Edit;
//      Grid.DataSource.DataSet.FieldByName('RowNumber').AsInteger := i;
//      Grid.DataSource.DataSet.Post;
//      Inc(i);
//      Grid.DataSource.DataSet.Next;
//    end;
//  finally
//    Grid.DataSource.DataSet.EnableControls;
//  end;
end;

procedure TNodesT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TNodesT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  GridExt.SortColumnCreate(Grid);

  // восстановление настроек грида дл€ пользовател€
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);


  GridRefresh
end;

procedure TNodesT.EditFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if NodesF.FormAction = acInsert then
  begin
    Query.Refresh();
  end;
  if NodesF.FormAction = acUpdate then
  begin
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
