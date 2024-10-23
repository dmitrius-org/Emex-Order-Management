unit uSqlUtils;

interface

uses System.SysUtils, System.UITypes, Variants,  Data.DB,//System.Rtti,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Intf,
     FireDAC.Stan.Async,  System.Threading
    // uniGUIForm, uniGUITypes
     ;

Type
  /// <summary>
  /// Класс для работы с SQL запросами.
  /// </summary>
  TSql = class
  private
    var FQuery: TFDQuery;
    var FConnection: TFDConnection;

    function GetConnection: TFDConnection;
    procedure SetConnection(const Value: TFDConnection);
    function GetCount: integer;

//    var FSql: TSql;

//    function GetConnection: TFDConnection;
//    procedure SetConnection(const Value: TFDConnection);
    procedure Prepare(AQuery: TFDQuery; AParams: array of string; AArgs: array of variant);
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
   // property Connection: TFDConnection read GetConnection write SetConnection;

    // overload;
    function Q():TFDQuery;

    /// <summary>
    /// Возвращает результат запроса переданного в параметре ASqlText
    /// в компонент AQuery. Запрос выполняется как "Query.Open".
    /// </summary>
    procedure Open(AQuery: TFDQuery; AParams: array of string; AArgs: array of variant); overload;

    /// <summary>
    /// Возвращает результат запроса переданного в параметре ASqlText
    /// в компонент TSql.Q.
    /// </summary>
    procedure Open(ASql: String; AParams: array of string; AArgs: array of variant);     overload;

    procedure Exec(ASql: String; AParams: array of string; AArgs: array of variant);

    /// <summary>
    /// ExecAsync - асинхронное выполнение запроса
    /// </summary>
    /// <param name="ASql">Запрос</param>
    /// <param name="AParams">Массив списка наименований параметров</param>
    /// <param name="AArgs">Массив значений параметров</param>
    procedure ExecAsync(ASql: String; AParams: array of string; AArgs: array of variant);


    /// <summary>
    /// GetSetting - получение значния настройки
    /// </summary>
    function GetSetting(ASetting: String): Variant; overload;
    function GetSetting(ASetting: String; ADefValue: Double): Double; overload;
    function GetSetting(ASetting: String; ADefValue: Boolean): Boolean; overload;
    function GetSetting(ASetting: String; ADefValue: Integer): Integer; overload;


    property Count: integer read GetCount;
  end;


implementation

uses
  uLogger, uUtils.Varriant;


{ TSql }

function TSql.GetSetting(ASetting: String): Variant;
var Query: TFDQuery;
begin
  Query :=TFDQuery.Create(nil);
//  Query.FetchOptions.AutoFetchAll := TFDAutoFetchAll.afAll;
  Query.FetchOptions.RowsetSize := 1000000;
  Try
    Query.Connection := FConnection;
    Query.Close;
    Query.SQL.Text:= 'SELECT isnull((SELECT Val FROM [tSettings] (Nolock) WHERE Brief = :ASetting), '''') as val';
    Query.ParamByName('ASetting').Value := ASetting;
    Query.Open();
    result:= Query.FieldByName('Val').Value;
    Query.Close;
  Finally
    FreeAndNil(Query);
  End;
end;

function TSql.GetSetting(ASetting: String; ADefValue: Double): Double;
var v: Variant;
begin
  v := GetSetting(ASetting);
  result:= VarToDoubleDef(v, ADefValue);
end;

function TSql.GetSetting(ASetting: String; ADefValue: Boolean): Boolean;
var v: Variant;
begin
  v := GetSetting(ASetting);
  result:= VarToBoolDef(v, ADefValue);
end;

function TSql.Q: TFDQuery;
begin
  if not Assigned(FQuery) then
  begin
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConnection;
  end;

  result := FQuery;
end;

constructor TSql.Create(AConnection: TFDConnection);
begin
  inherited Create();

  if Assigned(AConnection) then
    FConnection:=AConnection;
end;

destructor TSql.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TSql.Exec(ASql: String; AParams: array of string;  AArgs: array of variant);
var FQueryTMP:TFDQuery;
begin
  FQueryTMP := TFDQuery.Create(nil);
  FQueryTMP.Connection := FConnection;

  FQueryTMP.SQL.Text := ASql;
  Prepare(FQueryTMP, AParams, AArgs);
  FQueryTMP.ExecSQL;
  FQueryTMP.Close;
  FreeAndNil(FQueryTMP);
end;

procedure TSql.ExecAsync(ASql: String; AParams: array of string; AArgs: array of variant);
VAR SQL: string; FQueryTMP:TFDQuery;
begin

  FQueryTMP := TFDQuery.Create(nil);
  FQueryTMP.Connection := FConnection;
  FQueryTMP.SQL.Text := ASql;
  Prepare(FQueryTMP, AParams, AArgs);

  TTask.Run(procedure
  var
      I: Integer;
  begin
    try
      // Асинхронное выполнение запроса
      //FQueryTMP.ResourceOptions.CmdExecMode := amAsync;
      //FQueryTMP.AsyncExec := True;
      FQueryTMP.ExecSQL;
    finally
      FQueryTMP.Free;
    end;

  end).Start;
end;

procedure TSql.Open(AQuery: TFDQuery; AParams: array of string; AArgs: array of variant);
begin
  AQuery.Close;
  Prepare(AQuery, AParams, AArgs);
  AQuery.Open;
end;

procedure TSql.Open(ASql: String; AParams: array of string; AArgs: array of variant);
begin
  Q.Close;
  Q.SQL.Text := ASql;
  Open(Q, AParams, AArgs);
end;

procedure TSql.Prepare(AQuery: TFDQuery; AParams: array of string; AArgs: array of variant);
var i: Integer;
begin
  for i := 0 to High(AParams) do
  begin
    if AArgs[i] = null then
    begin
      with AQuery.ParamByName(AParams[i]) do
      begin
        DataType := ftString;
        Clear;
      end;
    end
    else
      AQuery.ParamByName(AParams[i]).Value := AArgs[i];
  end;
end;

function TSql.GetConnection: TFDConnection;
begin
  Result:= FConnection;
end;

function TSql.GetCount: integer;
begin
  result:= q.RecordCount;
end;

procedure TSql.SetConnection(const Value: TFDConnection);
begin
  if Assigned(Value) then
  begin
    FConnection:= Value;

    if not Assigned(FQuery) then FQuery := TFDQuery.Create(nil);

    FQuery.Connection :=FConnection;
  end;
end;

function TSql.GetSetting(ASetting: String; ADefValue: Integer): Integer;
var v: Variant;
begin
  v := GetSetting(ASetting);
  result:= VarToIntDef(v, ADefValue);
end;

end.
