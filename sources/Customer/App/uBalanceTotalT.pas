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
  System.ImageList, Vcl.ImgList, uniGridExporters, uniButton,
  VCL.FlexCel.Core, FlexCel.XlsAdapter;

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
    procedure ShipmentsGridColumnActionClick(Column: TUniDBGridColumn;
      ButtonId: Integer);


  private
    { Private declarations }
    procedure ShipmentReportPrint();
    procedure ShipmentReportToExcel(FQuery: TFDQuery; const FileName: string);
  public
    { Public declarations }
    procedure GridRefresh;

    procedure ShipmentsGridRefresh;
  end;

implementation

uses
  MainModule, ServerModule, uMainVar;

{$R *.dfm}

{ TBalanceTotalT }

procedure TBalanceTotalT.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh;
  ShipmentsGridRefresh;
end;


procedure TBalanceTotalT.actShippmentReportPrintExecute(Sender: TObject);
begin
  ShipmentReportPrint;
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

procedure TBalanceTotalT.ShipmentReportPrint;
begin
  Sql.Open('''
    exec ExportImplementationByClient
              @Invoice  = :Invoice
             ,@ClientID = :ClientID
  ''', ['Invoice', 'ClientID'], [qShipments.FieldByName('Invoice').Value, UniMainModule.AUserID]);

  if Sql.Count > 0 then
  begin
    ShipmentReportToExcel(Sql.Q, 'InvoiceFull_' + qShipments.FieldByName('Invoice').Value+ '.xlsx');
  end;
end;

procedure TBalanceTotalT.ShipmentReportToExcel(FQuery: TFDQuery; const FileName: string);
var
  ExcelFile: TExcelFile;
  Row, Col: Integer;
  MemoryStream: TMemoryStream;

  excelTemplate: string;
begin
  // Инициализируем TExcelFile и загружаем шаблон
  ExcelFile := TXlsFile.Create;
  MemoryStream := TMemoryStream.Create;

  try

    excelTemplate := Sql.GetSetting('TemplateClientsShipments');

    ExcelFile.Open(excelTemplate);  // Загружаем шаблон Excel

    FQuery.First;
    Row := 3;  // Начинаем с 2-й строки, так как 1-я — заголовки

    // Проходим по записям DataSource и заполняем Excel
    while not FQuery.Eof do
    begin
      Col := 1;  // Начинаем с первого столбца

      ExcelFile.SetCellValue(1, 1, qShipments.FieldByName('Invoice').Value);

      // Заполняем ячейки данными из полей DataSet
      ExcelFile.SetCellValue(Row, Col, FQuery.FieldByName('ClientBrief').AsString);
      ExcelFile.SetCellValue(Row, Col + 1, FQuery.FieldByName('Manufacturer').AsString);

      ExcelFile.SetCellValue(Row, Col + 2, FQuery.FieldByName('DetailNumber').AsString);
      ExcelFile.SetCellValue(Row, Col + 3, FQuery.FieldByName('RManufacturer').AsString);
      ExcelFile.SetCellValue(Row, Col + 4, FQuery.FieldByName('RDetailNumber').AsString);
      ExcelFile.SetCellValue(Row, Col + 5, FQuery.FieldByName('DetailName').AsString);

      ExcelFile.SetCellValue(Row, Col + 6, FQuery.FieldByName('Quantity').AsInteger);

      ExcelFile.SetCellValue(Row, Col + 7, FQuery.FieldByName('PricePurchase').AsCurrency);
      ExcelFile.SetCellValue(Row, Col + 8, FQuery.FieldByName('AmountPurchase').AsCurrency);

      ExcelFile.SetCellValue(Row, Col + 9, FQuery.FieldByName('reference').AsString);
      ExcelFile.SetCellValue(Row, Col + 10, FQuery.FieldByName('CustomerSubId').AsString);
      ExcelFile.SetCellValue(Row, Col + 11, FQuery.FieldByName('OrderDetailSubId').AsString);
      ExcelFile.SetCellValue(Row, Col + 12, FQuery.FieldByName('Box').AsString);
      // Добавьте больше полей при необходимости...

      Inc(Row);
      FQuery.Next;
    end;

    // Сохраняем файл
    ExcelFile.Save(MemoryStream);
    MemoryStream.Position := 0; // Возвращаем указатель в начало потока

    // Отправка файла пользователю
    UniSession.SendStream(MemoryStream, FileName);
  finally
    ExcelFile.Free;
    MemoryStream.Free;
  end;
end;

procedure TBalanceTotalT.ShipmentsGridColumnActionClick(
  Column: TUniDBGridColumn; ButtonId: Integer);
begin
//  case ButtonId of
//    0 :
//      begin
//        ShowMessage('Grid custom action: ');
//        ShipmentReportPrint;
//      end;
//  end;
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
