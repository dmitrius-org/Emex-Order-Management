unit uClientsTypeT;

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
  TClientsTypeT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actView: TAction;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
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
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    UniHiddenPanel: TUniHiddenPanel;
    QueryClientTypeID: TFMTBCDField;
    QueryName: TWideStringField;
    QueryComment: TWideStringField;
    QueryPrepayment: TBooleanField;
    QueryPrepaymentAmount: TCurrencyField;
    QueryMargin: TCurrencyField;
    QueryIsActive: TBooleanField;
    QueryReliability: TCurrencyField;
    QueryDiscount: TCurrencyField;
    QueryCommission: TCurrencyField;
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
  private
    { Private declarations }
    FAction: tFormaction;
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar;

{$R *.dfm}

procedure TClientsTypeT.actAddExecute(Sender: TObject);
begin
  FAction:=TFormAction.acInsert;
  Query.Insert;
end;

procedure TClientsTypeT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TClientsTypeT.actEditExecute(Sender: TObject);
begin
  FAction:=TFormAction.acUpdate;
  Query.Edit;
end;

procedure TClientsTypeT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;

procedure TClientsTypeT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TClientsTypeT.GridClearFilters(Sender: TObject);
//var i:Integer;
begin
//  if Query.Active then
//  begin
//    for I := 0 to Query.Params.Count-1 do
//      Query.Params[I].Value:=null;
//
//    Query.Refresh;
//  end;
end;

procedure TClientsTypeT.GridColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
//var
//  V : Variant;
//  I : Integer;
begin
//  if Query.Active then
//  begin
//    if (Column.Field.DataType = TFieldType.ftBoolean) then  // boolean
//      Query.Params.ParamValues[Column.FieldName]:=Value
//    else
//      Query.Params.ParamValues[Column.FieldName]:='%'+Value+'%';
//
//    Query.Refresh();
//  end;
end;

procedure TClientsTypeT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TClientsTypeT.QueryAfterPost(DataSet: TDataSet);
begin
  if FAction = acInsert then  Query.Refresh;
end;

procedure TClientsTypeT.UniFrameCreate(Sender: TObject); var Index: Integer;
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  Grid.ReadOnly := not actEdit.Enabled;

  Query.Close;
  Query.Open;
end;

procedure TClientsTypeT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin

end;

initialization
  RegisterClass(TClientsTypeT);
end.
