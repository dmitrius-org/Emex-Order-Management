unit uOrderF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel, uniButton,
  uniBitBtn;

type
  TOrderF = class(TUniForm)
    UniPanel1: TUniPanel;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    UniLabel1: TUniLabel;
    lblRowCountL: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    lblCount: TUniLabel;
    lblRowCount: TUniLabel;
    lblSum: TUniLabel;
    lblW: TUniLabel;
    procedure UniFormReady(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }

    isPosExist: Boolean;

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIApplication, MainModule, uMainVar;

{$R *.dfm}


procedure TOrderF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TOrderF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin

  DataCheck();

  if RetVal.Code = 0 then
      begin
        sqltext :=' declare @R      int                       '+
                  ' exec @r = OrderCreateFromBasket           '+
                  '           '+
                  ' select @r as retcode '+
                  ' ';

        Sql.Open(sqltext, [], []);

        RetVal.Code := Sql.Q.FieldByName('retcode').Value;
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

procedure TOrderF.DataCheck;
begin
  RetVal.Clear;

  if not isPosExist then
  begin
    RetVal.Code := 527;
    //RetVal.Message := 'Не выбраны позиции для заказа';
    Exit();
  end
end;

procedure TOrderF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select * from vBasketOrderCount';
  UniMainModule.Query.Open;

  isPosExist :=   UniMainModule.Query.FieldByName('DetailCount').AsInteger > 0;

  lblCount.Text  := UniMainModule.Query.FieldByName('DetailPosCount').AsString;
  lblRowCount.Text  := UniMainModule.Query.FieldByName('DetailCount').AsString;
  lblSum.text:= UniMainModule.Query.FieldByName('OrderAmount').AsString + ' руб.';
  lblW.text:= UniMainModule.Query.FieldByName('OrderWeight').AsString + ' кг.';
end;

procedure TOrderF.UniFormReady(Sender: TObject);
begin
  DataLoad;// начитываем данные с базы
end;

end.
