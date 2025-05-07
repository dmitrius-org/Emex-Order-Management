unit uEmployeeOrdersProcessedT;

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
  uUniExDateRangePicker, uUniADCheckComboBoxEx;

type
  TEmployeeOrdersProcessedT = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel5: TUniLabel;
    fCancel: TUniBitBtn;
    Grid: TUniDBGrid;
    Source: TDataSource;
    Query: TFDQuery;
    UniLabel3: TUniLabel;
    edtOrderDate: TUniDateRangePicker;
    fEmployees: TUniADCheckComboBox;
    QueryEmployeeID: TFMTBCDField;
    QueryEmployeeName: TWideStringField;
    QueryProcessed: TIntegerField;
    QueryIncorrect: TIntegerField;
    QueryConfirmed: TIntegerField;
    QueryConfirmedSum: TFloatField;
    QueryProcessedSumAll: TFloatField;
    QueryProcessedSum: TFloatField;
    QueryIncorrectSum: TFloatField;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fCancelClick(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure btnGridStatisticOpenClick(Sender: TObject);
  private
    FEmployeeID: Integer;
    procedure SetEmployeeID(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }

    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

    property EmployeeID: Integer read FEmployeeID write SetEmployeeID;
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant;

procedure TEmployeeOrdersProcessedT.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
end;

procedure TEmployeeOrdersProcessedT.edtOrderDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TEmployeeOrdersProcessedT.fCancelClick(Sender: TObject);
begin
  fEmployees.ClearSelection;
  edtOrderDate.ClearDateRange;
end;

procedure TEmployeeOrdersProcessedT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TEmployeeOrdersProcessedT.SetEmployeeID(const Value: Integer);
begin
  FEmployeeID := Value;
end;

procedure TEmployeeOrdersProcessedT.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TEmployeeOrdersProcessedT.GridOpen;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    Query.Close();

    Query.ParamByName('Employees').AsString := fEmployees.SelectedKeys;

    if (edtOrderDate.DateStart <> NullDate) and (edtOrderDate.DateEnd <> NullDate) then
    begin
      Query.ParamByName('DateBegin').AsDateTime := edtOrderDate.DateStart;
      Query.ParamByName('DateEnd').AsDateTime := edtOrderDate.DateEnd;
    end
    else
    begin
      Query.ParamByName('DateBegin').Value := null;
      Query.ParamByName('DateEnd').Value := null;
    end;

    Query.Open();

  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TEmployeeOrdersProcessedT.UniFrameCreate(Sender: TObject);
begin
  ComboBoxFill(fEmployees,'''
    EXEC EmployeeOrdersProcessedT_EmployeeList
  ''');

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);
end;

initialization
  RegisterClass(TEmployeeOrdersProcessedT);

end.
