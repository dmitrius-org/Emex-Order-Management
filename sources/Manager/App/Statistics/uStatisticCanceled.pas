unit uStatisticCanceled;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, UniFSCombobox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniDateRangePicker, uUniADCheckComboBoxEx, uLogger, uniCheckBox, MainModule,
  cfs.GCharts.uniGUI, uUniADCheckComboBoxHelper;

type
  TStatisticCanceled = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel5: TUniLabel;
    fCancel: TUniBitBtn;
    dsCanceled: TDataSource;
    qCanceled: TFDQuery;
    UniLabel3: TUniLabel;
    edtOrderDate: TUniDateRangePicker;
    UniLabel2: TUniLabel;
    fPriceLogo: TUniADCheckComboBox;
    fClient: TUniADCheckComboBox;
    UniLabel1: TUniLabel;
    fPriceLogoF: TUniADCheckComboBox;
    fPriceLogoCancel: TUniCheckBox;
    qCanceledOrderDate: TSQLTimeStampField;
    qCanceledQuantityCancel: TIntegerField;
    qCanceledAmountCancel: TCurrencyField;
    ChartAverage: TuniGChartsFrame;
    qCanceledQuantityCancelEmex: TIntegerField;
    qCanceledAmountCancelEmex: TCurrencyField;
    qCanceledQuantityCancelManager: TIntegerField;
    qCanceledAmountCancelManger: TCurrencyField;
    qCanceledPrcCancel: TFloatField;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fCancelClick(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure btnGridStatisticOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

    /// <summary>
    /// CancelChart - Отказы
    /// </summary>
    procedure CancelChart();
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant, cfs.GCharts, System.Math;

procedure TStatisticCanceled.btnGridStatisticOpenClick(Sender: TObject);
begin
  CancelChart;
end;

procedure TStatisticCanceled.CancelChart;
var
  ChartCount: IcfsGChartProducer;
  Series: TArray<string>;
  max1: Integer;
begin
  max1 := 0;

  GridOpen;

  ChartCount := TcfsGChartProducer.Create;
  ChartCount.ClassChartType := TcfsGChartProducer.CLASS_COMBO_CHART;

  ChartCount.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано emex'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано менеджером'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Всего отказов (% отказа)'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);


  qCanceled.First;
  while not qCanceled.eof do
  begin
      ChartCount.Data.AddRow([qCanceled.FieldByName('OrderDate').Value,
                              qCanceled.FieldByName('QuantityCancelEmex').Value,
                              qCanceled.FieldByName('QuantityCancelEmex').Value,
                              qCanceled.FieldByName('QuantityCancelManager').Value,
                              qCanceled.FieldByName('QuantityCancelManager').Value,
                              0,
                              qCanceled.FieldByName('QuantityCancel').AsString + ' (' + qCanceled.FieldByName('PrcCancel').AsString + ' %)'
                              ]);



    max1 := max(max1, qCanceled.FieldByName('QuantityCancel').Value);

    qCanceled.Next;
  end;

  max1 := max1 + IfThen(max1>10, 15, 10);

// Г1
  with ChartCount do
  begin
    LibraryLanguage := UniSession.Language;
    Options.Title('Статистика отказов за период');
    Options.IsStacked(True);

    Options.hAxis('minValue', 0);

    SetLength(Series, IfThen(fClient.SelCount = 1, 4, 3));

    Series[0] := 'annotations: {    '+
                 '  stem: {         '+
                 '     length: 2  '+
                 '  } '+
                 '} ';

    Series[1] := 'annotations: {    '+
                 '  stem: {         '+
                 '     length: 15  '+
                 '  } '+
                 '} ';

    Series[2] := 'annotations: {    '+
                 '  stem: {         '+
                // '     color: "transparent",'+
                 '     length: 30  '+
                 '  }  '+
                 '} '+
                 '';

    Options.Series(Series);

    Options.hAxis('title', 'Дата заказа');

    begin
      Options.Series([
       '0: {type: "bars", targetAxisIndex: 0}',
       '1: {type: "bars", targetAxisIndex: 0}',
       '2: {type: "bars", targetAxisIndex: 0}'
      ]);
      Options.VAxes(['title: "Отказы (Количество)", maxValue: ' + max1.ToString])
    end;
  end;

  // Generate
  ChartAverage.DocumentInit;
  ChartAverage.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="ColumnChartCount" style="width: 100%"></div>'
    +   '</div>'
    + '</div>'
  );
  ChartAverage.DocumentGenerate('ColumnChartCount', ChartCount);
  ChartAverage.DocumentPost;

end;

procedure TStatisticCanceled.edtOrderDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TStatisticCanceled.fCancelClick(Sender: TObject);
begin
  fClient.ClearSelection;
  fPriceLogo.ClearSelection;
  fPriceLogoF.ClearSelection;
  fPriceLogoCancel.Checked := false;
  edtOrderDate.ClearDateRange;
end;

procedure TStatisticCanceled.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TStatisticCanceled.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    qCanceled.IndexName := Column.FieldName+'_index_asc'
  else
    qCanceled.IndexName := Column.FieldName+'_index_des';
end;

procedure TStatisticCanceled.GridOpen;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    qCanceled.Close();

    qCanceled.ParamByName('Clients').AsString := fClient.SelectedKeys;
    qCanceled.ParamByName('Prices').AsString := fPriceLogo.SelectedNames;
    qCanceled.ParamByName('PricesF').AsString := fPriceLogoF.SelectedNames;

    qCanceled.ParamByName('PricesFCan').asBoolean := fPriceLogoCancel.Checked;

    if (edtOrderDate.DateStart <> NullDate) and (edtOrderDate.DateEnd <> NullDate) then
    begin
      qCanceled.ParamByName('DateBegin').AsDateTime := edtOrderDate.DateStart;
      qCanceled.ParamByName('DateEnd').AsDateTime := edtOrderDate.DateEnd;
    end
    else
    begin
      qCanceled.ParamByName('DateBegin').Value := null;
      qCanceled.ParamByName('DateEnd').Value := null;
    end;

    qCanceled.Open();

  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TStatisticCanceled.UniFrameCreate(Sender: TObject);
begin
  fClient.IsValue := True;
  fClient.FillFromSQL('''
    DECLARE @R table (ID numeric(18, 0), Brief varchar(256), Name varchar(256)) ;

    insert @R
    EXEC OrderFilter_Client

    SELECT ID, Brief as Name from @R;
  ''');

  fPriceLogo.FillFromSQL('''
    DECLARE @R table (Name varchar(256)) ;

    insert @R
      EXEC StatisticCancelledFilter_OrderPriceLogo

    SELECT 0 ID, Name from @R;
  ''');

  fPriceLogoF.FillFromSQL('''
    DECLARE @R table (Name varchar(256)) ;

    insert @R
      EXEC StatisticCancelledFilter_PriceLogo

    SELECT 0 ID, Name from @R;
  ''');

end;

initialization
  RegisterClass(TStatisticCanceled);

end.
