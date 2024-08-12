unit uPromptMarginEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniButton, uniBitBtn,
  uniPanel;

type
  TPromptMarginEdit = class(TUniForm)
    edtMargin: TUniNumberEdit;
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function PromptMarginEdit: TPromptMarginEdit;

implementation

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

{$R *.dfm}


function PromptMarginEdit: TPromptMarginEdit;
begin
  Result := TPromptMarginEdit(UniMainModule.GetFormInstance(TPromptMarginEdit));
end;

procedure TPromptMarginEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TPromptMarginEdit.btnOkClick(Sender: TObject);
begin
  if RetVal.Code = 0 then
  begin
    Sql.exec('exec ProfilesCustomerMarginMassEdit @Margin = :Margin  ', ['Margin'], [edtMargin.Value]);
  end;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

end.
