unit uFrmComboIDDataSource;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  uniPanel, uniMultiItem, uniComboBox, UniFSCombobox, Data.DB, Datasnap.DBClient,
  uniButton, uniBitBtn, uniDBComboBox;

type
  TfrmComboDataSource = class(TUniForm)
    dbg1: TUniDBGrid;
    hdp1: TUniHiddenPanel;
    cmb1: TUniFSComboBox;
    CDS1: TClientDataSet;
    btnLoad: TUniBitBtn;
    cbb1: TUniDBComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmComboDataSource: TfrmComboDataSource;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmComboDataSource: TfrmComboDataSource;
begin
  Result := TfrmComboDataSource(UniMainModule.GetFormInstance(TfrmComboDataSource));
end;

end.
