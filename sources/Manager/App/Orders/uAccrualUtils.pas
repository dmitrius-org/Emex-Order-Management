unit uAccrualUtils;

 {                            Оработка действий                                }

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics,
      Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
      uniGUIClasses, uniGUIFrame, uniGUIBaseClasses,
      uniGUIDialogs,

      FireDAC.Comp.Client, FireDAC.Comp.Script ,FireDAC.Stan.Param,

      uCommonType, uSqlUtils, uEmexUtils, Quick.Logger;
type
  TMyFuncType = function(): integer of object;
  TProcExec = class
  private
    Emex: TEmex;
    FLogger: tLogger;
    function GetLogger: tLogger;
    procedure SetLogger(const Value: tLogger);

  published
    /// <summary>
    /// InsertPartToBasketByPartFromMark - Помещение запчастей в корзину на основе меток tMarks
    /// </summary>
    procedure InsertPartToBasketByPartFromMark();

    /// <summary>
    /// InsertPartToBasketByPartRollBack - Удаление запчастей из корзины на основе меток tMarks
    /// </summary>
    procedure InsertPartToBasketByPartRollBack();

    /// <summary>
    /// EmexCreateOrderCheck - Проверка наличия заказа в Emex по данным корзины
    /// </summary>
    procedure EmexCreateOrderCheck();

    /// <summary>
    /// EmexCreateOrder - Создание заказа клиента по данным корзины
    /// </summary>
    procedure EmexCreateOrder();

    /// <summary>
    /// EmexOrderStateSync - Синхронизация статусов
    /// </summary>
    procedure EmexOrderStateSync();
  public
    constructor Create(Value: TFDConnection); overload;
    destructor Destroy; override;

    procedure Call(MethodName: string);

    property Logger: tLogger read GetLogger write SetLogger;
  end;

/// <summary>
///  TAccrual - класс для выполнения действий
///</summary>
TAccrual = class
  private
    var FConnection: TFDConnection;
    function GetShowProgress: Boolean;
    procedure SetShowProgress(const Value: Boolean);
    procedure SetFinished(const Value: Boolean);

    var FFinished: Boolean;
    var FShowProgress:  Boolean;   // показывать ход выполнения операции

    var FSQl: TSql;
    var FRetVal: tRetVal;

    function GetSQL: TSql;
    function GetFinished: Boolean;

    /// <summary>
    ///  ActionExecuteCheck - предобработчик действия. Набор данных в pAccrualAction
    ///</summary>
    function ActionExecuteCheck(AActionID: integer; AResult:TFormAction): integer;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    /// <summary>
    /// ActionExecute - выполнение действия. Набор данных в pAccrualAction
    /// </summary>
    function ActionExecute(ActionID: integer): Integer;

    /// <summary>
    /// ActionExecuteRollback - откат выполнения действия. Набор данных в pAccrualAction
    /// </summary>
    function ActionExecuteRollback(): Integer;

    property SQL: TSql read GetSQL;

    /// <summary>
    /// Finished - признак завершения операции
    /// </summary>
    property Finished: Boolean read GetFinished write SetFinished;
    /// <summary>
    /// ShowProgress - показывать ход выполнения операции
    /// </summary>
    property ShowProgress: Boolean read GetShowProgress write SetShowProgress;
  end;

TAccrualThread = class(TThread)
protected
  private
    FAccrual : TAccrual;
    FActionID: Integer;
    FLogger: tLogger;
    function GetLogger: tLogger;
    procedure SetLogger(const Value: tLogger);
  protected
    procedure Execute(); override;
  public
    constructor Create(AAccrual: TAccrual; AActionID: Integer);
    // передаем логгер в поток
    property Logger: tLogger read GetLogger write SetLogger;
end;


implementation

uses
  uError_T, uUtils.Varriant, MainModule, uUtils.Logger;

{ TProcExec }

