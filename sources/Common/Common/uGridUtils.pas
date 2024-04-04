unit uGridUtils;

interface

uses System.SysUtils, System.UITypes, System.Rtti,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.Intf, FireDAC.Stan.Intf
     ,uniDBGrid ;

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

  end;

implementation

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
