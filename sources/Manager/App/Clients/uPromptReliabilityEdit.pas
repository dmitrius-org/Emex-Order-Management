unit uPromptReliabilityEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniEdit, uniButton, uniBitBtn,
  uniPanel;

type
  TPromptReliabilityEdit = class(TUniForm)
    edtReliability: TUniNumberEdit;
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

  function PromptReliabilityEdit: TPromptReliabilityEdit;

implementation

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

{$R *.dfm}


function PromptReliabilityEdit: TPromptReliabilityEdit;
begin
  Result := TPromptReliabilityEdit(UniMainModule.GetFormInstance(TPromptReliabilityEdit));
end;

procedure TPromptReliabilityEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TPromptReliabilityEdit.btnOkClick(Sender: TObject);
begin
  if RetVal.Code = 0 then
  begin
    Sql.exec('exec ProfilesCustomerReliabilityMassEdit @Reliability = :Reliability  ', ['Reliability'], [edtReliability.Value]);
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
