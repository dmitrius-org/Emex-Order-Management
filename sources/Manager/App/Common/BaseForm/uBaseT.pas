unit uBaseT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,
  uUserF, uGrant, uCommonType, uUtils.Grid;

type
  TBaseT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    PopupMenu: TUniPopupMenu;
    ImageList16: TUniImageList;
    hdFilter: TUniHiddenPanel;
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    N6: TUniMenuItem;
    fisBlock: TUniCheckBox;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure GridColumnFilter(Sender: TUniDBGrid; const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridClearFilters(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex, NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    { Private declarations }
    FAction: tFormaction;

  public
    { Public declarations }
    procedure DataRefresh(); dynamic;
  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar;

{$R *.dfm}

procedure TBaseT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TBaseT.DataRefresh;
begin
  //
end;

procedure TBaseT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TBaseT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TBaseT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TBaseT.GridColumnFilter(Sender: TUniDBGrid;
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

procedure TBaseT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TBaseT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TBaseT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TBaseT.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TBaseT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
    Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);
end;

initialization
  RegisterClass(TBaseT);

end.
