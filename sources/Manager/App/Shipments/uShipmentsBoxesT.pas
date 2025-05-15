unit uShipmentsBoxesT;

interface

uses
  Windows, Messages, System.SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, uUniExComboBox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniExDateRangePicker, uUniExCheckComboBox, uniDBPivotGrid, uCommonType,
  uniGUIApplication, uUtils.Varriant, Vcl.Menus, uniMainMenu,
  System.Actions, Vcl.ActnList, uOrdersF, uUtils.Math;

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
    actMain: TUniActionList;
    actOrderEdit: TAction;
    ppMain: TUniPopupMenu;
    N12: TUniMenuItem;
    QueryOrderID: TFMTBCDField;
    UpdateSQL: TFDUpdateSQL;
    QueryWeightKGOld: TCurrencyField;
    QueryVolumeKGOld: TCurrencyField;
    QueryN: TIntegerField;
    QueryID: TIntegerField;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex, NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure GridColumnSummary(Column: TUniDBGridColumn; GroupFieldValue: Variant);
    procedure GridColumnSummaryResult(Column: TUniDBGridColumn; GroupFieldValue: Variant; Attribs: TUniCellAttribs; var Result: string);
    procedure GridColumnSummaryTotal(Column: TUniDBGridColumn; Attribs: TUniCellAttribs; var Result: string);
    procedure QueryTransporterPhysicalWeightGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure GridAfterLoad(Sender: TUniCustomDBGrid);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure GridDblClick(Sender: TObject);
    procedure actOrderEditExecute(Sender: TObject);
    procedure QueryWeightKGGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QueryWeightKGSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    FTransporterNumber: String;
//    FGroupFieldValue: Integer;
    FTransporterPhysicalWeight: Real;
    FTransporterVolumetricWeight: Real;
    FWeightKGS, FWeightKGSOld: Real;
    FVolumeKGS, FVolumeKGSOld: Real;
    FInvoice: String;

    FNoCollapseAll: Boolean;

    /// <summary>
    /// ACurrColumn - текущая колонка
    /// </summary>
    ACurrColumn: TUniDBGridColumn;

    /// <summary>
    ///  OrdersFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure OrdersFCallBack(Sender: TComponent; AResult:Integer);

  public
    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

    property TransporterNumber: String read FTransporterNumber write FTransporterNumber;
    property Invoice: String read FInvoice write FInvoice;
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant, System.Math, uUtils.Logger;

procedure TShipmentsBoxesT.actOrderEditExecute(Sender: TObject);
begin
  OrderF.FormAction := TFormAction.acUpdateShipments;
  OrderF.ID:=QueryOrderID.AsInteger;
  OrderF.IsCounter := False;

  OrderF.ShowModal(OrdersFCallBack);
end;

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

