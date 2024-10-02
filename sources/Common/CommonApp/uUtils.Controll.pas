unit uUtils.Controll;

interface

uses
  uniEdit, UniFSCombobox;

    /// <summary>
    ///  Disabled - установка свойств недоступности контрола
    ///</summary>
    procedure Disabled(AControl: TUniEdit); overload;
    /// <summary>
    ///  Disabled - установка свойств недоступности контрола
    ///</summary>
    procedure Disabled(AControl: TUniFSComboBox); overload;

implementation

uses
  Vcl.Graphics;

procedure Disabled(AControl: TUniEdit);
begin
  AControl.ReadOnly := true;
  AControl.Color    := cl3DLight;
  AControl.ClearButton := False;
end;

procedure Disabled(AControl: TUniFSComboBox);
begin
  AControl.ReadOnly := true;
  AControl.Color    := cl3DLight;
  AControl.ClearButton := False;
end;

end.
