unit uInstructionDevT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uConfluenceT, uniGUIBaseClasses, uniImageList,
  Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList, uniHTMLFrame, uniButton,
  uniLabel, uniTreeView, uniPanel;

type
  TInstructionDevT = class(TConfluenceT)
    procedure UniFrameReady(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TInstructionDevT.UniFrameReady(Sender: TObject);
begin
  ArticleType := 2;
  inherited;

end;

initialization
  RegisterClass(TInstructionDevT);
end.
