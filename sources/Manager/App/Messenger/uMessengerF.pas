unit uMessengerF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm;

type
  TMessageF = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FOrderID: Integer;
    { Private declarations }
  public
    { Public declarations }


    property OrderID: Integer read FOrderID write FOrderID;
  end;

function MessageF: TMessageF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMessengerMessage, uCommonType;

function MessageF: TMessageF;
begin
  Result := TMessageF(UniMainModule.GetFormInstance(TMessageF));
end;

procedure TMessageF.UniFormShow(Sender: TObject);
var Message: TMessage;
begin
   Message:= TMessage.Create(self);
   Message.Parent := self;
   Message.AppType := atManager;
   Message.OrderID := FOrderID;

end;

end.
