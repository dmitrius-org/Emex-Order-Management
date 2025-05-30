﻿unit uUserT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, FireDAC.VCLUI.UpdateOptions, uCommonType, uniGUIForm, uToast,
  uEmployeeParametersF, uEmployeeOrdersProcessedT_Wrapper,
  uEmployeeOrdersProcessedT;

type
  TUsersT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    QueryUserID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    QueryDateBlock: TSQLTimeStampField;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryisAdmin: TBooleanField;
    QueryisBlock: TBooleanField;
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
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    fisBlock: TUniCheckBox;
    actGrant: TAction;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    GridUsers: TUniDBGrid;
    FDUpdateSQL: TFDUpdateSQL;
    actLookup: TAction;
    N9: TUniMenuItem;
    UniToolButton5: TUniToolButton;
    UniToolButton6: TUniToolButton;
    UniToolButton7: TUniToolButton;
    actGroup: TAction;
    N10: TUniMenuItem;
    actGrantCopy: TAction;
    N11: TUniMenuItem;
    actEmployeeParameters: TAction;
    N12: TUniMenuItem;
    N14: TUniMenuItem;
    actEmployeeOrdersProcessed: TAction;
    N13: TUniMenuItem;
    actLogger: TAction;
    N16: TUniMenuItem;
    N15: TUniMenuItem;
    QueryStatus: TIntegerField;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridUsersCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure GridUsersColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure GridUsersClearFilters(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actGrantExecute(Sender: TObject);
    procedure GridUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameReady(Sender: TObject);
    procedure actLookupExecute(Sender: TObject);
    procedure actGroupExecute(Sender: TObject);
    procedure actGrantCopyExecute(Sender: TObject);
    procedure actEmployeeParametersExecute(Sender: TObject);
    procedure actEmployeeOrdersProcessedExecute(Sender: TObject);
    procedure actLoggerExecute(Sender: TObject);
    procedure QueryStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    FAction: Integer;
    procedure SetAction(const Value: Integer);
    { Private declarations }
    procedure GridRefresh;

    procedure LoggerFCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

    //используем тип Integer т.к. не можем происвоить значение TFormAction для лукап фрмы
    property FormAction: Integer read FAction write SetAction;
  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uLookupF, uGroups2T, uLoggerF, uConstant;

{$R *.dfm}

procedure TUsersT.actAddExecute(Sender: TObject);
begin
  UserF.FormAction := TFormAction.acInsert;
  UserF.ShowModal(UserFCallBack);
end;

procedure TUsersT.actDeleteExecute(Sender: TObject);
begin
  UserF.FormAction := TFormAction.acDelete;
  UserF.ID:=QueryUserID.AsInteger;
  UserF.ShowModal(UserFCallBack);
end;

procedure TUsersT.actEditExecute(Sender: TObject);
begin
  UserF.FormAction := TFormAction.acUpdate;
  UserF.ID:=QueryUserID.AsInteger;
  UserF.ShowModal(UserFCallBack);
end;

procedure TUsersT.actGrantCopyExecute(Sender: TObject);
var f: TLookupF;
    sqltext: string;
    I: Integer;
begin
  f := TLookupF.Create(UniApplication);
  try
    f.Caption := 'Пользователи';
    f.FromName := 'TUsersT';

    if f.ShowModal = mrOk then
    begin
       sqltext := '''
         declare @R int = 0

         exec @R=GrantCopy
                   @UserID       = :UserID
                  ,@SourceUserID = :SourceUserID

         select @r as retcode
       ''';

      for I := 0 to f.ID.Count - 1 do
      begin
        Sql.Open(sqltext,
                ['UserID','SourceUserID'],
                [QueryUserID.AsInteger,
                 f.ID.Strings[I].ToInteger]);
      end;
    end
    else
      Exit;

    if RetVal.Code = 0 then
    begin
      ToastOK('Права успешно скопированы!', UniSession);
    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;

  finally
    f.Free
  end;
end;

procedure TUsersT.actGrantExecute(Sender: TObject);
begin
  GrantF.ID:=QueryUserID.AsInteger;
  GrantF.ObjectType := 0;

  GrantF.ShowModal();
end;

procedure TUsersT.actGroupExecute(Sender: TObject);
begin
  Groups2T.ShowModal;
end;

procedure TUsersT.actLoggerExecute(Sender: TObject);
begin
  LoggerF.UserID :=QueryUserID.AsInteger;
  LoggerF.AppName:= AppManager;
  LoggerF.ShowModal(LoggerFCallBack);
end;

procedure TUsersT.actLookupExecute(Sender: TObject);
var //BM : TBookmark;
    i:Integer;
begin
  if GridUsers.SelectedRows.Count>0 then
  begin
    // BM := FGrid.DataSource.DataSet.GetBookmark;
     try
        for I := 0 to GridUsers.SelectedRows.Count - 1 do
        begin
          GridUsers.DataSource.DataSet.Bookmark := GridUsers.SelectedRows[I];
          (Self.Parent as TLookupF).ID.Add(GridUsers.DataSource.DataSet.FieldByName('UserID').AsString);
        end;
     finally
     //  FGrid.DataSource.DataSet.GotoBookmark(BM);
     //  FGrid.DataSource.DataSet.FreeBookmark(BM);
     end;
  end
  else
  begin
    (Self.Parent as TLookupF).ID.Add(QueryUserID.AsString);
  end;

 (Self.Parent as TLookupF).ModalResult := mrOk;
end;

procedure TUsersT.actEmployeeOrdersProcessedExecute(Sender: TObject);
begin
  EmployeeOrdersProcessedT_Wrapper.EmployeeID := QueryUserID.AsInteger;
  EmployeeOrdersProcessedT_Wrapper.ShowModal();
end;

procedure TUsersT.actEmployeeParametersExecute(Sender: TObject);
begin
  EmployeeParametersF.ID :=QueryUserID.AsInteger;
  EmployeeParametersF.FormAction := TFormAction.acUpdate;
  EmployeeParametersF.ShowModal;
end;

procedure TUsersT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;

procedure TUsersT.actViewExecute(Sender: TObject);
begin
  UserF.FormAction := TFormAction.acShow;
  UserF.ID:=QueryUserID.AsInteger;
  UserF.ShowModal(UserFCallBack);
end;

procedure TUsersT.GridRefresh;
begin
  Query.Close;
  Query.Open;

  actLookup.Visible :=(TFormAction(FAction) = acLookup) and (Query.RecordCount >0);
end;

procedure TUsersT.GridUsersCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(x, y, GridUsers);
end;

procedure TUsersT.GridUsersClearFilters(Sender: TObject);
var i:Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TUsersT.GridUsersColumnFilter(Sender: TUniDBGrid;
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

procedure TUsersT.GridUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridUsers.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TUsersT.LoggerFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult= mrOK then
  begin
    Query.RefreshRecord();
    GridUsers.RefreshCurrentRow();
  end;
end;

procedure TUsersT.QueryStatusGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender.AsInteger and 1) > 0 then
  begin
      Text := '<span class="logger-enabled" data-qtip="Включено логирование"><i class="fa fa-bug"></i></span> ';
  end;
end;

procedure TUsersT.SetAction(const Value: Integer);
begin
  FAction := Value;

  actLookup.Visible :=(FAction = Integer(acLookup)) and (Query.RecordCount >0);
end;

procedure TUsersT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);
end;

