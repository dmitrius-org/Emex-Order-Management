unit uGridUtils;

interface

uses System.SysUtils, System.UITypes, System.Rtti,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.Intf, FireDAC.Stan.Intf
     ,uniDBGrid ;

Type
  /// <summary> Типы для обработки ошибок </summary>
  GridExt = class
  strict
  private

  public
    /// <summary>
    ///  SortColumnCreate - Создание индексов по сортируемым полям
    ///</summary>
    class procedure SortColumnCreate(AGrid: TUniDBGrid) ;


  end;

/// <summary>
///  SortColumnCreate - Создание индексов по сортируемым полям
///</summary>
procedure SortColumnCreate(AQuery: TFDQuery); // Overload ;

implementation



procedure SortColumnCreate(AQuery: TFDQuery);
var
  I: Integer;
  IndexnameAsc : string;
  IndexnameDes : string;
begin
  // индексы для сортировки
  //with Query do
  begin
    for I := 0 to AQuery.FieldCount-1 do
    begin
     // if AQuery.Fields[I].FieldKind = fk then
      begin
        IndexnameAsc := AQuery.Fields[I].FieldName+'_index_asc';
        IndexnameDes := AQuery.Fields[I].FieldName+'_index_des';

        with AQuery.Indexes.Add do
        begin
          Name := IndexnameAsc;
          Fields := AQuery.Fields[I].FieldName;
          Options:=[];
          Active := True;
        end;
        with AQuery.Indexes.Add do
        begin
          Name := IndexnameDes;
          Fields := AQuery.Fields[I].FieldName;
          Options:=[soDescending];
          Active := True;
        end;
      end;
    end;
  end;
end;

{ TGridExt }

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
