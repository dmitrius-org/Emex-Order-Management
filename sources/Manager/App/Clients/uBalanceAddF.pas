unit uBalanceAddF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniTabControl, uniPageControl, uniBasicGrid,
  uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, uniMultiItem, uniComboBox, uniWidgets, uniDBComboBox,
  uniDBLookupComboBox, Vcl.Menus, uniMemo, UniFSCombobox;

type
  TBalanceAddF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    pcCommon: TUniPageControl;
    tabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    lblName: TUniLabel;
    tabAudit: TUniTabSheet;
    Query: TFDQuery;
    ImageList16: TUniImageList;
    ActionList: TUniActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshAll: TAction;
    QueryID: TFMTBCDField;
    QueryClientID: TFMTBCDField;
    QueryEmployeeID: TFMTBCDField;
    QueryClientBrief: TWideStringField;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    edtAmount: TUniNumberEdit;
    edtComment: TUniMemo;
    lblDate: TUniLabel;
    edtDate: TUniDateTimePicker;
    cbPayType: TUniFSComboBox;
    UniLabel5: TUniLabel;
    cbClient: TUniFSComboBox;
    UniLabel6: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    FClientID: Integer;
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
    property FormAction: TFormAction read FAction write SetAction;
    property ClientID: Integer read FClientID write FClientID;
    property ID: Integer read FID write FID;
  end;

function BalanceAddF: TBalanceAddF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar, uLogger;

function BalanceAddF: TBalanceAddF;
begin
  Result := TBalanceAddF(UniMainModule.GetFormInstance(TBalanceAddF));
end;

{ TBalanceAddF }

procedure TBalanceAddF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TBalanceAddF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  DataCheck;

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin
      sqltext :='''
                 declare @R           int

                 exec @r = BalanceAdd
                             @ClientID   = :ClientID
                            ,@Amount     = :Amount
                            ,@Date       = :Date
                            ,@Comment    = :Comment
                            ,@Number     = :Number
                            ,@PayType    = :PayType

                 select @r as retcode
      ''';

      Sql.Open(sqltext,
               ['ClientID','Amount','Date','Comment','Number', 'PayType'],
               [cbClient.Value
               ,edtAmount.value
               ,edtDate.DateTime
               ,edtComment.Text
               ,''
               ,cbPayType.Value
               ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

    end;
//    acUpdate:
//    begin
//      sqltext :=' declare @R      int                      '+
//                '                                          '+
//                ' exec @r = EmployeeUpdate                 '+
//                '             @EmployeeID   = :EmployeeID  '+
//                '            ,@Brief        = :Brief       '+
//                '            ,@Name         = :Name        '+
//                '                                          '+
//                ' select @r as retcode      ';
//
//      Sql.Open(sqltext,
//               ['Brief','Name', 'EmployeeID'],
//               [edtBrief.Text,
//               '',
//               FID
//               ]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//    end;
//    acDelete:
//    begin
//      sqltext :=  ' declare @R      int                 '+
//                  '                                     '+
//                  ' exec @r = EmployeeDelete            '+
//                  '         @EmployeeID = :EmployeeID   '+
//                  '                                     '+
//                  ' select @r as retcode                '+
//                  ' ';
//
//      Sql.Open(sqltext, ['EmployeeID'], [FID]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//    end;
  end;

  if RetVal.Code = 0 then
  begin
    //Audit.Add(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TBalanceAddF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin

      if cbClient.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Клиент] обязательно к заполнению!';
        cbClient.SetFocus;
        Exit();
      end;

      if (edtAmount.IsBlank) or (edtAmount.value = 0) then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Сумма] обязательно к заполнению!';
        edtAmount.SetFocus;
        Exit();
      end;

      if edtDate.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Дата] обязательно к заполнению!';
        edtDate.SetFocus;
        Exit();
      end;

      if cbPayType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Тип платежа] обязательно к заполнению!';
        cbPayType.SetFocus;
        Exit();
      end;


    end;
  end;
end;

procedure TBalanceAddF.DataLoad;
begin
//  UniMainModule.Query.Close;
//  UniMainModule.Query.SQL.Text := ' select *  '+
//                                  '   from tClients (nolock) '+
//                                  '  where ClientID = :ClientID '+
//                                  ' ';
//  UniMainModule.Query.ParamByName('ClientID').Value := FID;
//  UniMainModule.Query.Open;

  // аудит
  //edtID.Text         := UniMainModule.Query.FieldValues['UserID'];
  //edtInDate.DateTime := UniMainModule.Query.FieldValues['inDatetime'];
 // edtUpdDate.DateTime:= UniMainModule.Query.FieldValues['updDatetime'];

  //edtBrief.Text:= UniMainModule.Query.FieldValues['Brief'];
end;

procedure TBalanceAddF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TBalanceAddF.UniFormShow(Sender: TObject);
begin

  ComboBoxFill(cbPayType, 'select PropertyID as ID, Name from tProperty (nolock) where ObjectTypeID = 12');
  ComboBoxFill(cbClient, 'select ClientID as ID, Brief as Name from tClients (nolock)');

  tabAudit.Visible:= FAction <> acInsert;

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *  '+
                                  '   from tClients (nolock) '+
                                  '  where ClientID = :ClientID '+
                                  ' ';
  UniMainModule.Query.ParamByName('ClientID').Value := FClientID;
  UniMainModule.Query.Open;

  case FAction of
    acInsert, acReportCreate:
    begin
      Self.Caption := 'Пополнение баланса по клиенту: ' + UniMainModule.Query.FieldbyName('Brief').asString;
      cbClient.Value := FClientID.ToString;
      btnOk.Caption := ' Пополнить';
      edtInDate.Text := '';
      edtUpdDate.Text := '';

      edtDate.DateTime:=now();
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' Сохранить';
    acDelete:
      btnOk.Caption := ' Удалить';
    acShow:
      btnOk.Caption := ' Закрыть';
  else
    btnOk.Caption   := ' Выполнить';
  end;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
    begin
      Self.Caption := 'Пополнение баланса по клиенту: ' + UniMainModule.Query.FieldbyName('Brief').asString;
      DataLoad;
    end
  else
    //
  end;



end;

end.
