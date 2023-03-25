object Form4: TForm4
  Left = 271
  Top = 205
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Game Over!'
  ClientHeight = 148
  ClientWidth = 181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 113
    Top = 6
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label2: TLabel
    Left = 113
    Top = 26
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label3: TLabel
    Left = 113
    Top = 46
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label4: TLabel
    Left = 113
    Top = 66
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label5: TLabel
    Left = 113
    Top = 86
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label6: TLabel
    Left = 17
    Top = 6
    Width = 62
    Height = 13
    Caption = 'Game Score:'
  end
  object Label7: TLabel
    Left = 17
    Top = 26
    Width = 73
    Height = 13
    Caption = 'Breaker Bonus:'
  end
  object Label8: TLabel
    Left = 17
    Top = 46
    Width = 58
    Height = 13
    Caption = 'Total Score:'
  end
  object Label9: TLabel
    Left = 17
    Top = 66
    Width = 74
    Height = 13
    Caption = 'Average Score:'
  end
  object Label10: TLabel
    Left = 17
    Top = 86
    Width = 71
    Height = 13
    Caption = 'Games Played:'
  end
  object Button1: TButton
    Left = 7
    Top = 116
    Width = 167
    Height = 25
    Caption = 'New Game'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
    OnKeyPress = Button1KeyPress
  end
  object Panel1: TPanel
    Left = 8
    Top = 108
    Width = 166
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 1
  end
end
