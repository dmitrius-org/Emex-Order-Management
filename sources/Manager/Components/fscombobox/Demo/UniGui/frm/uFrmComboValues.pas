unit uFrmComboValues;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMultiItem, uniComboBox, UniFSCombobox,
  uniGUIBaseClasses, uniButton, uniBitBtn;

type
  TfrmComboValues = class(TUniForm)
    btnLoadCombo: TUniBitBtn;
    cmb1: TUniFSComboBox;
    btnGetValue: TUniBitBtn;
    btnSetValue: TUniBitBtn;
    procedure btnLoadComboClick(Sender: TObject);
    procedure btnGetValueClick(Sender: TObject);
    procedure btnSetValueClick(Sender: TObject);
    procedure cmb1CloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmComboValues: TfrmComboValues;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmComboValues: TfrmComboValues;
begin
  Result := TfrmComboValues(UniMainModule.GetFormInstance(TfrmComboValues));
end;

procedure TfrmComboValues.btnGetValueClick(Sender: TObject);
begin
  ShowMessage(cmb1.Value);
end;

procedure TfrmComboValues.btnLoadComboClick(Sender: TObject);
begin
  cmb1.ClearAll;
  cmb1.ValueList.Add('MT');
  cmb1.Items.Add('Mato Grosso');
  cmb1.ValueList.Add('SP');
  cmb1.Items.Add('São Paulo');
  cmb1.ValueList.Add('PR');
  cmb1.Items.Add('Paraná');
  cmb1.ValueList.Add('RS');
  cmb1.Items.Add('Rio Grande do Sul');
  cmb1.ItemIndex := 0;
end;

procedure TfrmComboValues.btnSetValueClick(Sender: TObject);
begin
  cmb1.Value := 'RS';
end;

procedure TfrmComboValues.cmb1CloseUp(Sender: TObject);
begin
  //
end;

end.
