unit uChatMessageF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel,
  uniLabel, uniEdit, uCommonType, Vcl.ExtCtrls, uniGroupBox, Math, uniMultiItem,
  uniComboBox, uniImageList, uniHTMLFrame, uniURLFrame,

  Data.DB,FireDAC.Comp.Client, FireDAC.Comp.Script, uniThreadTimer, uniTimer,
  uniMemo, uUniMemoHelper;

type



  TChatMessageF = class(TUniForm)
    tabCommon: TUniFieldContainer;
    btnCancel: TUniBitBtn;
    btnOk: TUniBitBtn;
    edtMessage: TUniMemo;
    edtSubject: TUniEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);

  private
    FAction: TFormAction;
    FID: Integer;

    FDetailNumber: string;
    FDetailNumber2: string;
    FPriceLogo: string;

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

//    procedure SetTaskTypeProperty();
//    procedure SetPeriodTypeProperty();


  public
    { Public declarations }
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function ChatMessageF: TChatMessageF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uEmexUtils;

function ChatMessageF: TChatMessageF;
begin
  Result := TChatMessageF(UniMainModule.GetFormInstance(TChatMessageF));
end;

{ TOrderF }

procedure TChatMessageF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TChatMessageF.btnOkClick(Sender: TObject);
 var sqltext: string;
     Field:string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
    case FAction of
      acInsert:
      begin
        sql.Open(
        '''
          declare @ChatID    numeric(18, 0)
                 ,@MessageID numeric(18, 0)

          exec ChatsInsert
                @ChatID   = @ChatID out
               ,@ClientID = :ClientID
               ,@Name     = :Name

          if @ChatID > 0
          begin
            exec ChatsMessageInsert
                   @ChatID   = @ChatID
                  ,@UserID   = :ClientID
                  ,@Message  = :Message
                  ,@Flag     = 0
                  ,@MessageID= @MessageID out
          end

          select 0       as retval
                ,@ChatID as ChatID

        ''',
        ['ClientID', 'Name', 'Message'],
        [UniMainModule.AUserID,
         edtSubject.Text,
         edtMessage.ToHTML]);

        RetVal.Code := Sql.Q.FieldByName('retval').Value;
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

procedure TChatMessageF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin

      if edtSubject.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Тема] обязательно к заполнению!';
        edtSubject.SetFocus;
        Exit();
      end;

      if (edtMessage.IsBlank)  then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Вопрос] обязательно к заполнению!';
        edtMessage.SetFocus;
        Exit();
      end;
    end;
  end;
end;

procedure TChatMessageF.DataLoad;
begin
//  UniMainModule.Query.Close;
//  UniMainModule.Query.SQL.Text := ' ';
//  UniMainModule.Query.ParamByName('OrderID').Value := FID;
//  UniMainModule.Query.Open;
//
//  edtMessage.text := UniMainModule.Query.FieldByName('Comment').AsString;
end;

procedure TChatMessageF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TChatMessageF.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Создать новое обращение';
      btnOk.Caption := ' Отправить';

      edtMessage.Clear;
      edtSubject.Clear;
    end;
//    acUpdate, acReportEdit, acUserAction:
//    begin
//      btnOk.Caption := ' Сохранить';
//
//    end;
//    acDelete:
//    begin
//      edtMessage.ReadOnly := True;
//      btnOk.Caption := ' Удалить';
//    end;
//    acShow:
//    begin
//      edtMessage.ReadOnly := True;
//      btnOk.Caption := ' Закрыть';
//    end;
//    acMessage:
//    begin
//      edtMessage.ReadOnly := True;
//      btnOk.Caption := ' Прочитано';
//    end;
  else
    btnOk.Caption := ' Выполнить';
  end;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow, acMessage:
    begin
      DataLoad;
    end
  else
    //
  end;
end;

end.
