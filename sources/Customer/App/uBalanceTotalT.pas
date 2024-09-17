unit uBalanceTotalT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBasicGrid, uniDBGrid, uniGUIBaseClasses,
  uniPanel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TBalanceTotalT = class(TUniFrame)
    pnlOrder: TUniPanel;
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    QueryID: TFMTBCDField;
    QuerySpid: TIntegerField;
    QueryClientID: TFMTBCDField;
    QueryStatusName: TStringField;
    QueryOrderSum: TCurrencyField;
    QueryPaySum: TCurrencyField;
    QueryBalanceSum: TCurrencyField;
    QueryOperDate: TSQLTimeStampField;
    QueryOrderType: TStringField;
    QueryPayType: TStringField;
    QueryBalanceType: TStringField;
    QueryIsCalc: TBooleanField;
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure GridRefresh;
  end;

implementation

uses
  MainModule;

{$R *.dfm}

{ TBalanceTotalT }

procedure TBalanceTotalT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TBalanceTotalT.GridRefresh;
begin
  Query.Close;
  Query.ParamByName('ClientID').AsInteger := UniMainModule.AUserID;
  Query.Open;

  //Grid.Columns.ColumnFromFieldName('IsUpdating').Visible := Query.FieldByName('IsUpdatingExists').Value > 0;
end;

initialization
  RegisterClass(TBalanceTotalT);
end.
