unit uGridUtils;

interface

uses System.SysUtils, System.UITypes, System.Rtti,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.Intf, FireDAC.Stan.Intf;


procedure SortColumnCreate(AQuery: TFDQuery);

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
end.
