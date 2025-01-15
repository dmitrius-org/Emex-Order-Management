unit uStatistics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,  DateUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGroupBox, uniDateTimePicker, uniChart,
  uniGUIBaseClasses, uniPanel, unimChart, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniLabel, uniButton,
  cfs.GCharts.uniGUI, uniMultiItem, uniComboBox, uniPageControl, uniEdit,
  uStatisticOrders;

type
  TStatisticsT = class(TUniFrame)
    PageCommon: TUniPageControl;
    TabOrders: TUniTabSheet;
    procedure TabOrdersBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
    FStatisticOrders :TStatisticOrders;
  public
    { Public declarations }
  end;

implementation

uses
  MainModule, uLogger;

{$R *.dfm}


procedure TStatisticsT.TabOrdersBeforeFirstActivate(Sender: TObject; var AllowActivate: Boolean);
begin
//  if not Assigned(FStatisticOrders) then
//  begin
//    FStatisticOrders := TStatisticOrders.Create(Self);
//    FStatisticOrders.Align := alClient;
//    FStatisticOrders.Parent := TabOrders;
//  end;
end;

procedure TStatisticsT.UniFrameCreate(Sender: TObject);
begin
  if not Assigned(FStatisticOrders) then
  begin
    FStatisticOrders := TStatisticOrders.Create(Self);
    FStatisticOrders.Align := alClient;
    FStatisticOrders.Parent := TabOrders;
  end;
end;

initialization
  RegisterClass(TStatisticsT);

end.
