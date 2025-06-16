unit uBasket;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, System.SysUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniEdit, uniGUIBaseClasses, uniPanel,
  uniImageList, System.ImageList, Vcl.ImgList,
  uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniWidgets, System.Actions,
  Vcl.ActnList, uniMainMenu, Vcl.Menus, uniButton, uniLabel,
  System.Generics.Collections, uniSpinEdit, uniDBEdit, uniScreenMask,
  uUtils.Mark, uniTimer, uniGridExporters;

type
 TBasketItem = record
    BasketID: Integer;
    DetailNum: string;
  end;

  TBasketList = array of TBasketItem;

  TBasketPriceCalcThread = class(TThread)
  private
    FItems: TBasketList;
    FUserID: Integer;
    FOnProgress: TProc<Integer, Integer>;
    FConnection: TFDConnection;
  protected
    procedure Execute; override;
  public
    constructor Create(const AItems: TBasketList;
                       AUserID: Integer;
                       AConnection: TFDConnection;
                       AOnProgress: TProc<Integer, Integer>);
  end;

  TBasketF = class(TUniFrame)
    MainPanel: TUniPanel;
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    qStatus: TFDQuery;
    HiddenPanel: TUniHiddenPanel;
    QueryBasketID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryMake: TWideStringField;
    QueryMakeName: TWideStringField;
    QueryDetailNum: TWideStringField;
    QueryPartNameRus: TWideStringField;
    QueryPriceLogo: TWideStringField;
    QueryQuantity: TIntegerField;
    QueryAmount: TCurrencyField;
    btnDeleteBasket: TUniButtonWidget;
    UpdateSQL: TFDUpdateSQL;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    TopPanel: TUniPanel;
    BaseTopContainer: TUniContainerPanel;
    PriceInfoContainer: TUniPanel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    ButtonContainer: TUniPanel;
    addOrder: TUniButton;
    btnRefresh: TUniButton;
    QueryPriceRub: TCurrencyField;
    QueryOurDelivery: TIntegerField;
    PriceInfo: TUniContainerPanel;
    UniFieldContainer1: TUniFieldContainer;
    UniFieldContainer2: TUniFieldContainer;
    UniLabel9: TUniLabel;
    UniLabel10: TUniLabel;
    UniLabel11: TUniLabel;
    edtOrderAmount: TUniLabel;
    edtWeight: TUniLabel;
    edtCount: TUniLabel;
    edtCountEdit: TUniSpinEdit;
    QueryIsUpdating: TIntegerField;
    btnPriceRefresh: TUniButtonWidget;
    QueryIsUpdatingExists: TIntegerField;
    QueryPacking: TIntegerField;
    QueryComment2: TStringField;
    ImageList: TUniNativeImageList;
    btnPriceRefreshAll: TUniLabel;
    btnBasketClear: TUniLabel;
    TimerProcessed: TUniTimer;
    lblToExcel: TUniLabel;
    UniGridExcelExporter: TUniGridExcelExporter;
    QuerySuppliersID: TFMTBCDField;

    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnDeleteBasketClick(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridSelectionChange(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure addOrderClick(Sender: TObject);
    procedure GridAfterLoad(Sender: TUniCustomDBGrid);
    procedure btnPriceRefreshClick(Sender: TObject);
    procedure btnBasketClearClick(Sender: TObject);
    procedure btnPriceRefreshAllClick(Sender: TObject);
    procedure TimerProcessedTimer(Sender: TObject);
    procedure lblToExcelClick(Sender: TObject);
  private
    { Private declarations }

    Marks: TMarks;

    /// <summary>
    /// PartPriceRefresh - обновление цены для выбранной позиции в корзине
    /// </summary>
    procedure PartPriceRefresh();

    /// <summary>
    /// PriceCalc - расчет цены и срока поставки
    /// </summary>
    procedure PriceCalc();



    /// <summary>
    /// BasketClear - очистка крозины
    /// </summary>
    procedure BasketClear();


    /// <summary>
    /// BasketDeleteByID - удаление позиции из корзины
    /// </summary>
    procedure BasketDeleteByID();
  public
    /// <summary>
    /// PriceCalcAll - расчет цены и срока поставки
    /// </summary>
    procedure PriceCalcAll();

    procedure GridRefresh;

    procedure GetAgregateData();
  end;

  var
  processed, total: Integer;

implementation

uses
  uEmexUtils, MainModule, uMainVar, uOrderF, uToast, uUtils.Logger;

{$R *.dfm}


procedure TBasketF.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh;
end;

procedure TBasketF.addOrderClick(Sender: TObject);
var f:TOrderF;
    sqltext: string;
begin
  if Grid.SelectedRows.Count = 0 then
  begin
    ShowToast('Нет выбранных строк');
    Exit;
  end;

  try
    RetVal.Clear;
    Marks.SaveMarksToDB;
    // Проверяем что по всем позициям актуальные цены
    if RetVal.Code = 0 then
    begin
      sqltext :=' declare @R      int                        ' +
                ' exec @r = OrderCreateFromBasketCheckBefore ' +
                '           '+
                ' select @r as retcode '+
                ' ';

      Sql.Open(sqltext, [], []);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;


    if RetVal.Code>0 then
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
      exit;
    end;

    f := TOrderF.Create(UniApplication);
    try
      if f.ShowModal = mrOk then
      begin
        GridRefresh;
      end;
    finally
      f.Free
    end;
  finally

  end;
end;

procedure TBasketF.BasketClear;
begin
  RetVal.Clear;

  Sql.Open('''
   declare @R      int

   exec @r = BasketClear
               @ClientID  = :ClientID

   select @r as retcode
  ''',
  ['ClientID'], [UniMainModule.AUserID]);

  RetVal.Code := Sql.Q.FieldByName('retcode').Value;

  if RetVal.Code = 0 then
  begin
    GridRefresh();
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TBasketF.BasketDeleteByID;
begin
  RetVal.Clear;

  Sql.Open('''
   declare @R      int

   exec @r = BasketDeleteByID
               @BasketID  = :BasketID

   select @r as retcode
  ''',
  ['BasketID'], [Query.FieldByName('BasketID').AsInteger]);

  RetVal.Code := Sql.Q.FieldByName('retcode').Value;

  if RetVal.Code = 0 then
  begin
    Query.Delete;

    GetAgregateData;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TBasketF.btnBasketClearClick(Sender: TObject);
begin
  if Grid.SelectedRows.Count = 0 then
  begin
    ShowToast('Нет выбранных строк');
    Exit;
  end;

  MessageDlg('Вы действительно хотите очистить корзину? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : BasketClear();
        mrNo  : Exit;
      end;
    end
  );
end;

procedure TBasketF.btnDeleteBasketClick(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите удалить текущую позицию? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : BasketDeleteByID();
        mrNo  : Exit;
      end;
    end
  );
end;


procedure TBasketF.btnPriceRefreshAllClick(Sender: TObject);
begin
  if Grid.SelectedRows.Count = 0 then
  begin
    ShowToast('Нет выбранных строк');
    Exit;
  end;

  MessageDlg('Вы действительно хотите обновить цену по выделенным позициям? ' , mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      case Res of
        mrYes : PriceCalcAll;
        mrNo  : Exit;
      end;
    end
  );

end;

procedure TBasketF.btnPriceRefreshClick(Sender: TObject);
begin
  PartPriceRefresh;
end;

procedure TBasketF.PriceCalc;
begin
  RetVal.Clear;
  Sql.exec('exec BasketPriceCalc @BasketID = :BasketID',
          ['BasketID'],
          [Query.FieldByName('BasketID').AsInteger]);
end;

procedure TBasketF.PriceCalcAll;
var
  i: Integer;
  items: TBasketList;
  ds: TDataSet;

  Thread : TBasketPriceCalcThread;
begin
  LogInfo('TBasketF.PriceCalcAll begin');
  ds := Grid.DataSource.DataSet;
  processed:=0;
  total := Grid.SelectedRows.Count;
  if total = 0 then
  begin
    ShowToast('Нет выбранных строк');
    Exit;
  end;

  SetLength(items, total);
  // Собираем данные из выбранных строк
  for i := 0 to total - 1 do
  begin
    ds.Bookmark := Grid.SelectedRows[i];
    items[i].BasketID := ds.FieldByName('BasketID').AsInteger;
    items[i].DetailNum := ds.FieldByName('DetailNum').AsString;
  end;

  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;

  Sql.Exec('delete from #ProcessedRecords');
  Sql.Exec('insert into #ProcessedRecords (Processed, Total) values (0, :Total)', ['Total'], [total]);
  TimerProcessed.Enabled := True;

  Thread := TBasketPriceCalcThread.Create(
    items,
    UniMainModule.AUserID,
    UniMainModule.FDConnection,
    procedure(AProcessed, ATotal: Integer)  // не работает в dll
    begin
      Processed :=AProcessed;
      Total :=ATotal;
    end
  );

  Thread.Start; // Запуск вручную
end;

procedure TBasketF.TimerProcessedTimer(Sender: TObject);
begin
  LogInfo('TBasketF.TimerProcessedTimer begin');

  Sql.Open('select Processed, Total from #ProcessedRecords (nolock)', [], []);

  Processed := Sql.f('Processed').AsInteger;
  Total := Sql.f('Total').AsInteger;

  if processed >= total then
  begin
    TimerProcessed.Enabled := False;
    HideMask;
    UniSession.Synchronize;

    ShowToast('Цены успешно обновлены!');

    GridRefresh;
  end
  else
  begin
    HideMask;
    ShowMask(Format('Обработано %d из %d', [processed, total]));
    UniSession.Synchronize;
  end;
  LogInfo('TBasketF.TimerProcessedTimer end');
end;


procedure TBasketF.GridRefresh;
begin
  Query.Close;
  Query.ParamByName('ClientID').AsInteger := UniMainModule.AUserID;
  Query.Open;

  Grid.Columns.ColumnFromFieldName('IsUpdating').Visible := Query.FieldByName('IsUpdatingExists').Value > 0;

  GetAgregateData;
end;

procedure TBasketF.GridSelectionChange(Sender: TObject);
begin
  Marks.Select;
end;

procedure TBasketF.lblToExcelClick(Sender: TObject);
begin
  Grid.Exporter.ExportGrid;
end;

procedure TBasketF.PartPriceRefresh;
var
  emex: TEmex;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    SQL.Exec('''
      Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid
    ''', [], []);

    emex := TEmex.Create(UniMainModule.FDConnection);
    emex.FindByDetailNumber( UniMainModule.AUserID, QuerySuppliersID.AsLargeInt, Query.FieldByName('DetailNum').AsString );

    PriceCalc;

    GridRefresh();
  finally
    FreeAndNil(emex);

    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TBasketF.GetAgregateData;
begin
  RetVal.Clear;
  Sql.Open('exec BasketData @ClientID = :ClientID',
          ['ClientID'],
          [UniMainModule.AUserID]);

  edtOrderAmount.Text := FormatFloat('###,##0.00 ₽', Sql.Q.FieldByName('Amount').Value);
  edtWeight.Text := FormatFloat('###,##0.000 кг', Sql.Q.FieldByName('WeightKG').Value);
  edtCount.Text  := Sql.Q.FieldByName('Cnt').AsString;
end;

procedure TBasketF.GridAfterLoad(Sender: TUniCustomDBGrid);
begin
  with Grid, JSInterface do
    JSCallDefer('getSelectionModel().selectAll', [], 100 );
end;

procedure TBasketF.GridAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if (EventName = 'edit') and (Query.State  in [dsEdit, dsInsert] ) then
  begin
    Query.Post;
    Query.Refresh;

    GetAgregateData();
  end;
end;

procedure TBasketF.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TBasketF.UniFrameCreate(Sender: TObject);
begin
  // объект для упраления метками
  Marks := tMarks.Create(Grid, 6);
  Marks.Clear;
end;

procedure TBasketF.UniFrameDestroy(Sender: TObject);
begin
  Marks.Free;
end;


{ TBasketPriceCalcThread }

constructor TBasketPriceCalcThread.Create(const AItems: TBasketList;
                                          AUserID: Integer;
                                          AConnection: TFDConnection;
                                          AOnProgress: TProc<Integer, Integer>);
begin
  inherited Create(True);
  FreeOnTerminate := True; // Экземпляр должен само уничтожиться после выполнения
  FItems := Copy(AItems);
  FUserID := AUserID;
  FOnProgress := AOnProgress;
  FConnection:= AConnection;
end;

procedure TBasketPriceCalcThread.Execute;
var emex: TEmex;
    i: Integer;
begin
  emex := TEmex.Create(FConnection);
  try
    for i := 0 to Length(FItems) - 1 do
    begin
      emex.SQL.Open('''
        Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid

        select top 1 pc.SuppliersID
          From tBasket b (nolock)
         inner join vClientProfilesParam pc
                 on pc.ProfilesCustomerID = b.ProfilesCustomerID
         where b.BasketID = :BasketID
      ''', ['BasketID'], [FItems[i].BasketID]);

      emex.FindByDetailNumber(FUserID, emex.SQL.Q.Fields[0].AsInteger, FItems[i].DetailNum);

      emex.SQL.Exec('''
        exec BasketPriceCalc @BasketID = :BasketID;

        UPDATE #ProcessedRecords SET Processed = :Processed;
      ''',
      ['BasketID', 'Processed'], [FItems[i].BasketID, i+1]);

//      Synchronize(   // не работает в dll
//        procedure
//        begin
//          if Assigned(FOnProgress) then
//            FOnProgress(i + 1, Length(FItems));
//        end
//      );
    end;
  finally
    FreeAndNil(emex);
  end;
end;

initialization
  RegisterClass(TBasketF);
end.
