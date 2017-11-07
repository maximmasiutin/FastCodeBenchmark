object MainForm: TMainForm
  Left = 64
  Top = 43
  Caption = 'IsPrime B & V Tool for Fastcode Version 7.2.2'
  ClientHeight = 693
  ClientWidth = 864
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
    Left = 728
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 728
    Top = 96
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 728
    Top = 136
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 728
    Top = 176
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label10: TLabel
    Left = 8
    Top = 232
    Width = 26
    Height = 13
    Caption = 'Prime'
  end
  object Label11: TLabel
    Left = 8
    Top = 320
    Width = 71
    Height = 13
    Caption = 'Sub Range No'
  end
  object Label12: TLabel
    Left = 8
    Top = 424
    Width = 20
    Height = 13
    Caption = 'Max'
  end
  object Label13: TLabel
    Left = 8
    Top = 416
    Width = 17
    Height = 13
    Caption = 'Min'
  end
  object Label14: TLabel
    Left = 8
    Top = 272
    Width = 34
    Height = 13
    Caption = 'Error at'
  end
  object Label7: TLabel
    Left = 8
    Top = 440
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object Label8: TLabel
    Left = 8
    Top = 480
    Width = 31
    Height = 13
    Caption = 'Speed'
  end
  object Label9: TLabel
    Left = 8
    Top = 360
    Width = 47
    Height = 13
    Caption = 'Min Value'
  end
  object Label15: TLabel
    Left = 8
    Top = 400
    Width = 50
    Height = 13
    Caption = 'Max Value'
  end
  object Label16: TLabel
    Left = 8
    Top = 520
    Width = 94
    Height = 13
    Caption = 'Reference Function'
  end
  object ValidateButton: TButton
    Left = 27
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 2
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
    TabOrder = 7
    Text = 'ValidationEdit'
  end
  object BitBtn1: TBitBtn
    Left = 776
    Top = 623
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 312
    Top = 56
    Width = 401
    Height = 504
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
    TabOrder = 4
    OnClick = BenchmarkButtonClick
  end
  object BenchmarkEdit: TEdit
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
    Text = 'BenchmarkEdit'
    OnClick = BenchmarkEditClick
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 136
    Top = 56
    Width = 169
    Height = 504
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'IsPrime_JOH_Pas_6'
      'IsPrime_JOH_IA32_6'
      'IsPrime_DKC_Pas_23'
      'IsPrime_DKC_Pas_24'
      'IsPrime_DKC_Pas_25'
      'IsPrime_DKC_Pas_26'
      'IsPrime_DKC_Pas_27'
      'IsPrime_DKC_IA32_9'
      'IsPrime_DKC_SSE_1'
      'IsPrime_DKC_SSE_2'
      'IsPrime_DKC_SSE_3'
      'IsPrime_DKC_SSE_4'
      'IsPrime_HR_IA32_1'
      'IsPrime_HR_IA32_2'
      'IsPrime_DKC_SSE_5'
      'IsPrime_DKC_SSE_6'
      'IsPrime_DKC_SSE_7'
      'IsPrime_JOH_IA32_8')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 608
    Top = 584
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
    TabOrder = 11
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 728
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
    Text = 'Bench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 456
    Top = 584
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 317
    Top = 628
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 728
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
    Left = 728
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
    Width = 864
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
    object TimeLabel: TLabel
      Left = 632
      Top = 16
      Width = 49
      Height = 13
      Caption = 'TimeLabel'
    end
    object AboutSpeedButton: TSpeedButton
      Left = 816
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
  object BenchTestButton: TButton
    Left = 752
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 3
    OnClick = BenchTestButtonClick
  end
  object SpreadTestButton: TButton
    Left = 752
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 317
    Top = 597
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = CleanResultsButtonClick
  end
  object PrimeEdit: TEdit
    Left = 8
    Top = 248
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
    TabOrder = 18
    Text = 'PrimeEdit'
  end
  object ErrorEdit: TEdit
    Left = 8
    Top = 288
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
    TabOrder = 19
    Text = 'ErrorEdit'
  end
  object ValidateSubRangeButton: TButton
    Left = 8
    Top = 597
    Width = 185
    Height = 25
    Hint = 'Complete validation of a subrange '
    Caption = 'Validate Sub Range All Functions'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnClick = ValidateSubRangeButtonClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 676
    Width = 864
    Height = 17
    Align = alBottom
    TabOrder = 21
  end
  object RangeNoEdit: TEdit
    Left = 8
    Top = 336
    Width = 121
    Height = 21
    Hint = 'The range you want to validate'
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    Text = 'RangeNoEdit'
  end
  object MaxEdit: TEdit
    Left = 8
    Top = 416
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
    TabOrder = 23
    Text = 'MaxEdit'
  end
  object MinEdit: TEdit
    Left = 8
    Top = 376
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
    TabOrder = 24
    Text = 'MinEdit'
  end
  object RuntimeEdit: TEdit
    Left = 8
    Top = 456
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
    TabOrder = 25
    Text = 'RuntimeEdit'
  end
  object SpeedEdit: TEdit
    Left = 8
    Top = 496
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
    TabOrder = 26
    Text = 'SpeedEdit'
  end
  object ReferenceFunctionEdit: TEdit
    Left = 8
    Top = 536
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
    TabOrder = 27
    Text = 'ReferenceFunctionEdit'
  end
  object ValidateSomeSubRangesButton: TButton
    Left = 8
    Top = 628
    Width = 185
    Height = 25
    Hint = 'Validate a number of subranges'
    Caption = 'Validate Sub Ranges All Functions'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 28
    OnClick = ValidateSomeSubRangesButtonClick
  end
  object ProgressBar2: TProgressBar
    Left = 0
    Top = 659
    Width = 864
    Height = 17
    Align = alBottom
    TabOrder = 29
  end
  object ValidateSubrangeOneFunctionButton: TButton
    Left = 8
    Top = 566
    Width = 185
    Height = 25
    Caption = 'Validate Subrange One Function'
    TabOrder = 30
    OnClick = ValidateSubrangeOneFunctionButtonClick
  end
  object ValidateAllSubrangesOneFunctionButton: TButton
    Left = 199
    Top = 566
    Width = 193
    Height = 25
    Caption = 'Validate All Subranges One Function'
    TabOrder = 31
    OnClick = ValidateAllSubrangesOneFunctionButtonClick
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 736
    Top = 378
    Width = 120
    Height = 17
    Caption = 'Show Error Dialog'
    TabOrder = 32
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 8
    Top = 192
  end
end
