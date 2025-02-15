unit uShipmentsBoxesT;

interface

uses
  Windows, Messages, System.SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, UniFSCombobox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniDateRangePicker, uUniADCheckComboBoxEx, uniDBPivotGrid, uCommonType,
  uniGUIApplication, uLogger, uUtils.Varriant

  ;

type
  TShipmentsBoxesT = class(TUniFrame)
    UniPanel3: TUniPanel;
    Source: TDataSource;
    Query: TFDQuery;
    Grid: TUniDBGrid;
    QueryShipmentsBoxesID: TFMTBCDField;
    QueryBoxNumber: TFMTBCDField;
    QueryClientName: TStringField;
    QueryManufacturer: TStringField;
    QueryDetailNumber: TStringField;
    QueryDetailName: TStringField;
    QueryManufacturerReplacement: TStringField;
    QueryDetailNumberReplacement: TStringField;
    QueryQuantity: TIntegerField;
    QueryPricePurchase: TCurrencyField;
    QueryAmountPurchase: TCurrencyField;
    QueryWeightKG: TCurrencyField;
    QueryWeightKGS: TCurrencyField;
    QuerySupplierPhysicalWeight: TFloatField;
    QueryTransporterPhysicalWeight: TFloatField;
    QueryVolumeKG: TCurrencyField;
    QueryVolumeKGS: TCurrencyField;
    QuerySupplierVolumetricWeight: TFloatField;
    QueryTransporterVolumetricWeight: TFloatField;
    QueryOrderDetailSubId: TStringField;
    QueryCustomerSubId: TStringField;
    QueryReference: TStringField;
    QueryWeightL: TIntegerField;
    QueryVolumeL: TIntegerField;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure GridColumnSummary(Column: TUniDBGridColumn;
      GroupFieldValue: Variant);
    procedure GridColumnSummaryResult(Column: TUniDBGridColumn;
      GroupFieldValue: Variant; Attribs: TUniCellAttribs; var Result: string);
    procedure GridColumnSummaryTotal(Column: TUniDBGridColumn;
      Attribs: TUniCellAttribs; var Result: string);
    procedure QueryTransporterPhysicalWeightGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure GridAfterLoad(Sender: TUniCustomDBGrid);
  private
    FTransporterNumber: String;

    FGroupFieldValue: Integer;


    FTransporterPhysicalWeight: Real;
    FTransporterVolumetricWeight: Real;
    FWeightKGS: Real;
    FVolumeKGS: Real;


    procedure SetTransporterNumber(const Value: String);
    { Private declarations }
  public
    { Public declarations }

    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

    property TransporterNumber: String read FTransporterNumber write SetTransporterNumber;
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant;

procedure TShipmentsBoxesT.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
end;

procedure TShipmentsBoxesT.edtOrderDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TShipmentsBoxesT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TShipmentsBoxesT.SetTransporterNumber(const Value: String);
begin
  FTransporterNumber := Value;

  GridOpen;
end;

procedure TShipmentsBoxesT.GridAfterLoad(Sender: TUniCustomDBGrid);
begin
  if Query.RecordCount > 25 then
       grid.JSInterface.JSCall('view.features[0].collapseAll', []);
end;

procedure TShipmentsBoxesT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
//  ppMain.Popup(X, Y, Grid);
end;

