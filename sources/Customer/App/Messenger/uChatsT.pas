unit uChatsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,  uniGUIForm,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, UniFSCombobox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniDateRangePicker, uUniADCheckComboBoxEx, System.Actions, Vcl.ActnList,
  uniMainMenu, Vcl.Menus, uniImageList, System.ImageList, Vcl.ImgList,
  uMessengerF, uCommonType, uniGUIApplication, MainModule, uChatMessageF, uToast;

type
  TChatsT = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    fCancel: TUniBitBtn;
    Grid: TUniDBGrid;
    dsQuery: TDataSource;
    qQuery: TFDQuery;
    qQueryChatID: TFMTBCDField;
    qQuerySubject: TStringField;
    qQueryNumber: TStringField;
    qQueryInDateTime: TSQLTimeStampField;
    qQueryFlag: TIntegerField;
    qQueryStatusName: TStringField;
    UniLabel1: TUniLabel;
    fStatus: TUniADCheckComboBox;
    edtSearch: TUniComboBox;
    qQueryUnReadMessages: TIntegerField;
    btnAddChat: TUniBitBtn;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
    procedure qQueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actRefreshExecute(Sender: TObject);
    procedure actMessagesExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure btnAddChatClick(Sender: TObject);
  private
    { Private declarations }
    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;

  public
    { Public declarations }

    /// <summary>
    ///  ChatMessageFCallBack - CallBack обработчик действия
    ///</summary>
    procedure ChatMessageFCallBack(Sender: TComponent; AResult:Integer);
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant;

procedure TChatsT.actMessagesExecute(Sender: TObject);
begin
   MessengerF.ChatID := qQueryChatID.AsInteger;
   MessengerF.ShowModal();
end;

procedure TChatsT.actRefreshExecute(Sender: TObject);
begin
  GridOpen;
end;

procedure TChatsT.btnAddChatClick(Sender: TObject);
begin
  ChatMessageF.FormAction := acInsert;
  ChatMessageF.ShowModal(ChatMessageFCallBack);
end;

procedure TChatsT.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
end;

procedure TChatsT.ChatMessageFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;
  try
    if ChatMessageF.FormAction = acInsert then
    begin

      ToastOK('Сообщение успешно отправлено!', UniSession);

      GridOpen;
    end;
  except
    //on E: Exception do
    //  logger.Info('TChatsT.ChatMessageFCallBack Ошибка: ' + e.Message);
  end;
end;

procedure TChatsT.edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TChatsT.fCancelClick(Sender: TObject);
begin
  edtSearch.Clear;

  fStatus.ClearSelection;

  GridOpen;
end;

procedure TChatsT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TChatsT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(UniMainModule.AUserID, self, Grid, Params, EventName);
  end;
end;

procedure TChatsT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glSave);
end;

procedure TChatsT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
 GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glSave);
end;

procedure TChatsT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  if Direction then
    qQuery.IndexName := Column.FieldName+'_index_asc'
  else
    qQuery.IndexName := Column.FieldName+'_index_des';
end;

procedure TChatsT.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TChatsT.GridOpen;
begin
  //ShowMask('Ждите, операция выполняется');
  //UniSession.Synchronize();
  try
    qQuery.Close();

    qQuery.ParamByName('ClientID').AsInteger := UniMainModule.AUserID;

    qQuery.ParamByName('Status').AsString := fStatus.SelectedKeys;

    qQuery.ParamByName('Number').AsString := edtSearch.Text;

    qQuery.Open();

    //BroadcastMessage('ChatsMessageUpdate', ['SID', UniSession.SessionID], []);
  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TChatsT.qQueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  var t: string;
begin
  t := '';
  if (qQueryUnReadMessages.AsInteger > 0) then
  begin
    t := t + '<span class="x-orders-message" data-qtip="Имеется непрочитанное сообщение"><i class="fa fa-bell"></i></span> ';
  end;

  Text := t;
end;

procedure TChatsT.UniFrameCreate(Sender: TObject);
begin
  ComboBoxFill(fStatus,'''
    exec ChatsFilter_Status
  ''');

  GridExt.SortColumnCreate(Grid);

  GridExt.GridLayout(UniMainModule.AUserID, Self, Grid, tGridLayout.glLoad);
end;

procedure TChatsT.UniFrameDestroy(Sender: TObject);
begin
//  FClients.Free;
end;

initialization
  RegisterClass(TChatsT);

end.
