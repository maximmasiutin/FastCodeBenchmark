object MainForm: TMainForm
  Left = 242
  Top = 110
  Width = 736
  Height = 606
  Caption = 'Round32 Benchmark & Validation for Fastcode Version 1.2'
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
  object Label6: TLabel
    Left = 448
    Top = 440
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label7: TLabel
    Left = 544
    Top = 440
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label8: TLabel
    Left = 448
    Top = 520
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label9: TLabel
    Left = 448
    Top = 480
    Width = 71
    Height = 13
    Caption = 'MaxSpread [%]'
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
      'Round32ExtendedDKC1'
      'Round32ExtendedJOH'
      'Round32ExtendedJOH_1'
      'Round32ExtendedJOH_2')
    TabOrder = 3
    OnClick = FunctionExtendedSelectionRadioGroupClick
  end
  object ReportRichEdit: TRichEdit
    Left = 384
    Top = 64
    Width = 281
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
    Width = 728
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
    Left = 640
    Top = 528
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
      'Round32DoubleDKC1'
      'Round32DoubleDKCSSE2_2'
      'Round32DoubleJOH'
      'Round32DoubleJOH_1'
      'Round32DoubleJOH_2')
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
      'Round32SingleDKC1'
      'Round32SingleDKCSSE_2'
      'Round32SingleJOH'
      'Round32SingleJOH_1'
      'Round32SingleJOH_2')
    TabOrder = 16
    OnClick = FunctionSingleSelectionRadioGroupClick
  end
  object ValidateAllButton: TButton
    Left = 472
    Top = 400
    Width = 89
    Height = 33
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 576
    Top = 400
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
    Left = 384
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 24
    OnClick = ClearButtonClick
  end
  object Bench1Edit: TEdit
    Left = 448
    Top = 456
    Width = 89
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
    TabOrder = 25
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 544
    Top = 456
    Width = 81
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
    TabOrder = 26
    Text = 'Bench2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 448
    Top = 536
    Width = 177
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
    TabOrder = 27
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 448
    Top = 496
    Width = 89
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
    TabOrder = 28
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object CleanButton: TButton
    Left = 320
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Clean'
    TabOrder = 29
    OnClick = CleanButtonClick
  end
  object BenchTestButton: TButton
    Left = 552
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 30
    OnClick = BenchTestButtonClick
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 144
    Top = 144
  end
end
