object MainForm: TMainForm
  Left = 87
  Top = 81
  Caption = 'PosIEx B & V for Fastcode Version 1.3.1'
  ClientHeight = 620
  ClientWidth = 941
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
  object Label3: TLabel
    Left = 600
    Top = 55
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label4: TLabel
    Left = 664
    Top = 55
    Width = 56
    Height = 13
    Caption = 'SubBench2'
  end
  object Label5: TLabel
    Left = 752
    Top = 55
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label6: TLabel
    Left = 560
    Top = 55
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label7: TLabel
    Left = 447
    Top = 54
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label8: TLabel
    Left = 808
    Top = 55
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label13: TLabel
    Left = 808
    Top = 95
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label14: TLabel
    Left = 808
    Top = 311
    Width = 106
    Height = 13
    Caption = 'Alignment Max Spread'
  end
  object Label15: TLabel
    Left = 808
    Top = 351
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label16: TLabel
    Left = 808
    Top = 391
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label17: TLabel
    Left = 808
    Top = 135
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label18: TLabel
    Left = 808
    Top = 175
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label1: TLabel
    Left = 808
    Top = 231
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label9: TLabel
    Left = 808
    Top = 271
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object CloseBitBtn: TBitBtn
    Left = 833
    Top = 544
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 448
    Top = 71
    Width = 353
    Height = 433
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'BenchmarkResultsRichEdit')
    ParentFont = False
    ParentShowHint = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 4
    WantTabs = True
  end
  object RunAllBenchmarksButton: TButton
    Left = 680
    Top = 510
    Width = 121
    Height = 49
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = RunAllBenchmarksButtonClick
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 136
    Top = 64
    Width = 305
    Height = 505
    Caption = 'Function Selection'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'PosIEx_Ref_a'
      'PosIEx_Ref_b'
      'PosIEx_Ref_c'
      'PosIEx_Ref_d'
      'PosIEx_DKC_Pas_16_a'
      'PosIEx_DKC_Pas_16_b'
      'PosIEx_DKC_Pas_16_c'
      'PosIEx_DKC_Pas_16_d'
      'PosIEx_DKC_Pas_18_a'
      'PosIEx_DKC_Pas_18_b'
      'PosIEx_DKC_Pas_18_c'
      'PosIEx_DKC_Pas_18_d'
      'PosIEx_DKC_IA32_5_a'
      'PosIEx_DKC_IA32_5_b'
      'PosIEx_DKC_IA32_5_c'
      'PosIEx_DKC_IA32_5_d'
      'PosIEx_DKC_IA32_11_a'
      'PosIEx_DKC_IA32_11_b'
      'PosIEx_DKC_IA32_11_c'
      'PosIEx_DKC_IA32_11_d'
      'PosIEx_DKC_IA32_12_a'
      'PosIEx_DKC_IA32_12_b'
      'PosIEx_DKC_IA32_12_c'
      'PosIEx_DKC_IA32_12_d'
      'PosIEx_DKC_MMX_5_a'
      'PosIEx_DKC_MMX_5_b'
      'PosIEx_DKC_MMX_5_c'
      'PosIEx_DKC_MMX_5_d'
      'PosIEx_JOH_IA32_1_a'
      'PosIEx_JOH_IA32_1_b'
      'PosIEx_JOH_IA32_1_c'
      'PosIEx_JOH_IA32_1_d'
      'PosIEx_DKC_MMX_6_a'
      'PosIEx_DKC_MMX_6_b'
      'PosIEx_DKC_MMX_6_c'
      'PosIEx_DKC_MMX_6_d'
      'PosIEx_DKC_MMX_7_a'
      'PosIEx_DKC_IA32_13_a'
      'PosIEx_DKC_IA32_13_b'
      'PosIEx_DKC_IA32_13_c'
      'PosIEx_DKC_IA32_13_d'
      'PosIEx_DKC_Pas_19_a'
      'PosIEx_DKC_Pas_19_b'
      'PosIEx_DKC_Pas_19_c'
      'PosIEx_DKC_Pas_19_d'
      'PosIEx_DKC_Pas_20_a'
      'PosIEx_DKC_Pas_20_b'
      'PosIEx_DKC_Pas_20_c'
      'PosIEx_DKC_Pas_20_d'
      'PosIEx_DKC_Pas_21_a'
      'PosIEx_DKC_Pas_21_b'
      'PosIEx_DKC_Pas_21_c'
      'PosIEx_DKC_Pas_21_d'
      'PosIEx_DKC_Pas_22_a'
      'PosIEx_DKC_Pas_22_b'
      'PosIEx_DKC_Pas_22_c'
      'PosIEx_DKC_Pas_22_d'
      'PosIEx_DKC_Pas_23_a'
      'PosIEx_DKC_Pas_23_b'
      'PosIEx_DKC_Pas_23_c'
      'PosIEx_DKC_Pas_23_d'
      'PosIEx_DKC_Pas_24_a'
      'PosIEx_DKC_Pas_24_b'
      'PosIEx_DKC_Pas_24_c'
      'PosIEx_DKC_Pas_24_d'
      'PosIEx_DKC_Pas_25_a'
      'PosIEx_DKC_Pas_25_b'
      'PosIEx_DKC_Pas_25_c'
      'PosIEx_DKC_Pas_25_d'
      'PosIEx_DKC_Pas_26_a'
      'PosIEx_DKC_Pas_26_b'
      'PosIEx_DKC_Pas_26_c'
      'PosIEx_DKC_Pas_26_d')
    ParentFont = False
    TabOrder = 5
    OnClick = FunctionSelectionRadioGroupClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 603
    Width = 941
    Height = 17
    Align = alBottom
    TabOrder = 6
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 941
    Height = 49
    Align = alTop
    TabOrder = 7
    object PrintSpeedButton: TSpeedButton
      Left = 56
      Top = 16
      Width = 23
      Height = 22
      Hint = 'Print Results'
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
      ParentShowHint = False
      ShowHint = True
      OnClick = PrintSpeedButtonClick
    end
    object SaveAsSpeedButton: TSpeedButton
      Left = 24
      Top = 16
      Width = 23
      Height = 22
      Hint = 'Save Results'
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
      ParentShowHint = False
      ShowHint = True
      OnClick = SaveButtonClick
    end
    object AboutSpeedButton: TSpeedButton
      Left = 776
      Top = 16
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
  object ValidateAllButton: TButton
    Left = 560
    Top = 510
    Width = 105
    Height = 49
    Caption = 'Validate All'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkButton: TButton
    Left = 16
    Top = 136
    Width = 97
    Height = 33
    Caption = 'Benchmark'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BenchmarkButtonClick
  end
  object ResultEdit: TEdit
    Left = 9
    Top = 488
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'ResultEdit'
    Visible = False
  end
  object ValidateButton: TButton
    Left = 16
    Top = 88
    Width = 97
    Height = 33
    Caption = 'Validate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = ValidateButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 584
    Width = 941
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 16
    Top = 192
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 11
  end
  object SpreadBench1Edit: TEdit
    Left = 809
    Top = 71
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 809
    Top = 111
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Text = 'SpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 809
    Top = 327
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 809
    Top = 367
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 809
    Top = 407
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 809
    Top = 151
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 809
    Top = 191
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
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchTestButton: TButton
    Left = 831
    Top = 447
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 19
    OnClick = BenchTestButtonClick
  end
  object ClearButton: TButton
    Left = 456
    Top = 510
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 20
    OnClick = ClearButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 808
    Top = 247
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
    TabOrder = 21
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 808
    Top = 287
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
    TabOrder = 22
    Text = 'AlignSpreadBench2Edit'
  end
  object AlignCheckButton: TButton
    Left = 24
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 23
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 9
    Top = 233
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
    Text = 'AlignCheckEdit'
  end
  object TestCaseButton: TButton
    Left = 24
    Top = 340
    Width = 75
    Height = 25
    Hint = 
      'Functions based on UpperCase and LowerCase must perform identica' +
      'lly'
    Caption = 'Test Case'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    OnClick = TestCaseButtonClick
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 57
    Top = 504
  end
end
