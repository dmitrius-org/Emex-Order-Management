unit uUtils.Logger;

{
обертка для логгер
}

interface

uses Quick.Logger, TypInfo, SysUtils;

type
  // INFO SUCC WARN ERROR CRITICAL EXCEPT DEBUG TRACE DONE CUST1 CUST2
  TmyEventType = (etHeader, etInfo, etSuccess, etWarning, etError, etCritical, etException, etDebug, etTrace, etDone, etCustom1, etCustom2);

  /// <summary>
  /// SetCurrentLogData - сохранение логгера в потоке
  /// </summary>
  procedure SetCurrentLogData(const AValue: TLogger);
  /// <summary>
  /// GetCurrentLogData -  получение логгера для потока
  /// </summary>
  function GetCurrentLogData():TLogger;

  function MyToQuickEventType(E: TmyEventType): TEventType;
  procedure LogInfo(const cMsg : string);
  procedure Log(const cMsg : string; cEventType : TmyEventType); overload;
  procedure Log(const cMsg : string; cValues : array of {$IFDEF FPC}const{$ELSE}TVarRec{$ENDIF}; cEventType : TmyEventType); overload;

  /// <summary>
  /// ParseLogLevel - Парсинг собтий для логирования из строки
  /// </summary>
  function ParseLogLevel(const S: string): TLogLevel;

threadvar
  CurrentLogData : TLogger;

implementation

uses
  MainModule, ServerModule;

procedure SetCurrentLogData(const AValue: TLogger);
begin
  if Assigned(AValue) then
    CurrentLogData := AValue;
end;

function GetCurrentLogData: TLogger;
begin
  try
    if Assigned(CurrentLogData) then
      Result := CurrentLogData
    else
     Result := UniMainModule.ALogger;
  except
    on E: Exception do
      UniServerModule.Logger.AddLog('GetCurrentLogData', e.Message);
  end;
end;

function MyToQuickEventType(E: TmyEventType): TEventType;
begin
  case E of
    etHeader:   Result := Quick.Logger.etHeader;
    etInfo:     Result := Quick.Logger.etInfo;
    etSuccess:  Result := Quick.Logger.etSuccess;
    etWarning:  Result := Quick.Logger.etWarning;
    etError:    Result := Quick.Logger.etError;
    etCritical: Result := Quick.Logger.etCritical;
    etException:Result := Quick.Logger.etException;
    etDebug:    Result := Quick.Logger.etDebug;
    etTrace:    Result := Quick.Logger.etTrace;
    etDone:     Result := Quick.Logger.etDone;
    etCustom1:  Result := Quick.Logger.etCustom1;
    etCustom2:  Result := Quick.Logger.etCustom2;
  end;
end;

procedure LogInfo(const cMsg : string);
begin
  GetCurrentLogData.Add(cMsg, Quick.Logger.etInfo);
end;

procedure Log(const cMsg : string; cEventType : TmyEventType); overload;
begin
  GetCurrentLogData.Add(cMsg, MyToQuickEventType(cEventType));
end;

procedure Log(const cMsg : string; cValues : array of {$IFDEF FPC}const{$ELSE}TVarRec{$ENDIF}; cEventType : TmyEventType); overload;
begin
  GetCurrentLogData.Add(cMsg, cValues, MyToQuickEventType(cEventType));
end;


//
function ParseLogLevel(const S: string): TLogLevel;
var
  Parts: TArray<string>;
  Part: string;
  EventType: TEventType;
begin
  Result := [];
  Parts := S.Split([';']);

  for Part in Parts do
  begin
    for EventType := Low(TEventType) to High(TEventType) do
    begin
      if Trim(UpperCase(Part)) = DEF_EVENTTYPENAMES[Ord(EventType)] then
      begin
        Include(Result, EventType);
        Break;
      end;
    end;
  end;
end;
end.
