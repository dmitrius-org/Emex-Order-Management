unit uStatistics;

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
  UniFSCombobox, uniBasicGrid, uniDBGrid, uniBitBtn, uniSpeedButton,
  uniGridExporters, uStatisticBrand, uStatisticCanceled;

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
    qClient: TFDQuery;
    qClientClientID: TFMTBCDField;
    qClientBrief: TWideStringField;
    qClientName: TWideStringField;
    dsClient: TDataSource;
    fClient: TUniCheckComboBox;
    UniLabel3: TUniLabel;
    PageCommon: TUniPageControl;
    TabOrderChart: TUniTabSheet;
    TabOrders: TUniTabSheet;
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel6: TUniLabel;
    UniLabel4: TUniLabel;
    edtDataType: TUniFSComboBox;
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
    procedure UniFrameCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure GridStatisticsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcelExportButtonClick(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
    procedure TabBrandBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure TabCanceledBeforeFirstActivate(Sender: TObject;
      var AllowActivate: Boolean);
  private
    { Private declarations }
    FFilterTextClient: string;

    StatisticBrand :TStatisticBrand;
    StatisticCanceled :TStatisticCanceled;

    procedure FilterClientsCreate();

    procedure GridStatisticsRefresh();
  public
    { Public declarations }

    procedure AverageCountOrders();
  end;

implementation

uses
  MainModule, cfs.GCharts, uLogger;

{$R *.dfm}


procedure TStatisticsT.AverageCountOrders;
var
  //Defined as TInterfacedObject. No need try..finally
 // AreaChart: IcfsGChartProducer;
  ChartCount: IcfsGChartProducer;
  ChartSum:   IcfsGChartProducer;

  Series: TArray<string>;
var FClient:string;
begin
  if FFilterTextClient <> '' then FClient := ' and ClientID in (' + FFilterTextClient + ')'
  else
    FClient := '';


  qAverageCountOrders.Close;
  qAverageCountOrders.ParamByName('DateBegin').AsDate := edtDateBegin.DateTime;
  qAverageCountOrders.ParamByName('DateEnd').AsDate := edtDateEnd.DateTime;

  qAverageCountOrders.MacroByName('Client').Value    := FClient;

  qAverageCountOrders.Open;

  ChartCount := TcfsGChartProducer.Create;
  ChartCount.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;

  ChartCount.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'В работе'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Всего'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);


  ChartSum := TcfsGChartProducer.Create;
  ChartSum.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartSum.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'В работе'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Отказано'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Всего'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)

  ]);
  qAverageCountOrders.First;
  while not qAverageCountOrders.eof do
  begin
    ChartCount.Data.AddRow([qAverageCountOrders.FieldByName('OrderDate').Value,
                            qAverageCountOrders.FieldByName('WorkCount').Value,
                            qAverageCountOrders.FieldByName('WorkCount').Value,
                            qAverageCountOrders.FieldByName('CancelCount').Value,
                            qAverageCountOrders.FieldByName('CancelCount').Value,
                            0,
                            qAverageCountOrders.FieldByName('TotalCount').Value
                            ]);

    ChartSum.Data.AddRow([qAverageCountOrders.FieldByName('OrderDate').Value,
                          qAverageCountOrders.FieldByName('WorkSum').Value,
                          qAverageCountOrders.FieldByName('WorkSum').Value,
                          qAverageCountOrders.FieldByName('CancelSum').Value,
                          qAverageCountOrders.FieldByName('CancelSum').Value,
                          0,
                          qAverageCountOrders.FieldByName('TotalSum').Value
                          ]);

    qAverageCountOrders.Next;
  end;

// Г1
  with ChartCount do
  begin
    LibraryLanguage := UniSession.Language;
    Options.Title('Количество заказов по дням за период');
    Options.IsStacked(True);
//  ColumnChartCount.Options.Legend('position', 'none');
//  ChartCount.Options.Annotations('alwaysOutside', True);
//    Options.Annotations('alwaysOutside', True);
//    Options.Annotations('displayAnnotationsFilter', True);
//    Options.Annotations('legendPosition', 'newRow');
    Options.hAxis('minValue', 0);
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
                // '     color: "transparent",'+
                 '     length: 30  '+
                 '  }  '+
                 '} '+
                 //'type: "Bar"' +
                 '';
    Options.Series(Series);


    Options.hAxis('title', 'Дни');
    Options.vAxis('title', 'Заказы (Количество)');
    Options.vAxis('title', 'Заказы (Количество)');
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

procedure TStatisticsT.fClientSelect(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextClient := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      s:= s + integer((Sender as TUniCheckComboBox).Items.Objects[i]).ToString +',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextClient := s;
end;

procedure TStatisticsT.FilterClientsCreate;
begin
  qClient.Open(); // используется в фильтре Клиент

  fClient.Clear;
  qClient.First;
  while not qClient.Eof do
  begin
    fClient.Items.AddObject( qClient.FieldByName('Brief').AsString, Pointer(qClient.FieldByName('ClientID').AsInteger) );
    qClient.Next;
  end;

  fClient.Refresh;
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
  logger.Info('TStatisticsT.GridStatisticsRefresh');
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
      logger.Info(edtBeginDate2.DateTime.ToString) ;
      logger.Info(cbCancel.ItemIndex.ToBoolean.ToString());

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

      logger.Info(cbCancel.ItemIndex.ToBoolean.ToString());
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

procedure TStatisticsT.btnExcelExportButtonClick(Sender: TObject); var js : string;
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
     PageCommon.ActivePage := TabBrand;

     edtDateBegin.DateTime := IncDay(now(), -7);
  {$ENDIF}
  edtDateEnd.DateTime := now();

  edtEndDate2.DateTime := now();
  edtBeginDate2.DateTime :=EnCodeDate(YearOf(Date), MonthOf(Date), 1);

  FilterClientsCreate;

  AverageCountOrders;
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
