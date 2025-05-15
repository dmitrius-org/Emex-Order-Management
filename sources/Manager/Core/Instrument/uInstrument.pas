unit uInstrument;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FireDAC.Stan.Param,
  uniGUIClasses, uniGUIFrame, uniTreeView, uniGUIBaseClasses, uniPanel,
  Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList, uniImageList;

type
  /// <summary>
  /// TInstrumentData - объект дл€ хранени€ дополнительных данных по Instrument в
  ///  дереве меню
  /// </summary>
  /// <seealso>TInstrumentData</seealso>
  PInstrumentData = ^TInstrumentData;
  TInstrumentData= record
    /// <summary> InstrumentID - »ƒ инструмента </summary>
    ID    : Integer;
    /// <summary> InstrumentType - “ип инструмента </summary>
    IType  : Integer;
    /// <summary> Form - наименование класса формы </summary>
    Form            : string;
    /// <summary> PID - »д родительского элемента. дл€ tModel это TInsrument.InstrumentID </summary>
    PID : Integer;
    SID : Integer;
    Flag: Integer;
  //  ModelID: Integer;
   end;

  TInstrumentT = class(TUniFrame)
    UniPanelTop: TUniPanel;
    UniPanelleft: TUniPanel;
    UniPanelCenter: TUniPanel;
    twInstrument: TUniTreeView;
    UniPanel2: TUniPanel;
    UniActionList: TUniActionList;
    PMInstrument: TUniPopupMenu;
    ActInstrumentAdd: TAction;
    N1: TUniMenuItem;
    ActInstrumentEdit: TAction;
    N2: TUniMenuItem;
    ActInstrumentDelete: TAction;
    N3: TUniMenuItem;
    ActInstrumentShow: TAction;
    InstrumentImage: TUniNativeImageList;
    procedure twInstrumentCellContextClick(ANode: TUniTreeNode; X, Y: Integer);
    procedure ActInstrumentAddExecute(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure ActInstrumentEditExecute(Sender: TObject);
    procedure ActInstrumentDeleteExecute(Sender: TObject);
    procedure PMInstrumentPopup(Sender: TObject);
    procedure twInstrumentClick(Sender: TObject);
    procedure ActInstrumentShowExecute(Sender: TObject);
    procedure twInstrumentDblClick(Sender: TObject);
  private
    FtargetForm : TUniFrame;
    FtargetName : String;

    FSettings: Pointer;
    FState: Pointer;
    FAction: Pointer;

//    function FindNodeByID(AID: Integer): TUniTreeNode;

    function FindNodeByType(AID: Integer; AType: Integer): TUniTreeNode;

    /// <summary>
    ///  UserFCallBack - CallBack обработчик действи€ на форме редактировани€ данных
    ///</summary>
    procedure UserFCallBack(Sender: TComponent; AResult:Integer);
    /// <summary>
    ///  SetNodeIco - ”становка иконки дл€ ветки в зависимости от типа
    ///</summary>
    procedure SetNodeIco( Nd : TUniTreeNode);
    /// <summary>
    ///  SetNodeEditFormName - ”становка формы редактировани€ дл€ ветки в зависимости от типа ветки
    ///</summary>
    function SetNodeEditFormName( InstrumentType : integer): string;
  public
    /// <summary>
    ///  twCreate - создание дерева меню
    ///</summary>
    procedure twCreate;
  end;

implementation

uses
  uInstrumentF, uCommonType, uSqlUtils, MainModule, uMainVar;

var
   InstData: PInstrumentData;

{$R *.dfm}

procedure TInstrumentT.ActInstrumentAddExecute(Sender: TObject);
begin
  InstData := twInstrument.Selected.Data;

//  if (InstData.InstrumentType = Integer(tInstrumentType.Action)) then
//  begin
//     TSql.Open('Select 1 from tInstrument where PID = :PID and InstrumentTypeID = :InstrumentTypeID',
//              ['PID', 'InstrumentTypeID'], [InstData.InstrumentID, tInstrumentType.State]);
//
//     if TSql.Q.RecordCount > 0 then
//     begin
//       MessageDlg('” действи€ уже настроен переход в состо€ние!', mtError, [mbOK]);
//       exit
//     end;
//  end;

  UnstrumentF.FormAction := acinsert;
  UnstrumentF.PID   := InstData.ID;
  UnstrumentF.PType := InstData.IType;
  UnstrumentF.PID   := InstData.ID;

  if InstData.IType = Integer(tInstrumentType.State) then
  begin
    UnstrumentF.PID   := InstData.PID;
    UnstrumentF.SID   := InstData.SID;
  end;

  UnstrumentF.ShowModal(UserFCallBack);
end;

procedure TInstrumentT.ActInstrumentEditExecute(Sender: TObject);
begin
  UnstrumentF.FormAction := acUpdate;
  InstData := twInstrument.Selected.Data;

  UnstrumentF.ID    := InstData.ID;
  UnstrumentF.IType := InstData.IType;
  UnstrumentF.PID   := InstData.PID;
  if InstData.IType = Integer(tInstrumentType.Action) then
  begin
    UnstrumentF.SID   := InstData.SID;
  end;
  UnstrumentF.ShowModal(UserFCallBack);
end;

procedure TInstrumentT.ActInstrumentDeleteExecute(Sender: TObject);
begin
  UnstrumentF.FormAction := acDelete;
  InstData := twInstrument.Selected.Data;

  UnstrumentF.ID  := InstData.ID;
  UnstrumentF.IType := InstData.IType;
  UnstrumentF.PID   := InstData.PID;

  UnstrumentF.ShowModal(UserFCallBack);
end;

procedure TInstrumentT.ActInstrumentShowExecute(Sender: TObject);
begin
  UnstrumentF.FormAction := acShow;
  InstData := twInstrument.Selected.Data;

  UnstrumentF.ID := InstData.ID;
  UnstrumentF.IType := InstData.IType;
end;

//function TInstrumentT.FindNodeByID(AID: Integer): TUniTreeNode;
//var i:integer;
//begin
//  result := nil;
//  for i:=0 to twInstrument.Items.Count-1 do
//  begin
//    if twInstrument.Items[i].Tag = AID then
//    begin
//      result := twInstrument.Items.Item[i];
//      break;
//    end;
//  end;
//end;

function TInstrumentT.FindNodeByType(AID, AType: Integer): TUniTreeNode;
var i:integer;
begin
  result := nil;
  for i:=0 to twInstrument.Items.Count-1 do
  begin
    if twInstrument.Items[i].Tag = AID then
    begin
      if PInstrumentData(twInstrument.Items[i].Data).IType = AType then
      begin
        result := twInstrument.Items.Item[i];
        break;
      end;
    end;
  end;
end;

procedure TInstrumentT.PMInstrumentPopup(Sender: TObject);
begin
  ActInstrumentAdd.Enabled :=  PInstrumentData(twInstrument.Selected.Data).IType <> 7;
  ActInstrumentEdit.Enabled :=  PInstrumentData(twInstrument.Selected.Data).IType > 2;
  ActInstrumentDelete.Enabled :=  PInstrumentData(twInstrument.Selected.Data).IType > 2;
end;


function TInstrumentT.SetNodeEditFormName(InstrumentType: integer): string;
begin
  case InstrumentType of
    4: //SettingGroups
    begin
      result := 'TSettingsT';
    end;
    7: //Action
    begin
      result := 'TInstrumentActionT';
    end;
    6: //State
    begin
      result := 'TInstrumentStateT';
    end;
  else
   result := '';
  end;
end;

procedure TInstrumentT.SetNodeIco(Nd: TUniTreeNode);
begin
  case InstData.IType of
    1:
    begin
      Nd.ImageIndex := 0
    end;
    2:
    begin
      Nd.ImageIndex := 1
    end;
    3,4:
    begin
      Nd.ImageIndex := 2;
     // Nd.SelectedIndex :=3;
    end;
    5:    //StateModel
    begin
      Nd.ImageIndex := 3;
    end;
    6:   // State
    begin
      if  ((PInstrumentData(Nd.Data).Flag and Integer(tInstrumentFlag.isStartState)) > 0) then
        Nd.ImageIndex := 4
      else
        Nd.ImageIndex := 4;
    end;
    7:  //Action
    begin
      Nd.ImageIndex := 6;
    end
  else
    Nd.ImageIndex := -1;
  end;
end;

procedure TInstrumentT.twCreate;
var
  c: string;
  PID, I, ID: Integer;
  Nd : TUniTreeNode;
begin

  with Sql.Q do
  begin
    close;
    sql.Clear;
    sql.Add( '  select *'+
             '    from vInstrumentTree   '+
             '   order by ITypeID, ID, PID ');

    open;
    if RecordCount = 0 then
    begin
      exit
    end;
  end;

  try
    Sql.Q.First;
    for I := 0 to Sql.Q.RecordCount -1  do
    begin
      ID  := Sql.Q.FieldByName('ID').AsInteger;
      PID := Sql.Q.FieldByName('PID').AsInteger;
      c   := Sql.Q.FieldByName('Caption').Value;

      New(InstData);
      InstData.ID   := ID;
      InstData.IType:= Sql.Q.FieldByName('ITypeID').AsInteger;
      InstData.PID  := Sql.Q.FieldByName('PID').AsInteger;
      InstData.Form := SetNodeEditFormName(InstData.IType);
      InstData.SID  := Sql.Q.FieldByName('StateID').AsInteger;
      InstData.Flag := Sql.Q.FieldByName('Flag').AsInteger;

      begin
        Nd := FindNodeByType(PID, Sql.Q.FieldByName('PType').AsInteger); //FindNodeByID(PID);
        if Nd = nil then
        begin
          Nd := twInstrument.Items.Add(nil, c);
        end
        else
        begin
          Nd := twInstrument.Items.Add(Nd, c);
        end;

        Nd.Data :=InstData;

        Nd.Tag := ID;
        SetNodeIco(Nd);
      end;
      Sql.Q.Next;
    end;

    twInstrument.Items[0].Selected := True;
  finally
  end;
end;

procedure TInstrumentT.twInstrumentCellContextClick(ANode: TUniTreeNode; X,
  Y: Integer);
begin
    PMInstrument.Popup(x, y, twInstrument);
end;

procedure TInstrumentT.twInstrumentClick(Sender: TObject);
var
  Nd : TUniTreeNode;
  FrC: TUniFrameClass;
  Fr : TUniFrame;
  FClassName: string;
begin
  Nd := twInstrument.Selected;

  if (Assigned(Nd.Data)) then
  begin
    FClassName := PInstrumentData(Nd.Data).Form;

    if FtargetName = FClassName then
    begin
       // если идентификатор изменилс€, то нужно обновить данные в форме
       if Assigned(FtargetForm) then
       if FtargetForm.Tag <> PInstrumentData(Nd.Data).ID then
       begin
         FtargetForm.Tag:=PInstrumentData(Nd.Data).ID;
         TMultiProp.Objects([FtargetForm])['ID']:=PInstrumentData(Nd.Data).ID;
       end;
       Exit;
    end;

    // скрываем старую форму
    if (Assigned(FtargetForm)) then
    begin
      FtargetForm.Parent := nil;
      FtargetForm := nil;
      FtargetName := '';
    end;

    if (FClassName <> '') then
    begin
      if FClassName = 'TSettingsT' then
      begin
        if (Assigned(FSettings)) then    FreeAndNil(FSettings);

        FrC := TUniFrameClass(FindClass(FClassName));
        FSettings := FrC.Create(UniPanelCenter);
        Fr := FSettings;
      end
      else if FClassName = 'TInstrumentStateT' then
      begin
        if (Assigned(FState)) then    FreeAndNil(FState);

        FrC := TUniFrameClass(FindClass(FClassName));
        FState := FrC.Create(UniPanelCenter);
        Fr := FState;
      end
      else if FClassName = 'TInstrumentActionT' then
      begin
        if (Assigned(FAction)) then    FreeAndNil(FAction);
        FrC := TUniFrameClass(FindClass(FClassName));
        FAction := FrC.Create(UniPanelCenter);
        Fr := FAction;
      end;

      FtargetName := FClassName;
      FtargetForm := Fr;
      Fr.Parent := UniPanelCenter;

      FtargetForm.Tag:=PInstrumentData(Nd.Data).ID;
      TMultiProp.Objects([FtargetForm])['ID']:=PInstrumentData(Nd.Data).ID;
    end;
  end
end;

procedure TInstrumentT.twInstrumentDblClick(Sender: TObject);
var Nd : TUniTreeNode;
  I: Integer;

  procedure DeleteChilds(Node: TUniTreeNode);
  var
   Child: TUniTreeNode;
  begin
   Child := Node.GetFirstChild;
   while Assigned(Child) do
   begin
     DeleteChilds(Child);
     Child := Node.GetNext();
   end;
  end;
begin
  InstData := twInstrument.Selected.Data;
  if InstData.IType in [Integer(tInstrumentType.State), Integer(tInstrumentType.Action)] then
  begin

    DeleteChilds(twInstrument.Selected);

    Sql.Q.Close;
    Sql.Q.SQL.Text := ' SELECT p.* '+
                       '   FROM [vInstrumentTree] t '+
                       '  inner join [vInstrumentTree] p '+
                       '          on p.ModelID = t.ModelID'+
                       '         and p.ITypeID <> t.ITypeID'+
                       '         and ( (p.StateID = t.StateID  and p.ITypeID = 7) or (p.StateID = t.TStateID and p.ITypeID = 6 ) )'+
                       '  WHERE t.ID = :PID and t.ITypeID in (6,7)'+
                       ' ';


    Sql.Q.ParamByName('PID').Value := twInstrument.Selected.Tag;
    Sql.Q.Open;
    Sql.Q.First;
    for I := 0 to Sql.Q.RecordCount - 1 do
    begin
      New(InstData);

      InstData.ID        := Sql.Q.FieldByName('ID').AsInteger;
      InstData.IType     := Sql.Q.FieldByName('ITypeID').AsInteger;
      InstData.PID       := Sql.Q.FieldByName('PID').AsInteger;
      InstData.Form      := SetNodeEditFormName(InstData.IType);
      InstData.SID       := Sql.Q.FieldByName('StateID').AsInteger;
      InstData.Flag      := Sql.Q.FieldByName('Flag').AsInteger;

      Nd := twInstrument.Items.Add(twInstrument.Selected, Sql.Q.FieldByName('Caption').AsString);

      Nd.Data :=InstData;
      Nd.Tag := InstData.ID;

      SetNodeIco(Nd);
      Sql.Q.Next;
    end;
  end;
end;

procedure TInstrumentT.UniFrameCreate(Sender: TObject);
begin
  twCreate;
end;

procedure TInstrumentT.UserFCallBack(Sender: TComponent; AResult: Integer);
var Nd : TUniTreeNode;
begin
  if AResult <> mrOK then Exit;

  if UnstrumentF.FormAction = acInsert then
  begin
    Sql.Q.Close;
    Sql.Q.SQL.Text := ' SELECT * '+
                       '   FROM [vInstrumentTree] '+
                       '  WHERE ID = :ID and ITypeID = :ITypeID'+
                       ' ';
    Sql.Q.ParamByName('ID').Value      := UnstrumentF.ID;
    Sql.Q.ParamByName('ITypeID').Value := UnstrumentF.IType;
    Sql.Q.Open;

    New(InstData);

    InstData.ID        := Sql.Q.FieldByName('ID').AsInteger;
    InstData.IType     := Sql.Q.FieldByName('ITypeID').AsInteger;
    InstData.PID       := Sql.Q.FieldByName('PID').AsInteger;
    InstData.Form      := SetNodeEditFormName(InstData.IType);
    InstData.SID       := Sql.Q.FieldByName('StateID').AsInteger;
    InstData.Flag      := Sql.Q.FieldByName('Flag').AsInteger;

    Nd := twInstrument.Items.Add(twInstrument.Selected, Sql.Q.FieldByName('Caption').AsString);

    Nd.Data :=InstData;
    Nd.Tag := InstData.ID;

    SetNodeIco(Nd);
  end
  else
  if UnstrumentF.FormAction = acUpdate then
  begin
    Sql.Q.Close;
    Sql.Q.SQL.Text := ' SELECT * '+
                       '   FROM [vInstrumentTree] '+
                       '  WHERE ID = :ID and ITypeID = :ITypeID'+
                       ' ';
    Sql.Q.ParamByName('ID').Value      := UnstrumentF.ID;
    Sql.Q.ParamByName('ITypeID').Value := UnstrumentF.IType;
    Sql.Q.Open;

    twInstrument.Selected.Text := Sql.Q.FieldByName('Caption').AsString;
  end
  else
  if UnstrumentF.FormAction = acDelete then
  begin
    twInstrument.Selected.Destroy;
  end;
end;

initialization
  RegisterClass(TInstrumentT);
end.
