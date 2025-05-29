unit uBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMainMenu;

type
  TBaseForm = class(TUniForm)
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm(const LangCode: string); virtual;

    procedure ShowError(Msg: string);
  published

  end;

function BaseForm: TBaseForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uUtils.Localizer, uUtils.Logger;

function BaseForm: TBaseForm;
begin
  Result := TBaseForm(UniMainModule.GetFormInstance(TBaseForm));
end;

{ TBaseForm }

procedure TBaseForm.ShowError(Msg: string);
begin
  MessageDlg(Msg, mtError, [mbOK], nil);
end;

procedure TBaseForm.TranslateForm(const LangCode: string);
begin
  if Assigned(TLocalizer.Instance()) then
  begin
    TLocalizer.Instance.ApplyLocalization(self);
  end;
end;

procedure TBaseForm.UniFormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  if Assigned(TLocalizer.Instance()) then
  begin
    TLocalizer.Instance.ExportFormLocalization((Self));
  end;
{$ENDIF}

  TranslateForm('ru');
end;

end.
