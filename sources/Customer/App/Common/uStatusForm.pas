unit uStatusForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame;

type
  TStatusForm = class(TUniForm)
    edt1: TUniHTMLFrame;
    procedure UniFormShow(Sender: TObject);
  private
    FStatusFile: string;
    procedure SetStatusFile(const Value: string);
    { Private declarations }
  public
    { Public declarations }


    property StatusFile: string read FStatusFile write SetStatusFile;
  end;

implementation

//uses
//  uniGUIApplication,
//  ServerModule;

{$R *.dfm}


procedure TStatusForm.SetStatusFile(const Value: string);
begin
  FStatusFile := Value;
end;

procedure TStatusForm.UniFormShow(Sender: TObject);
begin
  edt1.HTML.Clear;
  edt1.HTML.LoadFromFile( FStatusFile );
end;

end.
