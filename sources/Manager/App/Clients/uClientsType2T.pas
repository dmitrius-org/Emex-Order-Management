unit uClientsType2T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm;

type
  TClientType2T = class(TUniForm)
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ClientType2T: TClientType2T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uClientsTypeT;

function ClientType2T: TClientType2T;
begin
  Result := TClientType2T(UniMainModule.GetFormInstance(TClientType2T));
end;

procedure TClientType2T.UniFormCreate(Sender: TObject);
var ClientsType: TClientsTypeT;
begin
   ClientsType := TClientsTypeT.Create(Self);
   ClientsType.Align := alClient;
   ClientsType.Parent := self;
end;

end.
