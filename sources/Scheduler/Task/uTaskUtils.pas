unit uTaskUtils;

interface

uses System.SysUtils, //Vcl.Dialogs, //System.Variants,
     System.UITypes, Variants,  Data.DB,
     Winapi.ShellAPI, Windows, Messages,

     FireDAC.Comp.Client, FireDAC.Comp.Script,

     uCommonType;

Type
  /// <summary>
  /// TMTask -
  /// </summary>
  TMTask = class
  strict private
    var FConnection: TFDConnection;

  private
    function GetIsActive: Boolean;
    procedure SetIsActive(const Value: Boolean);

    /// <summary>
    /// AuditInsert - записывает сообщение в поле message таблицы tTask
    /// AMessage     - сообщение
    /// </summary>
    procedure WriteTaskMessage(ATaskID:Integer; AMessage: String);

//    procedure ExecFile2(const sComand, sParameter : string; var rc : word; isExecuteHide:Boolean=True);

    function ExecDosOutput(CommandLine: String): String;

    /// <summary>
    /// AuditInsert - добавление аудита
    /// AObjectID     - ИД объекта по которому ведется аудит
    /// AObjectTypeID - тип объекта
    /// AActionID     - ИД выполняемое дейстие из tAction
    /// AComment      - Комментарий
    /// </summary>
    procedure AuditInsert(
                   AObjectTypeID:TObjectType; AObjectID: Integer;
                   AActionID: TFormAction;
                   AComment: string;
                   AUserID: integer = 0;
                   AHostInfoID: string = ''
                  );
  public
    constructor Create(Value: TFDConnection); overload;
    destructor Destroy; override;

    property IsActive: Boolean read GetIsActive write SetIsActive;

    /// <summary>
    /// Execute - Выполнение задачи
    /// </summary>
    procedure Execute();



  end;

implementation

uses
  uAccrualUtils, uLogger;

{ TTask }


function TMTask.GetIsActive: Boolean;
begin
  Result:= FConnection.ExecSQLScalar(' Select IsActive from tTaskActive (nolock) ', []);
end;

procedure TMTask.SetIsActive(const Value: Boolean);
var qry: TFDQuery;
begin
  try
    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := ' Update tTaskActive      '+
                    '    set IsActive = :IsActive ';
    qry.ParamByName('IsActive').Value := Value;
    qry.ExecSQL;
    qry.Close;

    if Value then
      AuditInsert(TObjectType.otTask, 0, acOn, '')
    else
      AuditInsert(TObjectType.otTask, 0, acOff, '')
  finally
    FreeAndNil(qry);
  end;
end;

procedure TMTask.WriteTaskMessage(ATaskID: Integer; AMessage: String);
var qry: TFDQuery;
begin
  try
    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := ' Update tTask              '+
                    '    set Message = :Message '+
                    '  where TaskID    = :TaskID';
    qry.ParamByName('TaskID').Value := ATaskID;
    qry.ParamByName('Message').Value := AMessage;
    qry.ExecSQL;
    qry.Close;

  finally
    FreeAndNil(qry);
  end;
end;

procedure TMTask.AuditInsert(
                   AObjectTypeID:TObjectType; AObjectID: Integer;
                   AActionID: TFormAction;
                   AComment: string;
                   AUserID: integer = 0;
                   AHostInfoID: string = '');
var qry: TFDQuery;
Begin
  try
    qry:= TFDQuery.Create(nil);
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
    qry.Close;
  finally
   FreeAndNil(qry);
  end
end;

constructor TMTask.Create(Value: TFDConnection);
begin
  inherited Create;
  FConnection := Value;
end;

destructor TMTask.Destroy;
begin
  inherited;
end;
                   {
procedure TMTask.ExecFile2(const sComand, sParameter: string; var rc: word; isExecuteHide:Boolean=True);
var
   sInfo: TStartupInfo;
   pInfo: TProcessInformation;
   sCmd : string;
   ahwnd: HWND;

   CreationFlag: Cardinal;
begin
  FillChar(sInfo, SizeOf(sInfo), 0);
  sInfo.cb := SizeOf(sInfo);
  sInfo.wShowWindow := SW_SHOWMINNOACTIVE;

  sCmd := sComand;
  if (sParameter > '') then sCmd := sCmd + ' ' + sParameter;

  if isExecuteHide then
    CreationFlag :=  CREATE_NO_WINDOW
  else
    CreationFlag :=  NORMAL_PRIORITY_CLASS;

  if (Not CreateProcess(Nil, PChar(sCmd), Nil, Nil, False, CreationFlag, Nil, Nil, sInfo, pInfo)) then
  begin
    rc := GetLastError;
  end;

  ahwnd:=pInfo.hProcess;
  while WaitForSingleObject(ahwnd, 100)=WAIT_TIMEOUT do   //wait untill finish
  begin
     //
  end;

  CloseHandle(pInfo.hThread);
end;  }

