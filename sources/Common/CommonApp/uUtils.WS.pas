unit uUtils.WS;

interface

uses System.SysUtils, System.Generics.Collections, uniGUIJSUtils; //uniStrUtils

type

/// <summary>
/// tWS - класс для работы с WebSocket
/// </summary>
tWS = class
private
  FEventForm: TDictionary <String, String>;

  function ObjMessage(): string;

protected

public
  /// <summary>
  /// Create - Создание WebSocket соединения
  /// </summary>
  constructor Create(const Args: string);     //socket.send('client:123');

  /// <summary>
  /// Destroy - Закрываем WebSocket соединение клиента
  /// </summary>
  destructor Destroy(const Args: string);

  procedure Send(Args: string);

  procedure FormRegister(JSFormName, EventName: string);
  procedure FormUnRegister(JSFormName: string);

published


end;


implementation

uses
  uniGUIApplication, uLogger;

{ tMessenger }

constructor tWS.Create(const Args: string);
begin

  if not Assigned(FEventForm) then
    FEventForm := TDictionary <string, string>.Create();

  UniSession.AddJS(
  StringReplace(
  '''

    var WebSockets;
    if (!WebSockets) {
      WebSockets = new WebSocket("ws://localhost:8765");
    }

    // Обработчик при открытии соединения
    WebSockets.onopen = function(event) {
      console.log("Connection opened!");

      WebSockets.send('SendText');
    };

    // Обработчик получения сообщений
    WebSockets.onmessage = function(event) {
      console.log("Create");
      console.log("Message received: " + event.data);
    };

    // Обработчик ошибок WebSocket
    WebSockets.onerror = function(error) {
      console.log("WebSocket Error: " + error);
    };

    // Обработчик закрытия соединения
    WebSockets.onclose = function(event) {
      console.log("Connection closed!");
    };

    // Экспортируем WebSockets в глобальный объект window
    window.WebSockets = WebSockets;

  '''
  , 'SendText', Args, [])
  );
end;

destructor tWS.Destroy(const Args: string);
begin
  // Сообщаем серверу об отключении, а затем закрываем WebSocket соединение
  UniSession.AddJS(
  StringReplace(
  '''
    if (window.WebSockets) {
      // Отправляем сообщение серверу о том, что клиент отключается
      window.WebSockets.send('SendText:disconnecting');

      // Закрываем WebSocket соединение
      window.WebSockets.close();
      console.log('WebSocket connection closed by client.');
    }
  '''
  , 'SendText', Args, [])
  );

  FEventForm.Free;
end;

procedure tWS.FormRegister(JSFormName, EventName: string);
begin
  FEventForm.Add(JSFormName, EventName);

  UniSession.AddJS(
  '''
    if (WebSockets) {

      //  получения сообщений
      WebSockets.onmessage = function(event) {
       console.log("FormRegister");
       console.log("Message received: " + event.data);

   '''
   +  ObjMessage +
   '''
      };
    };

  ''' );
end;

procedure tWS.FormUnRegister(JSFormName: string);
begin
  FEventForm.Remove(JSFormName);

  UniSession.AddJS(
  '''
    if (WebSockets) {

      //  получения сообщений
      WebSockets.onmessage = function(event) {
        console.log("FormUnRegister");

        console.log("Message received: " + event.data);

   '''
   +  ObjMessage +
   '''
      };
    };

  ''');
end;

function tWS.ObjMessage: string;
var str: string; Key:string;
begin
    for Key in FEventForm.Keys  do
    begin

        str:= str + 'ajaxRequest(' + Key + ' , "' + FEventForm.Items[Key]  + '", ["message=" + event.data]);';


        logger.Info(str);
    end;

    Result := str;
end;

procedure tWS.Send(Args: string);
var  xMsg, S : string;
begin
 // AppendJsonPair(Args, xMsg, True);

 // logger.Info(stringreplace(xMsg, '"', '''', [rfReplaceAll]));

 // xMsg := '{' + stringreplace(xMsg, '"', '''', [rfReplaceAll]) + '}';

  UniSession.AddJS(
    'if (WebSockets && WebSockets.readyState === WebSocket.OPEN) {' +
    '  WebSockets.send("' + Args + '");' +
    '} else {' +
    '  console.log("WebSockets is not open !");' +
    '};'
  );

end;

end.
