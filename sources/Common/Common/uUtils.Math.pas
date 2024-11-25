unit uUtils.Math;

interface

uses System.Variants;
{ Easy to use conditional functions }

function IfThen(AValue: Boolean; ATrue: String; AFalse: String = ''): String; overload; inline;
function IfThen(AValue: Boolean; ATrue: TDateTime; AFalse: Variant): Variant; overload; //inline;

implementation

function IfThen(AValue: Boolean; ATrue: String; AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; ATrue: TDateTime; AFalse: Variant): Variant;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

end.
