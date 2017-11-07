object MainForm: TMainForm
  Left = 663
  Top = 82
  Caption = 'Ceil32 B & V Tool for Fastcode version 1.4.1'
  ClientHeight = 548
  ClientWidth = 871
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clInfoText
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
    Left = 415
    Top = 47
    Width = 32
    Height = 13
    Caption = 'Report'
  end
  object Label6: TLabel
    Left = 741
    Top = 46
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label7: TLabel
    Left = 741
    Top = 86
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label8: TLabel
    Left = 741
    Top = 126
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label9: TLabel
    Left = 741
    Top = 174
    Width = 108
    Height = 13
    Caption = 'Max Spread Bench [%]'
  end
  object FunctionExtendedSelectionRadioGroup: TRadioGroup
    Left = 159
    Top = 65
    Width = 250
    Height = 120
    Caption = 'Function Extended Selection'
    ItemIndex = 0
    Items.Strings = (
      'Ceil32_RTL'
      'Ceil32_DKC_Pas_1'
      'Ceil32_DKC_Pas_3'
      'Ceil32_DKC_Pas_4'
      'Ceil32_DKC_Pas_5'
      'Ceil32_DKC_IA32_1'
      'Ceil32_PLR_IA32_1'
      'Ceil32_PLR_IA32_2'
      'Ceil32_PLR_PAS_1'
      'Ceil32_JOH_PAS_1'
      'Ceil32_JOH_IA32_1'
      'Ceil32_LBG_PAS_1')
    TabOrder = 2
    OnClick = FunctionExtendedSelectionRadioGroupClick
  end
  object ReportRichEdit: TRichEdit
    Left = 415
    Top = 63
    Width = 320
    Height = 378
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
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 8
    Top = 65
    Width = 145
    Height = 105
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 2
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 4
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object SetRoundModeRadioGroup: TRadioGroup
    Left = 8
    Top = 176
    Width = 145
    Height = 105
    Caption = 'Set Round Mode'
    ItemIndex = 0
    Items.Strings = (
      'rmNearest'
      'rmDown'
      'rmUp'
      'rmTruncate')
    TabOrder = 5
    OnClick = SetRoundModeRadioGroupClick
  end
  object ValidateExtendedButton: TButton
    Left = 16
    Top = 296
    Width = 121
    Height = 25
    Caption = 'Validate Extended'
    TabOrder = 6
    OnClick = ValidateExtendedButtonClick
  end
  object BenchmarkExtendedButton: TButton
    Left = 16
    Top = 403
    Width = 121
    Height = 25
    Caption = 'Benchmark Extended'
    TabOrder = 7
    OnClick = BenchmarkExtendedButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 871
    Height = 41
    Align = alTop
    TabOrder = 8
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
    object PrintSpeedButton: TSpeedButton
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
      OnClick = PrintSpeedButtonClick
    end
    object AboutSpeedButton: TSpeedButton
      Left = 720
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
  object CloseBitBtn: TBitBtn
    Left = 787
    Top = 466
    Width = 75
    Height = 25
    TabOrder = 9
    Kind = bkClose
  end
  object FunctionDoubleSelectionRadioGroup: TRadioGroup
    Left = 159
    Top = 192
    Width = 250
    Height = 140
    Caption = 'Function Double Selection'
    ItemIndex = 0
    Items.Strings = (
      'Ceil32_DKC_Pas_1'
      'Ceil32_DKC_Pas_3'
      'Ceil32_DKC_Pas_4'
      'Ceil32_DKC_Pas_5'
      'Ceil32_DKC_IA32_1'
      'Ceil32_DKC_SSE2_1'
      'Ceil32_DKC_SSE2_2'
      'Ceil32_DKC_SSE2_3'
      'Ceil32_DKC_SSE2_4'
      'Ceil32_DKC_SSE2_5'
      'Ceil32_PLR_IA32_1'
      'Ceil32_PLR_IA32_2'
      'Ceil32_JOH_PAS_1'
      'Ceil32_JOH_IA32_1')
    TabOrder = 10
    OnClick = FunctionDoubleSelectionRadioGroupClick
  end
  object FunctionSingleSelectionRadioGroup: TRadioGroup
    Left = 159
    Top = 338
    Width = 250
    Height = 159
    Caption = 'Function Single Selection'
    ItemIndex = 0
    Items.Strings = (
      'Ceil32_DKC_Pas_1'
      'Ceil32_DKC_Pas_3'
      'Ceil32_DKC_Pas_4'
      'Ceil32_DKC_Pas_5'
      'Ceil32_DKC_IA32_1'
      'Ceil32_DKC_IA32_2'
      'Ceil32_DKC_IA32_3'
      'Ceil32_DKC_IA32_4'
      'Ceil32_DKC_SSE_1'
      'Ceil32_PLR_IA32_1'
      'Ceil32_PLR_IA32_2'
      'Ceil32_JOH_PAS_1'
      'Ceil32_JOH_IA32_1'
      'Ceil32_LBG_PAS_1')
    TabOrder = 11
    OnClick = FunctionSingleSelectionRadioGroupClick
  end
  object ValidateAllButton: TButton
    Left = 543
    Top = 456
    Width = 88
    Height = 33
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 648
    Top = 456
    Width = 89
    Height = 33
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object BenchmarkDoubleButton: TButton
    Left = 16
    Top = 435
    Width = 121
    Height = 25
    Caption = 'Benchmark Double'
    TabOrder = 12
    OnClick = BenchmarkDoubleButtonClick
  end
  object BenchmarkSingleButton: TButton
    Left = 16
    Top = 467
    Width = 121
    Height = 25
    Caption = 'Benchmark Single'
    TabOrder = 13
    OnClick = BenchmarkSingleButtonClick
  end
  object ValidateDoubleButton: TButton
    Left = 16
    Top = 328
    Width = 121
    Height = 25
    Caption = 'Validate Double'
    TabOrder = 14
    OnClick = ValidateDoubleButtonClick
  end
  object ValidateSingleButton: TButton
    Left = 16
    Top = 360
    Width = 121
    Height = 25
    Caption = 'Validate Single'
    TabOrder = 15
    OnClick = ValidateSingleButtonClick
  end
  object ClearButton: TButton
    Left = 454
    Top = 463
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 16
    OnClick = ClearButtonClick
  end
  object Bench1Edit: TEdit
    Left = 741
    Top = 62
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
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 741
    Top = 99
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
    Text = 'Bench2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 741
    Top = 145
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
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 741
    Top = 193
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
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchmarkTestButton: TButton
    Left = 760
    Top = 239
    Width = 89
    Height = 25
    Caption = 'Benchmark Test'
    TabOrder = 21
    OnClick = BenchmarkTestButtonClick
  end
  object IEdit: TEdit
    Left = 159
    Top = 461
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
    Text = 'IEdit'
    Visible = False
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 744
    Top = 288
    Width = 121
    Height = 17
    Caption = 'Show Error Dialog'
    TabOrder = 23
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 774
    Top = 399
  end
end
