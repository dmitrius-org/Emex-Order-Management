unit uUtils.Logger;

{
обертка для логгер
}

interface

uses
 Quick.Logger;

type

  TmyEventType = (etHeader, etInfo, etSuccess, etWarning, etError, etCritical, etException, etDebug, etTrace, etDone, etCustom1, etCustom2);

  function MyToQuickEventType(E: TmyEventType): TEventType;

  procedure Log(const cMsg : string; cEventType : TmyEventType); overload;
  procedure Log(const cMsg : string; cValues : array of {$IFDEF FPC}const{$ELSE}TVarRec{$ENDIF}; cEventType : TmyEventType); overload;

implementation

uses
  MainModule;

function MyToQuickEventType(E: TmyEventType): TEventType;
begin
  case E of
    etHeader:   Result := Quick.Logger.etInfo;
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

procedure Log(const cMsg : string; cEventType : TmyEventType); overload;
begin
  UniMainModule.ALogger.Add(cMsg, MyToQuickEventType(cEventType));
end;

procedure Log(const cMsg : string; cValues : array of {$IFDEF FPC}const{$ELSE}TVarRec{$ENDIF}; cEventType : TmyEventType); overload;
begin
  UniMainModule.ALogger.Add(cMsg, cValues, MyToQuickEventType(cEventType));
end;

end.
