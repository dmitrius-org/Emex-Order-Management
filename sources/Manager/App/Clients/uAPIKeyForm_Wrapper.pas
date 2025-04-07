unit uAPIKeyForm_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel;

type
  TAPIKeyForm_W = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
  public
    property ClientID: Integer read FClientID write SetClientID;
  end;

function APIKeyForm_W: TAPIKeyForm_W;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAPIKeyForm_T;

function APIKeyForm_W: TAPIKeyForm_W;
begin
  Result := TAPIKeyForm_W(UniMainModule.GetFormInstance(TAPIKeyForm_W));
end;

{ TAPIKeyForm_W }

procedure TAPIKeyForm_W.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

procedure TAPIKeyForm_W.UniFormShow(Sender: TObject);
var APIKeyForm_T: TAPIKeyForm_T;
begin
  APIKeyForm_T:=TAPIKeyForm_T.Create(self);
  APIKeyForm_T.Align    := alClient;
  APIKeyForm_T.Parent   := self;
  APIKeyForm_T.ClientID := FClientID;
end;

end.
