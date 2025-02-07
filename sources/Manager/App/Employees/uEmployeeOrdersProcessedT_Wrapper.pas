unit uEmployeeOrdersProcessedT_Wrapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uEmployeeOrdersProcessedT;

type
  TEmployeeOrdersProcessedT_Wrapper = class(TUniForm)
    procedure UniFormShow(Sender: TObject);
  private
    FEmployeeID: Integer;
    { Private declarations }
  public
    { Public declarations }
    property EmployeeID: Integer read FEmployeeID write FEmployeeID;
  end;

function EmployeeOrdersProcessedT_Wrapper: TEmployeeOrdersProcessedT_Wrapper;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function EmployeeOrdersProcessedT_Wrapper: TEmployeeOrdersProcessedT_Wrapper;
begin
  Result := TEmployeeOrdersProcessedT_Wrapper(UniMainModule.GetFormInstance(TEmployeeOrdersProcessedT_Wrapper));
end;

procedure TEmployeeOrdersProcessedT_Wrapper.UniFormShow(Sender: TObject);
var Employee: TEmployeeOrdersProcessedT;
begin
   Employee:= TEmployeeOrdersProcessedT.Create(self);
   Employee.Parent := self;
   Employee.EmployeeID := FEmployeeID;
end;

end.
