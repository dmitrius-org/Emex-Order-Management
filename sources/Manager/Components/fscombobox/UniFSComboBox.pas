{*******************************************************************************
                                 Falcon Sistemas

                          www.falconsistemas.com.br
                         suporte@falconsistemas.com.br
                 Adapted by Marlon Nardi - ALL RIGHTS RESERVED.

*******************************************************************************}

{$IF CompilerVersion >= 24.0} // XE3 ou superior
  {$LEGACYIFEND ON}
{$IFEND}

unit UniFSCombobox;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  uniGuiTypes,
  uniComboBox;

const
  FSAbout = 'store.falconsistemas.com.br';
  PackageVersion = '1.1.2.27';

type
  {$IF CompilerVersion >= 23.0}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IF CompilerVersion >= 34.0}or pidLinux64{$IFEND})]
  {$IFEND}
  TUniFSComboBox = class(TUniComboBox)
  private
    FValue: string;
    FList: TStrings;

    SonTus: Word;

    procedure SetValueControl(const Value: string);
    procedure SetValueList(const Value: TStrings);
    function GetValueControl: string;

    function GetVersion: string;
    function GetAbout: string;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoExit; override;
  public
    LastKey: Word;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearAll;
  published
    property Value: string read GetValueControl write SetValueControl;
    property ValueList: TStrings read FList write SetValueList;

    property About : string read GetAbout;
    property Version: string read GetVersion;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Falcon', [TUniFSComboBox]);
end;

{ TUniFSComboBox }

constructor TUniFSComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TStringList.Create;

  MatchFieldWidth := True;
  FValue := '-1';
  Self.AnyMatch := True;
  try
    ItemIndex := -1;
  except
  end;
end;

destructor TUniFSComboBox.Destroy;
begin
  FList.Free;
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

 function TUniFSComboBox.GetValueControl: string;
begin
  try
    if (ValueList.Count > 0) and (ItemIndex <> -1) then
      Result := ValueList.Strings[ItemIndex]
    else
      Result := '-1';
  except
    Result := '-1';
  end;
end;

function TUniFSComboBox.GetVersion: string;
begin
  Result := PackageVersion;
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

procedure TUniFSComboBox.DoExit;
begin
  if Text = '' then
  begin
    ItemIndex := -1;
    Value := '-1';
    Hint := Value;
  end;
  inherited;
end;

procedure TUniFSComboBox.SetValueList(const Value: TStrings);
begin
  FList.Assign(Value);
end;

procedure TUniFSComboBox.ClearAll;
begin
  Items.Clear;
  ValueList.Clear;
end;

end.
