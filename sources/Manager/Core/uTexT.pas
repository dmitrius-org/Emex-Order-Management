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
    UniGroupBox3: TUniGroupBox;
    UniButton3: TUniButton;
    edtSuppliersID: TUniNumberEdit;
    UniLabel5: TUniLabel;
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
  uMainVar, uEmexUtils, MainModule, uUtils.Varriant, uServiceEmex, uUtils.Logger;

{$R *.dfm}


procedure TTexT.UniButton1Click(Sender: TObject);
var Emex: TEmex;
begin
   SQl.Exec('delete pMovement where spid = @@spid', [],[]);
   if (edtclient.Value > 0) and (edtOrderNum.Value > 0) then
   begin
     Emex := TEmex.Create(UniMainModule.FDConnection, GetCurrentLogData());
//     Emex.
     Emex.MovementByOrderNumber(vartoint(edtclient.Value), vartoint(edtOrderNum.Value));
     FreeAndNil(Emex);
   end;
end;

procedure TTexT.UniButton2Click(Sender: TObject);
var Emex: TEmex;
     Ctm: Customer;
inBasket: ArrayOfBasketDetails;
       i: Integer;
    part: BasketDetails;
begin
  SQl.Exec('delete pBasketDetails where spid = @@spid', [],[]);
  SQl.Open('Select s.emexUsername, s.emexPassword '+
           '  from tSuppliers  s (nolock)         ' +
           ' where s.SuppliersID = :SuppliersID   ',
          ['SuppliersID'], [edtSuppliersID.value]);


  Ctm := Customer.Create;
  Ctm.UserName      := SQl.Q.FieldByName('emexUsername').AsString;
  Ctm.Password      := SQl.Q.FieldByName('emexPassword').AsString;
  Ctm.SubCustomerId := '0';
  Ctm.CustomerId    := '0';

  if (edtSuppliersID.Value > 0) then
  begin
    Emex := TEmex.Create(UniMainModule.FDConnection, GetCurrentLogData());

    inBasket := Emex.Emex.GetBasketDetails(Ctm);

    for I := 0 to Length(inBasket)-1 do
    begin
      part:= BasketDetails.Create;
      part:= inBasket[i];

      SQl.Exec(''+
               ' insert into pBasketDetails'+
               '       (Spid, BasketId, MakeLogo, DetailNum, PriceLogo, Price, Quantity, Comments, DetailWeight, EmExWeight, DestinationLogo, UploadedPrice, CoeffMaxAgree, CustomerSubId, Reference, ClientID) '+
               ' select @@spid, :BasketId,:MakeLogo,:DetailNum,:PriceLogo,:Price, :Quantity, :Comments, :DetailWeight, :EmExWeight, :DestinationLogo, :UploadedPrice, :CoeffMaxAgree, :CustomerSubId, :Reference, :ClientID'+
               '       ',
               ['BasketId','MakeLogo','DetailNum','PriceLogo','Price','Quantity', 'Comments', 'DetailWeight', 'EmExWeight', 'DestinationLogo', 'UploadedPrice', 'CoeffMaxAgree', 'CustomerSubId', 'Reference', 'ClientID'],
               [part.BasketId, part.MakeLogo, part.DetailNum, part.PriceLogo, part.Price, part.Quantity
               ,part.Comments, part.DetailWeight, part.EmExWeight, part.DestinationLogo, part.UploadedPrice
               ,part.CoeffMaxAgree, part.CustomerSubId, part.Reference, 0]
               );
    end;

    freeandnil(part);
  end;

  FreeAndNil(Emex);
end;

procedure TTexT.UniFrameReady(Sender: TObject);
begin
ComboBoxFill(cbStatus, ' select distinct EID, EBrief as Name from tNodes Order By EID');
end;

initialization
  RegisterClass(TTexT);
end.
