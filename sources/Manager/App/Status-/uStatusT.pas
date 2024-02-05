unit uStatusT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, uCommonType, uniButton, uniBitBtn, uniColorButton,
  uniColorPalette, uniWidgets, uniDBComboBox, uniDBLookupComboBox;

type
  TStatusT = class(TUniFrame)
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
    UpdateSQL: TFDUpdateSQL;
    QueryStatusID: TFMTBCDField;
    QueryDescription: TWideStringField;
    QueryName: TWideStringField;
    FDQColor: TFDQuery;
    dsColor: TDataSource;
    UniHiddenPanel1: TUniHiddenPanel;
    lkStatusColor: TUniDBLookupComboBox;
    QueryColor: TWideStringField;
    QueryColorID: TWideStringField;
    Querytest: TStringField;
    QueryFlag: TIntegerField;
    QueryStatus: TStringField;
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
  private
    { Private declarations }
    FAction: tFormaction;
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

    /// <summary>
    /// </summary>
end;

implementation

uses
  MainModule, uGrantUtils, ServerModule;

{$R *.dfm}

procedure TStatusT.actEditExecute(Sender: TObject);
begin
  FAction:=TFormAction.acUpdate;
  Query.Edit;
end;

procedure TStatusT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;


procedure TStatusT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TStatusT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TStatusT.GridColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
var
  V : Variant;
  I : Integer;
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

procedure TStatusT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
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


procedure TStatusT.UniFrameCreate(Sender: TObject); var Index: Integer;
begin
  {$IFDEF Debug}
  TGrant.GrantTemplateCreate(self);
  {$ENDIF}
  TGrant.SetGrant(self, ActionList);

  Grid.ReadOnly := not actEdit.Enabled;

  FDQColor.Close; FDQColor.Open;

  Query.Close; Query.Open;
end;

procedure TStatusT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin

end;

initialization
  RegisterClass(TStatusT);
end.
