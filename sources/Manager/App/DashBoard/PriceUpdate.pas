unit PriceUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TPriceUpdateT = class(TUniFrame)
    DataSource: TDataSource;
    Query: TFDQuery;
    Grid: TUniDBGrid;
    QueryPriceName: TStringField;
    QueryUpdateDate: TSQLTimeStampField;
    QueryUpdateDays: TIntegerField;
    procedure UniFrameReady(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure DataRefresh();
  end;

implementation

uses
  MainModule;

{$R *.dfm}



procedure TPriceUpdateT.DataRefresh;
begin
  Query.Close;
  Query.Open;
end;



procedure TPriceUpdateT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (Query.FieldByName('UpdateDays').AsInteger = 0) then
  begin
    Attribs.Font.Color:=clMaroon;
    Attribs.Font.Style:=[fsBold, fsItalic];
    Attribs.Color:= rgb(153,204,0);
  end
  else
  if (Query.FieldByName('UpdateDays').AsInteger = 1) then
  begin
    Attribs.Color:=rgb(255,219,88);
  end
  else
    Attribs.Color:=rgb(255,77,77);

end;

procedure TPriceUpdateT.UniFrameReady(Sender: TObject);
begin
  DataRefresh;
end;

initialization
  RegisterClass(TPriceUpdateT);
end.
