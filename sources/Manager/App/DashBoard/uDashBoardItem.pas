unit uDashBoardItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniLabel, uniButton, uniBitBtn, uniPanel,
  uniGUIBaseClasses, uniImage, uniImageList;

type
  TDashBoardItem = class(TUniFrame)
    UniImage1: TUniImage;
    lblName: TUniLabel;
    ItemPanel: TUniContainerPanel;
    UniContainerPanel2: TUniContainerPanel;
    UniContainerPanel3: TUniContainerPanel;
    UniContainerPanel4: TUniContainerPanel;
    UniContainerPanel5: TUniContainerPanel;
    UniLabel1: TUniLabel;
    lblDetail: TUniLabel;
  private
    procedure SetTitle(const Value: string);
    procedure SetImages(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetDetail(const Value: string);
    { Private declarations }
  public
    { Public declarations }

    property Title:string write SetTitle;
    property Detail:string write SetDetail;

    property Images:string write SetImages;

    property Status:string write SetStatus;

  end;

implementation

{$R *.dfm}



{ TCaseItem }

procedure TDashBoardItem.SetImages(const Value: string);
begin
  UniImage1.ClientEvents.ExtEvents.Values['afterrender'] := 'function afterrender(sender) {' +
    'var el = sender.getEl();' +
    'el.addCls("fa ' + Value + ' fa-5x");' +
    '}';
end;

procedure TDashBoardItem.SetDetail(const Value: string);
begin
  lblDetail.Caption := Value;
end;

procedure TDashBoardItem.SetTitle(const Value: string);
begin
  lblName.Caption := Value;
end;

procedure TDashBoardItem.SetStatus(const Value: string);
begin
  ItemPanel.ClientEvents.ExtEvents.Values['afterrender'] := 'function afterrender(sender) {' +
    'var el = sender.getEl();' +
    'el.addCls("' + Value + '");' +
    '}';
end;

end.
