(* *****************************************************************************


Copyright (C) 2018 Company
***************************************************************************** *)

unit  uCommonType;

interface

uses System.SysUtils, System.UITypes, System.Rtti,
     FireDAC.Comp.Client, FireDAC.Comp.Script;

Type
  /// <summary> Типы действий </summary>
  TFormAction = (
   acNone          = 0
   /// <summary> acInsert - добавление </summary>
  ,acInsert        = 1
  /// <summary> acUpdate - изменение </summary>
  ,acUpdate        = 2
  /// <summary> acDelete - Удаление </summary>
  ,acDelete        = 3
  /// <summary> acShow - удаление </summary>
  ,acShow          = 4
  /// <summary> acCancel - отмена </summary>
  ,acCancel        = 5   // отмена
  /// <summary> acLookup - выбрать </summary>
  ,acLookup        = 6
  ,acChecking      = 7
  ,acCheckKey      = 8
  ,acChildInsert   = 9
  ,acVerify        = 10
  ,acHistory       = 11
  ,acTemplate      = 12  // используется для технических нужд
  ,acReset         = 13
  ,acParentShow    = 14
  ,acChildDelete   = 15
  ,acReportCreate  = 16
  ,acReportEdit    = 17
  ,acSelect        = 18
  ,acHolding       = 19  // проведен, редактирование запрещено
  ,acUserAction    = 20
  ,acLogin         = 21
  ,acExit          = 22
  /// <summary> asRefresh - Обновление </summary>
  ,acRefresh       = 23
  /// <summary> acMessage - Сообщение </summary>
  ,acMessage       = 24
  ,acOn            = 25
  ,acOff           = 26
  ,acRollback      = 27 // Откат действия
  ,acCancelRequest = 28 // Запрос отмены
  );

   /// <summary> Типы объектов системы </summary>
  TObjectType = (
   //otAuthorization  = 1        // авторизация пользователя
   otUser           = 2          // пользователи
  ,otSearchAppUser  = 8          // Интерфейс: Клиенты search
  ,otTask           = 11         // Автоматические задания

  );

  /// <summary> Типы для справочников </summary>
  THandHookType = (
   htNone           = 0
  ,htSystemic       = 1          //системный
  ,htNotWork        = 2          //не действует
  );

  TExceptionInform = (
    erInformation
   ,erNotInformation
  );

  tInstrumentFlag = (
    isStartState   = 1           //начальное состояние
  );

  /// <summary> tInstrumentType - тип элемента инструментов/моделей
  ///     StateModels   = 1  //Модель состояния
  ///     Settings      = 2  //Настройки
  ///     StateGroups   = 3  //Группа
  ///     SettingGroups = 4  //Группа
  ///     StateModel    = 5  //Модель состояния
  ///     State         = 6  //Состояние
  ///     Action        = 7  //Действие  </summary>
  tInstrumentType = (
   StateModels   = 1  //Модель состояния
  ,Settings      = 2  //Настройки
  ,StateGroups   = 3  //Группа
  ,SettingGroups = 4  //Группа
  ,StateModel    = 5  //Модель состояния
  ,State         = 6  //Состояние
  ,Action        = 7  //Действие
  );

  /// <summary> tInstrumentMetodType - типы </summary>
  tInstrumentMetodType = (
   mtProc   = 0  //Процедура
  );

  /// <summary> TaskType - типы автоматических заданий </summary>
  tTaskType = (
   ttProc        = 0  // Процедура
  ,ttBat         = 1  // Bat файл
  ,ttSQL         = 2  // Скрипт SQL
  );

  /// <summary> Типы периодов автоматических заданий  </summary>
  tTaskPeriod = (
  /// <summary>  =  0 - Только один раз</summary>
  /// <summary>  =  1 - Выбрать </summary>
   tpSelect      = 1
  /// <summary> tpDaily = 2 - Ежедневно </summary>
  ,tpDaily       = 2
  /// <summary>  = 3 - Еженедельно </summary>
  /// <summary>  = 4 - Ежемесячно </summary>
  /// <summary>  = 5 - Ежегодно </summary>
  );


  /// <summary> tGridLayout - </summary>
  tGridLayout = (
   glSave = 0
  ,glLoad = 1
  );


  /// <summary> tAuditFlag - </summary>
  tAuditFlag = (
   agInfo = 0
   /// <remarks>Ошибка</remarks>
  ,agError = 1
  );

  /// <summary> Тип для обработки ошибок </summary>
  TRetVal = class
  private
    var FCode: Integer;
    var FMessage: string;          // сообщение
    var FID     : Integer;         // для тех нужд

    var FErrType: TMsgDlgType;     // тип ошибки
    var FConnection: TFDConnection;

    function GetCode: Integer;     // код ошибки
    function GetID: Integer;
    procedure SetCode(const Value: Integer);

    /// <summary>
    /// GetMessage - установка текстового значения ошибки по его коду в переменной RetCode
    /// </summary>
    /// <returns>Текст ошибки возвращается в переменную RetMsg; Type: string</returns>
    function GetMessage():string;
    procedure SetMessage(const Value: string);
  public

    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    /// <summary>Code - код ошибки</summary>
    property Code: Integer     read GetCode write SetCode;
    /// <summary>Message - текст ошибки</summary>
    property Message: string   read GetMessage write SetMessage ;
    /// <summary>ID - идентификатор, используется для тех. нужд</summary>
    property ID: Integer       read GetID      write FID      ;
    /// <summary>ErrType - тип ошибки: mtWarning, mtError, mtInformation, mtConfirmation, mtCustom</summary>
    property ErrType: TMsgDlgType read FErrType write FErrType ;
     /// <summary> Clear - очистка текущих значений</summary>
    function Clear:TRetVal;
  end;


  /// <summary>
  /// TMultiProp.Objects - Установка свойства для нескольких объектов.
  /// </summary>
  /// <example>
  /// <code>
  /// TMultiProp.Objects([Self.clLegDialogButton, Self.OKButton,  Self.CancelButton])['Enabled']:=True;
  /// </code>
  /// </example>
  TMultiProp = record
  strict private
    class var FData : array of TObject;
  public
    type
      TObjectProperty = record
        strict private
          procedure setValue(propName : string; value : TValue);
          function GetValue(propName : string) : TValue;
        public
          property Properties[propName :string ] :TValue read GetValue write setValue;  default;
      end;

    class function Objects(objects : array of TObject) : TObjectProperty; static;
  end;

