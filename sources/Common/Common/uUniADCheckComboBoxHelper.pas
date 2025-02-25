unit uUniADCheckComboBoxHelper;

interface

uses
  System.SysUtils, System.Classes, uUniADCheckComboBoxEx, Data.DB, uMainVar;

type
  TUniADCheckComboBoxHelper  = class helper for TUniADCheckComboBox
  public
    /// <summary>
    /// FillFromSQL - ��������� �� ������� �� ��.
    /// </summary>
    /// <param name="ASQL">SQL �����. � ������� ����������� ������ ���� ���� ID, Name</param>
    procedure FillFromSQL(const ASQL: string);
  end;

implementation

procedure TUniADCheckComboBoxHelper.FillFromSQL(const ASQL: string);
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
