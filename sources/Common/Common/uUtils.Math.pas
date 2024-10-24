unit uUtils.Math;

interface

{ Easy to use conditional functions }

function IfThen(AValue: Boolean; ATrue: String; AFalse: String = ''): String; overload; inline;

implementation

function IfThen(AValue: Boolean; ATrue: String; AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

end.
