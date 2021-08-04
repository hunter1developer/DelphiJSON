unit uMainClasses;

interface
uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  System.Classes,
  System.Generics.Collections;


type
  TAuto = class(TObject)
  private
    FBrand: string;
    FColor: string;
    FID: Integer;
    FModel: string;
    FNumber: string;
  public
    property Brand: string read FBrand write FBrand;
    property Color: string read FColor write FColor;
    property ID: Integer read FID write FID;
    property Model: string read FModel write FModel;
    property Number: string read FNumber write FNumber;
  end;

  TDriver = class(TObject)
  private
    FID: Integer;
    FName: string;
    FPhone: string;
  public
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
    property Phone: string read FPhone write FPhone;
  end;

  TTrip = class
  private
    FAutoID: Integer;
    FDriverID: Integer;
    FStartTime: TDateTime;
  public
    property AutoID: Integer read FAutoID write FAutoID;
    property DriverID: Integer read FDriverID write FDriverID;
    property StartTime: TDateTime read FStartTime write FStartTime;
  end;

  TDriverList = class(TObjectList<TDriver>)
  private
    FFileName: string;
    FJSON: string;
  public
    constructor Create(const fileName: string);
    function CreateDriver(const ID: Integer; const Name: string; const Phone: string): TDriver;
    procedure loadFromJson();
    procedure saveToJson();
    property JSON: string read FJSON;
  end;

  TAutoList = class(TObjectList<TAuto>)
  private
    FFileName: string;
    FJSON: string;
  public
    constructor Create(const fileName: string);
    function CreateAuto(const ID: Integer; const Brand, Color, Model, Number: string): TAuto;
    procedure loadFromJson();
    procedure saveToJson();
    property JSON: string read FJSON;
  end;

  TTripList = class(TObjectList<TTrip>)
  private
    FFileName: string;
    FJSON: string;
  public
    constructor Create(const fileName: string);
    function CreateTrip(const AutoID, DriverID: Integer; const StartTime: TDateTime): TTrip;
    procedure loadFromJson();
    procedure saveToJson();
    property JSON: string read FJSON;
  end;

implementation

{ TDriverList }

constructor TDriverList.Create(const fileName: string);
begin
  inherited Create;
  Self.FFileName := fileName;
end;

function TDriverList.CreateDriver(const ID: Integer; const Name, Phone: string): TDriver;
var
  Driver: TDriver;
begin
  Driver        := TDriver.Create;
  Driver.ID     := ID;
  Driver.Name   := Name;
  Driver.Phone  := Phone;
  Result        := Driver;
end;

procedure TDriverList.loadFromJson();
const
  cFileName = 'The file %s is not exists!';
var
  data: TBytes;
  JSONValue, jv: TJSONValue;
  joName: TJSONObject;
  Name : String;
  Phone: String;
  ID: Integer;
begin
  try
    try
      ID := 1;
      if FileExists(Self.FFileName) then begin
        data := TEncoding.ASCII.GetBytes(TFile.ReadAllText(Self.FFileName));
        FJSON := TEncoding.ASCII.GetString(data);
        JSONValue := TJSONObject.ParseJSONValue(data, 0);
        for jv in JSONValue as TJSONArray do begin
          joName := jv as TJSONObject;
          Name := joName.Get('Name').JSONValue.Value;
          Phone := joName.Get('Phone').JSONValue.Value;
          Self.Add(Self.CreateDriver(ID, Name, Phone));
          Inc(ID);
        end;
      end else
        raise Exception.Create(Format(cFileName, [Self.FFileName]));
    finally
      FreeAndNil(JSONValue);
    end;
  except

  end;
end;

procedure TDriverList.saveToJson;
var
  JSON: TJSONObject;
  JSONArray: TJSONArray;
  JSONNestedObject: TJSONObject;
  i: integer;
  Driver: TDriver;
begin
  JSONArray := TJSONArray.Create;
  try
    for i := 0 to Self.Count - 1 do begin
      Driver := Self.Items[i];
      JSONArray.AddElement(TJSONObject.Create);
      JSONNestedObject := JSONArray.Items[pred(JSONArray.Count)] as TJSONObject;
      JSONNestedObject.AddPair('Name',  Driver.Name)
                      .AddPair('Phone', Driver.Phone);
    end;
    FJSON := JSONArray.ToJSON;
  finally
    FreeAndNIl(JSONArray);
  end;end;

{ TAutoList }

constructor TAutoList.Create(const fileName: string);
begin
  inherited Create;
  Self.FFileName := fileName;
end;

function TAutoList.CreateAuto(const ID: Integer; const Brand, Color, Model, Number: string): TAuto;
var
  Auto: TAuto;
begin
  Auto        := TAuto.Create;
  Auto.ID     := ID;
  Auto.Brand  := Brand;
  Auto.Color  := Color;
  Auto.Model  := Model;
  Auto.Number := Number;
  Result := Auto;
end;

procedure TAutoList.loadFromJson();
const
  cFileName = 'The file %s is not exists!';
var
  data: TBytes;
  JSONValue, jv, findJSONValue: TJSONValue;
  joName: TJSONObject;
  ID: Integer;
  Brand: String;
  Color: String;
  Model: String;
  Number: String;
