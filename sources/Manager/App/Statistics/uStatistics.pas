﻿unit uStatistics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,  DateUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGroupBox, uniDateTimePicker, uniChart,
  uniGUIBaseClasses, uniPanel, unimChart, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniLabel, uniButton,
  cfs.GCharts.uniGUI, uniMultiItem, uniComboBox, uniPageControl, uniEdit,
  uUniExComboBox, uniBasicGrid, uniDBGrid, uniBitBtn, uniSpeedButton,
  uniGridExporters, uStatisticBrand, uStatisticCanceled, math,
  uUniExCheckComboBox;

type
  TStatisticsT = class(TUniFrame)
    qAverageCountOrders: TFDQuery;
    dsAverageCountOrders: TDataSource;
    UniPanel1: TUniPanel;
    UniLabel1: TUniLabel;
    edtDateBegin: TUniDateTimePicker;
    UniLabel2: TUniLabel;
    edtDateEnd: TUniDateTimePicker;
    UniButton1: TUniButton;
    UniPanel2: TUniPanel;
    ChartAverage: TuniGChartsFrame;
    UniLabel3: TUniLabel;
    PageCommon: TUniPageControl;
    TabOrderChart: TUniTabSheet;
    TabOrders: TUniTabSheet;
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel6: TUniLabel;
    UniLabel4: TUniLabel;
    edtDataType: TUniExComboBox;
    edtDataSize: TUniNumberEdit;
    dsGridStatistics: TDataSource;
    qGridStatistics: TFDQuery;
    GridStatistics: TUniDBGrid;
    qGridStatisticsManufacturer: TStringField;
    qGridStatisticsDetailNumber: TWideStringField;
    qGridStatisticsDetailName: TWideStringField;
    qGridStatisticsOrderCount: TIntegerField;
    UniGridExcelExporter1: TUniGridExcelExporter;
    btnExcelExportButton: TUniButton;
    UniLabel5: TUniLabel;
    edtBeginDate2: TUniDateTimePicker;
    edtEndDate2: TUniDateTimePicker;
    UniLabel7: TUniLabel;
    cbCancel: TUniComboBox;
    UniLabel8: TUniLabel;
    fCancel: TUniBitBtn;
    TabBrand: TUniTabSheet;
    TabCanceled: TUniTabSheet;
    fClient: TUniExCheckComboBox;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure GridStatisticsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcelExportButtonClick(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
    procedure TabBrandBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure TabCanceledBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure UniFrameReady(Sender: TObject);
  private
    { Private declarations }
    StatisticBrand :TStatisticBrand;
    StatisticCanceled :TStatisticCanceled;

    procedure GridStatisticsRefresh();
  public
    { Public declarations }
    /// <summary>
    /// AverageCountOrders - Статистика по заказам. Количество и сумма заказов за период.
    /// </summary>
    procedure AverageCountOrders();
  end;

implementation

uses
  MainModule, cfs.GCharts, uUtils.BusinessComboBoxHelper;

{$R *.dfm}


procedure TStatisticsT.AverageCountOrders;
var
  ChartCount: IcfsGChartProducer;
  ChartSum:   IcfsGChartProducer;
  Series: TArray<string>;
  max1: Integer;
  max2: Integer;
begin
  max1 := 0;
  max2 := 0;

  qAverageCountOrders.Close;
  qAverageCountOrders.ParamByName('DateBegin').AsDate := edtDateBegin.DateTime;
  qAverageCountOrders.ParamByName('DateEnd').AsDate := edtDateEnd.DateTime;
  qAverageCountOrders.ParamByName('Clients').Value    := fClient.SelectedKeys;
  qAverageCountOrders.Open;

  ChartCount := TcfsGChartProducer.Create;
  //ChartCount.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartCount.ClassChartType := TcfsGChartProducer.CLASS_COMBO_CHART;

  ChartCount.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'В работе'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано менеджером'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано поставщиком'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Всего'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);

  if fClient.SelCount = 1 then
    ChartCount.Data.Columns.Add(TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Наценка %'));

  ChartSum := TcfsGChartProducer.Create;
  ChartSum.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartSum.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'В работе'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано менеджером'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано поставщиком'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Всего'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)

  ]);

  qAverageCountOrders.First;
  while not qAverageCountOrders.eof do
  begin
    if fClient.SelCount = 1 then
      ChartCount.Data.AddRow([qAverageCountOrders.FieldByName('OrderDate').Value,
                              qAverageCountOrders.FieldByName('WorkCount').Value,
                              qAverageCountOrders.FieldByName('WorkCount').Value,
                              qAverageCountOrders.FieldByName('CancelOurCount').Value,
                              qAverageCountOrders.FieldByName('CancelOurCount').Value,
                              qAverageCountOrders.FieldByName('CancelSupplierCount').Value,
                              qAverageCountOrders.FieldByName('CancelSupplierCount').Value,
                              0,
                              qAverageCountOrders.FieldByName('TotalCount').Value,
                              qAverageCountOrders.FieldByName('Margin').Value  // Наценка
                              ])
    else
      ChartCount.Data.AddRow([qAverageCountOrders.FieldByName('OrderDate').Value,
                              qAverageCountOrders.FieldByName('WorkCount').Value,
                              qAverageCountOrders.FieldByName('WorkCount').Value,
                              qAverageCountOrders.FieldByName('CancelOurCount').Value,
                              qAverageCountOrders.FieldByName('CancelOurCount').Value,
                              qAverageCountOrders.FieldByName('CancelSupplierCount').Value,
                              qAverageCountOrders.FieldByName('CancelSupplierCount').Value,
                              0,
                              qAverageCountOrders.FieldByName('TotalCount').Value
                              ]);

    ChartSum.Data.AddRow([qAverageCountOrders.FieldByName('OrderDate').Value,
                          qAverageCountOrders.FieldByName('WorkSum').Value,
                          qAverageCountOrders.FieldByName('WorkSum').Value,
                          qAverageCountOrders.FieldByName('CancelOurSum').Value,
                          qAverageCountOrders.FieldByName('CancelOurSum').Value,
                          qAverageCountOrders.FieldByName('CancelSupplierSum').Value,
                          qAverageCountOrders.FieldByName('CancelSupplierSum').Value,
                          0,
                          qAverageCountOrders.FieldByName('TotalSum').Value
                          ]);

    max1 := max(max1, qAverageCountOrders.FieldByName('WorkCount').Value);
    max2 := max(max2, Trunc(qAverageCountOrders.FieldByName('Margin').Value));

    qAverageCountOrders.Next;
  end;


  max1 := max1 + IfThen(max1>1000, round(max1*0.1), round(max1*0.25));
  max2 := max2 + IfThen(max2>10, 2, 1);

