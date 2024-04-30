unit uRefusalsT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, uniGUIForm,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniToolBar, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uniEdit, uniPanel, uniCheckBox, uniMultiItem, uniComboBox, uniDBEdit,

  uUserF, uGrant, uCommonType, uniFileUpload;

type
  TRefusalsT = class(TUniFrame)
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actDelete: TAction;
    actUpload: TAction;
    PopupMenu: TUniPopupMenu;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    ImageList16: TUniImageList;
    actRefreshAll: TAction;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    TopPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    Grid: TUniDBGrid;
    Query: TFDQuery;
    QueryOrderRefusalsID: TFMTBCDField;
    QueryFileName: TWideStringField;
    UpdateSQL: TFDUpdateSQL;
    QueryFlag: TIntegerField;
    QueryInDateTime: TSQLTimeStampField;
    UniToolButton1: TUniToolButton;
    actUploadingRefusalsEmex: TAction;
    UniFileUpload: TUniFileUpload;
    GridPanel: TUniContainerPanel;
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actUploadExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFileUploadMultiCompleted(Sender: TObject;
      Files: TUniFileInfoArray);
    procedure UniFrameReady(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure actUploadingRefusalsEmexExecute(Sender: TObject);
  private
    { Private declarations }
    FAction: tFormaction;

    procedure GridRefresh();

    procedure FileList();
  public
    { Public declarations }
    /// <summary>
    ///  UserFCallBack - CallBack обработчик действия на форме редактирования данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);

  end;

  function RefusalsT: TRefusalsT;

implementation

uses
  MainModule, uGrantUtils, uMainVar, uFileU, uLogger, ServerModule, uUploadingRefusals, uToast;

{$R *.dfm}


function RefusalsT: TRefusalsT;
begin
  Result := TRefusalsT(UniMainModule.GetFormInstance(TRefusalsT));
end;

procedure TRefusalsT.actDeleteExecute(Sender: TObject);  var isCancel: Boolean;
begin
  //MessageDlg('Отказ дан?' +#13+#10 , mtConfirmation, mbYesNo,
  MessageDlg('Вы действительно хотите удалить файл?' +#13+#10 , mtConfirmation, mbYesNo,
  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes :
      begin
        isCancel := False;
        if DeleteFile(Query.FieldByName('FileName').AsString) then
          begin
          end;

          UpdateSQL.Commands[arDelete].ParamByName('IsCancel').AsBoolean := isCancel;
          Query.Delete;
      end;

      //mrNo  :
      //  isCancel := False;
      else
        Exit;
    end;


  end);
end;

procedure TRefusalsT.actRefreshAllExecute(Sender: TObject);
begin
  GridRefresh;
end;

procedure TRefusalsT.actUploadExecute(Sender: TObject);
begin
  logger.Info('TRefusalsT.actUploadExecute Begin');
  if Query.RecordCount > 0 then
  begin
    UniSession.SendFile(Query.FieldByName('FileName').AsString);
  end;
  logger.Info('TRefusalsT.actUploadExecute End');
end;

procedure TRefusalsT.actUploadingRefusalsEmexExecute(Sender: TObject);
begin
   UniFileUpload.Execute;
end;

procedure TRefusalsT.FileList;
var sr: TSearchRec;
    filedir: string;
begin
//  MemTable.EmptyDataSet;
//  filedir := sql.GetSetting('UploadingRefusalsCatalog');
//
//  if FindFirst(GetSpecialPath(filedir) + '*.xls', faAnyFile , sr) = 0 then
//  begin
//    repeat
//
//      with MemTable do
//      begin
//         Append;
//         FieldByName('FileName').AsString := sr.Name;
//         FieldByName('FileDate').AsDateTime := sr.TimeStamp;
//        // FieldByName('FileSize').AsFloat := sr.Size;
//         FieldByName('FileDir').AsString := GetSpecialPath(filedir)  + sr.Name;
//         Post;
//      end;
//
//    until FindNext(sr) <> 0;
//    FindClose(sr);
//  end;
end;

procedure TRefusalsT.GridCellContextClick(Column: TUniDBGridColumn; X,
  Y: Integer);
begin
  PopupMenu.Popup(X, Y, Grid)
end;

procedure TRefusalsT.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      Grid.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TRefusalsT.GridRefresh;
begin
  Query.Close;
  Query.Open;
end;

procedure TRefusalsT.UniFileUploadMultiCompleted(Sender: TObject;
  Files: TUniFileInfoArray);
var f:TUniFileInfoClass;
    DestName : string;
    DestFolder : string;

    AFnabled : Boolean;
begin
  logger.Info('TRefusalsT.UniFileUpload1MultiCompleted Begin');
  for f in Files do
  begin
    logger.Info('UniFileUpload1Completed ' + f.FileName);
    logger.Info(ExtractFileName(f.FileName));

    RetVal.Clear;

    DestFolder:= UniServerModule.StartPath+'temp\';
    DestName  := DestFolder+ExtractFileName(f.FileName);

    AFnabled  := CopyFile(PChar(f.Stream.FileName), PChar(DestName), False);

    Sql.Q.Close;
    Sql.Open(' declare @R      int                  ' +
             '                                      ' +
             ' exec @r = OrderRefusalsInsert        ' +
             '             @FileName = :FileName    ' +
             '                                      ' +
             ' select @r as retcode ',
            ['FileName'],
            [DestName]);

    RetVal.Code := Sql.Q.FieldByName('retcode').Value;
    if RetVal.Code = 0 then
    begin

      var e:tUploadingRefusals;
      e:= tUploadingRefusals.Create(UniMainModule.FDConnection);
      try

        RetVal.Code := e.Uploading(SPID);

        if  RetVal.Code > 0   then
          ToastERR(RetVal.Message, UniSession)
        else
          ToastOK('Ответ сформирован!', UniSession)

      finally
        FreeAndNil(e)
      end;

    end
    else
    begin
      ToastERR(RetVal.Message, UniSession);
      logger.Info('TRefusalsT.RetVal.Code:' + RetVal.Code.ToString + ', ' + RetVal.Message);
    end;

  end;
  logger.Info('TRefusalsT.UniFileUpload1MultiCompleted End');
end;

procedure TRefusalsT.UniFrameCreate(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self);
  {$ENDIF}
  Grant.SetGrant(self, ActionList);
end;

procedure TRefusalsT.UniFrameReady(Sender: TObject);
begin
  GridRefresh;
end;

procedure TRefusalsT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin

end;

initialization
  RegisterClass(TRefusalsT);

end.
