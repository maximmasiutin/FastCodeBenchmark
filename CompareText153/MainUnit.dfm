object MainForm: TMainForm
  Left = 80
  Top = 75
  Caption = 'CompareText B&V for Fastcode Version 1.5.3'
  ClientHeight = 657
  ClientWidth = 888
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
    Width = 23
    Height = 13
    Caption = 'Valid'
  end
  object Label2: TLabel
    Left = 8
    Top = 136
    Width = 87
    Height = 13
    Caption = 'Benchmark Result'
  end
  object Label3: TLabel
    Left = 328
    Top = 56
    Width = 41
    Height = 13
    Caption = 'Function'
  end
  object Label4: TLabel
    Left = 544
    Top = 56
    Width = 28
    Height = 13
    Caption = 'Sub 1'
  end
  object Label5: TLabel
    Left = 584
    Top = 56
    Width = 28
    Height = 13
    Caption = 'Sub 2'
  end
  object Label6: TLabel
    Left = 624
    Top = 56
    Width = 28
    Height = 13
    Caption = 'Sub 3'
  end
  object Label7: TLabel
    Left = 680
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label9: TLabel
    Left = 504
    Top = 56
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label10: TLabel
    Left = 8
    Top = 216
    Width = 54
    Height = 13
    Caption = 'Max Bench'
  end
  object Label11: TLabel
    Left = 8
    Top = 256
    Width = 51
    Height = 13
    Caption = 'Min Bench'
  end
  object Label12: TLabel
    Left = 8
    Top = 296
    Width = 51
    Height = 13
    Caption = 'Spread [%]'
  end
  object Label8: TLabel
    Left = 760
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label13: TLabel
    Left = 760
    Top = 96
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label14: TLabel
    Left = 760
    Top = 240
    Width = 106
    Height = 13
    Caption = 'Alignment Max Spread'
  end
  object Label15: TLabel
    Left = 760
    Top = 280
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label16: TLabel
    Left = 760
    Top = 320
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label17: TLabel
    Left = 760
    Top = 136
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label18: TLabel
    Left = 760
    Top = 176
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object ValidateButton: TButton
    Left = 24
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
    OnClick = ValidateButtonClick
  end
  object ValidEdit: TEdit
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
    TabOrder = 5
    Text = 'ValidEdit'
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 136
    Top = 72
    Width = 185
    Height = 561
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'CompareText_RTL_IA32_a'
      'CompareText_RTL_IA32_b'
      'CompareText_RTL_IA32_c'
      'CompareText_RTL_IA32_d'
      'CompareText_JOH_PAS_1_a'
      'CompareText_JOH_PAS_1_b'
      'CompareText_JOH_PAS_1_c'
      'CompareText_JOH_PAS_1_d'
      'CompareText_DKC_Pas_13_a'
      'CompareText_DKC_Pas_13_b'
      'CompareText_DKC_Pas_13_c'
      'CompareText_DKC_Pas_13_d'
      'CompareText_DKC_IA32_11_a'
      'CompareText_DKC_IA32_11_b'
      'CompareText_DKC_IA32_11_c'
      'CompareText_DKC_IA32_11_d'
      'CompareText_DKC_IA32_12_a'
      'CompareText_DKC_IA32_12_b'
      'CompareText_DKC_IA32_12_c'
      'CompareText_DKC_IA32_12_d'
      'CompareText_JOH_IA32_5_a'
      'CompareText_JOH_IA32_5_b'
      'CompareText_JOH_IA32_5_c'
      'CompareText_JOH_IA32_5_d'
      'CompareText_JOH_IA32_6_a'
      'CompareText_JOH_IA32_6_b'
      'CompareText_JOH_IA32_6_c'
      'CompareText_JOH_IA32_6_d'
      'CompareText_Sha_IA32_3_a'
      'CompareText_Sha_IA32_3_b'
      'CompareText_Sha_IA32_3_c'
      'CompareText_Sha_IA32_3_d'
      'CompareText_Sha_IA32_4_a'
      'CompareText_Sha_IA32_4_b'
      'CompareText_Sha_IA32_4_c'
      'CompareText_Sha_IA32_4_d'
      'CompareText_Sha_Pas_5_a'
      'CompareText_Sha_Pas_5_b'
      'CompareText_Sha_Pas_5_c'
      'CompareText_Sha_Pas_5_d'
      'CompareText_DKC_Pas_17_a'
      'CompareText_DKC_Pas_17_b'
      'CompareText_DKC_Pas_17_c'
      'CompareText_DKC_Pas_17_d'
      'CompareText_DKC_Pas_18_a'
      'CompareText_DKC_Pas_18_b'
      'CompareText_DKC_Pas_18_c'
      'CompareText_DKC_Pas_18_d'
      'CompareText_DKC_Pas_19_a'
      'CompareText_DKC_Pas_19_b'
      'CompareText_DKC_Pas_19_c'
      'CompareText_DKC_Pas_19_d'
      'CompareText_DKC_Pas_20_a'
      'CompareText_DKC_Pas_20_b'
      'CompareText_DKC_Pas_20_c'
      'CompareText_DKC_Pas_20_d'
      'CompareText_DKC_Pas_21_a'
      'CompareText_DKC_Pas_21_b'
      'CompareText_DKC_Pas_21_c'
      'CompareText_DKC_Pas_21_d')
    TabOrder = 6
    OnClick = FunctionSelectionRadioGroupClick
  end
  object CloseBitBtn: TBitBtn
    Left = 792
    Top = 600
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object BenchmarkButton: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
    OnClick = BenchmarkButtonClick
  end
  object BenchEdit: TEdit
    Left = 8
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
    TabOrder = 8
    Text = 'BenchEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 41
    Align = alTop
    TabOrder = 9
    object SaveReportSpeedButton: TSpeedButton
      Left = 24
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
    object PrintSpeedButton: TSpeedButton
      Left = 56
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
      OnClick = PrintSpeedButtonClick
    end
    object AboutSpeedButton: TSpeedButton
      Left = 88
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
    Top = 72
    Width = 425
    Height = 497
    TabStop = False
    Color = clInfoBk
    Lines.Strings = (
      'ReportRichEdit')
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 10
  end
  object BenchmarkAllButton: TButton
    Left = 600
    Top = 584
    Width = 113
    Height = 57
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateAllButton: TButton
    Left = 456
    Top = 584
    Width = 121
    Height = 57
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object J2Edit: TEdit
    Left = 8
    Top = 568
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 11
    Text = 'J2Edit'
    Visible = False
  end
  object J3Edit: TEdit
    Left = 8
    Top = 592
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 12
    Text = 'J3Edit'
    Visible = False
  end
  object ClearButton: TButton
    Left = 344
    Top = 584
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object SpreadTestButton: TButton
    Left = 24
    Top = 344
    Width = 75
    Height = 25
    Hint = 'Tests stability of benchmark'
    Caption = 'Spread Test'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = SpreadTestButtonClick
  end
  object MaxBenchEdit: TEdit
    Left = 8
    Top = 232
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
    TabOrder = 14
    Text = 'MaxBenchEdit'
  end
  object MinBenchEdit: TEdit
    Left = 8
    Top = 272
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
    TabOrder = 15
    Text = 'MinBenchEdit'
  end
  object SpreadBenchPercentageEdit: TEdit
    Left = 8
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
    TabOrder = 16
    Text = 'SpreadBenchPercentageEdit'
    OnClick = SpreadBenchPercentageEditClick
  end
  object J1Edit: TEdit
    Left = 8
    Top = 544
    Width = 121
    Height = 21
    TabStop = False
    Color = clSkyBlue
    TabOrder = 17
    Text = 'J1Edit'
    Visible = False
  end
  object Bench1Edit: TEdit
    Left = 760
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
    TabOrder = 18
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 760
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
    TabOrder = 19
    Text = 'Bench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 760
    Top = 256
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 20
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 760
    Top = 296
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 760
    Top = 336
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
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 760
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
    TabOrder = 23
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 760
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
    TabOrder = 24
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchTestButton: TButton
    Left = 784
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 25
    OnClick = BenchTestButtonClick
  end
  object CleanButton: TButton
    Left = 344
    Top = 616
    Width = 75
    Height = 25
    Caption = 'Clean'
    TabOrder = 26
    OnClick = CleanButtonClick
  end
  object AlignCheckButton: TButton
    Left = 24
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 27
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 8
    Top = 384
    Width = 121
    Height = 21
    Color = clInfoBk
    TabOrder = 28
    Text = 'AlignCheckEdit'
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 104
    Top = 112
  end
end