// Г1
  with ChartCount do
  begin
    LibraryLanguage := UniSession.Language;
    Options.Title('Количество заказов по дням за период');
    Options.IsStacked(True);

    Options.hAxis('minValue', 0);

    SetLength(Series, IfThen(fClient.SelCount = 1, 5, 4));

    Options.hAxis('title', 'Дни');

    if fClient.SelCount = 1 then
    begin
      Options.Series([
       '0: {type: "bars", targetAxisIndex: 0}',
       '1: {type: "bars", targetAxisIndex: 0}',
       '2: {type: "bars", targetAxisIndex: 0}',
       '3: {type: "bars", targetAxisIndex: 0}',
       '4: {type: "line", targetAxisIndex: 1}'
      ]);

      Options.VAxes(['title: "Заказы (Количество)", maxValue: ' + max1.ToString,
                     'title: "Наценка %" , maxValue: ' +  max2.ToString]);
     // Options.VAxis('viewWindowMode', 'pretty');
    end
    else
    begin
      Options.Series([
       '0: {type: "bars", targetAxisIndex: 0}',
       '1: {type: "bars", targetAxisIndex: 0}',
       '2: {type: "bars", targetAxisIndex: 0}',
       '3: {type: "bars", targetAxisIndex: 0}'
      ]);
      Options.VAxes(['title: "Заказы (Количество)", viewWindowMode: "pretty", maxValue: ' + max1.ToString]); //
    end;
  end;

// Г2
  ChartSum.LibraryLanguage := UniSession.Language;
  ChartSum.Options.Title('Сумма заказов по дням за период');
  ChartSum.Options.IsStacked(True);
  ChartSum.Options.hAxis('title', 'Дни');
  ChartSum.Options.hAxis('minValue', 0);
//  ChartSum.Options.hAxis('format', 'decimal');
  ChartSum.Options.vAxis('title', 'Заказы (Сумма)');

  SetLength(Series, 3);
  Series[0] := 'annotations: {    '+
                 '  stem: {         '+
                 '     length: 2  '+
                 '  }  '+
                 '} ';
  Series[1] := 'annotations: {    '+
                 '  stem: {         '+
                 '     length: 15  '+
                 '  }  '+
                 '} ';
  Series[2] := 'annotations: {    '+
                 '  stem: {         '+
                 '     length: 30  '+
                 '  }  '+
                 '} ';
  ChartSum.Options.Series(Series);

  // Generate
  ChartAverage.DocumentInit;
  ChartAverage.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="ColumnChartCount" style="width: 50%"></div>'
    +   '<div id="ColumnChartSum" style="width: 50%"></div>'
    +   '</div>'
    + '</div>'
  );
  ChartAverage.DocumentGenerate('ColumnChartCount', ChartCount);
  ChartAverage.DocumentGenerate('ColumnChartSum', ChartSum);
  ChartAverage.DocumentPost;
