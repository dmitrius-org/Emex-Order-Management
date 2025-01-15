unit uStatisticOrders;

(*
  uStatisticOrders - монитор заказов

  15.01.2025
*)

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
  uniGridExporters, math,
  uUniADCheckComboBoxEx, uUniDateRangePicker;

type
  TStatisticOrders = class(TUniFrame)
    dsGridStatistics: TDataSource;
    qGridStatistics: TFDQuery;
    qGridStatisticsManufacturer: TStringField;
    qGridStatisticsDetailNumber: TWideStringField;
    qGridStatisticsDetailName: TWideStringField;
    qGridStatisticsOrderCount: TIntegerField;
    GridStatistics: TUniDBGrid;
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel6: TUniLabel;
    UniLabel4: TUniLabel;
    edtDataType: TUniFSComboBox;
    edtDataSize: TUniNumberEdit;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    UniLabel8: TUniLabel;
    fCancel: TUniBitBtn;
    edtPeriod: TUniDateRangePicker;
    procedure UniFrameCreate(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure GridStatisticsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcelExportButtonClick(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure GridStatisticsRefresh();
  public
    { Public declarations }
  end;

implementation

uses
  MainModule, uLogger;

{$R *.dfm}

procedure TStatisticOrders.fCancelClick(Sender: TObject);
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;

  edtPeriod.ClearDateRange;
  edtDataSize.Value := 100;
  cbCancel.ItemIndex:= 0;

  HideMask;
  UniSession.Synchronize;
end;

procedure TStatisticOrders.GridStatisticsKeyDown(Sender: TObject; var Key: Word;
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

procedure TStatisticOrders.GridStatisticsRefresh;
begin
  logger.Info('TStatisticsT.GridStatisticsRefresh');
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize();
  try
    if edtDataType.Value = '1' then  // Детали с наибольшим количеством уникальных заказов
    begin
      qGridStatistics.Close;
      qGridStatistics.sql.Text := '''
         -- Детали с наибольшим количеством уникальных заказов
         exec PartsMostUniqueOrdersList
                @RowSize   = :RowSize
               ,@isCancel  = :isCancel
               ,@DateBegin = :DateBegin
               ,@DateEnd   = :DateEnd

      ''';

      qGridStatistics.ParamByName('DateBegin').AsDateTime := edtPeriod.DateStart;
      qGridStatistics.ParamByName('DateEnd').AsDateTime := edtPeriod.DateEnd;
      qGridStatistics.ParamByName('RowSize').Value := edtDataSize.Value;

      if cbCancel.ItemIndex >= 0 then
        qGridStatistics.ParamByName('isCancel').AsBoolean := cbCancel.ItemIndex.ToBoolean
      else
        qGridStatistics.ParamByName('isCancel').Value := null;


      qGridStatistics.Open;
    end
    else
    if edtDataType.Value = '2' then //Детали с наибольшим количеством заказанных позиций
    begin
      qGridStatistics.Close;
      qGridStatistics.sql.Text := '''
         -- Детали с наибольшим количеством заказанных позиций
         exec PartsMostOrdersList
                @RowSize   = :RowSize
               ,@isCancel  = :isCancel
               ,@DateBegin = :DateBegin
               ,@DateEnd   = :DateEnd

      ''';

      qGridStatistics.ParamByName('DateBegin').AsDateTime := edtPeriod.DateStart;
      qGridStatistics.ParamByName('DateEnd').AsDateTime := edtPeriod.DateEnd;

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
  //  btnExcelExportButton.Enabled := qGridStatistics.RecordCount > 0;
  end;
end;

procedure TStatisticOrders.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridStatisticsRefresh;
end;

procedure TStatisticOrders.btnExcelExportButtonClick(Sender: TObject); var js : string;
begin
//  if qGridStatistics.RecordCount > 0 then
//  begin
//    GridStatistics.Exporter.Title := edtDataType.Text;
//    GridStatistics.Exporter.ExportGrid;
//  end;
end;

procedure TStatisticOrders.UniFrameCreate(Sender: TObject);
begin
  edtPeriod.DateStart := now();
  edtPeriod.DateEnd :=EnCodeDate(YearOf(Date), MonthOf(Date), 1);
end;

initialization
  RegisterClass(TStatisticOrders);

end.
