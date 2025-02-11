unit uTreeMenuHelper;

interface

uses
  uniGUIAbstractClasses, UniTreeMenu;

type
  /// <summary>
  /// Класс-хелпер для компонента TUniTreeMenu.
  /// Добавляет дополнительные методы для работы с элементами меню.
  /// </summary>
  TUniTreeMenuHelper = class helper for TUniTreeMenu
  public
    /// <summary>
    /// Ищет узел (TUniTreeNode) в компоненте TUniTreeMenu по значению свойства Tag.
    /// </summary>
    /// <param name="AID">
    /// Целочисленное значение, по которому производится поиск узла (свойство Tag).
    /// </param>
    /// <returns>
    /// Возвращает найденный узел (TUniTreeNode), либо nil, если узел с указанным Tag не найден.
    /// </returns>
    function FindNodeByID(AID: Integer): TUniTreeNode;
  end;

implementation

function TUniTreeMenuHelper.FindNodeByID(AID: Integer): TUniTreeNode;
var
  I: Integer;
begin
  Result := nil;
  // Перебираем элементы меню и ищем узел с нужным ID
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Tag = AID then
    begin
      Result := Items.Item[I];
      Exit; // Прерываем цикл, если узел найден
    end;
  end;
end;

end.

