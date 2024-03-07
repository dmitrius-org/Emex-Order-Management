unit uTaskProcedure_F;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel, uCommonType,
  uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniLabel,
  uniEdit, uniCheckBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTaskProcedure_F = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    edtLinkID: TUniDBLookupComboBox;
    ebtIsActive: TUniCheckBox;
    edtComment: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    DataSource: TDataSource;
    FDQuery: TFDQuery;
    edtNumber: TUniNumberEdit;
    UniLabel3: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;

    procedure SetAction(const Value: TFormAction);

    /// <summary>
    ///  DataLoad - ��������� ������ � �������, ��� ����������� �� �����
    ///</summary>
    procedure DataLoad();
    { Private declarations }
  public
    { Public declarations }
    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function TaskProcedure_F: TTaskProcedure_F;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uVarUtils;

function TaskProcedure_F: TTaskProcedure_F;
begin
  Result := TTaskProcedure_F(UniMainModule.GetFormInstance(TTaskProcedure_F));
end;

{ TTaskProcedure_F }

procedure TTaskProcedure_F.btnOkClick(Sender: TObject);
 var sqltext: string;
       Field: string;

begin



   case FAction of
    acInsert:
    begin
      sqltext :=' declare @R      int                 '+
                '        ,@ID     numeric(18, 0)      '+
                '                                     '+
                ' exec @r = TaskActionAdd             '+
                '             @ID       = @ID    out  '+
                '            ,@TaskID   = :TaskID     '+
                '            ,@Number   = :Number     '+
                '            ,@Comment  = :Comment    '+
                '            ,@TaskType = 0           '+
                '            ,@LinkID   = :LinkID     '+
                '            ,@IsActive = :IsActive   '+
                '                                     '+
                ' select @r as retcode, @ID  as ID    '+
                ' ';

      Sql.Open(sqltext,
               ['TaskID','Number','Comment', 'LinkID', 'IsActive'],
               [null,
                edtNumber.Text,
                edtComment.Text,
                vartoint(edtLinkID.KeyValue),
                ebtIsActive.Checked
                ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('ID').Value;

    end;
//    acUpdate:
//    begin
//      sqltext :=' declare @R      int                 '+
//                '                                     '+
//                ' exec @r = TaskUpdate                '+
//                '             @TaskID    = :TaskID    '+
//                '            ,@Brief     = :Brief     '+
//                '            ,@Name      = :Name      '+
//                '            ,@TaskType  = :TaskType  '+
//                '            ,@PeriodType= :PeriodType'+
//                '            ,@DateBegin = :DateBegin '+
//                '            ,@IsActive  = :IsActive  '+
//                '            ,@Field     = :Field     '+
//                '            ,@LinkID    = :LinkID    '+
//                '            ,@TimeBegin = :TimeBegin '+
//                '            ,@TimeEnd   = :TimeEnd   '+
//                '            ,@DayPeriod = :DayPeriod '+
//                '            ,@TimePeriod= :TimePeriod'+
//                '            ,@Flag      = :Flag      '+
//                '                                     '+
//                ' select @r as retcode                '+
//                ' ';
//
//      Sql.Open(sqltext,
//               ['TaskID', 'Brief','Name','TaskType', 'PeriodType', 'DateBegin',
//                'IsActive', 'Field', 'LinkID', 'TimeBegin', 'TimeEnd',
//                'DayPeriod', 'TimePeriod', 'Flag'],
//               [FID,
//                edtBrief.Text,
//                edtName.Text,
//                edtTaskType.ItemIndex,
//                edtPeriodType.ItemIndex,
//                edtDateBegin.DateTime,
//                ebtIsActive.Checked,
//                Field,
//                vartoint(edtLinkID.KeyValue),
//                edtTimeBegin.DateTime,
//                edtTimeEnd.DateTime,
//                edtDayPeriod.Value,
//                edtTimePeriod.DateTime,
//                FFlag
//                ]);
//
//      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
//    end;
//    acDelete:
//    begin
//      UniMainModule.Query.Close;
//      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
//                                      '         '+
//                                      ' exec @r = TaskDelete               '+
//                                      '             @TaskID   = :TaskID    '+
//                                      '                                    '+
//                                      ' select @r as retcode               '+
//                                      ' ';
//
//      UniMainModule.Query.ParamByName('TaskID').Value := FID;
//      UniMainModule.Query.Open;
//      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
//    end;
//   end;
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

procedure TTaskProcedure_F.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *  '+
                                  '   from tTaskActions (nolock)   '+
                                  '  where TaskActionsID = :TaskActionsID '+
                                  ' ';
  UniMainModule.Query.ParamByName('TaskActionsID').Value := FID;
  UniMainModule.Query.Open;

  edtComment.Text:= UniMainModule.Query.FieldByName('Comment').AsString;
  ebtIsActive.Checked:= UniMainModule.Query.FieldByName('IsActive').AsBoolean;
  edtLinkID.KeyValue:=  UniMainModule.Query.FieldByName('LinkID').AsInteger;
end;

procedure TTaskProcedure_F.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TTaskProcedure_F.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQuery.Close;
end;

procedure TTaskProcedure_F.UniFormShow(Sender: TObject);
begin

  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' ��������';
    end;
    acUpdate, acReportEdit, acUserAction:
      btnOk.Caption := ' ���������';
    acDelete:
      btnOk.Caption := ' �������';
    acShow:
      btnOk.Caption := ' �������';
  else
    btnOk.Caption := ' ���������';
  end;

  FDQuery.Close;
  FDQuery.SQL.Text := 'select PropertyID, Brief, Name from tProperty (nolock) where ObjectTypeID = :ObjectTypeID';
  FDQuery.ParamByName('ObjectTypeID').AsInteger := 101;
  FDQuery.Open;

  // ���������� ������ � ����
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  end;
end;

end.