implementation

{ TRetVal }

function TRetVal.Clear: TRetVal;
begin
  FCode    := 0;
  FMessage := '';
  FID      := 0;
end;

constructor TRetVal.Create(AConnection: TFDConnection);
begin
  inherited Create();

  if Assigned(AConnection) then
    FConnection:=AConnection;
end;

destructor TRetVal.Destroy;
begin
  inherited;
end;

function TRetVal.GetCode: Integer;
begin
  Result := FCode;
end;

function TRetVal.GetID: Integer;
begin
  Result := FID;
end;

function TRetVal.GetMessage:string;
var
  Qry: TFDQuery;
Begin
  if (FCode <> 0) and (FMessage = '') then
  begin
    try
      Qry := TFDQuery.Create(nil);
      Qry.Connection := FConnection;

      Qry.SQL.Text := 'select dbo.GetRetMsg(:RetCode)';
      Qry.ParamByName('RetCode').Value := FCode;
      Qry.Open;

      if not Qry.IsEmpty then
        FMessage := '[' + FCode.ToString + '] ' + Qry.Fields.Fields[0].AsString
      else
        FMessage := '';
    finally
      FreeAndNil(Qry);
    end
  end;

  result:= FMessage;
end;

procedure TRetVal.SetCode(const Value: Integer);
begin
  Clear;
  FCode := Value;
end;

//procedure TRetVal.SetConnection(const Value: TFDConnection);
//begin
//  if Assigned(Value) then
//    FConnection := Value;
//end;

procedure TRetVal.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

{TMultiProp}

class function TMultiProp.Objects(objects: array of TObject): TObjectProperty;
var i : integer;
Begin
  setLength(FData, length(objects));
  for i := 0 to high(objects) do
    FData[i] := objects[i];
end;

procedure TMultiProp.TObjectProperty.setValue(propName: string; value: TValue);
var ctx : TRttiContext;
      t : TRttiType;
      p : TRttiProperty;
    obj : TObject;
Begin
  ctx := TRttiContext.Create();
  propName := LowerCase(propName);
  try
    for obj in FData do
    Begin
      t := ctx.GetType(obj.ClassType);
      if t = nil then continue;
      for p in t.GetProperties() do
      Begin
        if LowerCase(p.Name) <> propName then continue;
        p.SetValue(obj, value);
      end;
    end;
  finally
    ctx.Free();
    FData := nil;
  end;
end;

function TMultiProp.TObjectProperty.GetValue(propName: string): TValue;
var ctx : TRttiContext;
      t : TRttiType;
      p : TRttiProperty;
    obj : TObject;
Begin
  ctx := TRttiContext.Create();
  propName := LowerCase(propName);
  try
    for obj in FData do
    Begin
      t := ctx.GetType(obj.ClassType);
      if t = nil then continue;
      for p in t.GetProperties() do
      Begin
        if LowerCase(p.Name) <> propName then continue;
        Result := p.GetValue(obj);
        Break;
      end;
    end;
  finally
    ctx.Free();
    FData := nil;
  end;

end;

end.




