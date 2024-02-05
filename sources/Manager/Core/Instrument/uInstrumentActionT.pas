unit uInstrumentActionT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, uniGUIBaseClasses, uniBasicGrid, uniDBGrid, uniToolBar;

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
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure acInsertExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
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
  uLogger;

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

procedure TInstrumentActionT.SetID(const Value: Integer);
begin
  logger.Info('TInstrumentActionT.SetID begin');
  FID := Value;

  DataRefresh;
  logger.Info('TInstrumentActionT.SetID end');
end;

initialization
  RegisterClass(TInstrumentActionT);

end.
