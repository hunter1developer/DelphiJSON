unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnLoadSaveJsonDriver: TButton;
    btnLoadSaveJsonAuto: TButton;
    btnLoadSaveJsonTrip: TButton;
    procedure btnLoadSaveJsonDriverClick(Sender: TObject);
    procedure btnLoadSaveJsonAutoClick(Sender: TObject);
    procedure btnLoadSaveJsonTripClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uMainClasses;

procedure TMainForm.btnLoadSaveJsonAutoClick(Sender: TObject);
var
  list: TAutoList;
  openDialog: TOpenDialog;
begin
  try
    openDialog := TOpenDialog.Create(nil);
    openDialog.Filter := 'JSON files (auto.json)|auto.json';
    if openDialog.Execute then begin
      list := TAutoList.Create(openDialog.FileName);
      try
        list.loadFromJson;
        list.saveToJson;
      finally
        FreeAndNil(list);
        FreeAndNIl(openDialog);
      end;
    end;
  except

  end;

end;

procedure TMainForm.btnLoadSaveJsonDriverClick(Sender: TObject);
var
  list: TDriverList;
  openDialog: TOpenDialog;
begin
  try
    openDialog := TOpenDialog.Create(nil);
    openDialog.Filter := 'JSON files (driver.json)|driver.json';
    if openDialog.Execute then begin
      list := TDriverList.Create(openDialog.FileName);
      try
        list.loadFromJson;
        list.saveToJson;
      finally
        FreeAndNil(list);
        FreeAndNIl(openDialog);
      end;
    end;
  except

  end;
end;

procedure TMainForm.btnLoadSaveJsonTripClick(Sender: TObject);
var
  list: TTripList;
  openDialog: TOpenDialog;
begin
  try
    openDialog := TOpenDialog.Create(nil);
    openDialog.Filter := 'JSON files (trip.json)|trip.json';
    if openDialog.Execute then begin
      list := TTripList.Create(openDialog.FileName);
      try
        list.loadFromJson;
        list.saveToJson;
      finally
        FreeAndNil(list);
        FreeAndNIl(openDialog);
      end;
    end;
  except

  end;
end;

end.