procedure TUsersT.UniFrameReady(Sender: TObject);
begin
  GridRefresh;
end;

procedure TUsersT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if UserF.FormAction = acInsert then
  begin
//    UniMainModule.Query.SQL.Text := ' select u.UserID '+
//                                    '       ,u.Brief        '+
//                                    '       ,u.Name         '+
//                                    '       ,u.isAdmin      '+
//                                    '       ,u.isBlock      '+
//                                    '       ,u.DateBlock    '+
//                                    '       ,u.inDatetime   '+
//                                    '       ,u.updDatetime  '+
//                                    '   from tUser u (nolock)   '+
//                                    '  where u.UserID = :UserID '+
//                                    ' ';
//    UniMainModule.Query.ParamByName('UserID').Value := QueryUserID.AsInteger;
//    UniMainModule.Query.Open;
//
//    Query.Insert ;
//    GridUsers.DataSource.DataSet.Insert;
//    Query.FieldValues['UserID']   := UniMainModule.Query.FieldValues['UserID'];
//    Query.FieldValues['Brief']   := UniMainModule.Query.FieldValues['Brief'];
//    Query.FieldValues['Name']    := UniMainModule.Query.FieldValues['Name'];
//    Query.FieldValues['isBlock'] := UniMainModule.Query.FieldValues['isBlock'];
//    Query.FieldValues['isAdmin']     := UniMainModule.Query.FieldValues['isAdmin'];
//    Query.FieldValues['DateBlock']   := UniMainModule.Query.FieldValues['DateBlock'];
//    Query.FieldValues['inDatetime'] := UniMainModule.Query.FieldValues['inDatetime'];
//    Query.FieldValues['updDatetime'] := UniMainModule.Query.FieldValues['updDatetime'];
   //  GridUsers.DataSource.DataSet.Post;
    Query.Refresh();
  end;
  if UserF.FormAction = acUpdate then
  begin
    UniMainModule.Query.SQL.Text := ' select u.*  '+
                                    '   from vUsers u   '+
                                    '  where u.UserID = :UserID '+
                                    ' ';
    UniMainModule.Query.ParamByName('UserID').Value := QueryUserID.AsInteger;
    UniMainModule.Query.Open;

    Query.Edit ;
    Query.FieldValues['Brief']   := UniMainModule.Query.FieldValues['Brief'];
    Query.FieldValues['Name']    := UniMainModule.Query.FieldValues['Name'];
    Query.FieldValues['isBlock'] := UniMainModule.Query.FieldValues['isBlock'];
    //Query.FieldValues['isAdmin']     := UniMainModule.Query.FieldValues['isAdmin'];
    Query.FieldValues['DateBlock']   := UniMainModule.Query.FieldValues['DateBlock'];
    Query.FieldValues['updDatetime'] := UniMainModule.Query.FieldValues['updDatetime'];
    Query.Post;
  end;
  if UserF.FormAction = acDelete then
  begin
   // GridUsers.DataSource.DataSet.Delete;
   Query.Refresh();
  end;
end;

initialization
  RegisterClass(TUsersT);
end.
