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
  uniToolBar, uniPanel, uTaskUtils, System.ImageList, Vcl.ImgList,
  uniGUIApplication;

type
  TTask_T = class(TUniFrame)
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    GridTasks: TUniDBGrid;
    qTask: TFDQuery;
    dsTask: TDataSource;
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
    qTaskTaskID: TFMTBCDField;
    qTaskBrief: TWideStringField;
    qTaskName: TWideStringField;
    qTaskDateBegin: TSQLTimeStampField;
    qTaskDateExec: TSQLTimeStampField;
    qTaskinDatetime: TSQLTimeStampField;
    qTaskupdDatetime: TSQLTimeStampField;
    qTaskIsActive: TBooleanField;
    actDateExecClear: TAction;
    tbActive: TUniToolButton;
    actTaskActive: TAction;
    N7: TUniMenuItem;
    N10: TUniMenuItem;
    UniToolButton5: TUniToolButton;
    qTaskMessage: TWideStringField;
    qTDetail: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    SQLTimeStampField3: TSQLTimeStampField;
    dsTDetail: TDataSource;
    GridDetail: TUniDBGrid;
    pnlCommon: TUniContainerPanel;
    pnlTask: TUniContainerPanel;
    pnlTaskDetail: TUniContainerPanel;
    qTDetailComment: TStringField;
    qTDetailFlag: TIntegerField;
    qTaskFlag: TIntegerField;
    actTaskEnabled: TAction;
    actTaskEnabled1: TUniMenuItem;
    procedure actAddExecute(Sender: TObject);
    procedure GridTasksCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure actDateExecClearExecute(Sender: TObject);
    procedure actTaskActiveExecute(Sender: TObject);
    procedure GridTasksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFrameReady(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure GridDetailKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qTaskFlagGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actTaskEnabledExecute(Sender: TObject);
  private
    { Private declarations }

    IsActive: Boolean;
    IsRefreshInterface: Boolean;
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

    procedure DataRefresh();
    procedure DataDetailRefresh();

    procedure SetTasksEnabledStatus(); overload;
    //procedure SetTaskEnabledStatus(AIsEnabled: boolean); overload;


    procedure SetTasksEnabledLabel();

    procedure SetTaskEnabledLabel();
  public
    { Public declarations }
    procedure TaskProcessing(ATaskID: Integer);
    procedure SetTaskEnabledStatus(AIsEnabled: boolean); overload;
  end;

implementation

uses
  uTask_F, uCommonType, uSqlUtils, MainModule, uMainVar, uGrantUtils, uLogger, ServerModule, uAuditUtils;

{$R *.dfm}

procedure TTask_T.actAddExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acInsert;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actDateExecClearExecute(Sender: TObject);
var sqltext: string;
begin
  sqltext :='''
             declare @R      int

             exec @r = TaskExecuteClear @TaskID    = :TaskID

             select @r as retcode
            ''';
  Sql.Open(sqltext, ['TaskID'], [qTaskTaskID.AsInteger]);
  qTask.Edit;
  qTask.Post;
end;

procedure TTask_T.actDeleteExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acDelete;
  Task_F.ID:=qTaskTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actEditExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acUpdate;
  Task_F.ID:=qTaskTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TTask_T.actTaskActiveExecute(Sender: TObject);
begin
  IsActive := not IsActive;

  Sql.Exec(' Update tTaskActive set IsActive = :IsActive ', ['IsActive'], [IsActive]);

  if IsActive then
    Audit.Add(TObjectType.otTask, 0, acOn , 'Включение планировщика')
  else
    Audit.Add(TObjectType.otTask, 0, acOff, 'Выключение планировщика');

  SetTasksEnabledStatus;

  BroadcastMessage('TaskEnabled',
                  ['Enabled', IsActive],
                  [boIgnoreCurrentSession]); //  boClientOnly
end;

procedure TTask_T.actTaskEnabledExecute(Sender: TObject);
var sqltext: string;
begin
  sqltext :='''
    declare @R      int

    exec @r = TaskEnabled
                @TaskID   = :TaskID
               ,@IsActive = :IsActive

    select @r as retcode
  ''';
  Sql.Open(sqltext, ['TaskID', 'IsActive'], [qTaskTaskID.AsInteger, Not qTaskIsActive.Value]);

  qTask.RefreshRecord(False);
  GridTasks.RefreshCurrentRow();
end;

procedure TTask_T.actViewExecute(Sender: TObject);
begin
  Task_F.FormAction := TFormAction.acShow;
  Task_F.ID:=qTaskTaskID.AsInteger;
  Task_F.ShowModal(UserFCallBack);
end;

procedure TTask_T.DataDetailRefresh;
begin
  qTDetail.Close;
  qTDetail.Open();
end;

procedure TTask_T.DataRefresh;
begin
  qTask.Close;
  qTask.Open();
end;

procedure TTask_T.GridDetailKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridDetail.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TTask_T.GridTasksCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
begin
  PopupMenu.Popup(x, y, GridTasks);
end;

procedure TTask_T.GridTasksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridTasks.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TTask_T.PopupMenuPopup(Sender: TObject);
begin
  SetTasksEnabledStatus;

  SetTaskEnabledLabel;
end;

procedure TTask_T.qTaskFlagGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender.AsInteger and 1 > 0) then
  begin
    Text := '<div class="task-works fa-pulse"></div>'; //&nbsp;
  end
  else
    Text := '';
