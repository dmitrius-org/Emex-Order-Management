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
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    Mainbox: TUniGroupBox;
    Query: TFDQuery;
    cbSqlLog: TUniDBCheckBox;
    QueryLoggerSettingsID: TFMTBCDField;
    QueryUserID: TFMTBCDField;
    QueryUsername: TStringField;
    UniLabel1: TUniLabel;
    QueryLogDestination: TStringField;
    QueryFileLogLevel: TStringField;
    QueryDBLogLevel: TStringField;
    QueryLogSql: TBooleanField;
    LogDestination: TUniCheckComboBox;
    FileEvent: TUniCheckComboBox;
    DBEvent: TUniCheckComboBox;
    MainContainer: TUniContainerPanel;
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FUserID: Integer;
    FAppName: string;
    FID: Integer;

    { Private declarations }
  public
    { Public declarations }
    property UserID:Integer  read FUserID  write FUserID;
    property AppName: string read FAppName write FAppName;
    property ID:Integer  read FID write FID;
  end;

function LoggerF: TLoggerF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Quick.Logger,

  Quick.Logger.Provider.Files,
  Quick.Logger.Provider.ADODB,

  uUtils.Logger, uMainVar, uConstant;

function LoggerF: TLoggerF;
begin
  Result := TLoggerF(UniMainModule.GetFormInstance(TLoggerF));
end;

procedure TLoggerF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TLoggerF.btnOkClick(Sender: TObject);
var sqltext: string;
begin
  Log('TLoggerF.btnOkClick Begin', etDebug);
  sqltext :='''
  UPDATE tLoggerSettings
     SET FileLogLevel   = :FileLogLevel
        ,DBLogLevel     = :DBLogLevel
        ,LogDestination = :LogDestination
        ,LogSql         = :LogSql
   WHERE LoggerSettingsID = :LoggerSettingsID
  ''';

  Sql.Exec(sqltext,
           ['LoggerSettingsID','FileLogLevel','DBLogLevel','LogDestination','LogSql'],
           [FID,
            FileEvent.Text,
            DBEvent.Text,
            LogDestination.Text,
            cbSqlLog.Checked
           ]);

  if UniMainModule.AAppName = AppManager then
  begin
    Log('TLoggerF.btnOkClick BroadcastMessage LoggerManagerRefresh', etDebug);
    Log('TLoggerF.btnOkClick Refresh=%s UserID=%s AppName=%s', ['True', FUserID.ToString, FAppName], etDebug);
    BroadcastMessage('LoggerManagerRefresh',
                    ['Refresh', 'true' , 'UserID', FUserID, 'AppName', FAppName],
                    []); //  boClientOnly boIgnoreCurrentSession

  end;
//  if FID = UniMainModule.AUserID then
//  begin
//
//    //GlobalLogFileProvider
//    if (AnsiPos('В файл', LogDestination.text) > 0) then
//    begin
//      UniMainModule.CreateGlobalLogFileProvider;
//    end;
//
//    if UniMainModule.ALogger.Providers.IndexOf(UniMainModule.GlobalLogFileProvider)>-1 then
//    with UniMainModule.GlobalLogFileProvider do
//    begin
//      LogLevel:= ParseLogLevel(FileEvent.text);
//      Enabled := (AnsiPos('В файл', LogDestination.text) > 0);
//
//      if Enabled then
//        Log('Включено логирование в файл', etInfo)
//      else
//        Log('Оключено логирование в файл', etInfo)
//    end;
//
//    //GlobalLogADODBProvider
//    if (AnsiPos('В базу данных', LogDestination.text) > 0) then
//    begin
//      UniMainModule.CreateGlobalLogADODBProvider;
//    end;
//
//    if UniMainModule.ALogger.Providers.IndexOf(UniMainModule.GlobalLogADODBProvider)>-1 then   //В файл;В базу данных
//    with UniMainModule.GlobalLogADODBProvider do
//    begin
//      LogLevel:= ParseLogLevel(DBEvent.text);
//      Enabled := (AnsiPos('В базу данных', LogDestination.text) > 0);
//      if Enabled then
//        Log('Включено логирование в базу данных', etInfo)
//      else
//        Log('Оключено логирование в базу данных', etInfo)
//    end;
//
//    if (AnsiPos('В файл', LogDestination.text) > 0)or
//       (AnsiPos('В базу данных', LogDestination.text) > 0)
//    then
//    begin
//      UniMainModule.FDConnection.Params.MonitorBy := mbCustom;
//      UniMainModule.FDMoniSQl.Tracing := cbSqlLog.Checked;
//    end;
//  end

  ModalResult:=mrOK;
  Log('TLoggerF.btnOkClick End', etDebug);
end;

procedure TLoggerF.UniFormShow(Sender: TObject);
begin
  Query.Close();
  Query.ParamByName('UserID').Value := FUserID;
  Query.ParamByName('AppName').Value := FAppName;
  Query.Open();

  FID:= Query.FieldByName('LoggerSettingsID').AsInteger;
  LogDestination.Text := Query.FieldByName('LogDestination').AsString;
  FileEvent.Text := Query.FieldByName('FileLogLevel').AsString;
  DBEvent.Text := Query.FieldByName('DBLogLevel').AsString;
  cbSqlLog.Checked := Query.FieldByName('LogSql').AsBoolean;


  Self.Caption := 'Настройки логирования: ' +  Query.FieldByName('Username').Value;
end;


end.
