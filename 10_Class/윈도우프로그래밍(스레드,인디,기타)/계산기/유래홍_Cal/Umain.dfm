object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Calculator'
  ClientHeight = 358
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 110
    Width = 289
    Height = 249
    Caption = 'Panel1'
    TabOrder = 0
    object btn_Backspace: TButton
      Left = 118
      Top = 8
      Width = 49
      Height = 41
      Caption = '<--'
      TabOrder = 0
      TabStop = False
      OnClick = btn_BackspaceClick
    end
    object btn_Reset: TButton
      Left = 8
      Top = 8
      Width = 104
      Height = 41
      Caption = 'Clear'
      TabOrder = 1
      TabStop = False
      OnClick = btn_ResetClick
    end
    object btn_Sign: TButton
      Left = 173
      Top = 8
      Width = 49
      Height = 41
      Caption = '+/-'
      TabOrder = 2
      TabStop = False
      OnClick = btn_PercentClick
    end
    object btn_Root: TButton
      Left = 228
      Top = 8
      Width = 49
      Height = 41
      Caption = #47336#53944
      TabOrder = 3
      TabStop = False
      OnClick = btn_PercentClick
    end
    object btn_Num1: TButton
      Left = 8
      Top = 55
      Width = 49
      Height = 41
      Caption = '1'
      TabOrder = 4
      TabStop = False
      OnClick = btn_Num1Click
    end
    object btn_Inverse: TButton
      Left = 228
      Top = 102
      Width = 49
      Height = 41
      Caption = '1/x'
      TabOrder = 5
      TabStop = False
      OnClick = btn_PercentClick
    end
    object btn_Mul: TButton
      Left = 173
      Top = 102
      Width = 49
      Height = 41
      Caption = '*'
      TabOrder = 6
      TabStop = False
      OnClick = btn_MulClick
    end
    object btn_Num6: TButton
      Left = 118
      Top = 102
      Width = 49
      Height = 41
      Caption = '6'
      TabOrder = 7
      TabStop = False
      OnClick = btn_Num6Click
    end
    object btn_Num5: TButton
      Left = 63
      Top = 102
      Width = 49
      Height = 41
      Caption = '5'
      TabOrder = 8
      TabStop = False
      OnClick = btn_Num5Click
    end
    object btn_Num4: TButton
      Left = 8
      Top = 102
      Width = 49
      Height = 41
      Caption = '4'
      TabOrder = 9
      TabStop = False
      OnClick = btn_Num4Click
    end
    object btn_Enter: TButton
      Left = 228
      Top = 149
      Width = 49
      Height = 88
      Caption = '='
      TabOrder = 10
      OnClick = btn_EnterClick
    end
    object btn_Sub: TButton
      Left = 173
      Top = 149
      Width = 49
      Height = 41
      Caption = '-'
      TabOrder = 11
      TabStop = False
      OnClick = btn_SubClick
    end
    object btn_Num9: TButton
      Left = 118
      Top = 149
      Width = 49
      Height = 41
      Caption = '9'
      TabOrder = 12
      TabStop = False
      OnClick = btn_Num9Click
    end
    object btn_Num8: TButton
      Left = 63
      Top = 149
      Width = 49
      Height = 41
      Caption = '8'
      TabOrder = 13
      TabStop = False
      OnClick = btn_Num8Click
    end
    object btn_Num7: TButton
      Left = 8
      Top = 149
      Width = 49
      Height = 41
      Caption = '7'
      TabOrder = 14
      TabStop = False
      OnClick = btn_Num7Click
    end
    object btn_Add: TButton
      Left = 173
      Top = 196
      Width = 49
      Height = 41
      Caption = '+'
      TabOrder = 15
      TabStop = False
      OnClick = btn_AddClick
    end
    object btn_Dat: TButton
      Left = 118
      Top = 196
      Width = 49
      Height = 41
      Caption = '.'
      TabOrder = 16
      TabStop = False
      OnClick = btn_DatClick
    end
    object btn_Num0: TButton
      Left = 8
      Top = 196
      Width = 104
      Height = 41
      Caption = '0'
      TabOrder = 17
      TabStop = False
      OnClick = btn_Num0Click
    end
    object btn_Percent: TButton
      Left = 228
      Top = 55
      Width = 49
      Height = 41
      Caption = '%'
      TabOrder = 18
      TabStop = False
      OnClick = btn_PercentClick
    end
    object btn_Div: TButton
      Left = 173
      Top = 55
      Width = 49
      Height = 41
      Caption = '/'
      TabOrder = 19
      TabStop = False
      OnClick = btn_DivClick
    end
    object btn_Num3: TButton
      Left = 118
      Top = 55
      Width = 49
      Height = 41
      Caption = '3'
      TabOrder = 20
      TabStop = False
      OnClick = btn_Num3Click
    end
    object btn_Num2: TButton
      Left = 63
      Top = 55
      Width = 49
      Height = 41
      Caption = '2'
      TabOrder = 21
      TabStop = False
      OnClick = btn_Num2Click
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 271
    Height = 96
    TabOrder = 1
    object StaticText1: TStaticText
      Left = 8
      Top = 47
      Width = 257
      Height = 41
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 8
      Top = 9
      Width = 257
      Height = 32
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
