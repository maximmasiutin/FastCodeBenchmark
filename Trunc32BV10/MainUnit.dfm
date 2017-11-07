object MainForm: TMainForm
  Left = 242
  Top = 110
  Width = 698
  Height = 597
  Caption = 'Trunc32 Benchmark & Validation for Fastcode Version 1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 56
    Width = 7
    Height = 13
    Caption = 'X'
  end
  object Label2: TLabel
    Left = 24
    Top = 96
    Width = 3
    Height = 13
    Caption = 'I'
  end
  object Label3: TLabel
    Left = 384
    Top = 48
    Width = 32
    Height = 13
    Caption = 'Report'
  end
  object Label4: TLabel
    Left = 176
    Top = 408
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label5: TLabel
    Left = 32
    Top = 408
    Width = 22
    Height = 13
    Caption = 'Error'
  end
  object DevelopButton: TButton
    Left = 48
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Develop'
    TabOrder = 2
    OnClick = DevelopButtonClick
  end
  object FunctionExtendedSelectionRadioGroup: TRadioGroup
    Left = 184
    Top = 64
    Width = 185
    Height = 105
    Caption = 'Function Extended Selection'
    ItemIndex = 0
    Items.Strings = (
      'Trunc32ExtendedDKC1'
      'Trunc32ExtendedJOH'
      'Trunc32ExtendedDFLSSE3_1')
    TabOrder = 3
    OnClick = FunctionExtendedSelectionRadioGroupClick
  end
  object ReportRichEdit: TRichEdit
    Left = 384
    Top = 64
    Width = 297
    Height = 329
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
    TabOrder = 4
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 24
    Top = 176
    Width = 145
    Height = 105
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 2
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 5
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object SetRoundModeRadioGroup: TRadioGroup
    Left = 24
    Top = 288
    Width = 145
    Height = 105
    Caption = 'Set Round Mode'
    ItemIndex = 0
    Items.Strings = (
      'rmNearest'
      'rmDown'
      'rmUp'
      'rmTruncate')
    TabOrder = 6
    OnClick = SetRoundModeRadioGroupClick
  end
  object IEdit: TEdit
    Left = 24
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
    TabOrder = 7
    Text = 'IEdit'
  end
  object XEdit: TEdit
    Left = 24
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
    TabOrder = 8
    Text = 'XEdit'
  end
  object ValidateExtendedButton: TButton
    Left = 32
    Top = 464
    Width = 121
    Height = 25
    Caption = 'Validate Extended'
    TabOrder = 9
    OnClick = ValidateExtendedButtonClick
  end
  object BenchmarkExtendedButton: TButton
    Left = 176
    Top = 464
    Width = 121
    Height = 25
    Caption = 'Benchmark Extended'
    TabOrder = 10
    OnClick = BenchmarkExtendedButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 690
    Height = 41
    Align = alTop
    TabOrder = 11
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
  end
  object CloseBitBtn: TBitBtn
    Left = 592
    Top = 520
    Width = 75
    Height = 25
    TabOrder = 12
    Kind = bkClose
  end
  object ErrorEdit: TEdit
    Left = 32
    Top = 424
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
    TabOrder = 13
    Text = 'ErrorEdit'
  end
  object BenchEdit: TEdit
    Left = 176
    Top = 424
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
    Text = 'BenchEdit'
  end
  object FunctionDoubleSelectionRadioGroup: TRadioGroup
    Left = 184
    Top = 176
    Width = 185
    Height = 105
    Caption = 'Function Double Selection'
    ItemIndex = 0
    Items.Strings = (
      'Trunc32DoubleDKC1'
      'Trunc32DoubleJOH'
      'Trunc32DoubleDKCSSE2_2'
      'Trunc32DoubleDFLSSE3')
    TabOrder = 15
    OnClick = FunctionDoubleSelectionRadioGroupClick
  end
  object FunctionSingleSelectionRadioGroup: TRadioGroup
    Left = 184
    Top = 288
    Width = 185
    Height = 105
    Caption = 'Function Single Selection'
    ItemIndex = 0
    Items.Strings = (
      'Trunc32SingleDKC1'
      'Trunc32SingleJOH'
      'Trunc32SingleDKCSSE_2'
      'Trunc32SingleDFL1SSE3')
    TabOrder = 16
    OnClick = FunctionSingleSelectionRadioGroupClick
  end
  object ValidateAllButton: TButton
    Left = 480
    Top = 408
    Width = 89
    Height = 33
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 584
    Top = 408
    Width = 89
    Height = 33
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object BenchmarkDoubleButton: TButton
    Left = 176
    Top = 496
    Width = 121
    Height = 25
    Caption = 'Benchmark Double'
    TabOrder = 17
    OnClick = BenchmarkDoubleButtonClick
  end
  object BenchmarkSingleButton: TButton
    Left = 176
    Top = 528
    Width = 121
    Height = 25
    Caption = 'Benchmark Single'
    TabOrder = 18
    OnClick = BenchmarkSingleButtonClick
  end
  object ValidateDoubleButton: TButton
    Left = 32
    Top = 496
    Width = 121
    Height = 25
    Caption = 'Validate Double'
    TabOrder = 19
    OnClick = ValidateDoubleButtonClick
  end
  object ValidateSingleButton: TButton
    Left = 32
    Top = 528
    Width = 121
    Height = 25
    Caption = 'Validate Single'
    TabOrder = 20
    OnClick = ValidateSingleButtonClick
  end
  object BenchExtendedRTLButton: TButton
    Left = 320
    Top = 464
    Width = 113
    Height = 25
    Caption = 'Bench Extended RTL'
    TabOrder = 21
    OnClick = BenchExtendedRTLButtonClick
  end
  object BenchDoubleRTLButton: TButton
    Left = 320
    Top = 496
    Width = 113
    Height = 25
    Caption = 'Bench Double RTL'
    TabOrder = 22
    OnClick = BenchDoubleRTLButtonClick
  end
  object BenchSingleRTLButton: TButton
    Left = 320
    Top = 528
    Width = 113
    Height = 25
    Caption = 'Bench Single RTL'
    TabOrder = 23
    OnClick = BenchSingleRTLButtonClick
  end
  object ClearButton: TButton
    Left = 392
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 24
    OnClick = ClearButtonClick
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 624
    Top = 440
  end
end
