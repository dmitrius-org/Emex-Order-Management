unit uOrdersNewDeliveryDateF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, uniDateTimePicker,
  uCommonType, uConstant;

type
  TOrdersNewDeliveryDateF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    lblDate: TUniLabel;
    edtDate: TUniDateTimePicker;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);


    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function OrdersNewDeliveryDateF: TOrdersNewDeliveryDateF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function OrdersNewDeliveryDateF: TOrdersNewDeliveryDateF;
begin
  Result := TOrdersNewDeliveryDateF(UniMainModule.GetFormInstance(TOrdersNewDeliveryDateF));
end;

{ TShipmentsReceiptDateF }

procedure TOrdersNewDeliveryDateF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TOrdersNewDeliveryDateF.btnOkClick(Sender: TObject);
 var Field:string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        Sql.Exec('''
           update #ActionParams
              set DateValue = :DateValue
            where ActionID= :ActionID
        ''',
        ['DateValue', 'ActionID'],
        [edtDate.DateTime, FID]);

        //RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      end;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TOrdersNewDeliveryDateF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if (edtDate.IsBlank) or (edtDate.DateTime = NullDate) then
      begin
        RetVal.Code := 1;
        edtDate.SetFocus;
        RetVal.Message := 'Поле [Дата поставки] обязательно к заполнению!'; Exit();
      end
    end;
  end;
end;

procedure TOrdersNewDeliveryDateF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TOrdersNewDeliveryDateF.UniFormShow(Sender: TObject);
begin
  edtDate.DateTime := Date();
end;

end.
