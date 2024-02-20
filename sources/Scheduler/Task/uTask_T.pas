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
  uniThreadTimer, uniTimer;

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
    DBAlert: TFDEventAlerter;
    IntefaceRefresh: TUniTimer;
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
    procedure GridUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameReady(Sender: TObject);
    procedure DBAlertAlert(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);
    procedure PopupMenuPopup(Sender: TObject);
    procedure IntefaceRefreshTimer(Sender: TObject);
  private
    { Private declarations }

    IsActive: Boolean;
    IsRefreshInterface: Boolean;
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
  IsActive := not IsActive;
  Sql.Exec(' Update tTaskActive set IsActive = :IsActive ', ['IsActive'], [IsActive]);

  if IsActive then
    Audit.Add(TObjectType.otTask, 0, acOn , '')
  else
    Audit.Add(TObjectType.otTask, 0, acOff, '');

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

procedure TTask_T.DBAlertAlert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
//var
//	i: Integer;
//	sArgs: String;
begin
  logger.Info('TTask_T.DBAlertAlert Begin');
//	if VarIsArray(AArgument) then
//  begin
//		sArgs := '';
//		for i := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do
//    begin
//			if sArgs <> '' then
//				sArgs := sArgs + ', ';
//			sArgs := sArgs + VarToStr(AArgument[i]);
//		end;
//	end
//	else if VarIsNull(AArgument) then sArgs := '<NULL>'
//	else if VarIsEmpty(AArgument) then sArgs := '<UNASSIGNED>'
//	else sArgs := VarToStr(AArgument);
//	logger.Info('Event - [' + AEventName + '] - [' + sArgs + ']');

  if AEventName = 'IsActive' then
  begin
    IsRefreshInterface:=True;
  end;

  logger.Info('TTask_T.DBAlertAlert End');
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

procedure TTask_T.PopupMenuPopup(Sender: TObject);
begin
  SetTaskEnabledStatus;
end;

procedure TTask_T.SetTaskEnabledStatus;
begin
	logger.Info('TTask_T.SetTaskEnabledStatus Begin');

  Sql.Open(' Select IsActive from tTaskActive (nolock) ', [], []);

  IsActive := Sql.Q.FieldByName('IsActive').AsBoolean;

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

  logger.Info('TTask_T.SetTaskEnabledStatus End');
end;

procedure TTask_T.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  SetTaskEnabledStatus;

  DataRefresh;
end;

procedure TTask_T.UniFrameReady(Sender: TObject);
begin
  logger.Info('TTask_T.UniFrameReady Handle: ' + VarToStr(Self.Handle));

  DBAlert.Names.Clear;
  DBAlert.Names.Add('QUEUE=TaskManager');
 	DBAlert.Names.Add('SERVICE=TaskManager');
  DBAlert.Names.Add('CHANGE1=IsActive;select IsActive from dbo.tTaskActive');
	DBAlert.Options.Synchronize := True;
	DBAlert.Register;
end;

procedure TTask_T.IntefaceRefreshTimer(Sender: TObject);
begin
  if IsRefreshInterface then
  begin
    IsRefreshInterface := false;

    SetTaskEnabledStatus;
  end;
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
