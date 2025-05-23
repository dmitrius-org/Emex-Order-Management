unit uUtils.BusinessComboBoxHelper;

interface

uses
  uUniExCheckComboBox, Data.DB, uMainVar;

type
  /// <summary>
  /// TBusinessComboBoxHelper - Расширение для TUniExCheckComboBox бизнес логикой.
  /// </summary>
  TBusinessComboBoxHelper = class helper for TUniExCheckComboBox
  private

  public
    /// <summary>
    /// FillFromSQL - позволяет заполнять списк значений из БД произвольным запросом.
    /// </summary>
    procedure FillFromSQL(const ASQL: string);

    /// <summary>
    /// FillClients - получение списка клиентов.
    /// </summary>
    procedure FillClients;

    /// <summary>
    /// FillPrices - получение списка прайсов.
    /// </summary>
    procedure FillPrices;

  end;

implementation

procedure TBusinessComboBoxHelper.FillClients;
begin
  Self.FillFromSQL('''
    DECLARE @R table (ID     numeric(18, 0),
                      Brief  varchar(256),
                      Name   varchar(256));

    INSERT @R EXEC OrderFilter_Client;

    SELECT ID,
           Brief as Name
      FROM @R;
  ''');
end;

procedure TBusinessComboBoxHelper.FillPrices;
begin
//  Self.FillFromSQL('''
//    DECLARE @R table (ID     numeric(18, 0),
//                      Brief  varchar(256),
//                      Name   varchar(256));
//
//    INSERT @R EXEC OrderFilter_Client;
//
//    SELECT ID,
//           Brief as Name
//      FROM @R;
//  ''');
end;


procedure TBusinessComboBoxHelper.FillFromSQL(const ASQL: string);
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

