unit uShipmentsTransporterNumberF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm,

  uCommonType, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel, uniEdit,
  uniLabel;

type
  TShipmentsTransporterNumberF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    edtNum: TUniEdit;
    edtNumS: TUniLabel;
    UniLabel1: TUniLabel;
    edtNumE: TUniLabel;
    procedure UniFormReady(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataCheck - проверка заполнени€ об€зательных полей
    ///</summary>
    procedure DataCheck();
    { Private declarations }
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function ShipmentsTransporterNumberF: TShipmentsTransporterNumberF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function ShipmentsTransporterNumberF: TShipmentsTransporterNumberF;
begin
  Result := TShipmentsTransporterNumberF(UniMainModule.GetFormInstance(TShipmentsTransporterNumberF));
end;

{ TShipmentsTransporterNumberF }

procedure TShipmentsTransporterNumberF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TShipmentsTransporterNumberF.btnOkClick(Sender: TObject);
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

            exec @r = SetShipmentsTransporterNumber
                        @TransporterNumber = :TransporterNumber
                       ,@ShipmentsID       = :ShipmentsID
                  select @r as retcode
        ''';

        Sql.Open(sqltext, ['TransporterNumber', 'ShipmentsID'], [edtNumS.Text + edtNum.Text + edtNumE.Text, FID]);

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

procedure TShipmentsTransporterNumberF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//      if edtBrief.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := 'ѕоле [—окращение] об€зательно к заполнению!'; Exit();
//      end
//    end;
//  end;
end;

procedure TShipmentsTransporterNumberF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TShipmentsTransporterNumberF.UniFormReady(Sender: TObject);
begin

  Sql.Open
  ('''
    select sd.Brief
      from tShipments s (nolock)
     inner join tSupplierDeliveryProfiles as sd (nolock)
             on sd.SuppliersID     = s.SuppliersID
            and sd.DestinationLogo = s.DestinationLogo
     where s.ShipmentsID = :ShipmentsID
  ''', ['ShipmentsID'],[FID]);

  if Sql.q.RecordCount > 0 then
  begin
     edtNumE.Caption := Sql.q.FieldByName('Brief').AsString;
  end;
end;

end.
