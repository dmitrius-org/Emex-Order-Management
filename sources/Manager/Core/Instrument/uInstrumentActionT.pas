unit uInstrumentActionT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, uniGUIBaseClasses, uniBasicGrid, uniDBGrid, uniToolBar,
  uniMultiItem, uniComboBox, uniPanel;

type
  TInstrumentActionT = class(TUniFrame)
    GridUsers: TUniDBGrid;
    Query: TFDQuery;
    DataSource: TDataSource;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    ActionList: TUniActionList;
    actEdit: TAction;
    acInsert: TAction;
    acDelete: TAction;
    actRefreshAll: TAction;
    UpdateSQL: TFDUpdateSQL;
    UniToolBar1: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniHiddenPanel1: TUniHiddenPanel;
    cbMetod: TUniComboBox;
    cbMetodRollback: TUniComboBox;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure acInsertExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure GridUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameReady(Sender: TObject);
  private
    FID: Integer;
    { Private declarations }
    procedure DataRefresh();
    function GetID: Integer;
    procedure SetID(const Value: Integer);


  public
    { Public declarations }

    property ID: Integer read GetID write SetID;
  end;

implementation

uses
  uLogger, uMainVar;

{$R *.dfm}

{ TInstrumentActionT }

procedure TInstrumentActionT.acDeleteExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TInstrumentActionT.acInsertExecute(Sender: TObject);
begin
  Query.Insert;
  Query.FieldByName('ModelID').Value := FID;
  Query.FieldByName('Type').Value := 0;
end;

procedure TInstrumentActionT.actEditExecute(Sender: TObject);
begin
  Query.Edit;
end;

procedure TInstrumentActionT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TInstrumentActionT.DataRefresh;
begin
  logger.Info('TInstrumentActionT.DataRefresh begin');
  begin
    Query.Close();
    Query.ParamByName('ModelID').Value := FID;
    Query.Open();
  end;
  logger.Info('TInstrumentActionT.DataRefresh end');
end;

function TInstrumentActionT.GetID: Integer;
begin
  result:=FID;
end;

procedure TInstrumentActionT.GridUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (CHAR(KEY)='C') AND (SHIFT=[SSCTRL]) then
  begin
    if (Sender is Tunidbgrid) then
    begin
      GridUsers.JSInterface.JSCall('copyToClipboard', []);
    end;
  end;
end;

procedure TInstrumentActionT.SetID(const Value: Integer);
begin
  logger.Info('TInstrumentActionT.SetID begin');
  FID := Value;

  DataRefresh;
  logger.Info('TInstrumentActionT.SetID end');
end;

procedure TInstrumentActionT.UniFrameReady(Sender: TObject);
begin
  ComboBoxFill(cbMetod,' select Brief as Name from tProperty where ObjectTypeID=102 and ((Flag & 1) >0)' );
  ComboBoxFill(cbMetodRollback,' select Brief as Name from tProperty where ObjectTypeID=102 and ((Flag & 2) >0)' );
end;

initialization
  RegisterClass(TInstrumentActionT);

end.
