﻿unit uUtils.Grid;

interface

uses System.SysUtils, System.UITypes, System.Rtti, System.Classes,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.Intf, FireDAC.Stan.Intf
     ,uniDBGrid, uCommonType, uniGUITypes ;

Type
  /// <summary></summary>
  GridExt = class
  strict
  private

  public
    /// <summary>
    ///  SortColumnCreate - Создание индексов по сортируемым полям
    ///</summary>
    class procedure SortColumnCreate(AGrid: TUniDBGrid) ;

    /// <summary>
    ///  GridLayout - сохранение/восстановление настроек грида по пользоватлю
    ///  AOperation 0-сохранение
    ///             1-восстановление
    ///</summary>
    class procedure GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout); overload;
    /// <summary>
    ///  GridLayout - сохранение/восстановление настроек грида по клиенту
    ///  AOperation 0-сохранение
    ///             1-восстановление
    ///</summary>
    class procedure GridLayout(AClientID: Integer; AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout); overload;
    /// <summary>
    ///  GridLayout - сохранение настроек грида
    ///</summary>
    class procedure GridLayoutSave(AForm:TObject; AGrid: TUniDBGrid; AParams:TUniStrings; AEventName: String); overload;
    /// <summary>
    ///  GridLayout - сохранение настроек грида
    ///</summary>
    class procedure GridLayoutSave(AClientID: Integer; AForm:TObject; AGrid: TUniDBGrid; AParams:TUniStrings; AEventName: String); overload;

    /// <summary>
    ///  GridLayoutDefault -
    ///</summary>
    class procedure GridLayoutDefault(AForm:TObject; AGrid: TUniDBGrid);
  end;

implementation

uses
  uniGUIAbstractClasses, uMainVar;

class procedure GridExt.GridLayout(AForm: TObject; AGrid: TUniDBGrid;  AOperation: tGridLayout);
var
  i: integer;
  SqlText: string;
  Column: TUniBaseDBGridColumn;
begin
  if not (AGrid is TUniDBGrid) then Exit;

  if AOperation=tGridLayout.glSave then
    for i := 0 to AGrid.Columns.count-1 do
    begin
      Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[AForm.ClassName +'.' + AGrid.Name]);
      if i = 0 then
        SqlText:= SqlText + ' Insert into tGridOptions (UserID, Grid, [Column], Position, Width, Visible) '
      else
        SqlText:= SqlText + ' Union all ';

       SqlText:= SqlText +
       Format ('select dbo.GetUserID(), ''%s'', ''%s'', %d, %d, %d',
       [AForm.ClassName +'.' + AGrid.Name,
        AGrid.Columns[i].FieldName,
        AGrid.Columns[i].Index,
        AGrid.Columns[i].Width,
        AGrid.Columns[i].Visible.ToInteger
        //AGrid.Columns[i].Locked.ToInteger Locking
        ]);

        //logger.Info(SqlText);
        Sql.Exec(SqlText,[],[]);
    end
  else
  if AOperation=tGridLayout.glLoad then
  begin
    Sql.Q.Close;
    Sql.Open('''
             select *
               from GridOptionsSelect
              where UserID = dbo.GetUserID()
                and Grid =:Grid
              order by Position
            ''',
            ['Grid'], [AForm.ClassName +'.' + AGrid.Name]);
    Sql.Q.First;
    for i:= 0 to Sql.Q.RecordCount-1 do
    begin

     try
       Column := AGrid.Columns.ColumnFromFieldName(Sql.Q.FieldByName('Column').AsString);

       if Assigned(Column) then
       begin

         Column.Index  := Sql.Q.FieldByName('Position').AsInteger;
         Column.Width  := Sql.Q.FieldByName('Width').AsInteger;
         Column.Visible:= Sql.Q.FieldByName('Visible').AsBoolean;
     // Column.Locked := Sql.Q.FieldByName('Locking').AsBoolean;
       end

     except
       on E: Exception do
       begin
        // logger.Info('TOrdersT.GridLayout Ошибка: ' + e.Message);
        // logger.Info('TOrdersT.GridLayout Column: ' + Sql.Q.FieldByName('Column').AsString);
       end;
     end;
      Sql.Q.Next;
    end;
  end;

  //if AShowResultMessage = True then
  //  ToastOK ('Успешно выполнено!', unisession);
end;

class procedure GridExt.GridLayout(AClientID: Integer; AForm: TObject; AGrid: TUniDBGrid; AOperation: tGridLayout);
var
  i: integer;
  SqlText: string;
  Column: TUniBaseDBGridColumn;
