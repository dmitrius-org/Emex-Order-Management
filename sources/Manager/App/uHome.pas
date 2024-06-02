unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniPanel, uniGUIBaseClasses, uniHTMLFrame,
  unimHTMLFrame, uniPageControl;

type
  THomeF = class(TUniFrame)
    pcMain: TUniPageControl;
    Dashboard: TUniTabSheet;
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  PriceUpdate, ServerModule;

{$R *.dfm}


procedure THomeF.UniFrameCreate(Sender: TObject);
var fr : TPriceUpdateT;
  tmp : TStringList;
begin
//    Fr := TPriceUpdateT.Create(Self);
//    Fr.Align := alClient;
//    Fr.Parent := pnlPriceUpdate;

    //  Nd.Data := Ts;
 // pcMain.Layout := 'Fit';

//  tmp := TStringList.Create;
//  tmp.LoadFromFile(UniServerModule.StartPath + '\files\tinymce5\index.html');
//
//
// // tmp.Text := StringReplace(tmp.Text, 'myEditor', GetEditor, [rfReplaceAll]);
//
//
//  edt.HTML.Clear;
//  edt.HTML.LoadFromFile(UniServerModule.StartPath + '\files\html\Dashboard.html');
//  tmp.Free;
//
end;

initialization
  RegisterClass(THomeF);

end.
