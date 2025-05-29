{$I ..\..\compile.inc}

unit uUtils.Localizer;

interface

uses
  System.JSON, System.SysUtils, System.Classes, System.Generics.Collections,
  Vcl.Controls, uniGUIForm, uniGUIBaseClasses, uniGUIClasses, uUniExComboBox,
  System.Variants;

type
  TLocalizer = class
  private
    class var FInstance: TLocalizer;
    var FLocaleData: TJSONObject;
    var FLanguageCode: string;
    constructor Create;
    procedure FreeLocaleData;
    procedure SetLanguageCode(const Value: string);
    procedure LoadLanguage(const LangCode: string);
    procedure ApplyAllForms;
  public
    class function Instance: TLocalizer;
    /// <summary>
    ///  ApplyLocalization - Применяет локализацию ко всем элементам формы
    /// </summary>
    procedure ApplyLocalization(AForm: TUniForm);
    function Translate(const FormName, ElementName: string): string;
    procedure ExportFormLocalization(AForm: TUniForm);
    procedure FillLanguageList(ComboBox: TUniExComboBox);

    property LanguageCode: string read FLanguageCode write SetLanguageCode;
  end;

  function L(const FormName, ElementName: string): string;

implementation

uses
  System.IOUtils, System.JSON.Readers, System.JSON.Utils, Rtti, TypInfo,
  ServerModule, uniPanel, System.Types, Vcl.Forms, MainModule;

const
  LOCALE_FOLDER = 'locales';
  LOCALE_EXT = '.json';

{ TLocalizer }

function L(const FormName, ElementName: string): string;
begin
  Result := TLocalizer.Instance.Translate(FormName, ElementName);
end;

constructor TLocalizer.Create;
begin
  inherited Create;
  FLocaleData := nil;
  FLanguageCode := '';
end;

procedure TLocalizer.FreeLocaleData;
begin
  if Assigned(FLocaleData) then
  begin
    FLocaleData.Free;
    FLocaleData := nil;
  end;
end;

class function TLocalizer.Instance: TLocalizer;
begin
  if not Assigned(FInstance) then
    FInstance := TLocalizer.Create;
  Result := FInstance;
end;

procedure TLocalizer.SetLanguageCode(const Value: string);
begin
  if FLanguageCode <> Value then
  begin
    LoadLanguage(Value);
    ApplyAllForms;
  end;
end;

procedure TLocalizer.LoadLanguage(const LangCode: string);
var
  FileName: string;
  JSONStr: string;
begin
  FreeLocaleData;

  FLanguageCode := LangCode;
  UniMainModule.ExtLocale := FLanguageCode;
//  UniMainModule.ARetVal.Language :=FLanguageCode;

  // не работает
//  UniMainModule.FDConnection.ExecSQL('''
//    EXEC sp_set_session_context N'language', :Language;
//  ''', [FLanguageCode]);

  FileName := TPath.Combine(UniServerModule.StartPath, UniServerModule.FilesFolder, LOCALE_FOLDER, LangCode + LOCALE_EXT);

  if not TFile.Exists(FileName) then
    Exit;

  JSONStr := TFile.ReadAllText(FileName, TEncoding.UTF8);
  FLocaleData := TJSONObject.ParseJSONValue(JSONStr) as TJSONObject;

  if not Assigned(FLocaleData) then
    raise Exception.Create('Ошибка разбора JSON локализации.');
end;

procedure TLocalizer.ApplyAllForms;
begin
end;

procedure TLocalizer.ApplyLocalization(AForm: TUniForm);
var
  i: Integer;
  Comp: TComponent;
  FormName: string;
  Key: string;
  Value: string;
