unit uShipmentsT;

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

  uUserF, uGrant, uCommonType, uniButton, uniBitBtn, uniLabel, uniDBComboBox,
  uniGroupBox, uniDBLookupComboBox, Vcl.StdActns, Vcl.StdCtrls, Vcl.Clipbrd,

  uAccrualUtils, uniSweetAlert, unimSelect, unimDBSelect, uniSegmentedButton,

  System.Generics.Collections, System.MaskUtils, uniFileUpload,
  uniDateTimePicker, uniGridExporters, uniMenuButton;



type

  tMarks = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FGrid: TUniDBGrid;

    FMarks: TDictionary <Integer, Integer>;

    procedure DeleteInDB();
    function GetCount: Integer;

    property Count: Integer read GetCount;
  public
    constructor Create(AGrid: TUniDBGrid);
    destructor Destroy; override;

    /// <summary>
    ///  Select - сохранение отметок в БД
    ///</summary>
    procedure Select();
    procedure Clear();


    procedure DataRefresh();
  end;

  TShipmentsT = class(TUniFrame)
    Query: TFDQuery;
    DataSource: TDataSource;
    actMain: TUniActionList;
    ppMain: TUniPopupMenu;
    actRefreshAll: TAction;
    N6: TUniMenuItem;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UpdateSQL: TFDUpdateSQL;
    pFilter: TUniPanel;
    gbFilter: TUniGroupBox;
    UniImageListAdapter: TUniImageListAdapter;
    UniImageList: TUniImageList;
    UniImageList32: TUniImageList;
    actFilter: TAction;
    actFilterClear: TAction;
    actGridSettingLoad: TAction;
    actGridSettingSave: TAction;
    actGridSettingDefault: TAction;
    N7: TUniMenuItem;
    N8: TUniMenuItem;
    N9: TUniMenuItem;
    N11: TUniMenuItem;
    pnlGridSelectedCount: TUniPanel;
    UniPanel3: TUniPanel;
    lblSelRowCunt: TUniLabel;
    UniPanel4: TUniPanel;
    lblSelRowSum: TUniLabel;
    UniPanel5: TUniPanel;
    lblRowSum2: TUniLabel;
    lblRowSum1: TUniLabel;
    UniLabel7: TUniLabel;
    lblWeightKG: TUniLabel;
    lblVolumeKG: TUniLabel;
    fCancel: TUniBitBtn;
    fOk: TUniBitBtn;
    fShipmentsDate: TUniDateTimePicker;
    UniLabel8: TUniLabel;
    edtInvoice: TUniEdit;
    UniLabel4: TUniLabel;
    N1: TUniMenuItem;
    actExportData: TAction;
    N2: TUniMenuItem;
    QueryShipmentsID: TFMTBCDField;
    QueryShipmentsDate: TSQLTimeStampField;
    QueryReceiptDate: TSQLTimeStampField;
    QueryInvoice: TWideStringField;
    QueryShipmentsType: TWideStringField;
    QueryShipmentsAmount: TCurrencyField;
    QueryDetailCount: TIntegerField;
    QueryWeightKG: TCurrencyField;
    QueryVolumeKG: TCurrencyField;
    QueryWeightKGDiff: TCurrencyField;
    QueryWeightKGF: TCurrencyField;
    QueryVolumeKGF: TCurrencyField;
    QueryVolumeKGDiff: TCurrencyField;
    QueryAmount: TCurrencyField;
    QuerySupplierWeightKG: TCurrencyField;
    QuerySupplierVolumeKG: TCurrencyField;
    QuerySupplierDiffVolumeWeigh: TCurrencyField;
    QuerySupplierAmount: TCurrencyField;
    QueryTransporterWeightKG: TCurrencyField;
    QueryTransporterVolumeKG: TCurrencyField;
    QueryTransporterDiffVolumeWeigh: TCurrencyField;
    QueryTransporterAmount: TCurrencyField;
    QueryWeightKGAmount: TCurrencyField;
    QueryVolumeKGAmount: TCurrencyField;
    QueryupdDatetime: TSQLTimeStampField;
    QuerySupplierBrief: TWideStringField;
    QueryShipmentsAmountR: TCurrencyField;
    QueryTransporterNumber: TWideStringField;
    QueryStatusName: TWideStringField;
    actSetTransporterNumber: TAction;
    actSetReceiptDate: TAction;
    actSetReceivedStatus: TAction;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N10: TUniMenuItem;
    QueryReceiptDate2: TSQLTimeStampField;
    actSetTransporterData: TAction;
    N12: TUniMenuItem;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure GridSelectionChange(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridCellClick(Column: TUniDBGridColumn);
    procedure ppMainPopup(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actFilterClearExecute(Sender: TObject);

    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure actGridSettingLoadExecute(Sender: TObject);
    procedure actGridSettingSaveExecute(Sender: TObject);
    procedure actGridSettingDefaultExecute(Sender: TObject);
    procedure fClientSelect(Sender: TObject);
    procedure actExportDataExecute(Sender: TObject);
    procedure actSetTransporterNumberExecute(Sender: TObject);
    procedure actSetReceiptDateExecute(Sender: TObject);
    procedure QueryReceiptDateGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actSetReceivedStatusExecute(Sender: TObject);
    procedure actSetTransporterDataExecute(Sender: TObject);

  private
    { Private declarations }
    FAction: tFormaction;
    FAccrual: TAccrual;

    FFilterTextStatus: string;
    FFilterTextPriceLogo: string;
    FFilterTextClient: string;

    ACurrColumn: TUniDBGridColumn;
    FID: Integer;  //текущая колонка

    Marks: TMarks;                  // отметки

    /// <summary>
    /// GridOpen -
    /// </summary>
    procedure GridOpen;

    procedure DoShowMask();
    procedure DoHideMask();

    function Accrual :TAccrual;

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure FilterStatusCreate();
    procedure FilterPriceLogoCreate();
    procedure FilterClientsCreate();

    procedure ShipmentsTransporterNumberFCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }



    /// <summary>
    ///  GridLayout - сохранение/восстановление настроек грида
    ///  AOperation 0-сохранение
    ///             1-восстановление
    ///</summary>
    procedure GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
  end;

implementation

uses
  MainModule, uGrantUtils, uSqlUtils, uLogger, uMainVar,
  Main, ServerModule, uToast, uGridUtils, uExportForm, uShipmentsTransporterNumberF, uShipmentsReceiptDateF,
  uShipmentsReceiptStatusF, uShipmentsTransporterDataF;

{$R *.dfm}

function TShipmentsT.Accrual: TAccrual;
begin
  if not Assigned(FAccrual) then
  begin
    FAccrual := TAccrual.Create(TFDConnection(Query.Connection));
  end;

  Result := FAccrual;
end;

procedure TShipmentsT.actDeleteExecute(Sender: TObject);
begin
  FAction:=TFormAction.acDelete;
  Query.Delete;
end;

procedure TShipmentsT.actExportDataExecute(Sender: TObject);
begin
  ExportForm.Invoice := QueryInvoice.Value;
  ExportForm.ShowModal;
end;

procedure TShipmentsT.actFilterClearExecute(Sender: TObject);
begin
  edtInvoice.Clear;
  fShipmentsDate.Text := '';
  GridOpen();
end;

procedure TShipmentsT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TShipmentsT.actGridSettingDefaultExecute(Sender: TObject);
begin
  Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[self.ClassName +'.' + Grid.Name]);
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TShipmentsT.actGridSettingLoadExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TShipmentsT.actGridSettingSaveExecute(Sender: TObject);
begin
  GridLayout(Self, Grid, tGridLayout.glSave);
