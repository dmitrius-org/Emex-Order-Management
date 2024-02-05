unit uOrdersProtocol_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList;

type
  TOrdersProtocol_T = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    QueryProtocolID: TFMTBCDField;
    QueryObjectID: TFMTBCDField;
    QueryCurState: TWideStringField;
    QueryActionName: TWideStringField;
    QueryProtocDate: TSQLTimeStampField;
    QueryComment: TWideStringField;
    QueryName: TWideStringField;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    ppMain: TUniPopupMenu;
    N6: TUniMenuItem;
    QueryInDateTime: TSQLTimeStampField;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure UniFormShow(Sender: TObject);
  private
    FID: integer;
    procedure SetID(const Value: integer);

    procedure DataRefresh();
  public
    { Public declarations }

    property ID: integer read FID write SetID;
  end;

function OrdersProtocol_T: TOrdersProtocol_T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function OrdersProtocol_T: TOrdersProtocol_T;
begin
  Result := TOrdersProtocol_T(UniMainModule.GetFormInstance(TOrdersProtocol_T));
end;


procedure TOrdersProtocol_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TOrdersProtocol_T.DataRefresh;
begin
  Query.Close;
  Query.ParamByName('ID').AsInteger := FID;
  Query.Open;
end;

procedure TOrdersProtocol_T.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
end;

procedure TOrdersProtocol_T.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TOrdersProtocol_T.UniFormShow(Sender: TObject);
begin
  DataRefresh;
end;

end.
