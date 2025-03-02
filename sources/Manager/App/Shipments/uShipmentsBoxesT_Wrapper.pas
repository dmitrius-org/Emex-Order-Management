unit uShipmentsBoxesT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uEmployeeOrdersProcessedT, uShipmentsBoxesT;

type
  TShipmentsBoxesT_Wrapper = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FTransporterNumber: String;
    FInvoice: String;
    { Private declarations }
  public
    { Public declarations }
    property TransporterNumber: String read FTransporterNumber write FTransporterNumber;
    property Invoice: String read FInvoice write FInvoice;

  end;

function ShipmentsBoxesT_Wrapper: TShipmentsBoxesT_Wrapper;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function ShipmentsBoxesT_Wrapper: TShipmentsBoxesT_Wrapper;
begin
  Result := TShipmentsBoxesT_Wrapper(UniMainModule.GetFormInstance(TShipmentsBoxesT_Wrapper));
end;

procedure TShipmentsBoxesT_Wrapper.UniFormShow(Sender: TObject);
var Boxes: TShipmentsBoxesT;
begin
   Boxes:= TShipmentsBoxesT.Create(self);
   Boxes.Parent := self;
   Boxes.Invoice := FInvoice;
   Boxes.TransporterNumber := FTransporterNumber;

   Boxes.GridOpen;
end;

end.
