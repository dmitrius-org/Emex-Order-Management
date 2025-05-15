unit uTaskUtils;

interface

uses System.SysUtils, //Vcl.Dialogs, //System.Variants,
     System.UITypes, Variants,  Data.DB,
     Winapi.ShellAPI, Windows, Messages,

     FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Stan.Param,

     uCommonType, uSqlUtils, uniGUIApplication, uniGUITypes;

Type
  /// <summary>
  /// TMTask -
  /// </summary>
  TMTask = class
  strict private
    FConnection: TFDConnection;
    FSQL: TSql;

//    FIsActive: Boolean;

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
    /// </summary>
    /// <param name="AObjectTypeID">Тип объекта</param>
    /// <param name="AObjectID">ИД объекта по которому ведется аудит</param>
    /// <param name="AActionID">ИД выполняемое дейстие из tAction</param>
    /// <param name="AComment">Комментарий</param>
    /// <param name="AFlag">Флаги</param>
    /// <param name="AUserID">ИД пользователя</param>
    /// <param name="AHostInfoID">Хост</param>
    procedure AuditInsert(
                   AObjectTypeID:TObjectType; AObjectID: Integer;
                   AActionID: TFormAction;
                   AComment: string;
                   AFlag: tAuditFlag = tAuditFlag.agInfo;
                   AUserID: integer = 0;
                   AHostInfoID: string = ''
                  );

   procedure TaskProgress(ATaskID:Integer; ASatus:Boolean);
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
  uAccrualUtils, uUtils.Logger;


{ TMTask }

function TMTask.GetIsActive: Boolean;
begin

  Result:= FConnection.ExecSQLScalar(' Select IsActive from tTaskActive (nolock) ', []);

//  if FIsActive <> Result then
//  begin
//    FIsActive:=Result;
//
//    BroadcastMessage('TaskEnabled',
//                    ['Enabled', FIsActive],
//                    [boIgnoreCurrentSession]); //  boClientOnly
//
//  end;

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

procedure TMTask.TaskProgress(ATaskID: Integer; ASatus: Boolean);
begin
  FSQl.Exec('exec TaskProgress @TaskID = :TaskID, @IsActive = :IsActive', ['TaskID', 'IsActive'], [ATaskID, ASatus]);
end;

procedure TMTask.WriteTaskMessage(ATaskID: Integer; AMessage: String);
var qry: TFDQuery;
begin
  try
    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := ' exec TaskWriteErrorMessage '+
                    '        @TaskID  = :TaskID  '+
                    '       ,@Message = :Message ' ;
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
                   AFlag: tAuditFlag = tAuditFlag.agInfo;
                   AUserID: integer = 0;
                   AHostInfoID: string = '');
var qry: TFDQuery;
Begin
  try
    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := '''
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
                                ,@Flag        = :Flag

                     select @r as retcode, @AuditID as AuditID
                    ''';
    qry.ParamByName('ObjectID').Value     := AObjectID;
    qry.ParamByName('ObjectTypeID').Value := AObjectTypeID ;
    qry.ParamByName('ActionID').Value     := AActionID;
    qry.ParamByName('Comment').Value      := AComment;
    qry.ParamByName('UserID').Value       := AUserID;
    qry.ParamByName('HostInfoID').Value   := AHostInfoID;
    qry.ParamByName('Flag').Value         := AFlag;
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

  FSQL:= TSql.Create(FConnection);
end;

destructor TMTask.Destroy;
begin
  inherited;
  FSQL.Destroy;
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
   act: TFDQuery;

  i, a: Integer;
  Proc: TProcExec;
//    rc: word;
     M: string;
TaskID: Integer;
   Msg: string;

