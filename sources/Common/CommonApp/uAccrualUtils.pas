unit uAccrualUtils;

 {                            Оработка действий                                }

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics,
      Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
      uniGUIClasses, uniGUIFrame, uniMemo, uniButton, uniGUIBaseClasses, uniPanel,
      uniGUIDialogs,

      FireDAC.Comp.Client, FireDAC.Comp.Script,

      uCommonType, uSqlUtils, uEmexUtils;

type
  TMyFuncType = function(): integer of object;
  TProcExec = class
  private
    Emex:TEmex;
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
  end;


/// <summary>
///  TAccrual - класс для выполнения действий
///</summary>
TAccrual = class
  private
    var FConnection: TFDConnection;
    var FSQl: TSql;
    var FRetVal: tRetVal;  //RetVal := tRetVal.Create;

    function GetSQL: TSql;
    procedure SetSQL(const Value: TSql);

    /// <summary>
    ///  ActionExecuteBefore - предобработчик действия. Набор данных в pAccrualAction
    ///</summary>
    function ActionExecuteBefore(AActionID: integer; AResult:TFormAction): integer;

    /// <summary>
    ///  ActionExecuteAfter - постобработчик действия. Набор данных в pAccrualAction
    ///</summary>
    procedure ActionExecuteAfter(AResult:TFormAction);
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

    property SQL: TSql read GetSQL write SetSQL;
  end;


implementation

uses
  uLogger, uError_T, uVarUtils;

{ TProcExec }

procedure TProcExec.Call(MethodName: string);
var m: TMethod;
begin
  m.Code := Self.MethodAddress(MethodName); //find method code
  m.Data := pointer(Self); //store pointer to object instance
  //Result := TMyFuncType(m)(a, b);
  TMyFuncType(m);
end;

constructor TProcExec.Create(Value: TFDConnection);
begin
  Emex := TEmex.Create;
  Emex.Connection := Value;
end;

destructor TProcExec.Destroy;
begin
  //Emex.Free;
  Emex.Destroy;
  //FreeAndNil(Emex);
  inherited;
end;

procedure TProcExec.EmexCreateOrder();
begin
  Emex.CreateOrder;
end;

procedure TProcExec.EmexCreateOrderCheck;
begin
  //Запрашиваем заказы в статусе в Работе
  Emex.MovementInWork;

  // Выполняем проверку, результат пишем pAccrualAction.RetVal
  Emex.SQl.Exec('exec EmexCreateOrderCheck', [], []);
end;

procedure TProcExec.EmexOrderStateSync;
begin
  Emex.Connection.ExecSQL(
                    ' delete pAccrualAction from pAccrualAction where spid = @@Spid');

  Emex.Connection.ExecSQL(
                    ' insert pAccrualAction (Spid, ObjectID, StateID, Retval) ' +
                    ' Select @@Spid, OrderID, StatusID, 0        '+
                    '   from vOrderStateSyncByOrderNum  ');

  Emex.OrderStateSyncByOrderNum;
end;

procedure TProcExec.InsertPartToBasketByPartFromMark;
var R: Integer;
begin
  logger.Info('Integer.InsertPartToBasketByPartFromMark Begin ');
  R := Emex.InsertPartToBasketByPart;
  logger.Info('Integer.InsertPartToBasketByPartFromMark Количество добавленных позиций: ' + R.ToString);

  if R > 0 then
  begin
    logger.Info('Integer.InsertPartToBasketByPartFromMark GetBasketDetails Begin ');
    Emex.GetBasketDetails;
    logger.Info('Integer.InsertPartToBasketByPartFromMark GetBasketDetails End ');

    logger.Info('Integer.InsertPartToBasketByPartFromMark BasketStateSync Begin ');
    Emex.Qry.ExecSQL('exec BasketStateSync select 0', [],[]);
    logger.Info('Integer.InsertPartToBasketByPartFromMark BasketStateSync End ');

    // Удаление деталей из корзины которые не смогли смапить с заказами на нашей стороне
    logger.Info('Integer.InsertPartToBasketByPartFromMark InsertPartToBasketCancel Begin ');
    Emex.InsertPartToBasketCancel();
    logger.Info('Integer.InsertPartToBasketByPartFromMark InsertPartToBasketCancel End ');
  end;
  logger.Info('Integer.InsertPartToBasketByPartFromMark End ');
end;

procedure TProcExec.InsertPartToBasketByPartRollBack;
begin
  Emex.InsertPartToBasketByPartDelete;
end;


{ TAccrual }

