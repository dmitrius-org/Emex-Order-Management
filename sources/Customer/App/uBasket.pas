unit uBasket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniEdit, uniGUIBaseClasses, uniPanel,
  uniImageList, System.ImageList, Vcl.ImgList,
  uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniWidgets, System.Actions,
  Vcl.ActnList, uniMainMenu, Vcl.Menus, uniButton, uniLabel,
  System.Generics.Collections, uniSpinEdit;

type
  tMarks = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FGrid: TUniDBGrid;

    FMarks: TDictionary <Integer, Integer>;

    procedure DeleteInDB();
    function GetCount: Integer;
  public
    constructor Create(AGrid: TUniDBGrid);
    destructor Destroy; override;

    procedure Select();
    procedure Clear();

    property Count: Integer read GetCount;
  end;


  TBasketF = class(TUniFrame)
    MainPanel: TUniPanel;
    UniImageList1: TUniImageList;
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    qStatus: TFDQuery;
    UniHiddenPanel1: TUniHiddenPanel;
    QueryBasketID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryMake: TWideStringField;
    QueryMakeName: TWideStringField;
    QueryDetailNum: TWideStringField;
    QueryPartNameRus: TWideStringField;
    QueryPriceLogo: TWideStringField;
    QueryGuaranteedDay: TWideStringField;
    QueryQuantity: TIntegerField;
    QueryAmount: TCurrencyField;
    btnDeleteBasket: TUniButtonWidget;
    UpdateSQL: TFDUpdateSQL;
    ppMain: TUniPopupMenu;
    N6: TUniMenuItem;
    actMain: TUniActionList;
    actRefreshAll: TAction;
    TopPanel: TUniPanel;
    UniContainerPanel1: TUniContainerPanel;
    UniPanel1: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    edtCount: TUniLabel;
    edtWeight: TUniLabel;
    edtOrderAmount: TUniLabel;
    UniPanel2: TUniPanel;
    addOrder: TUniButton;
    btnRefresh: TUniButton;
    QueryPriceRub: TCurrencyField;
    edtQuantity: TUniSpinEdit;
    procedure edtSearchTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnDeleteBasketClick(Sender: TObject);
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure UniFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridSelectionChange(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure addOrderClick(Sender: TObject);
  private
    { Private declarations }

    Marks: TMarks;

    procedure GetAgregateDate();

  public
    { Public declarations }
    procedure GridRefresh;

  end;

implementation

uses
  uEmexUtils, MainModule, uMainVar, uLogger, uOrderF;

{$R *.dfm}


procedure TBasketF.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh;
end;

procedure TBasketF.addOrderClick(Sender: TObject);
var f:TOrderF;
begin
  try
    f := TOrderF.Create(UniApplication);
    if f.ShowModal = mrOk then
    begin
      GridRefresh;
    end;
  finally
    f.Free
  end;

end;

procedure TBasketF.btnDeleteBasketClick(Sender: TObject);
begin
  Query.Delete;

  GetAgregateDate;
end;

procedure TBasketF.edtSearchTriggerEvent(Sender: TUniFormControl; AButtonId: Integer);
var emex: TEmex;
begin

end;

procedure TBasketF.GridRefresh;
begin
  Query.Close;
  Query.ParamByName('ClientID').AsInteger := UniMainModule.AUserID;
  Query.Open;

  GetAgregateDate;
end;

procedure TBasketF.GridSelectionChange(Sender: TObject);
begin
  logger.Info('TBasketF.GridSelectionChange Begin');

  Marks.Select;

 // GetMarksInfo;

 // ActionExecuteEnabled;

  logger.Info('TBasketF.GridSelectionChange End');
end;

procedure TBasketF.GetAgregateDate;
begin

  RetVal.Clear;
  Sql.Open('exec BasketData @ClientID = :ClientID',
          ['ClientID'],
          [UniMainModule.AUserID]);

  edtOrderAmount.Text := Sql.Q.FieldByName('Amount').AsString;
  edtWeight.Text := Sql.Q.FieldByName('WeightKG').AsString;
  edtCount.Text := Sql.Q.FieldByName('Cnt').AsString;
end;

procedure TBasketF.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
   Logger.Info(EventName);
//   Logger.Info(Params.Text);
end;

procedure TBasketF.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  ppMain.Popup(X, Y, Grid);
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

procedure TBasketF.UniFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
//if EventName='MyEvent1' then
//  begin
//    Logger.Info(EventName);
//   // UniButton1.Caption:=Params.Values['param0'] + Params.Values['param1'];
//   // showmessage(Params.Values['param0'] + Params.Values['param1']);
//  end;
end;

procedure TBasketF.UniFrameCreate(Sender: TObject);
begin
  // объект для упраления метками
  Marks := tMarks.Create(Grid);
  Marks.Clear;

  GridRefresh;
end;

procedure TBasketF.UniFrameDestroy(Sender: TObject);
begin
 Marks.Free;
end;

procedure TBasketF.UniFrameReady(Sender: TObject);
begin
  Logger.Info('TBasketF.UniFrameReady');
  GridRefresh;
end;


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

procedure tMarks.DeleteInDB();
begin
  Sql.Exec('Delete tMarks from tMarks (rowlock) where Spid= @@Spid and Type = 6 /*6-корзина*/', [], [])
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
        id := FGrid.DataSource.DataSet.FieldByName('BasketID').AsLargeInt;
        FMarks.Add(id, id);
        if i = 0 then
          SqlText:= SqlText + ' Insert into tMarks (Spid, Type, ID) select @@Spid, 6, '
        else
          SqlText:= SqlText + ' Union all select @@Spid, 6, ';

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
  RegisterClass(TBasketF);
end.
