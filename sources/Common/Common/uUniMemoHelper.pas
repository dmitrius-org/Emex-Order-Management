unit uUniMemoHelper;

interface

uses System.SysUtils, uniMemo;

type
  TUniMemoHelper = class helper for TUniMemo
  public
    /// <summary>
    /// ToHTML - оборачивает строки в TUniMemo в тег <p>, в конце каждой строки
    ///  добавляется <br>
    /// </summary>
    function ToHTML: string;
  end;

implementation

function TUniMemoHelper.ToHTML: string;
var
  i: Integer;
  HTMLText: string;
begin
  HTMLText := '<p>';

  // Перебираем строки в TUniMemo и оборачиваем их в теги <p>
  for i := 0 to Lines.Count - 1 do
  begin
    if Lines[i].Length > 0 then
      HTMLText := HTMLText + Lines[i] + '<br>';
  end;

  // Если в Memo всего одна строка, убираем <br>
  if Lines.Count = 1 then
    HTMLText := StringReplace(HTMLText, '<br>', '', []);

  HTMLText := HTMLText + '</p>';

  Result := HTMLText;
end;

end.
