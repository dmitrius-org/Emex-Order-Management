unit uOrdersProtocol_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniLabel, uniMultiItem, uniComboBox, uniButton, uniPanel;

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
    UniPanel1: TUniPanel;
    UniButton1: TUniButton;
    fProtocol: TUniCheckComboBox;
    UniLabel3: TUniLabel;
    QueryProtocolType: TIntegerField;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniButton1Click(Sender: TObject);
    procedure fProtocolSelect(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
  private
    FID: integer;
    FFilterTextProtocol: string;

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
  MainModule, uniGUIApplication, uMainVar;

function OrdersProtocol_T: TOrdersProtocol_T;
begin
  Result := TOrdersProtocol_T(UniMainModule.GetFormInstance(TOrdersProtocol_T));
end;

procedure TOrdersProtocol_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TOrdersProtocol_T.DataRefresh;
var FProtocol:string;
begin
  if FFilterTextProtocol <> '' then FProtocol := ' and ProtocolType in (' + FFilterTextProtocol + ')'
  else
    FProtocol := '';

  Query.Close;
  Query.ParamByName('ID').AsInteger := FID;
  Query.MacroByName('ProtocolType').Value    := FProtocol;
  Query.Open;
end;

procedure TOrdersProtocol_T.fProtocolSelect(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextProtocol := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      //s:= s + integer((Sender as TUniCheckComboBox).Selected[i]).ToString +',';
      s:= s + i.ToString +',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextProtocol := s;
end;

procedure TOrdersProtocol_T.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
end;

procedure TOrdersProtocol_T.GridDrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (Query.FieldByName('ProtocolType').AsInteger = 1) then
  begin
    Attribs.Font.Color:=clGray//rgb(70 ,	68,	81);
    //Attribs.Font.Style:=[fsBold, fsItalic];
    //Attribs.Color:= rgb(181,184,177);
  end
end;

procedure TOrdersProtocol_T.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TOrdersProtocol_T.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TOrdersProtocol_T.UniButton1Click(Sender: TObject);
begin
  DataRefresh;
end;

procedure TOrdersProtocol_T.UniFormShow(Sender: TObject);
begin
  sql.Open('Select OrderID, Manufacturer, DetailNumber from tOrders (nolock) where OrderID=:OrderID',['OrderID'] , [FID]);

  Self.Caption:= 'Протокол по [' +
      sql.Q.FieldByName('OrderID').AsString + '] ' +
      sql.Q.FieldByName('Manufacturer').AsString + ' ' +
      sql.Q.FieldByName('DetailNumber').AsString;
  sql.Q.Close;

  fProtocol.Selected[0] := true;

  fProtocolSelect(fProtocol);

  DataRefresh;


end;

end.
