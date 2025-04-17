unit uUtils.WS;

interface

uses System.SysUtils, System.Generics.Collections, uniGUIJSUtils;

type

/// <summary>
/// tWS - класс для работы с WebSocket
/// </summary>
tWS = class
private
  FEventForm: TDictionary <String, String>;

  FWSAddress: string;

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
  uniGUIApplication, uMainVar;

{ tMessenger }

constructor tWS.Create(const Args: string);
// Args
// manager:56
begin

  if not Assigned(FEventForm) then
    FEventForm := TDictionary <string, string>.Create();

  FWSAddress := Sql.GetSetting('WebSocketAddress');

  if FWSAddress <> '' then
  begin
    UniSession.AddJS(
    format(
    '''
      var WebSockets;

      if (!WebSockets) {
        var url = '%s';
        if (url) {
          WebSockets = new WebSocket(url);
        }
      }

      // Обработчик при открытии соединения
      WebSockets.onopen = function(event) {
        //manager:56
        console.log("Connection opened!");

        WebSockets.send('%s');
      };

      // Обработчик получения сообщений
      WebSockets.onmessage = function(event) {
        console.log("Message received: " + event.data);
      };

      // Обработчик ошибок WebSocket
      WebSockets.onerror = function(error) {
        console.log("WebSocket Error: ");
        console.error(error);
      };

      // Обработчик закрытия соединения
      WebSockets.onclose = function(event) {
        console.log("Connection closed!");
      };

      // Экспортируем WebSockets в глобальный объект window
      window.WebSockets = WebSockets;

    '''
    , [FWSAddress, Args])
    );
  end;
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
  if FWSAddress <> '' then
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
end;

procedure tWS.FormUnRegister(JSFormName: string);
begin
  if FWSAddress <> '' then
  begin
    FEventForm.Remove(JSFormName);

    UniSession.AddJS(
    '''
      if (WebSockets) {
        //  получения сообщений
        WebSockets.onmessage = function(event) {
          console.log("Message received: " + event.data);
     '''
     +  ObjMessage +
     '''
        };
      };

    ''');
  end;
end;

function tWS.ObjMessage: string;
var str: string; Key:string;
begin
  for Key in FEventForm.Keys  do
  begin
    str:= str + 'ajaxRequest(' + Key + ' , "' + FEventForm.Items[Key]  + '", ["message=" + event.data]);';
  end;

  Result := str;
end;

procedure tWS.Send(Args: string);
var  xMsg, S : string;
begin
  if FWSAddress <> '' then
  begin
    UniSession.AddJS(


      'if (WebSockets) {' +
      '  if (WebSockets && WebSockets.readyState === WebSocket.OPEN) {' +
      '    WebSockets.send("' + Args + '");' +
      '  } else {' +
      '    console.log("WebSockets is not open !");' +
      '  }'+
      '};'
    );
  end;

end;

end.
