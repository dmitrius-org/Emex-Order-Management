unit uPricesT;

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

  uUserF, uGrant, uCommonType;

type
  TPricesT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N4: TUniMenuItem;
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
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    QueryName: TWideStringField;
    CommentName: TWideStringField;
    QueryDeliveryTerm: TIntegerField;
    QueryDeliveryType: TWideStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    cbDeliveryType: TUniComboBox;
    QueryInWorkingDays: TBooleanField;
    QueryShowInSearch: TBooleanField;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridClearFilters(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure QueryAfterPost(DataSet: TDataSet);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFrameDestroy(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
  private
    { Private declarations }
    FAction: tFormaction;

    procedure DataRefresh();

    procedure SortColumn(const FieldName: string; Dir: Boolean);
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);


  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uGridUtils;

{$R *.dfm}

procedure TPricesT.actAddExecute(Sender: TObject);
begin
  Query.Insert;
 // Query.FieldByName('ModelID').Value := FID;
end;

procedure TPricesT.actDeleteExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TPricesT.actEditExecute(Sender: TObject);
begin
  Query.Edit;
end;

procedure TPricesT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TPricesT.DataRefresh;
begin
  Query.Close;
  Query.Open;

  actEdit.Enabled := (actEdit.Tag = 1) and (Query.RecordCount >0);
  actDelete.Enabled := (actDelete.Tag = 1 ) and (Query.RecordCount >0);
end;

procedure TPricesT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TPricesT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TPricesT.GridColumnFilter(Sender: TUniDBGrid;
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

procedure TPricesT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TPricesT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TPricesT.QueryAfterPost(DataSet: TDataSet);
begin
 // if FAction = acInsert then  Query.Refresh;
end;

procedure TPricesT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TPricesT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  DataRefresh;

  GridExt.SortColumnCreate(Grid) //SortColumnCreate(Query);
end;

procedure TPricesT.UniFrameDestroy(Sender: TObject);
begin
  Query.Close;
end;

procedure TPricesT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
//  if AResult <> mrOK then Exit;
//
//  if SuppliersF.FormAction = acInsert then
//  begin
//    DataRefresh;
//  end;
//  if SuppliersF.FormAction = acUpdate then
//  begin
//    DataRefresh;
//  end;
//  if SuppliersF.FormAction = acDelete then
//  begin
//    DataRefresh;
//  end;
end;

initialization
  RegisterClass(TPricesT);
end.