procedure TShipmentsBoxesT.GridColumnMove(Column: TUniBaseDBGridColumn;
  OldIndex, NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TShipmentsBoxesT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TShipmentsBoxesT.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  if Direction then
    Query.IndexName := Column.FieldName+'_index_asc'
  else
    Query.IndexName := Column.FieldName+'_index_des';
end;

procedure TShipmentsBoxesT.GridColumnSummary(Column: TUniDBGridColumn; GroupFieldValue: Variant);
begin
  //logger.Info('GridColumnSummary: ' + Column.FieldName);

  if SameText(Column.FieldName, 'WeightKGS') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;

    FWeightKGS:=Column.AuxValue;
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;

    FVolumeKGS:=Column.AuxValue;
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;

    FTransporterPhysicalWeight:=Column.AuxValue;
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[1]:=Column.AuxValues[1] + Column.Field.AsFloat;

    FTransporterVolumetricWeight := Column.AuxValue;
  end
//  else
//  if SameText(Column.FieldName, 'WeightL') then
//  begin
//    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
//    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;
//
//    //Column.AuxValue + Column.Field.AsFloat;
//  end
//  else
//  if SameText(Column.FieldName, 'VolumeL') then
//  begin
//    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
//    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;
//
//    //Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
//  end
end;

procedure TShipmentsBoxesT.GridColumnSummaryResult(Column: TUniDBGridColumn;
  GroupFieldValue: Variant; Attribs: TUniCellAttribs; var Result: string);
var I: Real;
begin
  //logger.Info('GridColumnSummaryResult: ' + Column.FieldName);
  if SameText(Column.FieldName, 'WeightKGS') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    I:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', I);
  end
  else
  if SameText(Column.FieldName, 'WeightL') then
  begin
    I:=FTransporterPhysicalWeight - FWeightKGS;

    //VarToDouble(Grid.Columns.ColumnFromFieldName('TransporterPhysicalWeight').AuxValue) -
    //Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValue;

    if i > 0 then
    begin
      Result:=FormatFloat('+##0.000 кг', I);
      Attribs.Color   := $008080FF;
    end
    else
    begin
      Result:=FormatFloat('##0.000 кг', I);
      Attribs.Color   := $8ec9a6;
    end;
  end
  else
  if SameText(Column.FieldName, 'VolumeL') then
  begin
    I:=FTransporterVolumetricWeight - FVolumeKGS;
//    Grid.Columns.ColumnFromFieldName('TransporterVolumetricWeight').AuxValue -
//       Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValue;

    if i > 0 then
    begin
      Result:=FormatFloat('+##0.000 кг', I);
      Attribs.Color   := $008080FF;
    end
    else
    begin
      Result:=FormatFloat('##0.000 кг', I);
      Attribs.Color   := $8ec9a6;
    end;
  end;



//  FTransporterPhysicalWeight:=0;
//  FWeightKGS:=0;
  Column.AuxValue:=NULL;
end;

procedure TShipmentsBoxesT.GridColumnSummaryTotal(Column: TUniDBGridColumn;
  Attribs: TUniCellAttribs; var Result: string);
  var
  I : Real;
begin
  if SameText(Column.FieldName, 'WeightKGS') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
    //Attribs.Font.Color:=clGray;
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    I:=Column.AuxValues[1];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'WeightL') then
  begin
    I:= Grid.Columns.ColumnFromFieldName('TransporterPhysicalWeight').AuxValues[1]-
        Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValues[1];

    if i > 0 then
    begin
      Result:=FormatFloat('+###,##0.000 кг', I) +
              FormatFloat(' (+##0.00%)', i/Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValues[1] * 100);
    end
    else
    begin
      Result:=FormatFloat('###,##0.000 кг', I) +
              FormatFloat(' (-##0.00%)', i/Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValues[1] * 100);
    end;
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'VolumeL') then
  begin
    I:= Grid.Columns.ColumnFromFieldName('TransporterVolumetricWeight').AuxValues[1]-
        Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[1];

    if i > 0 then
    begin
      Result:=FormatFloat('+###,##0.000 кг', I) +
              FormatFloat(' (+##0.00%)', i/Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[1] * 100);
    end
    else
    begin
      Result:=FormatFloat('###,##0.000 кг', I) +
              FormatFloat(' (-##0.00%)', i/Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[1] * 100);
    end;
    Attribs.Font.Style:=[fsBold];
  end
end;

procedure TShipmentsBoxesT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TShipmentsBoxesT.GridOpen;
begin
  ShowMask('Ждите, операция выполняется');
  //UniSession.Synchronize;
  try
    Query.Close();
    Query.ParamByName('TransporterNumber').AsString := FTransporterNumber;
    Query.Open();
  finally
    HideMask();
   // UniSession.Synchronize;
  end;
end;

procedure TShipmentsBoxesT.QueryTransporterPhysicalWeightGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:='';
end;

procedure TShipmentsBoxesT.UniFrameCreate(Sender: TObject);
begin
  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

//  Query.AddIndex('BoxNumberIx', 'BoxNumber', '', []);
end;

initialization
  RegisterClass(TShipmentsBoxesT);

end.
