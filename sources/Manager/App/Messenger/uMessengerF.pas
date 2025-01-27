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
    FChatID: Integer;
    { Private declarations }
  public
    { Public declarations }

    property OrderID: Integer read FOrderID write FOrderID;
    property ChatID: Integer read FChatID write FChatID;
  end;

function MessageF: TMessageF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMessengerMessage;

function MessageF: TMessageF;
begin
  Result := TMessageF(UniMainModule.GetFormInstance(TMessageF));
end;

procedure TMessageF.UniFormShow(Sender: TObject);
var Message: TMessage;
begin
   Message:= TMessage.Create(self);
   Message.Parent := self;
   Message.AppType := 1;

   Message.OrderID := FOrderID;
   Message.ChatID := FChatID;
end;

end.
