unit uSearch;

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
  Vcl.ActnList, uniMainMenu, uniHTMLFrame;

type
  TSearchF = class(TUniFrame)
    TopPanel: TUniPanel;
    MainPanel: TUniPanel;
    edtSearch: TUniEdit;
    UniImageList1: TUniImageList;
    SearchGrid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    qStatus: TFDQuery;
    QueryMakeName: TWideStringField;
    QueryDetailNum: TWideStringField;
    QueryPartNameRus: TWideStringField;
    QueryDeliveryType: TIntegerField;
    QueryDelivery: TIntegerField;
    QueryPercentSupped: TIntegerField;
    QueryPrice: TCurrencyField;
    QueryAvailable: TWideStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    btnAddBasket: TUniButtonWidget;
    QueryID: TFMTBCDField;
    QueryRating: TStringField;
    procedure edtSearchTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure SearchGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure btnAddBasketClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure QueryDeliveryTypeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure SearchGridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniHTMLFrameAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFrameReady(Sender: TObject);

  private
    { Private declarations }

    FDestinationLogo: string;

    procedure PartSearch();

    procedure GridRefresh();

    procedure PartToBasket();
    /// <summary>
    /// CustomerPriceCalc - расчет цены
    /// </summary>
    procedure CustomerPriceCalc();
  public
    { Public declarations }
  end;

implementation

uses
  uEmexUtils, MainModule, uMainVar, uLogger, uToast;

{$R *.dfm}

procedure TSearchF.btnAddBasketClick(Sender: TObject);
begin
  PartToBasket();
end;

procedure TSearchF.CustomerPriceCalc;
begin
    RetVal.Clear;
    Sql.exec('exec CustomerPriceCalc @DestinationLogo=:DestinationLogo', ['DestinationLogo'], [FDestinationLogo]);
end;

procedure TSearchF.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if edtSearch.Text = '' then
      Exit;

    if (Sender is TUniDBGrid) then
    begin
      PartSearch;
    end;
  end;
end;

procedure TSearchF.edtSearchTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if edtSearch.Text = '' then
    Exit;

  if AButtonId = 0 then
  begin
    PartSearch;
  end;
end;

procedure TSearchF.GridRefresh();
var
  js: string;
begin
  Query.Close;
  Query.ParamByName('DestinationLogo').Value := FDestinationLogo;
  Query.Open;
end;

procedure TSearchF.PartSearch;
var
  emex: TEmex;
begin
  emex := TEmex.Create;
  try
    emex.Connection := UniMainModule.FDConnection;
    emex.FindByDetailNumber(UniMainModule.AUserID, edtSearch.Text);

    CustomerPriceCalc;

    GridRefresh();

  finally
    FreeAndNil(emex);
  end;
end;

procedure TSearchF.PartToBasket;
begin
  logger.Info('ClientID: ' + UniMainModule.AUserID.ToString);
  logger.Info('SPID: ' + UniMainModule.ASPID.ToString);

  RetVal.Clear;
  Sql.Open('declare @R int exec @R=PartToBasket @ClientID = :ClientID, @PartID=:PartID  select @R as retval',
    ['PartID', 'ClientID'], [QueryID.AsInteger, UniMainModule.AUserID]);

  RetVal.Code := Sql.Q.FieldByName('retval').Value;

  if RetVal.Code = 0 then
  begin
    ToastOK('Деталь успешно добавлена в корзину!', UniSession);
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TSearchF.QueryDeliveryTypeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  /// /  if (Sender.FieldName = 'Manufacturer') and (QueryReplacementManufacturer.Value <> '') then
  /// /  begin
  Text := StringReplace('<form id="frmDestLogo"  method="post" action=""> ' +
    '<div class="radio-form">' + '   <label class="radio-control">  ' +
    '       <input type="radio"  value="0001"  onchange="setDestLogo(value)" /> '
    + '       <span class="radio-input">   ' +
    '           <i class="fa fa-plane"></i> ' +
    // '          <span></span>    ' +
    '       </span>      ' + '   </label>    ' +
    '   <label class="radio-control">  ' +
    '       <input type="radio"  value="0002"  onchange="setDestLogo(value)" />  '
    + '       <span class="radio-input">  ' +
    '           <i class="fa fa-car"></i> ' + '       </span>   ' +
    '   </label>      ' + '   <label class="radio-control"> ' +
    '       <input type="radio"  value="0003" onchange="setDestLogo(value)" />     '
    + '       <span class="radio-input"> ' +
    '          <i class="fa fa-ship"></i>  ' + '       </span>    ' +
    '   </label>' + '</div>' + '</form>', FDestinationLogo + '"',
    FDestinationLogo + '" checked', []);
end;

procedure TSearchF.SearchGridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if EventName = 'setDestLogo' then
  begin
    FDestinationLogo := Params.Values['P1'];

    CustomerPriceCalc;

    GridRefresh();
  end;
end;

procedure TSearchF.SearchGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(Key) = 'C') AND (Shift = [SSCTRL]) then
  begin
    if (Sender is TUniDBGrid) then
    begin
      SearchGrid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TSearchF.UniFrameCreate(Sender: TObject);
var
  js: string;
begin
  SQL.Exec('Delete pFindByNumber from pFindByNumber (rowlock) where spid = @@spid', [], []);

  js := ' setDestLogo = function(AVal) { ' + ' ajaxRequest(' + SearchGrid.JSName
    + ', "setDestLogo", [ "P1=" + AVal ]);' + ' } ;';
  UniSession.JSCode(js);
end;

procedure TSearchF.UniFrameReady(Sender: TObject);
begin
  Sql.exec('update pFindByNumber set spid = @@spid', [], []);

  FDestinationLogo := '0001';

  GridRefresh();

  with SearchGrid do
  begin
    Options := Options + [dgDontShowSelected];
    JSInterface.JSConfig('disableSelection', [True]);
  end;
end;

procedure TSearchF.UniHTMLFrameAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  logger.Info(Sender.Name + ': ' + EventName)
end;

initialization

RegisterClass(TSearchF);

end.
