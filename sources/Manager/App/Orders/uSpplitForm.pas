unit uSpplitForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  uniSpinEdit;

type



  TSpplitForm = class(TUniForm)
    tabCommon: TUniFieldContainer;
    lblDetailNameF: TUniLabel;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    edtQuantity: TUniSpinEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);

  private
    FAction: TFormAction;
    FID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;
    FManufacturer:string;
    FQuantity: Integer;


//    FWeightKGF: Double;
//    FVolumeKGF: Double;

    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
    function GetQuantity: Integer;

  public
    { Public declarations }
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;


    /// <summary>
    ///  Quantity - количество
    ///</summary>
    property Quantity: Integer read GetQuantity;
  end;

function SpplitForm: TSpplitForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

function SpplitForm: TSpplitForm;
begin
  Result := TSpplitForm(UniMainModule.GetFormInstance(TSpplitForm));
end;

{ TOrderF }

procedure TSpplitForm.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSpplitForm.btnOkClick(Sender: TObject);
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TSpplitForm.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtQuantity.Value = 0 then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Количество должно быть больше нуля!'; Exit();
      end
      else
      if edtQuantity.Value >= FQuantity then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Количество должно быть меньше количества в основном заказе [' + FQuantity.ToString + ']!'; Exit();
      end
    end;
  end;
end;

procedure TSpplitForm.DataLoad;
begin
 sql.open(
  '''
       select DetailName
             ,DetailNumber
             ,Quantity
         from tOrders (nolock)
        where OrderID = :OrderID

  ''', ['OrderID'], [FID]);

  FDetailNumber      := UniMainModule.Query.FieldByName('DetailNumber').AsString;
//  FManufacturer      := UniMainModule.Query.FieldByName('Manufacturer').AsString;
  FQuantity         := UniMainModule.Query.FieldByName('Quantity').AsInteger;


//  edtQuantity.MaxValue:= FQuantity-1;
end;

function TSpplitForm.GetQuantity: Integer;
begin
  Result := edtQuantity.Value;
end;

procedure TSpplitForm.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TSpplitForm.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
    end;
    acUpdate, acReportEdit, acUserAction:
    begin
      btnOk.Caption := ' Сохранить';

    end;
    acDelete:
      btnOk.Caption := ' Удалить';
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption := ' Выполнить';
  end;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      DataLoad;
    end
  else

  end;

//  edtQuantity.Clear;
end;

end.

