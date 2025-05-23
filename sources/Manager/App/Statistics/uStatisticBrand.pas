unit uStatisticBrand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, uUniExComboBox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniExDateRangePicker, uUniExCheckComboBox

  ;

type
  TStatisticBrand = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel5: TUniLabel;
    cbCancel: TUniComboBox;
    UniLabel8: TUniLabel;
    fCancel: TUniBitBtn;
    Grid: TUniDBGrid;
    dsBrand: TDataSource;
    qBrand: TFDQuery;
    UniLabel3: TUniLabel;
    edtOrderDate: TUniDateRangePicker;
    qBrandManufacturer: TWideStringField;
    qBrandDetailNumber: TWideStringField;
    qBrandDetailName: TWideStringField;
    qBrandDetailQuantity: TIntegerField;
    qBrandDetailAmount: TCurrencyField;
    qBrandQuantity: TIntegerField;
    fClient: TUniExCheckComboBox;
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
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant, uUtils.BusinessComboBoxHelper;

procedure TStatisticBrand.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
end;

procedure TStatisticBrand.edtOrderDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TStatisticBrand.fCancelClick(Sender: TObject);
begin
  fClient.ClearSelection;
  edtOrderDate.ClearDateRange;
end;

procedure TStatisticBrand.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TStatisticBrand.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    qBrand.IndexName := Column.FieldName+'_index_asc'
  else
    qBrand.IndexName := Column.FieldName+'_index_des';
end;

procedure TStatisticBrand.GridOpen;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    qBrand.Close();

    qBrand.ParamByName('Clients').AsString := fClient.SelectedKeys;

    if cbCancel.ItemIndex > -1 then
      qBrand.ParamByName('isCancel').AsBoolean := cbCancel.ItemIndex.ToBoolean
    else
      qBrand.ParamByName('isCancel').Value := null;

    if (edtOrderDate.DateStart <> NullDate) and (edtOrderDate.DateEnd <> NullDate) then
    begin
      qBrand.ParamByName('DateBegin').AsDateTime := edtOrderDate.DateStart;
      qBrand.ParamByName('DateEnd').AsDateTime := edtOrderDate.DateEnd;
    end
    else
    begin
      qBrand.ParamByName('DateBegin').Value := null;
      qBrand.ParamByName('DateEnd').Value := null;
    end;

    qBrand.Open();

  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TStatisticBrand.UniFrameCreate(Sender: TObject);
begin
  fClient.FillClients;

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);
end;

initialization
  RegisterClass(TStatisticBrand);

end.
