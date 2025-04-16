unit uAPIKeyForm_T;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseT, FireDAC.Stan.Intf, Vcl.Graphics,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniGUIBaseClasses, uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid,
  uniDBGrid, uniGUIClasses, uniPanel, uniCheckBox, uniEdit, uniButton,
  uniBitBtn, uniGroupBox, uniToolBar, uCommonType;

type
  TAPIKeyForm_T = class(TBaseT)
    QueryApiKeysID: TIntegerField;
    QueryClientID: TFMTBCDField;
    QueryApiKey: TStringField;
    QueryName: TStringField;
    QueryFlag: TIntegerField;
    QueryinDatetime: TSQLTimeStampField;
    QueryEndDatetime: TSQLTimeStampField;
    gbFilter: TUniGroupBox;
    ToolBars: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    actInsert: TAction;
    ActEdit: TAction;
    actDelete: TAction;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    procedure actInsertExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
    /// <summary>
    ///  EditCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure EditCallBack(Sender: TComponent; AResult:Integer);
  public
    procedure DataRefresh(); override;
    property ClientID: Integer read FClientID write SetClientID;
  end;

implementation

uses
  uAPIKeyForm_F;

{$R *.dfm}

{ TAPIKeyForm_T }

procedure TAPIKeyForm_T.actDeleteExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acDelete;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyForm_T.ActEditExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acUpdate;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyForm_T.actInsertExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acInsert;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyForm_T.DataRefresh;
begin
//  inherited;

  Query.Close;
  Query.ParamByName('ClientID').AsInteger := FClientID;
  Query.Open;
end;

procedure TAPIKeyForm_T.EditCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if APIKeyForm_F.FormAction = acInsert then
  begin
    Query.Refresh;
  end
  else
  if APIKeyForm_F.FormAction = acUpdate then
  begin
    Query.RefreshRecord();

    Grid.Refresh();
  end
  else
  if APIKeyForm_F.FormAction = acDelete then
  begin
    Query.Delete;
  end;
end;

procedure TAPIKeyForm_T.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

initialization
  RegisterClass(TAPIKeyForm_T);

end.
