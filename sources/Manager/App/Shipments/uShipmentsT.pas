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
  uniDateTimePicker, uniGridExporters, uniMenuButton, uConstant,
  uShipmentsBoxesT_Wrapper, uUniExCheckComboBoxHelper, uUniExCheckComboBox,
  uUtils.Mark, uFragileT_Wrapper;



type
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
    actFilter: TAction;
    actFilterClear: TAction;
    actGridSettingDefault: TAction;
    N7: TUniMenuItem;
    N11: TUniMenuItem;
    pnlGridSelectedCount: TUniPanel;
    UniPanel3: TUniPanel;
    lblSelRowCunt: TUniLabel;
    UniPanel4: TUniPanel;
    lblSelRowSum: TUniLabel;
    lblRowSum2: TUniLabel;
    lblRowSum1: TUniLabel;
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
    actProtocol: TAction;
    N13: TUniMenuItem;
    N14: TUniMenuItem;
    UniLabel3: TUniLabel;
    N15: TUniMenuItem;
    actDataEdit: TAction;
    N16: TUniMenuItem;
    QueryDeliverySumF: TCurrencyField;
    QueryAmountF: TCurrencyField;
    edtTransporterNumber: TUniEdit;
    UniLabel1: TUniLabel;
    actShipmentsBoxes: TAction;
    N17: TUniMenuItem;
    QueryFlag: TIntegerField;
    lblStatys: TUniLabel;
    fStatus2: TUniExCheckComboBox;
    edtBox: TUniEdit;
    UniLabel2: TUniLabel;
    actFrigileData: TAction;
    N8: TUniMenuItem;
    fSupplier: TUniExCheckComboBox;
    procedure UniFrameCreate(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X, Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure GridSelectionChange(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ppMainPopup(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actFilterClearExecute(Sender: TObject);

    procedure GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure actGridSettingDefaultExecute(Sender: TObject);
    procedure actExportDataExecute(Sender: TObject);
    procedure actSetTransporterNumberExecute(Sender: TObject);
    procedure actSetReceiptDateExecute(Sender: TObject);
    procedure QueryReceiptDateGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure actSetReceivedStatusExecute(Sender: TObject);
    procedure actSetTransporterDataExecute(Sender: TObject);
    procedure actProtocolExecute(Sender: TObject);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure UniFrameReady(Sender: TObject);
    procedure actDataEditExecute(Sender: TObject);
    procedure actShipmentsBoxesExecute(Sender: TObject);
    procedure QueryFlagGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure UniFrameDestroy(Sender: TObject);
    procedure actFrigileDataExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);

  private
    { Private declarations }
    FAction: tFormaction;
//    FAccrual: TAccrual;

//    ACurrColumn: TUniDBGridColumn;
//    FID: Integer;  //текущая колонка

    Marks: TMarks;                  // отметки

    /// <summary>GetMarksInfo - получение информации по выделенным строкам (сумма, количество)</summary>
    procedure GetMarksInfo();

    /// <summary>
    /// GridOpen -
    /// </summary>
    procedure GridOpen;

    procedure DoShowMask();
    procedure DoHideMask();

    procedure SortColumn(const FieldName: string; Dir: Boolean);

    procedure FilterSupplierCreate();

    procedure ShipmentsTransporterNumberFCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }
  end;

implementation

uses
  MainModule, uGrantUtils, uSqlUtils, uMainVar,
  Main, ServerModule, uToast, uUtils.Grid, uExportForm,
  uShipmentsTransporterNumberF, uShipmentsReceiptDateF,
  uShipmentsReceiptStatusF, uShipmentsTransporterDataF, uShipmentsProtocol_T,
  uShipmentsEditF;

{$R *.dfm}


procedure TShipmentsT.actDataEditExecute(Sender: TObject);
begin
  ShipmentsEditF.ID:= Integer(QueryShipmentsID.Value);
  ShipmentsEditF.FormAction := acUpdate;
  ShipmentsEditF.ShowModal(ShipmentsTransporterNumberFCallBack);
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
  edtBox.Clear;
  fShipmentsDate.DateTime := nulldate;
  fSupplier.ClearSelection;
  edtTransporterNumber.Clear;
  fStatus2.ClearSelection;

  GridOpen();
end;

procedure TShipmentsT.actFilterExecute(Sender: TObject);
begin
  GridOpen();
end;

procedure TShipmentsT.actFrigileDataExecute(Sender: TObject);
begin
  FragileT_Wrapper.ShowModal;
end;

procedure TShipmentsT.actGridSettingDefaultExecute(Sender: TObject);
begin
  GridExt.GridLayoutDefault(Self, Grid);
  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);
end;

procedure TShipmentsT.actProtocolExecute(Sender: TObject);
begin
  ShipmentsProtocol_T.ID:= Integer(QueryShipmentsID.Value);
  ShipmentsProtocol_T.ShowModal;
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

procedure TShipmentsT.actShipmentsBoxesExecute(Sender: TObject);
begin
  ShipmentsBoxesT_Wrapper.Invoice:=QueryInvoice.Value;
  ShipmentsBoxesT_Wrapper.TransporterNumber:=QueryTransporterNumber.Value;
  ShipmentsBoxesT_Wrapper.ShowModal;
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

procedure TShipmentsT.FilterSupplierCreate;
begin
  fSupplier.FillFromSQL('select SuppliersID as ID, Brief as Name from tSuppliers (nolock) where SuppliersID<>8');
