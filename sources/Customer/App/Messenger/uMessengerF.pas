unit uMessengerF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm;

type
  TMessengerF = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FOrderID: Integer;
    FChatID: Integer;
    { Private declarations }
  public
    { Public declarations }


    property OrderID: Integer read FOrderID write FOrderID;
    property ChatID: Integer read FChatID write FChatID;
  end;

function MessengerF: TMessengerF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMessengerMessage;

function MessengerF: TMessengerF;
begin
  Result := TMessengerF(UniMainModule.GetFormInstance(TMessengerF));
end;

procedure TMessengerF.UniFormShow(Sender: TObject);
var Message: TMessage;
begin
   Message:= TMessage.Create(self);
   Message.Parent := self;
   Message.AppType := 0;

   if FOrderID > 0 then
     Message.OrderID := FOrderID
   else
     Message.ChatID := FChatID;
end;

end.

