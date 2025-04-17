unit utest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  uniGUIBaseClasses, uniImageList, Data.DB, FireDAC.Comp.DataSet, uniBasicGrid,
  uniDBGrid, uniGUIClasses, uniPanel, uniCheckBox, uniEdit, uniButton,
  uniBitBtn, uniGroupBox, uniToolBar, uCommonType, uniGUIFrame, uBaseT;

type
  Ttest = class(TBaseT)
    actdelete: TAction;
    actTest1: TUniMenuItem;
    ToolBars: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    gbFilter: TUniGroupBox;
    procedure actdeleteExecute(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
    { Private declarations }
    procedure EditCallBack(Sender: TComponent; AResult:Integer);
  public
    { Public declarations }
    procedure DataRefresh(); override;

    property ClientID: Integer read FClientID write SetClientID;
  end;

var
  test: Ttest;

implementation

{$R *.dfm}

procedure Ttest.actdeleteExecute(Sender: TObject);
begin
  inherited;
 //
end;

procedure Ttest.DataRefresh;
begin
 //

end;

procedure Ttest.EditCallBack(Sender: TComponent; AResult: Integer);
begin
//
end;

procedure Ttest.SetClientID(const Value: Integer);
begin
  FClientID := Value;
end;

initialization
  RegisterClass(Ttest);

end.
