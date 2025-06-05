unit uClientsT;

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

  uUserF, uGrant, uCommonType, uUtils.Grid, uClientPasswordResetF;

type
  TClientsT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
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
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    QueryClientID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryName: TWideStringField;
    UpdateSQL: TFDUpdateSQL;
    UniHiddenPanel: TUniHiddenPanel;
    QueryinDatetime: TSQLTimeStampField;
    QueryupdDatetime: TSQLTimeStampField;
    QueryIsActive: TBooleanField;
    actLookup: TAction;
    N7: TUniMenuItem;
    QueryClientTypeName: TWideStringField;
    actBalance: TAction;
    actBalanceAdd: TAction;
    N8: TUniMenuItem;
    N9: TUniMenuItem;
    N10: TUniMenuItem;
    UniToolButton5: TUniToolButton;
    UniToolButton6: TUniToolButton;
    UniToolButton7: TUniToolButton;
    tbSeparator: TUniToolButton;
    UniToolButton9: TUniToolButton;
    actClientType: TAction;
    flClientBrief: TUniEdit;
    flClientID: TUniNumberEdit;
    actBalanceTotal: TAction;
    tbBalanceTotal: TUniToolButton;
    N11: TUniMenuItem;
    actClientAuthorizationClear: TAction;
    N12: TUniMenuItem;
    N13: TUniMenuItem;
    QueryRest: TCurrencyField;
    actPasswordReset: TAction;
    N14: TUniMenuItem;
    actApi: TAction;
    N15: TUniMenuItem;
    Api1: TUniMenuItem;
    actRestCalc: TAction;
    N16: TUniMenuItem;
    actLogger: TAction;
    N17: TUniMenuItem;
    QueryStatus: TIntegerField;
    ImageList: TUniNativeImageList;
    ImageList16: TUniNativeImageList;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure QueryAfterPost(DataSet: TDataSet);
    procedure actViewExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actLookupExecute(Sender: TObject);
    procedure actBalanceAddExecute(Sender: TObject);
    procedure actBalanceExecute(Sender: TObject);
    procedure actClientTypeExecute(Sender: TObject);
    procedure GridClearFilters(Sender: TObject);
    procedure GridColumnFilter(Sender: TUniDBGrid;
      const Column: TUniDBGridColumn; const Value: Variant);
    procedure actBalanceTotalExecute(Sender: TObject);
    procedure actClientAuthorizationClearExecute(Sender: TObject);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure actPasswordResetExecute(Sender: TObject);
    procedure actApiExecute(Sender: TObject);
    procedure actRestCalcExecute(Sender: TObject);
    procedure actLoggerExecute(Sender: TObject);
    procedure QueryStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FAction: Integer;
    procedure SetAction(const Value: Integer);

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure Refresh();
  public
    { Public declarations }
    /// <summary>
    ///  ClientCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure ClientCallBack(Sender: TComponent; AResult:Integer);

    procedure LoggerFCallBack(Sender: TComponent; AResult:Integer);

    procedure BalanceAddCallBack(Sender: TComponent; AResult:Integer);
    property FormAction: Integer read FAction write SetAction;
  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uClientsF, uLookupF, uBalanceAddF,
  uBalanceT, uClientsType2T, uBalanceTotalT_Wrapper, uToast, uBalanceTotalT, uAPIKeyT_Wrapper, uUploadingRefusals, uLoggerF, uConstant;

{$R *.dfm}

procedure TClientsT.actAddExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acInsert;
  ClientsF.ShowModal(ClientCallBack);
end;

procedure TClientsT.actApiExecute(Sender: TObject);
begin
  APIKeyT_W.ClientID:=QueryClientID.AsInteger;
  APIKeyT_W.ShowModal;
end;

procedure TClientsT.actBalanceAddExecute(Sender: TObject);
begin
  BalanceAddF.FormAction := TFormAction.acInsert;
  BalanceAddF.ClientID:=QueryClientID.AsInteger;

  BalanceAddF.ShowModal(BalanceAddCallBack);
end;

procedure TClientsT.actBalanceExecute(Sender: TObject);
begin
  BalanceT.ID:= QueryClientID.AsInteger;
  BalanceT.ShowModal;
end;

procedure TClientsT.actBalanceTotalExecute(Sender: TObject);
begin
  //Баланс и Отгрузки
  BalanceTotalT_W.ClientID:=QueryClientID.AsInteger;
  BalanceTotalT_W.ShowModal();
end;

procedure TClientsT.actClientAuthorizationClearExecute(Sender: TObject);
begin
  sql.Exec('exec ClientAuthorizationClear @ClientID = :ClientID', ['ClientID'], [QueryClientID.AsInteger]);

  ToastOK('Выполнено', UniSession);
end;

procedure TClientsT.actClientTypeExecute(Sender: TObject);
begin
  ClientType2T.ShowModal;
end;

procedure TClientsT.actDeleteExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acDelete;
  ClientsF.ID:=QueryClientID.AsInteger;
  ClientsF.ShowModal(ClientCallBack);
end;

procedure TClientsT.actEditExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acUpdate;
  ClientsF.ID:=Grid.Columns.ColumnFromFieldName('ClientID').Field.Value;
  ClientsF.ShowModal(ClientCallBack);
