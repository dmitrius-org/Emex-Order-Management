unit uUniMemoHelper;

interface

uses System.SysUtils, uniMemo;

type
  TUniMemoHelper = class helper for TUniMemo
  public
    /// <summary>
    /// ToHTML - ����������� ������ � TUniMemo � ��� <p>, � ����� ������ ������
    ///  ����������� <br>
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

  // ���������� ������ � TUniMemo � ����������� �� � ���� <p>
  for i := 0 to Lines.Count - 1 do
  begin
    if Lines[i].Length > 0 then
      HTMLText := HTMLText + Lines[i] + '<br>';
  end;

  // ���� � Memo ����� ���� ������, ������� <br>
  if Lines.Count = 1 then
    HTMLText := StringReplace(HTMLText, '<br>', '', []);

  HTMLText := HTMLText + '</p>';

  Result := HTMLText;
end;

end.
