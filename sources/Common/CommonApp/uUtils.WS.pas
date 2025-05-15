unit uUtils.WS;

interface

uses
  System.SysUtils, System.Generics.Collections, uniGUIJSUtils;

type
  tWS = class
  private
    FEventForm: TDictionary <String, String>;  // Регистрация форм и событий
    FWSAddress: string;

    function ObjMessage(): string;
    function GetRegisterJSON(AObjectType, AObjectID: string): string;

  public
    constructor Create(AObjectType, AObjectID: string);
    destructor Destroy(); override;

    procedure Send(Args: string);
    /// <summary>
    ///  FormRegister - регистрация формы для приема сообщений от websocket сервера
    /// </summary>
    procedure FormRegister(JSFormName, EventName: string);
    procedure FormUnRegister(JSFormName: string);

    procedure CheckOnline(AObjectType, AObjectID: string);
  end;

implementation

uses
  uniGUIApplication, uMainVar, uUtils.Logger;

{ tWS }

constructor tWS.Create(AObjectType, AObjectID: string);
begin
  if not Assigned(FEventForm) then
    FEventForm := TDictionary<string, string>.Create();

  FWSAddress := Sql.GetSetting('WebSocketAddress');

  if FWSAddress <> '' then
  begin
    UniSession.AddJS(
    format(
    '''
      var WebSockets;

      if (!WebSockets) {
        var url = '%s';
        console.log(url);
        if (url) {
          WebSockets = new WebSocket(url);
        }
      }

      // Обработчик при открытии соединения
      WebSockets.onopen = function(event) {
        console.log("Connection opened!");
        console.log(event);

        var str = JSON.stringify(%s);
        console.log(str);
        WebSockets.send(str);
      };

      // Обработчик получения сообщений
      WebSockets.onmessage = function(event) {
        console.log("Message received: " + event.data);
      };

      // Обработчик ошибок WebSocket
      WebSockets.onerror = function(error) {
        console.error("WebSocket Error: ");
        console.error(error);
      };

      // Обработчик закрытия соединения
      WebSockets.onclose = function(event) {
        console.log("Connection closed!");
        console.log(event);
      };

      // Экспортируем WebSockets в глобальный объект window
      window.WebSockets = WebSockets;

    '''
    , [FWSAddress, GetRegisterJSON(AObjectType, AObjectID)])
    );
  end;
end;

destructor tWS.Destroy();
begin
  // Сообщаем серверу об отключении и закрываем WebSocket соединение
  UniSession.AddJS(
  StringReplace(
  '''
    if (window.WebSockets) {
      // Отправляем сообщение серверу о том, что клиент отключается
      //window.WebSockets.send('SendText:disconnecting');
      window.WebSockets.close();
      console.log('WebSocket connection closed by client.');
    }
  '''
  , '', '', [])
  );

  FEventForm.Free;

  inherited; // обязательно вызывать базовый Destroy
end;

function tWS.GetRegisterJSON(AObjectType, AObjectID: string): string;
begin
  Result := Format('{"type": "%s", "id": "%s"}', [AObjectType, AObjectID]);
end;

function tWS.ObjMessage: string;
var
  str, Key: string;
begin
  for Key in FEventForm.Keys do
  begin
    Log(Key, etInfo);
    Log(FEventForm.Items[Key], etInfo);

    if FEventForm.Items[Key] = 'online_status' then
    begin
      str := ' var messageData = JSON.parse(event.data);' +
             ' var type = messageData.type;' +
             ' if (["online_status", "connection", "disconnection"].includes(type)) {' +
             '   ajaxRequest(' + Key + ' , "' + FEventForm.Items[Key] + '", ["message=" + event.data]);'+
             ' }; '
    end
    else
    begin
      str := str + ' ajaxRequest(' + Key + ' , "' + FEventForm.Items[Key] + '", ["message=" + event.data]); ';
    end
  end;

  Result := str;
end;

procedure tWS.FormRegister(JSFormName, EventName: string);
begin
  if FWSAddress <> '' then
  begin
    FEventForm.Add(JSFormName, EventName);

    UniSession.AddJS(
    StringReplace(
    '''
      if (window.WebSockets) {
        WebSockets.onmessage = function(event) {
          console.log('WebSockets.onmessage');
          console.log(event);
    '''
    +
          ObjMessage
    +
    '''
        };
      };
    '''
    , '', '',[])
    );
    //{
    //  "action": "subscribe",
    //  "events": ["online_status", "message"]
    //}
    Send((' {"action": "subscribe", "events": ["online_status"] }'));
  end;
end;

procedure tWS.FormUnRegister(JSFormName: string);
var
  EventName: string;
begin
  if FWSAddress <> '' then
  begin
    // Перебираем все ключи и значения в FEventForm
    for EventName in FEventForm.Values do
    begin
      // Отправляем запрос на отписку от каждого события
      Send(Format('{"action": "unsubscribe", "events": ["%s"]}', [EventName]));
    end;

    // Удаляем все подписки для данной формы
    FEventForm.Remove(JSFormName);
  end;
end;

procedure tWS.Send(Args: string);
begin
  if FWSAddress <> '' then
  begin
    UniSession.AddJS(
      'if (window.WebSockets) {' +
      '  if (window.WebSockets && window.WebSockets.readyState === WebSocket.OPEN) {' +
      '    window.WebSockets.send(''' + Args + ''');' +
      '  } else {' +
      '    console.log("WebSockets is not open!");' +
      '  }'+
      '};'
    );
  end;
end;

procedure tWS.CheckOnline(AObjectType, AObjectID: string);
var
  Msg: string;
begin
  Msg := Format('{"action": "check_online", "type": "%s", "id": "%s"}', [AObjectType, AObjectID]);
  Send(Msg);
end;

end.

