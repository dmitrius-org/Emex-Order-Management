unit uError_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TError_T = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    QueryObjectID: TFMTBCDField;
    QueryRetval: TFMTBCDField;
    QueryMessage: TWideStringField;
    QueryMakeLogo: TWideStringField;
    QueryManufacturer: TWideStringField;
    QueryDetailNumber: TWideStringField;
    QueryReference: TWideStringField;
    QueryCustomerSubId: TWideStringField;
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Error_T: TError_T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function Error_T: TError_T;
begin
  Result := TError_T(UniMainModule.GetFormInstance(TError_T));
end;

procedure TError_T.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TError_T.UniFormShow(Sender: TObject);
begin
  Query.Close;
  Query.Open;
end;

end.
