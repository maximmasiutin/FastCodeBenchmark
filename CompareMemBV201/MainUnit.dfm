object MainForm: TMainForm
  Left = 81
  Top = 79
  Caption = 
    'CompareMem Benchmark & Validation Tool for Fastcode Version 2.0.' +
    '1'
  ClientHeight = 580
  ClientWidth = 1064
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
    Left = 935
    Top = 56
    Width = 71
    Height = 13
    Caption = 'SpreadBench1'
  end
  object Label4: TLabel
    Left = 935
    Top = 96
    Width = 71
    Height = 13
    Caption = 'SpreadBench2'
  end
  object Label5: TLabel
    Left = 935
    Top = 136
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 935
    Top = 176
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 935
    Top = 384
    Width = 97
    Height = 13
    Caption = 'Alignment Spread[%]'
  end
  object Label8: TLabel
    Left = 935
    Top = 424
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label9: TLabel
    Left = 935
    Top = 464
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label10: TLabel
    Left = 935
    Top = 304
    Width = 94
    Height = 13
    Caption = 'AlignSpreadBench1'
  end
  object Label11: TLabel
    Left = 935
    Top = 344
    Width = 94
    Height = 13
    Caption = 'AlignSpreadBench2'
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
    Left = 967
    Top = 536
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 544
    Top = 56
    Width = 385
    Height = 449
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
    Top = 56
    Width = 402
    Height = 505
    Caption = 'Function Selection'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'CompareMemRTL'
      'CompareMem_DKC_Pas_9_a'
      'CompareMem_DKC_Pas_9_b'
      'CompareMem_DKC_Pas_9_c'
      'CompareMem_DKC_Pas_9_d'
      'CompareMem_DKC_IA32_6_a'
      'CompareMem_DKC_IA32_6_b'
      'CompareMem_DKC_IA32_6_c'
      'CompareMem_DKC_IA32_6_d'
      'CompareMem_DKC_IA32_7_a'
      'CompareMem_DKC_IA32_7_b'
      'CompareMem_DKC_IA32_7_c'
      'CompareMem_DKC_IA32_7_d'
      'CompareMem_DKC_MMX_1_a'
      'CompareMem_DKC_MMX_1_b'
      'CompareMem_DKC_MMX_1_c'
      'CompareMem_DKC_MMX_1_d'
      'CompareMem_DKC_SSE2_1_a'
      'CompareMem_DKC_SSE2_1_b'
      'CompareMem_DKC_SSE2_1_c'
      'CompareMem_DKC_SSE2_1_d'
      'CompareMem_DKC_SSE3_1_a'
      'CompareMem_DKC_SSE3_1_b'
      'CompareMem_DKC_SSE3_1_c'
      'CompareMem_DKC_SSE3_1_d'
      'CompareMem_Sha_Pas_4_a'
      'CompareMem_Sha_Pas_4_b'
      'CompareMem_Sha_Pas_4_c'
      'CompareMem_Sha_Pas_4_d'
      'CompareMem_Sha_IA32_4_a'
      'CompareMem_Sha_IA32_4_b'
      'CompareMem_Sha_IA32_4_c'
      'CompareMem_Sha_IA32_4_d'
      'CompareMem_Sha_IA32_5_a'
      'CompareMem_Sha_IA32_5_b'
      'CompareMem_Sha_IA32_5_c'
      'CompareMem_Sha_IA32_5_d'
      'CompareMem_JOH_IA32_1_a'
      'CompareMem_JOH_IA32_1_b'
      'CompareMem_JOH_IA32_1_c'
      'CompareMem_JOH_IA32_1_d'
      'CompareMem_PLR_IA32_1_a'
      'CompareMem_PLR_IA32_1_b'
      'CompareMem_PLR_IA32_1_c'
      'CompareMem_PLR_IA32_1_d'
      'CompareMem_PLR_IA32_2_a'
      'CompareMem_PLR_IA32_2_b'
      'CompareMem_PLR_IA32_2_c'
      'CompareMem_PLR_IA32_2_d'
      'CompareMem_PLR_IA32_3_a'
      'CompareMem_PLR_IA32_3_b'
      'CompareMem_PLR_IA32_3_c'
      'CompareMem_PLR_IA32_3_d'
      'CompareMem_DKC_SSE2_2_a'
      'CompareMem_DKC_SSE2_2_b'
      'CompareMem_DKC_SSE2_2_c'
      'CompareMem_DKC_SSE2_2_d'
      'CompareMem_DKC_SSE2_3_a'
      'CompareMem_DKC_SSE2_3_b'
      'CompareMem_DKC_SSE2_3_c'
      'CompareMem_DKC_SSE2_3_d'
      'CompareMem_DKC_SSE2_4_a'
      'CompareMem_DKC_SSE2_4_b'
      'CompareMem_DKC_SSE2_4_c'
      'CompareMem_DKC_SSE2_4_d'
      'CompareMem_DKC_SSE2_5_a'
      'CompareMem_DKC_SSE2_5_b'
      'CompareMem_DKC_SSE2_5_c'
      'CompareMem_DKC_SSE2_5_d'
      'CompareMem_DKC_SSE2_6_a'
      'CompareMem_DKC_SSE2_6_b'
      'CompareMem_DKC_SSE2_6_c'
      'CompareMem_DKC_SSE2_6_d'
      'CompareMem_DKC_SSE2_7_a'
      'CompareMem_DKC_SSE2_7_b'
      'CompareMem_DKC_SSE2_7_c'
      'CompareMem_DKC_SSE2_7_d'
      'CompareMem_DKC_SSE2_8_a'
      'CompareMem_DKC_SSE2_8_b'
      'CompareMem_DKC_SSE2_8_c'
      'CompareMem_DKC_SSE2_8_d'
      'CompareMem_DKC_SSE2_9_a'
      'CompareMem_DKC_SSE2_9_b'
      'CompareMem_DKC_SSE2_9_c'
      'CompareMem_DKC_SSE2_9_d'
      'CompareMem_DKC_SSE2_10_a'
      'CompareMem_DKC_SSE2_10_b'
      'CompareMem_DKC_SSE2_10_c'
      'CompareMem_DKC_SSE2_10_d'
      'CompareMem_DKC_SSE2_11_a'
      'CompareMem_DKC_SSE2_11_b'
      'CompareMem_DKC_SSE2_11_c'
      'CompareMem_DKC_SSE2_11_d'
      'CompareMem_DKC_SSE3_2_a'
      'CompareMem_DKC_SSE3_2_b'
      'CompareMem_DKC_SSE3_2_c'
      'CompareMem_DKC_SSE3_2_d'
      'CompareMem_DKC_SSE2_12_a'
      'CompareMem_DKC_SSE2_12_b'
      'CompareMem_DKC_SSE2_12_c'
      'CompareMem_DKC_SSE2_12_d')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 768
    Top = 520
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object SpreadBench1Edit: TEdit
    Left = 935
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
    Left = 935
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
    Left = 648
    Top = 520
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 552
    Top = 520
    Width = 75
    Height = 17
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 935
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
    Left = 935
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
    Width = 1064
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
    object SpeedButton1: TSpeedButton
      Left = 795
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
      OnClick = SpeedButton1Click
    end
  end
  object BenchTestButton: TButton
    Left = 959
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object AlignFunctionName1Edit: TEdit
    Left = 935
    Top = 440
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
    Left = 935
    Top = 480
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
    Left = 935
    Top = 400
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
    Left = 959
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 552
    Top = 544
    Width = 75
    Height = 17
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnClick = CleanResultsButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 935
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
    ReadOnly = True
    TabOrder = 21
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 935
    Top = 360
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
  object Edit1: TEdit
    Left = 16
    Top = 328
    Width = 121
    Height = 21
    TabOrder = 23
    Text = 'Edit1'
    Visible = False
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 24
    Top = 296
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 24
  end
  object AlignCheckButton: TButton
    Left = 32
    Top = 398
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 25
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 8
    Top = 360
    Width = 121
    Height = 21
    TabOrder = 26
    Text = 'AlignCheckEdit'
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 248
  end
end
