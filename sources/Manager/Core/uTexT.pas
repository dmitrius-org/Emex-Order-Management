unit uTexT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniLabel, uniButton, uniGUIBaseClasses, uniEdit,
  uniGroupBox, uniMultiItem, uniComboBox;

type
  TTexT = class(TUniFrame)
    UniGroupBox1: TUniGroupBox;
    lblordernum: TUniLabel;
    UniLabel1: TUniLabel;
    UniGroupBox2: TUniGroupBox;
    UniButton2: TUniButton;
    UniLabel2: TUniLabel;
    edtclient2: TUniNumberEdit;
    UniLabel3: TUniLabel;
    cbStatus: TUniComboBox;
    UniButton1: TUniButton;
    edtclient: TUniNumberEdit;
    edtOrderNum: TUniNumberEdit;
    procedure UniButton1Click(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uMainVar, uEmexUtils, MainModule, uVarUtils;

{$R *.dfm}


procedure TTexT.UniButton1Click(Sender: TObject);
var Emex: TEmex;
begin
   SQl.Exec('delete pMovement where spid = @@spid', [],[]);
   if (edtclient.Value > 0) and (edtOrderNum.Value > 0) then
   begin
     Emex := TEmex.Create;
     Emex.Connection := UniMainModule.FDConnection;
//     Emex.
     Emex.MovementByOrderNumber(vartoint(edtclient.Value), vartoint(edtOrderNum.Value));
     FreeAndNil(Emex);
   end;
end;

procedure TTexT.UniButton2Click(Sender: TObject);
var Emex: TEmex;
begin
   SQl.Exec('delete pMovement where spid = @@spid', [],[]);
   SQl.Exec('delete pAccrualAction where spid = @@spid', [],[]);


   SQl.Exec('insert pAccrualAction (Spid, ObjectID, Retval) select top 1 @@Spid, OrderID, 0 from tOrders (nolock) where ClientID = :ClientID',
           ['ClientID'],[edtclient2.Value]);


   if (edtclient2.Value > 0) and (cbStatus.ItemIndex > 0) then
   begin
     Emex := TEmex.Create;
     Emex.Connection := UniMainModule.FDConnection;

     case cbStatus.ItemIndex  of
//        1: //InWork
//        2: //Purchased
//        3: //	ReceivedOnStock
//        4: //	ReadyToSend
        5: //	Sent
          Emex.MovementInWork();
//        6: //	NOT AVAILABLE
//        7: //	AGREE
     else
       //
     end;


     FreeAndNil(Emex);
   end;
end;

procedure TTexT.UniFrameReady(Sender: TObject);
begin
ComboBoxFill(cbStatus, ' select distinct EID, EBrief as Name from tNodes Order By EID');
end;

initialization
  RegisterClass(TTexT);
end.
