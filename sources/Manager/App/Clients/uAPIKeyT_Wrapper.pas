unit uAPIKeyT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel,
  uniButton;

type
  TAPIKeyT_W = class(TUniForm)
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    procedure UniFormDestroy(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
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
  MainModule, uniGUIApplication, uniGUIFrame, uAPIKeyT, uBaseT, utest;

function APIKeyT_W: TAPIKeyT_W;
begin
  Result := TAPIKeyT_W(UniMainModule.GetFormInstance(TAPIKeyT_W));
end;

{ TAPIKeyForm_W }

procedure TAPIKeyT_W.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

procedure TAPIKeyT_W.UniButton1Click(Sender: TObject);

begin



  test := Ttest.Create(Self);
  test.Align    := alClient;
  test.Parent   := self;

end;

procedure TAPIKeyT_W.UniButton2Click(Sender: TObject);
begin
  APIKeyT := TAPIKeyT.Create(Self);
  APIKeyT.Align    := alClient;
  APIKeyT.Parent   := self;
end;

procedure TAPIKeyT_W.UniFormDestroy(Sender: TObject);
begin
//  FreeAndNil(BaseT);
end;

end.
