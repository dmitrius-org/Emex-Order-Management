unit uExportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Vcl.Menus, uniMainMenu, uniBasicGrid, uniDBGrid,
  uniPanel, uniPageControl, uniGUIBaseClasses, uniGridExporters, System.Actions,
  Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TExportForm = class(TUniForm)
    PG: TUniPageControl;
    TabNomenclature: TUniTabSheet;
    GridNomenclature: TUniDBGrid;
    pmNomenclature: TUniPopupMenu;
    ExportNomenclature: TUniGridExcelExporter;
    actMain: TUniActionList;
    actRefreshNomenclatureAll: TAction;
    actExportNomenklature: TAction;
    FDExportNomenclature: TFDQuery;
    FDExportNomenclatureManufacturer: TWideStringField;
    FDExportNomenclatureDetailNumber: TWideStringField;
    FDExportNomenclatureDetailNumberDetailName: TWideStringField;
    FDExportNomenclatureManufacturerDetailNumber: TWideStringField;
    FDExportNomenclatureWeightKGF: TFloatField;
    DSNomenklature: TDataSource;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    tabAdmission: TUniTabSheet;
    FDExportAdmission: TFDQuery;
    dsAdmission: TDataSource;
    ExportAdmission: TUniGridExcelExporter;
    pmAdmission: TUniPopupMenu;
    UniMenuItem1: TUniMenuItem;
    UniMenuItem2: TUniMenuItem;
    GridAdmission: TUniDBGrid;
    ectExportAdmission: TAction;
    actRefreshAdmission: TAction;
    FDExportAdmissionDetailNumber: TWideStringField;
    FDExportAdmissionManufacturerDetailNumber: TWideStringField;
    FDExportAdmissionDetailNumberDetailName: TWideStringField;
    FDExportAdmissionRManufacturerDetailNumber: TWideStringField;
    FDExportAdmissionCustomerSubId: TWideStringField;
    FDExportAdmissionQuantity: TIntegerField;
    FDExportAdmissionPricePurchaseF: TCurrencyField;
    FDExportAdmissionAmountPurchaseF: TCurrencyField;
    FDExportAdmissionManufacturer: TWideStringField;
    tabImplementation: TUniTabSheet;
    pmImplementation: TUniPopupMenu;
    UniMenuItem3: TUniMenuItem;
    UniMenuItem4: TUniMenuItem;
    qImplementation: TFDQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    IntegerField1: TIntegerField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    WideStringField6: TWideStringField;
    dsImplementation: TDataSource;
    ExportImplementation: TUniGridExcelExporter;
    GridImplementation: TUniDBGrid;
    actExportImplementation: TAction;
    actRefreschImplementation: TAction;
    qImplementationClientBrief: TWideStringField;
    FDExportNomenclatureBarCode: TWideStringField;
    qImplementationBox: TWideStringField;
    qImplementationreference: TWideStringField;
    FDExportAdmissionreference: TWideStringField;
    tabFragile: TUniTabSheet;
    UniDBGrid1: TUniDBGrid;
    dsFragile: TDataSource;
    actFragileRefresh: TAction;
    pmFragile: TUniPopupMenu;
    UniMenuItem5: TUniMenuItem;
    UniMenuItem6: TUniMenuItem;
    ExportFragile: TUniGridExcelExporter;
    actExportFragile: TAction;
    GridFragile: TUniDBGrid;
    qFragile: TFDQuery;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    IntegerField2: TIntegerField;
    CurrencyField3: TCurrencyField;
    CurrencyField4: TCurrencyField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    FDExportNomenclatureClientBrief: TWideStringField;
    procedure GridNomenclatureCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actExportNomenklatureExecute(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure ectExportAdmissionExecute(Sender: TObject);
    procedure actRefreshAdmissionExecute(Sender: TObject);
    procedure GridAdmissionCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actExportImplementationExecute(Sender: TObject);
    procedure actRefreschImplementationExecute(Sender: TObject);
    procedure GridImplementationCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridImplementationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actFragileRefreshExecute(Sender: TObject);
    procedure GridFragileCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actExportFragileExecute(Sender: TObject);
  private
    FInvoice: String;
    procedure SetInvoice(const Value: String);

    { Private declarations }
  public
    { Public declarations }

    property Invoice:String  read FInvoice write SetInvoice;

    procedure NomenklatureRefresh();
    procedure AdmissionRefresh();
    procedure ImplementationRefresh();

    procedure FragileRefresh();
  end;

function ExportForm: TExportForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uLogger;

function ExportForm: TExportForm;
begin
  Result := TExportForm(UniMainModule.GetFormInstance(TExportForm));
end;

procedure TExportForm.actExportFragileExecute(Sender: TObject);
begin
  GridFragile.Exporter.FileName :=  FInvoice + '-Хрупкое';
  GridFragile.Exporter.Title := FInvoice + '-Хрупкое';
  GridFragile.Exporter.ExportGrid;
end;

procedure TExportForm.actExportImplementationExecute(Sender: TObject);
begin
  GridImplementation.Exporter.FileName :=  FInvoice + '-Реализация';
  GridImplementation.Exporter.Title := FInvoice + '-Реализация';
  GridImplementation.Exporter.ExportGrid;
end;

procedure TExportForm.actExportNomenklatureExecute(Sender: TObject);
begin
  GridNomenclature.Exporter.FileName := FInvoice + '-Номенклатура';
  GridNomenclature.Exporter.Title := FInvoice + '-Номенклатура';
  GridNomenclature.Exporter.ExportGrid;
end;

procedure TExportForm.actFragileRefreshExecute(Sender: TObject);
begin
  FragileRefresh;
end;

procedure TExportForm.actRefreschImplementationExecute(Sender: TObject);
begin
  ImplementationRefresh;
end;

procedure TExportForm.actRefreshAdmissionExecute(Sender: TObject);
begin
  AdmissionRefresh;
end;

procedure TExportForm.AdmissionRefresh;
begin
  FDExportAdmission.Close;
  FDExportAdmission.ParamByName('Invoice').AsWideString := FInvoice;
  FDExportAdmission.Open;
end;

procedure TExportForm.ectExportAdmissionExecute(Sender: TObject);
begin
  GridAdmission.Exporter.FileName := FInvoice + '-Поступление';
  GridAdmission.Exporter.Title := FInvoice + '-Поступление';
  GridAdmission.Exporter.ExportGrid;
end;

procedure TExportForm.FragileRefresh;
begin
  qFragile.Close;
  qFragile.ParamByName('Invoice').AsWideString := FInvoice;
  qFragile.Open;
end;

procedure TExportForm.GridAdmissionCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  pmAdmission.Popup(X, Y, GridAdmission);
end;

procedure TExportForm.GridFragileCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  pmFragile.Popup(X, Y, GridFragile);
end;

procedure TExportForm.GridImplementationCellContextClick(
  Column: TUniDBGridColumn; X, Y: Integer);
begin
  pmImplementation.Popup(X, Y, GridImplementation);
end;

procedure TExportForm.GridImplementationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      (Sender as TUniDBGrid).JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TExportForm.GridNomenclatureCellContextClick(Column: TUniDBGridColumn;
  X, Y: Integer);
begin
  pmNomenclature.Popup(X, Y, GridNomenclature);
end;

procedure TExportForm.ImplementationRefresh;
begin
  qImplementation.Close;
  qImplementation.ParamByName('Invoice').AsWideString := FInvoice;
  qImplementation.Open;
end;

procedure TExportForm.NomenklatureRefresh;
begin
  FDExportNomenclature.Close;
  FDExportNomenclature.ParamByName('Invoice').AsWideString := FInvoice;
  FDExportNomenclature.Open;
end;

procedure TExportForm.SetInvoice(const Value: String);
begin
  FInvoice := Value;
end;

procedure TExportForm.UniFormShow(Sender: TObject);
begin
  PG.ActivePage := TabNomenclature;
  NomenklatureRefresh;

  AdmissionRefresh;

  ImplementationRefresh;

  FragileRefresh;

  self.Caption := 'ExportForm. Поставка: ' + FInvoice;
end;


end.
