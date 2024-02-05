unit uUploadingRefusals;

//                        выгрузка отказов в excel

interface


uses System.SysUtils, System.UITypes, Variants,  Data.DB,
     FireDAC.Comp.Client, FireDAC.Comp.Script ,  Winapi.ShellAPI,
     Windows, Messages;

Type
  /// <summary>
  /// Класс для обработки отказов
  /// </summary>
  tUploadingRefusals = class
  private
    var FQuery: TFDQuery;
    var FConnection: TFDConnection;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    function Uploading(ASpid: Integer):Integer;
  end;

  procedure ExecFile(const sComand, sParameter : string; var rc : word);

implementation

uses
  uFileU, ComObj;

procedure ExecFile(const sComand, sParameter: string; var rc: word);
var
   sInfo: TStartupInfo;
   pInfo: TProcessInformation;
   sCmd : string;
   ahwnd: HWND;
begin
  FillChar(sInfo, SizeOf(sInfo), 0);
  sInfo.cb := SizeOf(sInfo);
  sInfo.wShowWindow := SW_SHOWMINNOACTIVE;

  sCmd := sComand;
  if (sParameter > '') then sCmd := sCmd + ' ' + sParameter;

  if (Not CreateProcess(Nil, PChar(sCmd), Nil, Nil, False, NORMAL_PRIORITY_CLASS, Nil, Nil, sInfo, pInfo)) then
  begin
    rc := GetLastError;
  end;

  ahwnd:=pInfo.hProcess;
  //wait untill finish
  while WaitForSingleObject(ahwnd, 100)=WAIT_TIMEOUT do
  begin
     //
  end;

  CloseHandle(pInfo.hThread);
end;

{ tUploadingRefusals }

constructor tUploadingRefusals.Create(AConnection: TFDConnection);
begin
  inherited Create();

  if Assigned(AConnection) then
  begin
    FConnection:= AConnection;

    if not Assigned(FQuery) then FQuery := TFDQuery.Create(nil);

    FQuery.Connection :=FConnection;
  end;
end;

destructor tUploadingRefusals.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function tUploadingRefusals.Uploading(ASpid: Integer):Integer;
var
TemplateFile, ExelOtch : String;
     I: Integer;
   cmd: string;
    rc: word;
begin
  result:=0;

  FQuery.Close;
  FQuery.Open('Select Val from tSettings (nolock) where Brief = ''TemplateOrderRefusals''');
  TemplateFile:= FQuery.FieldByName('Val').AsString;
  if TemplateFile= '' then
  begin
    exit(519); // 'Не задан шаблон Excel для экспорта отказов!'
  end
  else
  begin
    if not FileExists(TemplateFile) then exit(522);
  end;

  FQuery.Close;
  FQuery.Open('Select Val from tSettings (nolock) where Brief = ''UploadingRefusalsCatalog''');
  ExelOtch:= FQuery.FieldByName('Val').AsString;
  if ExelOtch= '' then
  begin
    exit(520); // 'Не задана папка для сохранения файлов отказов!'
  end
  else
  begin
    if not DirectoryExists (ExelOtch) then exit(523);
  end;

  FQuery.Close;
  FQuery.Open('Select Val from tSettings (nolock) where Brief = ''UploadingEmexRefusalsScript''');
  cmd:= FQuery.FieldByName('Val').AsString;
  if cmd= '' then
  begin
    exit(521);
  end
  else
  begin
    if not FileExists(cmd) then exit(524);
  end;

  ExecFile(cmd, '', rc);

  Exit(rc);
end;

end.
