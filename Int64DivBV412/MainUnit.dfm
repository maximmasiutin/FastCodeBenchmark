object MainForm: TMainForm
  Left = 88
  Top = 107
  Caption = 'Int64 Division B&V Tool for Fastcode Version 4.1.2'
  ClientHeight = 573
  ClientWidth = 922
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Validation'
  end
  object Label2: TLabel
    Left = 8
    Top = 144
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label3: TLabel
    Left = 768
    Top = 48
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 768
    Top = 88
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 768
    Top = 128
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 768
    Top = 168
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 8
    Top = 272
    Width = 86
    Height = 13
    Caption = 'FPU Control Word'
  end
  object Label8: TLabel
    Left = 768
    Top = 312
    Width = 94
    Height = 13
    Caption = 'AlignSpreadBench1'
  end
  object Label9: TLabel
    Left = 768
    Top = 352
    Width = 94
    Height = 13
    Caption = 'AlignSpreadBench2'
  end
  object Label10: TLabel
    Left = 768
    Top = 392
    Width = 125
    Height = 13
    Caption = 'AlignMaxSpreadBench [%]'
  end
  object Label11: TLabel
    Left = 768
    Top = 432
    Width = 98
    Height = 13
    Caption = 'AlignFunctionName2'
  end
  object Label12: TLabel
    Left = 768
    Top = 472
    Width = 98
    Height = 13
    Caption = 'AlignFunctionName2'
  end
  object ValidateButton: TButton
    Left = 32
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
    OnClick = ValidateButtonClick
  end
  object ValidationEdit: TEdit
    Left = 8
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
    TabOrder = 6
    Text = 'ValidationEdit'
  end
  object BitBtn1: TBitBtn
    Left = 797
    Top = 520
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 320
    Top = 56
    Width = 433
    Height = 425
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'ReportRichEdit')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object BenchmarkButton: TButton
    Left = 32
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
    OnClick = BenchmarkButtonClick
  end
  object RuntimeEdit: TEdit
    Left = 8
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
    TabOrder = 9
    Text = 'RuntimeEdit'
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 144
    Top = 56
    Width = 169
    Height = 489
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'Int64Div_RTL_IA32_1'
      'Int64Div_RTL_IA32_2_a'
      'Int64Div_RTL_IA32_2_b'
      'Int64Div_RTL_IA32_2_c'
      'Int64Div_RTL_IA32_2_d'
      'Int64Div_AMD_IA32_1_a'
      'Int64Div_AMD_IA32_1_b'
      'Int64Div_AMD_IA32_1_c'
      'Int64Div_AMD_IA32_1_d'
      'Int64Div_DKC_IA32_2_a'
      'Int64Div_DKC_IA32_2_b'
      'Int64Div_DKC_IA32_2_c'
      'Int64Div_DKC_IA32_2_d'
      'Int64Div_DKC_IA32ext_2_a'
      'Int64Div_DKC_IA32ext_2_b'
      'Int64Div_DKC_IA32ext_2_c'
      'Int64Div_DKC_IA32ext_2_d'
      'Int64Div_JOH_IA32_1_a'
      'Int64Div_JOH_IA32_1_b'
      'Int64Div_JOH_IA32_1_c'
      'Int64Div_JOH_IA32_1_d'
      'Int64Div_JOH_IA32_2_a'
      'Int64Div_JOH_IA32_2_b'
      'Int64Div_JOH_IA32_2_c'
      'Int64Div_JOH_IA32_2_d'
      'Int64Div_JOH_IA32_3_a'
      'Int64Div_JOH_IA32_3_b'
      'Int64Div_JOH_IA32_3_c'
      'Int64Div_JOH_IA32_3_d'
      'Int64Div_JOH_IA32_4_a'
      'Int64Div_JOH_IA32_4_b'
      'Int64Div_JOH_IA32_4_c'
      'Int64Div_JOH_IA32_4_d'
      'Int64Div_JOH_IA32_5_a'
      'Int64Div_JOH_IA32_5_b'
      'Int64Div_JOH_IA32_5_c'
      'Int64Div_JOH_IA32_5_d')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 616
    Top = 496
    Width = 121
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Bench1Edit: TEdit
    Left = 768
    Top = 64
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
    Left = 768
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
    TabOrder = 12
    Text = 'Bench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 448
    Top = 496
    Width = 129
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 328
    Top = 496
    Width = 81
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 768
    Top = 144
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
    Text = 'MaxSpreadBenchPercentageEdit'
    OnClick = MaxSpreadBenchPercentageEditClick
  end
  object FunctionNameEdit: TEdit
    Left = 768
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
    TabOrder = 15
    Text = 'FunctionNameEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 922
    Height = 41
    Align = alTop
    TabOrder = 16
    object SaveReportSpeedButton: TSpeedButton
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
      OnClick = SaveReportSpeedButtonClick
    end
    object PrintReportSpeedButton: TSpeedButton
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
      OnClick = PrintReportSpeedButtonClick
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
  object BenchTestButton: TButton
    Left = 792
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object SpreadTestButton: TButton
    Left = 792
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 792
    Top = 279
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = CleanResultsButtonClick
  end
  object ZEdit: TEdit
    Left = 8
    Top = 240
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
    Text = 'ZEdit'
  end
  object Get8087CWEdit: TEdit
    Left = 8
    Top = 288
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
    Text = 'Get8087CWEdit'
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 8
    Top = 320
    Width = 129
    Height = 105
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 0
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 20
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 556
    Width = 922
    Height = 17
    Align = alBottom
    Smooth = True
    TabOrder = 21
  end
  object AlignCheckEdit: TEdit
    Left = 15
    Top = 438
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
    Text = 'AlignCheckEdit'
  end
  object AlignCheckButton: TButton
    Left = 40
    Top = 465
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 23
    OnClick = AlignCheckButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 768
    Top = 328
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 24
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 768
    Top = 368
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 25
    Text = 'AlignSpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 768
    Top = 408
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 26
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 768
    Top = 448
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 27
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 768
    Top = 488
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 28
    Text = 'AlignFunctionName2Edit'
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 104
  end
end
