unit uSuppliersPriceT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseT, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList,
  Data.DB, FireDAC.Comp.DataSet, uniGUIClasses, uniBasicGrid, uniDBGrid,
  uniGUIBaseClasses, uniPanel, uniToolBar, MainModule, uniMultiItem, uniComboBox;

type
  TSuppliersPriceT = class(TBaseT)
    UniPanel: TUniPanel;
    ToolBar: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton4: TUniToolButton;
    actInsert: TAction;
    actEdit: TAction;
    actDelete: TAction;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    UniToolButton3: TUniToolButton;
    QueryDeliveryType: TStringField;
    QueryName: TStringField;
    QueryComment: TStringField;
    QueryDeliveryTerm: TIntegerField;
    QueryInWorkingDays: TBooleanField;
    QueryShowInSearch: TBooleanField;
    QueryID: TFMTBCDField;
    UniHiddenPanel1: TUniHiddenPanel;
    cbDeliveryType: TUniComboBox;
    procedure actInsertExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
  private
    procedure MenuEnabled;
    { Private declarations }
  public
    { Public declarations }
    procedure DataRefresh(); override;
  end;

var
  SuppliersPriceT: TSuppliersPriceT;

implementation

{$R *.dfm}

procedure TSuppliersPriceT.actDeleteExecute(Sender: TObject);
begin
  MessageDlg('Вы действительно хотите удалить Прайс? ' , mtConfirmation, mbYesNo,
  procedure(Sender: TComponent; Res: Integer)
  begin
    case Res of
      mrYes :
      begin
        Query.Delete;
      end;
      mrNo  : Exit;
    end;
  end
  );
end;

procedure TSuppliersPriceT.actEditExecute(Sender: TObject);
begin
  Query.Edit;
end;

procedure TSuppliersPriceT.actInsertExecute(Sender: TObject);
begin
  Query.Insert;
end;

procedure TSuppliersPriceT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TSuppliersPriceT.DataRefresh;
begin
  ShowMask('Ждите, операция выполняется');
  UniSession.Synchronize;
  try
    Query.Close;
    Query.Open;

    MenuEnabled;

    inherited;
  finally
    HideMask();
    UniSession.Synchronize;
  end;
end;

procedure TSuppliersPriceT.MenuEnabled;
begin

end;


end.