begin
  try
    try
      ID := 1;
      if FileExists(Self.FFileName) then begin
        data := TEncoding.ASCII.GetBytes(TFile.ReadAllText(Self.FFileName));
        FJSON := TEncoding.ASCII.GetString(data);
        JSONValue := TJSONObject.ParseJSONValue(data, 0);
        for jv in JSONValue as TJSONArray do begin
          joName := jv as TJSONObject;
          Brand  := EmptyStr;
          Color  := EmptyStr;
          Model  := EmptyStr;
          Number := EmptyStr;
          findJSONValue := joName.FindValue('Brand');
          if findJSONValue <> nil then Brand := findJSONValue.Value;
          findJSONValue := joName.FindValue('Color');
          if findJSONValue <> nil then Color := findJSONValue.Value;
          findJSONValue := joName.FindValue('Model');
          if findJSONValue <> nil then Model := findJSONValue.Value;
          findJSONValue := joName.FindValue('Number');
          if findJSONValue <> nil then Number := findJSONValue.Value;
          Self.Add(Self.CreateAuto(ID, Brand, Color, Model, Number));
          Inc(ID);
        end;
      end else
        raise Exception.Create(Format(cFileName, [Self.FFileName]));
    finally
      FreeAndNil(JSONValue);
    end;
  except

  end;
end;

procedure TAutoList.saveToJson;
var
  JSON: TJSONObject;
  JSONArray: TJSONArray;
  JSONNestedObject: TJSONObject;
  i: integer;
  Auto: TAuto;
begin
  JSONArray := TJSONArray.Create;
  try
    for i := 0 to Self.Count - 1 do begin
      Auto := Self.Items[i];
      JSONArray.AddElement(TJSONObject.Create);
      JSONNestedObject := JSONArray.Items[pred(JSONArray.Count)] as TJSONObject;
      JSONNestedObject.AddPair('Brand', Auto.Brand)
                      .AddPair('Color', Auto.Color)
                      .AddPair('Model', Auto.Model)
                      .AddPair('Number', Auto.Number);
    end;
    FJSON := JSONArray.ToJSON;
  finally
    FreeAndNIl(JSONArray);
  end;
end;

{ TTripList }

constructor TTripList.Create(const fileName: string);
begin
  inherited Create;
  Self.FFileName := fileName;
end;

function TTripList.CreateTrip(const AutoID, DriverID: Integer;
  const StartTime: TDateTime): TTrip;
var
  Trip: TTrip;
begin
  Trip           := TTrip.Create;
  Trip.AutoID    := AutoID;
  Trip.DriverID  := DriverID;
  Trip.StartTime := StartTime;
  Result := Trip;
end;

procedure TTripList.loadFromJson;
const
  cFileName = 'The file %s is not exists!';
var
  data: TBytes;
  JSONValue, jv, findJSONValue: TJSONValue;
  joName: TJSONObject;
  ID: Integer;
  AutoID: Integer;
  DriverID: Integer;
  StartTime: TDateTime;
begin
  try
    try
      ID := 1;
      if FileExists(Self.FFileName) then begin
        data := TEncoding.ASCII.GetBytes(TFile.ReadAllText(Self.FFileName));
        FJSON := TEncoding.ASCII.GetString(data);
        JSONValue := TJSONObject.ParseJSONValue(data, 0);
        for jv in JSONValue as TJSONArray do begin
          joName := jv as TJSONObject;
          findJSONValue := joName.FindValue('AutoID');
          if findJSONValue <> nil then AutoID := StrToInt(findJSONValue.Value);
          findJSONValue := joName.FindValue('DriverID');
          if findJSONValue <> nil then DriverID := StrToInt(findJSONValue.Value);
          findJSONValue := joName.FindValue('StartTime');
          if findJSONValue <> nil then StartTime := StrToDateTime(findJSONValue.Value);
          Self.Add(Self.CreateTrip(AutoID, DriverID, StartTime));
          Inc(ID);
        end;
      end else
        raise Exception.Create(Format(cFileName, [Self.FFileName]));
    finally
      FreeAndNil(JSONValue);
    end;
  except

  end;
end;

procedure TTripList.saveToJson;
var
  JSON: TJSONObject;
  JSONArray: TJSONArray;
  JSONNestedObject: TJSONObject;
  i: integer;
  Trip: TTrip;
  strDate: String;
begin
  JSONArray := TJSONArray.Create;
  try
    for i := 0 to Self.Count - 1 do begin
      Trip := Self.Items[i];
      strDate := DateTimeToStr(Trip.StartTime);
      JSONArray.AddElement(TJSONObject.Create);
      JSONNestedObject := JSONArray.Items[pred(JSONArray.Count)] as TJSONObject;
      JSONNestedObject.AddPair('AutoID',    IntToStr(Trip.AutoID))
                      .AddPair('DriverID',  IntToStr(Trip.DriverID))
                      .AddPair('StartTime', strDate);
    end;
    FJSON := JSONArray.ToJSON;
  finally
    FreeAndNIl(JSONArray);
  end;
end;

end.
