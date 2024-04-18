unit uSettingsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Actions, Vcl.ActnList, uniMainMenu,
  Vcl.Menus, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TSettingsT = class(TUniFrame)
    Grid: TUniDBGrid;
    Query: TFDQuery;
    DataSource: TDataSource;
    PopupMenu: TUniPopupMenu;
    N6: TUniMenuItem;
    ActionList: TUniActionList;
    actEdit: TAction;
    actRefreshAll: TAction;
    QuerySettingsID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    QueryComment: TWideStringField;
    QueryVal: TWideStringField;
    QuerySettingType: TIntegerField;
    UpdateSQL: TFDUpdateSQL;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
  private
    FID: Integer;
    { Private declarations }
    procedure DataRefresh();
    function GetID: Integer;
    procedure SetID(const Value: Integer);

  public
    { Public declarations }
    property ID: Integer read GetID write SetID;
  end;

implementation

uses
  uLogger;

{$R *.dfm}

procedure TSettingsT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Refresh
end;

procedure TSettingsT.DataRefresh;
begin
    Query.Close();
    Query.ParamByName('GroupID').Value := FID;
    Query.Open();
end;

function TSettingsT.GetID: Integer;
begin
  Result:=FID;
end;

procedure TSettingsT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid);
end;

procedure TSettingsT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TSettingsT.SetID(const Value: Integer);
begin
  FID := Value;

  DataRefresh;
end;

initialization
  RegisterClass(TSettingsT);

end.
