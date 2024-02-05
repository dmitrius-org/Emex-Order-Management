unit uAuditUtils;

interface

uses System.SysUtils, //Vcl.Dialogs, //System.Variants,

     FireDAC.Comp.Client, FireDAC.Comp.Script,

     uCommonType;

Type
  /// <summary>
  /// Класс для аудирования действий пользователя.
  /// </summary>
  TAudit = class
    private
      var FConnection: TFDConnection;
      var FRetVal: TRetVal;
    private
    procedure SetRetVal(const Value: TRetVal);
//      function GetConnection: TFDConnection;
//      procedure SetConnection(const Value: TFDConnection);
    public
      constructor Create(AConnection: TFDConnection);
      destructor Destroy; override;

      property RetVal: TRetVal read FRetVal write SetRetVal;

      //property Connection: TFDConnection read GetConnection write SetConnection;
      /// <summary>
      /// Add - добавление аудита
      /// AObjectID     - ИД объекта по которому ведется аудит
      /// AObjectTypeID - тип объекта
      /// AActionID     - ИД выполняемое дейстие из tAction
      /// AComment      - Комментарий
      /// </summary>
      function Add(AObjectTypeID:TObjectType; AObjectID: Integer;
                   AActionID: TFormAction;
                   AComment: string;
                   AUserID: integer = 0;
                   AHostInfoID: string = ''): Integer;

  end;

  function Audit: TAudit;

implementation

uses  MainModule;

function Audit: TAudit;
begin
  if not Assigned(MainModule.UniMainModule.AAudit) then
    MainModule.UniMainModule.AAudit := TAudit.Create(MainModule.UniMainModule.FDConnection);

  Result := MainModule.UniMainModule.AAudit;
end;

{ TAudit }

function TAudit.Add(
  AObjectTypeID:TObjectType;
  AObjectID:Integer;
  AActionID: TFormAction;
  AComment: string;
  AUserID: integer;
  AHostInfoID: string): integer;
var Qry: TFDQuery;
Begin
  try
    Result:= 0;
    Qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;

    qry.Close;
    qry.SQL.Text := ' declare @R      int                     '+
                    '        ,@AuditID numeric(18, 0)         '+
                    ' ' +
                    ' exec @r = AuditInsert                   '+
                    '             @AuditID     = @AuditID out  '+
                    '            ,@ObjectID    = :ObjectID     '+
                    '            ,@ObjectTypeID= :ObjectTypeID '+
                    '            ,@ActionID    = :ActionID     '+
                    '            ,@Comment     = :Comment      '+
                    '            ,@UserID      = :UserID       '+
                    '            ,@HostInfoID  = :HostInfoID   '+
                    ' ' +
                    ' select @r as retcode, @AuditID as AuditID'+
                    ' ';
    qry.ParamByName('ObjectID').Value     := AObjectID;
    qry.ParamByName('ObjectTypeID').Value := AObjectTypeID ;
    qry.ParamByName('ActionID').Value     := AActionID;
    qry.ParamByName('Comment').Value      := AComment;
    qry.ParamByName('UserID').Value       := AUserID;
    qry.ParamByName('HostInfoID').Value   := AHostInfoID;
    qry.Open;
    RetVal.Code := qry.FieldByName('retcode').Value;


    if RetVal.Code = 0 then
    begin
      Result:= qry.FieldByName('AuditID').Value;
    end
    else
    begin
      Result:=0
    end;
    qry.Close;
  finally
   FreeAndNil(Qry);
  end

end;

constructor TAudit.Create(AConnection: TFDConnection);
begin
  inherited Create();

  if Assigned(AConnection) then
    FConnection:=AConnection;

  FRetVal:= TRetVal.Create(FConnection);
end;

destructor TAudit.Destroy;
begin
  FreeAndNil(FRetVal);
  inherited;
end;

procedure TAudit.SetRetVal(const Value: TRetVal);
begin
  FRetVal := Value;
end;

end.