end;

procedure TClientsT.actLoggerExecute(Sender: TObject);
begin
  LoggerF.UserID := Grid.Columns.ColumnFromFieldName('ClientID').Field.Value;
  LoggerF.AppName:= AppCustomer;
  LoggerF.ShowModal(LoggerFCallBack);
end;

procedure TClientsT.actLookupExecute(Sender: TObject);
var //BM : TBookmark;
    i:Integer;
begin
  if Grid.SelectedRows.Count>0 then
  begin
    // BM := FGrid.DataSource.DataSet.GetBookmark;
     try
        for I := 0 to Grid.SelectedRows.Count - 1 do
        begin
          Grid.DataSource.DataSet.Bookmark := Grid.SelectedRows[I];
          (Self.Parent as TLookupF).ID.Add(Grid.DataSource.DataSet.FieldByName('ClientID').AsString);
        end;
     finally
     //  FGrid.DataSource.DataSet.GotoBookmark(BM);
     //  FGrid.DataSource.DataSet.FreeBookmark(BM);
     end;
  end
  else
  begin
    (Self.Parent as TLookupF).ID.Add(QueryClientID.AsString);
  end;

  (Self.Parent as TLookupF).ModalResult := mrOk;
end;

procedure TClientsT.actPasswordResetExecute(Sender: TObject);
begin
  ClientPasswordResetF.ClientID:=QueryClientID.AsInteger;
  ClientPasswordResetF.ShowModal;
end;

procedure TClientsT.actRefreshAllExecute(Sender: TObject);
begin
  Refresh;
end;

procedure TClientsT.actRestCalcExecute(Sender: TObject);
begin
  ShowMask('Выполняется: Пересчет балансов по клиентам');
  UniSession.Synchronize;
  try
    sql.Exec('exec RestCalcMassAll', [], []);

    ToastOK('Выполнено', UniSession);
  finally
    HideMask();
    UniSession.Synchronize
  end;

end;

procedure TClientsT.actViewExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acShow;
  ClientsF.ID:=QueryClientID.AsInteger;
end;

procedure TClientsT.BalanceAddCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if BalanceAddF.FormAction = acInsert then
  begin
    Query.RefreshRecord();
    Grid.Refresh();
  end;
end;

procedure TClientsT.ClientCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if ClientsF.FormAction = acInsert then
  begin
    Query.Refresh;
  end;
  if ClientsF.FormAction = acUpdate then
  begin
    Query.RefreshRecord();

    Grid.Refresh();
  end;
  if ClientsF.FormAction = acDelete then
  begin
    Query.Delete;
  end;
end;

procedure TClientsT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TClientsT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TClientsT.GridClearFilters(Sender: TObject);  var i: Integer;
begin
  if Query.Active then
  begin
    for I := 0 to Query.Params.Count-1 do
      Query.Params[I].Value:=null;

    Query.Refresh;
  end;
end;

procedure TClientsT.GridColumnFilter(Sender: TUniDBGrid;
  const Column: TUniDBGridColumn; const Value: Variant);
begin
  if Query.Active then
  begin
    if (Column.Field.DataType in [TFieldType.ftBoolean, TFieldType.ftFMTBcd]) then  // boolean
      Query.Params.ParamValues[Column.FieldName]:=Value
    else
      Query.Params.ParamValues[Column.FieldName]:='%'+Value+'%';

    Query.Refresh();
  end;
end;

procedure TClientsT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TClientsT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
 GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TClientsT.GridColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TClientsT.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TClientsT.LoggerFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult= mrOK then
  begin
    Query.RefreshRecord();
    Grid.RefreshCurrentRow();
  end;
end;

procedure TClientsT.QueryAfterPost(DataSet: TDataSet);
begin
  if FAction = Integer(acInsert) then  Query.Refresh;
end;

procedure TClientsT.QueryStatusGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);

begin
  if (Sender.AsInteger and 1) > 0 then
  begin
    Text := '<span class="logger-enabled" data-qtip="Включено логирование"><i class="fa fa-bug"></i></span> ';
  end;
  if (Sender.AsInteger and 2) > 0 then
  begin
    Text := Text + '<span class="pass-lock" data-qtip="Доступ заблокирован из-за превышения попыток ввода пароля"><i class="fa fa-lock"></i></span> ';
  end;
end;

procedure TClientsT.Refresh;
begin
  Query.Close;
  Query.Open;
end;

procedure TClientsT.SetAction(const Value: Integer);
begin
  FAction := Value;

  actLookup.Visible :=(TFormAction(FAction) = acLookup) and (Query.RecordCount >0);

  if TFormAction(FAction) = acLookup then
  begin
    Grid.Options := Grid.Options + [dgRowSelect, dgCheckSelect, dgMultiSelect];

    Grid.JSInterface.JSAddListener('beforerender',
      '''
        function beforerender(sender, eOpts)
        {
            var me=sender.checkboxModel;
            if (me) {
                me.showHeaderCheckbox=true;
            }
        }
      ''');

  end;
end;

procedure TClientsT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TClientsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);


  Grid.ReadOnly := not actEdit.Enabled;
  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  Refresh;
end;

initialization
  RegisterClass(TClientsT);
end.
