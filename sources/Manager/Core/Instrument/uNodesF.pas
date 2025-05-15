unit uNodesF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, FireDAC.Stan.Param,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType, uniRadioGroup, uniPageControl;

type
  TNodesF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    PageBase: TUniPageControl;
    TabCommon: TUniTabSheet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    edtComment: TUniEdit;
    lblBruef: TUniLabel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    edtType: TUniRadioGroup;
    edtN: TUniNumberEdit;
    UniLabel3: TUniLabel;
    TabStateAdditionally: TUniTabSheet;
    cbSyncEmex: TUniCheckBox;
    cbRecalClientDelivery: TUniCheckBox;
    cbRecalSupplierDelivery: TUniCheckBox;
    cbSyncSupplier: TUniCheckBox;
    cbLastTermShipment: TUniCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure edtTypeChangeValue(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;

    FFlag: Integer;

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
    property ID: Integer read FID write FID;
  end;

function NodesF: TNodesF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar;

function NodesF: TNodesF;
begin
  Result := TNodesF(UniMainModule.GetFormInstance(TNodesF));
end;

{ TUserF }

procedure TNodesF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TNodesF.btnOkClick(Sender: TObject);
var sqltext: string;
  procedure SetFalg();
  begin
    FFlag := 0;
    if cbSyncEmex.Checked then
      FFlag := FFlag + 2;
    if cbRecalClientDelivery.Checked then
      FFlag := FFlag + 4;
    if cbRecalSupplierDelivery.Checked then
      FFlag := FFlag + 8;
    if cbSyncSupplier.Checked then
      FFlag := FFlag + 16;
    if cbLastTermShipment.Checked then
      FFlag := FFlag + 32;
  end;
begin
  RetVal.Clear;

  DataCheck();

  if RetVal.Code = 0 then
  case FAction of
    acInsert:
    begin

      SetFalg;

      sqltext :=' declare @R      int                '+
                '        ,@NodeID numeric(18, 0)     '+
                '                                    '+
                ' exec @r = NodeInsert               '+
                '             @NodeID   = @NodeID out'+
                '            ,@Brief    = :Brief     '+
                '            ,@Name     = :Name      '+
                '            ,@Comment  = :Comment   '+
                '            ,@Flag     = :Flag      '+
                '            ,@ColorID  = :ColorID   '+
                '            ,@Type     = :Type      '+
                '            ,@N        = :N         '+
                ' select @r as retcode, @NodeID as NodeID      '+
                ' ';

      Sql.Open(sqltext,
               ['Brief','Name','Comment','Flag', 'ColorID', 'Type', 'N'],
               [edtBrief.Text,
                edtName.Text,
                edtComment.Text,
                FFlag,
                '',
                edtType.ItemIndex,
                edtN.Value]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('NodeID').Value;

    end;
    acUpdate:
    begin
      SetFalg;

      sqltext :='''
                 declare @R      int

                 exec @r = NodeUpdate
                             @NodeID   = :NodeID
                            ,@Name     = :Name
                            ,@Comment  = :Comment
                            ,@Flag     = :Flag
                            ,@ColorID  = :ColorID
                            ,@Type     = :Type
                            ,@N        = :N

                 select @r as retcode
                ''';

      Sql.Open(sqltext,
               ['NodeID','Name','Comment','Flag', 'ColorID', 'Type', 'N'],
               [FID,
                edtName.Text,
                edtComment.Text,
                FFlag,
                '',
                edtType.ItemIndex,
                edtN.Value]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = NodeDelete               '+
                                      '             @NodeID   = :NodeID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('NodeID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
//    TAudit.AuditAdd(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TNodesF.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtBrief.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Сокращение] обязательно к заполнению!';
        Exit();
      end
      else if edtName.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Наименование] обязательно к заполнению!';
        Exit();
      end
      else if edtType.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Тип] обязателено к заполнению!';
        Exit();
      end;
    end;
  end;
end;

procedure TNodesF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select n.*  '+
                                  '   from vNodes n   '+
                                  '  where n.NodeID = :NodeID '+
                                  ' ';
  UniMainModule.Query.ParamByName('NodeID').Value := FID;
  UniMainModule.Query.Open;


  edtBrief.Text     := UniMainModule.Query.FieldByName('Brief').AsString;
  edtName.Text      := UniMainModule.Query.FieldByName('Name').AsString;
  edtComment.Text   := UniMainModule.Query.FieldByName('Comment').AsString;
  edtType.ItemIndex := UniMainModule.Query.FieldByName('Type').AsInteger;
  edtN.Value        := UniMainModule.Query.FieldByName('N').AsInteger;

  FFlag             := UniMainModule.Query.FieldByName('Flag').AsInteger;

  cbSyncEmex.Checked := FFlag and 2 > 0;
  cbRecalClientDelivery.Checked := FFlag and 4 > 0;
  cbRecalSupplierDelivery.Checked := FFlag and 8 > 0;
  cbSyncSupplier.Checked := FFlag and 16 > 0;
  cbLastTermShipment.Checked := FFlag and 32 > 0; //Пересчитывать: Дней до крайней даты отгрузки со склада

end;

procedure TNodesF.edtTypeChangeValue(Sender: TObject);
begin
  TabStateAdditionally.Visible := edtType.ItemIndex = 0;
end;

procedure TNodesF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TNodesF.UniFormShow(Sender: TObject);
begin
  edtBrief.ReadOnly:= FAction <> acInsert;
  edtType.ReadOnly:= FAction <> acInsert;

  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' Сохранить';
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
      DataLoad;
  else
    //DataLoad;
  end;

  PageBase.ActivePageIndex := 0;
end;

end.
