unit uGrant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniDBVerticalGrid,
  uniDBVerticalTreeGrid, uniGUIBaseClasses, uniToolBar, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniDBTreeGrid, uniButton,
  uniBitBtn, uniPanel, System.Actions, Vcl.ActnList, uniMainMenu, uniPageControl,
  uniLabel, uniMultiItem, uniComboBox, uniGUIFrame;

type
  TGrantF = class(TUniForm)
    ToolBar: TUniToolBar;
    Query: TFDQuery;
    DataSource: TDataSource;
    GridGrant: TUniDBTreeGrid;
    UniPanel: TUniPanel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    FDUpdateSQL: TFDUpdateSQL;
    UniToolButton1: TUniToolButton;
    UniActionList: TUniActionList;
    actExpand: TAction;
    actCollapse: TAction;
    UniToolButton2: TUniToolButton;
    UniPageControl1: TUniPageControl;
    tsInterface: TUniTabSheet;
    tsObjects: TUniTabSheet;
    UniPanel1: TUniPanel;
    cbObjectType: TUniComboBox;
    UniLabel1: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure actExpandExecute(Sender: TObject);
    procedure actCollapseExecute(Sender: TObject);
    procedure cbObjectTypeSelect(Sender: TObject);
  private
    FID: Integer;
    FObjectType: Integer;

    FGrantObjectForm: Pointer;
    FTargetForm: string;

    { Private declarations }
    /// <summary>
    ///  SetGrantFormName - Установка формы редактирования
    ///</summary>
    function SetGrantFormName(): string;

  public
    { Public declarations }
    property ID: Integer read FID write FID;
    property ObjectType: Integer read FObjectType write FObjectType;
  end;

function GrantF: TGrantF;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uCommonType, uMainVar;

function GrantF: TGrantF;
begin
  Result := TGrantF(UniMainModule.GetFormInstance(TGrantF));
end;

procedure TGrantF.actExpandExecute(Sender: TObject);
begin
  GridGrant.FullExpand;
end;

procedure TGrantF.actCollapseExecute(Sender: TObject);
begin
  GridGrant.FullCollapse;
end;

procedure TGrantF.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TGrantF.btnOkClick(Sender: TObject);
begin
 // Query.ApplyUpdates();

  UniMainModule.Query.Close;
  UniMainModule.Query.SQL.Text := ' declare @R      int                 '+
                                  ' '+
                                  ' exec @r = GrantSave                 '+
                                  '            @ObjectID  = :ObjectID   '+
                                  '           ,@ObjectType= :ObjectType '+
                                  ' '+
                                  ' select @r as retcode ';

  UniMainModule.Query.ParamByName('ObjectID').Value := FID; // пользователь или групп
  UniMainModule.Query.ParamByName('ObjectType').Value := FObjectType;  // тип пользователя или группы

  UniMainModule.Query.Open;
  RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;

  if RetVal.Code = 0 then
  begin
    ModalResult:=mrOK;
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TGrantF.cbObjectTypeSelect(Sender: TObject);
var
  FrC: TUniFrameClass;
  Fr : TUniFrame;
  FClassName: string;
begin
  FClassName := SetGrantFormName();

  if (FClassName<>'') and (FClassName<>FTargetForm) then
  begin

    if Assigned(FGrantObjectForm) then FreeObjectInstance(FGrantObjectForm);

    FrC := TUniFrameClass(FindClass(FClassName));
    Fr := FrC.Create(tsObjects);
    Fr.Parent := tsObjects;

    TMultiProp.Objects([Fr])['ID']:= FID;
    TMultiProp.Objects([Fr])['ObjectType']:= FObjectType;

    FGrantObjectForm := Fr;
    FTargetForm := FClassName;
  end;
end;

function TGrantF.SetGrantFormName: string;
begin
  if cbObjectType.Text = 'Клиенты' then
  begin
    result := 'TGrantClientT';
  end;
end;

procedure TGrantF.UniFormShow(Sender: TObject);
begin
  UniPageControl1.ActivePage := tsInterface;

  Query.Close;
  Query.ParamByName('ObjectID').Value := FID;
  Query.ParamByName('ObjectType').Value := FObjectType;
  Query.Open();

  ComboBoxFill(cbObjectType,   ' select Brief as name From tObjectType (nolock) where flag&4=4 order by ObjectTypeID ');
end;

end.
