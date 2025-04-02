unit uMessengerMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniButton, uniMemo, uniBitBtn, uniSpeedButton,
  uniMultiItem, uniListBox, uniLabel, uniPanel, uniGUIBaseClasses, uSqlUtils,
  uniHTMLMemo, UniFSPopup, uniGUIApplication, uniStrUtils, System.JSON,
  uniThreadTimer, uniTimer, uUniMemoHelper;

type
  TMessage = class(TUniFrame)
    ContentChatContainer: TUniContainerPanel;
    ChatContent: TUniContainerPanel;
    ChatMessages: TUniContainerPanel;
    pnlChatHeaderLeft: TUniPanel;
    pnlChatHheaderInfo: TUniContainerPanel;
    pnlChatHeaderTitle: TUniContainerPanel;
    pnlChatHeaderTitleContainer: TUniContainerPanel;
    lblChatTitleText: TUniLabel;
    lblChatHeaderUserStatus: TUniLabel;
    MessageEditor: TUniListBox;
    ChatMessagesSend: TUniContainerPanel;
    pnlSendPanelContainer: TUniContainerPanel;
    pnlSendMessage: TUniContainerPanel;
    pnlTextAreaContent: TUniContainerPanel;
    pnlTextAreaLeft: TUniContainerPanel;
    pnlUploadContainer: TUniContainerPanel;
    btnFileUpload: TUniSpeedButton;
    MessageText: TUniMemo;
    pnlSendButton: TUniContainerPanel;
    btnSend: TUniSpeedButton;
    pnlChatHeaderRight: TUniContainerPanel;
    btnRefresch: TUniSpeedButton;
    UniSpeedButton1: TUniSpeedButton;
    UserStatusTimer: TUniTimer;
    ChatHeader: TUniContainerPanel;
    procedure UniFrameReady(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure MessageTextChange(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure ContentChatContainerAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UserStatusTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FChatID :Integer;
    FOrderID: Integer;
    FClientID: Integer;

    FAppType: Integer;

    FMessageItem: string;

    FFlag: Integer;

    procedure SetOrderID(const Value: Integer);

    /// <summary>
    /// MessageIsRead - Установка признака прочитано на сообщении в базе данных
    /// </summary>
    /// <param name="MessageID">ИД Сообщения</param>
    procedure MessageIsRead(MessageID: integer);


    /// <summary>
    /// BtnSendEnabled - Управление доступностю кнопки "Отправить"
    /// </summary>
    procedure BtnSendEnabled();


    /// <summary>
    /// SetUserStatus - Статус пользователя/клиента
    /// </summary>
    procedure SetUserStatus(AEvent: string; ClientID: integer; Status: string='');
    procedure SetChatID(const Value: Integer);
  public
    { Public declarations }

    /// <summary>
    /// ClientInfo - Получение информации о клиенте
    /// </summary>
    procedure ClientInfo();

    /// <summary>
    /// ChatsInfoByChatID - Получение информации о чате по идентификатору чата
    /// </summary>
    /// <param name="AChatID">ИД чата</param>
    procedure ChatsInfoByChatID(AChatID: integer);

    procedure ChatInfo();

    procedure ChatInfoByOrderID();

    /// <summary>
    /// LoadMessageByChatID - загрузка сообщений из БД
    /// </summary>
    /// <param name="AChatID">ИД чата</param>
    procedure LoadMessageByChatID( AChatID: integer );  overload;

    /// <summary>
    /// LoadMessageByOrderID - загрузка сообщений из БД
    /// </summary>
    /// <param name="AOrderID">ИД заказа</param>
    procedure LoadMessageByOrderID( AOrderID: integer ); overload;

    /// <summary>
    /// AddMessageToChat - Добавление сообщения форму чата
    /// </summary>
    /// <param name="MID">ИД сообщения</param>
    /// <param name="MFlag">Флаги сообщения</param>
    /// <param name="MText">Текст сообщения</param>
    /// <param name="MDate">Дата сообщения</param>
    procedure AddMessageToChat(  MID: integer;
                                 MFlag: integer;
                                 MText: string;
                                 MDate: TDateTime;
                                 MReadDate: string = '');

    /// <summary>
    /// SendMessage - Отправка сообщения
    /// </summary>
    procedure SendMessage();

    /// <summary>
    /// AddChat - Добавление чата
    /// </summary>
    procedure AddChat();

    /// <summary>
    ///  OrderID - ИД заявки
    /// </summary>
    property OrderID: Integer read FOrderID write SetOrderID;

    /// <summary>
    ///  ChatID - ИД чата
    /// </summary>
    property ChatID:  Integer read FChatID  write SetChatID;

    /// <summary>
    ///  AppType - Тип приложения:
    /// 0 - клиентское приложение;
    /// 1 - приложение менеджера;
    /// </summary>
    property AppType: Integer read FAppType write FAppType;

  end;


implementation

{$R *.dfm}

uses MainModule, uMainVar, uLogger, uUtils.Math, ServerModule;


{ TMessage }

procedure TMessage.AddChat;
begin
  if FChatID <> 0 then Exit;

  sql.Open('''
    declare @ChatID  numeric(18, 0)

    exec ChatsInsert
          @ChatID   = @ChatID out
         ,@OrderID  = :OrderID
         ,@ClientID = :ClientID
         ,@Flag     = null


    select 0       as retval
          ,@ChatID as ChatID

  ''',
  ['OrderID', 'ClientID'],
  [FOrderID,
   FClientID]);

  if sql.Q.FieldByName('retval').AsInteger = 0 then
  begin
     FChatID := sql.Q.FieldByName('ChatID').AsInteger;
  end;
end;

procedure TMessage.SendMessage();
var Flag: Integer;
begin

  if Trim(MessageText.Text) = '' then exit;

  if FChatID = 0 then AddChat;

  if FAppType = 1 then
    FFlag := 1
  else
    FFlag := 0;

  sql.Open('''
    declare @MessageID numeric(18, 0)

    exec ChatsMessageInsert
           @ChatID   = :ChatID
          ,@UserID   = :UserID
          ,@Message  = :Message
          ,@Flag     = :Flag
          ,@MessageID= @MessageID out

    select 0          as retval
          ,@MessageID as MessageID

  ''',
  ['ChatID', 'UserID', 'Message', 'Flag'],
  [FChatID,
   UniMainModule.AUserID,
   MessageText.ToHTML,
   FFlag]);

  if sql.Q.FieldByName('MessageID').AsInteger > 0 then
  begin
     AddMessageToChat (sql.Q.FieldByName('MessageID').AsInteger,
                       FFlag,
                       MessageText.ToHTML,
                       Now());
     //
     //MessageEditor.ItemIndex := MessageEditor.Items.Count - 1;

     MessageText.Clear;

     btnSendEnabled;
  end;

end;

procedure TMessage.MessageIsRead(MessageID: integer);
begin
  sql.ExecAsync('exec ChatsMessageIsRead @MessageID = :MessageID',
               ['MessageID'],
               [MessageID]);

  BroadcastMessage('ChatsMessageIsRead', ['SID', UniSession.SessionID], []);
end;

procedure TMessage.AddMessageToChat(
   MID: integer;
   MFlag: integer;
   MText: string;
   MDate: TDateTime;
   MReadDate: string = ''
   );
var
  i: integer;
  Message : string;
begin
   Message := StringReplace(FMessageItem, 'message_id', MID.ToString, []);
   Message := StringReplace(Message, 'message_text', MText, []);
   Message := StringReplace(Message, 'message_date', DateTimeToStr(MDate), []);

   if ((MFlag and 1) > 0) and (FAppType = 1) then
   begin
     Message := StringReplace(Message, 'message_type', '--self', []);
     if (MFlag and 2) > 0 then // прочитано
     begin
       Message := StringReplace(Message, 'message_viewed', '--viewed', []);
     end;
   end
   else
   if ((MFlag and 1) = 0) and (FAppType = 0) then
   begin
     Message := StringReplace(Message, 'message_type', '--self', []);
     if (MFlag and 2) > 0 then //прочитано
     begin
       Message := StringReplace(Message, 'message_viewed', '--viewed', []);
     end;
   end
   else
   begin
     Message := StringReplace(Message, 'message_type', '--opponent', []);

     if MFlag and 2 = 0 then // если сообщение не прочитано, то проставим признак
       MessageIsRead(MID);   //
   end;

   Message := StringReplace(Message, 'message_DateRead', MReadDate, []);

   i:=MessageEditor.Items.Add( Message );
end;

procedure TMessage.btnSendClick(Sender: TObject);
begin
  SendMessage();
end;

procedure TMessage.btnSendEnabled;
begin
  btnSend.Enabled := Length(MessageText.Text) > 0;
end;

procedure TMessage.ChatInfo;
begin

end;

procedure TMessage.ChatInfoByOrderID;
begin

  if FChatID <> 0 then Exit;

  sql.Open('''
    exec ChatsInfoByOrderID
           @OrderID = :OrderID
  ''',
  ['OrderID'],
  [FOrderID]);

  if sql.Count = 0 then  Exit;

  with sql.q do
  begin
    First;

    while not EOF do
    begin
      FChatID := FieldByName('ChatID').asInteger;
      Exit;
    end;
  end;

end;

procedure TMessage.ClientInfo;
begin

  sql.Open('''
    exec ChatsClientInfoByOrderID
           @OrderID = :OrderID
  ''',
  ['OrderID'],
  [FOrderID]);

//  if sql.Count = 0 then
//  begin
//    Exit;
//  end;

  with sql.q do
  begin
    First;

    while not EOF do
    begin
      lblChatTitleText.Caption := 'Заказ: ' + FOrderID.ToString +

      IfThen(FAppType=1, string(' Клиент: ' + FieldByName('ClientBrief').AsString), '');

      FClientID := FieldByName('ClientID').AsInteger;
      Next;
    end;
  end;

end;

procedure TMessage.ChatsInfoByChatID(AChatID: integer);
begin
  sql.Open('''
    exec ChatsInfoByChatID
           @ChatID = :ChatID
  ''',
  ['ChatID'],
  [AChatID]);

  with sql.q do
  begin
    First;

    while not EOF do
    begin
      FOrderID := FieldByName('OrderID').AsInteger;
      FClientID := FieldByName('ClientID').AsInteger;

      if FOrderID = 0 then
      begin
        lblChatTitleText.Caption := '' +

        IfThen(FAppType=1, string(' Клиент: ' + FieldByName('ClientBrief').AsString), '') +
        IfThen(FAppType=0, string(' Тема: ' + FieldByName('Subject').AsString), '');
      end
      else
      begin
        lblChatTitleText.Caption := 'Заказ: ' + FOrderID.ToString +

        IfThen(FAppType=1, string(' Клиент: ' + FieldByName('ClientBrief').AsString), '');
      end;

      Next;
    end;
  end;
end;

procedure TMessage.LoadMessageByChatID(AChatID: integer);
var
  i: integer;
  Message : string;
begin
  MessageText.Clear;

  ChatsInfoByChatID(AChatID);

  MessageEditor.Clear;

  sql.Open('''
    exec ChatsMessageLoadByChatID
           @ChatID = :ChatID
  ''',
  ['ChatID'],
  [AChatID]);

  if sql.Count = 0 then
  begin
    Exit;
  end;

  with sql.q do
  begin
    First;

    while not EOF do
    begin
      AddMessageToChat (FieldByName('MessageID').AsInteger,
                        FieldByName('Flag').AsInteger,
                        FieldByName('Message').AsString,
                        FieldByName('InDateTime').AsDateTime,
                        FieldByName('DateRead').AsString);

      Next;
    end;

    //MessageEditor.Selected[MessageEditor.Items.Count-1] := true;

    // MessageEditor.JSInterface.JSCall('boundList.getSelectedNodes()['+inttostr(MessageEditor.Items.Count-1)+'].scrollIntoView', [True]);


    MessageEditor.ItemIndex := MessageEditor.Items.Count - 1;
  end;
end;

procedure TMessage.LoadMessageByOrderID(AOrderID: integer); //
var
  i: integer;
  Message : string;
begin
  MessageText.Clear;

  ChatInfoByOrderID;

  ClientInfo;

  MessageEditor.Clear;

  sql.Open(' exec ChatsMessageLoadByOrderID @OrderID = :OrderID ',
  ['OrderID'],
  [AOrderID]);

  if sql.Count = 0 then
  begin
    Exit;
  end;

  with sql.q do
  begin
    First;

    while not EOF do
    begin
      AddMessageToChat (FieldByName('MessageID').AsInteger,
                        FieldByName('Flag').AsInteger,
                        FieldByName('Message').AsString,
                        FieldByName('InDateTime').AsDateTime,
                        FieldByName('DateRead').AsString);

      Next;
    end;
  end;
end;

procedure TMessage.MessageTextChange(Sender: TObject);
begin
  btnSendEnabled;
end;

procedure TMessage.ContentChatContainerAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);   var i:Integer;
  JSONObject: TJSONObject;
begin
  logger.Info(EventName );

  if EventName = 'websocket_message' then
  begin
    logger.Info( Params.Values['message'] );

    try
      JSONObject := TJSONObject.ParseJSONValue(Params.Values['message']) as TJSONObject;
      try
        // Извлекаем значения из JSON
        if JSONObject <> nil then
        begin
          logger.Info( JSONObject.GetValue('type').Value);
          logger.Info( JSONObject.GetValue('id').Value);

          if JSONObject.GetValue('type').Value = 'connection' then
            SetUserStatus(JSONObject.GetValue('type').Value, JSONObject.GetValue('id').Value.ToInteger)
          else
          if JSONObject.GetValue('type').Value = 'disconnection' then
            SetUserStatus(JSONObject.GetValue('type').Value, JSONObject.GetValue('id').Value.ToInteger)
          else
          if JSONObject.GetValue('type').Value = 'status' then
            SetUserStatus(JSONObject.GetValue('type').Value, JSONObject.GetValue('id').Value.ToInteger, JSONObject.GetValue('status').Value)
        end;
      finally
        JSONObject.Free;  // Освобождаем память
      end;
    except
      on E: Exception do
        logger.Info( 'Ошибка разбора JSON: ' + E.Message );
       // ShowMessage('Ошибка разбора JSON: ' + E.Message);
    end;

  end;
end;

procedure TMessage.SetChatID(const Value: Integer);
begin
  FChatID := Value;
  FOrderID := 0;

  LoadMessageByChatID(FChatID);
end;

procedure TMessage.SetOrderID(const Value: Integer);
begin
  FOrderID := Value;

  LoadMessageByOrderID(FOrderID);
end;

procedure TMessage.SetUserStatus(AEvent: string; ClientID: integer; Status: string='');  var i:Integer;
begin
  if AEvent = 'connection' then
    lblChatHeaderUserStatus.Caption := 'Онлайн'
  else
  if AEvent = 'disconnection' then
    lblChatHeaderUserStatus.Caption := 'Офлайн'
  else
  if AEvent = 'status' then
  begin
    if Status = 'online' then
      lblChatHeaderUserStatus.Caption := 'Онлайн'
    else
      lblChatHeaderUserStatus.Caption := 'Офлайн';
  end;
end;

procedure TMessage.UserStatusTimerTimer(Sender: TObject);
begin
  // статуса пользователя (клиента)
  if FAppType = 1 then
    UniMainModule.WS.Send('request_status:' + FClientID.ToString) ;
end;

procedure TMessage.UniFrameCreate(Sender: TObject);
var f: TStringList;
   js:string;
begin
  f :=TStringList.Create;
  try
    f.LoadFromFile(UniServerModule.StartPath + '\files\html\MessageItem.html');
    FMessageItem := f.Text;
  finally
    f.Free;
  end;

  // фуекция для копирования текста сообщения
  js := '''
    copyText = function(button) {

      var textElement = button.closest('.message-default-content-container').querySelector('.message-default-content-text p');
      var text = textElement.innerText || textElement.textContent;

      navigator.clipboard.writeText(text).then(() => {
          button.innerHTML = "✔"; // Меняем иконку на галочку
          setTimeout(() => button.innerHTML = "&#xf0ea;", 1500); // Возвращаем иконку копирования
      }).catch(err => console.error('Ошибка копирования:', err));

    } ;
  ''';
  UniSession.JSCode(js);
end;

procedure TMessage.UniFrameDestroy(Sender: TObject);
begin
  UniMainModule.WS.FormUnRegister (ContentChatContainer.JSName);
end;

procedure TMessage.UniFrameReady(Sender: TObject);
begin
  lblChatHeaderUserStatus.Caption := '';

  btnSendEnabled;

  UniMainModule.WS.FormRegister (ContentChatContainer.JSName , 'websocket_message');
end;

initialization
  RegisterClass(TMessage);

end.