procedure TProcExec.Call(MethodName: string);
var m: TMethod;
begin
  FLogger.Debug('TProcExec.Call Begin %s', ['MethodName']);
  try
     m.Code := Self.MethodAddress(MethodName); //find method code
     m.Data := pointer(Self); //store pointer to object instance
     //Result := TMyFuncType(m)(a, b);
     TMyFuncType(m);
  except
    on E : exception do
    begin
      Emex.SQL.Exec('Update pAccrualAction set retval = 506, Message =:Message where spid = @@spid',
                   ['Message'],[e.Message]);


      FLogger.&Except('TProcExec.Call ' + E.ClassName+' поднята ошибка, с сообщением: '+#13#10+#13#10+E.Message);
    end;
  end;
end;

constructor TProcExec.Create(Value: TFDConnection);
begin
  Emex := TEmex.Create(Value);
end;

destructor TProcExec.Destroy;
begin
  Emex.Destroy;
  inherited;
end;

procedure TProcExec.EmexCreateOrder();
begin
  Emex.CreateOrder;
end;

procedure TProcExec.EmexCreateOrderCheck;
begin
  FLogger.Debug('TProcExec.EmexCreateOrderCheck Begin');

  //Запрашиваем заказы в статусе в Работе
  Emex.MovementInWorkByMarks;

  // Выполняем проверку, результат пишем pAccrualAction.RetVal
  Emex.SQl.Exec('exec EmexCreateOrderCheck', [], []);

  FLogger.Debug('TProcExec.EmexCreateOrderCheck End');
end;

procedure TProcExec.EmexOrderStateSync;
begin
  Emex.SQl.Exec('''
    delete pAccrualAction
      from pAccrualAction (rowlock)
     where spid = @@Spid
  ''');

  Emex.SQl.Exec('''
    insert pAccrualAction with (rowlock)
          (Spid, ObjectID, StateID, Retval)
    Select @@Spid, OrderID, StatusID, 0
      from vOrderStateSyncByOrderNum
  ''');

  Emex.OrderStateSyncByOrderNum;
end;

function TProcExec.GetLogger: tLogger;
begin
  Result:=FLogger;
end;

procedure TProcExec.InsertPartToBasketByPartFromMark; var R: Integer;
begin
  FLogger.Debug('TProcExec.InsertPartToBasketByPartFromMark Begin');

  R := Emex.InsertPartToBasketByMarks;
  FLogger.Debug('TProcExec.InsertPartToBasketByPartFromMark Количество добавленных позиций: ' + R.ToString);

  if R > 0 then
  begin
    Emex.GetBasketDetailsByMarks;

    Emex.SQl.Exec('exec BasketStateSync select 0');

    // Удаление деталей из корзины которые не смогли смапить с заказами на нашей стороне
    Emex.InsertPartToBasketCancelByMarks();
  end;

  FLogger.Debug('TProcExec.InsertPartToBasketByPartFromMark End');
end;

procedure TProcExec.InsertPartToBasketByPartRollBack;
begin
  Emex.InsertPartToBasketRollbackByMarks;
end;

procedure TProcExec.SetLogger(const Value: tLogger);
begin
  if Assigned(Value) then
    FLogger := Value;
end;

{ TAccrual }

function TAccrual.ActionExecute(ActionID: integer): integer;
var t: TAccrualThread;
begin
  log('TAccrual.ActionExecute Begin ', etinfo);
  log('TAccrual.ActionExecute ActionID: ' + ActionID.ToString, etinfo);
  result    := 0;
  FFinished := False;

  FRetVal.Clear;
  FRetVal.Code := ActionExecuteCheck(ActionID, acVerify);

  begin
    if FRetVal.Code = 0 then
    begin
      // Настройка: Автоматический отказ деталей с ошибками при создании заказа
      if sql.GetSetting('AutomaticRejectionPartsByCreatOrder', false)  then
      begin
        log('TAccrual.ActionExecute Автоматический отказ деталей с ошибками при создании заказа: ДА', etinfo);
        Sql.Open('''
          Select 1
            from vOrdersWarningList
           where ActionBrief = 'ToInWork'
        ''', [], []);

        if Sql.Q.RecordCount > 0 then
        begin
          Sql.Q.Close;
          case (MessageDlg('По некоторым позициям имеются замечания, данные детали будут перенесены в состояние "Отказан"', mtConfirmation, mbYesNo))  of
            mrYes:
            begin
                Sql.Exec(' exec ActionObjectCancel ', [], []);
            end;
            mrNo:
            begin
                Exit;
            end;
          end;
        end;
      end
      else
      begin
        log('TAccrual.ActionExecute Автоматический отказ деталей с ошибками при создании заказа: НЕТ', etinfo);
        Sql.Open('''
           Select 1
             from vOrdersWarningList
            where ActionBrief = 'ToInWork'
        ''', [], []);

        if Sql.Q.RecordCount > 0 then
        begin
          Sql.Q.Close;
          case (MessageDlg('Уверены что хотите разместить заказ несмотря на замечания? ' , mtConfirmation, mbYesNo))  of
//            mrYes:
//            begin
//            end;
            mrNo:
            begin
                Exit;
            end;
          end;
        end;
      end;
    end;

    // ВЫПОЛНЕНИЕ ПРОЦЕДУРЫ НАСТРОЕННОЙ НА МОДЕЛИ СОСТОЯНИЯ ПОД ДЕЙСТВИЕМ
    if FRetVal.Code = 0 then
    begin
      t := TAccrualThread.Create(self, ActionID);
      t.logger:= GetCurrentLogData();//UniMainModule.ALogger;
      t.FreeOnTerminate := True; // Экземпляр должен само уничтожиться после выполнения
      t.Start; // непосредственно ручной запуск потока
    end
    else
    begin
      FShowProgress := False;
      FFinished := True;
    end;
  end;
  log('TAccrual.ActionExecute End ', etInfo);
end;

function TAccrual.ActionExecuteCheck(AActionID: integer; AResult: TFormAction): integer;
var
  Query: TFDQuery;
begin
  log('TAccrual.ActionExecuteCheck Begin ', etInfo);

  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := FConnection;

    if AResult = acVerify then
    begin
      Query.Close;
      Query.SQL.Text := ' declare @R  int                  '+
                        ' exec @r = ActionExecuteCheck     '+
                        '             @ActionID = :ActionID'+
                        ' select @r as retcode             ';

      Query.ParamByName('ActionID').AsInteger := AActionID;
      Query.Open;

      Result := Query.FieldByName('retcode').Value;
    end;
    log('TAccrual.ActionExecuteCheck. Result: ' + Result.ToString, etInfo);
  finally
    FreeAndNil(Query);
  end;
  log('TAccrual.ActionExecuteCheck. end ', etInfo);
end;

function TAccrual.ActionExecuteRollback: integer;
var
  Proc: TProcExec;
  ServerErr: Integer;
  Query: TFDQuery;
begin
  log('TAccrual.ActionExecuteRollback Begin ' , etInfo);

  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := FConnection;

    FRetVal.Clear;
    begin
      // Откат протокола
      if FRetVal.Code = 0 then
      begin
        Query.Close;
        Query.SQL.Text := '''
          declare @R int
             exec @r = ProtocolRollBackCheck
          select @r as retcode
        ''';
        Query.Open;
        FRetVal.Code := Query.FieldByName('retcode').Value;
      end;

      // выполнение процедуры настроенной на модели состояния под действием
      if FRetVal.Code = 0 then
      begin
        Sql.Open('''
          Select distinct a.Number, p.ActionID, a.MetodRollback, a.MetodType
            from pAccrualAction p (nolock)
           inner join vActionMetod a
                   on a.ActionID  =p.ActionID
                  and a.MetodType =0
                  and isnull(a.MetodRollback, '') <> ''
           where p.Spid = @@spid
             and p.Retval = 0
           order by a.Number
        ''', [],[]);

        log('Проверка наличия настроенной под действием процедур: ' + (Sql.Q.RecordCount > 0).ToString(True), etInfo);
        if Sql.Q.RecordCount > 0 then
        begin
          log('Процедура: ' + Sql.Q.FieldByName('MetodRollback').AsString, etInfo);

          Proc := TProcExec.Create(FConnection);
          Proc.Logger := GetCurrentLogData();
          if Sql.Q.FieldByName('MetodType').AsInteger = Integer(tInstrumentMetodType.mtProc) then
          begin
            Proc.Call(Sql.Q.FieldByName('MetodRollback').AsString);
          end;
          Proc.Destroy;
        end;
      end;

      // Откат протокола
      if FRetVal.Code = 0 then
      begin
        log('TAccrual.ActionExecuteRollback Откат протокола Begin' , etInfo);
        Query.Close;
        Query.SQL.Text := ' exec ProtocolRollBack ';
        Query.ExecSQL;
        log('TAccrual.ActionExecuteRollback Откат протокола End' , etInfo);
      end;

      // проверка наличия серверных ошибок
      Sql.Open('''
        select 1
          from pAccrualAction p with (nolock)
         where p.Spid = @@spid
           and p.Retval <> 0
      ''', [], []);
      ServerErr := Sql.Q.RecordCount;

      if (FRetVal.Code = 0) and (ServerErr = 0) then
      begin
        //ActionExecuteAfter(acRefresh);
        result:=0;
      end
      else
      begin
        result:=1;
        if ServerErr > 0 then
        begin
          Error_T.ShowModal;
        end
        else
          MessageDlg(FRetVal.Message, mtError, [mbOK]);
      end;
    end;
  finally
    FreeAndNil(Query);
  end;

  log('TAccrual.ActionExecuteRollback End ', etInfo);
end;

constructor TAccrual.Create(AConnection: TFDConnection);
begin
  inherited Create();

  if Assigned(AConnection) then
  begin
    FConnection:=AConnection;

    FRetVal:=TRetVal.Create(FConnection);

    FSQl:=TSQl.Create(FConnection);
  end;
end;

destructor TAccrual.Destroy;
begin
  inherited;

  FreeAndNil(FRetVal);
end;

function TAccrual.GetShowProgress: Boolean;
begin
  Result := FShowProgress;
end;

function TAccrual.GetFinished: Boolean;
begin
  Result := FFinished;
end;

function TAccrual.GetSQl: TSql;
begin
  if not Assigned(FSQl) then
  begin
    FSQl:= TSQl.Create(FConnection);
  end;
  Result := FSQl;
end;

procedure TAccrual.SetShowProgress(const Value: Boolean);
begin
  FShowProgress := Value;
end;

procedure TAccrual.SetFinished(const Value: Boolean);
begin
  FFinished := Value;
end;


{ TAccrualThread }

constructor TAccrualThread.Create(AAccrual: TAccrual; AActionID: Integer);
begin
  inherited Create(True); // поток создаётся приостановленным

  FAccrual := AAccrual;
  FActionID:= AActionID;
end;

procedure TAccrualThread.Execute;
var
  i, j: Integer;
  Proc: TProcExec;
  qActionMetod: TFDQuery;
  qMetod: TFDQuery;
begin
  FLogger.Debug('TAccrualThread.Execute Begin');

  if not Assigned(qMetod) then qMetod := TFDQuery.Create(nil);
  if not Assigned(qActionMetod) then qActionMetod := TFDQuery.Create(nil);

  try
      qMetod.Connection := FAccrual.FConnection;

      qActionMetod.Connection := FAccrual.FConnection;
      qActionMetod.Close;
      qActionMetod.Open('''
        Select distinct ord, ActionID, StateID
          from pAccrualAction with (nolock)
         where spid = @@spid
           and retval = 0
         order by ord
      ''', [], []);
      qActionMetod.First;

      FLogger.Debug('TAccrualThread.Execute ActionMetod Begin');
      for j := 0 to qActionMetod.RecordCount-1 do
      begin

        qMetod.Close;
        qMetod.SQL.Text := '''
          Select distinct Number, ActionID, Metod, MetodType
            from vActionMetod
           where ActionID  =:ActionID
             and StateID   =:StateID
             and MetodType =:MetodType
           order by Number
        ''';

        FLogger.Debug('TAccrualThread.Execute ActionMetod ActionID: ' + qActionMetod.FieldByName('ActionID').AsString);

        qMetod.ParamByName('ActionID').AsInteger:= qActionMetod.FieldByName('ActionID').AsInteger;
        qMetod.ParamByName('StateID').AsInteger := qActionMetod.FieldByName('StateID').AsInteger;
        qMetod.ParamByName('MetodType').AsInteger:= Integer(tInstrumentMetodType.mtProc);
        qMetod.Open;

        FLogger.Debug('TAccrualThread.Проверка наличия настроенной под действием процедур: ' + (qMetod.RecordCount > 0).ToString(True));

        if qMetod.RecordCount > 0 then
        begin
          qMetod.First;
          for I := 0 to qMetod.RecordCount-1 do
          begin
            FLogger.Debug('TAccrualThread.Execute ActionMetod Процедура: ' + qMetod.FieldByName('Metod').AsString);

            Proc := TProcExec.Create(FAccrual.FConnection);
            Proc.Logger := FLogger;
            if qMetod.FieldByName('MetodType').AsInteger = Integer(tInstrumentMetodType.mtProc) then
            begin
              Proc.Call(qMetod.FieldByName('Metod').AsString);
            end;

            Proc.Destroy;
            qMetod.Next;
          end;
        end;

        qActionMetod.Next;
      end;

      // Добавление протокола
      begin
        FLogger.Debug('TAccrualThread.Execute ProtocolAdd Begin');
        qMetod.Close;
        qMetod.SQL.Text := ' exec ProtocolAdd ';
        qMetod.ExecSQL;
        FLogger.Debug('TAccrualThread.Execute ProtocolAdd End');
      end;

  finally
    FAccrual.FFinished := True;

    FreeAndNil(qMetod);
    FreeAndNil(qActionMetod);
    FLogger.Debug('TAccrualThread.Execute End');
  end;
end;

function TAccrualThread.GetLogger: tLogger;
begin
  Result:=FLogger;
end;

procedure TAccrualThread.SetLogger(const Value: tLogger);
begin
  if Assigned(Value) then
    FLogger := Value;
end;

end.