end;


procedure TShipmentsT.actRefreshAllExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TShipmentsT.actSetReceiptDateExecute(Sender: TObject);
begin
  ShipmentsReceiptDateF.FormAction := TFormAction.acUpdate;
  ShipmentsReceiptDateF.ID:=QueryShipmentsID.AsInteger;

  ShipmentsReceiptDateF.ShowModal(ShipmentsTransporterNumberFCallBack);
end;

procedure TShipmentsT.actSetReceivedStatusExecute(Sender: TObject);
begin
  ShipmentsReceivedStatusF.FormAction := TFormAction.acUpdate;
  ShipmentsReceivedStatusF.ID:=QueryShipmentsID.AsInteger;

  ShipmentsReceivedStatusF.ShowModal(ShipmentsTransporterNumberFCallBack);
end;

procedure TShipmentsT.actSetTransporterDataExecute(Sender: TObject);
begin
  ShipmentsTransporterDataF.FormAction := TFormAction.acUpdate;
  ShipmentsTransporterDataF.ID:=QueryShipmentsID.AsInteger;

  ShipmentsTransporterDataF.ShowModal(ShipmentsTransporterNumberFCallBack);
end;

procedure TShipmentsT.actSetTransporterNumberExecute(Sender: TObject);
begin
  ShipmentsTransporterNumberF.FormAction := TFormAction.acUpdate;
  ShipmentsTransporterNumberF.edtNumS.Caption := QuerySupplierBrief.AsString;
  ShipmentsTransporterNumberF.ID:=QueryShipmentsID.AsInteger;

  ShipmentsTransporterNumberF.ShowModal(ShipmentsTransporterNumberFCallBack);
