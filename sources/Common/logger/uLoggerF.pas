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
    procedure btnOkClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoggerF: TLoggerF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uLogger;

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

  logger.isActive := cbAppClientLog.Checked;
  UniMainModule.FDMoniFlatFileClientLink.Tracing := cbAppSqlLog.Checked;

  ModalResult:=mrOK;
end;

procedure TLoggerF.UniFormShow(Sender: TObject);
begin
  Query.Open();
end;

end.
