object MainForm: TMainForm
  Left = 242
  Top = 113
  Caption = 'MaxFP B & V for Fastcode Version 2.5.0'
  ClientHeight = 477
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object RunTimeLabel: TLabel
    Left = 272
    Top = 56
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object DevelopSingleButton: TButton
    Left = 32
    Top = 168
    Width = 89
    Height = 25
    Caption = 'Develop Single'
    TabOrder = 2
    OnClick = DevelopSingleButtonClick
  end
  object BenchmarkSingleButton: TButton
    Left = 280
    Top = 168
    Width = 97
    Height = 25
    Caption = 'Benchmark Single'
    TabOrder = 3
    OnClick = BenchmarkSingleButtonClick
  end
  object X1Edit: TEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 4
    Text = 'X1Edit'
  end
  object X2Edit: TEdit
    Left = 16
    Top = 104
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 5
    Text = 'X2Edit'
  end
  object Y2Edit: TEdit
    Left = 16
    Top = 136
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 6
    Text = 'Y2Edit'
  end
  object RunTimeEdit1: TEdit
    Left = 272
    Top = 72
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    ReadOnly = True
    TabOrder = 7
    Text = 'RuntimeEdit1'
  end
  object SingleFunctionSelectRadioGroup: TRadioGroup
    Left = 16
    Top = 320
    Width = 121
    Height = 129
    Caption = 'Single Function Select'
    ItemIndex = 0
    Items.Strings = (
      'Max_RTL_IA32_1'
      'Max_DKC_Pas_1'
      'Max_DKC_IA32_1'
      'Max_DKC_IA32_2'
      'Max_DKC_IA32_3'
      'Max_JOH_IA32_1'
      'Max_JOH_IA32_2'
      'Max_DKC_SSE_1')
    TabOrder = 8
    OnClick = SingleFunctionSelectRadioGroupClick
  end
  object CloseBitBtn: TBitBtn
    Left = 576
    Top = 440
    Width = 75
    Height = 25
    TabOrder = 9
    Kind = bkClose
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 668
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 10
    object SaveResultsSpeedButton: TSpeedButton
      Left = 16
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      OnClick = SaveResultsSpeedButtonClick
    end
    object PrintResultsSpeedButton: TSpeedButton
      Left = 48
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      OnClick = PrintResultsSpeedButtonClick
    end
  end
  object ResultsRichEdit: TRichEdit
    Left = 400
    Top = 72
    Width = 257
    Height = 353
    TabStop = False
    Color = clInfoBk
    Lines.Strings = (
      'ResultsRichEdit')
    PlainText = True
    ReadOnly = True
    TabOrder = 11
  end
  object BenchmarkAllButton: TButton
    Left = 272
    Top = 272
    Width = 113
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateSingleButton: TButton
    Left = 160
    Top = 168
    Width = 81
    Height = 25
    Caption = 'Validate Single'
    TabOrder = 12
    OnClick = ValidateSingleButtonClick
  end
  object ValidEdit: TEdit
    Left = 144
    Top = 72
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 13
    Text = 'ValidEdit'
  end
  object ClearButton: TButton
    Left = 416
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 14
    OnClick = ClearButtonClick
  end
  object DoubleFunctionSelectRadioGroup: TRadioGroup
    Left = 144
    Top = 320
    Width = 121
    Height = 129
    Caption = 'Double Function Select'
    ItemIndex = 0
    Items.Strings = (
      'Max_RTL_IA32_1'
      'Max_DKC_Pas_1'
      'Max_DKC_IA32_1'
      'Max_DKC_IA32_2'
      'Max_DKC_IA32_3'
      'Max_JOH_IA32_1'
      'Max_JOH_IA32_2'
      'Max_DKC_SSE2_1'
      'Max_DKC_SSE2_2')
    TabOrder = 15
    OnClick = DoubleFunctionSelectRadioGroupClick
  end
  object ExtendedFunctionSelectRadioGroup: TRadioGroup
    Left = 272
    Top = 320
    Width = 121
    Height = 129
    Caption = 'Ext. Function Select'
    ItemIndex = 0
    Items.Strings = (
      'Max_RTL_IA32_1'
      'Max_DKC_Pas_1'
      'Max_DKC_IA32_1'
      'Max_DKC_IA32_2'
      'Max_DKC_IA32_3'
      'Max_JOH_IA32_1'
      'Max_JOH_IA32_2')
    TabOrder = 16
    OnClick = ExtendedFunctionSelectRadioGroupClick
  end
  object DevelopDoubleButton: TButton
    Left = 32
    Top = 200
    Width = 89
    Height = 25
    Caption = 'Develop Double'
    TabOrder = 17
    OnClick = DevelopDoubleButtonClick
  end
  object DevelopExtendedButton: TButton
    Left = 32
    Top = 232
    Width = 89
    Height = 25
    Caption = 'Develop Ext.'
    TabOrder = 18
    OnClick = DevelopExtendedButtonClick
  end
  object ValidateDoubleButton: TButton
    Left = 160
    Top = 200
    Width = 81
    Height = 25
    Caption = 'Validate Double'
    TabOrder = 19
    OnClick = ValidateDoubleButtonClick
  end
  object ValidateExtendedButton: TButton
    Left = 160
    Top = 232
    Width = 81
    Height = 25
    Caption = 'Validate Ext.'
    TabOrder = 20
    OnClick = ValidateExtendedButtonClick
  end
  object BenchmarkDoubleButton: TButton
    Left = 280
    Top = 200
    Width = 97
    Height = 25
    Caption = 'Benchmark Double'
    TabOrder = 21
    OnClick = BenchmarkDoubleButtonClick
  end
  object BenchmarkExtendedButton: TButton
    Left = 280
    Top = 232
    Width = 97
    Height = 25
    Caption = 'Benchmark Ext.'
    TabOrder = 22
    OnClick = BenchmarkExtendedButtonClick
  end
  object Y1Edit: TEdit
    Left = 272
    Top = 104
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 23
    Text = 'Y1Edit'
  end
  object Y3Edit: TEdit
    Left = 272
    Top = 136
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 24
    Text = 'Y3Edit'
  end
  object ValidateAllButton: TButton
    Left = 152
    Top = 272
    Width = 97
    Height = 25
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 184
    Top = 112
  end
end
