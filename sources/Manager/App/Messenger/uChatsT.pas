unit uChatsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniBitBtn, uniDateTimePicker, uniEdit,
  uniMultiItem, uniComboBox, UniFSCombobox, uniLabel, uniButton,
  uniGUIBaseClasses, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  uniGridExporters, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uUniDateRangePicker, uUniADCheckComboBoxEx, System.Actions, Vcl.ActnList,
  uniMainMenu, Vcl.Menus, uniImageList, System.ImageList, Vcl.ImgList,
  uMessengerF;

type
  TChatsT = class(TUniFrame)
    UniPanel3: TUniPanel;
    btnGridStatisticOpen: TUniButton;
    fCancel: TUniBitBtn;
    Grid: TUniDBGrid;
    dsQuery: TDataSource;
    qQuery: TFDQuery;
    qQueryChatID: TFMTBCDField;
    qQuerySubject: TStringField;
    qQueryNumber: TStringField;
    qQueryInDateTime: TSQLTimeStampField;
    qQueryFlag: TIntegerField;
    qQueryStatusName: TStringField;
    qQueryClientName: TWideStringField;
    UniLabel1: TUniLabel;
    fClient: TUniADCheckComboBox;
    UniLabel3: TUniLabel;
    fStatus: TUniADCheckComboBox;
    edtSearch: TUniComboBox;
    qQueryUnReadMessages: TIntegerField;
    ppMain: TUniPopupMenu;
    N3: TUniMenuItem;
    N1: TUniMenuItem;
    N6: TUniMenuItem;
    actMain: TUniActionList;
    actMessages: TAction;
    actRefresh: TAction;
    UniImageList: TUniImageList;
    UniImageListAdapter: TUniImageListAdapter;
    procedure UniFrameCreate(Sender: TObject);
    procedure edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure btnGridStatisticOpenClick(Sender: TObject);
    procedure fCancelClick(Sender: TObject);
    procedure qQueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure actRefreshExecute(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actMessagesExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    /// <summary>
    /// GridOpen - получение данных с сервера
    /// </summary>
    procedure GridOpen; overload;
    procedure GridOpen(Key: Word); overload;
  end;

implementation

{$R *.dfm}

uses uUtils.Grid, uMainVar, uConstant;

procedure TChatsT.actMessagesExecute(Sender: TObject);
begin
   MessageF. := QueryOrderID.AsInteger;
   MessageF.ShowModal();
end;

procedure TChatsT.actRefreshExecute(Sender: TObject);
begin
  GridOpen;
end;

procedure TChatsT.btnGridStatisticOpenClick(Sender: TObject);
begin
  GridOpen;
end;

procedure TChatsT.edtOrderDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  GridOpen(Key);
end;

procedure TChatsT.fCancelClick(Sender: TObject);
begin
  edtSearch.Clear;
  fClient.ClearSelection;
  fStatus.ClearSelection;

  GridOpen;
end;

procedure TChatsT.GridOpen(Key: Word);
begin
  if (Key = 13) then
  begin
    GridOpen;
  end;
end;

procedure TChatsT.GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
begin
 // ACurrColumn := Column;

  ppMain.Popup(X, Y, Grid);
end;

procedure TChatsT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  if Direction then
    qQuery.IndexName := Column.FieldName+'_index_asc'
  else
    qQuery.IndexName := Column.FieldName+'_index_des';
end;

procedure TChatsT.GridOpen;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    qQuery.Close();

    qQuery.ParamByName('Clients').AsString := fClient.SelectedKeys;

    qQuery.ParamByName('Status').AsString := fStatus.SelectedKeys;

    qQuery.ParamByName('Number').AsString := edtSearch.Text;

    qQuery.Open();
  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TChatsT.qQueryFlagGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  var t: string;
begin
  t := '';
  if (qQueryUnReadMessages.AsInteger > 0) then
  begin
    t := t + '<span class="grid-order-message" data-qtip="Имеется непрочитанное сообщение от клиента"><i class="fa fa-bell"></i></span> ';
  end;

  Text := t;
end;

procedure TChatsT.UniFrameCreate(Sender: TObject);
begin

  ComboBoxFill(fClient,'''
    DECLARE @R table (ID numeric(18, 0), Brief varchar(256), Name varchar(256)) ;

    insert @R
    EXEC ChatsFilter_Client

    SELECT ID, Brief as Name from @R;
  ''');


  ComboBoxFill(fStatus,'''
    exec ChatsFilter_Status
  ''');

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

end;

procedure TChatsT.UniFrameDestroy(Sender: TObject);
begin
//  FClients.Free;
end;

initialization
  RegisterClass(TChatsT);

end.