procedure TShipmentsBoxesT.OrdersFCallBack(Sender: TComponent;
  AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
    if OrderF.FormAction = acUpdateShipments then
    begin
      Query.RefreshRecord(False) ;
      Grid.RefreshCurrentRow(True);

      FNoCollapseAll := True;
    end;
  except
    on E: Exception do
      log('TShipmentsBoxesT.OrdersFCallBack Ошибка: ' + e.Message, etException);
  end;
end;

procedure TShipmentsBoxesT.GridAfterLoad(Sender: TUniCustomDBGrid);
begin
  if (not FNoCollapseAll) and (Query.RecordCount > 25) then
    grid.JSInterface.JSCall('view.features[0].collapseAll', []);
end;

procedure TShipmentsBoxesT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TShipmentsBoxesT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ACurrColumn := Column;

  ppMain.Popup(X, Y, Grid);
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
  if SameText(Column.FieldName, 'WeightKGS') then //Вес Физический Факт Сумма
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;
    if Column.AuxValues[3]=NULL then Column.AuxValues[3]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;  // сумма для группы по актуальным значениям
    Column.AuxValues[1]:=Column.AuxValues[1] + (QueryWeightKGOld.Value * QueryQuantity.Value); // сумма для группы по старым значениям

    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;   // сумма всего по актуальным значениям
    Column.AuxValues[3]:=Column.AuxValues[3] + (QueryWeightKGOld.Value * QueryQuantity.Value); // сумма всего по старым значениям

    FWeightKGS   :=Column.AuxValue;
    FWeightKGSOld:=Column.AuxValues[1];
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[1]=NULL then Column.AuxValues[1]:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;
    if Column.AuxValues[3]=NULL then Column.AuxValues[3]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;  // сумма для группы по актуальным значениям
    Column.AuxValues[1]:=Column.AuxValues[1] + (QueryVolumeKGOld.Value * QueryQuantity.Value); // сумма для группы по старым значениям

    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;   // сумма всего по актуальным значениям
    Column.AuxValues[3]:=Column.AuxValues[3] + (QueryVolumeKGOld.Value * QueryQuantity.Value); // сумма всего по старым значениям

    FVolumeKGS   :=Column.AuxValue;
    FVolumeKGSOld:=Column.AuxValues[1];
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;

    FTransporterPhysicalWeight:=Column.AuxValue;
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    if Column.AuxValue=NULL then Column.AuxValue:=0.0;
    if Column.AuxValues[2]=NULL then Column.AuxValues[2]:=0.0;

    Column.AuxValue:=Column.AuxValue + Column.Field.AsFloat;
    Column.AuxValues[2]:=Column.AuxValues[2] + Column.Field.AsFloat;

    FTransporterVolumetricWeight := Column.AuxValue;
  end
  else
  if SameText(Column.FieldName, 'BoxNumber') then
  begin
    Column.AuxValue:=Column.Field.AsString;
  end
end;

procedure TShipmentsBoxesT.GridColumnSummaryResult(Column: TUniDBGridColumn;
  GroupFieldValue: Variant; Attribs: TUniCellAttribs; var Result: string);
var Value, ValueOld: Real;
begin
  if SameText(Column.FieldName, 'WeightKGS') then
  begin
    Value:=Column.AuxValue;
    ValueOld:=Column.AuxValues[1];

    if (VarToDouble(Value) <> VarToDouble(ValueOld)) then
    begin
       Result:=FormatFloat('###,##0.000', ValueOld) + FormatFloat(' (###,##0.000) кг', Value);
    end
    else
      Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    Value:=Column.AuxValue;
    ValueOld:=Column.AuxValues[1];

    if (VarToDouble(Value) <> VarToDouble(ValueOld)) then
    begin
       Result:=FormatFloat('###,##0.000', ValueOld) + FormatFloat(' (###,##0.000) кг', Value);
    end
    else
      Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    Value:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    Value:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    Value:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    Value:=Column.AuxValue;
    Result:=FormatFloat('###,##0.000 кг', Value);
  end
  else
  if SameText(Column.FieldName, 'WeightL') then
  begin
    Value:= FTransporterPhysicalWeight - FWeightKGS;
    ValueOld:= FTransporterPhysicalWeight - FWeightKGSOld;

    if Value <> ValueOld  then
    begin
      Result:= ifthen(ValueOld>0, '+', '')   + FormatFloat('###,##0.000', ValueOld) +
               ifthen(Value>0, ' (+', ' (')  + FormatFloat('###,##0.000', Value ) + ') кг';
    end
    else
    begin
      Result:= ifthen(Value>0, '+', '')      + FormatFloat('###,##0.000 кг', Value);
    end;

    if ValueOld > 0 then
    begin
      Attribs.Color   := $008080FF;
    end
    else
    begin
      Attribs.Color   := $8ec9a6;
    end;
  end
  else
  if SameText(Column.FieldName, 'VolumeL') then
  begin
    Value:= FTransporterVolumetricWeight - FVolumeKGS;
    ValueOld:= FTransporterVolumetricWeight - FVolumeKGSold;

    if Value <> ValueOld  then
    begin
      Result:= ifthen(ValueOld>0, '+', '')   + FormatFloat('###,##0.000', ValueOld) +
               ifthen(Value>0, ' (+', ' (')  + FormatFloat('###,##0.000', Value ) + ') кг';
    end
    else
    begin
      Result:= ifthen(Value>0, '+', '')      + FormatFloat('###,##0.000 кг', Value);
    end;

    if ValueOld > 0 then
    begin
      Attribs.Color   := $008080FF;
    end
    else
    begin
      Attribs.Color   := $8ec9a6;
    end;
  end
  else
  if SameText(Column.FieldName, 'BoxNumber') then
  begin
    Result := Column.AuxValue;
  end;

  Column.AuxValue:=NULL;
  Column.AuxValues[1]:=NULL;
end;

procedure TShipmentsBoxesT.GridColumnSummaryTotal(Column: TUniDBGridColumn; Attribs: TUniCellAttribs; var Result: string);
  var  I, IO: Real;
begin
  if SameText(Column.FieldName, 'WeightKGS') then
  begin
    I:=Column.AuxValues[2];
    IO:=Column.AuxValues[3];

    if I <> IO then
       Result:=FormatFloat('###,##0.000', IO) + FormatFloat(' (###,##0.000) кг', I)
    else
      Result:=FormatFloat('###,##0.000 кг', I);

    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'VolumeKGS') then
  begin
    I :=Column.AuxValues[2];
    IO:=Column.AuxValues[3];

    if I <> IO then
       Result:=FormatFloat('###,##0.000', IO) + FormatFloat(' (###,##0.000) кг', I)
    else
      Result:=FormatFloat('###,##0.000 кг', I);

    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'SupplierPhysicalWeight') then
  begin
    I:=Column.AuxValues[2];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'TransporterPhysicalWeight') then
  begin
    I:=Column.AuxValues[2];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'SupplierVolumetricWeight') then
  begin
    I:=Column.AuxValues[2];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'TransporterVolumetricWeight') then
  begin
    I:=Column.AuxValues[2];
    Result:=FormatFloat('###,##0.000 кг', I);
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'WeightL') then
  begin
    I:= Grid.Columns.ColumnFromFieldName('TransporterPhysicalWeight').AuxValues[2]-
        Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValues[2];

    IO:= Grid.Columns.ColumnFromFieldName('TransporterPhysicalWeight').AuxValues[2]-
         Grid.Columns.ColumnFromFieldName('WeightKGS').AuxValues[3];

    if I <> IO  then
    begin
      Result:= ifthen(IO>0, '+', '')     + FormatFloat('###,##0.000', IO) +
               ifthen(I>0, ' (+', ' (')  + FormatFloat('###,##0.000', I ) + ') кг';
    end
    else
    begin
      Result:= ifthen(I>0, '+', '')      + FormatFloat('###,##0.000 кг', I);
    end;
    Attribs.Font.Style:=[fsBold];
  end
  else
  if SameText(Column.FieldName, 'VolumeL') then
  begin
    I:= Grid.Columns.ColumnFromFieldName('TransporterVolumetricWeight').AuxValues[2]-
        Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[2];


    IO:= Grid.Columns.ColumnFromFieldName('TransporterVolumetricWeight').AuxValues[2]-
        Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[3];

    if I <> IO then
    begin

      Result:= ifthen(IO>0, '+', '')      + FormatFloat('###,##0.000', I) +
               ifthen(I>0, ' (+', ' (')  + FormatFloat('###,##0.000', I) + ') кг';

