unit uDashBoardItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniLabel, uniButton, uniBitBtn, uniPanel,
  uniGUIBaseClasses, uniImage;

type
  TUniFrame1 = class(TUniFrame)
    UniImage1: TUniImage;
    UniPanel1: TUniPanel;
    UniBitBtn1: TUniBitBtn;
    UniPanel2: TUniPanel;
    UniLabel1: TUniLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}



end.
