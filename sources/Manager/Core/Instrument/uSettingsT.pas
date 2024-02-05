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
    GridUsers: TUniDBGrid;
    Query: TFDQuery;
    DataSource: TDataSource;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
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

procedure TSettingsT.SetID(const Value: Integer);
begin
  FID := Value;

  DataRefresh;
end;

initialization
  RegisterClass(TSettingsT);

end.
