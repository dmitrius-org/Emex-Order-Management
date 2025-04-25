unit uAPIKeyT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel,
  uniButton;

type
  TAPIKeyT_W = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
  public
    property ClientID: Integer read FClientID write SetClientID;
  end;

function APIKeyT_W: TAPIKeyT_W;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uniGUIFrame, uBaseT, uAPIFormT, utest;

function APIKeyT_W: TAPIKeyT_W;
begin
  Result := TAPIKeyT_W(UniMainModule.GetFormInstance(TAPIKeyT_W));
end;

{ TAPIKeyForm_W }

procedure TAPIKeyT_W.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

procedure TAPIKeyT_W.UniFormShow(Sender: TObject);
begin
  APIFormT := TAPIFormT.Create(Self);
  APIFormT.Align    := alClient;
  APIFormT.Parent   := self;
  APIFormT.ClientID := FClientID;
end;

end.
