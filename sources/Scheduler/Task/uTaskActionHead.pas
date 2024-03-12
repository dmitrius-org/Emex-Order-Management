unit uTaskActionHead;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniEdit, uniLabel, uniGUIBaseClasses, uniCheckBox;

type
  TTaskActionHead = class(TUniFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}



initialization
  RegisterClass(TTaskActionHead);

end.
