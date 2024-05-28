unit uBalanceT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniPanel, uniDateTimePicker, uniButton, uniLabel, uniEdit, uniDBPivotGrid,
  System.ImageList, Vcl.ImgList, cxImageList, cxGraphics;

type
  TBalanceT = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    ppMain: TUniPopupMenu;
    N6: TUniMenuItem;
    UniPanel1: TUniPanel;
    UniButton1: TUniButton;
    edtDateEnd: TUniDateTimePicker;
    edtDateBegin: TUniDateTimePicker;
    QueryDocumentID: TFMTBCDField;
    QueryDocument: TStringField;
    QueryNumber: TWideStringField;
    QueryDate: TSQLTimeStampField;
    QueryAmount: TCurrencyField;
    QueryBalance: TCurrencyField;
    QueryComment: TWideStringField;
    QueryRest: TCurrencyField;
    UniPanel2: TUniPanel;
    edtBalance: TUniFormattedNumberEdit;
    UniLabel1: TUniLabel;
    btnBalanceAdd: TUniButton;
    cxImageList1: TcxImageList;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniButton1Click(Sender: TObject);
    procedure btnBalanceAddClick(Sender: TObject);
  private
    FID: integer;
    procedure SetID(const Value: integer);

    procedure DataRefresh();

    procedure BalanceAddCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }

    property ID: integer read FID write SetID;
  end;

function BalanceT: TBalanceT;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMainVar, uBalanceAddF, uCommonType;

function BalanceT: TBalanceT;
begin
  Result := TBalanceT(UniMainModule.GetFormInstance(TBalanceT));
end;

procedure TBalanceT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TBalanceT.BalanceAddCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if BalanceAddF.FormAction = acInsert then
  begin
    DataRefresh
  end;
end;

procedure TBalanceT.btnBalanceAddClick(Sender: TObject);
begin
  BalanceAddF.FormAction := TFormAction.acInsert;
  BalanceAddF.ClientID   := FID;
  BalanceAddF.ShowModal(BalanceAddCallBack);
end;

procedure TBalanceT.DataRefresh;
begin
  Query.Close;
  Query.ParamByName('ClientID').AsInteger := FID;
  Query.ParamByName('BDate').AsDate := edtDateBegin.DateTime;
  Query.ParamByName('EDate').AsDate := edtDateEnd.DateTime;
  Query.Open;

  edtBalance.Value := Query.FieldByName('Rest').AsCurrency;
end;

procedure TBalanceT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
end;

procedure TBalanceT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TBalanceT.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TBalanceT.UniButton1Click(Sender: TObject);
begin
  DataRefresh;
end;

procedure TBalanceT.UniFormShow(Sender: TObject);
begin
//  sql.Open('Select OrderID, Manufacturer, DetailNumber from tOrders (nolock) where OrderID=:OrderID',['OrderID'] , [FID]);
//
//  Self.Caption:= 'Протокол по [' +
//      sql.Q.FieldByName('OrderID').AsString + '] ' +
//      sql.Q.FieldByName('Manufacturer').AsString + ' ' +
//      sql.Q.FieldByName('DetailNumber').AsString;
//  sql.Q.Close;
  edtDateBegin.DateTime := Now();
  edtDateEnd.DateTime   := Now();

  DataRefresh;
end;

end.
