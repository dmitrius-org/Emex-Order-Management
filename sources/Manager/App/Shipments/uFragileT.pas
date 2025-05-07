unit uFragileT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseT, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniGUIBaseClasses, uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid,
  uniDBGrid, uniGUIClasses, uniPanel, uniCheckBox, uniEdit, uniLabel,
  uniMultiItem, uniComboBox, uniButton, uniBitBtn, uniGroupBox, uniGridExporters,
  uUniExCheckComboBoxHelper, uUniExCheckComboBox;

type
  TFragileT = class(TBaseT)
    gbFilter: TUniGroupBox;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    UniLabel3: TUniLabel;
    QueryDetailNumber: TWideStringField;
    QueryManufacturerDetailNumber: TWideStringField;
    QueryDetailNumberDetailName: TWideStringField;
    QueryRManufacturerDetailNumber: TWideStringField;
    QueryCustomerSubId: TWideStringField;
    QueryQuantity: TIntegerField;
    QueryPricePurchaseF: TCurrencyField;
    QueryAmountPurchaseF: TCurrencyField;
    QueryManufacturer: TWideStringField;
    Queryreference: TWideStringField;
    fSupplier: TUniExCheckComboBox;
    QuerySupplierBrief: TWideStringField;
    procedure fCancelClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure fOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DataRefresh(); override;
  end;

var
  FragileT: TFragileT;

implementation

{$R *.dfm}

procedure TFragileT.DataRefresh;
begin
  ShowMask('∆дите, операци€ выполн€етс€');
  UniSession.Synchronize;
  try
    Query.Close;
    Query.ParamByName('Suppliers').AsString := fSupplier.SelectedKeys;
    Query.Open;

  finally
    HideMask();
    UniSession.Synchronize;
  end;

  inherited;
end;

procedure TFragileT.fCancelClick(Sender: TObject);
begin
  fSupplier.ClearSelection;
end;

procedure TFragileT.fOkClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TFragileT.UniFrameCreate(Sender: TObject);
begin
  inherited;
  fSupplier.FillFromSQL('select SuppliersID as ID, Brief as Name from tSuppliers (nolock) where SuppliersID<>8');
end;

initialization
  RegisterClass(TFragileT);

end.
