object MainForm: TMainForm
  Left = 86
  Top = 80
  Caption = 'StrLen Benchmark & Validation for Fastcode Version 1.3.2'
  ClientHeight = 686
  ClientWidth = 992
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
    Left = 616
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label4: TLabel
    Left = 680
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench2'
  end
  object Label5: TLabel
    Left = 768
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label6: TLabel
    Left = 576
    Top = 56
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label7: TLabel
    Left = 463
    Top = 55
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label8: TLabel
    Left = 824
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label13: TLabel
    Left = 824
    Top = 96
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label14: TLabel
    Left = 824
    Top = 312
    Width = 106
    Height = 13
    Caption = 'Alignment Max Spread'
  end
  object Label15: TLabel
    Left = 824
    Top = 352
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label16: TLabel
    Left = 824
    Top = 392
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label17: TLabel
    Left = 824
    Top = 136
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label18: TLabel
    Left = 824
    Top = 176
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label1: TLabel
    Left = 824
    Top = 232
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label9: TLabel
    Left = 824
    Top = 272
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label2: TLabel
    Left = 8
    Top = 304
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object CloseBitBtn: TBitBtn
    Left = 870
    Top = 616
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 464
    Top = 72
    Width = 353
    Height = 505
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
    Left = 686
    Top = 592
    Width = 121
    Height = 49
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = RunAllBenchmarksButtonClick
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 136
    Top = 64
    Width = 321
    Height = 593
    Caption = 'Function Selection'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'StrLen_RTL'
      'StrLen_DKC_Pas_6_a'
      'StrLen_DKC_Pas_6_b'
      'StrLen_DKC_Pas_6_c'
      'StrLen_DKC_Pas_6_d'
      'StrLen_DKC_IA32_1_a'
      'StrLen_DKC_IA32_1_b'
      'StrLen_DKC_IA32_1_c'
      'StrLen_DKC_IA32_1_d'
      'StrLen_DKC_IA32_2_a'
      'StrLen_DKC_IA32_2_b'
      'StrLen_DKC_IA32_2_c'
      'StrLen_DKC_IA32_2_d'
      'StrLen_DKC_IA32_3_a'
      'StrLen_DKC_IA32_3_b'
      'StrLen_DKC_IA32_3_c'
      'StrLen_DKC_IA32_3_d'
      'StrLen_DKC_IA32_4_a'
      'StrLen_DKC_IA32_4_b'
      'StrLen_DKC_IA32_4_c'
      'StrLen_DKC_IA32_4_d'
      'StrLen_DKC_IA32_5_a'
      'StrLen_DKC_IA32_5_b'
      'StrLen_DKC_IA32_5_c'
      'StrLen_DKC_IA32_5_d'
      'StrLen_DKC_IA32_6_a'
      'StrLen_DKC_IA32_6_b'
      'StrLen_DKC_IA32_6_c'
      'StrLen_DKC_IA32_6_d'
      'StrLen_DKC_IA32_7_a'
      'StrLen_DKC_IA32_7_b'
      'StrLen_DKC_IA32_7_c'
      'StrLen_DKC_IA32_7_d'
      'StrLen_DKC_IA32_8_a'
      'StrLen_DKC_IA32_8_b'
      'StrLen_DKC_IA32_8_c'
      'StrLen_DKC_IA32_8_d'
      'StrLen_DKC_IA32_9_a'
      'StrLen_DKC_IA32_9_b'
      'StrLen_DKC_IA32_9_c'
      'StrLen_DKC_IA32_9_d'
      'StrLen_DKC_IA32_10_a'
      'StrLen_DKC_IA32_10_b'
      'StrLen_DKC_IA32_10_c'
      'StrLen_DKC_IA32_10_d'
      'StrLen_DKC_IA32_18_a'
      'StrLen_DKC_IA32_18_b'
      'StrLen_DKC_IA32_18_c'
      'StrLen_DKC_IA32_18_d'
      'StrLen_DKC_MMX_8_a'
      'StrLen_DKC_MMX_8_b'
      'StrLen_DKC_MMX_8_c'
      'StrLen_DKC_MMX_8_d'
      'StrLen_DKC_MMX_9_a'
      'StrLen_DKC_MMX_9_b'
      'StrLen_DKC_MMX_9_c'
      'StrLen_DKC_MMX_9_d'
      'StrLen_DKC_SSE2_1_a'
      'StrLen_DKC_SSE2_1_b'
      'StrLen_DKC_SSE2_1_c'
      'StrLen_DKC_SSE2_1_d'
      'StrLen_DKC_SSE2_4_a'
      'StrLen_DKC_SSE2_4_b'
      'StrLen_DKC_SSE2_4_c'
      'StrLen_DKC_SSE2_4_d'
      'StrLen_DKC_SSE2_5_a'
      'StrLen_DKC_SSE2_5_b'
      'StrLen_DKC_SSE2_5_c'
      'StrLen_DKC_SSE2_5_d'
      'StrLen_JOH_PAS_1_a'
      'StrLen_JOH_PAS_1_b'
      'StrLen_JOH_PAS_1_c'
      'StrLen_JOH_PAS_1_d'
      'StrLen_JOH_PAS_3_a'
      'StrLen_JOH_PAS_3_b'
      'StrLen_JOH_PAS_3_c'
      'StrLen_JOH_PAS_3_d'
      'StrLen_JOH_IA32_1_a'
      'StrLen_JOH_IA32_1_b'
      'StrLen_JOH_IA32_1_c'
      'StrLen_JOH_IA32_1_d'
      'StrLen_JOH_IA32_2_a'
      'StrLen_JOH_IA32_2_b'
      'StrLen_JOH_IA32_2_c'
      'StrLen_JOH_IA32_2_d'
      'StrLen_JOH_IA32_7_a'
      'StrLen_JOH_IA32_7_b'
      'StrLen_JOH_IA32_7_c'
      'StrLen_JOH_IA32_7_d'
      'StrLen_JOH_SSE2_1_a'
      'StrLen_JOH_SSE2_1_b'
      'StrLen_JOH_SSE2_1_c'
      'StrLen_JOH_SSE2_1_d'
      'StrLen_LBG_PAS_1_a'
      'StrLen_LBG_PAS_1_b'
      'StrLen_LBG_PAS_1_c'
      'StrLen_LBG_PAS_1_d'
      'StrLen_LBG_IA32_1_a'
      'StrLen_LBG_IA32_1_b'
      'StrLen_LBG_IA32_1_c'
      'StrLen_LBG_IA32_1_d'
      'StrLen_LBG_IA32_2_a'
      'StrLen_LBG_IA32_2_b'
      'StrLen_LBG_IA32_2_c'
      'StrLen_LBG_IA32_2_d'
      'StrLen_LBG_IA32_3_a'
      'StrLen_LBG_IA32_3_b'
      'StrLen_LBG_IA32_3_c'
      'StrLen_LBG_IA32_3_d'
      'StrLen_LBG_IA32_4_a'
      'StrLen_LBG_IA32_4_b'
      'StrLen_LBG_IA32_4_c'
      'StrLen_LBG_IA32_4_d'
      'StrLen_DKC_IA32_19_a'
      'StrLen_DKC_IA32_19_b'
      'StrLen_DKC_IA32_19_c'
      'StrLen_DKC_IA32_19_d'
      'StrLen_PLR_IA32_1_a'
      'StrLen_PLR_IA32_1_b'
      'StrLen_PLR_IA32_1_c'
      'StrLen_PLR_IA32_1_d'
      'StrLen_PLR_IA32_2_a'
      'StrLen_PLR_IA32_2_b'
      'StrLen_PLR_IA32_2_c'
      'StrLen_PLR_IA32_2_d'
      'StrLen_PLR_IA32_3_a'
      'StrLen_PLR_IA32_3_b'
      'StrLen_PLR_IA32_3_c'
      'StrLen_PLR_IA32_3_d'
      'StrLen_JOH_SSE2_2_a'
      'StrLen_JOH_SSE2_2_b'
      'StrLen_JOH_SSE2_2_c'
      'StrLen_JOH_SSE2_2_d')
    ParentFont = False
    TabOrder = 5
    OnClick = FunctionSelectionRadioGroupClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 992
    Height = 49
    Align = alTop
    TabOrder = 6
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
      Left = 728
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
    Left = 566
    Top = 592
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
    TabOrder = 7
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
    TabOrder = 8
    OnClick = ValidateButtonClick
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 16
    Top = 192
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 9
  end
  object SpreadBench1Edit: TEdit
    Left = 825
    Top = 72
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 825
    Top = 112
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Text = 'SpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 825
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
    TabOrder = 12
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 825
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
    TabOrder = 13
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 825
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
    TabOrder = 14
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 825
    Top = 152
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
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 825
    Top = 192
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
    TabOrder = 16
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchTestButton: TButton
    Left = 847
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 17
    OnClick = BenchTestButtonClick
  end
  object ClearButton: TButton
    Left = 478
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 18
    OnClick = ClearButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 824
    Top = 248
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
    TabOrder = 19
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 824
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
    ReadOnly = True
    TabOrder = 20
    Text = 'AlignSpreadBench2Edit'
  end
  object AlignCheckButton: TButton
    Left = 24
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 21
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
    TabOrder = 22
    Text = 'AlignCheckEdit'
  end
  object CleanButton: TButton
    Left = 478
    Top = 624
    Width = 75
    Height = 25
    Caption = 'Clean'
    TabOrder = 23
    OnClick = CleanButtonClick
  end
  object RunTimeEdit: TEdit
    Left = 8
    Top = 320
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
    Text = 'RunTimeEdit'
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 57
    Top = 504
  end
end