begin
  if not Assigned(FLocaleData) then Exit;

  FormName := AForm.Name;
  for i := 0 to AForm.ComponentCount - 1 do
  begin
    Comp := AForm.Components[i];

    // Исключаем TUniPanel и TUniContainerPanel
    if (Comp is TUniPanel) or (Comp is TUniContainerPanel) then
      Continue;

    if IsPublishedProp(Comp, 'Caption') then
    begin
      Key := Comp.Name + '.Caption';
      Value := Translate(FormName, Key);
      if not Value.StartsWith('[') then  // это значит, перевод найден
        SetPropValue(Comp, 'Caption', Value);
    end;

    if IsPublishedProp(Comp, 'Hint') then
    begin
      Key := Comp.Name + '.Hint';
      Value := Translate(FormName, Key);
      if not Value.StartsWith('[') then  // это значит, перевод найден
        SetPropValue(Comp, 'Hint', Value);
    end;

    if IsPublishedProp(Comp, 'EmptyText') then
    begin
      Key := Comp.Name + '.EmptyText';
      Value := Translate(FormName, Key);
      if not Value.StartsWith('[') then
        SetPropValue(Comp, 'EmptyText', Value);
    end;

    if IsPublishedProp(Comp, 'FieldLabel') then
    begin
      Key := Comp.Name + '.FieldLabel';
      Value := Translate(FormName, Key);
      if not Value.StartsWith('[') then
        SetPropValue(Comp, 'FieldLabel', Value);
    end;
  end;
end;

function TLocalizer.Translate(const FormName, ElementName: string): string;
var
  FormObj: TJSONValue;
  ElementValue: TJSONValue;
begin
  Result := '';

  if not Assigned(FLocaleData) then
    Exit;

  FormObj := FLocaleData.GetValue(FormName);
  if Assigned(FormObj) and (FormObj is TJSONObject) then
  begin
    ElementValue := TJSONObject(FormObj).GetValue(ElementName);
    if Assigned(ElementValue) then
      Result := ElementValue.Value;
  end;

  if Result = '' then
    Result := Format('[%s.%s]', [FormName, ElementName]);
end;

procedure TLocalizer.ExportFormLocalization(AForm: TUniForm);
var
  i: Integer;
  Comp: TComponent;
  FormName, Value, FileName, JSONStr: string;
  FormJSON, JSONRoot, MsgObj, LanObj, ExistingFormJSON: TJSONObject;
  ExistingJSON: TJSONObject;
  CompKey: string;

  LangCode: string;
begin
  LangCode :='sample';
  {$IFNDEF LOCALISE_FILE_CREATE}
     Exit;
  {$ENDIF}
  FileName := TPath.Combine(UniServerModule.StartPath, UniServerModule.FilesFolder, LOCALE_FOLDER, LangCode + LOCALE_EXT);

  // Если файл существует — загружаем, иначе создаем новый объект
  if TFile.Exists(FileName) then
  begin
    JSONStr := TFile.ReadAllText(FileName, TEncoding.UTF8);
    ExistingJSON := TJSONObject.ParseJSONValue(JSONStr) as TJSONObject;
    if Assigned(ExistingJSON) then
      JSONRoot := ExistingJSON
    else
      JSONRoot := TJSONObject.Create;
  end
  else
    JSONRoot := TJSONObject.Create;

  try
    // language
    if not JSONRoot.TryGetValue<TJSONObject>('language', LanObj) then
    begin
      LanObj := TJSONObject.Create;
      LanObj.AddPair('Name', 'ru');
      LanObj.AddPair('Caption', 'Русский');
      LanObj.AddPair('Author', '');
      LanObj.AddPair('ImageIndex', -1);
      JSONRoot.AddPair('language', LanObj);
    end;

    // Messages
    if not JSONRoot.TryGetValue<TJSONObject>('Messages', MsgObj) then
    begin
      MsgObj := TJSONObject.Create;
      MsgObj.AddPair('ErrorInvalidLogin', 'Неверный логин или пароль');
      MsgObj.AddPair('WelcomeUser', 'Добро пожаловать, %s!');
      JSONRoot.AddPair('Messages', MsgObj);
    end;

    // Форма
    FormName := AForm.Name;
    if not JSONRoot.TryGetValue<TJSONObject>(FormName, ExistingFormJSON) then
    begin
      FormJSON := TJSONObject.Create;

      for i := 0 to AForm.ComponentCount - 1 do
      begin
        Comp := AForm.Components[i];
        if (Comp is TUniPanel) or (Comp is TUniContainerPanel) then
          Continue;

        if IsPublishedProp(Comp, 'Caption') then
        begin
          Value := VarToStr(GetPropValue(Comp, 'Caption', True));
          if Value <> '' then
          begin
            CompKey := Comp.Name + '.Caption';
            FormJSON.AddPair(CompKey, Value);
          end;
        end;

        if IsPublishedProp(Comp, 'Hint') then
        begin
          Value := VarToStr(GetPropValue(Comp, 'Hint', True));
          if Value <> '' then
          begin
            CompKey := Comp.Name + '.Hint';
            FormJSON.AddPair(CompKey, Value);
          end;
        end;


        if IsPublishedProp(Comp, 'EmptyText') then
        begin
          Value := VarToStr(GetPropValue(Comp, 'EmptyText', True));
          if Value <> '' then
          begin
            CompKey := Comp.Name + '.EmptyText';
            FormJSON.AddPair(CompKey, Value);
          end;
        end;

        if IsPublishedProp(Comp, 'FieldLabel') then
        begin
          Value := VarToStr(GetPropValue(Comp, 'FieldLabel', True));
          if Value <> '' then
          begin
            CompKey := Comp.Name + '.FieldLabel';
            FormJSON.AddPair(CompKey, Value);
          end;
        end;

      end;

      JSONRoot.AddPair(FormName, FormJSON);
    end;

    // Сохраняем в файл
    TFile.WriteAllText(FileName, JSONRoot.ToString, TEncoding.UTF8);

  finally
    JSONRoot.Free; // Освобождает и все вложенные JSON-объекты
  end;
