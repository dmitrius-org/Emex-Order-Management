unit uGroupsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList,  Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uGroupF, uGrant, FireDAC.VCLUI.UpdateOptions, uniSplitter;

type
  TGroupsT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    QueryGroupID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actView: TAction;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    hdFilter: TUniHiddenPanel;
    fGroupID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    actRefreshAll: TAction;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    actGrant: TAction;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    GridGroups: TUniDBGrid;
    FDUpdateSQL: TFDUpdateSQL;
    UniToolButton6: TUniToolButton;
    GridUser: TUniDBGrid;
    qUser: TFDQuery;
    dsUser: TDataSource;
    qUserUserID: TFMTBCDField;
    qUserUserBrief: TWideStringField;
    qUserUserName: TWideStringField;
    qUserGroupID: TFMTBCDField;
    ppUser: TUniPopupMenu;
    UniMenuItem1: TUniMenuItem;
    UniMenuItem4: TUniMenuItem;
    actUserAdd: TAction;
    actUserDelete: TAction;
    pUser: TUniPanel;
    pGroup: TUniPanel;
    fUserBrief: TUniEdit;
    fUserName: TUniEdit;
    UniToolBar1: TUniToolBar;
    UniToolButton5: TUniToolButton;
    UniToolButton7: TUniToolButton;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridGroupsCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridGroupsColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridGroupsClearFilters(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actGrantExecute(Sender: TObject);
    procedure GridGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridUserClearFilters(Sender: TObject);
    procedure GridUserColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridUserCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridUserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actUserAddExecute(Sender: TObject);
    procedure actUserDeleteExecute(Sender: TObject);
  private
    { Private declarations }
    procedure DataRefresh();
    procedure UserDataRefresh();
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

  end;

implementation

uses
  MainModule, uCommonType, uGrantUtils, uMainVar, uLookupF, uToast;

{$R *.dfm}

procedure TGroupsT.actAddExecute(Sender: TObject);
begin
  GroupF.FormAction := TFormAction.acInsert;
  GroupF.ShowModal(UserFCallBack);
end;

procedure TGroupsT.actDeleteExecute(Sender: TObject);
begin
  GroupF.FormAction := TFormAction.acDelete;
  GroupF.ID:=QueryGroupID.AsInteger;
  GroupF.ShowModal(UserFCallBack);
end;

procedure TGroupsT.actEditExecute(Sender: TObject);
begin
  GroupF.FormAction := TFormAction.acUpdate;
  GroupF.ID:=QueryGroupID.AsInteger;
  GroupF.ShowModal(UserFCallBack);
end;

procedure TGroupsT.actGrantExecute(Sender: TObject);
begin
  GrantF.ID:=QueryGroupID.AsInteger;
  GrantF.ObjectType := 1; // 1 - группа

  GrantF.ShowModal();
end;

procedure TGroupsT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;

procedure TGroupsT.actUserAddExecute(Sender: TObject);
var f: TLookupF;
    sqltext: string;
begin
  f := TLookupF.Create(UniApplication);
  try
    f.Caption := 'Пользователи';
    f.FromName := 'TUsersT';

    if f.ShowModal = mrOk then
    begin
      sqltext :=' declare @R      int              '+
                ' exec @r = UserGroupLinkInsert    '+
                '             @UserID   = :UserID  '+
                '            ,@GroupID  = :GroupID '+
                '                                  '+
                ' select @r as retcode    '+
                ' ';
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      Sql.Open(UniMainModule.Query,
               ['GroupID','UserID'],
               [QueryGroupID.AsInteger,  f.ID.Strings[0].ToInteger ]);

      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end
    else
      exit;

    if RetVal.Code = 0 then
    begin
      UserDataRefresh;
      ToastOK('Успешно добавлен в группу!', UniSession);
    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;

  finally
    f.Free
  end;
end;

procedure TGroupsT.actUserDeleteExecute(Sender: TObject);
var sqltext: string;
begin
  begin
    sqltext :=' declare @R      int              '+
              ' exec @r = UserGroupLinkDelete    '+
              '             @UserID   = :UserID  '+
              '            ,@GroupID  = :GroupID '+
              '                                  '+
              ' select @r as retcode    '+
              ' ';
    UniMainModule.Query.Close;
    UniMainModule.Query.SQL.Text := sqltext;

    Sql.Open(UniMainModule.Query,
             ['GroupID','UserID'],
             [qUserGroupID.AsInteger, qUserUserID.AsInteger]);

    RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
  end;

  if RetVal.Code = 0 then
  begin
    UserDataRefresh;
    ToastOK('Пользователь успешно удален из группы!', UniSession);
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TGroupsT.actViewExecute(Sender: TObject);
begin
  GroupF.FormAction := TFormAction.acShow;
  GroupF.ID:=QueryGroupID.AsInteger;
  GroupF.ShowModal(UserFCallBack);
end;

procedure TGroupsT.DataRefresh;
begin
  Query.Close;
  Query.Open;

  actEdit.Enabled := (actEdit.Tag=1) and (Query.RecordCount>0);
  actDelete.Enabled := (actDelete.Tag=1) and (Query.RecordCount>0);
  actView.Enabled := (actView.Tag=1) and (Query.RecordCount>0);
end;

procedure TGroupsT.GridGroupsCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(x, y, GridGroups);
end;

procedure TGroupsT.GridUserCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppUser.Popup(x, y, GridUser);
end;

procedure TGroupsT.GridGroupsClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TGroupsT.GridGroupsColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
begin
  if Query.Active then
  begin
    if (Column.Field.DataType = TFieldType.ftBoolean) then  // boolean
      Query.Params.ParamValues[Column.FieldName]:=Value
    else
      Query.Params.ParamValues[Column.FieldName]:='%'+Value+'%';

    Query.Refresh();
  end;
end;

procedure TGroupsT.GridGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridGroups.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TGroupsT.GridUserClearFilters(Sender: TObject);
var i:Integer;
begin
  if qUser.Active then
  begin
    for I := 0 to qUser.Params.Count-1 do
      qUser.Params[I].Value:=null;

    qUser.Refresh;
  end;
end;

procedure TGroupsT.GridUserColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
begin
  if qUser.Active then
  begin
    if (Column.Field.DataType = TFieldType.ftBoolean) then  // boolean
      qUser.Params.ParamValues[Column.FieldName]:=Value
    else
      qUser.Params.ParamValues[Column.FieldName]:='%'+Value+'%';

    qUser.Refresh();
  end;
end;

procedure TGroupsT.GridUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridUser.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TGroupsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  DataRefresh;

  UserDataRefresh;
end;

procedure TGroupsT.UserDataRefresh;
begin
  qUser.Close;
  qUser.Open;
end;

procedure TGroupsT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if GroupF.FormAction = acInsert then
  begin
    DataRefresh;
  end
  else
  if GroupF.FormAction = acUpdate then
  begin
    Query.Edit;
    Query.Post;
  end
  else
  if GroupF.FormAction = acDelete then
  begin
    DataRefresh;
  end;
end;

initialization
  RegisterClass(TGroupsT);
end.
