unit uUtils.Controll;

interface

uses
  uniEdit, uUniExComboBox;

    /// <summary>
    ///  Disabled - ��������� ������� ������������� ��������
    ///</summary>
    procedure Disabled(AControl: TUniEdit); overload;
    /// <summary>
    ///  Disabled - ��������� ������� ������������� ��������
    ///</summary>
    procedure Disabled(AControl: TUniExComboBox); overload;

implementation

uses
  Vcl.Graphics;

procedure Disabled(AControl: TUniEdit);
begin
  AControl.ReadOnly := true;
  AControl.Color    := cl3DLight;
  AControl.ClearButton := False;
end;

procedure Disabled(AControl: TUniExComboBox);
begin
  AControl.ReadOnly := true;
  AControl.Color    := cl3DLight;
  AControl.ClearButton := False;
end;

end.
