{*******************************************************************************
                                 Falcon Sistemas

                          www.falconsistemas.com.br
                         suporte@falconsistemas.com.br
                 Adapted by Marlon Nardi - ALL RIGHTS RESERVED.

no dependepency css and js
*******************************************************************************}

unit UniFSCombobox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uniComboBox, Vcl.DBCtrls, Data.DB;

const
  FSAbout = 'www.falconsistemas.com.br';
  PackageVersion = '1.0.1.4';

type
  TUniFSComboBox = class(TUniComboBox)
  private
    FValue: string;
    FList: TStrings;
    SonTus: Word;
    FAllValueList: TStrings;
    FParentValue: string;
    FAllItemList: TStrings;
    FParentValueList: TStrings;

    {---------}
    FDataLink: TFieldDataLink;
    FAutoEdit: Boolean;

    procedure SetValueControl(const Value: string);
    procedure SetValueList(const Value: TStrings);
    function GetValueControl: string;
    procedure SetAllValueList(const Value: TStrings);
    procedure SetParentValue(const Value: string);
    procedure SetAllItemList(const Value: TStrings);
    procedure SetParentValueList(const Value: TStrings);
    function GetVersion: string;
    function GetAbout: string;

    {---------}
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure Modified;
    procedure InternalUpdateData(Value: Variant);

  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoExit; override;

    {---------}
    procedure DataChange(Sender: TObject); virtual;
    procedure ActiveChange(Sender: TObject); virtual;
    function GetItemText: string; virtual;
    function GetFieldValue: string; virtual;
    function AllowEdit: Boolean; virtual;
    procedure CheckReadOnly;

    procedure DoSetRemoteValue(AIndex:Integer; Value: string); override;

    function GetField: TField; virtual;
    function GetDataField: WideString; virtual;
    procedure SetDataField(Value: WideString); virtual;
    function GetDataSource: TDataSource; virtual;
    procedure SetDataSource(Value: TDataSource); virtual;

    property DataLink:TFieldDataLink read FDataLink;

    function VCLControlClassName: string; override;

    procedure WebCreate; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    property DataField: WideString read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Field: TField read GetField;
    property AutoEdit: Boolean read FAutoEdit write FAutoEdit default True;
  public
    LastKey: Word;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearAll;
    property AllValueList: TStrings read FAllValueList write SetAllValueList;
    property AllItemList: TStrings read FAllItemList write SetAllItemList;
    property ParentValueList: TStrings read FParentValueList write SetParentValueList;

    {---------}
    procedure UpdateText; override;
  published
    property Value: string read GetValueControl write SetValueControl;
    property ValueList: TStrings read FList write SetValueList;
    property ParentValue: string read FParentValue write SetParentValue;

    property About : string read GetAbout;
    property Version: string read GetVersion;
  end;

procedure Register;

implementation

uses
  uniGUITypes;

procedure Register;
begin
  RegisterComponents('uniGUI Falcon', [TUniFSComboBox]);
end;

{ TUniFSComboBox }

constructor TUniFSComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TStringList.Create;
  FAllValueList := TStringList.Create;
  FAllItemList := TStringList.Create;
  FParentValueList := TStringList.Create;
  FValue := '';
  Self.AnyMatch := True;
  try
    ItemIndex := -1;
  except
  end;

  {--------}
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  ParentColor := False;
  FAutoEdit:=True;
  ControlOptions := ControlOptions + [uoNameAsText];
end;

procedure TUniFSComboBox.DataChange(Sender: TObject);
begin

end;

destructor TUniFSComboBox.Destroy;
begin
  FList.Free;
  FAllValueList.Free;
  FAllItemList.Free;
  FParentValueList.Free;

  {--------}
  FDataLink.Free;
  inherited Destroy;
end;

procedure TUniFSComboBox.SetValueControl(const Value: string);
begin
  FValue := Value;
  try
    ItemIndex := ValueList.IndexOf(Value);
  except
    ItemIndex := -1;
  end;
