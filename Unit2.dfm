object Form2: TForm2
  Left = 213
  Top = 198
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Statistics'
  ClientHeight = 143
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 76
    Top = 31
    Width = 34
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label2: TLabel
    Left = 76
    Top = 47
    Width = 34
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label3: TLabel
    Left = 76
    Top = 63
    Width = 34
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label4: TLabel
    Left = 76
    Top = 79
    Width = 34
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label5: TLabel
    Left = 118
    Top = 31
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label6: TLabel
    Left = 118
    Top = 47
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label7: TLabel
    Left = 118
    Top = 63
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label8: TLabel
    Left = 118
    Top = 79
    Width = 50
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label9: TLabel
    Left = 173
    Top = 31
    Width = 30
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label10: TLabel
    Left = 173
    Top = 47
    Width = 30
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label11: TLabel
    Left = 173
    Top = 63
    Width = 30
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label12: TLabel
    Left = 173
    Top = 79
    Width = 30
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Label16: TLabel
    Left = 7
    Top = 79
    Width = 46
    Height = 13
    Caption = 'Megashift'
  end
  object Label15: TLabel
    Left = 7
    Top = 63
    Width = 30
    Height = 13
    Caption = 'Shifter'
  end
  object Label14: TLabel
    Left = 7
    Top = 47
    Width = 53
    Height = 13
    Caption = 'Continuous'
  end
  object Label13: TLabel
    Left = 7
    Top = 31
    Width = 43
    Height = 13
    Caption = 'Standard'
  end
  object Label17: TLabel
    Left = 75
    Top = 7
    Width = 33
    Height = 13
    Caption = 'Games'
  end
  object Label18: TLabel
    Left = 123
    Top = 7
    Width = 40
    Height = 13
    Caption = 'Average'
  end
  object Label19: TLabel
    Left = 177
    Top = 7
    Width = 22
    Height = 13
    Caption = 'High'
  end
  object Button1: TButton
    Left = 7
    Top = 111
    Width = 145
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
    OnKeyPress = Button1KeyPress
  end
  object Button2: TButton
    Left = 159
    Top = 111
    Width = 51
    Height = 25
    Hint = 'Reset Statistics'
    Caption = 'Reset'
    TabOrder = 1
    OnClick = Button2Click
    OnKeyPress = Button2KeyPress
  end
  object Panel1: TPanel
    Left = 7
    Top = 103
    Width = 201
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 2
  end
end
