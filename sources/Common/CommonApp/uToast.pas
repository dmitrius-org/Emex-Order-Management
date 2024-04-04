unit uToast;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Forms, uniGUIClasses, uniGUIFrame,
  uniGUITypes, uniGUIAbstractClasses, uniGUIApplication;

procedure ToastOK(AMessage: string; AUniSession: TUniGUISession);
procedure ToastERR(AMessage: string; AUniSession: TUniGUISession);

implementation

procedure ToastERR(AMessage: string; AUniSession: TUniGUISession);
var
  acol,
  apesan,
  genMsgID: string;
begin
  acol:='#E9967A';
  genMsgID := FormatDateTime('yyyymmddhhnnsszzz', Now());

  apesan := apesan+'<table style=margin-top:-18px ><td><i class=\"fa fa-info\" aria-hidden=\"true\">   </i>  &nbsp;&nbsp;&nbsp; </td>&nbsp;&nbsp;<td>'+ AMessage +
   '  &nbsp;&nbsp;&nbsp;  </td></table><span style=\"float:right;margin-top:-18px\"><i  onclick=\"window._msg'+ genMsgID +'.destroy(); window._msg'+genMsgID+'=null; \"   class=\"fa fa-times\" aria-hidden=\"true\"></i></span>';

  AUniSession.AddJS('window._msg'+ genMsgID +' = Ext.toast ({html: "<font color=white style=font-size:15px;font-family:segoe ui;>' + apesan +
   '</font>", align: "tr" , header: false, autoCloseDelay: 3000, hideDuration: 2000, modal: false, bodyStyle:{"background-color":"'+acol+
   ' !important;box-shadow:'+acol+' !important; border-color: 0px solid transparent;padding:0px 0px 0px 0px !important;top:180px !important"}'
   +',listeners: {show: function(){this.paddingY = Ext.getBody().getHeight() - this.getHeight()*2}}'
   +'});'
   );
end;

procedure ToastOK(AMessage: string; AUniSession: TUniGUISession);
var
  acol,
  apesan,
  genMsgID: string;
begin
  acol:='#8CCB5E';
  genMsgID := FormatDateTime('yyyymmddhhnnsszzz', Now());

  apesan := apesan+'<table style=margin-top:-18px ><td><i class=\"fa fa-info\" aria-hidden=\"true\">   </i>  &nbsp;&nbsp;&nbsp; </td>&nbsp;&nbsp;<td>'+ AMessage +
   '  &nbsp;&nbsp;&nbsp;  </td></table><span style=\"float:right;margin-top:-18px\"><i  onclick=\"window._msg'+ genMsgID +'.destroy(); window._msg'+genMsgID+'=null; \"   class=\"fa fa-times\" aria-hidden=\"true\"></i></span>';

  AUniSession.AddJS('window._msg'+ genMsgID +' = Ext.toast ({html: "<font color=white style=font-size:15px;font-family:segoe ui;>' + apesan +
   '</font>", align: "tr" , header: false, autoCloseDelay: 3000, hideDuration: 2000, modal: false, bodyStyle:{"background-color":"'+acol+
   ' !important;box-shadow:'+acol+' !important; border-color: 0px solid transparent;padding:0px 0px 0px 0px !important;top:180px !important"}'
   +',listeners: {show: function(){this.paddingY = Ext.getBody().getHeight() - this.getHeight()*2}}'
   +'});'
   );
end;

end.
