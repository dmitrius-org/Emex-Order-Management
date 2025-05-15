unit uAuditUtils;

interface

uses System.SysUtils, //Vcl.Dialogs, //System.Variants,
     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Param,
     uniGUIApplication,
     uCommonType;

Type
  /// <summary>
  /// Класс для аудирования действий пользователя.
  /// </summary>
  TAudit = class
    private
      FConnection: TFDConnection;
      FRetVal: TRetVal;
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
      procedure Add(AObjectTypeID: TObjectType;
                    AObjectID: Integer;
                    AActionID: TFormAction;
                    AComment: string;
                    AUserID: integer = 0;
                    AHostInfoID: string = '');   //
  end;

  function Audit: TAudit;

implementation

uses MainModule;

function Audit: TAudit;
begin
  if not Assigned(MainModule.UniMainModule.AAudit) then
    MainModule.UniMainModule.AAudit := TAudit.Create(MainModule.UniMainModule.FDConnection);

  Result := MainModule.UniMainModule.AAudit;
end;

{ TAudit }

procedure  TAudit.Add(
  AObjectTypeID: TObjectType;
  AObjectID: Integer;
  AActionID: TFormAction;
  AComment: string;
  AUserID: integer;
  AHostInfoID: string);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    if AHostInfoID = '' then
      AHostInfoID := UniSession.RemoteIP;

    Qry.Connection := FConnection;
    Qry.SQL.Text := '''
     declare @R      int
            ,@AuditID numeric(18, 0)

     exec @r = AuditInsert
                 @AuditID     = @AuditID out
                ,@ObjectID    = :ObjectID
                ,@ObjectTypeID= :ObjectTypeID
                ,@ActionID    = :ActionID
                ,@Comment     = :Comment
                ,@UserID      = :UserID
                ,@HostInfoID  = :HostInfoID

     select @r as retcode, @AuditID as AuditID
    ''';

    Qry.ParamByName('ObjectID').AsInteger     := AObjectID;
    Qry.ParamByName('ObjectTypeID').AsInteger := Ord(AObjectTypeID);
    Qry.ParamByName('ActionID').AsInteger     := Ord(AActionID);
    Qry.ParamByName('Comment').AsString       := AComment;
    Qry.ParamByName('UserID').AsInteger       := AUserID;
    Qry.ParamByName('HostInfoID').AsString    := AHostInfoID;

    Qry.Open;

    RetVal.Code := Qry.FieldByName('retcode').AsInteger;
//    if RetVal.Code = 0 then
//      Result := Qry.FieldByName('AuditID').AsInteger
//    else
//      Result := 0;
  finally
    FreeAndNil(Qry);
  end;
end;

constructor TAudit.Create(AConnection: TFDConnection);
begin
  inherited Create;

  if Assigned(AConnection) then
    FConnection := AConnection;

  FRetVal := TRetVal.Create(FConnection);
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

