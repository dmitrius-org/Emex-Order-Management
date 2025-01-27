unit uTreeMenuHelper;

interface

uses
  uniGUIAbstractClasses, UniTreeMenu;

type
  /// <summary>
  /// �����-������ ��� ���������� TUniTreeMenu.
  /// ��������� �������������� ������ ��� ������ � ���������� ����.
  /// </summary>
  TUniTreeMenuHelper = class helper for TUniTreeMenu
  public
    /// <summary>
    /// ���� ���� (TUniTreeNode) � ���������� TUniTreeMenu �� �������� �������� Tag.
    /// </summary>
    /// <param name="AID">
    /// ������������� ��������, �� �������� ������������ ����� ���� (�������� Tag).
    /// </param>
    /// <returns>
    /// ���������� ��������� ���� (TUniTreeNode), ���� nil, ���� ���� � ��������� Tag �� ������.
    /// </returns>
    function FindNodeByID(AID: Integer): TUniTreeNode;
  end;

implementation

function TUniTreeMenuHelper.FindNodeByID(AID: Integer): TUniTreeNode;
var
  I: Integer;
begin
  Result := nil;
  // ���������� �������� ���� � ���� ���� � ������ ID
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Tag = AID then
    begin
      Result := Items.Item[I];
      Exit; // ��������� ����, ���� ���� ������
    end;
  end;
end;

end.

