unit uOrdersMessageF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  uniMemo;

type



  TOrdersMessageF = class(TUniForm)
    tabCommon: TUniFieldContainer;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    edtMessage: TUniMemo;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);

  private
    FAction: TFormAction;
    FID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;

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

function OrdersMessageF: TOrdersMessageF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

function OrdersMessageF: TOrdersMessageF;
begin
  Result := TOrdersMessageF(UniMainModule.GetFormInstance(TOrdersMessageF));
end;

{ TOrderF }

procedure TOrdersMessageF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TOrdersMessageF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin

  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acCancel:
      begin
        sqltext :=' exec OrderCancelRequest   '+
                  '        @Comment=:Comment  '+
                  '       ,@OrderID=:OrderID  '+
                  ' select 0 as retcode ';

        Sql.Open(sqltext, ['Comment', 'OrderID'], [edtMessage.text, FID]);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
      end;
      acMessage:  // �������� ��������� �� ���������
      begin
        sqltext :=' exec OrderSetComment      '+
                  '        @Comment= :Comment '+
                  '       ,@OrderID= :OrderID '+
                  ' select 0 as retcode ';

        Sql.Open(sqltext, ['Comment', 'OrderID'], ['', FID]);

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

procedure TOrdersMessageF.DataCheck;
begin
end;

procedure TOrdersMessageF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select Comment, Manufacturer, DetailNumber'+
                                  '   from tOrders (nolock)'+
                                  '  where OrderID = :OrderID '+
                                  ' ';
  UniMainModule.Query.ParamByName('OrderID').Value := FID;
  UniMainModule.Query.Open;

  edtMessage.text := UniMainModule.Query.FieldByName('Comment').AsString;
end;

procedure TOrdersMessageF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TOrdersMessageF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acCancel:  // ������ �� �����
    begin
      //edtMessage.ReadOnly := True;
      btnOk.Caption := ' ���������';
    end;
    acMessage:
    begin
      edtMessage.ReadOnly := True;
      btnOk.Caption := ' ���������';
    end;
  else
    btnOk.Caption := ' ���������';
  end;

  // ���������� ������ � ����
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow, acMessage:
    begin
      DataLoad;
      Self.Caption:= '��������� �� ������: ' +
      UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
      UniMainModule.Query.FieldByName('DetailNumber').AsString;
    end;
    acCancel:
    begin
      DataLoad;
      Self.Caption:= '����� �� �������: ' +
      UniMainModule.Query.FieldByName('Manufacturer').AsString + ' ' +
      UniMainModule.Query.FieldByName('DetailNumber').AsString;
    end;
  else
    //
  end;
end;

end.
