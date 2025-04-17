unit uPartProtocol_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniLabel, uniMultiItem, uniComboBox, uniButton, uniPanel, uUtils.Grid,
  uCommonType, uniImageList, System.ImageList, Vcl.ImgList;

type
  TPartProtocol_T = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    ProtocolQuery: TFDQuery;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    ppMain: TUniPopupMenu;
    N6: TUniMenuItem;
    ProtocolQueryMakeLogo: TStringField;
    ProtocolQueryBrand: TStringField;
    ProtocolQueryDetailNum: TStringField;
    ProtocolQueryDetailName: TStringField;
    ProtocolQueryWeightKG: TFloatField;
    ProtocolQueryVolumeKG: TFloatField;
    ProtocolQueryRestrictions: TStringField;
    ProtocolQueryFragile: TBooleanField;
    ProtocolQueryUserName: TStringField;
    ProtocolQueryupdDateTime: TSQLTimeStampField;
    ProtocolQueryNLA: TBooleanField;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFilterClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFormCreate(Sender: TObject);
  private
    FID: integer;
    FFilterTextProtocol: string;

    procedure SetID(const Value: integer);

    procedure DataRefresh();
  public
    { Public declarations }

    property ID: integer read FID write SetID;
  end;

/// <summary>
/// PartProtocol_T - протокол изменения детали
/// </summary>
function PartProtocol_T: TPartProtocol_T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMainVar;

function PartProtocol_T: TPartProtocol_T;
begin
  Result := TPartProtocol_T(UniMainModule.GetFormInstance(TPartProtocol_T));
end;

procedure TPartProtocol_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TPartProtocol_T.DataRefresh;
var FProtocol:string;
begin
    ProtocolQuery.Close();
    ProtocolQuery.ParamByName('OrderID').AsLargeInt := FID;
    ProtocolQuery.Open();
end;

procedure TPartProtocol_T.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TPartProtocol_T.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
end;

procedure TPartProtocol_T.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TPartProtocol_T.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TPartProtocol_T.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    ProtocolQuery.IndexName := Column.FieldName+'_index_asc'
  else
    ProtocolQuery.IndexName := Column.FieldName+'_index_des';
end;

procedure TPartProtocol_T.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TPartProtocol_T.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TPartProtocol_T.btnFilterClick(Sender: TObject);
begin
  DataRefresh;
end;

procedure TPartProtocol_T.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ProtocolQuery.Close;
end;

procedure TPartProtocol_T.UniFormCreate(Sender: TObject);
begin
  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);
end;

procedure TPartProtocol_T.UniFormShow(Sender: TObject);  var i: Integer;
begin
// sql.Open('Select OrderID, Manufacturer, DetailNumber from tOrders (nolock) where OrderID=:OrderID',['OrderID'] , [FID]);
//
//  Self.Caption:= 'Протокол по [' +
//      sql.Q.FieldByName('OrderID').AsString + '] ' +
//      sql.Q.FieldByName('Manufacturer').AsString + ' ' +
//      sql.Q.FieldByName('DetailNumber').AsString;
//  sql.Q.Close;

  DataRefresh;
end;

end.
