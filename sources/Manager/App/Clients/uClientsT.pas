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

  uUserF, uGrant, uCommonType;

type
  TClientsT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
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
    UniToolButton8: TUniToolButton;
    QuerySupplier: TWideStringField;
    UniToolButton9: TUniToolButton;
    actClientType: TAction;
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
  private
    { Private declarations }
    FAction: Integer;
    procedure SetAction(const Value: Integer);
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);
    property FormAction: Integer read FAction write SetAction;
  end;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uClientsF, uLookupF, uBalanceAddF, uBalanceT, uClientsType2T;

{$R *.dfm}

procedure TClientsT.actAddExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acInsert;
  ClientsF.ShowModal(UserFCallBack);
end;

procedure TClientsT.actBalanceAddExecute(Sender: TObject);
begin
  BalanceAddF.FormAction := TFormAction.acInsert;
  BalanceAddF.ClientID:=QueryClientID.AsInteger;
 // BalanceAddF.ShowModal(UserFCallBack);
end;

procedure TClientsT.actBalanceExecute(Sender: TObject);
begin
  BalanceT.ID:= QueryClientID.AsInteger;
  BalanceT.ShowModal;
end;

procedure TClientsT.actClientTypeExecute(Sender: TObject);
begin
  ClientType2T.ShowModal;
end;

procedure TClientsT.actDeleteExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acDelete;
  ClientsF.ID:=QueryClientID.AsInteger;
  ClientsF.ShowModal(UserFCallBack);
end;

procedure TClientsT.actEditExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acUpdate;
  ClientsF.ID:=QueryClientID.AsInteger;
  ClientsF.ShowModal(UserFCallBack);
end;

procedure TClientsT.actLookupExecute(Sender: TObject);
var BM : TBookmark;
    i, id:Integer;
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

procedure TClientsT.actRefreshAllExecute(Sender: TObject);
begin
  Query.Close();
  Query.Open();
end;

procedure TClientsT.actViewExecute(Sender: TObject);
begin
  ClientsF.FormAction := TFormAction.acShow;
  ClientsF.ID:=QueryClientID.AsInteger;
  ClientsF.ShowModal(UserFCallBack);
end;

procedure TClientsT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
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

procedure TClientsT.QueryAfterPost(DataSet: TDataSet);
begin
  if FAction = Integer(acInsert) then  Query.Refresh;
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

procedure TClientsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);


  Grid.ReadOnly := not actEdit.Enabled;

  Query.Close;
  Query.Open;
end;

procedure TClientsT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  if ClientsF.FormAction = acInsert then
  begin
    Query.Refresh();
  end;
  if ClientsF.FormAction = acUpdate then
  begin
    Query.Refresh();
  end;
  if ClientsF.FormAction = acDelete then
  begin
    Query.Refresh();
  end;
end;

initialization
  RegisterClass(TClientsT);
end.
