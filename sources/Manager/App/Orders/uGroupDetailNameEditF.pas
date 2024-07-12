unit uGroupDetailNameEditF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer;

type



  TGroupDetailNameEditF = class(TUniForm)
    tabCommon: TUniFieldContainer;
    edtDetailName: TUniEdit;
    lblDetailNameF: TUniLabel;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
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
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    /// <summary>
    ///  DataCheck - проверка заполнения обязательных полей
    ///</summary>
    procedure DataCheck();

  public
    { Public declarations }
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function GroupDetailNameEditF: TGroupDetailNameEditF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

function GroupDetailNameEditF: TGroupDetailNameEditF;
begin
  Result := TGroupDetailNameEditF(UniMainModule.GetFormInstance(TGroupDetailNameEditF));
end;

{ TOrderF }

procedure TGroupDetailNameEditF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;


procedure TGroupDetailNameEditF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin
  //if UniTimer1.Enabled  then
  //  UniTimer1.Destroy;

  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acUpdate:
      begin
        sqltext :=' declare @R      int                   '+
                  '                                       '+
                  ' exec @r = GroupDetailNameUpdate       '+
                  '             @DetailName = :DetailName '+
                  ' '+
                  ' select @r as retcode ';

        Sql.Open(sqltext, ['DetailName'], [edtDetailName.Text]);

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

procedure TGroupDetailNameEditF.DataCheck;
begin
  RetVal.Clear;

//  case FAction of
//    acInsert, acReportCreate, acUpdate, acReportEdit:
//    begin
//      if edtBrief.IsBlank then
//      begin
//        RetVal.Code := 1;
//        RetVal.Message := 'Поле [Сокращение] обязательна к заполнению!'; Exit();
//      end
//    end;
//  end;
end;

procedure TGroupDetailNameEditF.DataLoad;
begin
  //
end;

procedure TGroupDetailNameEditF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TGroupDetailNameEditF.UniFormShow(Sender: TObject);
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

  edtDetailName.Clear;
end;

end.
