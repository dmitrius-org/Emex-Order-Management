unit uGrantClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, uniGUIBaseClasses, uniBasicGrid, uniDBGrid, uniToolBar,
  uniImageList;

type
  TGrantClientT = class(TUniFrame)
    GridUsers: TUniDBGrid;
    Query: TFDQuery;
    DataSource: TDataSource;
    PopupMenu: TUniPopupMenu;
    N1: TUniMenuItem;
    N2: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    ActionList: TUniActionList;
    actEdit: TAction;
    acInsert: TAction;
    acDelete: TAction;
    actRefreshAll: TAction;
    UniToolBar1: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    ImageList16: TUniImageList;
    procedure actRefreshAllExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure acInsertExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
  private
    FID: Integer;
    FObjectType: Integer;
    { Private declarations }
    procedure DataRefresh();
    function GetID: Integer;
    procedure SetID(const Value: Integer);


  public
    { Public declarations }

    property ID: Integer read GetID write SetID;  // ид пользователя/группы
    property ObjectType: Integer read FObjectType write FObjectType;  // тип: пользователь/шруппа
  end;

implementation

uses
  uLogger, MainModule, uLookupF, uMainVar, uToast;

{$R *.dfm}

{ TInstrumentActionT }

procedure TGrantClientT.acDeleteExecute(Sender: TObject);
var sqltext: string;
begin
  if 1=1 then
  begin
     sqltext :=
     ' declare @R int = 0                '+
     '                                   '+
     ' DELETE pGrantObject               '+
     '   FROM pGrantObject (rowlock)     '+
     '  WHERE Spid      = @@spid         '+
     '    and ObjectType= :ObjectType    '+
     '    and ObjectID  = :ObjectID      '+
     '    and LinkType  = 7 /*Клиенты*/  '+
     '    and LinkID    = :ClientID      '+
     ' exit_:                            '+
     '                                   '+
     ' select @r as retcode '+
     '';

    UniMainModule.Query.Close;
    UniMainModule.Query.SQL.Text := sqltext;

    Sql.Open(UniMainModule.Query,
             ['ObjectType','ObjectID', 'ClientID'],
             [Query.FieldByName('ObjectType').Value ,
              Query.FieldByName('ObjectID').Value ,
              Query.FieldByName('ClientID').Value ]);

    RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
  end
  else
    Exit;

  if RetVal.Code = 0 then
  begin
    DataRefresh;
   // ToastOK('Успешно добавлен!', UniSession);
  end
  else
  begin
    MessageDlg(RetVal.Message, mtError, [mbOK]);
  end;
end;

procedure TGrantClientT.acInsertExecute(Sender: TObject);
var f: TLookupF;
    sqltext: string;
    I: Integer;
begin
  f := TLookupF.Create(UniApplication);
  try
    f.Caption := 'Клиенты';
    f.FromName := 'TClientsT';

    if f.ShowModal = mrOk then
    begin
       sqltext :=
       ' declare @R int = 0                                              '+
       '                                                                 '+
       ' if exists (   select 1                                          '+
       '                 FROM pGrantObject (nolock)                      '+
       '                where Spid= @@spid                               '+
       '                  and ObjectType=:ObjectType                     '+
       '                  and ObjectID = :ObjectID                       '+
       '                  and LinkID   = :ClientID                       '+
       '                  and LinkType = 7 /*Клиенты*/                   '+
       '           )                                                     '+
       ' begin                                                           '+
       '   set @R = 10 /* Клиент существует */                           '+
       '   goto exit_                                                    '+
       ' end                                                             '+
       '                                                                 '+
       ' INSERT INTO pGrantObject                                        '+
       '       (  Spid,  ObjectType,  ObjectID,  LinkID,   LinkType )    '+
       ' Select @@spid, :ObjectType, :ObjectID, :ClientID, 7 /*Клиенты*/ '+
       '                                                                 '+
       ' exit_:                                                          '+
       '                                                                 '+
       ' select @r as retcode '+
       '';

      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      for I := 0 to f.ID.Count - 1 do
      begin
        Sql.Open(UniMainModule.Query,
                 ['ObjectType','ObjectID', 'ClientID'],
                 [FObjectType, FID, f.ID.Strings[I].ToInteger]);


        //RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
      end;
    end
    else
      Exit;

    if RetVal.Code = 0 then
    begin
      DataRefresh;
     // ToastOK('Успешно добавлен!', UniSession);
    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;

  finally
    f.Free
  end;
end;

procedure TGrantClientT.actEditExecute(Sender: TObject);
var f: TLookupF;
    sqltext: string;
    I: Integer;
begin
  f := TLookupF.Create(UniApplication);
  try
    f.Caption := 'Клиенты';
    f.FromName := 'TClientsT';

    if f.ShowModal = mrOk then
    begin
       sqltext :=
       ' declare @R int = 0                                '+
       '                                                   '+
       ' if exists (   select 1                            '+
       '                 FROM pGrantObject (nolock)        '+
       '                where Spid      = @@spid           '+
       '                  and ObjectType= :ObjectType      '+
       '                  and ObjectID  = :ObjectID        '+
       '                  and LinkID    = :ClientID        '+
       '                  and LinkType  = 7 /*Клиенты*/    '+
       '           )                                       '+
       ' begin                                             '+
       '   set @R = 10 /* Клиент существует */             '+
       '   goto exit_                                      '+
       ' end                                               '+
       '                                                   '+
       ' Update pGrantObject                               '+
       '    set LinkID    = :ClientID                      '+
       '  where Spid      = @@spid                         '+
       '    and ObjectType= :ObjectType                    '+
       '    and ObjectID  = :ObjectID                      '+
       '    and LinkID    = :ClientID                      '+
       '    and LinkType  = 7 /*Клиенты*/                  '+
       '                                                   '+
       ' exit_:                                            '+
       '                                                   '+
       ' select @r as retcode '+
       '';

      UniMainModule.Query.Close;
      UniMainModule.Query.SQL.Text := sqltext;

      for I := 0 to f.ID.Count - 1 do
      begin
        Sql.Open(UniMainModule.Query,
                 ['ObjectType','ObjectID', 'ClientID'],
                 [FObjectType, FID, f.ID.Strings[I].ToInteger]);


        //RetVal.Code := UniMainModule.Query.FieldByName('retcode').Value;
      end;
    end
    else
      Exit;

    if RetVal.Code = 0 then
    begin
      DataRefresh;
      //ToastOK('Успешно добавлен!', UniSession);
    end
    else
    begin
      MessageDlg(RetVal.Message, mtError, [mbOK]);
    end;

  finally
    f.Free
  end;
end;

procedure TGrantClientT.actRefreshAllExecute(Sender: TObject);
begin
  DataRefresh;
end;

procedure TGrantClientT.DataRefresh;
begin
  Query.Close();
  Query.Open();

  actEdit.Enabled := Query.RecordCount>0;
  acDelete.Enabled:= Query.RecordCount>0;
end;

function TGrantClientT.GetID: Integer;
begin
  result:=FID;
end;

procedure TGrantClientT.SetID(const Value: Integer);
begin
  FID := Value;

  DataRefresh;
end;

initialization
  RegisterClass(TGrantClientT);
end.