TaskErr: Boolean;

   /// <summary>
   /// ExecProcedure - Выполнение внутренней процедуры
   /// </summary>
   procedure ExecProcedure();
   begin
     Proc := TProcExec.Create(FConnection);
     try
       try
         if M='' then raise Exception.Create('Не настроена внутренняя процедура!');

         Proc.Call(M);

         // следующая дата выполнения
         //Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1, @Message = :2', [TaskID, '']);

         AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, 'Выполнение действия завершено: ' + act.FieldByName('Comment').AsString);
       except
         on E: Exception do
         begin
           Log('ExecProcedure.Exception: ' + E.Message, etException);
           AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message);

           WriteTaskMessage(TaskID, E.Message);

           TaskErr := True;
         end
       end;
     finally
       Log('ExecProcedure.finally', etDebug);
       Proc.Destroy;
     end;
   end;


   /// <summary>
   /// ExecBat - Выполнение bat файла
   /// </summary>
   procedure ExecBat();
   begin
     Log('ExecBat.Execute Script: ' + M, etDebug);
     try
       try
         if M='' then
           raise Exception.Create('Не указан путь к скрипту!');

         Msg:=ExecDosOutput(M);

         if Msg<>'' then
         begin
           Log('ExecBat.ERROR AnsiPos: ' + AnsiPos ('ERROR', Msg).ToString, etDebug);

           if AnsiPos ('ERROR', Msg)>0 then
             raise Exception.Create(Msg);
         end;

         AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, 'Выполнение действия завершено: ' + act.FieldByName('Comment').AsString);

       except
         on E: Exception do
         begin
           Log('ExecBat.Exception' + E.Message, etDebug);

           AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message);

           WriteTaskMessage(TaskID, e.Message);

           TaskErr := True;
         end
       end;
     finally
       Log('ExecBat.finally', etDebug);
     end;
   end;


   /// <summary>
   /// ExecSQL - Выполнение sql скрипта
   /// </summary>
   procedure ExecSQL();
   begin
     Log('ExecSQL.Execute Script: ' + M, etDebug);
     try
       try
         if M='' then
           raise Exception.Create('Не задан текст скрипта!');

         Qry.Connection.ExecSQL(M, []);

         // следующая дата выполнения
         //Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1, @Message = :2', [TaskID, '']);
         AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, 'Выполнение действия завершено: ' + act.FieldByName('Comment').AsString);
       except
         on E: Exception do
         begin
           Log('ExecSQL.Exception' + E.Message, etDebug);
           AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, E.Message, tAuditFlag.agError);

           WriteTaskMessage(TaskID, e.Message);

           TaskErr := True;
         end
       end;
     finally
       Log('ExecSQL.finally', etDebug);
     end;
   end;

begin
    Log('TMTask.Execute Begin', etDebug);

    qry:= TFDQuery.Create(nil);
    qry.Connection:= FConnection;
    qry.Close;
    qry.SQL.Text := ' Select *           ' +
                    '   from vTaskSelect ';
    qry.Open;
    Try
        // цикл по задачам
        qry.First;
        for i := 0 to qry.RecordCount-1 do
        begin
            Log('TMTask.Execute Задача: ' + qry.FieldByName('TaskBrief').AsString, etDebug);

            TaskID:= qry.FieldByName('TaskID').AsInteger;
            TaskErr := false;

            TaskProgress(TaskID, true);

            BroadcastMessage('TaskProgress',
                            ['TaskID', TaskID],
                            []); //boIgnoreCurrentSession boClientOnly

            act:= TFDQuery.Create(nil);
            Try
                act.Connection:= FConnection;
                act.Close;
                act.SQL.Text := ' Select *                  ' +
                                '   from vTaskActionsSelect ' +
                                '  where TaskID=:TaskID     ' +
                                '  order by Number          ';
                act.ParamByName('TaskID').Value := TaskID;
                act.Open;

                act.First;
                for a := 0 to act.RecordCount-1 do  // цикл по действиям / шагам
                begin
                    M := act.FieldByName('Method').AsString; Msg := '';

                    AuditInsert(TObjectType.otTask, TaskID, TFormAction.acNone, 'Выполнение действия: ' + act.FieldByName('Comment').AsString);

                    case act.FieldByName('TaskType').AsInteger of
                      Integer(tTaskType.ttProc):  // внутренняя процедура
                      begin
                          ExecProcedure();
                      end;
                      Integer(tTaskType.ttBat):  // bat файл
                      begin
                          ExecBat();
                      end;
                      Integer(tTaskType.ttSQL):  // SQL
                      begin
                          ExecSQL();
                      end;
                    end;

                    //если на каком-то шаге получили ошибку, то прекращаем выполнение
                    if TaskErr then Break;

                    act.Next;
                end;

            finally
                FreeAndNil(act);

                // следующая дата выполнения
                if TaskErr then
                  Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1, @Message = null', [TaskID])
                else
                  Qry.Connection.ExecSQL('exec TaskDateExecCalc @TaskID = :1', [TaskID]);

                BroadcastMessage('TaskProgress',
                                ['TaskID', TaskID],
                                []); //boIgnoreCurrentSession  boClientOnly
            End;
            Qry.Next;
        end;
    finally
        FreeAndNil(Qry);
    End;
    Log('TMTask.Execute End', etDebug);
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

    Handle := CreateProcess(nil, PChar('cmd.exe /C' + CommandLine), // /C
                            nil, nil, True, 0, nil, nil, SI, PI);   // PChar(WorkDir), SI, PI);

    CloseHandle(StdOutPipeWrite);

    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + string(Buffer);
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