begin
  if not (AGrid is TUniDBGrid) then Exit;

  if AOperation=tGridLayout.glSave then
    for i := 0 to AGrid.Columns.count-1 do
    begin
      Sql.Exec('delete tCustomerGridOptions from tCustomerGridOptions (rowlock) where ClientID = :ClientID and Grid =:Grid',
              ['Grid', 'ClientID'],
              [AForm.ClassName +'.' + AGrid.Name,
               AClientID]
               );
      if i = 0 then
        SqlText:= SqlText + ' Insert into tCustomerGridOptions (ClientID, Grid, [Column], Position, Width, Visible) '
      else
        SqlText:= SqlText + ' Union all ';

       SqlText:= SqlText +
       Format ('select :ClientID, ''%s'', ''%s'', %d, %d, %d',
       [AForm.ClassName +'.' + AGrid.Name,
        AGrid.Columns[i].FieldName,
        AGrid.Columns[i].Index,
        AGrid.Columns[i].Width,
        AGrid.Columns[i].Visible.ToInteger
        //AGrid.Columns[i].Locked.ToInteger Locking
        ]);

        //logger.Info(SqlText);
        Sql.Exec(SqlText,['ClientID'],[AClientID]);
    end
  else
  if AOperation=tGridLayout.glLoad then
  begin
    Sql.Q.Close;
    Sql.Open('''
             select *
               from CustomerGridOptionsSelect
              where ClientID = :ClientID
                and Grid =:Grid
              order by Position
             ''',
            ['Grid', 'ClientID'], [AForm.ClassName +'.' + AGrid.Name, AClientID]);
    Sql.Q.First;
    for i:= 0 to Sql.Q.RecordCount-1 do
    begin

     try
       Column := AGrid.Columns.ColumnFromFieldName(Sql.Q.FieldByName('Column').AsString);
       Column.Index  := Sql.Q.FieldByName('Position').AsInteger;
       if (Sql.Q.FieldByName('Visible').AsBoolean) and (Sql.Q.FieldByName('Width').AsInteger <> 0) then
         Column.Width  := Sql.Q.FieldByName('Width').AsInteger;
       Column.Visible:= Sql.Q.FieldByName('Visible').AsBoolean;
     // Column.Locked := Sql.Q.FieldByName('Locking').AsBoolean;

     except
       on E: Exception do
       begin
        // logger.Info('TOrdersT.GridLayout Ошибка: ' + e.Message);
        // logger.Info('TOrdersT.GridLayout Column: ' + Sql.Q.FieldByName('Column').AsString);
       end;
     end;
      Sql.Q.Next;
    end;
  end;

  //if AShowResultMessage = True then
  //  ToastOK ('Успешно выполнено!', unisession);
end;

class procedure GridExt.GridLayoutDefault(AForm:TObject; AGrid: TUniDBGrid);
begin
  Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[AForm.ClassName +'.' + AGrid.Name]);
end;

class procedure GridExt.GridLayoutSave(AClientID: Integer; AForm: TObject; AGrid: TUniDBGrid; AParams: TUniStrings; AEventName: String);
begin
  if (AEventName = '_columnhide')
  then
  begin
      Sql.Exec('''
                 exec CustomerGridOptionsVisible
                      @Grid   = :Grid
                     ,@Column = :Column
                     ,@Visible= 0
                     ,@ClientID= :ClientID
               ''',
              ['Grid', 'Column', 'ClientID'],
              [AForm.ClassName +'.' + AGrid.Name,
               AGrid.Columns[AParams['column'].Value.ToInteger].FieldName,
               AClientID
              ]);
  end
  else
  if (AEventName = '_columnshow')
  then
  begin
    Sql.Exec('''
              exec CustomerGridOptionsVisible
                    @Grid   = :Grid
                   ,@Column = :Column
                   ,@Visible= 1
                   ,@ClientID= :ClientID
             ''',
            ['Grid', 'Column', 'ClientID'],
            [AForm.ClassName +'.' + AGrid.Name,
             AGrid.Columns[AParams['column'].Value.ToInteger].FieldName,
             AClientID
             ]);
  end
end;

class procedure GridExt.GridLayoutSave(AForm: TObject; AGrid: TUniDBGrid; AParams:TUniStrings; AEventName: String);
begin
  if (AEventName = '_columnhide')
  then
  begin
      Sql.Exec('exec GridOptionsVisible ' +
               '       @Grid   = :Grid'+
               '      ,@Column = :Column '+
               '      ,@Visible= 0 ',
              ['Grid', 'Column'],
              [AForm.ClassName +'.' + AGrid.Name,
              AGrid.Columns[AParams['column'].Value.ToInteger].FieldName
               ]);
  end
  else
  if (AEventName = '_columnshow')
  then
  begin
    Sql.Exec('exec GridOptionsVisible ' +
             '       @Grid   = :Grid'+
             '      ,@Column = :Column '+
             '      ,@Visible= 1 ',
            ['Grid', 'Column'],
            [AForm.ClassName +'.' + AGrid.Name,
             AGrid.Columns[AParams['column'].Value.ToInteger].FieldName
             ]);
  end
end;

class procedure GridExt.SortColumnCreate(AGrid: TUniDBGrid);
var
  I: Integer;
  IndexnameAsc : string;
  IndexnameDes : string;
begin
  // индексы для сортировки
  begin

    for I := 0 to AGrid.Columns.Count-1 do
    begin
      if AGrid.Columns[i].Sortable then
      begin
        IndexnameAsc := AGrid.Columns[i].FieldName + '_index_asc';
        IndexnameDes := AGrid.Columns[i].FieldName + '_index_des';

        with  TFDQuery(AGrid.DataSource.DataSet).Indexes.Add do
        begin
          Name := IndexnameAsc;
          Fields := AGrid.Columns[i].FieldName;
          Options:=[];
          Active := True;
        end;
        with TFDQuery(AGrid.DataSource.DataSet).Indexes.Add do
        begin
          Name := IndexnameDes;
          Fields := AGrid.Columns[i].FieldName;
          Options:=[soDescending];
          Active := True;
        end;
      end;
    end;
  end;

end;

end.