end;

function TUniFSComboBox.GetAbout: string;
begin
  Result := FSAbout;
end;

function TUniFSComboBox.GetDataField: WideString;
begin

end;

function TUniFSComboBox.GetDataSource: TDataSource;
begin

end;

function TUniFSComboBox.GetField: TField;
begin

end;

function TUniFSComboBox.GetFieldValue: string;
begin

end;

function TUniFSComboBox.GetItemText: string;
begin

end;

function TUniFSComboBox.GetValueControl: string;
begin
  try
    Result := ValueList.Strings[ItemIndex]
  except
    Result := '';
  end;
end;

function TUniFSComboBox.GetVersion: string;
begin
  Result := PackageVersion;
end;

procedure TUniFSComboBox.InternalUpdateData(Value: Variant);
begin

end;

procedure TUniFSComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SonTus := Key;
  if ((SonTus = 8) or (SonTus = VK_DELETE)) then
  begin
    SonTus := 0;
    ItemIndex := -1;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TUniFSComboBox.Modified;
begin

end;

procedure TUniFSComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

procedure TUniFSComboBox.DoExit;
begin
  if Text = '' then
  begin
    ItemIndex := -1;
    Value := '';
    Hint := Value;
  end;
  inherited;
end;

procedure TUniFSComboBox.DoSetRemoteValue(AIndex: Integer; Value: string);
begin
  inherited;

end;

procedure TUniFSComboBox.EditingChange(Sender: TObject);
begin

end;

procedure TUniFSComboBox.SetValueList(const Value: TStrings);
begin
  FList.Assign(Value);
end;

procedure TUniFSComboBox.UpdateData(Sender: TObject);
begin

end;

procedure TUniFSComboBox.UpdateText;
begin
  inherited;

end;

function TUniFSComboBox.VCLControlClassName: string;
begin

end;

procedure TUniFSComboBox.WebCreate;
begin
  inherited;
  KeepState:=True;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;

  DBEditField:=True;
  JSAddEvent('select', [], H_ExtOnSelect);
  JSConfig('trackBlurChange', [True]);
end;

procedure TUniFSComboBox.SetAllValueList(const Value: TStrings);
begin
  FAllValueList.Assign(Value);
end;

procedure TUniFSComboBox.SetDataField(Value: WideString);
begin

end;

procedure TUniFSComboBox.SetDataSource(Value: TDataSource);
begin

end;

procedure TUniFSComboBox.SetAllItemList(const Value: TStrings);
begin
  FAllItemList.Assign(Value);
end;

procedure TUniFSComboBox.SetParentValueList(const Value: TStrings);
begin
  FParentValueList.Assign(Value);
end;

procedure TUniFSComboBox.SetParentValue(const Value: string);
var
  I: Integer;
begin
  FParentValue := Value;
  if (AllValueList.Count > 0) then
  begin
    Items.Clear;
    ValueList.Clear;
    if ParentValueList.Count > 0 then
    begin
      for I := 0 to AllValueList.Count - 1 do
      begin
        if (ParentValueList.Strings[I] = FParentValue) or (FParentValue = '') then
        begin
          ValueList.Add(AllValueList.Strings[I]);
          Items.Add(AllItemList.Strings[I]);
        end;
      end;
    end
    else
    begin
      for I := 0 to AllValueList.Count - 1 do
      begin
        ValueList.Add(AllValueList.Strings[I]);
        Items.Add(AllItemList.Strings[I]);
      end;
    end;
  end;
end;

procedure TUniFSComboBox.ActiveChange(Sender: TObject);
begin

end;

function TUniFSComboBox.AllowEdit: Boolean;
begin

end;

procedure TUniFSComboBox.CheckReadOnly;
begin

end;

procedure TUniFSComboBox.ClearAll;
begin
  Items.Clear;
  ValueList.Clear;
  ParentValueList.Clear;
  AllValueList.Clear;
  AllItemList.Clear;
end;

end.