end;

procedure TTask_T.SetTasksEnabledLabel();
begin
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

procedure TTask_T.SetTaskEnabledLabel;
begin
  if qTaskIsActive.Value then
  begin
    actTaskEnabled.Caption:= 'Отключить задание';
  end
  else
  begin
    actTaskEnabled.Caption:= 'Включить задание';
  end;
end;

procedure TTask_T.SetTaskEnabledStatus(AIsEnabled: boolean);
begin
	logger.Info('TTask_T.SetTaskEnabledStatus Begin');

  IsActive := AIsEnabled;

  SetTasksEnabledLabel();

  logger.Info('TTask_T.SetTaskEnabledStatus End');
end;

procedure TTask_T.SetTasksEnabledStatus;
begin
	logger.Info('TTask_T.SetTaskEnabledStatus Begin');

  Sql.Open(' Select IsActive from tTaskActive (nolock) ', [], []);

  IsActive := Sql.Q.FieldByName('IsActive').AsBoolean;

  SetTasksEnabledLabel();

  logger.Info('TTask_T.SetTaskEnabledStatus End');
end;

procedure TTask_T.TaskProcessing(ATaskID: Integer);
var BM : TBookmark;
begin
  logger.Info('TTask_T.TaskProcessing Begin');

  qTask.DisableControls;
  BM := qTask.GetBookmark;
  try
      if qTask.Locate('TaskID', ATaskID, [loCaseInsensitive, loPartialKey]) then
      begin
        qTask.RefreshRecord(True) ;
        GridTasks.RefreshCurrentRow();
       // UniSession.Synchronize;
      end;
  finally // внутри finally не работает  :(
    qTask.GotoBookmark(BM);
    qTask.FreeBookmark(BM);
    qTask.EnableControls;
  end;

  logger.Info('TTask_T.TaskProcessing End');
end;

procedure TTask_T.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  DataRefresh;
  DataDetailRefresh;
end;

procedure TTask_T.UniFrameReady(Sender: TObject);
begin
  SetTasksEnabledStatus;
end;

procedure TTask_T.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if Task_F.FormAction = acInsert then
  begin
    qTask.Refresh();
  end;
  if Task_F.FormAction = acUpdate then
  begin
    qTask.Edit ;
    qTask.Post;
  end;
  if Task_F.FormAction = acDelete then
  begin
    qTask.Refresh();
  end;
end;

initialization
  RegisterClass(TTask_T);
end.