procedure TMTask.Execute;
var
   qry: TFDQuery;
     i: Integer;
  Proc: TProcExec;
    rc: word;
     M: string;
TaskID: Integer;
   Msg: string;
begin
    Logger.Info('TMTask.Execute Begin');

    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := ' Select * from vTaskSelect ';
    qry.Open;
 //   Try
        for i := 0 to qry.RecordCount-1 do
        begin
          Logger.Info('TMTask.Execute Задача:' + qry.FieldByName('TaskBrief').AsString);
          TaskID:= qry.FieldByName('TaskID').AsInteger;
          M     := qry.FieldByName('Method').AsString;
          Msg   := '';
          AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, 'Выполнение задачи:' + qry.FieldByName('TaskBrief').AsString);

          case qry.FieldByName('TaskType').AsInteger of
            Integer(tTaskType.ttProc):  // внутренняя процедура
            begin
              Logger.Info('TMTask.Execute Method: ' + M );
              try
                Proc := TProcExec.Create(FConnection);
                try
                  if M='' then raise Exception.Create('Не настроена внутренняя процедура!');

                  Proc.Call(M);

                  Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1, @Message = :2', [TaskID, '']);
                except
                  on E: Exception do
                  begin
                    Logger.Info('TMTask.Exception: ' + E.Message);
                    AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message);

                    WriteTaskMessage(TaskID, e.Message);
                  end
                end;
              finally
                Logger.Info('TMTask.finally');
                Proc.Destroy;
              end;
            end;

            Integer(tTaskType.ttBat):  // bat файл
            begin
              Logger.Info('TMTask.Execute Script: ' + M );
              try
                try
                  if M='' then
                    raise Exception.Create('Не указан путь к скрипту!');

                  //ExecFile2(M, '', rc,  ((qry.FieldByName('Flag').AsInteger and 1) = 1));
                  Msg:=ExecDosOutput(M);

                  if Msg<>'' then
                    raise Exception.Create(Msg);

                  Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1, @Message = :2', [TaskID, '']);
                except
                  on E: Exception do
                  begin
                    Logger.Info('TMTask.Exception' + E.Message);
                    AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message);

                    WriteTaskMessage(TaskID, e.Message);
                  end
                end;
              finally
                Logger.Info('TMTask.finally');
              //  if rc > 0 then
                //  WriteTaskMessage(TaskID, rc.ToString);
              end;
            end;

//            Integer(tTaskType.ttSQL):  // cmd
//            begin
//              Logger.Info('TMTask.Execute Script: ' + M );
//              try
//                try
//                  if M='' then
//                    raise Exception.Create('Не указан текст скрипта!');
//
//                  Msg:=ExecDosOutput(M);
//
//                  Qry.Connection.ExecSQL(' exec TaskDateExecCalc @TaskID = :1, @Message = :2 ', [TaskID, Msg]);
//                except
//                  on E: Exception do
//                  begin
//                    AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message);
//
//                    WriteTaskMessage(TaskID, e.Message);
//                  end
//                end;
//              finally
//                if rc > 0 then
//                  WriteTaskMessage(TaskID, rc.ToString);
//              end;
//            end;

          end;
        end;
   // finally
    FreeAndNil(Qry);
 // End;
    Logger.Info('TMTask.Execute End');
end;

function TMTask.ExecDosOutput(CommandLine:String): String;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;//AnsiChar;
  BytesRead: Cardinal;
  //WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;

  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    //WorkDir := Work;

    Handle := CreateProcess(nil, PChar('cmd.exe /C' + CommandLine),    // /C
                            nil, nil, True, 0, nil, nil, SI, PI);  // PChar(WorkDir), SI, PI);

    CloseHandle(StdOutPipeWrite);

    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
          end;
        until not WasOK or (BytesRead = 0);

        WaitForSingleObject(PI.hProcess, INFINITE);

      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;


end.
