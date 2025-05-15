unit uGroupF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, FireDAC.Stan.Param,
  uniGUIBaseClasses, uniPanel, uniEdit, uniCheckBox, uniFieldSet, uniLabel,
  uniDateTimePicker, uCommonType;

type
  TGroupF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    fsCommon: TUniFieldSet;
    UniFieldContainer1: TUniFieldContainer;
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    lblBrief: TUniLabel;
    lblName: TUniLabel;
    fsAudit: TUniFieldSet;
    UniFieldContainer2: TUniFieldContainer;
    edtID: TUniEdit;
    edtInDate: TUniDateTimePicker;
    edtUpdDate: TUniDateTimePicker;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function GroupF: TGroupF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uAuditUtils, uSqlUtils, uMainVar;

function GroupF: TGroupF;
begin
  Result := TGroupF(UniMainModule.GetFormInstance(TGroupF));
end;

{ TUserF }

procedure TGroupF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TGroupF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;
  case FAction of
    acInsert:
    begin
      sqltext :=' declare @R      int                '+
                '        ,@GroupID numeric(18, 0)    '+
                ' exec @r = GroupInsert              '+
                '             @GroupID  = @GroupID out'+
                '            ,@Brief    = :Brief     '+
                '            ,@Name     = :Name      '+
                '                                    '+
                ' select @r        retcode  '+
                '       ,@GroupID  GroupID  '+
                ' ';
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      Sql.Open(UniMainModule.Query,
               ['Brief','Name'],
               [edtBrief.Text, edtName.Text]);

      RetVal.Code := UniMainModule.Query.FieldByName('retcode').AsInteger;
      FID := UniMainModule.Query.FieldByName('GroupID').AsInteger;
    end;
    acUpdate:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = GroupUpdate               '+
                                      '             @GroupID  = :GroupID    '+
                                      '            ,@Brief    = :Brief     '+
                                      '            ,@Name     = :Name      '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('GroupID').AsInteger := FID;
      UniMainModule.Query.ParamByName('Brief').AsString := edtBrief.Text;
      UniMainModule.Query.ParamByName('Name').AsString := edtName.Text;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = GroupDelete               '+
                                      '             @GroupID   = :GroupID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('GroupID').AsInteger := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
    end;
  end;

  if RetVal.Code = 0 then
  begin
    Audit.Add(TObjectType.otUser, FID, FAction, '');
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;

end;

procedure TGroupF.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select g.*  '+
                                  '   from vGroups g   '+
                                  '  where g.GroupID = :GroupID '+
                                  ' ';
  UniMainModule.Query.ParamByName('GroupID').AsInteger := FID;
  UniMainModule.Query.Open;

  // аудит
  edtID.Text         := UniMainModule.Query.FieldValues['GroupID'];  // идентификатор
  edtInDate.DateTime := UniMainModule.Query.FieldValues['inDatetime'];
  edtUpdDate.DateTime:= UniMainModule.Query.FieldValues['updDatetime'];
  edtBrief.Text:= UniMainModule.Query.FieldValues['Brief'];
  edtName.Text:= UniMainModule.Query.FieldValues['Name'];

end;

procedure TGroupF.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TGroupF.UniFormShow(Sender: TObject);
begin
//  edtBrief.ReadOnly:= FAction <> acInsert;
  fsAudit.Visible:= FAction <> acInsert;

  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
      edtUpdDate.Text := '';
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
end;

end.
