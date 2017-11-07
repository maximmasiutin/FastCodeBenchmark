object MainForm: TMainForm
  Left = 81
  Top = 76
  Caption = 'StrIComp Benchmark & Validation Tool for Fastcode Version 1.3.1'
  ClientHeight = 600
  ClientWidth = 847
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
    Left = 704
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 704
    Top = 96
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 704
    Top = 136
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 704
    Top = 176
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 704
    Top = 376
    Width = 97
    Height = 13
    Caption = 'Alignment Spread[%]'
  end
  object Label8: TLabel
    Left = 704
    Top = 416
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label9: TLabel
    Left = 704
    Top = 456
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label10: TLabel
    Left = 704
    Top = 296
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label11: TLabel
    Left = 704
    Top = 336
    Width = 37
    Height = 13
    Caption = 'Bench2'
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
    Left = 728
    Top = 560
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 304
    Top = 56
    Width = 393
    Height = 481
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
    Left = 136
    Top = 47
    Width = 161
    Height = 554
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'StrIComp_RTL'
      'StrIComp_DKC_Pas_6_a'
      'StrIComp_DKC_Pas_6_b'
      'StrIComp_DKC_Pas_6_c'
      'StrIComp_DKC_Pas_6_d'
      'StrIComp_DKC_IA32_10_a'
      'StrIComp_DKC_IA32_10_b'
      'StrIComp_DKC_IA32_10_c'
      'StrIComp_DKC_IA32_10_d'
      'StrIComp_DKC_IA32_15_a'
      'StrIComp_DKC_IA32_15_b'
      'StrIComp_DKC_IA32_15_c'
      'StrIComp_DKC_IA32_15_d'
      'StrIComp_JOH_PAS_1_a'
      'StrIComp_JOH_PAS_1_b'
      'StrIComp_JOH_PAS_1_c'
      'StrIComp_JOH_PAS_1_d'
      'StrIComp_JOH_IA32_1_a'
      'StrIComp_JOH_IA32_1_b'
      'StrIComp_JOH_IA32_1_c'
      'StrIComp_JOH_IA32_1_d'
      'StrIComp_JOH_IA32_2_a'
      'StrIComp_JOH_IA32_2_b'
      'StrIComp_JOH_IA32_2_c'
      'StrIComp_JOH_IA32_2_d'
      'StrIComp_JOH_IA32_3_a'
      'StrIComp_JOH_IA32_3_b'
      'StrIComp_JOH_IA32_3_c'
      'StrIComp_JOH_IA32_3_d'
      'StrIComp_JOH_IA32_4_a'
      'StrIComp_JOH_IA32_4_b'
      'StrIComp_JOH_IA32_4_c'
      'StrIComp_JOH_IA32_4_d'
      'StrIComp_DFL_Pas_10_a'
      'StrIComp_DFL_Pas_10_b'
      'StrIComp_DFL_Pas_10_c'
      'StrIComp_DFL_Pas_10_d'
      'StrIComp_DFL_Pas_11_a'
      'StrIComp_DFL_Pas_12_a'
      'StrIComp_DFL_Pas_18_a'
      'StrIComp_DFL_Pas_19_a'
      'StrIComp_DFL_Pas_19_b'
      'StrIComp_DFL_Pas_19_c'
      'StrIComp_DFL_Pas_19_d'
      'StrIComp_DKC_IA32_16_a'
      'StrIComp_DKC_IA32_16_b'
      'StrIComp_DKC_IA32_16_c'
      'StrIComp_DKC_IA32_16_d'
      'StrIComp_DKC_IA32_17_a'
      'StrIComp_DKC_IA32_17_b'
      'StrIComp_DKC_IA32_17_c'
      'StrIComp_DKC_IA32_17_d'
      'StrIComp_DKC_IA32_18_a'
      'StrIComp_DKC_IA32_18_b'
      'StrIComp_DKC_IA32_18_c'
      'StrIComp_DKC_IA32_18_d')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 596
    Top = 552
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object SpreadBench1Edit: TEdit
    Left = 704
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
    TabOrder = 11
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 704
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
    TabOrder = 12
    Text = 'SpreadBench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 444
    Top = 552
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 316
    Top = 552
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 704
    Top = 152
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
    Left = 704
    Top = 192
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
    Width = 847
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
      Left = 800
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
    Left = 728
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object AlignFunctionName1Edit: TEdit
    Left = 704
    Top = 432
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
    TabOrder = 17
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 704
    Top = 472
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
    TabOrder = 18
    Text = 'AlignFunctionName2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 704
    Top = 392
    Width = 121
    Height = 21
    Hint = 
      'Spread due to differences in code alignment inclusive measuremen' +
      't errors'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 19
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object SpreadTestButton: TButton
    Left = 728
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 728
    Top = 504
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnClick = CleanResultsButtonClick
  end
  object J1Edit: TEdit
    Left = 8
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 21
    Text = 'J1Edit'
    Visible = False
  end
  object J2Edit: TEdit
    Left = 8
    Top = 360
    Width = 121
    Height = 21
    TabOrder = 22
    Text = 'J2Edit'
    Visible = False
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 704
    Top = 312
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
    TabOrder = 23
    Text = 'Bench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 704
    Top = 352
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
    TabOrder = 24
    Text = 'Bench2Edit'
  end
  object AlignCheckButton: TButton
    Left = 32
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 25
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 8
    Top = 232
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
    TabOrder = 26
    Text = 'AlignCheckEdit'
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 16
    Top = 448
    Width = 114
    Height = 17
    Caption = 'Show Error Dialog'
    TabOrder = 27
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 64
    Top = 400
  end
end