end;

procedure TShipmentsT.DoHideMask;
begin
//  UniToolButton5.HideMask();
//  UniSession.Synchronize;
end;

procedure TShipmentsT.DoShowMask;
begin
//  UniToolButton5.ShowMask('');
//  UniSession.Synchronize;
end;

procedure TShipmentsT.fClientSelect(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s:= '';
  FFilterTextClient := '';

  for i:= 0 to (Sender as TUniCheckComboBox).Items.Count-1 do
  begin
    if (Sender as TUniCheckComboBox).Selected[i] = True then
    begin
      s:= s + integer((Sender as TUniCheckComboBox).Items.Objects[i]).ToString +',';
    end;
  end;

  if (s<> '') and  (s[length(s)]=',') then
    delete(s,length(s),1);

  FFilterTextClient := s;
  GridOpen;
  logger.Info('FFilterTextClient: ' + FFilterTextClient);
end;

procedure TShipmentsT.FilterClientsCreate;
begin

end;

procedure TShipmentsT.FilterPriceLogoCreate;
begin

end;

procedure TShipmentsT.FilterStatusCreate;
begin

end;


procedure TShipmentsT.GridOpen;
var FClient:string;
    FStatus :string;
    FPriceLogo :string;
begin
  logger.Info('TOrdersT.GridOpen Begin');
  DoShowMask;
  try
    Query.Close();

    if edtInvoice.Text <> '' then
      Query.MacroByName('Invoice').Value := ' and Invoice like ''%'   + edtInvoice.Text + '%'''
    else
      Query.MacroByName('Invoice').Value := '';

    if (fShipmentsDate.Text <> '') and (fShipmentsDate.Text <> '30.12.1899') then
      Query.MacroByName('ShipmentsDate').Value := ' and cast(ShipmentsDate as date) = '''   + FormatDateTime('yyyymmdd', fShipmentsDate.DateTime) + ''''
    else
      Query.MacroByName('ShipmentsDate').Value := '';

    Query.Open();

  finally
    DoHideMask();
    logger.Info('TOrdersT.GridOpen End');
  end;
end;

procedure TShipmentsT.GridSelectionChange(Sender: TObject);
begin
  //logger.Info('TOrdersT.GridSelectionChange Begin');

 // Marks.Select;

 // GetMarksInfo;

 // ActionExecuteEnabled;

 // logger.Info('TOrdersT.GridSelectionChange End');
end;


procedure TShipmentsT.ppMainPopup(Sender: TObject);
begin
//  actProtocol.Enabled := (actProtocol.Tag=1) and (Query.RecordCount>0);
//
//  actGroupDetailNameEdit.Enabled := (actGroupDetailNameEdit.Tag=1) and (Marks.Count>0);


  actSetTransporterNumber.Enabled := (actSetTransporterNumber.Tag=1) and (Query.RecordCount>0);

  actSetReceiptDate.Enabled := (actSetReceiptDate.Tag=1) and (Query.RecordCount>0);
end;

procedure TShipmentsT.QueryReceiptDateGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin // Ожидаемая дата поступления
  if (not QueryReceiptDate2.IsNull) then
  begin
    Text := '<span>' + Sender.AsString +  '</span><br><span class="x-receipt-date-arrow">&#10149;'+
            '</span><span class="x-receipt-date">' + QueryReceiptDate2.AsString + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TShipmentsT.GridCellClick(Column: TUniDBGridColumn);
begin
//  ACurrColumn := Column;
end;

procedure TShipmentsT.GridCellContextClick(Column: TUniDBGridColumn; X,Y: Integer);
begin
//  ACurrColumn := Column;

  ppMain.Popup(X, Y, Grid);
end;

procedure TShipmentsT.GridLayout(AForm:TObject; AGrid: TUniDBGrid; AOperation: tGridLayout; AShowResultMessage:Boolean = True);
var
  i: integer;
  SqlText: string;
  Column: TUniBaseDBGridColumn;
begin
  if not (AGrid is TUniDBGrid) then Exit;

  if AOperation=tGridLayout.glSave then
    for i := 0 to AGrid.Columns.count-1 do
    begin
      Sql.Exec('delete tGridOptions from tGridOptions (rowlock) where UserID = dbo.GetUserID() and Grid =:Grid', ['Grid'],[AForm.ClassName +'.' + AGrid.Name]);
      if i = 0 then
        SqlText:= SqlText + ' Insert into tGridOptions (UserID, Grid, [Column], Position, Width, Visible) '
      else
        SqlText:= SqlText + ' Union all ';

       SqlText:= SqlText +
       Format ('select dbo.GetUserID(), ''%s'', ''%s'', %d, %d, %d',
       [AForm.ClassName +'.' + AGrid.Name,
        AGrid.Columns[i].FieldName,
        AGrid.Columns[i].Index,
        AGrid.Columns[i].Width,
        AGrid.Columns[i].Visible.ToInteger
        //AGrid.Columns[i].Locked.ToInteger Locking
        ]);

        logger.Info(SqlText);
        Sql.Exec(SqlText,[],[]);
    end
  else
  if AOperation=tGridLayout.glLoad then
  begin
    Sql.Q.Close;
    Sql.Open('select * '+
             '  from tGridOptions (nolock) '+
             ' where UserID = dbo.GetUserID() '+
             '   and Grid =:Grid '+
             ' order by Position ',
            ['Grid'], [AForm.ClassName +'.' + AGrid.Name]);
    Sql.Q.First;
    for i:= 0 to Sql.Q.RecordCount-1 do
    begin

     try
       Column := AGrid.Columns.ColumnFromFieldName(Sql.Q.FieldByName('Column').AsString);
       Column.Index  := Sql.Q.FieldByName('Position').AsInteger;
       Column.Width  := Sql.Q.FieldByName('Width').AsInteger;
       Column.Visible:= Sql.Q.FieldByName('Visible').AsBoolean;
     // Column.Locked := Sql.Q.FieldByName('Locking').AsBoolean;

     except
       on E: Exception do
       begin
         logger.Info('TOrdersT.GridLayout Ошибка: ' + e.Message);
         logger.Info('TOrdersT.GridLayout Column: ' + Sql.Q.FieldByName('Column').AsString);
       end;
     end;
      Sql.Q.Next;
    end;
  end;

  if AShowResultMessage = True then
    ToastOK ('Успешно выполнено!', unisession);
end;

procedure TShipmentsT.ShipmentsTransporterNumberFCallBack(Sender: TComponent;
  AResult: Integer);
begin
  Query.RefreshRecord(False) ;
  Grid.RefreshCurrentRow();
end;

procedure TShipmentsT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TShipmentsT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TShipmentsT.UniFrameCreate(Sender: TObject);
var
  I: Integer;
  IndexnameAsc : string;
  IndexnameDes : string;
begin
  logger.Info('TShipmentsT.UniFrameCreate Begin');

  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}

  Grant.SetGrant(self, actMain);

  fShipmentsDate.Text := '';

//  Grid.WebOptions.PageSize := sql.GetSetting('OrdersGridRowCount', 100);

//  fOrderDate.Text := '';
//
//  FilterStatusCreate;
//  FilterPriceLogoCreate();
//  FilterClientsCreate();

 // qPriceLogo.Open();
 // qClient.Open();

  GridOpen;

  // индексы для сортировки
  //with Query do
  GridExt.SortColumnCreate(Grid);;


//  {$IFDEF Release}
//  {$ENDIF}

  // восстановление настроек грида для пользователя
  GridLayout(Self, Grid, tGridLayout.glLoad, False);


  // объект для упраления метками
//  Marks := tMarks.Create(Grid);
//  Marks.Clear;

  //GetMarksInfo;

  logger.Info('TShipmentsT.UniFrameCreate End');
end;


procedure TShipmentsT.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;


{ tMarks }

constructor tMarks.Create(AGrid: TUniDBGrid);
begin
    if Assigned(AGrid) then
    begin
        FConnection := TFDConnection(TFDQuery(AGrid.DataSource.DataSet).Connection);
        FQuery := TFDQuery.Create(nil);
        FQuery.Connection := FConnection;
        FGrid := AGrid;
    end;
    FMarks := TDictionary <integer, integer>.Create();
end;

procedure tMarks.DataRefresh;
var Key: Integer;
    BM : TBookmark;
begin
  logger.Info('tMarks.DataRefresh Begin');
  begin
      FGrid.DataSource.DataSet.DisableControls;
      BM := FGrid.DataSource.DataSet.GetBookmark;
      try
          for Key in FMarks.Keys  do
          begin
              if FGrid.DataSource.DataSet.Locate('OrderID', Key, [loCaseInsensitive, loPartialKey]) then
              begin
                  tFDQuery(FGrid.DataSource.DataSet).RefreshRecord(False) ;
                  FGrid.RefreshCurrentRow();
              end;
          end;
      finally
          FGrid.DataSource.DataSet.GotoBookmark(BM);
          FGrid.DataSource.DataSet.FreeBookmark(BM);
          FGrid.DataSource.DataSet.EnableControls;
      end;
  end;
  logger.Info('tMarks.DataRefresh End');
end;

procedure tMarks.DeleteInDB();
begin
    Sql.Exec('Delete tMarks from tMarks (rowlock) where Spid=@@Spid and Type=3', [], [])
end;

procedure tMarks.Clear;
begin
    DeleteInDB();
    FMarks.Clear;
end;

destructor tMarks.Destroy;
begin
   FMarks.Free;
   inherited;
end;

function tMarks.GetCount: Integer;
begin
    Result := FMarks.Count;
end;

procedure tMarks.Select();
var i, id:Integer;
    SqlText: string;
    BM : TBookmark;
begin
  logger.Info('tMarks.Select Begin');

  SqlText:='';
  Clear;

  if FGrid.SelectedRows.Count>0 then
  begin
    BM := FGrid.DataSource.DataSet.GetBookmark;
    try
      for I := 0 to FGrid.SelectedRows.Count - 1 do
      begin
        FGrid.DataSource.DataSet.Bookmark := FGrid.SelectedRows[I];
        id := FGrid.DataSource.DataSet.FieldByName('OrderID').AsInteger;
        FMarks.Add(id, id);
        if i = 0 then
          SqlText:= SqlText + ' Insert into tMarks (Spid, Type, ID) select @@Spid, 3, '
        else
          SqlText:= SqlText + ' Union all select @@Spid, 3, ';

        SqlText:= SqlText + id.ToString;
      end;
      if SqlText <> '' then Sql.Exec(SqlText ,[], []);

    finally
      FGrid.DataSource.DataSet.GotoBookmark(BM);
      FGrid.DataSource.DataSet.FreeBookmark(BM);
    end;
  end;
  logger.Info('tMarks.Select End');
end;

initialization
  RegisterClass(TShipmentsT);
end.
