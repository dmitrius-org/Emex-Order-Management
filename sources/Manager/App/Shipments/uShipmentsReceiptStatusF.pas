unit uShipmentsReceiptStatusF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, uniDateTimePicker,
  uCommonType;

type
  TShipmentsReceivedStatusF = class(TUniForm)
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

function ShipmentsReceivedStatusF: TShipmentsReceivedStatusF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function ShipmentsReceivedStatusF: TShipmentsReceivedStatusF;
begin
  Result := TShipmentsReceivedStatusF(UniMainModule.GetFormInstance(TShipmentsReceivedStatusF));
end;

{ TShipmentsReceiptDateF }

procedure TShipmentsReceivedStatusF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TShipmentsReceivedStatusF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin
  DataCheck();

  btnOk.Enabled := False;

  UniSession.Synchronize();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        sqltext :='''
            declare @R      int

            exec @r = SetShipmentsReceiptStatus
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

    btnOk.Enabled := True;
    UniSession.Synchronize();
  end;
end;

procedure TShipmentsReceivedStatusF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtDate.IsBlank then
      begin
        RetVal.Code := 1;
        edtDate.SetFocus;
        RetVal.Message := 'ѕоле [ƒата поступлени€] об€зательно к заполнению!'; Exit();
      end
    end;
  end;
end;

procedure TShipmentsReceivedStatusF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TShipmentsReceivedStatusF.UniFormShow(Sender: TObject);
begin
  edtDate.DateTime := Date();
end;

end.
