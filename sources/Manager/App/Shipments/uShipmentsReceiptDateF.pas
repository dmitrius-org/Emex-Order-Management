unit uShipmentsReceiptDateF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, uniDateTimePicker,
  uCommonType;

type
  TShipmentsReceiptDateF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniLabel1: TUniLabel;
    edtDate: TUniDateTimePicker;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);


    /// <summary>
    ///  DataCheck - проверка заполнени€ об€зательных полей
    ///</summary>
    procedure DataCheck();
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function ShipmentsReceiptDateF: TShipmentsReceiptDateF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function ShipmentsReceiptDateF: TShipmentsReceiptDateF;
begin
  Result := TShipmentsReceiptDateF(UniMainModule.GetFormInstance(TShipmentsReceiptDateF));
end;

{ TShipmentsReceiptDateF }

procedure TShipmentsReceiptDateF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TShipmentsReceiptDateF.btnOkClick(Sender: TObject);
 var sqltext: string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        sqltext :='''
            declare @R      int

            exec @r = SetShipmentsReceiptDate
                        @ReceiptDate = :ReceiptDate
                       ,@ShipmentsID  = :ShipmentsID
                  select @r as retcode
        ''';

        Sql.Open(sqltext,
                ['ReceiptDate', 'ShipmentsID'],
                [edtDate.DateTime, FID]);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
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

procedure TShipmentsReceiptDateF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtDate.IsBlank then
      begin
        RetVal.Code := 1;
        edtDate.SetFocus;
        RetVal.Message := 'ѕоле [ƒата поставки] об€зательно к заполнению!'; Exit();
      end
    end;
  end;
end;

procedure TShipmentsReceiptDateF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TShipmentsReceiptDateF.UniFormShow(Sender: TObject);
begin
  edtDate.DateTime := Date();
end;

end.
