﻿unit uHome;

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
begin

  FDashBoard:=TDashBoardFrame.Create(Self);
  FDashBoard.Parent:=Dashboard;
//FUniShowCaseFrame.Align:=alClient;

  FCurrentPage:=0;

  FDashBoard.MaxWidth:=Self.Width;

  FDashBoard.ProductsOnPage:=10;

  FDashBoard.MaxWidth:=Self.Width;
  FDashBoard.LoadDashBoardDataFromDB;
  FDashBoard.OpenPage(0);
end;

initialization
  RegisterClass(THomeF);

end.
