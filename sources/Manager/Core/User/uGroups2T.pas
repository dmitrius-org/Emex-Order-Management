unit uGroups2T;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm;

type
  TGroups2T = class(TUniForm)
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Groups2T: TGroups2T;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uGroupsT;

function Groups2T: TGroups2T;
begin
  Result := TGroups2T(UniMainModule.GetFormInstance(TGroups2T));
end;

procedure TGroups2T.UniFormCreate(Sender: TObject);
var Group: TGroupsT;
begin
   Group := TGroupsT.Create(Self);
   Group.Align := alClient;
   Group.Parent := self;
end;

end.
