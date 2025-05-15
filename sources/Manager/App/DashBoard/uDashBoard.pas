unit uDashBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame,System.Contnrs;

type
  TDashBoardFrame = class(TUniFrame)
  private
    { Private declarations }

    FCaseItems:TObjectList;
    FNameCount:integer;

    FMaxWidth:integer;

    FProductsOnPage:integer;
    FCurrentPageNumber:integer;
    FPagesCount:integer;

    procedure DisposeCaseItemsFrames(i: Integer; PageNumber: Integer);


  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;

    procedure AddProductFrameSinglePage;
//    procedure AddProductFrameMultiPages;

    procedure OpenPage(PageNumber:integer);

    procedure HideAllProductFrames;

    procedure LoadDashBoardDataFromDB;

    property MaxWidth:integer read FMaxWidth write FMaxWidth;

    property ProductsOnPage:Integer read FProductsOnPage write FProductsOnPage;
    property PageNumber:Integer read FCurrentPageNumber write FCurrentPageNumber;

    property PagesCount:integer read FPagesCount write FPagesCount;

    property ProductsOL:TObjectList read FCaseItems write FCaseItems;

  end;

implementation

{$R *.dfm}

uses uMainVar, uDashBoardItem;



{ TUniShowCaseFrame }

//procedure TUniShowCaseFrame.AddProductFrameMultiPages;
//var   i:integer;
//      Product: TDashBoardItem;
//
//begin
//
//  i:=FProductsOL.Add( TDashBoardItem.Create(Self));
//
//  FPagesCount:=trunc(i/FProductsOnPage);
//
//
//  with TDashBoardItem(FProductsOL[i]) do
//  begin
//
//    Parent:=Self;
//
//   // Inc(FNameCount);
//   // Name:='SomeName'+FNameCount.ToString;
//
//    //  lProductName.Text:=Name;
//
//    //add some properties here...
//
//
//  end;
//
//
//end;



procedure TDashBoardFrame.AddProductFrameSinglePage;
var   i:integer;
begin

  i:=FCaseItems.Add( TDashBoardItem.Create(Self) );

  with TDashBoardItem(FCaseItems[i]) do
  begin

    Parent:=Self;

    Inc(FNameCount);
    Name:='SomeName'+FNameCount.ToString;

    //In which row to put? In current or next?
    if i>0 then
     begin
       if TDashBoardItem(FCaseItems[i-1]).Left+ 2*TDashBoardItem(FCaseItems[i-1]).width>FMaxWidth-10 then

       begin
        Top:=TDashBoardItem(FCaseItems[i-1]).Top+
        TDashBoardItem(FCaseItems[i-1]).Height;
        Left:=0;

        Self.Height:=Self.Height+TDashBoardItem(FCaseItems[i-1]).Height;
       end
       else
       begin

        Top:=TDashBoardItem(FCaseItems[i-1]).Top;
        Left:=TDashBoardItem(FCaseItems[i-1]).Left+
        TDashBoardItem(FCaseItems[i-1]).width;

       end;

     end;
    Show;

    //PaintBorder;
  end;
end;

constructor TDashBoardFrame.Create(AOwner: TComponent);
begin
  inherited;

  FCaseItems:=TObjectList.Create(true);
  FNameCount:=-1;
  FCurrentPageNumber:=0;

  FPagesCount:=0;
end;


procedure TDashBoardFrame.OpenPage(PageNumber: integer);
var
  i: Integer;
begin
  // clear all product frames
  HideAllProductFrames;
  // fill new ones
  // if this last page?
  if PageNumber=FPagesCount then
  for i:= PageNumber*FProductsOnPage to FCaseItems.Count-1  do
    DisposeCaseItemsFrames(i,PageNumber)

  else
   // if not this last page?
    for i := PageNumber*FProductsOnPage to PageNumber*FProductsOnPage+FProductsOnPage-1 do
      DisposeCaseItemsFrames(i,PageNumber);
end;

procedure TDashBoardFrame.DisposeCaseItemsFrames(i: Integer; PageNumber: Integer);
begin
  if i=PageNumber*FProductsOnPage then
  begin
    TDashBoardItem(FCaseItems[i]).Left:=0;
    TDashBoardItem(FCaseItems[i]).Top:=0;
    TDashBoardItem(FCaseItems[i]).Show;
  end
  else
  begin
    if TDashBoardItem(FCaseItems[i-1]).Left+ 2*TDashBoardItem(FCaseItems[i-1]).width>FMaxWidth-10 then
    begin
       TDashBoardItem(FCaseItems[i]).Top:=TDashBoardItem(FCaseItems[i-1]).Top+
       TDashBoardItem(FCaseItems[i-1]).Height;
       TDashBoardItem(FCaseItems[i]).Left:=0;

       Self.Height:=Self.Height+TDashBoardItem(FCaseItems[i-1]).Height;
    end
    else
    begin

      TDashBoardItem(FCaseItems[i]).Top:=TDashBoardItem(FCaseItems[i-1]).Top;
      TDashBoardItem(FCaseItems[i]).Left:=TDashBoardItem(FCaseItems[i-1]).Left+
      TDashBoardItem(FCaseItems[i-1]).width;

    end;

   TDashBoardItem(FCaseItems[i]).Show;
  end;
end;

procedure TDashBoardFrame.HideAllProductFrames;
var
  i: Integer;
begin
  // clear all  frames
  for i := 0 to FCaseItems.Count-1 do
  begin
    TDashBoardItem(FCaseItems[i]).Left:=0;
    TDashBoardItem(FCaseItems[i]).Top:=0;
    TDashBoardItem(FCaseItems[i]).Hide;
  end;
end;


procedure TDashBoardFrame.LoadDashBoardDataFromDB;
var
  i: integer;
begin

  HideAllProductFrames;
  ProductsOL.Clear;
  Sql.Open('DashBoardDataLoad', [], []);

  with Sql.Q do
  begin
    while not EOF do
    begin
      i:=FCaseItems.Add( TDashBoardItem.Create(Self) );

      FPagesCount:=trunc(i/FProductsOnPage);

      with TDashBoardItem(FCaseItems[i]) do
      begin

        Parent:=Self;

        Inc(FNameCount);

        Name:='SomeName'+FNameCount.ToString;

        Title:= FieldByName('Title').AsString;
        Detail := FieldByName('Detail').AsString;

        UniContainerPanel5.Hint :=  FieldByName('Hint').AsString;

        Status:= FieldByName('Status').AsString;
        Images:= FieldByName('Icon').AsString;

      end;

      Next;
    end;
   // Close();
  end;
end;


end.
