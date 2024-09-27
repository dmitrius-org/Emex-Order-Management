unit uBalanceTotalT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBasicGrid, uniDBGrid, uniGUIBaseClasses,
  uniPanel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, uniMainMenu, uniImageList,
  System.ImageList, Vcl.ImgList, uniGridExporters, uniButton;

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
    ShipmentsGrid: TUniDBGrid;
    qShipments: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    IntegerField1: TIntegerField;
    FMTBCDField2: TFMTBCDField;
    StringField1: TStringField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    CurrencyField3: TCurrencyField;
    SQLTimeStampField1: TSQLTimeStampField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    BooleanField1: TBooleanField;
    dsShipments: TDataSource;
    qShipmentsInvoice: TStringField;
    UniPanel1: TUniPanel;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    UniImageList: TUniImageList;
    UniImageListAdapter: TUniImageListAdapter;
    actShippmentReportPrint: TAction;
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actShippmentReportPrintExecute(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure GridRefresh;

    procedure ShipmentsGridRefresh;
  end;

implementation

uses
  MainModule, ServerModule;

{$R *.dfm}

{ TBalanceTotalT }

procedure TBalanceTotalT.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh;
  ShipmentsGridRefresh;
end;


procedure TBalanceTotalT.actShippmentReportPrintExecute(Sender: TObject);
begin
 //
end;

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

procedure TBalanceTotalT.ShipmentsGridRefresh;
begin
  qShipments.Close;
  qShipments.ParamByName('ClientID').AsInteger := UniMainModule.AUserID;
  qShipments.Open;
end;


initialization
  RegisterClass(TBalanceTotalT);
end.