end;


procedure TLocalizer.FillLanguageList(ComboBox: TUniExComboBox);
var
  Files: TStringDynArray;
  FileName, JSONStr, Code, Caption, Name: string;
  LangJSON, LangInfo: TJSONObject;
  i, ImageIndex: Integer;
  Path: string;
  SavedOnChange: TNotifyEvent;
begin
  // Сохраняем текущий обработчик
  SavedOnChange := ComboBox.OnChangeValue;
  ComboBox.OnChangeValue := nil; // Отключаем событие

  try
    ComboBox.Items.Clear;
    ComboBox.ValueList.Clear;
    Path := TPath.Combine(UniServerModule.StartPath, UniServerModule.FilesFolder, LOCALE_FOLDER);
    Files := TDirectory.GetFiles(Path, '*' + LOCALE_EXT);

    for i := 0 to High(Files) do
    begin
      FileName := Files[i];
      Code := TPath.GetFileNameWithoutExtension(FileName);
      JSONStr := TFile.ReadAllText(FileName, TEncoding.UTF8);
      LangJSON := TJSONObject.ParseJSONValue(JSONStr) as TJSONObject;

      if Assigned(LangJSON) then
      begin
        try
          LangInfo := LangJSON.GetValue('language') as TJSONObject;
          if Assigned(LangInfo) then
          begin
            Name := LangInfo.GetValue<string>('Name');
            Caption := LangInfo.GetValue<string>('Caption');

            ComboBox.BeginUpdate;

            if LangInfo.TryGetValue<Integer>('ImageIndex', ImageIndex) then
            begin
              // Добавляем с иконкой
              ComboBox.IconItems.Add();
              ComboBox.IconItems[ComboBox.IconItems.Count - 1].Caption := ' ' + Caption;
              ComboBox.IconItems[ComboBox.IconItems.Count - 1].ImageIndex := ImageIndex;
            end
            else
            begin
              // Без иконки
              ComboBox.Items.Add(Caption);
            end;
            ComboBox.ValueList.Add(Name);

            ComboBox.EndUpdate;
          end;
        finally
          LangJSON.Free;
        end;
      end;
    end;

  finally
    ComboBox.OnChangeValue := SavedOnChange; // Возвращаем обработчик обратно
  end;
end;


initialization

finalization
  if Assigned(TLocalizer.FInstance) then
    TLocalizer.FInstance.Free;

end.

