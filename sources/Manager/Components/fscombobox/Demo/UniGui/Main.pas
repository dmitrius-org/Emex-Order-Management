unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniMultiItem, uniComboBox,
  UniFSCombobox, uniGUIBaseClasses, uniButton, uniBitBtn;

type
  TMainForm = class(TUniForm)
    btnExemplo1: TUniBitBtn;
    btnExemplo2: TUniBitBtn;
    procedure btnExemplo1Click(Sender: TObject);
    procedure btnExemplo2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, uFrmComboIDDataSource, uFrmComboValues;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnExemplo1Click(Sender: TObject);
begin
  frmComboValues.ShowModal();
end;

procedure TMainForm.btnExemplo2Click(Sender: TObject);
begin
  frmComboDataSource.ShowModal();
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
