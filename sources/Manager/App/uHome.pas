unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniPanel, uniGUIBaseClasses, uniHTMLFrame,
  unimHTMLFrame, uniPageControl, uDashBoard;

type
  THomeF = class(TUniFrame)
    pcMain: TUniPageControl;
    Dashboard: TUniTabSheet;
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }

    FCurrentPage:integer;

    FDashBoard: TDashBoardFrame;
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
begin   // TUniShowCaseFrame

  FDashBoard:=TDashBoardFrame.Create(Self);
  FDashBoard.Parent:=Dashboard;// Self;
//FUniShowCaseFrame.Align:=alClient;

  FCurrentPage:=0;

  FDashBoard.MaxWidth:=Self.Width;




  FDashBoard.ProductsOnPage:=10;

  FDashBoard.MaxWidth:=Self.Width;
  FDashBoard.LoadDashBoardDataFromDB;
  FDashBoard.OpenPage(0);

 // lPages.Text:=FCurrentPage.ToString+ ' / '+FUniShowCaseFrame.PagesCount.ToString;


//FUniShowCaseFrameAlign;
//
//
//CenterElements;


end;

initialization
  RegisterClass(THomeF);

end.
