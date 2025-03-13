unit uUtils.Mark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, FireDAC.Comp.Client,
  uniDBGrid, System.Generics.Collections;

type
  tMarks = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FGrid: TUniDBGrid;
    FMarks: TDictionary<Integer, Integer>;
    FKeyFields: String;

    FObjectType: Integer; // tObjectType.ObjectTypeID

    procedure DeleteInDB;
    function GetCount: Integer;
    procedure SetKeyFields(const Value: String);

  public
    constructor Create(AGrid: TUniDBGrid; AObjectType: Integer);
    destructor Destroy; override;

    procedure Select;
    procedure Clear;
    function IsSelected(AID: Integer): Boolean;

    procedure Load;
    procedure DataRefresh(ARowDelete: Boolean = False);
    procedure SaveMarksToDB;

    property Count: Integer read GetCount;
    property KeyFields: String read FKeyFields write SetKeyFields;
  end;

implementation

uses
  Data.DB;

{ tMarks }

procedure tMarks.Clear;
begin
  FMarks.Clear;
  DeleteInDB;
end;

constructor tMarks.Create(AGrid: TUniDBGrid; AObjectType: Integer);
begin
  if Assigned(AGrid) then
  begin
    FConnection := TFDConnection(TFDQuery(AGrid.DataSource.DataSet).Connection);

    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
    FGrid := AGrid;
  end;

  FKeyFields := TFDQuery(AGrid.DataSource.DataSet).UpdateOptions.KeyFields;
  FObjectType := AObjectType;

  FMarks := TDictionary<Integer, Integer>.Create();
end;

procedure tMarks.DataRefresh(ARowDelete: Boolean = False);
var
  Key: Integer;
  BM: TBookmark;
begin
  FGrid.DataSource.DataSet.DisableControls;
  BM := FGrid.DataSource.DataSet.GetBookmark;
  try
    for Key in FMarks.Keys do
    begin
      if FGrid.DataSource.DataSet.Locate(FKeyFields, Key, [loCaseInsensitive, loPartialKey]) then
      begin

        if ARowDelete then
        begin
          TFDQuery(FGrid.DataSource.DataSet).Delete;
          FGrid.RefreshCurrentRow;
        end
        else
        begin
          TFDQuery(FGrid.DataSource.DataSet).RefreshRecord(False);
          FGrid.RefreshCurrentRow;
        end;
      end;
    end;
  finally
    if not ARowDelete then
      FGrid.DataSource.DataSet.GotoBookmark(BM);
    FGrid.DataSource.DataSet.FreeBookmark(BM);
    FGrid.DataSource.DataSet.EnableControls;
  end;
end;

procedure tMarks.DeleteInDB;
begin
  FQuery.SQL.Text := 'delete tMarks from tMarks with (rowlock index=pk_tMarks) where spid=@@Spid';
  FQuery.ExecSQL;
end;

destructor tMarks.Destroy;
begin
  DeleteInDB;
  FMarks.Clear;
  FMarks.Free;
  FQuery.Free;
  inherited;
end;

function tMarks.GetCount: Integer;
begin
  Result := FMarks.Count;
end;

function tMarks.IsSelected(AID: Integer): Boolean;
begin
  Result := FMarks.ContainsKey(AID);
end;

procedure tMarks.Load;
begin
  // если необходимо загрузить данные из БД в FMarks
end;

procedure tMarks.Select;
var
  I, ID: Integer;
  BM: TBookmark;
begin
  Clear;

  if FGrid.SelectedRows.Count > 0 then
  begin
    BM := FGrid.DataSource.DataSet.GetBookmark;
    try
      for I := 0 to FGrid.SelectedRows.Count - 1 do
      begin
        FGrid.DataSource.DataSet.Bookmark := FGrid.SelectedRows[I];
        ID := FGrid.DataSource.DataSet.FieldByName(FKeyFields).AsInteger;
        FMarks.AddOrSetValue(ID, ID);
      end;
    finally
      FGrid.DataSource.DataSet.GotoBookmark(BM);
      FGrid.DataSource.DataSet.FreeBookmark(BM);
    end;
  end;
end;

procedure tMarks.SaveMarksToDB;
var
  IDs: TArray<Integer>;
  Values: TStringList;
  ID: Integer;
begin
  DeleteInDB;

  if FMarks.Count = 0 then
    Exit;

  IDs := FMarks.Keys.ToArray;
  Values := TStringList.Create;
  try
    for ID in IDs do
      Values.Add(Format('SELECT @@Spid, %d, %d', [FObjectType, ID]));

    FQuery.SQL.Text := 'INSERT INTO tMarks with (rowlock) (Spid, Type, ID) ' + String.Join(' UNION ALL ', Values.ToStringArray);
    FQuery.ExecSQL;
  finally
    Values.Free;
  end;
end;

procedure tMarks.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

end.

