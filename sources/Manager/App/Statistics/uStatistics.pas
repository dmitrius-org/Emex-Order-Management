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
  cfs.GCharts.uniGUI, uniMultiItem, uniComboBox;

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
    procedure UniFrameCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
  private
    { Private declarations }
    FFilterTextClient: string;

    procedure FilterClientsCreate();
  public
    { Public declarations }

    procedure AverageCountOrders();
  end;

implementation

uses
  MainModule, cfs.GCharts;

{$R *.dfm}


procedure TStatisticsT.AverageCountOrders;
var
  //Defined as TInterfacedObject. No need try..finally
 // AreaChart: IcfsGChartProducer;
  ColumnChartCount: IcfsGChartProducer;
  ColumnChartSum:   IcfsGChartProducer;
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

  ColumnChartCount := TcfsGChartProducer.Create;
  ColumnChartCount.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ColumnChartCount.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Количество заказов'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);



 ColumnChartSum := TcfsGChartProducer.Create;
  ColumnChartSum.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ColumnChartSum.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'День'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Сумма заказов'),
//    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
//    ROLE_ANOTATION
//    ROLE_STYLE
  ]);
  qAverageCountOrders.First;
  while not qAverageCountOrders.eof do
  begin
   // Profit := qAverageCountOrders.FieldByName('Sales').AsCurrency - FClientDataSet.FieldByName('Expenses').AsCurrency;
    ColumnChartCount.Data.AddRow;
    ColumnChartCount.Data.SetValue(0, qAverageCountOrders.FieldByName('d').Value);
    ColumnChartCount.Data.SetValue(1, qAverageCountOrders.FieldByName('orderCount').Value);
    ColumnChartCount.Data.SetValue(2, qAverageCountOrders.FieldByName('orderCount').Value);
    //ColumnChart.Data.SetValue(2, qAverageCountOrders.FieldByName('orderSum').Value);
    //if Profit < 0 then
    //  ColumnChart.Data.SetValue(2, 'red');

    ColumnChartSum.Data.AddRow;
    ColumnChartSum.Data.SetValue(0, qAverageCountOrders.FieldByName('d').Value);
    ColumnChartSum.Data.SetValue(1, qAverageCountOrders.FieldByName('orderSum').AsCurrency);
    ColumnChartSum.Data.SetValue(2, qAverageCountOrders.FieldByName('orderSum').Value);
    //ColumnChart.Data.SetValue(2, qAverageCountOrders.FieldByName('orderSum').Value);
    //if Profit < 0 then
    //  ColumnChart.Data.SetValue(2, 'red');
    qAverageCountOrders.Next;
  end;

// Г1
  ColumnChartCount.Options.Title('Количество заказов по дням за период');
//  ColumnChartCount.Options.Legend('position', 'none');
  ColumnChartCount.LibraryLanguage := UniSession.Language;
  ColumnChartCount.Options.hAxis('title', 'Дни');
  ColumnChartCount.Options.hAxis('minValue', 0);
  ColumnChartCount.Options.vAxis('title', 'Заказы (Количество)');



// Г2
  ColumnChartSum.Options.Title('Сумма заказов по дням за период');
//  ColumnChartSum.Options.Legend('position', 'none');
  ColumnChartSum.LibraryLanguage := UniSession.Language;
//  ColumnChartSum.Options.Annotations('alwaysOutside', True);
//  ColumnChartSum.Options.Annotations('textStyle', '{fontSize: 12, auraColor: ''none'', color: ''#555''}');
//  ColumnChartSum.Options.Annotations('boxStyle', '{stroke: ''#ccc'', strokeWidth: 1, gradient: {color1: ''#f3e5f5'', color2: ''#f3e5f5'', x1: ''0%'', y1: ''0%'', x2: ''100%'', y2: ''100%'' }}');
  ColumnChartSum.Options.hAxis('title', 'Дни');
  ColumnChartSum.Options.hAxis('minValue', 0);
  ColumnChartSum.Options.vAxis('title', 'Заказы (Сумма)');

  // Generate
  ChartAverage.DocumentInit;
  ChartAverage.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="ColumnChartCount" style="width: 50%"></div>'
    +   '<div id="ColumnChartSum" style="width: 50%"></div>'
    +   '</div>'
    + '</div>'
  );
  ChartAverage.DocumentGenerate('ColumnChartCount', ColumnChartCount);
  ChartAverage.DocumentGenerate('ColumnChartSum', ColumnChartSum);
  ChartAverage.DocumentPost;
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

procedure TStatisticsT.UniButton1Click(Sender: TObject);
begin
  AverageCountOrders;
end;

procedure TStatisticsT.UniFrameCreate(Sender: TObject);
begin
  edtDateBegin.DateTime := IncDay(now(), -7);
  {$IFDEF Debug}
  edtDateBegin.DateTime := IncDay(now(), -90);
  {$ENDIF}
  edtDateEnd.DateTime := now();



  FilterClientsCreate;

  AverageCountOrders;
end;

initialization
  RegisterClass(TStatisticsT);

end.
