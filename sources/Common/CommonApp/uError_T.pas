unit uError_T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uUtils.Grid, uCommonType, uniImageList, System.ImageList,
  Vcl.ImgList;

type
  TError_T = class(TUniForm)
    Grid: TUniDBGrid;
    DataSource: TDataSource;
    Query: TFDQuery;
    QueryObjectID: TFMTBCDField;
    QueryRetval: TFMTBCDField;
    QueryMessage: TWideStringField;
    QueryMakeLogo: TWideStringField;
    QueryManufacturer: TWideStringField;
    QueryDetailNumber: TWideStringField;
    QueryReference: TWideStringField;
    QueryCustomerSubId: TWideStringField;
    procedure UniFormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
      NewIndex: Integer);
    procedure GridColumnResize(Sender: TUniBaseDBGridColumn; NewSize: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Error_T: TError_T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function Error_T: TError_T;
begin
  Result := TError_T(UniMainModule.GetFormInstance(TError_T));
end;

procedure TError_T.GridAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if Params.Count > 0 then
  begin
    if ((EventName = '_columnhide') or (EventName = '_columnshow')) then
      GridExt.GridLayoutSave(self, Grid, Params, EventName);
  end;
end;

procedure TError_T.GridColumnMove(Column: TUniBaseDBGridColumn; OldIndex,
  NewIndex: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TError_T.GridColumnResize(Sender: TUniBaseDBGridColumn;
  NewSize: Integer);
begin
  GridExt.GridLayout(Self, Grid, tGridLayout.glSave);
end;

procedure TError_T.GridKeyDown(Sender: TObject; var Key: Word;
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

procedure TError_T.UniFormShow(Sender: TObject);
begin
  // восстановление настроек грида для пользователя
  GridExt.GridLayout(Self, Grid, tGridLayout.glLoad);

  // индексы для сортировки
  //GridExt.SortColumnCreate(Grid);

  Query.Close;
  Query.Open;
end;

end.
