unit uInstrumentStateT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, uniGUIBaseClasses, uniBasicGrid, uniDBGrid;

type
  TInstrumentStateT = class(TUniFrame)
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
    actRefreshAll: TAction;
    UpdateSQL: TFDUpdateSQL;
    QueryNodeExtID: TFMTBCDField;
    QueryNodeID: TFMTBCDField;
    QueryBrief: TWideStringField;
    QueryComment: TWideStringField;
    QueryFlag: TIntegerField;
    QueryType: TIntegerField;
    acInsert: TAction;
    acDelete: TAction;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure acInsertExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure GridUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FID: Integer;
    procedure DataRefresh();
    function GetID: Integer;
    procedure SetID(const Value: Integer);
  public
    { Public declarations }
    property ID: Integer read GetID write SetID;
  end;

implementation

{$R *.dfm}

{ TInstrumentStateT }

procedure TInstrumentStateT.acDeleteExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TInstrumentStateT.acInsertExecute(Sender: TObject);
begin
  Query.Insert;
end;

procedure TInstrumentStateT.actEditExecute(Sender: TObject);
begin
  Query.Edit;
end;

procedure TInstrumentStateT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TInstrumentStateT.DataRefresh;
begin
//
//    Query.Close();
//    Query.ParamByName('GroupID').Value := FID;
//    Query.Open();
end;

function TInstrumentStateT.GetID: Integer;
begin
  Result:=FID;
end;

procedure TInstrumentStateT.GridUsersKeyDown(Sender: TObject; var Key: Word;
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

procedure TInstrumentStateT.SetID(const Value: Integer);
begin
  FID := Value;

  DataRefresh;
end;

initialization
  RegisterClass(TInstrumentStateT);

end.
