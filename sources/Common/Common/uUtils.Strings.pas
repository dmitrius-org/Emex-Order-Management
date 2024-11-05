unit uUtils.Strings;

interface

//uses System.SysUtils, System.UITypes, Variants,  Data.DB,
//     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Intf,
//     FireDAC.Stan.Async;


function CharInSet(C: Char; const CharSet: string): Boolean; overload;

implementation


function CharInSet(C: Char; const CharSet: string): Boolean;
begin
  Result := Pos(C, CharSet) > 0;
end;


end.
