unit uAllowCreateOrderF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, uniDateTimePicker,
  uCommonType, uniMemo, uniHTMLMemo, uServiceEmex, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uniBasicGrid, uniDBGrid, uniTimer;

type
  TAllowCreateOrderF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    Table: TFDMemTable;
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    TableTotal: TFloatField;
    TableBalance: TFloatField;
    TableCredit: TFloatField;
    TableNewOrderAmount: TFloatField;
    TableSupplier: TStringField;
    UniTimer: TUniTimer;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure TableNewOrderAmountGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure UniTimerTimer(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
  public
    { Public declarations }

    procedure AllowCreateOrderByMarks;
  end;

function AllowCreateOrderF: TAllowCreateOrderF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils,
  System.Math;

function AllowCreateOrderF: TAllowCreateOrderF;
begin
  Result := TAllowCreateOrderF(UniMainModule.GetFormInstance(TAllowCreateOrderF));
end;

{ TShipmentsReceiptDateF }

procedure TAllowCreateOrderF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TAllowCreateOrderF.btnOkClick(Sender: TObject);
begin
  btnOk.Enabled := False;
  UniSession.Synchronize();

  DataCheck();

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);

    btnOk.Enabled := True;
    UniSession.Synchronize();
  end;
end;

procedure TAllowCreateOrderF.DataCheck; var i: Integer;
begin
  RetVal.Clear;
  Table.First;
  for i:=0 to Table.RecordCount - 1 do // Цикл по поставщикам
  begin
      if Table.FieldByName('Balance').AsFloat  <  Table.FieldByName('NewOrderAmount').AsFloat then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Невозможно разместить заказ!'; break;
      end;
    Table.Next
  end;
end;

procedure TAllowCreateOrderF.TableNewOrderAmountGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if (TableBalance.Value < TableNewOrderAmount.Value) then
  begin
    Text := '<span class="grid-allow-create-order">' + FormatFloat('###,##0.00 $', Sender.Value) + '</span>';
  end
  else
    Text := Sender.AsString;
end;

procedure TAllowCreateOrderF.UniFormShow(Sender: TObject);
begin
  btnOk.Enabled := False;
  UniTimer.Enabled:= True;
end;

procedure TAllowCreateOrderF.UniTimerTimer(Sender: TObject);
begin
  AllowCreateOrderByMarks;
end;

procedure TAllowCreateOrderF.AllowCreateOrderByMarks;
var   i: Integer;
Balance: BalanceForOrder; // AllowCreateOrderResponse
   emex: TEmex;
begin
  Table.Open;
  Table.EmptyDataSet;

  sql.Open('''
            select 1
              from pAccrualAction p with (nolock index=ao2)
             where p.Spid   = @@SPID
               and p.RetVal = 534;
  ''', [],[]);
  if SQl.Q.RecordCount > 0 then
  begin
    Exit;
  end;

  sql.Open('''
            Select distinct
                   s.SuppliersID
                  ,s.Brief
              from pAccrualAction p with (nolock index=ao2)
             inner join tOrders o with (nolock)
                     on o.OrderID = p.ObjectID
             inner join tClients c with (nolock)
                     on c.ClientID = o.ClientID
             inner join tSuppliers  s with (nolock)
                     on s.SuppliersID = c.SuppliersID
             where p.Spid   = @@spid
               and p.Retval = 0
           ''', [], []);

  if sql.Count > 0 then
  begin
    emex := TEmex.Create(UniMainModule.FDConnection);

    sql.Q.First;
    for i:=0 to sql.Count - 1 do // Цикл по поставщикам
    begin
      Balance:= emex.Emex.AllowCreateOrder(emex.getCustomer(sql.f('SuppliersID').AsInteger));  // запрос корзины в emex

      with Table do
      begin
         Append;
         FieldByName('Supplier').AsString := sql.f('Brief').AsString;
         FieldByName('Balance').AsFloat := IfThen( Balance.Total > 0, Balance.Total * 10, 0.00);
         FieldByName('NewOrderAmount').AsFloat := Balance.NewOrderAmount;
         Post;
      end;

      Table.Refresh;

      UniSession.Synchronize();

      sql.Q.Next;
    end;

    FreeAndNil(emex);

    btnOk.Enabled := true;
    UniSession.Synchronize();
  end;
end;

end.
