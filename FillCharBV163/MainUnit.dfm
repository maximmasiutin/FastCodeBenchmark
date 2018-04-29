object MainForm: TMainForm
  Left = 182
  Top = 110
  Caption = 'Fastcode FillChar B & V Tool Version 1.6.3'
  ClientHeight = 689
  ClientWidth = 892
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 96
    Width = 22
    Height = 13
    Caption = 'Error'
  end
  object Label2: TLabel
    Left = 16
    Top = 176
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Bench1Label: TLabel
    Left = 16
    Top = 256
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label4: TLabel
    Left = 16
    Top = 296
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label5: TLabel
    Left = 16
    Top = 336
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 16
    Top = 376
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label3: TLabel
    Left = 16
    Top = 432
    Width = 139
    Height = 13
    Caption = 'Spread due to codealignment'
  end
  object Label7: TLabel
    Left = 16
    Top = 472
    Width = 76
    Height = 13
    Caption = 'Functionname 1'
  end
  object Label8: TLabel
    Left = 16
    Top = 512
    Width = 76
    Height = 13
    Caption = 'Functionname 2'
  end
  object DevelopButton: TButton
    Left = 32
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Develop'
    TabOrder = 3
    OnClick = DevelopButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 892
    Height = 41
    Align = alTop
    TabOrder = 4
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
  end
  object CloseBitBtn: TBitBtn
    Left = 808
    Top = 656
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 5
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 56
    Width = 321
    Height = 625
    Caption = 'Function Selection'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'FillChar_RTL_IA32_1'
      'FillChar_RTL_Pas_1'
      'FillChar_JOH_PAS_1_a'
      'FillChar_JOH_PAS_1_b'
      'FillChar_JOH_PAS_1_c'
      'FillChar_JOH_PAS_1_d'
      'FillChar_JOH_IA32_1_a'
      'FillChar_JOH_IA32_1_b'
      'FillChar_JOH_IA32_1_c'
      'FillChar_JOH_IA32_1_d'
      'FillChar_PLR_IA32_3_a'
      'FillChar_PLR_IA32_3_b'
      'FillChar_PLR_IA32_3_c'
      'FillChar_PLR_IA32_3_d'
      'FillChar_PLR_IA32_4_a'
      'FillChar_PLR_IA32_4_b'
      'FillChar_PLR_IA32_4_c'
      'FillChar_PLR_IA32_4_d'
      'FillChar_PLR_MMX_1_a'
      'FillChar_PLR_MMX_1_b'
      'FillChar_PLR_MMX_1_c'
      'FillChar_PLR_MMX_1_d'
      'FillChar_DKC_Pas_24_a'
      'FillChar_JOH_MMX_1_a'
      'FillChar_JOH_MMX_1_b'
      'FillChar_JOH_MMX_1_c'
      'FillChar_JOH_MMX_1_d'
      'FillChar_JOH_SSE2_1_a'
      'FillChar_JOH_SSE2_1_b'
      'FillChar_JOH_SSE2_1_c'
      'FillChar_JOH_SSE2_1_d'
      'FillChar_DKC_MMX_11_a'
      'FillChar_DKC_MMX_11_b'
      'FillChar_DKC_MMX_11_c'
      'FillChar_DKC_MMX_11_d'
      'FillChar_JOH_IA32_3_a'
      'FillChar_JOH_IA32_3_b'
      'FillChar_JOH_IA32_3_c'
      'FillChar_JOH_IA32_3_d'
      'FillChar_DKC_IA32_20_a'
      'FillChar_DKC_IA32_20_b'
      'FillChar_DKC_IA32_20_c'
      'FillChar_DKC_IA32_20_d'
      'FillChar_JOH_IA32_2_a'
      'FillChar_JOH_IA32_2_b'
      'FillChar_JOH_IA32_2_c'
      'FillChar_JOH_IA32_2_d'
      'FillChar_DKC_SSE_9_a'
      'FillChar_DKC_SSE_9_b'
      'FillChar_DKC_SSE_9_c'
      'FillChar_DKC_SSE_9_d'
      'FillChar_JOH_SSE_1_a'
      'FillChar_JOH_SSE_1_b'
      'FillChar_JOH_SSE_1_c'
      'FillChar_JOH_SSE_1_d'
      'FillChar_DKC_SSE_14_a'
      'FillChar_DKC_SSE_14_b'
      'FillChar_DKC_SSE_14_c'
      'FillChar_DKC_SSE_14_d'
      'FillChar_DKC_SSE2_11_a'
      'FillChar_DKC_SSE2_11_b'
      'FillChar_DKC_SSE2_11_c'
      'FillChar_DKC_SSE2_11_d'
      'FillChar_CJG_Pas_5_a'
      'FillChar_CJG_Pas_5_b'
      'FillChar_CJG_Pas_5_c'
      'FillChar_CJG_Pas_5_d'
      'FillChar_DKC_SSE2_10_a'
      'FillChar_DKC_SSE2_10_b'
      'FillChar_DKC_SSE2_10_c'
      'FillChar_DKC_SSE2_10_d'
      'FillChar_DKC_MMX_12_a'
      'FillChar_DKC_MMX_12_b'
      'FillChar_DKC_MMX_12_c'
      'FillChar_DKC_MMX_12_d'
      'FillChar_JOH_MMX_4_a'
      'FillChar_JOH_MMX_4_b'
      'FillChar_JOH_MMX_4_c'
      'FillChar_JOH_MMX_4_d'
      'FillChar_DKC_Pas_24_b'
      'FillChar_DKC_Pas_24_c'
      'FillChar_DKC_Pas_24_d')
    TabOrder = 6
    OnClick = FunctionSelectionRadioGroupClick
  end
  object ValidateButton: TButton
    Left = 32
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 7
    OnClick = ValidateButtonClick
  end
  object ErrorEdit: TEdit
    Left = 16
    Top = 112
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 8
    Text = 'ErrorEdit'
  end
  object BenchmarkButton: TButton
    Left = 32
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 2
    OnClick = BenchmarkButtonClick
  end
  object BenchmarkEdit: TEdit
    Left = 16
    Top = 192
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 9
    Text = 'BenchmarkEdit'
    OnClick = BenchmarkEditClick
  end
  object ReportRichEdit: TRichEdit
    Left = 488
    Top = 64
    Width = 393
    Height = 577
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    Lines.Strings = (
      'ReportRichEdit')
    ParentFont = True
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 10
    Zoom = 100
  end
  object BenchmarkAllButton: TButton
    Left = 680
    Top = 648
    Width = 81
    Height = 33
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateAllButton: TButton
    Left = 584
    Top = 648
    Width = 81
    Height = 33
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 496
    Top = 648
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 11
    OnClick = ClearButtonClick
  end
  object Bench1Edit: TEdit
    Left = 16
    Top = 272
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 12
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 16
    Top = 312
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 13
    Text = 'Bench2Edit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 16
    Top = 352
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 14
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object FunctionNameEdit: TEdit
    Left = 16
    Top = 392
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 15
    Text = 'FunctionNameEdit'
  end
  object SpreadTestButton: TButton
    Left = 40
    Top = 560
    Width = 75
    Height = 25
    Caption = 'SpreadTest'
    TabOrder = 16
    OnClick = SpreadTestButtonClick
  end
  object BenchTestButton: TButton
    Left = 40
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 17
    OnClick = BenchTestButtonClick
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 16
    Top = 448
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 18
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 16
    Top = 488
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 19
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 16
    Top = 528
    Width = 121
    Height = 21
    TabStop = False
    Color = clInfoBk
    ParentFont = True
    ReadOnly = True
    TabOrder = 20
    Text = 'AlignFunctionName2Edit'
  end
  object Clean: TButton
    Left = 40
    Top = 624
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result.'
    Caption = 'Clean'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    OnClick = CleanClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 120
    Top = 64
  end
end
