object MainForm: TMainForm
  Left = 90
  Top = 82
  Caption = 'MaxInt B & V Tool  for Fastcode Version 1.8.1'
  ClientHeight = 494
  ClientWidth = 737
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
    Left = 16
    Top = 168
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object Label1: TLabel
    Left = 16
    Top = 56
    Width = 82
    Height = 13
    Caption = 'Function Address'
  end
  object Label2: TLabel
    Left = 608
    Top = 56
    Width = 70
    Height = 13
    Caption = 'Function name'
  end
  object Label3: TLabel
    Left = 608
    Top = 96
    Width = 72
    Height = 13
    Caption = 'Max spread [%]'
  end
  object Label4: TLabel
    Left = 608
    Top = 144
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label5: TLabel
    Left = 608
    Top = 184
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label6: TLabel
    Left = 608
    Top = 232
    Width = 100
    Height = 13
    Caption = 'Alignment Spread [%]'
  end
  object Label7: TLabel
    Left = 608
    Top = 272
    Width = 79
    Height = 13
    Caption = 'Function name 1'
  end
  object Label8: TLabel
    Left = 608
    Top = 312
    Width = 79
    Height = 13
    Caption = 'Function name 1'
  end
  object BenchmarkButton: TButton
    Left = 40
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 1
    OnClick = BenchmarkButtonClick
  end
  object RunTimeEdit1: TEdit
    Left = 16
    Top = 184
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = 'RuntimeEdit1'
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 56
    Width = 161
    Height = 361
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'Max_RTL_IA32_1_a'
      'Max_RTL_IA32_1_b'
      'Max_RTL_IA32_1_c'
      'Max_RTL_IA32_1_d'
      'Max_DKC_IA32_1_a'
      'Max_DKC_IA32_1_b'
      'Max_DKC_IA32_1_c'
      'Max_DKC_IA32_1_d'
      'Max_LBG_IA32_1_a'
      'Max_LBG_IA32_1_b'
      'Max_LBG_IA32_1_c'
      'Max_LBG_IA32_1_d'
      'Max_DKC_Pas_1_a'
      'Max_DKC_Pas_1_b'
      'Max_DKC_Pas_1_c'
      'Max_DKC_Pas_1_d'
      'Max_Sha_IA32_1_a'
      'Max_Sha_IA32_1_b'
      'Max_Sha_IA32_1_c'
      'Max_Sha_IA32_1_d'
      'Max_Sha_Pas_1_a'
      'Max_Sha_Pas_1_b'
      'Max_Sha_Pas_1_c'
      'Max_Sha_Pas_1_d')
    TabOrder = 3
    OnClick = FunctionSelectionRadioGroupClick
  end
  object CloseBitBtn: TBitBtn
    Left = 648
    Top = 440
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkClose
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 737
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 5
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
    object AboutSpeedButton: TSpeedButton
      Left = 80
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      OnClick = AboutSpeedButtonClick
    end
  end
  object ReportRichEdit: TRichEdit
    Left = 328
    Top = 56
    Width = 273
    Height = 361
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'ResultsRichEdit')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object BenchmarkAllButton: TButton
    Left = 512
    Top = 423
    Width = 89
    Height = 42
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateButton: TButton
    Left = 40
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 7
    OnClick = ValidateButtonClick
  end
  object ValidEdit: TEdit
    Left = 16
    Top = 104
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    Text = 'ValidEdit'
  end
  object ClearButton: TButton
    Left = 328
    Top = 424
    Width = 89
    Height = 41
    Caption = 'Clear'
    TabOrder = 9
    OnClick = ClearButtonClick
  end
  object AddressEdit: TEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
    Text = 'AddressEdit'
  end
  object Bench1Edit: TEdit
    Left = 608
    Top = 160
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 608
    Top = 200
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
    Text = 'Bench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 608
    Top = 248
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 608
    Top = 288
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 14
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 608
    Top = 328
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 15
    Text = 'AlignFunctionName2Edit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 608
    Top = 112
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 16
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object FunctionNameEdit: TEdit
    Left = 608
    Top = 72
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 17
    Text = 'FunctionNameEdit'
  end
  object ValidateAllButton: TButton
    Left = 424
    Top = 424
    Width = 81
    Height = 41
    Caption = 'Validate All'
    TabOrder = 18
    OnClick = ValidateAllButtonClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 477
    Width = 737
    Height = 17
    Align = alBottom
    TabOrder = 19
  end
  object SpreadTestButton: TButton
    Left = 632
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 20
    OnClick = SpreadTestButtonClick
  end
  object BenchTestButton: TButton
    Left = 632
    Top = 392
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 21
    OnClick = BenchTestButtonClick
  end
  object Y2Edit: TEdit
    Left = 176
    Top = 432
    Width = 121
    Height = 21
    TabOrder = 22
    Text = 'Y2Edit'
    Visible = False
  end
  object AlignCheckButton: TButton
    Left = 40
    Top = 312
    Width = 75
    Height = 25
    Caption = 'AlignCheck'
    TabOrder = 23
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 16
    Top = 280
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 24
    Text = 'AlignCheckEdit'
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 96
  end
end