function TAccrual.ActionExecute(ActionID: integer): integer;
var
  i, j: Integer;
 // MessageResult: Integer;
  Proc: TProcExec;
  qActionMetod: TFDQuery;
  qMetod: TFDQuery;
begin
  logger.Info('TAccrual.ActionExecute Begin ');
  logger.Info('TAccrual.ActionExecute ActionID: ' + ActionID.ToString);
  result:= 0;

  FRetVal.Clear;
  FRetVal.Code := ActionExecuteBefore(ActionID, acVerify);

  begin

    if FRetVal.Code = 0 then
    begin
      // Настройка: Автоматический отказ деталей с ошибками при создании заказа
      if sql.GetSetting('AutomaticRejectionPartsByCreatOrder', false)  then
      begin
        logger.Info('TAccrual.ActionExecute Автоматический отказ деталей с ошибками при создании заказа: ДА');
        Sql.Open('Select 1 from vOrdersWarningList where ActionBrief = ''ToInWork'' ', [], []);
        if Sql.Q.RecordCount > 0 then
        begin
          Sql.Q.Close;
          case (MessageDlg('По некоторым позициям имеются замечания, данные детали будут перенесены в состояние "Отказан" ' , mtConfirmation, mbYesNo))  of
            mrYes:
            begin
              Sql.Exec('exec ActionObjectCancel ', [], []);
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
        logger.Info('TAccrual.ActionExecute Автоматический отказ деталей с ошибками при создании заказа: НЕТ');
        Sql.Open('Select 1 from vOrdersWarningList where ActionBrief = ''ToInWork'' ', [], []);
        if Sql.Q.RecordCount > 0 then
        begin
          Sql.Q.Close;
          case (MessageDlg('Уверены что хотите разместить заказ несмотря на замечания? ' , mtConfirmation, mbYesNo))  of
//            mrYes:
//            begin
//
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

      if not Assigned(qMetod) then qMetod := TFDQuery.Create(nil);
      if not Assigned(qActionMetod) then qActionMetod := TFDQuery.Create(nil);
      try
          qMetod.Connection := FConnection;

       // try
          qActionMetod.Connection := FConnection;
          qActionMetod.Close;
          qActionMetod.Open('Select distinct ord, ActionID, StateID from pAccrualAction (nolock) where spid = @@spid and retval = 0 order by ord', [], []);
          qActionMetod.First;

          logger.Info('TAccrual.ActionExecute ActionMetod Begin');
          for j := 0 to qActionMetod.RecordCount-1 do
          begin

            qMetod.Close;
            qMetod.SQL.Text :=
                      'Select distinct Number, ActionID, Metod, MetodType '+
                      '  from vActionMetod '+
                      ' where ActionID  =:ActionID '+
                      '   and StateID   =:StateID '+
                      '   and MetodType =:MetodType '+
                      ' order by Number';

            logger.Info('TAccrual.ActionExecute ActionMetod ActionID: ' + qActionMetod.FieldByName('ActionID').AsString);
            qMetod.ParamByName('ActionID').Value:= qActionMetod.FieldByName('ActionID').AsInteger;
            qMetod.ParamByName('StateID').Value := qActionMetod.FieldByName('StateID').AsInteger;
            qMetod.ParamByName('MetodType').Value:= Integer(tInstrumentMetodType.mtProc);
            qMetod.Open;

            logger.Info('TAccrual.Проверка наличия настроенной под действием процедур: ' + (qMetod.RecordCount > 0).ToString());

            if qMetod.RecordCount > 0 then
            begin
              qMetod.First;
              for I := 0 to qMetod.RecordCount-1 do
              begin
                logger.Info('TAccrual.ActionExecute ActionMetod Процедура: ' + qMetod.FieldByName('Metod').AsString);

                Proc := TProcExec.Create(FConnection);

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
      //  finally
        //  FreeAndNil(qActionMetod);
          logger.Info('TAccrual.ActionExecute ActionMetod End');
       // end;

        // Добавление протокола
        if FRetVal.Code = 0 then
        begin
          logger.Info('TAccrual.ProtocolAdd Begin');
          qMetod.Close;
          qMetod.SQL.Text := ' exec ProtocolAdd  ';
          qMetod.ExecSQL;
          logger.Info('TAccrual.ActionExecute ProtocolAdd End');
        end;

      finally
        FreeAndNil(qMetod);
        FreeAndNil(qActionMetod);
        //logger.Info('qMetod End');
      end;
    end;

    // ОБРАБОТКА ОШИБОК
    // проверка наличия серверных ошибок
    Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
    var ServerErr:integer;
    ServerErr := Sql.Q.RecordCount;

    if (FRetVal.Code = 0) and (ServerErr = 0) then
    begin
      ActionExecuteAfter(acRefresh);
      result:= 0;
    end
    else
    begin
      logger.Info('TAccrual.ActionExecute RetVal: ' + FRetVal.Code.ToString);
      logger.Info('TAccrual.ActionExecute Message: ' + FRetVal.Message);
      if ServerErr > 0 then
      begin
        Error_T.ShowModal;
      end
      else
        MessageDlg(FRetVal.Message, mtError, [mbOK]);

      result:= 1;
    end;
  end;
  logger.Info('TAccrual.ActionExecute End ');
