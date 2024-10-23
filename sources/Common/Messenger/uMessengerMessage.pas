unit uMessengerMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniButton, uniMemo, uniBitBtn, uniSpeedButton,
  uniMultiItem, uniListBox, uniLabel, uniPanel, uniGUIBaseClasses, uSqlUtils,
  uniHTMLMemo, UniFSPopup, uniGUIApplication, uniStrUtils, System.JSON,
  uniThreadTimer, uniTimer;

type
  TMessage = class(TUniFrame)
    pnlContentChatContainer: TUniContainerPanel;
    pnlContentChatContent: TUniContainerPanel;
    pnlMessageList: TUniContainerPanel;
    pnlChatHeader: TUniPanel;
    pnlChatHeaderLeft: TUniPanel;
    pnlChatHheaderInfo: TUniContainerPanel;
    pnlChatHeaderTitle: TUniContainerPanel;
    pnlChatHeaderTitleContainer: TUniContainerPanel;
    lblChatTitleText: TUniLabel;
    lblChatHeaderUserStatus: TUniLabel;
    MessageEditor: TUniListBox;
    pnlSendContainer: TUniContainerPanel;
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
    procedure UniFrameReady(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure MessageTextChange(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure UniSpeedButton1Click(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure pnlContentChatContainerAjaxEvent(Sender: TComponent;
      EventName: string; Params: TUniStrings);
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

    function MemoTextToHTML(Memo: TUniMemo): string;

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
  public
    { Public declarations }

    procedure ClientInfo();
    procedure ChatInfo();

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
                                 MDate: TDateTime);

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
    property ChatID:  Integer read FChatID  write FChatID;

    /// <summary>
    ///  AppType - Тип приложения:
    /// 0 - клиентское приложение;
    /// 1 - приложение менеджера;
    /// </summary>
    property AppType: Integer read FAppType write FAppType;

  end;


implementation

{$R *.dfm}

uses MainModule, uMainVar, uLogger;


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
          ,@OrderID  = :OrderID
          ,@UserID   = :UserID
          ,@Message  = :Message
          ,@Flag     = :Flag
          ,@MessageID= @MessageID out

    select 0          as retval
          ,@MessageID as MessageID

  ''',
  ['ChatID', 'OrderID', 'UserID', 'Message', 'Flag'],
  [FChatID,
   FOrderID,
   UniMainModule.AUserID,
   MemoTextToHTML(MessageText),
   FFlag]);

  if sql.Q.FieldByName('MessageID').AsInteger > 0 then
  begin
     AddMessageToChat (sql.Q.FieldByName('MessageID').AsInteger,
                       FFlag,
                       MemoTextToHTML(MessageText),
                       Now());

     MessageText.Clear;

     btnSendEnabled;
  end;

end;


procedure TMessage.MessageIsRead(MessageID: integer);
begin
  sql.ExecAsync(' exec ChatsMessageIsRead @MessageID = :MessageID', ['MessageID'], [MessageID])
end;


procedure TMessage.AddMessageToChat(
   MID: integer;
   MFlag: integer;
   MText: string;
   MDate: TDateTime
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
       Message := StringReplace(Message, 'message_viewed', '--viewed', []);
   end
   else
   if ((MFlag and 1) = 0) and (FAppType = 0) then
   begin
     Message := StringReplace(Message, 'message_type', '--self', []);
     if (MFlag and 2) > 0 then //прочитано
       Message := StringReplace(Message, 'message_viewed', '--viewed', []);
   end
   else
   begin
     Message := StringReplace(Message, 'message_type', '--opponent', []);

     if MFlag and 2 = 0 then // если сообщение не прочитано, то проставим признак
       MessageIsRead(MID);   //
   end;


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
                                  ' Клиент: ' + FieldByName('ClientBrief').AsString;

      FClientID := FieldByName('ClientID').AsInteger;
      Next;
    end;
  end;

end;

procedure TMessage.LoadMessageByChatID(AChatID: integer);
var
  i: integer;
  Message : string;
begin
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
                        FieldByName('InDateTime').AsDateTime);

      Next;
    end;
  end;
end;

procedure TMessage.LoadMessageByOrderID(AOrderID: integer); //
var
  i: integer;
  Message : string;
begin
  MessageText.Clear;

  ChatInfo;

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
                        FieldByName('InDateTime').AsDateTime);

      Next;
    end;
  end;
end;

function TMessage.MemoTextToHTML(Memo: TUniMemo): string;
var
  i: Integer;
  HTMLText: string;
begin
  HTMLText := '<p>';

  // Перебираем строки в TUniMemo и оборачиваем их в теги <p>
  for i := 0 to Memo.Lines.Count - 1 do
  begin
    if Memo.Lines[i].Length > 0  then
      HTMLText := HTMLText + Memo.Lines[i] + '<br>';
  end;

  if i=1 then HTMLText := StringReplace(HTMLText, '<br>', '', []);

  HTMLText := HTMLText + '</p>';

  Result := HTMLText;
end;

procedure TMessage.MessageTextChange(Sender: TObject);
begin
  btnSendEnabled;
end;

procedure TMessage.pnlContentChatContainerAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);   var i:Integer;
  JSONObject: TJSONObject;
begin
  logger.Info(EventName );

//  for i := 0 to Params.Count - 1 do
//  begin
//    logger.Info(Format('Param[%d]: %s = %s', [i, Params.Names[i], Params.Values[Params.Names[i]]]));
//  end;

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

procedure TMessage.UniSpeedButton1Click(Sender: TObject);
begin
//  UniMainModule.WS.send (
//
////  'Sessions',
//                    [
//                      'Session', UniSession.SessionId,
//                      'User',    UniMainModule.AUserID,
//                      'InDateTime', DateTimeToStr(Now())
//                    ]
////                    []      //boIgnoreCurrentSession
//  );

end;

procedure TMessage.UserStatusTimerTimer(Sender: TObject);
begin
//  Sleep(3000);

  // статуса пользователя (клиента)
  if FAppType = 1 then
    UniMainModule.WS.Send('request_status:' + FClientID.ToString) ;
 // UniMainModule.WS.Send('request_status:' + UniMainModule.AUserID.ToString) ;
end;

procedure TMessage.UniFrameCreate(Sender: TObject);
var f: TStringList;
begin
  f :=TStringList.Create;

  f.LoadFromFile('.\files\html\MessageItem.html');
  FMessageItem := f.Text;

  f.Free;
end;

procedure TMessage.UniFrameDestroy(Sender: TObject);
begin
  UniMainModule.WS.FormUnRegister ( pnlContentChatContainer.JSName);
end;

procedure TMessage.UniFrameReady(Sender: TObject);
begin
  lblChatHeaderUserStatus.Caption := '';

  if FOrderID= 0 then
  begin
    logger.Info(OrderID.ToString);
    logger.Info(AppType.ToString);
    AppType:=1;
    OrderID  := 167120;

  end;

  btnSendEnabled;

  UniMainModule.WS.FormRegister (pnlContentChatContainer.JSName , 'websocket_message');
end;



initialization
  RegisterClass(TMessage);

end.
