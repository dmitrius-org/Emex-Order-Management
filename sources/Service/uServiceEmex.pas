// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://soap.emexdwc.ae/service.asmx?WSDL
//  >Import : https://soap.emexdwc.ae/service.asmx?WSDL>0
// Encoding : utf-8
// Codegen  : [wfForceSOAP12+]
// Version  : 1.0
// (25.10.2024 9:26:53 - - $Rev: 116709 $)
// ************************************************************************ //

unit uServiceEmex;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  IPlist               = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  BasketChangeResult   = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Customer             = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  QuotationList        = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  QuotationList_v2     = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Quotation            = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  FindByNumber         = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  BasketDetails        = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  BasketDetails_v2     = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  partstobasket        = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ListOfOrders         = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  SearchHistory        = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Balance              = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  InvDetails           = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  BalanceForOrder      = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  History              = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  History_v2           = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Destinations         = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  boxdetails           = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  BasketOrderResult    = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  CreateOrderResult_v2 = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  LogInfo              = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Boxes                = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Invoicelist          = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  Movement             = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  SubCustomers         = class;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }

  ArrayOfBasketChangeResult = array of BasketChangeResult;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfBasketDetails = array of BasketDetails;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfPartstobasket = array of partstobasket;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfIPlist = array of IPlist;              { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfListOfOrders = array of ListOfOrders;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfBasketDetails_v2 = array of BasketDetails_v2;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfQuotationList_v2 = array of QuotationList_v2;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : IPlist, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  IPlist = class(TRemotable)
  private
    FDesc: string;
    FDesc_Specified: boolean;
    FIP: string;
    FIP_Specified: boolean;
    FDateAdd: TXSDateTime;
    procedure SetDesc(Index: Integer; const Astring: string);
    function  Desc_Specified(Index: Integer): boolean;
    procedure SetIP(Index: Integer; const Astring: string);
    function  IP_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Desc:    string       Index (IS_OPTN) read FDesc write SetDesc stored Desc_Specified;
    property IP:      string       Index (IS_OPTN) read FIP write SetIP stored IP_Specified;
    property DateAdd: TXSDateTime  read FDateAdd write FDateAdd;
  end;



  // ************************************************************************ //
  // XML       : BasketChangeResult, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  BasketChangeResult = class(TRemotable)
  private
    FBasketId: Int64;
    FWarnText: string;
    FWarnText_Specified: boolean;
    procedure SetWarnText(Index: Integer; const Astring: string);
    function  WarnText_Specified(Index: Integer): boolean;
  published
    property BasketId: Int64   Index (IS_NLBL) read FBasketId write FBasketId;
    property WarnText: string  Index (IS_OPTN) read FWarnText write SetWarnText stored WarnText_Specified;
  end;

  ArrayOfFindByNumber = array of FindByNumber;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Customer, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Customer = class(TRemotable)
  private
    FUserName: string;
    FUserName_Specified: boolean;
    FPassword: string;
    FPassword_Specified: boolean;
    FSubCustomerId: string;
    FSubCustomerId_Specified: boolean;
    FCustomerId: string;
    FCustomerId_Specified: boolean;
    procedure SetUserName(Index: Integer; const Astring: string);
    function  UserName_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const Astring: string);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetSubCustomerId(Index: Integer; const Astring: string);
    function  SubCustomerId_Specified(Index: Integer): boolean;
    procedure SetCustomerId(Index: Integer; const Astring: string);
    function  CustomerId_Specified(Index: Integer): boolean;
  published
    property UserName:      string  Index (IS_OPTN) read FUserName write SetUserName stored UserName_Specified;
    property Password:      string  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property SubCustomerId: string  Index (IS_OPTN) read FSubCustomerId write SetSubCustomerId stored SubCustomerId_Specified;
    property CustomerId:    string  Index (IS_OPTN) read FCustomerId write SetCustomerId stored CustomerId_Specified;
  end;

  string_         =  type string;      { "http://emexonline.com:3000/MaximaWS/"[GblElm] }
  ArrayOfQuotationList = array of QuotationList;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfQuotation = array of Quotation;        { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : QuotationList, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  QuotationList = class(TRemotable)
  private
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FDelivery: Integer;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPrice: Double;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FPriceId: Integer;
    FPartNameRus: string;
    FPartNameRus_Specified: boolean;
    FPartNameEng: string;
    FPartNameEng_Specified: boolean;
    FWeightGr: Double;
    FMakeName: string;
    FMakeName_Specified: boolean;
    FPacking: Integer;
    FbitECO: Boolean;
    FbitWeightMeasured: Boolean;
    FReference: string;
    FReference_Specified: boolean;
    FQuantity: Integer;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetPartNameRus(Index: Integer; const Astring: string);
    function  PartNameRus_Specified(Index: Integer): boolean;
    procedure SetPartNameEng(Index: Integer; const Astring: string);
    function  PartNameEng_Specified(Index: Integer): boolean;
    procedure SetMakeName(Index: Integer; const Astring: string);
    function  MakeName_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
  published
    property PriceLogo:         string   Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Delivery:          Integer  read FDelivery write FDelivery;
    property DestinationLogo:   string   Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property Price:             Double   read FPrice write FPrice;
    property MakeLogo:          string   Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:         string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property PriceId:           Integer  read FPriceId write FPriceId;
    property PartNameRus:       string   Index (IS_OPTN) read FPartNameRus write SetPartNameRus stored PartNameRus_Specified;
    property PartNameEng:       string   Index (IS_OPTN) read FPartNameEng write SetPartNameEng stored PartNameEng_Specified;
    property WeightGr:          Double   read FWeightGr write FWeightGr;
    property MakeName:          string   Index (IS_OPTN) read FMakeName write SetMakeName stored MakeName_Specified;
    property Packing:           Integer  read FPacking write FPacking;
    property bitECO:            Boolean  read FbitECO write FbitECO;
    property bitWeightMeasured: Boolean  read FbitWeightMeasured write FbitWeightMeasured;
    property Reference:         string   Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property Quantity:          Integer  read FQuantity write FQuantity;
  end;



  // ************************************************************************ //
  // XML       : QuotationList_v2, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  QuotationList_v2 = class(QuotationList)
  private
    FHeightCm: Int64;
    FWidthCm: Int64;
    FLengthCm: Int64;
  published
    property HeightCm: Int64  Index (IS_NLBL) read FHeightCm write FHeightCm;
    property WidthCm:  Int64  Index (IS_NLBL) read FWidthCm write FWidthCm;
    property LengthCm: Int64  Index (IS_NLBL) read FLengthCm write FLengthCm;
  end;



  // ************************************************************************ //
  // XML       : Quotation, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Quotation = class(TRemotable)
  private
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FDelivery: Integer;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPrice: Double;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FPriceId: Integer;
    FPartNameRus: string;
    FPartNameRus_Specified: boolean;
    FPartNameEng: string;
    FPartNameEng_Specified: boolean;
    FWeightGr: Double;
    FMakeName: string;
    FMakeName_Specified: boolean;
    FPacking: Integer;
    FbitECO: Boolean;
    FbitWeightMeasured: Boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetPartNameRus(Index: Integer; const Astring: string);
    function  PartNameRus_Specified(Index: Integer): boolean;
    procedure SetPartNameEng(Index: Integer; const Astring: string);
    function  PartNameEng_Specified(Index: Integer): boolean;
    procedure SetMakeName(Index: Integer; const Astring: string);
    function  MakeName_Specified(Index: Integer): boolean;
  published
    property PriceLogo:         string   Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Delivery:          Integer  read FDelivery write FDelivery;
    property DestinationLogo:   string   Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property Price:             Double   read FPrice write FPrice;
    property MakeLogo:          string   Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:         string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property PriceId:           Integer  read FPriceId write FPriceId;
    property PartNameRus:       string   Index (IS_OPTN) read FPartNameRus write SetPartNameRus stored PartNameRus_Specified;
    property PartNameEng:       string   Index (IS_OPTN) read FPartNameEng write SetPartNameEng stored PartNameEng_Specified;
    property WeightGr:          Double   read FWeightGr write FWeightGr;
    property MakeName:          string   Index (IS_OPTN) read FMakeName write SetMakeName stored MakeName_Specified;
    property Packing:           Integer  read FPacking write FPacking;
    property bitECO:            Boolean  read FbitECO write FbitECO;
    property bitWeightMeasured: Boolean  read FbitWeightMeasured write FbitWeightMeasured;
  end;



  // ************************************************************************ //
  // XML       : FindByNumber, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  FindByNumber = class(TRemotable)
  private
    FAvailable: string;
    FAvailable_Specified: boolean;
    FbitOldNum: Boolean;
    FPercentSupped: Integer;
    FPriceId: Integer;
    FRegion: string;
    FRegion_Specified: boolean;
    FDelivery: Integer;
    FMake: string;
    FMake_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FPrice: Double;
    FPartNameRus: string;
    FPartNameRus_Specified: boolean;
    FPartNameEng: string;
    FPartNameEng_Specified: boolean;
    FWeightGr: Double;
    FMakeName: string;
    FMakeName_Specified: boolean;
    FPacking: Integer;
    FbitECO: Boolean;
    FbitWeightMeasured: Boolean;
    FVolumeAdd: Double;
    FGuaranteedDay: string;
    FGuaranteedDay_Specified: boolean;
    procedure SetAvailable(Index: Integer; const Astring: string);
    function  Available_Specified(Index: Integer): boolean;
    procedure SetRegion(Index: Integer; const Astring: string);
    function  Region_Specified(Index: Integer): boolean;
    procedure SetMake(Index: Integer; const Astring: string);
    function  Make_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetPartNameRus(Index: Integer; const Astring: string);
    function  PartNameRus_Specified(Index: Integer): boolean;
    procedure SetPartNameEng(Index: Integer; const Astring: string);
    function  PartNameEng_Specified(Index: Integer): boolean;
    procedure SetMakeName(Index: Integer; const Astring: string);
    function  MakeName_Specified(Index: Integer): boolean;
    procedure SetGuaranteedDay(Index: Integer; const Astring: string);
    function  GuaranteedDay_Specified(Index: Integer): boolean;
  published
    property Available:         string   Index (IS_OPTN) read FAvailable write SetAvailable stored Available_Specified;
    property bitOldNum:         Boolean  read FbitOldNum write FbitOldNum;
    property PercentSupped:     Integer  read FPercentSupped write FPercentSupped;
    property PriceId:           Integer  read FPriceId write FPriceId;
    property Region:            string   Index (IS_OPTN) read FRegion write SetRegion stored Region_Specified;
    property Delivery:          Integer  read FDelivery write FDelivery;
    property Make:              string   Index (IS_OPTN) read FMake write SetMake stored Make_Specified;
    property DetailNum:         string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property PriceLogo:         string   Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Price:             Double   read FPrice write FPrice;
    property PartNameRus:       string   Index (IS_OPTN) read FPartNameRus write SetPartNameRus stored PartNameRus_Specified;
    property PartNameEng:       string   Index (IS_OPTN) read FPartNameEng write SetPartNameEng stored PartNameEng_Specified;
    property WeightGr:          Double   read FWeightGr write FWeightGr;
    property MakeName:          string   Index (IS_OPTN) read FMakeName write SetMakeName stored MakeName_Specified;
    property Packing:           Integer  read FPacking write FPacking;
    property bitECO:            Boolean  read FbitECO write FbitECO;
    property bitWeightMeasured: Boolean  read FbitWeightMeasured write FbitWeightMeasured;
    property VolumeAdd:         Double   read FVolumeAdd write FVolumeAdd;
    property GuaranteedDay:     string   Index (IS_OPTN) read FGuaranteedDay write SetGuaranteedDay stored GuaranteedDay_Specified;
  end;



  // ************************************************************************ //
  // XML       : BasketDetails, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  BasketDetails = class(TRemotable)
  private
    FComments: string;
    FComments_Specified: boolean;
    FUploadedPrice: Double;
    FCoeffMaxAgree: Double;
    FPrice: Double;
    FCustomerLogo: string;
    FCustomerLogo_Specified: boolean;
    FbitConfirm: Boolean;
    FbitAgree: Boolean;
    FbitOnlyThisBrand: Boolean;
    FDate_add: TXSDateTime;
    FBasketId: Int64;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FQuantity: Integer;
    FbitOnlyThisNumber: Boolean;
    FbitOnlyThisQuantity: Boolean;
    FbitWait: Boolean;
    FReference: string;
    FReference_Specified: boolean;
    FCustomerSubId: string;
    FCustomerSubId_Specified: boolean;
    FTransportPack: string;
    FTransportPack_Specified: boolean;
    FDetailWeight: Double;
    FEmExWeight: Double;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetCustomerLogo(Index: Integer; const Astring: string);
    function  CustomerLogo_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetCustomerSubId(Index: Integer; const Astring: string);
    function  CustomerSubId_Specified(Index: Integer): boolean;
    procedure SetTransportPack(Index: Integer; const Astring: string);
    function  TransportPack_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Comments:            string       Index (IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property UploadedPrice:       Double       read FUploadedPrice write FUploadedPrice;
    property CoeffMaxAgree:       Double       read FCoeffMaxAgree write FCoeffMaxAgree;
    property Price:               Double       read FPrice write FPrice;
    property CustomerLogo:        string       Index (IS_OPTN) read FCustomerLogo write SetCustomerLogo stored CustomerLogo_Specified;
    property bitConfirm:          Boolean      read FbitConfirm write FbitConfirm;
    property bitAgree:            Boolean      read FbitAgree write FbitAgree;
    property bitOnlyThisBrand:    Boolean      read FbitOnlyThisBrand write FbitOnlyThisBrand;
    property Date_add:            TXSDateTime  read FDate_add write FDate_add;
    property BasketId:            Int64        read FBasketId write FBasketId;
    property MakeLogo:            string       Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:           string       Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property DestinationLogo:     string       Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property PriceLogo:           string       Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Quantity:            Integer      read FQuantity write FQuantity;
    property bitOnlyThisNumber:   Boolean      read FbitOnlyThisNumber write FbitOnlyThisNumber;
    property bitOnlyThisQuantity: Boolean      read FbitOnlyThisQuantity write FbitOnlyThisQuantity;
    property bitWait:             Boolean      read FbitWait write FbitWait;
    property Reference:           string       Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property CustomerSubId:       string       Index (IS_OPTN) read FCustomerSubId write SetCustomerSubId stored CustomerSubId_Specified;
    property TransportPack:       string       Index (IS_OPTN) read FTransportPack write SetTransportPack stored TransportPack_Specified;
    property DetailWeight:        Double       read FDetailWeight write FDetailWeight;
    property EmExWeight:          Double       read FEmExWeight write FEmExWeight;
  end;



  // ************************************************************************ //
  // XML       : BasketDetails_v2, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  BasketDetails_v2 = class(TRemotable)
  private
    FComments: string;
    FComments_Specified: boolean;
    FUploadedPrice: Double;
    FCoeffMaxAgree: Double;
    FPrice: Double;
    FCustomerLogo: string;
    FCustomerLogo_Specified: boolean;
    FbitConfirm: Boolean;
    FbitAgree: Boolean;
    FbitOnlyThisBrand: Boolean;
    FDate_add: TXSDateTime;
    FBasketId: Int64;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FQuantity: Integer;
    FPackQuantity: Integer;
    FbitOnlyThisNumber: Boolean;
    FbitOnlyThisQuantity: Boolean;
    FbitWait: Boolean;
    FReference: string;
    FReference_Specified: boolean;
    FCustomerSubId: string;
    FCustomerSubId_Specified: boolean;
    FTransportPack: string;
    FTransportPack_Specified: boolean;
    FDetailWeight: Double;
    FEmExWeight: Double;
    FWarnCode: Integer;
    FWarnText: string;
    FWarnText_Specified: boolean;
    FAvailableQuantity: Integer;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetCustomerLogo(Index: Integer; const Astring: string);
    function  CustomerLogo_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetCustomerSubId(Index: Integer; const Astring: string);
    function  CustomerSubId_Specified(Index: Integer): boolean;
    procedure SetTransportPack(Index: Integer; const Astring: string);
    function  TransportPack_Specified(Index: Integer): boolean;
    procedure SetWarnText(Index: Integer; const Astring: string);
    function  WarnText_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Comments:            string       Index (IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property UploadedPrice:       Double       read FUploadedPrice write FUploadedPrice;
    property CoeffMaxAgree:       Double       read FCoeffMaxAgree write FCoeffMaxAgree;
    property Price:               Double       read FPrice write FPrice;
    property CustomerLogo:        string       Index (IS_OPTN) read FCustomerLogo write SetCustomerLogo stored CustomerLogo_Specified;
    property bitConfirm:          Boolean      read FbitConfirm write FbitConfirm;
    property bitAgree:            Boolean      read FbitAgree write FbitAgree;
    property bitOnlyThisBrand:    Boolean      read FbitOnlyThisBrand write FbitOnlyThisBrand;
    property Date_add:            TXSDateTime  read FDate_add write FDate_add;
    property BasketId:            Int64        read FBasketId write FBasketId;
    property MakeLogo:            string       Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:           string       Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property DestinationLogo:     string       Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property PriceLogo:           string       Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Quantity:            Integer      read FQuantity write FQuantity;
    property PackQuantity:        Integer      read FPackQuantity write FPackQuantity;
    property bitOnlyThisNumber:   Boolean      read FbitOnlyThisNumber write FbitOnlyThisNumber;
    property bitOnlyThisQuantity: Boolean      read FbitOnlyThisQuantity write FbitOnlyThisQuantity;
    property bitWait:             Boolean      read FbitWait write FbitWait;
    property Reference:           string       Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property CustomerSubId:       string       Index (IS_OPTN) read FCustomerSubId write SetCustomerSubId stored CustomerSubId_Specified;
    property TransportPack:       string       Index (IS_OPTN) read FTransportPack write SetTransportPack stored TransportPack_Specified;
    property DetailWeight:        Double       read FDetailWeight write FDetailWeight;
    property EmExWeight:          Double       read FEmExWeight write FEmExWeight;
    property WarnCode:            Integer      read FWarnCode write FWarnCode;
    property WarnText:            string       Index (IS_OPTN) read FWarnText write SetWarnText stored WarnText_Specified;
    property AvailableQuantity:   Integer      Index (IS_NLBL) read FAvailableQuantity write FAvailableQuantity;
  end;



  // ************************************************************************ //
  // XML       : partstobasket, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  partstobasket = class(TRemotable)
  private
    FCoeffMaxAgree: Double;
    FUploadedPrice: Double;
    FbitAgree: Boolean;
    FOnlyThisBrand: Boolean;
    FConfirm: Boolean;
    FDelete: Boolean;
    FBasketId: Int64;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FQuantity: Integer;
    FbitOnly: Boolean;
    FbitQuantity: Boolean;
    FbitWait: Boolean;
    FReference: string;
    FReference_Specified: boolean;
    FCustomerSubId: Int64;
    FTransportPack: string;
    FTransportPack_Specified: boolean;
    FDetailWeight: Double;
    FEmExWeight: Double;
    FCustomerStickerData: string;
    FCustomerStickerData_Specified: boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetTransportPack(Index: Integer; const Astring: string);
    function  TransportPack_Specified(Index: Integer): boolean;
    procedure SetCustomerStickerData(Index: Integer; const Astring: string);
    function  CustomerStickerData_Specified(Index: Integer): boolean;
  published
    property CoeffMaxAgree:       Double   read FCoeffMaxAgree write FCoeffMaxAgree;
    property UploadedPrice:       Double   read FUploadedPrice write FUploadedPrice;
    property bitAgree:            Boolean  read FbitAgree write FbitAgree;
    property OnlyThisBrand:       Boolean  read FOnlyThisBrand write FOnlyThisBrand;
    property Confirm:             Boolean  read FConfirm write FConfirm;
    property Delete:              Boolean  read FDelete write FDelete;
    property BasketId:            Int64    read FBasketId write FBasketId;
    property MakeLogo:            string   Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:           string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property DestinationLogo:     string   Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property PriceLogo:           string   Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Quantity:            Integer  read FQuantity write FQuantity;
    property bitOnly:             Boolean  read FbitOnly write FbitOnly;
    property bitQuantity:         Boolean  read FbitQuantity write FbitQuantity;
    property bitWait:             Boolean  read FbitWait write FbitWait;
    property Reference:           string   Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property CustomerSubId:       Int64    read FCustomerSubId write FCustomerSubId;
    property TransportPack:       string   Index (IS_OPTN) read FTransportPack write SetTransportPack stored TransportPack_Specified;
    property DetailWeight:        Double   read FDetailWeight write FDetailWeight;
    property EmExWeight:          Double   read FEmExWeight write FEmExWeight;
    property CustomerStickerData: string   Index (IS_OPTN) read FCustomerStickerData write SetCustomerStickerData stored CustomerStickerData_Specified;
  end;



  // ************************************************************************ //
  // XML       : ListOfOrders, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  ListOfOrders = class(TRemotable)
  private
    FOrderNumber: Integer;
    FOrderDate: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property OrderNumber: Integer      read FOrderNumber write FOrderNumber;
    property OrderDate:   TXSDateTime  read FOrderDate write FOrderDate;
  end;

  ArrayOfSearchHistory2 = array of SearchHistory;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfSearchHistory =  type ArrayOfSearchHistory2;      { "http://emexonline.com:3000/MaximaWS/"[GblElm] }


  // ************************************************************************ //
  // XML       : SearchHistory, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  SearchHistory = class(TRemotable)
  private
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
  published
    property DetailNum: string  Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
  end;

  ArrayOfDestinations2 = array of Destinations;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfDestinations =  type ArrayOfDestinations2;      { "http://emexonline.com:3000/MaximaWS/"[GblElm] }


  // ************************************************************************ //
  // XML       : Balance, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Balance = class(TRemotable)
  private
    FDate: TXSDateTime;
    FDocument: string;
    FDocument_Specified: boolean;
    FComment: string;
    FComment_Specified: boolean;
    FDebit: Double;
    FCredit: Double;
    FSaldo: Double;
    procedure SetDocument(Index: Integer; const Astring: string);
    function  Document_Specified(Index: Integer): boolean;
    procedure SetComment(Index: Integer; const Astring: string);
    function  Comment_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Date:     TXSDateTime  read FDate write FDate;
    property Document: string       Index (IS_OPTN) read FDocument write SetDocument stored Document_Specified;
    property Comment:  string       Index (IS_OPTN) read FComment write SetComment stored Comment_Specified;
    property Debit:    Double       read FDebit write FDebit;
    property Credit:   Double       read FCredit write FCredit;
    property Saldo:    Double       read FSaldo write FSaldo;
  end;



  // ************************************************************************ //
  // XML       : InvDetails, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  InvDetails = class(TRemotable)
  private
    FPortion: Integer;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FOrderDetailSubId: Integer;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FSubstitution: string;
    FSubstitution_Specified: boolean;
    FMakeSubstitution: string;
    FMakeSubstitution_Specified: boolean;
    FReference: string;
    FReference_Specified: boolean;
    FCustomerSubId: string;
    FCustomerSubId_Specified: boolean;
    FWeightGr: Double;
    FOrderNumber: Integer;
    FBoxNumber: Integer;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FMakeName: string;
    FMakeName_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FQuantity: Integer;
    FPrice: Double;
    FDetailNameEng: string;
    FDetailNameEng_Specified: boolean;
    FDetailNameRus: string;
    FDetailNameRus_Specified: boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetSubstitution(Index: Integer; const Astring: string);
    function  Substitution_Specified(Index: Integer): boolean;
    procedure SetMakeSubstitution(Index: Integer; const Astring: string);
    function  MakeSubstitution_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetCustomerSubId(Index: Integer; const Astring: string);
    function  CustomerSubId_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetMakeName(Index: Integer; const Astring: string);
    function  MakeName_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDetailNameEng(Index: Integer; const Astring: string);
    function  DetailNameEng_Specified(Index: Integer): boolean;
    procedure SetDetailNameRus(Index: Integer; const Astring: string);
    function  DetailNameRus_Specified(Index: Integer): boolean;
  published
    property Portion:          Integer  read FPortion write FPortion;
    property DestinationLogo:  string   Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property OrderDetailSubId: Integer  read FOrderDetailSubId write FOrderDetailSubId;
    property PriceLogo:        string   Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property Substitution:     string   Index (IS_OPTN) read FSubstitution write SetSubstitution stored Substitution_Specified;
    property MakeSubstitution: string   Index (IS_OPTN) read FMakeSubstitution write SetMakeSubstitution stored MakeSubstitution_Specified;
    property Reference:        string   Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property CustomerSubId:    string   Index (IS_OPTN) read FCustomerSubId write SetCustomerSubId stored CustomerSubId_Specified;
    property WeightGr:         Double   read FWeightGr write FWeightGr;
    property OrderNumber:      Integer  read FOrderNumber write FOrderNumber;
    property BoxNumber:        Integer  read FBoxNumber write FBoxNumber;
    property MakeLogo:         string   Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property MakeName:         string   Index (IS_OPTN) read FMakeName write SetMakeName stored MakeName_Specified;
    property DetailNum:        string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property Quantity:         Integer  read FQuantity write FQuantity;
    property Price:            Double   read FPrice write FPrice;
    property DetailNameEng:    string   Index (IS_OPTN) read FDetailNameEng write SetDetailNameEng stored DetailNameEng_Specified;
    property DetailNameRus:    string   Index (IS_OPTN) read FDetailNameRus write SetDetailNameRus stored DetailNameRus_Specified;
  end;



  // ************************************************************************ //
  // XML       : BalanceForOrder, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  BalanceForOrder = class(TRemotable)
  private
    FTotal: Double;
    FBalance: Double;
    FCredit: Double;
    FNewOrderAmount: Double;
    FOrdersInWork: string;
    FOrdersInWork_Specified: boolean;
    procedure SetOrdersInWork(Index: Integer; const Astring: string);
    function  OrdersInWork_Specified(Index: Integer): boolean;
  published
    property Total:          Double  read FTotal write FTotal;
    property Balance:        Double  read FBalance write FBalance;
    property Credit:         Double  read FCredit write FCredit;
    property NewOrderAmount: Double  read FNewOrderAmount write FNewOrderAmount;
    property OrdersInWork:   string  Index (IS_OPTN) read FOrdersInWork write SetOrdersInWork stored OrdersInWork_Specified;
  end;

  ArrayOfBalance = array of Balance;            { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : History, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  History = class(TRemotable)
  private
    FOrderDate: TXSDateTime;
    FOrderNumber: Integer;
    FMake: string;
    FMake_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FQuantity: Integer;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FDetailPrice: Double;
    FCondition: string;
    FCondition_Specified: boolean;
    FSteps: Integer;
    FReference: string;
    FReference_Specified: boolean;
    FSubstitution: string;
    FSubstitution_Specified: boolean;
    FMakeSubstitution: string;
    FMakeSubstitution_Specified: boolean;
    FDetailPriceSale: Double;
    FDetailNameRus: string;
    FDetailNameRus_Specified: boolean;
    FDetailNameEng: string;
    FDetailNameEng_Specified: boolean;
    FCustomerSubId: Int64;
    procedure SetMake(Index: Integer; const Astring: string);
    function  Make_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetCondition(Index: Integer; const Astring: string);
    function  Condition_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetSubstitution(Index: Integer; const Astring: string);
    function  Substitution_Specified(Index: Integer): boolean;
    procedure SetMakeSubstitution(Index: Integer; const Astring: string);
    function  MakeSubstitution_Specified(Index: Integer): boolean;
    procedure SetDetailNameRus(Index: Integer; const Astring: string);
    function  DetailNameRus_Specified(Index: Integer): boolean;
    procedure SetDetailNameEng(Index: Integer; const Astring: string);
    function  DetailNameEng_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property OrderDate:        TXSDateTime  read FOrderDate write FOrderDate;
    property OrderNumber:      Integer      read FOrderNumber write FOrderNumber;
    property Make:             string       Index (IS_OPTN) read FMake write SetMake stored Make_Specified;
    property DetailNum:        string       Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property Quantity:         Integer      read FQuantity write FQuantity;
    property DestinationLogo:  string       Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property DetailPrice:      Double       read FDetailPrice write FDetailPrice;
    property Condition:        string       Index (IS_OPTN) read FCondition write SetCondition stored Condition_Specified;
    property Steps:            Integer      read FSteps write FSteps;
    property Reference:        string       Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property Substitution:     string       Index (IS_OPTN) read FSubstitution write SetSubstitution stored Substitution_Specified;
    property MakeSubstitution: string       Index (IS_OPTN) read FMakeSubstitution write SetMakeSubstitution stored MakeSubstitution_Specified;
    property DetailPriceSale:  Double       read FDetailPriceSale write FDetailPriceSale;
    property DetailNameRus:    string       Index (IS_OPTN) read FDetailNameRus write SetDetailNameRus stored DetailNameRus_Specified;
    property DetailNameEng:    string       Index (IS_OPTN) read FDetailNameEng write SetDetailNameEng stored DetailNameEng_Specified;
    property CustomerSubId:    Int64        read FCustomerSubId write FCustomerSubId;
  end;

  ArrayOfHistory_v2 = array of History_v2;      { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : History_v2, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  History_v2 = class(History)
  private
    FInvoiceNumber: Integer;
  published
    property InvoiceNumber: Integer  Index (IS_NLBL) read FInvoiceNumber write FInvoiceNumber;
  end;

  ArrayOfHistory = array of History;            { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Destinations, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Destinations = class(TRemotable)
  private
    FDestinationId: Integer;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
  published
    property DestinationId:   Integer  read FDestinationId write FDestinationId;
    property DestinationLogo: string   Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
  end;

  ArrayOfBoxdetails = array of boxdetails;      { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : boxdetails, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  boxdetails = class(TRemotable)
  private
    FOrderDetailSubId: string;
    FOrderDetailSubId_Specified: boolean;
    FReference: string;
    FReference_Specified: boolean;
    FCustomerSubId: string;
    FCustomerSubId_Specified: boolean;
    FWeightGr: Double;
    FMakeLogo: string;
    FMakeLogo_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FQuantity: Integer;
    FPrice: Double;
    FDetailNameEng: string;
    FDetailNameEng_Specified: boolean;
    FDetailNameRus: string;
    FDetailNameRus_Specified: boolean;
    procedure SetOrderDetailSubId(Index: Integer; const Astring: string);
    function  OrderDetailSubId_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetCustomerSubId(Index: Integer; const Astring: string);
    function  CustomerSubId_Specified(Index: Integer): boolean;
    procedure SetMakeLogo(Index: Integer; const Astring: string);
    function  MakeLogo_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetDetailNameEng(Index: Integer; const Astring: string);
    function  DetailNameEng_Specified(Index: Integer): boolean;
    procedure SetDetailNameRus(Index: Integer; const Astring: string);
    function  DetailNameRus_Specified(Index: Integer): boolean;
  published
    property OrderDetailSubId: string   Index (IS_OPTN) read FOrderDetailSubId write SetOrderDetailSubId stored OrderDetailSubId_Specified;
    property Reference:        string   Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property CustomerSubId:    string   Index (IS_OPTN) read FCustomerSubId write SetCustomerSubId stored CustomerSubId_Specified;
    property WeightGr:         Double   read FWeightGr write FWeightGr;
    property MakeLogo:         string   Index (IS_OPTN) read FMakeLogo write SetMakeLogo stored MakeLogo_Specified;
    property DetailNum:        string   Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property Quantity:         Integer  read FQuantity write FQuantity;
    property Price:            Double   read FPrice write FPrice;
    property DetailNameEng:    string   Index (IS_OPTN) read FDetailNameEng write SetDetailNameEng stored DetailNameEng_Specified;
    property DetailNameRus:    string   Index (IS_OPTN) read FDetailNameRus write SetDetailNameRus stored DetailNameRus_Specified;
  end;

  ArrayOfInvDetails = array of InvDetails;      { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }
  ArrayOfBasketOrderResult = array of BasketOrderResult;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : BasketOrderResult, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  BasketOrderResult = class(TRemotable)
  private
    FBasketId: Int64;
    FOrderDetailId: Int64;
    FErrorCode: Integer;
    FErrorMessage: string;
    FErrorMessage_Specified: boolean;
    procedure SetErrorMessage(Index: Integer; const Astring: string);
    function  ErrorMessage_Specified(Index: Integer): boolean;
  published
    property BasketId:      Int64    read FBasketId write FBasketId;
    property OrderDetailId: Int64    read FOrderDetailId write FOrderDetailId;
    property ErrorCode:     Integer  read FErrorCode write FErrorCode;
    property ErrorMessage:  string   Index (IS_OPTN) read FErrorMessage write SetErrorMessage stored ErrorMessage_Specified;
  end;

  ArrayOfMovement = array of Movement;          { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : CreateOrderResult_v2, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  CreateOrderResult_v2 = class(TRemotable)
  private
    FErrorCode: Integer;
    FMessage_: string;
    FMessage__Specified: boolean;
    FOrderNumber: Int64;
    FBasketOrders: ArrayOfBasketOrderResult;
    FBasketOrders_Specified: boolean;
    procedure SetMessage_(Index: Integer; const Astring: string);
    function  Message__Specified(Index: Integer): boolean;
    procedure SetBasketOrders(Index: Integer; const AArrayOfBasketOrderResult: ArrayOfBasketOrderResult);
    function  BasketOrders_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ErrorCode:    Integer                   read FErrorCode write FErrorCode;
    property Message_:     string                    Index (IS_OPTN) read FMessage_ write SetMessage_ stored Message__Specified;
    property OrderNumber:  Int64                     read FOrderNumber write FOrderNumber;
    property BasketOrders: ArrayOfBasketOrderResult  Index (IS_OPTN) read FBasketOrders write SetBasketOrders stored BasketOrders_Specified;
  end;

  ArrayOfLogInfo = array of LogInfo;            { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : LogInfo, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  LogInfo = class(TRemotable)
  private
    FDateTime: TXSDateTime;
    FText: string;
    FText_Specified: boolean;
    procedure SetText(Index: Integer; const Astring: string);
    function  Text_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DateTime: TXSDateTime  read FDateTime write FDateTime;
    property Text:     string       Index (IS_OPTN) read FText write SetText stored Text_Specified;
  end;

  ArrayOfLong = array of Int64;                 { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Boxes, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Boxes = class(TRemotable)
  private
    FDateCreated: TXSDateTime;
    FBoxType: string;
    FBoxType_Specified: boolean;
    FDestType: string;
    FDestType_Specified: boolean;
    FBoxNumber: Int64;
    FHeight: Double;
    FWidth: Double;
    FLength: Double;
    FWeight: Double;
    FBoxNetAmount: Double;
    FBoxAmount: Double;
    procedure SetBoxType(Index: Integer; const Astring: string);
    function  BoxType_Specified(Index: Integer): boolean;
    procedure SetDestType(Index: Integer; const Astring: string);
    function  DestType_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property DateCreated:  TXSDateTime  read FDateCreated write FDateCreated;
    property BoxType:      string       Index (IS_OPTN) read FBoxType write SetBoxType stored BoxType_Specified;
    property DestType:     string       Index (IS_OPTN) read FDestType write SetDestType stored DestType_Specified;
    property BoxNumber:    Int64        read FBoxNumber write FBoxNumber;
    property Height:       Double       read FHeight write FHeight;
    property Width:        Double       read FWidth write FWidth;
    property Length:       Double       read FLength write FLength;
    property Weight:       Double       read FWeight write FWeight;
    property BoxNetAmount: Double       read FBoxNetAmount write FBoxNetAmount;
    property BoxAmount:    Double       read FBoxAmount write FBoxAmount;
  end;

  ArrayOfInvoicelist = array of Invoicelist;    { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Invoicelist, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Invoicelist = class(TRemotable)
  private
    FInvoiceNumber: Int64;
    FInvoiceDate: TXSDateTime;
    FAmount: Double;
    FWeight: Double;
  public
    destructor Destroy; override;
  published
    property InvoiceNumber: Int64        read FInvoiceNumber write FInvoiceNumber;
    property InvoiceDate:   TXSDateTime  read FInvoiceDate write FInvoiceDate;
    property Amount:        Double       read FAmount write FAmount;
    property Weight:        Double       read FWeight write FWeight;
  end;

  ArrayOfBoxes = array of Boxes;                { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Movement, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  Movement = class(TRemotable)
  private
    FOrderNumber: Int64;
    FDocumentDate: TXSDateTime;
    FOrderDetailSubId: string;
    FOrderDetailSubId_Specified: boolean;
    FComment: string;
    FComment_Specified: boolean;
    FPriceOrdered: Double;
    FPriceSale: Double;
    FMake: string;
    FMake_Specified: boolean;
    FDetailNum: string;
    FDetailNum_Specified: boolean;
    FQuantity: Integer;
    FCondition: string;
    FCondition_Specified: boolean;
    FReference: string;
    FReference_Specified: boolean;
    FDetailNameRus: string;
    FDetailNameRus_Specified: boolean;
    FDetailNameEng: string;
    FDetailNameEng_Specified: boolean;
    FCustomerSubId: Int64;
    FSubstMake: string;
    FSubstMake_Specified: boolean;
    FSubstNum: string;
    FSubstNum_Specified: boolean;
    FDestinationLogo: string;
    FDestinationLogo_Specified: boolean;
    FPriceLogo: string;
    FPriceLogo_Specified: boolean;
    FStatusId: Integer;
    FStateText: string;
    FStateText_Specified: boolean;
    procedure SetOrderDetailSubId(Index: Integer; const Astring: string);
    function  OrderDetailSubId_Specified(Index: Integer): boolean;
    procedure SetComment(Index: Integer; const Astring: string);
    function  Comment_Specified(Index: Integer): boolean;
    procedure SetMake(Index: Integer; const Astring: string);
    function  Make_Specified(Index: Integer): boolean;
    procedure SetDetailNum(Index: Integer; const Astring: string);
    function  DetailNum_Specified(Index: Integer): boolean;
    procedure SetCondition(Index: Integer; const Astring: string);
    function  Condition_Specified(Index: Integer): boolean;
    procedure SetReference(Index: Integer; const Astring: string);
    function  Reference_Specified(Index: Integer): boolean;
    procedure SetDetailNameRus(Index: Integer; const Astring: string);
    function  DetailNameRus_Specified(Index: Integer): boolean;
    procedure SetDetailNameEng(Index: Integer; const Astring: string);
    function  DetailNameEng_Specified(Index: Integer): boolean;
    procedure SetSubstMake(Index: Integer; const Astring: string);
    function  SubstMake_Specified(Index: Integer): boolean;
    procedure SetSubstNum(Index: Integer; const Astring: string);
    function  SubstNum_Specified(Index: Integer): boolean;
    procedure SetDestinationLogo(Index: Integer; const Astring: string);
    function  DestinationLogo_Specified(Index: Integer): boolean;
    procedure SetPriceLogo(Index: Integer; const Astring: string);
    function  PriceLogo_Specified(Index: Integer): boolean;
    procedure SetStateText(Index: Integer; const Astring: string);
    function  StateText_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property OrderNumber:      Int64        read FOrderNumber write FOrderNumber;
    property DocumentDate:     TXSDateTime  read FDocumentDate write FDocumentDate;
    property OrderDetailSubId: string       Index (IS_OPTN) read FOrderDetailSubId write SetOrderDetailSubId stored OrderDetailSubId_Specified;
    property Comment:          string       Index (IS_OPTN) read FComment write SetComment stored Comment_Specified;
    property PriceOrdered:     Double       read FPriceOrdered write FPriceOrdered;
    property PriceSale:        Double       read FPriceSale write FPriceSale;
    property Make:             string       Index (IS_OPTN) read FMake write SetMake stored Make_Specified;
    property DetailNum:        string       Index (IS_OPTN) read FDetailNum write SetDetailNum stored DetailNum_Specified;
    property Quantity:         Integer      read FQuantity write FQuantity;
    property Condition:        string       Index (IS_OPTN) read FCondition write SetCondition stored Condition_Specified;
    property Reference:        string       Index (IS_OPTN) read FReference write SetReference stored Reference_Specified;
    property DetailNameRus:    string       Index (IS_OPTN) read FDetailNameRus write SetDetailNameRus stored DetailNameRus_Specified;
    property DetailNameEng:    string       Index (IS_OPTN) read FDetailNameEng write SetDetailNameEng stored DetailNameEng_Specified;
    property CustomerSubId:    Int64        read FCustomerSubId write FCustomerSubId;
    property SubstMake:        string       Index (IS_OPTN) read FSubstMake write SetSubstMake stored SubstMake_Specified;
    property SubstNum:         string       Index (IS_OPTN) read FSubstNum write SetSubstNum stored SubstNum_Specified;
    property DestinationLogo:  string       Index (IS_OPTN) read FDestinationLogo write SetDestinationLogo stored DestinationLogo_Specified;
    property PriceLogo:        string       Index (IS_OPTN) read FPriceLogo write SetPriceLogo stored PriceLogo_Specified;
    property StatusId:         Integer      read FStatusId write FStatusId;
    property StateText:        string       Index (IS_OPTN) read FStateText write SetStateText stored StateText_Specified;
  end;

  ArrayOfSubCustomers = array of SubCustomers;   { "http://emexonline.com:3000/MaximaWS/"[GblCplx] }


  // ************************************************************************ //
  // XML       : SubCustomers, global, <complexType>
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // ************************************************************************ //
  SubCustomers = class(TRemotable)
  private
    FUserName: string;
    FUserName_Specified: boolean;
    FPassword: string;
    FPassword_Specified: boolean;
    FCustomerId: string;
    FCustomerId_Specified: boolean;
    FDateOfJoin: TXSDateTime;
    FProfit: Double;
    procedure SetUserName(Index: Integer; const Astring: string);
    function  UserName_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const Astring: string);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetCustomerId(Index: Integer; const Astring: string);
    function  CustomerId_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property UserName:   string       Index (IS_OPTN) read FUserName write SetUserName stored UserName_Specified;
    property Password:   string       Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property CustomerId: string       Index (IS_OPTN) read FCustomerId write SetCustomerId stored CustomerId_Specified;
    property DateOfJoin: TXSDateTime  read FDateOfJoin write FDateOfJoin;
    property Profit:     Double       read FProfit write FProfit;
  end;


  // ************************************************************************ //
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // soapAction: http://emexonline.com:3000/MaximaWS/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ServiceSoap12
  // service   : Service
  // port      : ServiceSoap12
  // URL       : http://soap.emexdwc.ae:3000/service.asmx
  // ************************************************************************ //
  ServiceSoap = interface(IInvokable)
  ['{C566451E-075F-856C-41DD-11342377FFC1}']
    function  TEST: string; stdcall;
    function  Login(const Customer: Customer): Customer; stdcall;
    function  SearchPart(const Customer: Customer; const DetailNum: string; const ShowSubsts: Boolean): ArrayOfFindByNumber; stdcall;
    function  SearchPartEx(const Customer: Customer; const DetailNum: string; const ShowSubsts: Boolean; const MakeLogo: string; const PriceLogo: string; const DestinationLogo: string
                           ): ArrayOfFindByNumber; stdcall;
    function  Quotation(const Customer: Customer; const P: ArrayOfQuotation): ArrayOfQuotation; stdcall;
    function  QuotationList(const Customer: Customer; const P: ArrayOfQuotationList): ArrayOfQuotationList; stdcall;
    function  QuotationList_v2(const Customer: Customer; const P: ArrayOfQuotationList_v2): ArrayOfQuotationList_v2; stdcall;
    function  InsertPartToBasket(const Customer: Customer; const Array_: ArrayOfPartstobasket): Integer; stdcall;
    function  InsertPartToBasket_v2(const Customer: Customer; const Array_: ArrayOfPartstobasket; const lang: string): ArrayOfBasketChangeResult; stdcall;
    function  GetBasketDetails(const Customer: Customer): ArrayOfBasketDetails; stdcall;
    function  GetBasketDetails_v2(const Customer: Customer; const lang: string): ArrayOfBasketDetails_v2; stdcall;
    function  UpdateBasketDetails(const Customer: Customer; const P: ArrayOfBasketDetails): Integer; stdcall;
    function  UpdateBasketDetails_v2(const Customer: Customer; const P: ArrayOfBasketDetails; const lang: string): ArrayOfBasketChangeResult; stdcall;
    function  DeleteFromBasket(const Customer: Customer; const P: ArrayOfBasketDetails): Integer; stdcall;
    function  GetCustomersIp(const Customer: Customer): ArrayOfIPlist; stdcall;
    function  DeleteIp(const Customer: Customer; const Ip: string): Integer; stdcall;
    function  InsertIp(const Customer: Customer; const Ip: string; const Desc: string): Integer; stdcall;
    function  UpdateIp(const Customer: Customer; const Ip: string; const Desc: string): Integer; stdcall;
    function  GetListOfOrders(const Customer: Customer; const bitInWork: Boolean): ArrayOfListOfOrders; stdcall;
    function  GetFromInfoLog(const Customer: Customer; const MethodName: string): ArrayOfLogInfo; stdcall;
    function  CreateOrder(const Customer: Customer): Integer; stdcall;
    function  CreateOrder_v2(const Customer: Customer; const basketIds: ArrayOfLong; const lang: string): CreateOrderResult_v2; stdcall;
    function  MovementByOrderNumber(const Customer: Customer; const OrderNumber: Integer): ArrayOfMovement; stdcall;
    function  MovementInWork(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementPurchased(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementNotAvailable(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementReadyToSend(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementReceivedOnStock(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementSent(const Customer: Customer): ArrayOfMovement; stdcall;
    function  MovementAGREE(const Customer: Customer): ArrayOfMovement; stdcall;
    function  SearchInHistory(const Customer: Customer; const Parameter: string; const Type_: Integer): ArrayOfMovement; stdcall;
    function  GetSubCustomersDetails(const Customer: Customer): ArrayOfSubCustomers; stdcall;
    function  DeleteSubCustomer(const Customer: Customer; const SubCustomerId: Integer): Integer; stdcall;
    function  UpdateSubCustomer(const Customer: Customer; const SubCustomerId: Integer; const SubCustomerLogo: string; const Profit: Double; const SubCustomerPassword: string): Integer; stdcall;
    function  AddSubCustomer(const Customer: Customer; const SubCustomerLogo: string; const Profit: Double; const SubCustomerPassword: string): Integer; stdcall;
    function  GetBoxesReadyToSend(const Customer: Customer): ArrayOfBoxes; stdcall;
    function  GetBoxesInIvoice(const Customer: Customer; const InvoiceNumber: Integer): ArrayOfBoxes; stdcall;
    function  GetInvoicesList(const Customer: Customer): ArrayOfInvoicelist; stdcall;
    function  GetPackingDetails(const Customer: Customer; const InvoiceNumber: Integer): ArrayOfInvDetails; stdcall;
    function  GetInvoiceDetails(const Customer: Customer; const InvoiceNumber: Integer): ArrayOfInvDetails; stdcall;
    function  AllowCreateOrder(const Customer: Customer): BalanceForOrder; stdcall;
    function  GetBalance(const Customer: Customer): ArrayOfBalance; stdcall;
    function  SetAgree(const Customer: Customer; const OrderDetailSubId: Int64): Integer; stdcall;
    function  SearchHistory(const Customer: Customer): ArrayOfSearchHistory2; stdcall;
    function  FindSameNumbers(const DetailNum: string): ArrayOfSearchHistory2; stdcall;
    function  GetDestinations(const PriceLogo: string): ArrayOfDestinations2; stdcall;
    function  GetCustDestinations(const Customer: Customer; const PriceLogo: string): ArrayOfDestinations2; stdcall;
    function  GetBoxDetails(const Customer: Customer; const BoxNumber: Integer): ArrayOfBoxdetails; stdcall;
    function  GetDetailHistory(const Customer: Customer; const Parameter: string; const Type_: Integer): ArrayOfHistory; stdcall;
    function  GetDetailHistory_v2(const Customer: Customer; const Parameter: string; const Type_: Integer): ArrayOfHistory_v2; stdcall;
    function  SearchInHistory_Log(const Customer: Customer; const Parameter: string; const Type_: Integer): ArrayOfMovement; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // style     : ????
  // use       : ????
  // binding   : ServiceHttpGet
  // service   : Service
  // port      : ServiceHttpGet
  // ************************************************************************ //
  ServiceHttpGet = interface(IInvokable)
  ['{29B84785-840B-AD96-9F3C-9B715AB27FB3}']
    function  TEST: string_; stdcall;
    function  FindSameNumbers(const DetailNum: string): ArrayOfSearchHistory; stdcall;
    function  GetDestinations(const PriceLogo: string): ArrayOfDestinations; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://emexonline.com:3000/MaximaWS/
  // style     : ????
  // use       : ????
  // binding   : ServiceHttpPost
  // service   : Service
  // port      : ServiceHttpPost
  // ************************************************************************ //
  ServiceHttpPost = interface(IInvokable)
  ['{D5336BAF-CB3F-DDA6-40FF-A31DE25273E8}']
    function  TEST: string_; stdcall;
    function  FindSameNumbers(const DetailNum: string): ArrayOfSearchHistory; stdcall;
    function  GetDestinations(const PriceLogo: string): ArrayOfDestinations; stdcall;
  end;

function GetServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServiceSoap;
function GetServiceHttpGet(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServiceHttpGet;
function GetServiceHttpPost(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServiceHttpPost;


implementation
  uses System.SysUtils;

function GetServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServiceSoap;
const
  defWSDL = 'https://soap.emexdwc.ae/service.asmx?WSDL';
  defSvc  = 'Service';
  defPrt  = 'ServiceSoap12';
  defURL  = '';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetServiceHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServiceHttpGet;
const
  defWSDL = 'https://soap.emexdwc.ae/service.asmx?WSDL';
  defURL  = '';
  defSvc  = 'Service';
  defPrt  = 'ServiceHttpGet';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ServiceHttpGet);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetServiceHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServiceHttpPost;
const
  defWSDL = 'https://soap.emexdwc.ae/service.asmx?WSDL';
  defURL  = '';
  defSvc  = 'Service';
  defPrt  = 'ServiceHttpPost';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ServiceHttpPost);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor IPlist.Destroy;
begin
  System.SysUtils.FreeAndNil(FDateAdd);
  inherited Destroy;
end;

procedure IPlist.SetDesc(Index: Integer; const Astring: string);
begin
  FDesc := Astring;
  FDesc_Specified := True;
end;

function IPlist.Desc_Specified(Index: Integer): boolean;
begin
  Result := FDesc_Specified;
end;

procedure IPlist.SetIP(Index: Integer; const Astring: string);
begin
  FIP := Astring;
  FIP_Specified := True;
end;

function IPlist.IP_Specified(Index: Integer): boolean;
begin
  Result := FIP_Specified;
end;

procedure BasketChangeResult.SetWarnText(Index: Integer; const Astring: string);
begin
  FWarnText := Astring;
  FWarnText_Specified := True;
end;

function BasketChangeResult.WarnText_Specified(Index: Integer): boolean;
begin
  Result := FWarnText_Specified;
end;

procedure Customer.SetUserName(Index: Integer; const Astring: string);
begin
  FUserName := Astring;
  FUserName_Specified := True;
end;

function Customer.UserName_Specified(Index: Integer): boolean;
begin
  Result := FUserName_Specified;
end;

procedure Customer.SetPassword(Index: Integer; const Astring: string);
begin
  FPassword := Astring;
  FPassword_Specified := True;
end;

function Customer.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure Customer.SetSubCustomerId(Index: Integer; const Astring: string);
begin
  FSubCustomerId := Astring;
  FSubCustomerId_Specified := True;
end;

function Customer.SubCustomerId_Specified(Index: Integer): boolean;
begin
  Result := FSubCustomerId_Specified;
end;

procedure Customer.SetCustomerId(Index: Integer; const Astring: string);
begin
  FCustomerId := Astring;
  FCustomerId_Specified := True;
end;

function Customer.CustomerId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerId_Specified;
end;

procedure QuotationList.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function QuotationList.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure QuotationList.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function QuotationList.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure QuotationList.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function QuotationList.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure QuotationList.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function QuotationList.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure QuotationList.SetPartNameRus(Index: Integer; const Astring: string);
begin
  FPartNameRus := Astring;
  FPartNameRus_Specified := True;
end;

function QuotationList.PartNameRus_Specified(Index: Integer): boolean;
begin
  Result := FPartNameRus_Specified;
end;

procedure QuotationList.SetPartNameEng(Index: Integer; const Astring: string);
begin
  FPartNameEng := Astring;
  FPartNameEng_Specified := True;
end;

function QuotationList.PartNameEng_Specified(Index: Integer): boolean;
begin
  Result := FPartNameEng_Specified;
end;

procedure QuotationList.SetMakeName(Index: Integer; const Astring: string);
begin
  FMakeName := Astring;
  FMakeName_Specified := True;
end;

function QuotationList.MakeName_Specified(Index: Integer): boolean;
begin
  Result := FMakeName_Specified;
end;

procedure QuotationList.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function QuotationList.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure Quotation.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function Quotation.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure Quotation.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function Quotation.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure Quotation.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function Quotation.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure Quotation.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function Quotation.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure Quotation.SetPartNameRus(Index: Integer; const Astring: string);
begin
  FPartNameRus := Astring;
  FPartNameRus_Specified := True;
end;

function Quotation.PartNameRus_Specified(Index: Integer): boolean;
begin
  Result := FPartNameRus_Specified;
end;

procedure Quotation.SetPartNameEng(Index: Integer; const Astring: string);
begin
  FPartNameEng := Astring;
  FPartNameEng_Specified := True;
end;

function Quotation.PartNameEng_Specified(Index: Integer): boolean;
begin
  Result := FPartNameEng_Specified;
end;

procedure Quotation.SetMakeName(Index: Integer; const Astring: string);
begin
  FMakeName := Astring;
  FMakeName_Specified := True;
end;

function Quotation.MakeName_Specified(Index: Integer): boolean;
begin
  Result := FMakeName_Specified;
end;

procedure FindByNumber.SetAvailable(Index: Integer; const Astring: string);
begin
  FAvailable := Astring;
  FAvailable_Specified := True;
end;

function FindByNumber.Available_Specified(Index: Integer): boolean;
begin
  Result := FAvailable_Specified;
end;

procedure FindByNumber.SetRegion(Index: Integer; const Astring: string);
begin
  FRegion := Astring;
  FRegion_Specified := True;
end;

function FindByNumber.Region_Specified(Index: Integer): boolean;
begin
  Result := FRegion_Specified;
end;

procedure FindByNumber.SetMake(Index: Integer; const Astring: string);
begin
  FMake := Astring;
  FMake_Specified := True;
end;

function FindByNumber.Make_Specified(Index: Integer): boolean;
begin
  Result := FMake_Specified;
end;

procedure FindByNumber.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function FindByNumber.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure FindByNumber.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function FindByNumber.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure FindByNumber.SetPartNameRus(Index: Integer; const Astring: string);
begin
  FPartNameRus := Astring;
  FPartNameRus_Specified := True;
end;

function FindByNumber.PartNameRus_Specified(Index: Integer): boolean;
begin
  Result := FPartNameRus_Specified;
end;

procedure FindByNumber.SetPartNameEng(Index: Integer; const Astring: string);
begin
  FPartNameEng := Astring;
  FPartNameEng_Specified := True;
end;

function FindByNumber.PartNameEng_Specified(Index: Integer): boolean;
begin
  Result := FPartNameEng_Specified;
end;

procedure FindByNumber.SetMakeName(Index: Integer; const Astring: string);
begin
  FMakeName := Astring;
  FMakeName_Specified := True;
end;

function FindByNumber.MakeName_Specified(Index: Integer): boolean;
begin
  Result := FMakeName_Specified;
end;

procedure FindByNumber.SetGuaranteedDay(Index: Integer; const Astring: string);
begin
  FGuaranteedDay := Astring;
  FGuaranteedDay_Specified := True;
end;

function FindByNumber.GuaranteedDay_Specified(Index: Integer): boolean;
begin
  Result := FGuaranteedDay_Specified;
end;

destructor BasketDetails.Destroy;
begin
  System.SysUtils.FreeAndNil(FDate_add);
  inherited Destroy;
end;

procedure BasketDetails.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function BasketDetails.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure BasketDetails.SetCustomerLogo(Index: Integer; const Astring: string);
begin
  FCustomerLogo := Astring;
  FCustomerLogo_Specified := True;
end;

function BasketDetails.CustomerLogo_Specified(Index: Integer): boolean;
begin
  Result := FCustomerLogo_Specified;
end;

procedure BasketDetails.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function BasketDetails.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure BasketDetails.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function BasketDetails.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure BasketDetails.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function BasketDetails.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure BasketDetails.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function BasketDetails.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure BasketDetails.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function BasketDetails.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure BasketDetails.SetCustomerSubId(Index: Integer; const Astring: string);
begin
  FCustomerSubId := Astring;
  FCustomerSubId_Specified := True;
end;

function BasketDetails.CustomerSubId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerSubId_Specified;
end;

procedure BasketDetails.SetTransportPack(Index: Integer; const Astring: string);
begin
  FTransportPack := Astring;
  FTransportPack_Specified := True;
end;

function BasketDetails.TransportPack_Specified(Index: Integer): boolean;
begin
  Result := FTransportPack_Specified;
end;

destructor BasketDetails_v2.Destroy;
begin
  System.SysUtils.FreeAndNil(FDate_add);
  inherited Destroy;
end;

procedure BasketDetails_v2.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function BasketDetails_v2.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure BasketDetails_v2.SetCustomerLogo(Index: Integer; const Astring: string);
begin
  FCustomerLogo := Astring;
  FCustomerLogo_Specified := True;
end;

function BasketDetails_v2.CustomerLogo_Specified(Index: Integer): boolean;
begin
  Result := FCustomerLogo_Specified;
end;

procedure BasketDetails_v2.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function BasketDetails_v2.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure BasketDetails_v2.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function BasketDetails_v2.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure BasketDetails_v2.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function BasketDetails_v2.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure BasketDetails_v2.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function BasketDetails_v2.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure BasketDetails_v2.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function BasketDetails_v2.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure BasketDetails_v2.SetCustomerSubId(Index: Integer; const Astring: string);
begin
  FCustomerSubId := Astring;
  FCustomerSubId_Specified := True;
end;

function BasketDetails_v2.CustomerSubId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerSubId_Specified;
end;

procedure BasketDetails_v2.SetTransportPack(Index: Integer; const Astring: string);
begin
  FTransportPack := Astring;
  FTransportPack_Specified := True;
end;

function BasketDetails_v2.TransportPack_Specified(Index: Integer): boolean;
begin
  Result := FTransportPack_Specified;
end;

procedure BasketDetails_v2.SetWarnText(Index: Integer; const Astring: string);
begin
  FWarnText := Astring;
  FWarnText_Specified := True;
end;

function BasketDetails_v2.WarnText_Specified(Index: Integer): boolean;
begin
  Result := FWarnText_Specified;
end;

procedure partstobasket.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function partstobasket.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure partstobasket.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function partstobasket.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure partstobasket.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function partstobasket.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure partstobasket.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function partstobasket.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure partstobasket.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function partstobasket.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure partstobasket.SetTransportPack(Index: Integer; const Astring: string);
begin
  FTransportPack := Astring;
  FTransportPack_Specified := True;
end;

function partstobasket.TransportPack_Specified(Index: Integer): boolean;
begin
  Result := FTransportPack_Specified;
end;

procedure partstobasket.SetCustomerStickerData(Index: Integer; const Astring: string);
begin
  FCustomerStickerData := Astring;
  FCustomerStickerData_Specified := True;
end;

function partstobasket.CustomerStickerData_Specified(Index: Integer): boolean;
begin
  Result := FCustomerStickerData_Specified;
end;

destructor ListOfOrders.Destroy;
begin
  System.SysUtils.FreeAndNil(FOrderDate);
  inherited Destroy;
end;

procedure SearchHistory.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function SearchHistory.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

destructor Balance.Destroy;
begin
  System.SysUtils.FreeAndNil(FDate);
  inherited Destroy;
end;

procedure Balance.SetDocument(Index: Integer; const Astring: string);
begin
  FDocument := Astring;
  FDocument_Specified := True;
end;

function Balance.Document_Specified(Index: Integer): boolean;
begin
  Result := FDocument_Specified;
end;

procedure Balance.SetComment(Index: Integer; const Astring: string);
begin
  FComment := Astring;
  FComment_Specified := True;
end;

function Balance.Comment_Specified(Index: Integer): boolean;
begin
  Result := FComment_Specified;
end;

procedure InvDetails.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function InvDetails.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure InvDetails.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function InvDetails.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure InvDetails.SetSubstitution(Index: Integer; const Astring: string);
begin
  FSubstitution := Astring;
  FSubstitution_Specified := True;
end;

function InvDetails.Substitution_Specified(Index: Integer): boolean;
begin
  Result := FSubstitution_Specified;
end;

procedure InvDetails.SetMakeSubstitution(Index: Integer; const Astring: string);
begin
  FMakeSubstitution := Astring;
  FMakeSubstitution_Specified := True;
end;

function InvDetails.MakeSubstitution_Specified(Index: Integer): boolean;
begin
  Result := FMakeSubstitution_Specified;
end;

procedure InvDetails.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function InvDetails.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure InvDetails.SetCustomerSubId(Index: Integer; const Astring: string);
begin
  FCustomerSubId := Astring;
  FCustomerSubId_Specified := True;
end;

function InvDetails.CustomerSubId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerSubId_Specified;
end;

procedure InvDetails.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function InvDetails.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure InvDetails.SetMakeName(Index: Integer; const Astring: string);
begin
  FMakeName := Astring;
  FMakeName_Specified := True;
end;

function InvDetails.MakeName_Specified(Index: Integer): boolean;
begin
  Result := FMakeName_Specified;
end;

procedure InvDetails.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function InvDetails.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure InvDetails.SetDetailNameEng(Index: Integer; const Astring: string);
begin
  FDetailNameEng := Astring;
  FDetailNameEng_Specified := True;
end;

function InvDetails.DetailNameEng_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameEng_Specified;
end;

procedure InvDetails.SetDetailNameRus(Index: Integer; const Astring: string);
begin
  FDetailNameRus := Astring;
  FDetailNameRus_Specified := True;
end;

function InvDetails.DetailNameRus_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameRus_Specified;
end;

procedure BalanceForOrder.SetOrdersInWork(Index: Integer; const Astring: string);
begin
  FOrdersInWork := Astring;
  FOrdersInWork_Specified := True;
end;

function BalanceForOrder.OrdersInWork_Specified(Index: Integer): boolean;
begin
  Result := FOrdersInWork_Specified;
end;

destructor History.Destroy;
begin
  System.SysUtils.FreeAndNil(FOrderDate);
  inherited Destroy;
end;

procedure History.SetMake(Index: Integer; const Astring: string);
begin
  FMake := Astring;
  FMake_Specified := True;
end;

function History.Make_Specified(Index: Integer): boolean;
begin
  Result := FMake_Specified;
end;

procedure History.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function History.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure History.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function History.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure History.SetCondition(Index: Integer; const Astring: string);
begin
  FCondition := Astring;
  FCondition_Specified := True;
end;

function History.Condition_Specified(Index: Integer): boolean;
begin
  Result := FCondition_Specified;
end;

procedure History.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function History.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure History.SetSubstitution(Index: Integer; const Astring: string);
begin
  FSubstitution := Astring;
  FSubstitution_Specified := True;
end;

function History.Substitution_Specified(Index: Integer): boolean;
begin
  Result := FSubstitution_Specified;
end;

procedure History.SetMakeSubstitution(Index: Integer; const Astring: string);
begin
  FMakeSubstitution := Astring;
  FMakeSubstitution_Specified := True;
end;

function History.MakeSubstitution_Specified(Index: Integer): boolean;
begin
  Result := FMakeSubstitution_Specified;
end;

procedure History.SetDetailNameRus(Index: Integer; const Astring: string);
begin
  FDetailNameRus := Astring;
  FDetailNameRus_Specified := True;
end;

function History.DetailNameRus_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameRus_Specified;
end;

procedure History.SetDetailNameEng(Index: Integer; const Astring: string);
begin
  FDetailNameEng := Astring;
  FDetailNameEng_Specified := True;
end;

function History.DetailNameEng_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameEng_Specified;
end;

procedure Destinations.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function Destinations.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure boxdetails.SetOrderDetailSubId(Index: Integer; const Astring: string);
begin
  FOrderDetailSubId := Astring;
  FOrderDetailSubId_Specified := True;
end;

function boxdetails.OrderDetailSubId_Specified(Index: Integer): boolean;
begin
  Result := FOrderDetailSubId_Specified;
end;

procedure boxdetails.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function boxdetails.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure boxdetails.SetCustomerSubId(Index: Integer; const Astring: string);
begin
  FCustomerSubId := Astring;
  FCustomerSubId_Specified := True;
end;

function boxdetails.CustomerSubId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerSubId_Specified;
end;

procedure boxdetails.SetMakeLogo(Index: Integer; const Astring: string);
begin
  FMakeLogo := Astring;
  FMakeLogo_Specified := True;
end;

function boxdetails.MakeLogo_Specified(Index: Integer): boolean;
begin
  Result := FMakeLogo_Specified;
end;

procedure boxdetails.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function boxdetails.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure boxdetails.SetDetailNameEng(Index: Integer; const Astring: string);
begin
  FDetailNameEng := Astring;
  FDetailNameEng_Specified := True;
end;

function boxdetails.DetailNameEng_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameEng_Specified;
end;

procedure boxdetails.SetDetailNameRus(Index: Integer; const Astring: string);
begin
  FDetailNameRus := Astring;
  FDetailNameRus_Specified := True;
end;

function boxdetails.DetailNameRus_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameRus_Specified;
end;

procedure BasketOrderResult.SetErrorMessage(Index: Integer; const Astring: string);
begin
  FErrorMessage := Astring;
  FErrorMessage_Specified := True;
end;

function BasketOrderResult.ErrorMessage_Specified(Index: Integer): boolean;
begin
  Result := FErrorMessage_Specified;
end;

destructor CreateOrderResult_v2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FBasketOrders)-1 do
    System.SysUtils.FreeAndNil(FBasketOrders[I]);
  System.SetLength(FBasketOrders, 0);
  inherited Destroy;
end;

procedure CreateOrderResult_v2.SetMessage_(Index: Integer; const Astring: string);
begin
  FMessage_ := Astring;
  FMessage__Specified := True;
end;

function CreateOrderResult_v2.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure CreateOrderResult_v2.SetBasketOrders(Index: Integer; const AArrayOfBasketOrderResult: ArrayOfBasketOrderResult);
begin
  FBasketOrders := AArrayOfBasketOrderResult;
  FBasketOrders_Specified := True;
end;

function CreateOrderResult_v2.BasketOrders_Specified(Index: Integer): boolean;
begin
  Result := FBasketOrders_Specified;
end;

destructor LogInfo.Destroy;
begin
  System.SysUtils.FreeAndNil(FDateTime);
  inherited Destroy;
end;

procedure LogInfo.SetText(Index: Integer; const Astring: string);
begin
  FText := Astring;
  FText_Specified := True;
end;

function LogInfo.Text_Specified(Index: Integer): boolean;
begin
  Result := FText_Specified;
end;

destructor Boxes.Destroy;
begin
  System.SysUtils.FreeAndNil(FDateCreated);
  inherited Destroy;
end;

procedure Boxes.SetBoxType(Index: Integer; const Astring: string);
begin
  FBoxType := Astring;
  FBoxType_Specified := True;
end;

function Boxes.BoxType_Specified(Index: Integer): boolean;
begin
  Result := FBoxType_Specified;
end;

procedure Boxes.SetDestType(Index: Integer; const Astring: string);
begin
  FDestType := Astring;
  FDestType_Specified := True;
end;

function Boxes.DestType_Specified(Index: Integer): boolean;
begin
  Result := FDestType_Specified;
end;

destructor Invoicelist.Destroy;
begin
  System.SysUtils.FreeAndNil(FInvoiceDate);
  inherited Destroy;
end;

destructor Movement.Destroy;
begin
  System.SysUtils.FreeAndNil(FDocumentDate);
  inherited Destroy;
end;

procedure Movement.SetOrderDetailSubId(Index: Integer; const Astring: string);
begin
  FOrderDetailSubId := Astring;
  FOrderDetailSubId_Specified := True;
end;

function Movement.OrderDetailSubId_Specified(Index: Integer): boolean;
begin
  Result := FOrderDetailSubId_Specified;
end;

procedure Movement.SetComment(Index: Integer; const Astring: string);
begin
  FComment := Astring;
  FComment_Specified := True;
end;

function Movement.Comment_Specified(Index: Integer): boolean;
begin
  Result := FComment_Specified;
end;

procedure Movement.SetMake(Index: Integer; const Astring: string);
begin
  FMake := Astring;
  FMake_Specified := True;
end;

function Movement.Make_Specified(Index: Integer): boolean;
begin
  Result := FMake_Specified;
end;

procedure Movement.SetDetailNum(Index: Integer; const Astring: string);
begin
  FDetailNum := Astring;
  FDetailNum_Specified := True;
end;

function Movement.DetailNum_Specified(Index: Integer): boolean;
begin
  Result := FDetailNum_Specified;
end;

procedure Movement.SetCondition(Index: Integer; const Astring: string);
begin
  FCondition := Astring;
  FCondition_Specified := True;
end;

function Movement.Condition_Specified(Index: Integer): boolean;
begin
  Result := FCondition_Specified;
end;

procedure Movement.SetReference(Index: Integer; const Astring: string);
begin
  FReference := Astring;
  FReference_Specified := True;
end;

function Movement.Reference_Specified(Index: Integer): boolean;
begin
  Result := FReference_Specified;
end;

procedure Movement.SetDetailNameRus(Index: Integer; const Astring: string);
begin
  FDetailNameRus := Astring;
  FDetailNameRus_Specified := True;
end;

function Movement.DetailNameRus_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameRus_Specified;
end;

procedure Movement.SetDetailNameEng(Index: Integer; const Astring: string);
begin
  FDetailNameEng := Astring;
  FDetailNameEng_Specified := True;
end;

function Movement.DetailNameEng_Specified(Index: Integer): boolean;
begin
  Result := FDetailNameEng_Specified;
end;

procedure Movement.SetSubstMake(Index: Integer; const Astring: string);
begin
  FSubstMake := Astring;
  FSubstMake_Specified := True;
end;

function Movement.SubstMake_Specified(Index: Integer): boolean;
begin
  Result := FSubstMake_Specified;
end;

procedure Movement.SetSubstNum(Index: Integer; const Astring: string);
begin
  FSubstNum := Astring;
  FSubstNum_Specified := True;
end;

function Movement.SubstNum_Specified(Index: Integer): boolean;
begin
  Result := FSubstNum_Specified;
end;

procedure Movement.SetDestinationLogo(Index: Integer; const Astring: string);
begin
  FDestinationLogo := Astring;
  FDestinationLogo_Specified := True;
end;

function Movement.DestinationLogo_Specified(Index: Integer): boolean;
begin
  Result := FDestinationLogo_Specified;
end;

procedure Movement.SetPriceLogo(Index: Integer; const Astring: string);
begin
  FPriceLogo := Astring;
  FPriceLogo_Specified := True;
end;

function Movement.PriceLogo_Specified(Index: Integer): boolean;
begin
  Result := FPriceLogo_Specified;
end;

procedure Movement.SetStateText(Index: Integer; const Astring: string);
begin
  FStateText := Astring;
  FStateText_Specified := True;
end;

function Movement.StateText_Specified(Index: Integer): boolean;
begin
  Result := FStateText_Specified;
end;

destructor SubCustomers.Destroy;
begin
  System.SysUtils.FreeAndNil(FDateOfJoin);
  inherited Destroy;
end;

procedure SubCustomers.SetUserName(Index: Integer; const Astring: string);
begin
  FUserName := Astring;
  FUserName_Specified := True;
end;

function SubCustomers.UserName_Specified(Index: Integer): boolean;
begin
  Result := FUserName_Specified;
end;

procedure SubCustomers.SetPassword(Index: Integer; const Astring: string);
begin
  FPassword := Astring;
  FPassword_Specified := True;
end;

function SubCustomers.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure SubCustomers.SetCustomerId(Index: Integer; const Astring: string);
begin
  FCustomerId := Astring;
  FCustomerId_Specified := True;
end;

function SubCustomers.CustomerId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerId_Specified;
end;

initialization
  { ServiceSoap }
  InvRegistry.RegisterInterface(TypeInfo(ServiceSoap), 'http://emexonline.com:3000/MaximaWS/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServiceSoap), 'http://emexonline.com:3000/MaximaWS/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServiceSoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServiceSoap), ioSOAP12);
  { ServiceSoap.TEST }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'TEST', '',
                                 '[ReturnName="TESTResult"]', IS_OPTN);
  { ServiceSoap.Login }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'Login', '',
                                 '[ReturnName="LoginResult"]', IS_OPTN);
  { ServiceSoap.SearchPart }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SearchPart', '',
                                 '[ReturnName="SearchPartResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchPart', 'SearchPartResult', '',
                                '[ArrayItemName="FindByNumber"]');
  { ServiceSoap.SearchPartEx }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SearchPartEx', '',
                                 '[ReturnName="SearchPartExResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchPartEx', 'SearchPartExResult', '',
                                '[ArrayItemName="FindByNumber"]');
  { ServiceSoap.Quotation }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'Quotation', '',
                                 '[ReturnName="QuotationResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'Quotation', 'P', '',
                                '[ArrayItemName="Quotation"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'Quotation', 'QuotationResult', '',
                                '[ArrayItemName="Quotation"]');
  { ServiceSoap.QuotationList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'QuotationList', '',
                                 '[ReturnName="QuotationListResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'QuotationList', 'P', '',
                                '[ArrayItemName="QuotationList"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'QuotationList', 'QuotationListResult', '',
                                '[ArrayItemName="QuotationList"]');
  { ServiceSoap.QuotationList_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'QuotationList_v2', '',
                                 '[ReturnName="QuotationList_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'QuotationList_v2', 'P', '',
                                '[ArrayItemName="QuotationList_v2"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'QuotationList_v2', 'QuotationList_v2Result', '',
                                '[ArrayItemName="QuotationList_v2"]');
  { ServiceSoap.InsertPartToBasket }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'InsertPartToBasket', '',
                                 '[ReturnName="InsertPartToBasketResult"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'InsertPartToBasket', 'Array_', 'Array',
                                '[ArrayItemName="partstobasket"]');
  { ServiceSoap.InsertPartToBasket_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'InsertPartToBasket_v2', '',
                                 '[ReturnName="InsertPartToBasket_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'InsertPartToBasket_v2', 'Array_', 'Array',
                                '[ArrayItemName="partstobasket"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'InsertPartToBasket_v2', 'InsertPartToBasket_v2Result', '',
                                '[ArrayItemName="BasketChangeResult"]');
  { ServiceSoap.GetBasketDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBasketDetails', '',
                                 '[ReturnName="GetBasketDetailsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBasketDetails', 'GetBasketDetailsResult', '',
                                '[ArrayItemName="BasketDetails"]');
  { ServiceSoap.GetBasketDetails_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBasketDetails_v2', '',
                                 '[ReturnName="GetBasketDetails_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBasketDetails_v2', 'GetBasketDetails_v2Result', '',
                                '[ArrayItemName="BasketDetails_v2"]');
  { ServiceSoap.UpdateBasketDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'UpdateBasketDetails', '',
                                 '[ReturnName="UpdateBasketDetailsResult"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'UpdateBasketDetails', 'P', '',
                                '[ArrayItemName="BasketDetails"]');
  { ServiceSoap.UpdateBasketDetails_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'UpdateBasketDetails_v2', '',
                                 '[ReturnName="UpdateBasketDetails_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'UpdateBasketDetails_v2', 'P', '',
                                '[ArrayItemName="BasketDetails"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'UpdateBasketDetails_v2', 'UpdateBasketDetails_v2Result', '',
                                '[ArrayItemName="BasketChangeResult"]');
  { ServiceSoap.DeleteFromBasket }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'DeleteFromBasket', '',
                                 '[ReturnName="DeleteFromBasketResult"]');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'DeleteFromBasket', 'P', '',
                                '[ArrayItemName="BasketDetails"]');
  { ServiceSoap.GetCustomersIp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetCustomersIp', '',
                                 '[ReturnName="GetCustomersIpResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetCustomersIp', 'GetCustomersIpResult', '',
                                '[ArrayItemName="IPlist"]');
  { ServiceSoap.DeleteIp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'DeleteIp', '',
                                 '[ReturnName="DeleteIpResult"]');
  { ServiceSoap.InsertIp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'InsertIp', '',
                                 '[ReturnName="InsertIpResult"]');
  { ServiceSoap.UpdateIp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'UpdateIp', '',
                                 '[ReturnName="UpdateIpResult"]');
  { ServiceSoap.GetListOfOrders }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetListOfOrders', '',
                                 '[ReturnName="GetListOfOrdersResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetListOfOrders', 'GetListOfOrdersResult', '',
                                '[ArrayItemName="ListOfOrders"]');
  { ServiceSoap.GetFromInfoLog }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetFromInfoLog', '',
                                 '[ReturnName="GetFromInfoLogResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetFromInfoLog', 'GetFromInfoLogResult', '',
                                '[ArrayItemName="LogInfo"]');
  { ServiceSoap.CreateOrder }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CreateOrder', '',
                                 '[ReturnName="CreateOrderResult"]');
  { ServiceSoap.CreateOrder_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CreateOrder_v2', '',
                                 '[ReturnName="CreateOrder_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'CreateOrder_v2', 'basketIds', '',
                                '[ArrayItemName="long"]');
  { ServiceSoap.MovementByOrderNumber }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementByOrderNumber', '',
                                 '[ReturnName="MovementByOrderNumberResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementByOrderNumber', 'MovementByOrderNumberResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementInWork }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementInWork', '',
                                 '[ReturnName="MovementInWorkResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementInWork', 'MovementInWorkResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementPurchased }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementPurchased', '',
                                 '[ReturnName="MovementPurchasedResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementPurchased', 'MovementPurchasedResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementNotAvailable }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementNotAvailable', '',
                                 '[ReturnName="MovementNotAvailableResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementNotAvailable', 'MovementNotAvailableResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementReadyToSend }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementReadyToSend', '',
                                 '[ReturnName="MovementReadyToSendResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementReadyToSend', 'MovementReadyToSendResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementReceivedOnStock }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementReceivedOnStock', '',
                                 '[ReturnName="MovementReceivedOnStockResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementReceivedOnStock', 'MovementReceivedOnStockResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementSent }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementSent', '',
                                 '[ReturnName="MovementSentResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementSent', 'MovementSentResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.MovementAGREE }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MovementAGREE', '',
                                 '[ReturnName="MovementAGREEResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'MovementAGREE', 'MovementAGREEResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.SearchInHistory }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SearchInHistory', '',
                                 '[ReturnName="SearchInHistoryResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchInHistory', 'Type_', 'Type', '');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchInHistory', 'SearchInHistoryResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceSoap.GetSubCustomersDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetSubCustomersDetails', '',
                                 '[ReturnName="GetSubCustomersDetailsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetSubCustomersDetails', 'GetSubCustomersDetailsResult', '',
                                '[ArrayItemName="SubCustomers"]');
  { ServiceSoap.DeleteSubCustomer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'DeleteSubCustomer', '',
                                 '[ReturnName="DeleteSubCustomerResult"]');
  { ServiceSoap.UpdateSubCustomer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'UpdateSubCustomer', '',
                                 '[ReturnName="UpdateSubCustomerResult"]');
  { ServiceSoap.AddSubCustomer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AddSubCustomer', '',
                                 '[ReturnName="AddSubCustomerResult"]');
  { ServiceSoap.GetBoxesReadyToSend }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBoxesReadyToSend', '',
                                 '[ReturnName="GetBoxesReadyToSendResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBoxesReadyToSend', 'GetBoxesReadyToSendResult', '',
                                '[ArrayItemName="Boxes"]');
  { ServiceSoap.GetBoxesInIvoice }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBoxesInIvoice', '',
                                 '[ReturnName="GetBoxesInIvoiceResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBoxesInIvoice', 'GetBoxesInIvoiceResult', '',
                                '[ArrayItemName="Boxes"]');
  { ServiceSoap.GetInvoicesList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetInvoicesList', '',
                                 '[ReturnName="GetInvoicesListResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetInvoicesList', 'GetInvoicesListResult', '',
                                '[ArrayItemName="Invoicelist"]');
  { ServiceSoap.GetPackingDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetPackingDetails', '',
                                 '[ReturnName="GetPackingDetailsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetPackingDetails', 'GetPackingDetailsResult', '',
                                '[ArrayItemName="InvDetails"]');
  { ServiceSoap.GetInvoiceDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetInvoiceDetails', '',
                                 '[ReturnName="GetInvoiceDetailsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetInvoiceDetails', 'GetInvoiceDetailsResult', '',
                                '[ArrayItemName="InvDetails"]');
  { ServiceSoap.AllowCreateOrder }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AllowCreateOrder', '',
                                 '[ReturnName="AllowCreateOrderResult"]', IS_OPTN);
  { ServiceSoap.GetBalance }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBalance', '',
                                 '[ReturnName="GetBalanceResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBalance', 'GetBalanceResult', '',
                                '[ArrayItemName="Balance"]');
  { ServiceSoap.SetAgree }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SetAgree', '',
                                 '[ReturnName="SetAgreeResult"]');
  { ServiceSoap.SearchHistory }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SearchHistory', '',
                                 '[ReturnName="SearchHistoryResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchHistory', 'SearchHistoryResult', '',
                                '[ArrayItemName="SearchHistory"]');
  { ServiceSoap.FindSameNumbers }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'FindSameNumbers', '',
                                 '[ReturnName="FindSameNumbersResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'FindSameNumbers', 'FindSameNumbersResult', '',
                                '[ArrayItemName="SearchHistory"]');
  { ServiceSoap.GetDestinations }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetDestinations', '',
                                 '[ReturnName="GetDestinationsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetDestinations', 'GetDestinationsResult', '',
                                '[ArrayItemName="Destinations"]');
  { ServiceSoap.GetCustDestinations }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetCustDestinations', '',
                                 '[ReturnName="GetCustDestinationsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetCustDestinations', 'GetCustDestinationsResult', '',
                                '[ArrayItemName="Destinations"]');
  { ServiceSoap.GetBoxDetails }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetBoxDetails', '',
                                 '[ReturnName="GetBoxDetailsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetBoxDetails', 'GetBoxDetailsResult', '',
                                '[ArrayItemName="boxdetails"]');
  { ServiceSoap.GetDetailHistory }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetDetailHistory', '',
                                 '[ReturnName="GetDetailHistoryResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetDetailHistory', 'Type_', 'Type', '');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetDetailHistory', 'GetDetailHistoryResult', '',
                                '[ArrayItemName="History"]');
  { ServiceSoap.GetDetailHistory_v2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetDetailHistory_v2', '',
                                 '[ReturnName="GetDetailHistory_v2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetDetailHistory_v2', 'Type_', 'Type', '');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'GetDetailHistory_v2', 'GetDetailHistory_v2Result', '',
                                '[ArrayItemName="History_v2"]');
  { ServiceSoap.SearchInHistory_Log }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SearchInHistory_Log', '',
                                 '[ReturnName="SearchInHistory_LogResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchInHistory_Log', 'Type_', 'Type', '');
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceSoap), 'SearchInHistory_Log', 'SearchInHistory_LogResult', '',
                                '[ArrayItemName="Movement"]');
  { ServiceHttpGet }
  InvRegistry.RegisterInterface(TypeInfo(ServiceHttpGet), 'http://emexonline.com:3000/MaximaWS/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServiceHttpGet), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServiceHttpGet), ioSOAP12);
  { ServiceHttpGet.FindSameNumbers }
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceHttpGet), 'FindSameNumbers', 'Body', '',
                                '[ArrayItemName="SearchHistory"]');
  { ServiceHttpGet.GetDestinations }
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceHttpGet), 'GetDestinations', 'Body', '',
                                '[ArrayItemName="Destinations"]');
  { ServiceHttpPost }
  InvRegistry.RegisterInterface(TypeInfo(ServiceHttpPost), 'http://emexonline.com:3000/MaximaWS/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServiceHttpPost), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServiceHttpPost), ioSOAP12);
  { ServiceHttpPost.FindSameNumbers }
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceHttpPost), 'FindSameNumbers', 'Body', '',
                                '[ArrayItemName="SearchHistory"]');
  { ServiceHttpPost.GetDestinations }
  InvRegistry.RegisterParamInfo(TypeInfo(ServiceHttpPost), 'GetDestinations', 'Body', '',
                                '[ArrayItemName="Destinations"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBasketChangeResult), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBasketChangeResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBasketDetails), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBasketDetails');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPartstobasket), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfPartstobasket');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfIPlist), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfIPlist');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfListOfOrders), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfListOfOrders');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBasketDetails_v2), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBasketDetails_v2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQuotationList_v2), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfQuotationList_v2');
  RemClassRegistry.RegisterXSClass(IPlist, 'http://emexonline.com:3000/MaximaWS/', 'IPlist');
  RemClassRegistry.RegisterXSClass(BasketChangeResult, 'http://emexonline.com:3000/MaximaWS/', 'BasketChangeResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfFindByNumber), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfFindByNumber');
  RemClassRegistry.RegisterXSClass(Customer, 'http://emexonline.com:3000/MaximaWS/', 'Customer');
  RemClassRegistry.RegisterXSInfo(TypeInfo(string_), 'http://emexonline.com:3000/MaximaWS/', 'string_', 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQuotationList), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfQuotationList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQuotation), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfQuotation');
  RemClassRegistry.RegisterXSClass(QuotationList, 'http://emexonline.com:3000/MaximaWS/', 'QuotationList');
  RemClassRegistry.RegisterXSClass(QuotationList_v2, 'http://emexonline.com:3000/MaximaWS/', 'QuotationList_v2');
  RemClassRegistry.RegisterXSClass(Quotation, 'http://emexonline.com:3000/MaximaWS/', 'Quotation');
  RemClassRegistry.RegisterXSClass(FindByNumber, 'http://emexonline.com:3000/MaximaWS/', 'FindByNumber');
  RemClassRegistry.RegisterXSClass(BasketDetails, 'http://emexonline.com:3000/MaximaWS/', 'BasketDetails');
  RemClassRegistry.RegisterXSClass(BasketDetails_v2, 'http://emexonline.com:3000/MaximaWS/', 'BasketDetails_v2');
  RemClassRegistry.RegisterXSClass(partstobasket, 'http://emexonline.com:3000/MaximaWS/', 'partstobasket');
  RemClassRegistry.RegisterXSClass(ListOfOrders, 'http://emexonline.com:3000/MaximaWS/', 'ListOfOrders');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSearchHistory2), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfSearchHistory2', 'ArrayOfSearchHistory');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSearchHistory), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfSearchHistory');
  RemClassRegistry.RegisterXSClass(SearchHistory, 'http://emexonline.com:3000/MaximaWS/', 'SearchHistory');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfDestinations2), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfDestinations2', 'ArrayOfDestinations');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfDestinations), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfDestinations');
  RemClassRegistry.RegisterXSClass(Balance, 'http://emexonline.com:3000/MaximaWS/', 'Balance');
  RemClassRegistry.RegisterXSClass(InvDetails, 'http://emexonline.com:3000/MaximaWS/', 'InvDetails');
  RemClassRegistry.RegisterXSClass(BalanceForOrder, 'http://emexonline.com:3000/MaximaWS/', 'BalanceForOrder');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBalance), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBalance');
  RemClassRegistry.RegisterXSClass(History, 'http://emexonline.com:3000/MaximaWS/', 'History');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfHistory_v2), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfHistory_v2');
  RemClassRegistry.RegisterXSClass(History_v2, 'http://emexonline.com:3000/MaximaWS/', 'History_v2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfHistory), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfHistory');
  RemClassRegistry.RegisterXSClass(Destinations, 'http://emexonline.com:3000/MaximaWS/', 'Destinations');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBoxdetails), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBoxdetails');
  RemClassRegistry.RegisterXSClass(boxdetails, 'http://emexonline.com:3000/MaximaWS/', 'boxdetails');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfInvDetails), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfInvDetails');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBasketOrderResult), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBasketOrderResult');
  RemClassRegistry.RegisterXSClass(BasketOrderResult, 'http://emexonline.com:3000/MaximaWS/', 'BasketOrderResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfMovement), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfMovement');
  RemClassRegistry.RegisterXSClass(CreateOrderResult_v2, 'http://emexonline.com:3000/MaximaWS/', 'CreateOrderResult_v2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CreateOrderResult_v2), 'Message_', '[ExtName="Message"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CreateOrderResult_v2), 'BasketOrders', '[ArrayItemName="BasketOrderResult"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLogInfo), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfLogInfo');
  RemClassRegistry.RegisterXSClass(LogInfo, 'http://emexonline.com:3000/MaximaWS/', 'LogInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLong), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfLong');
  RemClassRegistry.RegisterXSClass(Boxes, 'http://emexonline.com:3000/MaximaWS/', 'Boxes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfInvoicelist), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfInvoicelist');
  RemClassRegistry.RegisterXSClass(Invoicelist, 'http://emexonline.com:3000/MaximaWS/', 'Invoicelist');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBoxes), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfBoxes');
  RemClassRegistry.RegisterXSClass(Movement, 'http://emexonline.com:3000/MaximaWS/', 'Movement');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSubCustomers), 'http://emexonline.com:3000/MaximaWS/', 'ArrayOfSubCustomers');
  RemClassRegistry.RegisterXSClass(SubCustomers, 'http://emexonline.com:3000/MaximaWS/', 'SubCustomers');

end.