unit uAPIFormT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniGUIBaseClasses, uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid,
  uniDBGrid, uniGUIClasses, uniPanel, uniCheckBox, uniEdit, uniButton,
  uniBitBtn, uniGroupBox, uniToolBar, uCommonType, uniGUIFrame, uBaseT;

type
  TAPIFormT = class(TBaseT)
    actDelete: TAction;
    ppInsert: TUniMenuItem;
    ToolBars: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    gbFilter: TUniGroupBox;
    actInsert: TAction;
    actUpdate: TAction;
    QueryApiKeysID: TIntegerField;
    QueryClientID: TFMTBCDField;
    QueryApiKey: TStringField;
    QueryName: TStringField;
    QueryFlag: TIntegerField;
    QueryinDatetime: TSQLTimeStampField;
    QueryEndDatetime: TSQLTimeStampField;
    UniToolButton3: TUniToolButton;
    ppUpdate: TUniMenuItem;
    ppDelete: TUniMenuItem;
    N3: TUniMenuItem;
    N1: TUniMenuItem;
    MainMenuImage: TUniNativeImageList;
    procedure actDeleteExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actUpdateExecute(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure GridColumnActionClick(Column: TUniDBGridColumn;
      ButtonId: Integer);
    procedure QueryApiKeyGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
    { Private declarations }
    procedure EditCallBack(Sender: TComponent; AResult:Integer);

    procedure MenuEnabled;
  public
    { Public declarations }
    procedure DataRefresh(); override;

    property ClientID: Integer read FClientID write SetClientID;
  end;

var
  APIFormT: TAPIFormT;

implementation

uses
  uUtils.Logger, uAPIKeyForm_F, uMainVar;

{$R *.dfm}

procedure TAPIFormT.actDeleteExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите удалить ключ? ' , mtConfirmation, mbYesNo,

  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes :
      begin
        Sql.Open('''
          declare @R      int

          exec @R =ApiKeyDelete
                    @ApiKeysID = :ApiKeysID
          select @R as R
        ''', ['ApiKeysID'], [QueryApiKeysID.AsInteger]
        );

        if Sql.f('R').value = 0 then
          DataRefresh;
      end;
      mrNo  : Exit;
    end;
  end

  );
end;

procedure TAPIFormT.actInsertExecute(Sender: TObject);
begin
  Sql.Open('''
    declare @R      int
           ,@ApiKey NVARCHAR(128)
    exec @R =ApiKeyGenerate
              @ClientID = :ClientID
             ,@ApiKey   = @ApiKey out
    select @R as R
  ''', ['ClientID'], [FClientID]
  );

  if Sql.f('R').value = 0 then
    DataRefresh;
end;

procedure TAPIFormT.actUpdateExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acUpdate;
  APIKeyForm_F.ID := QueryApiKeysID.AsInteger;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIFormT.DataRefresh;
begin
  ShowMask('Ждите, операция выполняется');
 // UniSession.Synchronize;
  try
    Query.Close;
    Query.ParamByName('ClientID').AsInteger := FClientID;
    Query.Open;

    //inherited;

    MenuEnabled;
  finally
    HideMask();
  //  UniSession.Synchronize;
  end;
end;

procedure TAPIFormT.EditCallBack(Sender: TComponent; AResult: Integer);
begin
  LogInfo('TAPIKeyT.EditCallBack Begin');
  if AResult <> mrOK then Exit;

  if APIKeyForm_F.FormAction = acInsert then
  begin
    Query.Refresh;
  end
  else
  if APIKeyForm_F.FormAction = acUpdate then
  begin
    Query.RefreshRecord();
    Grid.RefreshCurrentRow();
  end
  else
  if APIKeyForm_F.FormAction = acDelete then
  begin
    Query.Delete;
  end;
  LogInfo('TAPIKeyT.EditCallBack end');
end;

procedure TAPIFormT.GridColumnActionClick(Column: TUniDBGridColumn;
  ButtonId: Integer);
begin
  inherited;
  //
end;

procedure TAPIFormT.MenuEnabled;
begin
  actUpdate.Enabled := (Query.recordcount > 0) and (actUpdate.tag = 1);
  actDelete.Enabled := (Query.recordcount > 0) and (actDelete.tag = 1);
end;

procedure TAPIFormT.QueryApiKeyGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  Value: string;
begin
  Value := Sender.AsString;
  Text :=
    '<span class="key-text">' +
    Value +
    '<button class="copy-key-button" onclick="copyMd5(this)">&#xf0ea; md5' +
//    '<i class="fa fa-key"></i>' +
    '</button>' +
    '</span>';
end;

procedure TAPIFormT.SetClientID(const Value: Integer);
begin
  FClientID := Value;

  DataRefresh;
end;

procedure TAPIFormT.UniFrameCreate(Sender: TObject);
var js: string;
begin
  ParentMenu := 'TClientsT.actApi';

  inherited;

  MenuEnabled;

  // функция для копирования текста в md5
  js := '''
    copyMd5 = function(button) {
      const text = button.parentElement.firstChild.textContent;
      const hash = CryptoJS.MD5(text).toString();
      navigator.clipboard.writeText(hash).then(() => {
          button.innerHTML = "✔"; // Меняем иконку на галочку
          setTimeout(() => button.innerHTML = "&#xf0ea; md5", 1500); // Возвращаем иконку копирования
      }).catch(err => console.error('Ошибка копирования:', err));

    } ;
  ''';
  UniSession.JSCode(js);
end;

initialization
  RegisterClass(TAPIFormT);

end.
