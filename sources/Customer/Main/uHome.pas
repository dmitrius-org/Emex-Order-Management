unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame;

type
  THomeF = class(TUniFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


initialization
  RegisterClass(THomeF);

end.
