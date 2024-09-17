unit uLookupF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIFrame, uCommonType;

type
  TLookupF = class(TUniForm)
  private
    FFromName: String;
    FID: TStringList;
    procedure SetFromName(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property ID: TStringList read FID write FID;
    property FromName: String read FFromName write SetFromName;
  end;

implementation

uses
  uniGUIApplication, uUserT;

{$R *.dfm}


procedure TLookupF.SetFromName(const Value: String);
var
 FrC :  TUniFrameClass;
  Fr : TUniFrame;
begin
  FFromName := Value;

  if not Assigned(FID) then
    FID := TStringList.Create
  else
    FID.Clear;

  FrC := TUniFrameClass(FindClass(FFromName));
  Fr := FrC.Create(Self);

  TMultiProp.Objects([Fr])['FormAction']:=6;

  Fr.Align := alClient;
  Fr.Parent := self;
end;

end.
