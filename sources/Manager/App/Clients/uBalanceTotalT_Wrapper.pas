unit uBalanceTotalT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uBalanceTotalT,
  uniLabel, uniMultiItem, uniComboBox, UniFSCombobox;

type
  TBalanceTotalT_W = class(TUniForm)
    UniPanel1: TUniPanel;
    cbClient: TUniFSComboBox;
    UniLabel6: TUniLabel;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure cbClientSelect(Sender: TObject);
  private
    FClientID: Integer;
    procedure SetClientID(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }

    property ClientID: Integer  read FClientID write SetClientID;
  end;

function BalanceTotalT_W: TBalanceTotalT_W;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uMainVar;

var BalanceTotal: TBalanceTotalT;

function BalanceTotalT_W: TBalanceTotalT_W;
begin
  Result := TBalanceTotalT_W(UniMainModule.GetFormInstance(TBalanceTotalT_W));
end;

procedure TBalanceTotalT_W.cbClientSelect(Sender: TObject);
begin
  BalanceTotal.ClientID:= cbClient.Value.ToInteger;
end;

procedure TBalanceTotalT_W.SetClientID(const Value: Integer);
begin
  FClientID := Value;

  Sql.Open(' Select Brief from tClients (nolock) where ClientID=:ClientID ',
  ['ClientID'],
  [FClientID]);

  if sql.count > 0 then self.caption := Sql.q.FieldByName('Brief').asString;
end;

procedure TBalanceTotalT_W.UniFormCreate(Sender: TObject);
begin
  ComboBoxFill(cbClient, ' select ClientID as ID, Brief as Name from tClients (nolock) ');

  BalanceTotal :=  TBalanceTotalT.Create(Self);
  BalanceTotal.Align  := alClient;
  BalanceTotal.Parent := self;
end;

procedure TBalanceTotalT_W.UniFormShow(Sender: TObject);
begin
  cbClient.Value := FClientID.ToString;

  BalanceTotal.ClientID:= FClientID;
end;

end.
