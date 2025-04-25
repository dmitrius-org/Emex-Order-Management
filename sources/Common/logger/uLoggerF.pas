unit uLoggerF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniGroupBox, uniButton,
  uniBitBtn, uniPanel, uniCheckBox, uniDBCheckBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniLabel, uniMultiItem,
  uniComboBox, uUniADCheckComboBoxEx, uniDBComboBox;

type
  TLoggerF = class(TUniForm)
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    UniGroupBox4: TUniGroupBox;
    DataSource: TDataSource;
    Query: TFDQuery;
    FDUpdateSQL: TFDUpdateSQL;
    cbAppSqlLog: TUniDBCheckBox;
    QueryLoggerSettingsID: TFMTBCDField;
    QueryUserID: TFMTBCDField;
    QueryUsername: TStringField;
    UniLabel1: TUniLabel;
    QueryLogDestination: TStringField;
    LogDestination: TUniDBCheckComboBox;
    FileEvent: TUniDBCheckComboBox;
    QueryFileLogLevel: TStringField;
    QueryDBLogLevel: TStringField;
    DBEvent: TUniDBCheckComboBox;
    QueryLogSql: TBooleanField;
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
  MainModule, uniGUIApplication, Quick.Logger,

  Quick.Logger.Provider.Files,
  Quick.Logger.Provider.ADODB,

  uUtils.Logger;

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

  //GlobalLogFileProvider
  if (AnsiPos('В файл', LogDestination.text) > 0) then
  begin
    UniMainModule.CreateGlobalLogFileProvider;
  end;

  if UniMainModule.ALogger.Providers.IndexOf(UniMainModule.GlobalLogFileProvider)>-1 then
  with UniMainModule.GlobalLogFileProvider do
  begin
    LogLevel:= ParseLogLevel(FileEvent.text);
    Enabled := (AnsiPos('В файл', LogDestination.text) > 0);

    if Enabled then
      Log('Включено логирование в файл', etInfo)
    else
      Log('Оключено логирование в файл', etInfo)
  end;

  //GlobalLogADODBProvider
  if (AnsiPos('В базу данных', LogDestination.text) > 0) then
  begin
    UniMainModule.CreateGlobalLogADODBProvider;
  end;

  if UniMainModule.ALogger.Providers.IndexOf(UniMainModule.GlobalLogADODBProvider)>-1 then   //В файл;В базу данных
  with UniMainModule.GlobalLogADODBProvider do
  begin
    LogLevel:= ParseLogLevel(DBEvent.text);
    Enabled := (AnsiPos('В базу данных', LogDestination.text) > 0);
    if Enabled then
      Log('Включено логирование в базу данных', etInfo)
    else
      Log('Оключено логирование в базу данных', etInfo)
  end;

  if (AnsiPos('В файл', LogDestination.text) > 0)or
     (AnsiPos('В базу данных', LogDestination.text) > 0)
  then
  begin
    UniMainModule.FDConnection.Params.MonitorBy := mbCustom;
    UniMainModule.FDMoniSQl.Tracing := cbAppSqlLog.Checked;
  end;

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
