unit uTaskBat_F;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel, uCommonType,
  uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniLabel,
  uniEdit, uniCheckBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniSyntaxEditorBase,
  uniSyntaxEditor;

type
  TTaskBAT_F = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    DataSource: TDataSource;
    FDQuery: TFDQuery;
    edtpath: TUniEdit;
    UniLabel2: TUniLabel;
    edtIsActive: TUniCheckBox;
    edtComment: TUniEdit;
    UniLabel1: TUniLabel;
    edtNumber: TUniNumberEdit;
    UniLabel3: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtpathDblClick(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;

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

function TaskBAT_F: TTaskBAT_F;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uSqlUtils, uMainVar, uUtils.Varriant;

function TaskBAT_F: TTaskBAT_F;
begin
  Result := TTaskBAT_F(UniMainModule.GetFormInstance(TTaskBAT_F));
end;

{ TTaskProcedure_F }

procedure TTaskBAT_F.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TTaskBAT_F.btnOkClick(Sender: TObject);
 var sqltext: string;
begin
  DataCheck();

  if RetVal.Code = 0 then
  begin
   case FAction of
    acInsert:
    begin
      sqltext :=' declare @R      int                 '+
                '        ,@ID     numeric(18, 0)      '+
                '                                     '+
                ' exec @r = TaskActionAdd             '+
                '             @ID       = @ID    out  '+
                '            ,@Number   = :Number     '+
                '            ,@Comment  = :Comment    '+
                '            ,@TaskType = 1           '+
                '            ,@Field    = :Field      '+
                '            ,@IsActive = :IsActive   '+
                '                                     '+
                ' select @r as retcode, @ID  as ID    '+
                ' ';

      Sql.Open(sqltext,
               ['Number','Comment', 'Field', 'IsActive'],
               [edtNumber.Text,
                edtComment.Text,
                edtpath.Text,
                edtIsActive.Checked
                ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;

      FID :=  Sql.Q.FieldByName('ID').Value;
    end;
    acUpdate:
    begin
      sqltext :=' declare @R      int                 '+
                '                                     '+
                ' exec @r = TaskActionUpdate          '+
                '             @ID       = :ID         '+
                '            ,@Number   = :Number     '+
                '            ,@Comment  = :Comment    '+
                '            ,@Field    = :Field      '+
                '            ,@IsActive = :IsActive   '+
                '                                     '+
                ' select @r as retcode    '+
                ' ';

      Sql.Open(sqltext,
               ['ID','Number','Comment', 'Field', 'IsActive'],
               [FID,
                edtNumber.Text,
                edtComment.Text,
                edtpath.Text,
                edtIsActive.Checked
                ]);

      RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    end;
    acDelete:
    begin
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := ' declare @R      int                '+
                                      '         '+
                                      ' exec @r = TaskActionDelete               '+
                                      '             @ID   = :ID    '+
                                      '                                    '+
                                      ' select @r as retcode               '+
                                      ' ';

      UniMainModule.Query.ParamByName('ID').Value := FID;
      UniMainModule.Query.Open;
      RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
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

procedure TTaskBAT_F.DataCheck;
begin
  RetVal.Clear;

  case FAction of
    acInsert, acReportCreate, acUpdate, acReportEdit:
    begin
      if edtNumber.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Номер] обязательно к заполнению!'; Exit();
      end
      else if edtComment.IsBlank then
      begin
        RetVal.Code := 1;
        RetVal.Message := 'Поле [Описание] обязательно к заполнению!'; Exit();
      end;
    end;
  end;
end;

procedure TTaskBAT_F.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select *               '+
                                  '   from pTaskActions (nolock)   '+
                                  '  where ID = :ID '+
                                  ' ';
  UniMainModule.Query.ParamByName('ID').Value := FID;
  UniMainModule.Query.Open;

  edtNumber.Text     :=  UniMainModule.Query.FieldByName('Number').AsString;
  edtComment.Text    := UniMainModule.Query.FieldByName('Comment').AsString;
  edtIsActive.Checked:= UniMainModule.Query.FieldByName('IsActive').AsBoolean;
  edtpath.Text       :=  UniMainModule.Query.FieldByName('Field').Value;
end;

procedure TTaskBAT_F.edtpathDblClick(Sender: TObject);
begin
// if FileOpenDialog.Execute then
//    if FileExists(FileOpenDialog.FileName) then
//        edtpath.Text := FileOpenDialog.FileName;
end;

procedure TTaskBAT_F.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TTaskBAT_F.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQuery.Close;
end;

procedure TTaskBAT_F.UniFormShow(Sender: TObject);
begin
  case FAction of
    acInsert, acReportCreate:
    begin
      btnOk.Caption := ' Добавить';
      Self.Caption := 'Добавление действия';
    end;

    acUpdate, acReportEdit, acUserAction:
    begin
      btnOk.Caption := ' Сохранить';
      Self.Caption := 'Изменение действия';
    end;
    acDelete:
    begin
      btnOk.Caption := ' Удалить';
      Self.Caption := 'Удаление действия';
    end;
    acShow:
    begin
      btnOk.Caption := ' Закрыть';
      Self.Caption := 'Просмотр действия';
    end
  else
    btnOk.Caption := ' Выполнить';
    Self.Caption := 'Действие';
  end;

  FDQuery.Close;
  FDQuery.SQL.Text := 'select PropertyID, Brief, Name from tProperty (nolock) where ObjectTypeID = 101';
  FDQuery.Open;

  // начитываем данные с базы
  case FAction of
    acUpdate, acReportEdit, acUserAction, acDelete, acShow:
      DataLoad;
  end;
end;

end.
