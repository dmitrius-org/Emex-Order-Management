unit uEmployeesT;

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
  TEmployeesT = class(TUniFrame)
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
    QuerySuppliersID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
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

    procedure DataRefresh();
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack ���������� �������� �� ����� �������������� ������
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);


  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uEmployeesF;

{$R *.dfm}

procedure TEmployeesT.actAddExecute(Sender: TObject);
begin
  EmployeesF.FormAction := TFormAction.acInsert;
  EmployeesF.ShowModal(UserFCallBack);
end;

procedure TEmployeesT.actDeleteExecute(Sender: TObject);
begin
  EmployeesF.FormAction := TFormAction.acDelete;
  EmployeesF.ID := QuerySuppliersID.AsInteger;
  EmployeesF.ShowModal(UserFCallBack);
end;

procedure TEmployeesT.actEditExecute(Sender: TObject);
begin
  EmployeesF.FormAction := TFormAction.acUpdate;
  EmployeesF.ID := QuerySuppliersID.AsInteger;
  EmployeesF.ShowModal(UserFCallBack);
end;

procedure TEmployeesT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TEmployeesT.DataRefresh;
begin
  Query.Close;
  Query.Open;

  actEdit.Enabled := (actEdit.Tag = 1) and (Query.RecordCount >0);
  actDelete.Enabled := (actDelete.Tag = 1 ) and (Query.RecordCount >0);

  //Grid.ReadOnly := not actEdit.Enabled;
end;

procedure TEmployeesT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TEmployeesT.GridClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TEmployeesT.GridColumnFilter(Sender: TUniDBGrid;
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

procedure TEmployeesT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TEmployeesT.QueryAfterPost(DataSet: TDataSet);
begin
 // if FAction = acInsert then  Query.Refresh;
end;

procedure TEmployeesT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  DataRefresh;
end;

procedure TEmployeesT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if EmployeesF.FormAction = acInsert then
  begin
    DataRefresh;
  end;
  if EmployeesF.FormAction = acUpdate then
  begin
    DataRefresh;
  end;
  if EmployeesF.FormAction = acDelete then
  begin
    DataRefresh;
  end;
end;

initialization
  RegisterClass(TEmployeesT);
end.
