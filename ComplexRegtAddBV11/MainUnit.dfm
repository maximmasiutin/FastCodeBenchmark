object MainForm: TMainForm
  Left = 156
  Top = 134
  Width = 868
  Height = 618
  Caption = 
    'Complex Number Regtangular Addition Benchmark & Validation Tool ' +
    'for Fastcode Version 1.1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
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
    Top = 200
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label3: TLabel
    Left = 728
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 728
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 728
    Top = 152
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 728
    Top = 200
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 728
    Top = 288
    Width = 97
    Height = 13
    Caption = 'Alignment Spread[%]'
  end
  object Label8: TLabel
    Left = 728
    Top = 328
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label9: TLabel
    Left = 728
    Top = 368
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object ValidateExtendedButton: TButton
    Left = 8
    Top = 104
    Width = 121
    Height = 25
    Caption = 'Validate Extended'
    TabOrder = 4
    OnClick = ValidateExtendedButtonClick
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
    TabOrder = 5
    Text = 'ValidationEdit'
  end
  object BitBtn1: TBitBtn
    Left = 768
    Top = 536
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 320
    Top = 56
    Width = 393
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
    TabOrder = 7
  end
  object BenchmarkExtendedButton: TButton
    Left = 8
    Top = 248
    Width = 121
    Height = 25
    Caption = 'Benchmark Extended'
    TabOrder = 3
    OnClick = BenchmarkExtendedButtonClick
  end
  object RuntimeEdit: TEdit
    Left = 8
    Top = 216
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
    TabOrder = 8
    Text = 'RuntimeEdit'
  end
  object ExtendedFunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 56
    Width = 153
    Height = 137
    Caption = 'Extended Function Selection'
    ItemIndex = 1
    Items.Strings = (
      'RegtAddDKCPas1'
      'RegtAddDFL_IA32_1'
      'RegtAddDFL_IA32_2'
      'RectAdd_JOH_IA32')
    TabOrder = 9
    OnClick = ExtendedFunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 608
    Top = 520
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Bench1Edit: TEdit
    Left = 728
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
    TabOrder = 10
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 728
    Top = 120
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
    Text = 'Bench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 464
    Top = 520
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 328
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 12
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 728
    Top = 168
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
    TabOrder = 13
    Text = 'MaxSpreadBenchPercentageEdit'
    OnClick = MaxSpreadBenchPercentageEditClick
  end
  object FunctionNameEdit: TEdit
    Left = 728
    Top = 216
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
    Text = 'FunctionNameEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 860
    Height = 41
    Align = alTop
    TabOrder = 15
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
  object BenchTestButton: TButton
    Left = 752
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object AlignFunctionName1Edit: TEdit
    Left = 728
    Top = 344
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
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 728
    Top = 384
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
    Text = 'AlignFunctionName2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 728
    Top = 304
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
    TabOrder = 18
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object CleanResultsButton: TButton
    Left = 752
    Top = 424
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    OnClick = CleanResultsButtonClick
  end
  object DoubleFunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 208
    Width = 153
    Height = 137
    Caption = 'Double Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'RegtAddDKCPas1'
      'RegtAddDKCIA32_1'
      'RegtAddDDKC_SSE2_1'
      'RegtAddDFLIA32_1'
      'RectAdd_JOH_IA32')
    TabOrder = 20
    OnClick = DoubleFunctionSelectionRadioGroupClick
  end
  object SingleFunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 360
    Width = 153
    Height = 137
    Caption = 'Single Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'RegtAddDKCPas1'
      'RegtAddDKCIA32_1'
      'RegtAddDDKC_SSE_1'
      'RegtAddDFL_IA32_1'
      'RectAdd_JOH_IA32')
    TabOrder = 21
    OnClick = SingleFunctionSelectionRadioGroupClick
  end
  object ValidateDoubleButton: TButton
    Left = 8
    Top = 136
    Width = 121
    Height = 25
    Caption = 'Validate Double'
    TabOrder = 22
    OnClick = ValidateDoubleButtonClick
  end
  object ValidateSingleButton: TButton
    Left = 8
    Top = 168
    Width = 121
    Height = 25
    Caption = 'Validate Single'
    TabOrder = 23
    OnClick = ValidateSingleButtonClick
  end
  object BenchmarkDoubleButton: TButton
    Left = 8
    Top = 280
    Width = 121
    Height = 25
    Caption = 'Benchmark Double'
    TabOrder = 24
    OnClick = BenchmarkDoubleButtonClick
  end
  object BenchmarkSingleButton: TButton
    Left = 8
    Top = 312
    Width = 121
    Height = 25
    Caption = 'Benchmark Single'
    TabOrder = 25
    OnClick = BenchmarkSingleButtonClick
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 8
    Top = 344
    Width = 137
    Height = 105
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 2
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 26
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object SetRoundModeRadioGroup: TRadioGroup
    Left = 8
    Top = 464
    Width = 137
    Height = 105
    Caption = 'Set Round Mode'
    ItemIndex = 0
    Items.Strings = (
      'rmNearest'
      'rmDown'
      'rmUp'
      'rmTruncate')
    TabOrder = 27
    OnClick = SetRoundModeRadioGroupClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 96
    Top = 40
  end
end
