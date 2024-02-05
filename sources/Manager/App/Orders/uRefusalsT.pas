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

  uUserF, uGrant, uCommonType;

type
  TRefusalsT = class(TUniForm)
    DataSource: TDataSource;
    ImageList32: TUniImageList;
    ActionList: TUniActionList;
    actDelete: TAction;
    actUpload: TAction;
    PopupMenu: TUniPopupMenu;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    ImageList16: TUniImageList;
    hdFilter: TUniHiddenPanel;
    fUserID: TUniEdit;
    fName: TUniEdit;
    fBrief: TUniEdit;
    fisAdmin: TUniCheckBox;
    actRefreshAll: TAction;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    fisBlock: TUniCheckBox;
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniPanel2: TUniPanel;
    Grid: TUniDBGrid;
    UniHiddenPanel: TUniHiddenPanel;
    Query: TFDQuery;
    QueryOrderRefusalsID: TFMTBCDField;
    QueryFileName: TWideStringField;
    UpdateSQL: TFDUpdateSQL;
    QueryFlag: TIntegerField;
    QueryInDateTime: TSQLTimeStampField;
    procedure GridCellContextClick(Column: TUniDBGridColumn; X,
      Y: Integer);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure actUploadExecute(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  MainModule, uGrantUtils, uMainVar, uFileU, uLogger;

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

procedure TRefusalsT.UniFormShow(Sender: TObject);
begin
  {$IFDEF Debug}
  Grant.GrantTemplateCreate(self, 'TOrdersT.actFormRefusalsOpen');
  {$ENDIF}
  Grant.SetGrant(self, ActionList);

  GridRefresh
end;

procedure TRefusalsT.UserFCallBack(Sender: TComponent; AResult: Integer);
begin

end;

end.
