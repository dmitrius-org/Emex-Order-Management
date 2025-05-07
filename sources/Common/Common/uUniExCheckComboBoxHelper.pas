unit uUniExCheckComboBoxHelper;

interface

uses
  System.SysUtils, System.Classes, uUniExCheckComboBox, Data.DB, uMainVar;

type
  TUniExCheckComboBoxHelper  = class helper for TUniExCheckComboBox
  public
    /// <summary>
    /// FillFromSQL - заполнить по запросу из БД.
    /// </summary>
    /// <param name="ASQL">SQL зпрос. В запросе обязательно должны быть поля ID, Name</param>
    procedure FillFromSQL(const ASQL: string);
  end;

implementation

procedure TUniExCheckComboBoxHelper.FillFromSQL(const ASQL: string);
begin
  Sql.Q.Close;
  Sql.Open(ASQL, [], []);
  with Sql.Q do
  begin
    DisableControls;
    Self.Clear;
    Self.Items.BeginUpdate;
    try
      First;
      while not Eof do
      begin
        Self.Items.AddObject( FieldByName('Name').AsString, Pointer(FieldByName('ID').AsInteger) );

        Next;
      end;
    finally
      Self.Items.EndUpdate;
      EnableControls;
    end;
  end;
end;

end.
