unit uDashBoardItemCaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame,System.Contnrs;

type
  TUniShowCaseFrame = class(TUniFrame)
  private
    { Private declarations }

    FProductsOL:TObjectList;
    FNameCount:integer;

    FMaxWidth:integer;

    FProductsOnPage:integer;
    FCurrentPageNumber:integer;
    FPagesCount:integer;

    procedure DisposeProductFrames(i: Integer; PageNumber: Integer);


  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;

    procedure AddProductFrameSinglePage;
    procedure AddProductFrameMultiPages;

    procedure OpenPage(PageNumber:integer);

    procedure HideAllProductFrames;

    property MaxWidth:integer read FMaxWidth write FMaxWidth;

    property ProductsOnPage:Integer read FProductsOnPage write FProductsOnPage;
    property PageNumber:Integer read FCurrentPageNumber write FCurrentPageNumber;

    property PagesCount:integer read FPagesCount write FPagesCount;

    property ProductsOL:TObjectList read FProductsOL write FProductsOL;

  end;

implementation

{$R *.dfm}

uses uDashBoardItem;



{ TUniShowCaseFrame }

procedure TUniShowCaseFrame.AddProductFrameMultiPages;
var   i:integer;
      Product: TDashBoardItem;

begin

  i:=FProductsOL.Add( TDashBoardItem.Create(Self));

  FPagesCount:=trunc(i/FProductsOnPage);


  with TDashBoardItem(FProductsOL[i]) do
  begin

    Parent:=Self;

   // Inc(FNameCount);
   // Name:='SomeName'+FNameCount.ToString;

    //  lProductName.Text:=Name;

    //add some properties here...


  end;


end;



procedure TUniShowCaseFrame.AddProductFrameSinglePage;
var   i:integer;
      Product:TDashBoardItem;
begin

  i:=FProductsOL.Add( TDashBoardItem.Create(Self) );

  with TDashBoardItem(FProductsOL[i]) do
  begin

  Parent:=Self;

  Inc(FNameCount);
  Name:='SomeName'+FNameCount.ToString;

  //In which row to put? In current or next?

   if i>0 then
     begin
       if TDashBoardItem(FProductsOL[i-1]).Left+ 2*TDashBoardItem(FProductsOL[i-1]).width>FMaxWidth-10 then

       begin
        Top:=TDashBoardItem(FProductsOL[i-1]).Top+
        TDashBoardItem(FProductsOL[i-1]).Height;
        Left:=0;

        Self.Height:=Self.Height+TDashBoardItem(FProductsOL[i-1]).Height;
       end else

       begin

        Top:=TDashBoardItem(FProductsOL[i-1]).Top;
        Left:=TDashBoardItem(FProductsOL[i-1]).Left+
        TDashBoardItem(FProductsOL[i-1]).width;

       end;

     end;
    Show;

   // PaintBorder;
  end;
end;

constructor TUniShowCaseFrame.Create(AOwner: TComponent);
begin
  inherited;

  FProductsOL:=TObjectList.Create(true);
  FNameCount:=-1;
  FCurrentPageNumber:=0;

  FPagesCount:=0;
end;


procedure TUniShowCaseFrame.OpenPage(PageNumber: integer);
var
  i: Integer;
begin
  // clear all product frames
  HideAllProductFrames;
  // fill new ones
  // if this last page?
  if PageNumber=FPagesCount then
  for i:= PageNumber*FProductsOnPage to FProductsOL.Count-1  do
    DisposeProductFrames(i,PageNumber)

  else
   // if not this last page?
    for i := PageNumber*FProductsOnPage to PageNumber*FProductsOnPage+FProductsOnPage-1 do
      DisposeProductFrames(i,PageNumber);
end;

procedure TUniShowCaseFrame.DisposeProductFrames(i: Integer; PageNumber: Integer);
begin
  if i=PageNumber*FProductsOnPage then
  begin
    TDashBoardItem(FProductsOL[i]).Left:=0;
    TDashBoardItem(FProductsOL[i]).Top:=0;
    TDashBoardItem(FProductsOL[i]).Show;
  end
  else
  begin
    if TDashBoardItem(FProductsOL[i-1]).Left+ 2*TDashBoardItem(FProductsOL[i-1]).width>FMaxWidth-10 then
    begin
       TDashBoardItem(FProductsOL[i]).Top:=TDashBoardItem(FProductsOL[i-1]).Top+
       TDashBoardItem(FProductsOL[i-1]).Height;
       TDashBoardItem(FProductsOL[i]).Left:=0;

       Self.Height:=Self.Height+TDashBoardItem(FProductsOL[i-1]).Height;
    end
    else
    begin

      TDashBoardItem(FProductsOL[i]).Top:=TDashBoardItem(FProductsOL[i-1]).Top;
      TDashBoardItem(FProductsOL[i]).Left:=TDashBoardItem(FProductsOL[i-1]).Left+
      TDashBoardItem(FProductsOL[i-1]).width;

    end;

   TDashBoardItem(FProductsOL[i]).Show;

  end;
end;

procedure TUniShowCaseFrame.HideAllProductFrames;
var
  i: Integer;
begin
  // clear all product frames
  for i := 0 to FProductsOL.Count-1 do
  begin

    TDashBoardItem(FProductsOL[i]).Left:=0;
    TDashBoardItem(FProductsOL[i]).Top:=0;
    TDashBoardItem(FProductsOL[i]).Hide;
  end;
end;
end.