end;

procedure TStatisticsT.fCancelClick(Sender: TObject);
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  edtBeginDate2.Text := '';
  edtEndDate2.Text := '';
//  edtDataType.Text := '';
  edtDataSize.Value := 100;
  cbCancel.ItemIndex:= 0;
  HideMask;
  UniSession.Synchronize;
end;

procedure TStatisticsT.GridStatisticsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(Key) = 'C') AND (Shift = [SSCTRL]) then
  begin
    if (Sender is TUniDBGrid) then
    begin
      GridStatistics.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TStatisticsT.GridStatisticsRefresh;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize();
  try
    if edtDataType.Value = '1' then
    begin
      qGridStatistics.Close;
      qGridStatistics.sql.Text := '''
         exec PartsMostUniqueOrdersList
                @RowSize   = :RowSize
               ,@isCancel  = :isCancel
               ,@DateBegin = :DateBegin
               ,@DateEnd   = :DateEnd

      ''';

      qGridStatistics.ParamByName('DateBegin').AsDateTime := edtBeginDate2.DateTime;
      qGridStatistics.ParamByName('DateEnd').AsDateTime := edtEndDate2.DateTime;
      qGridStatistics.ParamByName('RowSize').Value := edtDataSize.Value;
      if cbCancel.ItemIndex >= 0 then
        qGridStatistics.ParamByName('isCancel').AsBoolean := cbCancel.ItemIndex.ToBoolean
      else
        qGridStatistics.ParamByName('isCancel').Value := null;

      qGridStatistics.Open;
    end
    else
    if edtDataType.Value = '2' then
    begin
      qGridStatistics.Close;
      qGridStatistics.sql.Text := '''
         exec PartsMostOrdersList
                @RowSize   = :RowSize
               ,@isCancel  = :isCancel
               ,@DateBegin = :DateBegin
               ,@DateEnd   = :DateEnd

      ''';

      qGridStatistics.ParamByName('DateBegin').Value := edtBeginDate2.text;
      qGridStatistics.ParamByName('DateEnd').Value := edtEndDate2.text;
      qGridStatistics.ParamByName('RowSize').Value := edtDataSize.Value;
      if cbCancel.ItemIndex >= 0 then
        qGridStatistics.ParamByName('isCancel').AsBoolean := cbCancel.ItemIndex.ToBoolean
      else
        qGridStatistics.ParamByName('isCancel').Value := null;
      qGridStatistics.Open;
    end;

  finally
    HideMask();
    UniSession.Synchronize();
    btnExcelExportButton.Enabled := qGridStatistics.RecordCount > 0;
  end;
end;

procedure TStatisticsT.UniButton1Click(Sender: TObject);
begin
  AverageCountOrders;
end;

procedure TStatisticsT.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridStatisticsRefresh
end;

procedure TStatisticsT.btnExcelExportButtonClick(Sender: TObject);
begin
  if qGridStatistics.RecordCount > 0 then
  begin
    GridStatistics.Exporter.Title := edtDataType.Text;
    GridStatistics.Exporter.ExportGrid;
  end;
end;

procedure TStatisticsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
     edtDateBegin.DateTime := IncDay(now(), -10);
  {$ELSE}
     PageCommon.ActivePage := TabOrderChart;

     edtDateBegin.DateTime := IncDay(now(), -7);
  {$ENDIF}
  edtDateEnd.DateTime := now();

  edtEndDate2.DateTime := now();
  edtBeginDate2.DateTime :=EnCodeDate(YearOf(Date), MonthOf(Date), 1);

  AverageCountOrders;
end;

procedure TStatisticsT.UniFrameReady(Sender: TObject);
begin
  fClient.FillClients;
end;

procedure TStatisticsT.TabCanceledBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(StatisticCanceled) then
  begin
    StatisticCanceled :=  TStatisticCanceled.Create(Self);
    StatisticCanceled.Align := alClient;
    StatisticCanceled.Parent := TabCanceled;
  end;
end;

procedure TStatisticsT.TabBrandBeforeFirstActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  if not Assigned(StatisticBrand) then
  begin
    StatisticBrand :=  TStatisticBrand.Create(Self);
    StatisticBrand.Align := alClient;
    StatisticBrand.Parent := TabBrand;
  end;
end;

initialization
  RegisterClass(TStatisticsT);

end.
