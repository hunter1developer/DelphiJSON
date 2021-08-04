object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Json Test'
  ClientHeight = 348
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnLoadSaveJsonDriver: TButton
    Left = 344
    Top = 24
    Width = 219
    Height = 25
    Caption = 'btnLoadSaveJsonDriver'
    TabOrder = 0
    OnClick = btnLoadSaveJsonDriverClick
  end
  object btnLoadSaveJsonAuto: TButton
    Left = 344
    Top = 64
    Width = 219
    Height = 25
    Caption = 'btnLoadSaveJsonAuto'
    TabOrder = 1
    OnClick = btnLoadSaveJsonAutoClick
  end
  object btnLoadSaveJsonTrip: TButton
    Left = 344
    Top = 112
    Width = 219
    Height = 25
    Caption = 'btnLoadSaveJsonTrip'
    TabOrder = 2
    OnClick = btnLoadSaveJsonTripClick
  end
end