//      Result:=FormatFloat('+###,##0.000 кг', I) +
//              FormatFloat(' (+##0.00%)', i/Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[2] * 100);
    end
    else
    begin
      Result:= ifthen(I>0, '+', '')      + FormatFloat('###,##0.000 кг', IO);
//      Result:=FormatFloat('###,##0.000 кг', I) +
//              FormatFloat(' (-##0.00%)', i/Grid.Columns.ColumnFromFieldName('VolumeKGS').AuxValues[2] * 100);
    end;
    Attribs.Font.Style:=[fsBold];
  end;
end;

procedure TShipmentsBoxesT.GridDblClick(Sender: TObject);
begin
 if (Assigned(ACurrColumn)) then
  if (ACurrColumn.FieldName = 'DetailNumber')
  then
  begin
    actOrderEditExecute(Sender);
  end;
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
    Query.ParamByName('Invoice').AsString := FInvoice;
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

procedure TShipmentsBoxesT.QueryWeightKGGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryWeightKG.Value <> QueryWeightKGOld.Value) then
  begin
    Text := FormatFloat('###,##0.000',  QueryWeightKGOld.Value)  + ' (' +  FormatFloat('###,##0.000',  QueryWeightKG.Value) + ') кг'  ;
  end
  else
    Text := Sender.AsString;
end;

procedure TShipmentsBoxesT.QueryWeightKGSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if (QueryWeightKG.Value <> QueryWeightKGOld.Value) then
  begin
    Text := FormatFloat('###,##0.000',  QueryWeightKGOld.Value * QueryQuantity.Value)  + ' (' +  FormatFloat('###,##0.000',  QueryWeightKG.Value * QueryQuantity.Value) + ') кг'  ;
  end
  else
    Text := Sender.AsString;
end;

procedure TShipmentsBoxesT.UniFrameCreate(Sender: TObject);
begin
  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

//  Query.AddIndex('BoxNumberIx', 'BoxNumber', '', []);
//with Grid.JSInterface do
//    JSCall('getView().setConfig', [JSObject(['stripeRows', True])]);
end;

initialization
  RegisterClass(TShipmentsBoxesT);

end.
