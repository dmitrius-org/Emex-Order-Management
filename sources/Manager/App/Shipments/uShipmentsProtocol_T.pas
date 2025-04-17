unit uShipmentsProtocol_T;

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
  TShipmentsProtocol_T = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    ProtocolQuery: TFDQuery;
    ProtocolQueryProtocolID: TFMTBCDField;
    ProtocolQueryObjectID: TFMTBCDField;
    ProtocolQueryCurState: TWideStringField;
    ProtocolQueryActionName: TWideStringField;
    ProtocolQueryProtocDate: TSQLTimeStampField;
    ProtocolQueryComment: TWideStringField;
    ProtocolQueryName: TWideStringField;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    ppMain: TUniPopupMenu;
    N6: TUniMenuItem;
    ProtocolQueryInDateTime: TSQLTimeStampField;
    UniPanel1: TUniPanel;
    btnFilter: TUniButton;
    fProtocol: TUniCheckComboBox;
    UniLabel3: TUniLabel;
    ProtocolQueryProtocolType: TIntegerField;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFilterClick(Sender: TObject);
    procedure fProtocolSelect(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    FID: integer;
    FFilterTextProtocol: string;

    procedure SetID(const Value: integer);

    procedure DataRefresh();
  public
    { Public declarations }

    property ID: integer read FID write SetID;
  end;

function ShipmentsProtocol_T: TShipmentsProtocol_T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMainVar;

function ShipmentsProtocol_T: TShipmentsProtocol_T;
begin
  Result := TShipmentsProtocol_T(UniMainModule.GetFormInstance(TShipmentsProtocol_T));
end;

procedure TShipmentsProtocol_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TShipmentsProtocol_T.DataRefresh;
var FProtocol:string;
begin
//  try
    if FFilterTextProtocol <> '' then FProtocol := ' and ProtocolType in (' + FFilterTextProtocol + ')'
    else
      FProtocol := '';

    ProtocolQuery.Close();
    ProtocolQuery.ParamByName('ID').AsLargeInt := FID;
    ProtocolQuery.MacroByName('ProtocolType').Value := FProtocol;
    ProtocolQuery.Open();

//  finally
//    grid.ScreenMask.HideMask;
//    UniSession.Synchronize;
//  end;
end;

procedure TShipmentsProtocol_T.fProtocolSelect(Sender: TObject);
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
      s:= s + i.ToString +',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextProtocol := s;
end;

procedure TShipmentsProtocol_T.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
end;

procedure TShipmentsProtocol_T.GridDrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (ProtocolQuery.FieldByName('ProtocolType').AsInteger in [1]) then
  begin
    Attribs.Font.Color:=clGray//rgb(70 ,	68,	81);
    //Attribs.Font.Style:=[fsBold, fsItalic];
    //Attribs.Color:= rgb(181,184,177);
  end
end;

procedure TShipmentsProtocol_T.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TShipmentsProtocol_T.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TShipmentsProtocol_T.btnFilterClick(Sender: TObject);
begin
  DataRefresh;
end;

procedure TShipmentsProtocol_T.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ProtocolQuery.Close;
end;

procedure TShipmentsProtocol_T.UniFormShow(Sender: TObject);  var i: Integer;
begin
  sql.Open('Select ShipmentsID, Invoice from tShipments (nolock) where ShipmentsID=:ShipmentsID',['ShipmentsID'] , [FID]);

  Self.Caption:= 'Протокол по [' +
    'ID: ' +  sql.Q.FieldByName('ShipmentsID').AsString + '] ' +
    'Invoice: ' +  sql.Q.FieldByName('Invoice').AsString;
  sql.Q.Close;

  // по умолчанию покзываем 3 основных действия
  for i:= 0 to 1 do
  begin
    fProtocol.Selected[i] := True;
  end;

  fProtocolSelect(fProtocol);

  DataRefresh;
end;

end.
