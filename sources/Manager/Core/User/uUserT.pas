unit uUserT;

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

  uUserF, uGrant, FireDAC.VCLUI.UpdateOptions, uCommonType, uniGUIForm;

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
    ImageList32: TUniImageList;
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
    ImageList16: TUniImageList;
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
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    GridUsers: TUniDBGrid;
    FDUpdateSQL1: TFDUpdateSQL;
    actLookup: TAction;
    N9: TUniMenuItem;
    UniToolButton5: TUniToolButton;
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
  private
    FAction: Integer;
    procedure SetAction(const Value: Integer);
    { Private declarations }
    procedure GridRefresh;
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
  MainModule, uGrantUtils, uMainVar, uLookupF;

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

procedure TUsersT.actGrantExecute(Sender: TObject);
begin
  GrantF.ID:=QueryUserID.AsInteger;
  GrantF.ObjectType := 0;

  GrantF.ShowModal();
end;

procedure TUsersT.actLookupExecute(Sender: TObject);
begin
 (Self.Parent as TLookupF).ID := QueryUserID.AsInteger;
 (Self.Parent as TLookupF).ModalResult := mrOk;
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
