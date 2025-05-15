unit uShipmentsEditF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, System.Math,

  uCommonType, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel, uniEdit,
  uniLabel, uniDateTimePicker, uConstant, uUtils.Math;

type
  TShipmentsEditF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    UniLabel7: TUniLabel;
    ShipmentsDate: TUniDateTimePicker;
    ReceiptDate: TUniDateTimePicker;
    Invoice: TUniEdit;
    Suppliers: TUniEdit;
    TransporterNumber: TUniEdit;
    DestinationName: TUniEdit;
    UniLabel8: TUniLabel;
    UniLabel9: TUniLabel;
    UniLabel10: TUniLabel;
    UniLabel11: TUniLabel;
    UniLabel12: TUniLabel;
    UniLabel13: TUniLabel;
    WeightKGAmount: TUniFormattedNumberEdit;
    WeightKG: TUniFormattedNumberEdit;
    WeightKGF: TUniFormattedNumberEdit;
    SupplierWeightKG: TUniFormattedNumberEdit;
    TransporterWeightKG: TUniFormattedNumberEdit;
    UniFormattedNumberEdit6: TUniFormattedNumberEdit;
    Amount: TUniFormattedNumberEdit;
    AmountF: TUniFormattedNumberEdit;
    SupplierAmount: TUniFormattedNumberEdit;
    TransporterAmount: TUniFormattedNumberEdit;
    DeliverySumF: TUniFormattedNumberEdit;
    UniLabel14: TUniLabel;
    UniLabel15: TUniLabel;
    UniLabel16: TUniLabel;
    VolumeKGAmount: TUniFormattedNumberEdit;
    VolumeKG: TUniFormattedNumberEdit;
    VolumeKGF: TUniFormattedNumberEdit;
    SupplierVolumeKG: TUniFormattedNumberEdit;
    TransporterVolumeKG: TUniFormattedNumberEdit;
    procedure UniFormReady(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
    { Private declarations }
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function ShipmentsEditF: TShipmentsEditF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function ShipmentsEditF: TShipmentsEditF;
begin
  Result := TShipmentsEditF(UniMainModule.GetFormInstance(TShipmentsEditF));
end;

{ TShipmentsTransporterNumberF }

procedure TShipmentsEditF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TShipmentsEditF.btnOkClick(Sender: TObject);
 var sqltext: string;
//     Field:string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        sqltext :='''
            declare @R      int

            exec @r = ShipmentsEdit
                        @ReceiptDate = :ReceiptDate
                       ,@TransporterNumber = :TransporterNumber
                       ,@ShipmentsID       = :ShipmentsID
                       ,@SupplierWeightKG    = :SupplierWeightKG
                       ,@SupplierVolumeKG    = :SupplierVolumeKG
                       ,@TransporterWeightKG = :TransporterWeightKG
                       ,@TransporterVolumeKG = :TransporterVolumeKG
                       ,@DeliverySumF        = :DeliverySumF

            select @r as retcode
        ''';

        Sql.Open(sqltext, ['ShipmentsID' ,
                           'ReceiptDate',
                           'TransporterNumber',
                           'SupplierWeightKG',
                           'SupplierVolumeKG',
                           'TransporterWeightKG',
                           'TransporterVolumeKG',
                           'DeliverySumF'],
                          [FID,
                           IfThen(ReceiptDate.DateTime <> NullDate, ReceiptDate.DateTime, null),
                           TransporterNumber.Text,
                           SupplierWeightKG.Value,
                           SupplierVolumeKG.Value,
                           TransporterWeightKG.Value,
                           TransporterVolumeKG.Value,
                           DeliverySumF.Value]);

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

procedure TShipmentsEditF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//      if edtBrief.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := 'Поле [Сокращение] обязательно к заполнению!'; Exit();
//      end
//    end;
//  end;
end;

procedure TShipmentsEditF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TShipmentsEditF.UniFormReady(Sender: TObject);
begin
  Sql.Open
  ('''
    select s.*
          ,isnull(s.ReceiptDate2, s.ReceiptDate) DateReceipt
      from vShipments s (nolock)
     inner join tSupplierDeliveryProfiles as sd (nolock)
             on sd.SuppliersID     = s.SuppliersID
            and sd.DestinationLogo = s.DestinationLogo
     where s.ShipmentsID = :ShipmentsID
   ''', ['ShipmentsID'],[FID]);

  if Sql.q.RecordCount > 0 then
  begin
    ShipmentsDate.DateTime := Sql.q.FieldByName('ShipmentsDate').AsDateTime;
    ReceiptDate.DateTime := Sql.q.FieldByName('DateReceipt').AsDateTime;
    Invoice.Text := Sql.q.FieldByName('Invoice').AsString;
    Suppliers.Text := Sql.q.FieldByName('SupplierBrief').AsString;
    TransporterNumber.Text := Sql.q.FieldByName('TransporterNumber').AsString;
    DestinationName.Text := Sql.q.FieldByName('DestinationName').AsString;

    WeightKGAmount.Value  := Sql.q.FieldByName('WeightKGAmount').AsFloat;
    VolumeKGAmount.Value  := Sql.q.FieldByName('VolumeKGAmount').AsFloat;

    WeightKG.Value   := Sql.q.FieldByName('WeightKG').AsFloat;
    VolumeKG.Value   := Sql.q.FieldByName('VolumeKG').AsFloat;
    Amount.Value     := Sql.q.FieldByName('Amount').AsFloat;

    WeightKGF.Value  := Sql.q.FieldByName('WeightKGF').AsFloat;
    VolumeKGF.Value  := Sql.q.FieldByName('VolumeKGF').AsFloat;
    AmountF.Value    := Sql.q.FieldByName('AmountF').AsFloat;

    SupplierWeightKG.Value    := Sql.q.FieldByName('SupplierWeightKG').AsFloat;
    SupplierVolumeKG.Value    := Sql.q.FieldByName('SupplierVolumeKG').AsFloat;
    SupplierAmount.Value      := Sql.q.FieldByName('SupplierAmount').AsFloat;

    TransporterWeightKG.Value := Sql.q.FieldByName('TransporterWeightKG').AsFloat;
    TransporterVolumeKG.Value := Sql.q.FieldByName('TransporterVolumeKG').AsFloat;
    TransporterAmount.Value   := Sql.q.FieldByName('TransporterAmount').AsFloat;

    DeliverySumF.Value        :=   Sql.q.FieldByName('DeliverySumF').AsFloat;

  end;


  UniFormattedNumberEdit6.Clear;

  self.caption := 'Данные по отгрузке: ' + Sql.q.FieldByName('Invoice').AsString;
end;

end.
