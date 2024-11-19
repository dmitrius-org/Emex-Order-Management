unit uMainVar;

interface

uses
  uSqlUtils, uLogger, uCommonType, uniComboBox, UniFSCombobox;

  function Sql: TSql;

  function RetVal: TRetVal;

  function SPID: Integer;


  procedure ComboBoxFill(AComboBox: TUniComboBox; ASQL: string); overload;
  procedure ComboBoxFill(AComboBox: TUniFSComboBox; ASQL: string); overload;
  procedure ComboBoxFill(AComboBox: TUniCheckComboBox; ASQL: string); overload;

implementation

uses
  MainModule;

function Sql: TSql;
begin
  if not Assigned(MainModule.UniMainModule.ASql) then
    MainModule.UniMainModule.ASql := TSql.Create(MainModule.UniMainModule.FDConnection);

  Result := MainModule.UniMainModule.ASql;
end;

function RetVal: TRetVal;
begin
  if not Assigned(MainModule.UniMainModule.ARetVal) then
    MainModule.UniMainModule.ARetVal := tRetVal.Create(MainModule.UniMainModule.FDConnection);

  RetVal := MainModule.UniMainModule.ARetVal;
end;

function SPID: Integer;
begin
  Result := MainModule.UniMainModule.ASPID;
end;


procedure ComboBoxFill(AComboBox: TUniComboBox; ASQL: string);
begin
  Sql.Q.Close;
  Sql.Open(ASQL, [], []);
  with Sql.Q do
  begin
    DisableControls;
    AComboBox.Clear;
    AComboBox.Items.BeginUpdate;
    First;
    while not Eof do
      begin
        AComboBox.Items.Add(FieldByName('Name').AsString);
        Next;
      end;
    AComboBox.Items.EndUpdate;
    EnableControls;
  end;
end;

procedure ComboBoxFill(AComboBox: TUniFSComboBox; ASQL: string);
begin
  Sql.Q.Close;
  Sql.Open(ASQL, [], []);
  with Sql.Q do
  begin
    DisableControls;
    AComboBox.ClearAll;
    AComboBox.Items.BeginUpdate;
    First;
    while not Eof do
      begin
        AComboBox.ValueList.Add(FieldByName('ID').AsString);
        AComboBox.Items.Add(FieldByName('Name').AsString);
        Next;
      end;
    AComboBox.Items.EndUpdate;
    EnableControls;
  end;
end;

procedure ComboBoxFill(AComboBox: TUniCheckComboBox; ASQL: string);
begin
  Sql.Q.Close;
  Sql.Open(ASQL, [], []);
  with Sql.Q do
  begin
    DisableControls;
    AComboBox.Clear;
    AComboBox.Items.BeginUpdate;
    First;
    while not Eof do
      begin
        //AComboBox.Items.Add(FieldByName('Name').AsString);
        AComboBox.Items.AddObject( FieldByName('Name').AsString, Pointer(FieldByName('ID').AsInteger) );
        Next;
      end;
    AComboBox.Items.EndUpdate;
    EnableControls;
  end;
end;
end.
