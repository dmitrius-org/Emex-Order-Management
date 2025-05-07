unit uFragileT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uEmployeeOrdersProcessedT, uShipmentsBoxesT,
  uniMultiItem, uniComboBox, uUniExCheckComboBox, uniButton,
  uniDateTimePicker, uniLabel, uniGUIBaseClasses, uniPanel, uniBitBtn,
  uniGroupBox, uFragileT;

type
  TFragileT_Wrapper = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FFragile: TFragileT;
    { Private declarations }
  public
    { Public declarations }

  end;

function FragileT_Wrapper: TFragileT_Wrapper;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FragileT_Wrapper: TFragileT_Wrapper;
begin
  Result := TFragileT_Wrapper(UniMainModule.GetFormInstance(TFragileT_Wrapper));
end;

procedure TFragileT_Wrapper.UniFormDestroy(Sender: TObject);
begin
  FreeAndNil(FFragile);
end;

procedure TFragileT_Wrapper.UniFormShow(Sender: TObject);
begin
  if not Assigned(FFragile) then
  begin
    FFragile := TFragileT.Create(Self);
    FFragile.Align := alClient;
    FFragile.Parent := Self;
  end;
 //  Fragile.GridOpen;
end;

end.
