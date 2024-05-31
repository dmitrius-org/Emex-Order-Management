unit uInstructionT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uConfluenceT, uniGUIBaseClasses, uniImageList,
  Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList, uniHTMLFrame, uniButton,
  uniLabel, uniTreeView, uniPanel;

type
  TInstructionT = class(TConfluenceT)
    procedure UniFrameReady(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TInstructionT.UniFrameReady(Sender: TObject);
begin
  ArticleType := 1;
  inherited;

end;

initialization
  RegisterClass(TInstructionT);
end.
