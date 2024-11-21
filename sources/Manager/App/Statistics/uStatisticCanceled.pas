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
  uUniDateRangePicker, uUniADCheckComboBoxEx, uLogger, uniCheckBox

  ;

type
  TStatisticCanceled = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    UniLabel5: TUniLabel;
    fCancel: TUniBitBtn;
    Grid: TUniDBGrid;
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
    qCanceledQuantity: TIntegerField;
    qCanceledAmount: TCurrencyField;
    qCanceledQuantityCancel: TIntegerField;
    qCanceledAmountCancel: TCurrencyField;
    qCanceledPrcCancel: TFMTBCDField;
    procedure UniFrameCreate(Sender: TObject);
//    procedure fClientSelect(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fCancelClick(Sender: TObject);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
  private
    { Private declarations }
    //FClients: TFDMemTable;
//    FFilterTextClient: string;
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

uses uUtils.Grid, uMainVar, uConstant;

procedure TStatisticCanceled.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
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

//procedure TStatisticCanceled.fClientSelect(Sender: TObject);
////
////  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
////  begin
////    if (Sender as TUniCheckComboBox).Selected[i] = True then
////    begin
////      FClients.AppendRecord([integer((Sender as TUniCheckComboBox).Items.Objects[i])]);
////    end;
////  end;
//end;

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

//    qBrand.ParamByName('Clients').DataType := ftDataSet;
//    qBrand.ParamByName('Clients').AsDataSet := FClients;
    logger.Info(fClient.SelectedKeys);
    logger.Info(fClient.SelectedItems);

    qCanceled.ParamByName('Clients').AsString := fClient.SelectedKeys;
    qCanceled.ParamByName('Prices').AsString := fPriceLogo.SelectedItems;
    qCanceled.ParamByName('PricesF').AsString := fPriceLogoF.SelectedItems;

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
  ComboBoxFill(fClient,'''
    DECLARE @R table (ID numeric(18, 0), Brief varchar(256), Name varchar(256)) ;

    insert @R
    EXEC OrderFilter_Client

    SELECT ID, Brief as Name from @R;
  ''');

  ComboBoxFill(fPriceLogo,'''
    DECLARE @R table (Name varchar(256)) ;

    insert @R
      EXEC StatisticCancelledFilter_PriceLogo

    SELECT 0 ID, Name from @R;
  ''');

  ComboBoxFill(fPriceLogoF,'''
    DECLARE @R table (Name varchar(256)) ;

    insert @R
      EXEC StatisticCancelledFilter_PriceLogo

    SELECT 0 ID, Name from @R;
  ''');


//  FClients := TFDMemTable.Create(nil);
//  FClients.FieldDefs.Add('ID', ftFMTBcd);
//  FClients.CreateDataSet;

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

end;

procedure TStatisticCanceled.UniFrameDestroy(Sender: TObject);
begin
//  FClients.Free;
end;

initialization
  RegisterClass(TStatisticCanceled);

end.
