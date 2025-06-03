unit uShipmentsTransporterDataF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, uniDateTimePicker,
  uCommonType, uniEdit;

type
  TShipmentsTransporterDataF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniLabel1: TUniLabel;
    edtTransporterWeightKG: TUniFormattedNumberEdit;
    edtTransporterVolumeKG: TUniFormattedNumberEdit;
    UniLabel2: TUniLabel;
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

function ShipmentsTransporterDataF: TShipmentsTransporterDataF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar;

function ShipmentsTransporterDataF: TShipmentsTransporterDataF;
begin
  Result := TShipmentsTransporterDataF(UniMainModule.GetFormInstance(TShipmentsTransporterDataF));
end;

{ TShipmentsReceiptDateF }

procedure TShipmentsTransporterDataF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TShipmentsTransporterDataF.btnOkClick(Sender: TObject);
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

            exec @r = SetShipmentsTransporterData
                        @Weight = :Weight
                       ,@Volume = :Volume
                       ,@ShipmentsID = :ShipmentsID
            select @r as retcode
        ''';

        Sql.Open(sqltext,
                ['Weight', 'Volume', 'ShipmentsID'],
                [edtTransporterWeightKG.Value, edtTransporterVolumeKG.Value, FID]);

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

procedure TShipmentsTransporterDataF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//    //  if edtDate.IsBlank then
////      begin
//       // RetVal.Code := 1;
//      //  edtDate.SetFocus;
//       // RetVal.Message := 'ѕоле [ƒата поставки] об€зательно к заполнению!'; Exit();
////      end
//    end;
//  end;
end;

procedure TShipmentsTransporterDataF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TShipmentsTransporterDataF.UniFormShow(Sender: TObject);
begin
 // edtDate.DateTime := Date();
end;

end.