end;

procedure TAccrual.ActionExecuteAfter(AResult: TFormAction);
begin
  logger.Info('TAccrual.ActionExecuteAfter Begin');

  logger.Info('TAccrual.ActionExecuteAfter End');
end;

function TAccrual.ActionExecuteBefore(AActionID: integer; AResult: TFormAction): integer;
var Query: TFDQuery;
begin
  logger.Info('TAccrual.ActionExecuteBefore. Begin ');
  if not Assigned(Query) then Query := TFDQuery.Create(nil);
  Try
    Query.Connection := FConnection;

    if AResult = acVerify then
    begin
      Query.Close;
      Query.SQL.Text := ' declare @R  int                    '+
                        ' exec @r = ActionExecuteCheck       '+
                        '             @ActionID   = :ActionID'+
                        ' select @r as retcode               ';

      Query.ParamByName('ActionID').Value := AActionID;
      Query.Open;

      Result := Query.FieldByName('retcode').Value;
    end;
    logger.Info('TAccrual.ActionExecuteBefore. Result: ' + Result.ToString);
  finally
    FreeAndNil(Query);
  end;
  logger.Info('TAccrual.ActionExecuteBefore. end ');
end;

function TAccrual.ActionExecuteRollback: integer;
var
  Proc: TProcExec;
  ServerErr: Integer;
  Query: TFDQuery;
begin
  logger.Info('TAccrual.ActionExecuteRollback Begin ' );

  Query := TFDQuery.Create(nil);
  Try
    Query.Connection := FConnection;
    result:=0;
    FRetVal.Clear;
    begin
      // Откат протокола
      if FRetVal.Code = 0 then
      begin
        Query.Close;
        Query.SQL.Text := ' declare @R            int        '+
                          ' exec @r = ProtocolRollBackCheck  '+
                          ' select @r          as retcode    ';
        Query.Open;
        FRetVal.Code := Query.FieldByName('retcode').Value;
      end;

       // выполнение процедуры настроенной на модели состояния под действием
      if FRetVal.Code = 0 then
      begin
        Sql.Open('Select distinct a.Number, p.ActionID, a.MetodRollback, a.MetodType '+
                  '  from pAccrualAction p (nolock)    '+
                  ' inner join vActionMetod a          '+
                  '         on a.ActionID  =p.ActionID '+
                  '        and a.MetodType =0                   '+
                  '        and isnull(a.MetodRollback, '''') <> '''' '+
                  ' where p.Spid = @@spid '+
                  '   and p.Retval = 0    '+
                  ' order by a.Number     ',
                 [],[]);

        logger.Info('Проверка наличия настроенной под действием процедур: ' + (Sql.Q.RecordCount > 0).ToString(True));
        if Sql.Q.RecordCount > 0 then
        begin
          logger.Info('Процедура: ' + Sql.Q.FieldByName('MetodRollback').AsString);

          Proc := TProcExec.Create(FConnection);
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
        Query.Close;
        Query.SQL.Text := ' exec ProtocolRollBack ';
        Query.ExecSQL;
      end;

      // проверка наличия серверных ошибок
      Sql.Open('select 1 from pAccrualAction p (nolock) where p.Spid = @@spid and p.Retval <> 0', [], []);
      ServerErr := Sql.Q.RecordCount;

      if (FRetVal.Code = 0) and (ServerErr = 0) then
      begin
        ActionExecuteAfter(acRefresh);
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

  logger.Info('TAccrual.ActionExecuteRollback End ');
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
  FreeAndNil(FConnection);
  FreeAndNil(FRetVal);
  inherited;
end;

function TAccrual.GetSQl: TSql;
begin
  if not Assigned(FSQl) then
  begin
    FSQl:= TSQl.Create(FConnection);
  end;
  Result := FSQl;
end;

procedure TAccrual.SetSQL(const Value: TSql);
begin

end;

end.
