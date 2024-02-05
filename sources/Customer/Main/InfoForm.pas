unit InfoForm;

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
  TInfo = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Info: TInfo;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function Info: TInfo;
begin
  Result := TInfo(UniMainModule.GetFormInstance(TInfo));
end;

procedure TInfo.UniFormShow(Sender: TObject);
begin
  Query.Open;
end;

end.
