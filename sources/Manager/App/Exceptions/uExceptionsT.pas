unit uExceptionsT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseT, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniGUIBaseClasses, uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid,
  uniDBGrid, uniToolBar, uniGUIClasses, uniPanel, uniCheckBox, uniEdit,
  uniMultiItem, uniComboBox, uUniExCheckComboBox, uUniExDateRangePicker,
  uniBitBtn, uniLabel, uniButton, uUtils.BusinessComboBoxHelper, uniGroupBox;

type
  TExceptionsT = class(TBaseT)
    QueryBrand: TStringField;
    QueryDetailNum: TStringField;
    QueryDetailName: TStringField;
    QueryDetailNameF: TStringField;
    QueryWeightKGF: TFloatField;
    QueryVolumeKGf: TFloatField;
    QueryFragile: TBooleanField;
    QueryNLA: TBooleanField;
    QueryPartID: TFMTBCDField;
    gbFilter: TUniGroupBox;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    UniLabel3: TUniLabel;
    fType: TUniExCheckComboBox;
    fDetailNum: TUniEdit;
    UniLabel1: TUniLabel;
    N1: TUniMenuItem;
    QueryNoAir: TBooleanField;
    procedure UniFrameCreate(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
    procedure fOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DataRefresh(); override;
  end;

var
  ExceptionsT: TExceptionsT;

implementation

{$R *.dfm}


procedure TExceptionsT.DataRefresh;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    Query.Close;
    Query.ParamByName('Types').AsString := fType.SelectedKeys;
    Query.ParamByName('DetailNum').AsString := fDetailNum.Text;

    Query.Open;

    inherited;
  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TExceptionsT.fCancelClick(Sender: TObject);
begin
  fType.ClearSelection;
  fDetailNum.Clear;
end;

procedure TExceptionsT.fOkClick(Sender: TObject);
begin
  DataRefresh
end;

procedure TExceptionsT.UniFrameCreate(Sender: TObject);
begin
  inherited;
  fType.FillFromSQL(' Select ID, Name from vExceptionsFilerType order by ID ');
end;

initialization
  RegisterClass(TExceptionsT);

end.
