unit uTask_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList, uniGUIBaseClasses,
  uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid, uniDBGrid,
  uniToolBar, uniPanel, uTaskUtils, System.ImageList, Vcl.ImgList;

type
  TTask_T = class(TUniFrame)
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    GridUsers: TUniDBGrid;
    Query: TFDQuery;
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actView: TAction;
    actRefreshAll: TAction;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    ImageList16: TUniImageList;
    FDUpdateSQL: TFDUpdateSQL;
    QueryTaskID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    QueryDateBegin: TSQLTimeStampField;
    QueryDateExec: TSQLTimeStampField;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryIsActive: TBooleanField;
    actDateExecClear: TAction;
    tbActive: TUniToolButton;
    actTaskActive: TAction;
    N8: TUniMenuItem;
    N9: TUniMenuItem;
    N7: TUniMenuItem;
    N10: TUniMenuItem;
    UniToolButton5: TUniToolButton;
    QueryMessage: TWideStringField;
    procedure actAddExecute(Sender: TObject);
    procedure GridUsersCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure actDateExecClearExecute(Sender: TObject);
    procedure actTaskActiveExecute(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure GridUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

    procedure DataRefresh();

    procedure SetTaskEnabledStatus();
  public
    { Public declarations }
  end;

implementation

uses
  uTask_F, uCommonType, uSqlUtils, MainModule, uMainVar, uGrantUtils;

var MTask: TMTask;
var IsActive: Boolean;

{$R *.dfm}

procedure TTask_T.actAddExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acInsert;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actDateExecClearExecute(Sender: TObject);
var sqltext: string;
begin
  sqltext :=' declare @R      int                 '+
            '                                     '+
            ' exec @r = TaskExecuteClear          '+
            '             @TaskID    = :TaskID    '+
            '                                     '+
            ' select @r as retcode                '+
            ' ';
  Sql.Open(sqltext,
           ['TaskID'], [QueryTaskID.AsInteger]);
  Query.Edit; Query.Post;
end;

procedure TTask_T.actDeleteExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acDelete;
  Task_F.ID:=QueryTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actEditExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acUpdate;
  Task_F.ID:=QueryTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TTask_T.actTaskActiveExecute(Sender: TObject);
begin
  MTask.IsActive := not IsActive;

  SetTaskEnabledStatus;
end;

procedure TTask_T.actViewExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acShow;
  Task_F.ID:=QueryTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.DataRefresh;
begin
  Query.Close;
  Query.Open();
end;

procedure TTask_T.GridUsersCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(x, y, GridUsers);
end;

procedure TTask_T.GridUsersKeyDown(Sender: TObject; var Key: Word;
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

procedure TTask_T.SetTaskEnabledStatus;

begin
  IsActive:=MTask.IsActive;

  if IsActive then
  begin
    actTaskActive.Caption:= 'Выполнение задач включено';
    actTaskActive.ImageIndex := 5;
  end
  else
  begin
    actTaskActive.Caption:= 'Выполнение задач выключено';
    actTaskActive.ImageIndex := 4;
  end;
end;

procedure TTask_T.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  if not Assigned(MTask) then
    MTask:= TMTask.Create(UniMainModule.FDConnection);

  SetTaskEnabledStatus;

  DataRefresh;
end;

procedure TTask_T.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(MTask);
end;

procedure TTask_T.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if Task_F.FormAction = acInsert then
  begin
    Query.Refresh();
  end;
  if Task_F.FormAction = acUpdate then
  begin
    Query.Edit ;
    Query.Post;
  end;
  if Task_F.FormAction = acDelete then
  begin
    Query.Refresh();
  end;
end;

initialization
  RegisterClass(TTask_T);
end.
