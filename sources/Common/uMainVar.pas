unit uMainVar;

interface

uses
  uAccrualUtils, uSqlUtils, uCommonType, uGrantUtils, uniComboBox,
  uUniExComboBox, uUniExCheckComboBox;

  function Sql: TSql;

  function RetVal: TRetVal;

  function Grant: TGrant;

  function SPID: Integer;


  procedure ComboBoxFill(AComboBox: TUniComboBox; ASQL: string); overload;
  procedure ComboBoxFill(AComboBox: TUniExComboBox; ASQL: string); overload;
  procedure ComboBoxFill(AComboBox: TUniCheckComboBox; ASQL: string); overload;
  procedure ComboBoxFill(AComboBox: TUniExCheckComboBox; ASQL: string); overload;

implementation

uses MainModule;

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

function Grant: TGrant;
begin
  if not Assigned(MainModule.UniMainModule.AGrant) then
    MainModule.UniMainModule.AGrant := TGrant.Create;

  Result := MainModule.UniMainModule.AGrant;
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

procedure ComboBoxFill(AComboBox: TUniExComboBox; ASQL: string);
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
        AComboBox.Items.AddObject( FieldByName('Name').AsString, Pointer(FieldByName('ID').AsInteger) );
        Next;
      end;
    AComboBox.Items.EndUpdate;
    EnableControls;
  end;
end;

procedure ComboBoxFill(AComboBox: TUniExCheckComboBox; ASQL: string);
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
        AComboBox.Items.AddObject( FieldByName('Name').AsString, Pointer(FieldByName('ID').AsInteger) );

        //AComboBox.Items.AddPair(FieldByName('Name').AsString, FieldByName('ID').AsString);
        Next;
      end;
    AComboBox.Items.EndUpdate;
    EnableControls;
  end;
end;

end.
