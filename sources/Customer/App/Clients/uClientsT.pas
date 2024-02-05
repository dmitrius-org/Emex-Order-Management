unit uClientsT;

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

  uUserF, uGrant, uCommonType;

type
  TClientsT = class(TUniFrame)
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
    QueryClientID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    UpdateSQL: TFDUpdateSQL;
    QueryFolder: TWideStringField;
    QueryFirstline: TIntegerField;
    QueryManufacturer: TIntegerField;
    QueryDetailNumber: TIntegerField;
    QueryQuantity: TIntegerField;
    QueryDetailID: TIntegerField;
    QuerytDetailName: TIntegerField;
    QueryPrice: TIntegerField;
    QueryAmount: TIntegerField;
    QueryOrderNum: TWideStringField;
    QueryOrderDate: TWideStringField;
    QueryPriceNum: TWideStringField;
    QueryCommission: TCurrencyField;
    UniHiddenPanel: TUniHiddenPanel;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryIsActive: TBooleanField;
    QueryCustomerSubID: TStringField;
    QueryReference: TStringField;
    QueryemexUsername: TWideStringField;
    QueryemexPassword: TWideStringField;
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
  MainModule, uGrantUtils;

{$R *.dfm}

procedure TClientsT.actAddExecute(Sender: TObject);
begin
  FAction:=TFormAction.acInsert;
  Query.Insert;
end;

procedure TClientsT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TClientsT.actEditExecute(Sender: TObject);
begin
  FAction:=TFormAction.acUpdate;
  Query.Edit;
end;

procedure TClientsT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;

procedure TClientsT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TClientsT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TClientsT.GridColumnFilter(Sender: TUniDBGrid;
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

procedure TClientsT.QueryAfterPost(DataSet: TDataSet);
begin
  if FAction = acInsert then  Query.Refresh;
end;

procedure TClientsT.UniFrameCreate(Sender: TObject); var Index: Integer;
begin
  {$IFDEF Debug}
  TGrant.GrantTemplateCreate(self);
  {$ENDIF}
  TGrant.SetGrant(self, ActionList);
  Grid.ReadOnly := not actEdit.Enabled;

  Query.Close;
  Query.Open;
end;

procedure TClientsT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin

end;

initialization
  RegisterClass(TClientsT);
end.
