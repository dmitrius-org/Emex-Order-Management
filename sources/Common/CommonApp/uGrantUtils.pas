unit uGrantUtils;

interface

uses Windows, Messages, SysUtils, Classes, Variants, Dialogs, uniMainMenu;

Type
  /// <summary>
  /// TGrant - клас для работы с правами пользователя
  /// </summary>
  TGrant = class
  private
  var FUserGrant: TStrings;

  private
  public

    /// <summary>
    /// GrantTemplateCreate - Создание шаблона меню.
    /// Сохраняет наименования пунктов actions в таблицу tMenu.
    /// </summary>
     procedure GrantTemplateCreate(AComp: TComponent; AParentMenu: string = '');

    /// <summary>
    /// UserGrantLoad - загрузка прав пользователя в память
    /// </summary>
     procedure UserGrantLoad();

    /// <summary>
    /// SetGrant - применени прав пользователя к меню системы
    /// </summary>
     procedure SetGrant(AComp: TComponent; AAction:TUniActionList);
  end;


implementation

uses MainModule, uUtils.Varriant, uLogger;

{ TGrant }

procedure TGrant.GrantTemplateCreate(AComp: TComponent; AParentMenu: string = '');
var loop, Index: Integer;
    Child : TComponent;
    Menu:TUniActionList;
begin
  for loop := 0 to AComp.ComponentCount -1 do
  Begin
    Child := AComp.Components[loop];
    if Child is TUniActionList then
    Begin
      Menu:= TUniActionList(Child);

      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text :=
         ' insert tMenu (MenuID, N, Caption, Name, Type, ParentID ) ' +
         ' select t.MenuID ' +
         '       ,t.MenuID ' +
         '       ,:Caption ' +
         '       ,:Name    ' +
         '       ,1        ' +
         '       ,m.MenuID ' +
         '   from tMenu m (nolock)                      ' +
         '  inner join ( Select max(MenuID)+1 MenuID from tMenu m (nolock) ) t on 1=1 '+
         '  where m.Name = :ParentID                    ' +
         '    and not exists (select 1                  ' +
         '                      from tMenu mm (nolock)  ' +
         '                     where mm.Name = :Name)   ' +
         ' select 0';

      for Index := 0 to Menu.ActionCount- 1 do
      Begin
        // если -1, то пункт не контролируем правами
        if Menu[Index].Tag = -1 then
          Continue;

         UniMainModule.Query.Close;
         UniMainModule.Query.ParamByName('Caption').Value := Menu[Index].Caption;


         UniMainModule.Query.ParamByName('Name').Value := AComp.ClassName + '.' + Menu[Index].Name;
         if AParentMenu <> '' then
           UniMainModule.Query.ParamByName('ParentID').Value := AParentMenu
         else
           UniMainModule.Query.ParamByName('ParentID').Value := AComp.ClassName;


         UniMainModule.Query.Open;
      end;
    end;
  end;
end;

procedure TGrant.SetGrant(AComp: TComponent; AAction: TUniActionList);
var Index:Integer;
    r : integer;
begin
  for Index := 0 to AAction.ActionCount- 1 do
  Begin
    logger.Info(AComp.ClassName + '.' + vartostr(AAction[Index].Name));
    try
      // если -1, то пункт не контролируем правами
      if AAction[Index].Tag = -1 then Continue;
      r:= VarToInt(FUserGrant.Values[AComp.ClassName + '.' + vartostr(AAction[Index].Name)]);

      AAction[Index].Tag:=r;
      AAction[Index].Enabled :=  r = 1;
    except
      on E: Exception do
      begin
        logger.Info(Format('Ошибка  [%s]', [E.Message]));
      end;
    end;
  end;
end;

procedure TGrant.UserGrantLoad;
var i: Integer;
begin
  //FUserGrant.Clear;
  FUserGrant := TStringList.Create();      //FormNames.Values[c] :=

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text :=
  ' declare @UserID numeric(18, 0)    '+
  '  select @UserID = dbo.GetUserID() '+
  ''+
  ' exec GrantSelect        '+
  '       @ObjectID   = @UserID '+
  '      ,@ObjectType = 0       '+
  ''+
  ' Select Name                 '+
  '   from vGrant               '+
  '  where ObjectID = @UserID   '+
  '    and (value = 1           '+
  '     or GroupValue = 1)      '+
  '    and Name <> ''''         '+
  '  order by N                 ';

  UniMainModule.Query.Open;

  UniMainModule.Query.First;
  for i := 0 to UniMainModule.Query.RecordCount-1 do
  Begin
    FUserGrant.Values[UniMainModule.Query.FieldByName('Name').AsString] := '1';
    UniMainModule.Query.Next;
  end;
end;

end.
