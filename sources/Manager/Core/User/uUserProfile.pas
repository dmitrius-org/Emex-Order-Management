unit uUserProfile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FireDAC.Stan.Param,
  uniGUIClasses, uniGUIForm, uCommonType, uniLabel, uniGUIBaseClasses, uniEdit,
  uniButton, uniBitBtn, uniPanel;

type
  TUserProfile = class(TUniForm)
    edtBrief: TUniEdit;
    edtName: TUniEdit;
    Email: TUniEdit;
    lblBrief: TUniLabel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    loginbox: TUniContainerPanel;
    procedure UniFormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FAction: TFormAction;
    FID: Integer;
    procedure SetAction(const Value: TFormAction);
    { Private declarations }
  public
    { Public declarations }
    /// <summary>
    ///  DataLoad - получение данных с сервера, для отображения на форме
    ///</summary>
    procedure DataLoad();

    property FormAction: TFormAction read FAction write SetAction;
    property ID: Integer read FID write FID;
  end;

function UserProfile: TUserProfile;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uUtils.Controll, uMainVar;

function UserProfile: TUserProfile;
begin
  Result := TUserProfile(UniMainModule.GetFormInstance(TUserProfile));
end;

{ TUserProfile }

procedure TUserProfile.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TUserProfile.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  RetVal.Clear;

  if RetVal.Code = 0 then
  case FAction of
    acUpdate:
    begin
      sqltext :='''
                 declare @R      int

                 exec @r = UserProfileEdit
                             @UserID   = :UserID
                            ,@Name     = :Name
                            ,@Email    = :Email

                 select @r as retcode
                ''';
      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      Sql.Open(UniMainModule.Query,
               ['UserID', 'Name', 'Email'],
               [FID,
                edtName.Text,
                Email.Text]
                );

      RetVal.Code := UniMainModule.Query.FieldByName('retcode').AsInteger;
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

procedure TUserProfile.DataLoad;
begin
  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' select u.*  '+
                                  '   from vUsers u   '+
                                  '  where u.UserID = :UserID '+
                                  ' ';
  UniMainModule.Query.ParamByName('UserID').AsInteger := FID;
  UniMainModule.Query.Open;


  edtBrief.Text        := UniMainModule.Query.FieldByName('Brief').AsString;
  edtName.Text         := UniMainModule.Query.FieldByName('Name').AsString;
  Email.Text           := UniMainModule.Query.FieldByName('Email').AsString;

  Caption := 'Пользователь [' + edtBrief.Text   + ']';
end;

procedure TUserProfile.SetAction(const Value: TFormAction);
begin
  FAction := Value;
end;

procedure TUserProfile.UniFormShow(Sender: TObject);
begin
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
  end;

  Disabled(edtBrief);
end;

end.
