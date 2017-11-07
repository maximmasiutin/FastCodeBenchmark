object MainForm: TMainForm
  Left = 167
  Top = 102
  Caption = 'PosEx Benchmark & Validation for Fastcode Version 1.6.4'
  ClientHeight = 620
  ClientWidth = 1000
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
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 82
    Height = 13
    Caption = 'Function Address'
  end
  object Label3: TLabel
    Left = 600
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label4: TLabel
    Left = 664
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench2'
  end
  object Label5: TLabel
    Left = 752
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label6: TLabel
    Left = 560
    Top = 56
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label7: TLabel
    Left = 456
    Top = 56
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label8: TLabel
    Left = 872
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label13: TLabel
    Left = 872
    Top = 96
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label14: TLabel
    Left = 872
    Top = 312
    Width = 106
    Height = 13
    Caption = 'Alignment Max Spread'
  end
  object Label15: TLabel
    Left = 872
    Top = 352
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label16: TLabel
    Left = 872
    Top = 392
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label17: TLabel
    Left = 872
    Top = 136
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label18: TLabel
    Left = 872
    Top = 176
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label1: TLabel
    Left = 872
    Top = 232
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label9: TLabel
    Left = 872
    Top = 272
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object CloseBitBtn: TBitBtn
    Left = 912
    Top = 544
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 448
    Top = 72
    Width = 409
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
    Left = 736
    Top = 512
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
    Caption = 'r'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'PosEx_RTLFixed'
      'PosEx_JOH_IA32_6_a'
      'PosEx_JOH_IA32_6_b'
      'PosEx_JOH_IA32_6_c'
      'PosEx_JOH_IA32_6_d'
      'PosEx_Sha_Pas_2_a'
      'PosEx_Sha_Pas_2_b'
      'PosEx_Sha_Pas_2_c'
      'PosEx_Sha_Pas_2_d'
      'PosEx_Sha_IA32_3_a'
      'PosEx_Sha_IA32_3_b'
      'PosEx_Sha_IA32_3_c'
      'PosEx_Sha_IA32_3_d'
      'PosEx_Sha_IA32_4_a'
      'PosEx_Sha_IA32_4_b'
      'PosEx_Sha_IA32_4_c'
      'PosEx_Sha_IA32_4_d'
      'PosEx_EWC_IA32_1_a'
      'PosEx_EWC_IA32_1_b'
      'PosEx_EWC_IA32_1_c'
      'PosEx_EWC_IA32_1_d'
      'PosEx_EWC_IA32_2_a'
      'PosEx_EWC_IA32_2_b'
      'PosEx_EWC_IA32_2_c'
      'PosEx_EWC_IA32_2_d'
      'PosEx_EWC_IA32_3_a'
      'PosEx_EWC_IA32_3_b'
      'PosEx_EWC_IA32_3_c'
      'PosEx_EWC_IA32_3_d'
      'PosEx_AZ_Pas_1_a'
      'PosEx_AZ_Pas_1_b'
      'PosEx_AZ_Pas_1_c'
      'PosEx_AZ_Pas_1_d'
      'PosEx_AZ_Pas_2_a'
      'PosEx_AZ_Pas_2_b'
      'PosEx_AZ_Pas_2_c'
      'PosEx_AZ_Pas_2_d'
      'PosEx_AZ_IA32_1_a'
      'PosEx_AZ_IA32_1_b'
      'PosEx_AZ_IA32_1_c'
      'PosEx_AZ_IA32_1_d'
      'PosEx_AZ_IA32_2_a'
      'PosEx_AZ_IA32_2_b'
      'PosEx_AZ_IA32_2_c'
      'PosEx_AZ_IA32_2_d'
      'PosEx_AZ_SSE_1_a'
      'PosEx_AZ_SSE_1_b'
      'PosEx_AZ_SSE_1_c'
      'PosEx_AZ_SSE_1_d'
      'PosEx_AZ_SSE2_1_a'
      'PosEx_AZ_SSE2_1_b'
      'PosEx_AZ_SSE2_1_c'
      'PosEx_AZ_SSE2_1_d'
      'PosEx_DKC_Pas_5_a'
      'PosEx_DKC_Pas_5_b'
      'PosEx_DKC_Pas_5_c'
      'PosEx_DKC_Pas_5_d'
      'PosEx_DKC_IA32_60_a'
      'PosEx_DKC_IA32_60_b'
      'PosEx_DKC_IA32_60_c'
      'PosEx_DKC_IA32_60_d'
      'PosEx_DKC_IA32_61_a'
      'PosEx_DKC_IA32_61_b'
      'PosEx_DKC_IA32_61_c'
      'PosEx_DKC_IA32_61_d'
      'PosEx_DKC_IA32_62_a'
      'PosEx_DKC_IA32_62_b'
      'PosEx_DKC_IA32_62_c'
      'PosEx_DKC_IA32_62_d'
      'PosEx_DKC_IA32_63_a'
      'PosEx_DKC_IA32_63_b'
      'PosEx_DKC_IA32_63_c'
      'PosEx_DKC_IA32_63_d'
      'PosEx_JOH_IA32_7_a'
      'PosEx_JOH_IA32_7_b'
      'PosEx_JOH_IA32_7_c'
      'PosEx_JOH_IA32_7_d'
      'PosEx_JOH_IA32_8_a'
      'PosEx_JOH_IA32_8_b'
      'PosEx_JOH_IA32_8_c'
      'PosEx_JOH_IA32_8_d')
    ParentFont = False
    TabOrder = 5
    OnClick = FunctionSelectionRadioGroupClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 603
    Width = 1000
    Height = 17
    Align = alBottom
    TabOrder = 6
  end
  object AddressEdit: TEdit
    Left = 8
    Top = 275
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
    TabOrder = 7
    Text = 'AddressEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 49
    Align = alTop
    TabOrder = 8
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
  end
  object ValidateAllButton: TButton
    Left = 616
    Top = 512
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
    Left = 8
    Top = 304
    Width = 121
    Height = 21
    TabOrder = 9
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
    TabOrder = 10
    OnClick = ValidateButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 584
    Width = 1000
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 8
    Top = 200
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 12
  end
  object SpreadBench1Edit: TEdit
    Left = 873
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
    TabOrder = 13
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 873
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
    TabOrder = 14
    Text = 'SpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 873
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
    TabOrder = 15
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 873
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
    TabOrder = 16
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 873
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
    TabOrder = 17
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 873
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
    TabOrder = 18
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 873
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
    TabOrder = 19
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchTestButton: TButton
    Left = 895
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 20
    OnClick = BenchTestButtonClick
  end
  object ClearButton: TButton
    Left = 456
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 21
    OnClick = ClearButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 872
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
    TabOrder = 22
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 872
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
    TabOrder = 23
    Text = 'AlignSpreadBench2Edit'
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 56
    Top = 320
  end
end
