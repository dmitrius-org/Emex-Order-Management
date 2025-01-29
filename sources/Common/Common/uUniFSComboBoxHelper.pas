unit uUniFSComboBoxHelper;

interface

uses
  System.SysUtils, System.Classes, UniFSComboBox, Data.DB, uMainVar;

type
  TUniFSComboBoxHelper = class helper for TUniFSComboBox
  public
    /// <summary>
    /// FillFromSQL - заполнить по запросу из БД.
    /// </summary>
    /// <param name="ASQL">SQL зпрос. В запросе обязательно должны быть поля ID, Name</param>
    procedure FillFromSQL(const ASQL: string);
  end;

implementation

procedure TUniFSComboBoxHelper.FillFromSQL(const ASQL: string);
begin
  Sql.Q.Close;
  Sql.Open(ASQL, [], []);
  with Sql.Q do
  begin
    DisableControls;
    Self.ClearAll;
    Self.Items.BeginUpdate;
    try
      First;
      while not Eof do
      begin
        Self.ValueList.Add(FieldByName('ID').AsString);
        Self.Items.Add(FieldByName('Name').AsString);
        Next;
      end;
    finally
      Self.Items.EndUpdate;
      EnableControls;
    end;
  end;
end;

end.

