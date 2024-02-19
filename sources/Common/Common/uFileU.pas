unit uFileU;

interface

uses System.SysUtils, Vcl.Dialogs, System.StrUtils;

/// <summary>
///  GetFName - получение наименования файла. Если файл существует, то к
///  наименованию добавляем порядковый номер
///</summary>
function GetFName(filename: string): string;

function GetSpecialPath(APath:string; ASymbol: string = '\'):string;

implementation

function GetFName(filename: string): string; var i: Integer;
var fn: string;
begin
  fn :=  StringReplace(ExtractFileName(filename), ExtractFileExt(filename), '', [rfReplaceAll, rfIgnoreCase]);

  if FileExists(filename) then
  begin
    while FileExists(filename) do
    begin
      inc(i);
      filename:=ExtractFilePath(filename) + fn + '(' + i.ToString + ')' + ExtractFileExt(filename);
    end;
  end;

  Result := filename;
end;

function GetSpecialPath(APath:string; ASymbol: string = '\'):string;
begin
  if Copy(APath, Length(APath), 1) <> ASymbol then
    APath := APath+ASymbol;
  Result:=APath;
end;

end.
