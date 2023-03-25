object Form3: TForm3
  Left = 245
  Top = 167
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 246
  ClientWidth = 181
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
    Left = 6
    Top = 133
    Width = 57
    Height = 13
    Caption = 'Game Style:'
  end
  object Label2: TLabel
    Left = 6
    Top = 158
    Width = 59
    Height = 13
    Caption = 'Breaker Set:'
  end
  object Label3: TLabel
    Left = 6
    Top = 182
    Width = 58
    Height = 13
    Caption = 'Sounds Set:'
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 6
    Width = 166
    Height = 17
    Hint = 'Sounds play if checked'
    Caption = 'Play Sounds'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnKeyPress = CheckBox1KeyPress
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 26
    Width = 166
    Height = 17
    Caption = 'Confirm End Game'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnKeyPress = CheckBox2KeyPress
  end
  object CheckBox3: TCheckBox
    Left = 8
    Top = 46
    Width = 166
    Height = 17
    Caption = 'Display Decimal Averages'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnKeyPress = CheckBox3KeyPress
  end
  object CheckBox4: TCheckBox
    Left = 8
    Top = 66
    Width = 166
    Height = 17
    Caption = 'Display Bursts'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnKeyPress = CheckBox4KeyPress
  end
  object CheckBox5: TCheckBox
    Left = 8
    Top = 87
    Width = 166
    Height = 17
    Caption = 'Guest Mode'
    TabOrder = 5
    OnKeyPress = CheckBox5KeyPress
  end
  object ComboBox1: TComboBox
    Left = 68
    Top = 131
    Width = 106
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Standard'
      'Continuous'
      'Shifter'
      'MegaShift')
  end
  object Button1: TButton
    Left = 7
    Top = 214
    Width = 167
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
    OnKeyPress = Button1KeyPress
  end
  object Panel2: TPanel
    Left = 8
    Top = 206
    Width = 166
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 9
  end
  object CheckBox6: TCheckBox
    Left = 8
    Top = 108
    Width = 166
    Height = 17
    Caption = 'Large Breakers'
    TabOrder = 6
    OnKeyPress = CheckBox6KeyPress
  end
  object ComboBox2: TComboBox
    Left = 68
    Top = 155
    Width = 106
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Colorful Breakers'
      'Grayscale Breakers')
  end
  object ComboBox3: TComboBox
    Left = 68
    Top = 179
    Width = 106
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 10
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Custom Sounds'
      'Original Sounds')
  end
end