end;

procedure TShipmentsT.GridOpen;
begin
  DoShowMask;
  try
    Query.Close();

    Query.ParamByName('TransporterNumber').Value := Trim(edtTransporterNumber.Text);
    Query.ParamByName('Invoice').Value := Trim(edtInvoice.Text);
    Query.ParamByName('Box').Value := Trim(edtBox.Text);

    Query.ParamByName('Status').Value := fStatus2.SelectedKeys;
    Query.ParamByName('Supplier').Value := fSupplier.SelectedKeys; // поставщик

    if (fShipmentsDate.Text <> '') and (fShipmentsDate.Text <> '30.12.1899') then
      Query.ParamByName('ShipmentsDate').Value := FormatDateTime('yyyymmdd', fShipmentsDate.DateTime)
    else
      Query.ParamByName('ShipmentsDate').Value := '';

    Query.Open();

  finally
    DoHideMask();
  end;
end;

procedure TShipmentsT.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;

  GetMarksInfo;

 // ActionExecuteEnabled;
end;


procedure TShipmentsT.ppMainPopup(Sender: TObject);
begin
//  actProtocol.Enabled := (actProtocol.Tag=1) and (Query.RecordCount>0);
//
//  actGroupDetailNameEdit.Enabled := (actGroupDetailNameEdit.Tag=1) and (Marks.Count>0);


  actSetTransporterNumber.Enabled := (actSetTransporterNumber.Tag=1) and (Query.RecordCount>0);

  actSetReceiptDate.Enabled := (actSetReceiptDate.Tag=1) and (Query.RecordCount>0);

  actShipmentsBoxes.Enabled := (actShipmentsBoxes.Tag=1) and (Query.RecordCount>0) and ((QueryFlag.Value and 1) = 1);


  N3.Enabled := ((QueryFlag.Value and 2) = 0);
  N16.Enabled := ((QueryFlag.Value and 2) = 0);
  N2.Enabled := ((QueryFlag.Value and 2) = 0);
  N8.Enabled := ((QueryFlag.Value and 2) = 0);
  N13.Enabled := ((QueryFlag.Value and 2) = 0);
end;

procedure TShipmentsT.QueryFlagGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
var t: string;
begin
  t := '';

  if (Sender.AsInteger and 1) > 0 then
  begin
    t := t + '<span class="" data-qtip="Загружена информаци о коробках"><i class="shipments-box"></i></span> ';
  end;

  Text := t;
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

procedure TShipmentsT.GetMarksInfo;
begin
  lblSelRowCunt.Caption := 'Выделено строк: ' + Grid.SelectedRows.Count.ToString + '  ';

  if Marks.Count > 0 then
  begin
    Marks.SaveMarksToDB;

    Sql.Open('Select ShipmentsAmount, ShipmentsAmountR from vShipmentsMarkSum', [], []);

    lblRowSum1.Caption := FormatFloat('###,##0.00 ₽', Sql.Q.FieldByName('ShipmentsAmountR').AsFloat );
    lblRowSum2.Caption := FormatFloat('###,##0.00 $', Sql.Q.FieldByName('ShipmentsAmount').AsFloat);
  end
  else
  begin
    lblRowSum1.Caption := '0 ₽';
    lblRowSum2.Caption := '0 $';
  end;
end;

procedure TShipmentsT.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TShipmentsT.GridCellContextClick(Column: TUniDBGridColumn; X,Y: Integer);
begin
//  ACurrColumn := Column;

  ppMain.Popup(X, Y, Grid);
end;

procedure TShipmentsT.ShipmentsTransporterNumberFCallBack(Sender: TComponent;
  AResult: Integer);
begin
  if AResult <> mrOK then Exit;

  Query.RefreshRecord(False) ;
  Grid.RefreshCurrentRow();

  ToastOK ('Успешно выполнено!', unisession);
end;

procedure TShipmentsT.SortColumn(const FieldName: string; Dir: Boolean);
begin
  if Dir then
    Query.IndexName := FieldName+'_index_asc'
  else
    Query.IndexName := FieldName+'_index_des';
end;

procedure TShipmentsT.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TShipmentsT.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TShipmentsT.GridColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  SortColumn(Column.FieldName, Direction);
end;

procedure TShipmentsT.GridDrawColumnCell(Sender: TObject; ACol, ARow: Integer;
  Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (Query.FieldByName('Flag').AsInteger and 2 > 0) then
  begin
    Attribs.Font.Color:=clGray;
  end;
end;

procedure TShipmentsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}

  Grant.SetGrant(self, actMain);

  fShipmentsDate.Text := '';

  // индексы для сортировки
  GridExt.SortColumnCreate(Grid);

  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // объект для упраления метками
  Marks := tMarks.Create(Grid, 10);
  Marks.Clear;

  fStatus2.FillFromSQL('Exec Shipments_StatusList');

  GetMarksInfo;

  GridOpen;
end;


procedure TShipmentsT.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
end;

procedure TShipmentsT.UniFrameReady(Sender: TObject);
begin
  FilterSupplierCreate();
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

  if (KEY = 117) then   // F6
  begin
    if (Sender is Tunidbgrid) then
    begin
      actProtocolExecute(Sender);
    end;
  end;

end;

initialization
  RegisterClass(TShipmentsT);

end.
