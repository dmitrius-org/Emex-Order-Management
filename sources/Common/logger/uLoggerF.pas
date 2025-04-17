unit uLoggerF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniGroupBox, uniButton,
  uniBitBtn, uniPanel, uniCheckBox, uniDBCheckBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TLoggerF = class(TUniForm)
    UniGroupBox1: TUniGroupBox;
    UniGroupBox2: TUniGroupBox;
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniGroupBox3: TUniGroupBox;
    UniGroupBox4: TUniGroupBox;
    cbAppClientLog: TUniDBCheckBox;
    DataSource: TDataSource;
    Query: TFDQuery;
    UniDBCheckBox2: TUniDBCheckBox;
    FDUpdateSQL: TFDUpdateSQL;
    cbAppSqlLog: TUniDBCheckBox;
    QueryLoggerSettingsID: TFMTBCDField;
    QueryUserID: TFMTBCDField;
    QueryAppClientLog: TBooleanField;
    QueryAppSqlLog: TBooleanField;
    QueryUsername: TStringField;
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FUserID: Integer;
    FAppName: string;

    { Private declarations }
  public
    { Public declarations }
    property UserID:Integer  read FUserID  write FUserID;
    property AppName: string read FAppName write FAppName;
  end;

function LoggerF: TLoggerF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Quick.Logger, Quick.Logger.Provider.Files;

function LoggerF: TLoggerF;
begin
  Result := TLoggerF(UniMainModule.GetFormInstance(TLoggerF));
end;

procedure TLoggerF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TLoggerF.btnOkClick(Sender: TObject);
begin
  Query.ApplyUpdates();

  with GlobalLogFileProvider do
  begin
      Enabled := cbAppClientLog.Checked;
  end;

  UniMainModule.FDMoniFlatFileClientLink.Tracing := cbAppSqlLog.Checked;

  ModalResult:=mrOK;
end;

procedure TLoggerF.UniFormShow(Sender: TObject);
begin
  Query.Close();
  Query.ParamByName('UserID').Value := FUserID;
  Query.ParamByName('AppName').Value := FAppName;
  Query.Open();


  Self.Caption := 'Настройки логирования: ' +  Query.FieldByName('Username').Value;


end;


end.
