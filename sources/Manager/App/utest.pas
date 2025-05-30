﻿unit utest;

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
  TAPIKeyT = class(TBaseT)
    actDelete: TAction;
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
    procedure actDeleteExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actUpdateExecute(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
    { Private declarations }
    procedure EditCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }
    procedure DataRefresh(); override;

    property ClientID: Integer read FClientID write SetClientID;
  end;

var
  APIKeyT: TAPIKeyT;

implementation

uses
  uUtils.Logger, uAPIKeyForm_F;

{$R *.dfm}

procedure TAPIKeyT.actDeleteExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acDelete;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyT.actInsertExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acInsert;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyT.actUpdateExecute(Sender: TObject);
begin
  APIKeyForm_F.FormAction := TFormAction.acUpdate;
  APIKeyForm_F.ShowModal(EditCallBack);
end;

procedure TAPIKeyT.DataRefresh;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    Query.Close;
    Query.ParamByName('ClientID').AsInteger := FClientID;
    Query.Open;

    inherited;
  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TAPIKeyT.EditCallBack(Sender: TComponent; AResult: Integer);
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

procedure TAPIKeyT.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

initialization
  RegisterClass(TAPIKeyT);

end.
