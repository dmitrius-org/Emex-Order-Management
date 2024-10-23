unit uMessenger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniMemo, uniHTMLMemo, uniGUIBaseClasses, uniPanel,
  uniHTMLFrame, uniMultiItem, uniListBox, uniDBListBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Contnrs, uSqlUtils,
  uniSegmentedButton, uniEdit, uniButton, uniBitBtn, uniSpeedButton, uniLabel,
  uniImage;

type

  tChatItem = class
    private
    FChatID      :integer;
  //	ClientID    :integer;
  //  OrderID     :integer;
	//  Flag        :integer;
  //  InDateTime  :TDateTime;


  protected

  public
    constructor Create;
  published
     property ChatID: integer read FChatID write FChatID;
   //  property ChatID: integer read FChatID write FChatID;
   //  property ChatID: integer read FChatID write FChatID;

  end;

  TChats = class(TObject)
  private
    FItems:TObjectList;
    FCount: integer;
    procedure SetCount(const Value: integer);

  protected

  public
    constructor Create;
    destructor Destroy;

  published
     procedure Clear;
     property Count: integer read FCount write SetCount;
     property Items:TObjectList read FItems write FItems;
  end;

  TMessenger = class(TUniFrame)
    leftPanel: TUniPanel;
    pnlContentDefaultChatContainer: TUniPanel;
    qChats: TFDQuery;
    dsChats: TDataSource;
    qChatsChatID: TFMTBCDField;
    qChatsClientID: TFMTBCDField;
    qChatsOrderID: TFMTBCDField;
    qChatsFlag: TIntegerField;
    qChatsInDateTime: TSQLTimeStampField;
    ItemsPanel: TUniPanel;
    ChatsEditor: TUniListBox;
    qChatsClientBrief: TWideStringField;
    MessengerContainer: TUniContainerPanel;
    procedure UniFrameCreate(Sender: TObject);
    procedure qChatsChatIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ChatsEditorClick(Sender: TObject);
  private
    { Private declarations }
    FChatItem: string;
  public
    { Public declarations }

    procedure ChatsLoad;
    procedure GetChats;


  end;

implementation

uses
  MainModule, uMainVar, uLogger;

var Chats:TChats;

{$R *.dfm}


 { Tchat }



procedure TMessenger.ChatsEditorClick(Sender: TObject);
var js: string;
begin
  if ChatsEditor.ItemIndex > -1 then
  begin
   // FChatID := tChatItem( Chats.FItems[ ChatsEditor.ItemIndex ] ).ChatID;


    UniSession.AddJS('Ext.select(".items-container").first().addCls("selected");');

    //LoadMessage( FChatID );
  end;
end;

procedure TMessenger.ChatsLoad;
var chatItemSapmle : tStringList;

begin
 // Items := TChats.Create(ItemsPanel);
//  Items.Parent := ItemsPanel;
//  Items.Sql := Sql;
//  Items.ClientID := 57;

  GetChats;

 // Chats.HTML.Clear;
 // Chats.HTML.LoadFromFile( FStatusFile );
end;

procedure TMessenger.GetChats;
var
  i: integer;
  ChatItem: tChatItem;
begin
  qChats.close;
  qChats.ParamByName('ClientID').AsInteger := 57;
  qChats.open;

  with qChats do
  begin
    First;
    ChatsEditor.Clear;
    Chats.Clear;

    while not EOF do
    begin
      ChatItem:= tChatItem.Create;

      with ChatItem do
      begin
        ChatID := FieldByName('ChatID').AsInteger;
       // ClientID := FieldByName('ClientID').AsInteger;
       // OrderID := FieldByName('OrderID').AsInteger;
       // Flag := FieldByName('Flag').AsInteger;
       // InDateTime := FieldByName('InDateTime').AsDateTime;
      end;

      i:=ChatsEditor.Items.Add( FieldByName('ChatID').Text );

      Chats.FItems.Add( ChatItem );

      Next;
    end;
  end;
end;


procedure TMessenger.qChatsChatIDGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var ChatItem: String;
begin
  ChatItem :=  Format (FChatItem,
  [qChats.fieldByName('ChatID').asString,
   qChats.fieldByName('ChatID').asString,
   qChats.fieldByName('InDateTime').asString,
   qChats.fieldByName('ClientBrief').asString]);

  if qChats.fieldByName('Flag').AsInteger and 1 > 0 then
    ChatItem := StringReplace(ChatItem, 'item-pinned-icon', '--pinned item-pinned-icon',[])
  else
    ChatItem := StringReplace(ChatItem, 'item-pinned-icon', '',[]);

  Text := ChatItem;
end;


procedure TMessenger.UniFrameCreate(Sender: TObject);
var f: TStringList;
begin
  Chats := TChats.Create;

  f :=TStringList.Create;

//  f.LoadFromFile('.\files\html\MessengerMessage.html');
//  FMessageHeader := f.Text;



  f.LoadFromFile('.\files\html\ChatItem.html');
  FChatItem := f.Text;

 // f.LoadFromFile('.\files\html\MessageItem.html');
 // FMessageItem := f.Text;


  f.Free;

  ChatsLoad;
end;

{ TChats }

procedure TChats.Clear;
begin
  FItems.Clear;
end;

constructor TChats.Create;
begin
  inherited;
  FItems := TObjectList.Create;

  FCount := -1
end;

destructor TChats.Destroy;
begin

  inherited;
end;

procedure TChats.SetCount(const Value: integer);
begin
  FCount := Value;
end;

{ tChatItem }

constructor tChatItem.Create;
begin

end;

initialization
  RegisterClass(TMessenger);
end.
