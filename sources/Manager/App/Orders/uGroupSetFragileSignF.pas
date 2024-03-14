unit uGroupSetFragileSignF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer;

type



  TGroupSetFragileSignF = class(TUniForm)
    tabCommon: TUniFieldContainer;
    lblDetailNameF: TUniLabel;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    cbRestrictions: TUniComboBox;
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

//    FWeightKGF: Double;
//    FVolumeKGF: Double;

    procedure SetAction(const Value: TFormAction);
    /// <summary>
    ///  DataLoad - ��������� ������ � �������, ��� ����������� �� �����
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - �������� ���������� ������������ �����
    ///</summary>
    procedure DataCheck();

  public
    { Public declarations }
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function GroupSetFragileSignF: TGroupSetFragileSignF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

function GroupSetFragileSignF: TGroupSetFragileSignF;
begin
  Result := TGroupSetFragileSignF(UniMainModule.GetFormInstance(TGroupSetFragileSignF));
end;

{ TOrderF }

procedure TGroupSetFragileSignF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;


procedure TGroupSetFragileSignF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        sqltext :=' declare @R      int                   '+
                  '                                       '+
                  ' exec @r = GroupSetFragileSign       '+
                  '             @Fragile = :Fragile '+
                  ' '+
                  ' select @r as retcode ';

        Sql.Open(sqltext, ['Fragile'], [cbRestrictions.Text]);

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

procedure TGroupSetFragileSignF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//      if edtBrief.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := '���� [����������] ����������� � ����������!'; Exit();
//      end
//    end;
//  end;
end;

procedure TGroupSetFragileSignF.DataLoad;
begin
  //
end;

procedure TGroupSetFragileSignF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TGroupSetFragileSignF.UniFormShow(Sender: TObject);
begin
  //ComboBoxFill(cbRestrictions,   ' Select Name from tRestrictions (nolock) where Flag&1=1 ');
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' ��������';
    end;
    acUpdate, acReportEdit, acUserAction:
    begin
      btnOk.Caption := ' ���������';

    end;
    acDelete:
      btnOk.Caption := ' �������';
    acShow:
      btnOk.Caption := ' �������';
  else
    btnOk.Caption := ' ���������';
  end;

  // ���������� ������ � ����
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      DataLoad;
    end
  else

  end;

  //cbRestrictions.Clear;
end;

end.
