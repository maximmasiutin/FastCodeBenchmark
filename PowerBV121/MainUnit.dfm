object MainForm: TMainForm
  Left = 136
  Top = 133
  Caption = 'Power Benchmark & Validation for Fastcode Version 1.2.1'
  ClientHeight = 552
  ClientWidth = 874
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
    Left = 368
    Top = 48
    Width = 123
    Height = 16
    Caption = 'Benchmark Results'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BenchmarkGroupBox: TGroupBox
    Left = 192
    Top = 56
    Width = 161
    Height = 273
    Caption = 'Benchmark'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object ResultLabel: TLabel
      Left = 16
      Top = 224
      Width = 30
      Height = 13
      Caption = 'Result'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RunSingleButton: TButton
      Left = 24
      Top = 120
      Width = 97
      Height = 25
      Caption = 'Run Single'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = RunSingleButtonClick
    end
    object ResultEdit: TEdit
      Left = 16
      Top = 240
      Width = 121
      Height = 21
      Hint = 'Use result to make compiler happy'
      TabStop = False
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      Text = 'ResultEdit'
    end
    object RunDoubleButton: TButton
      Left = 24
      Top = 152
      Width = 97
      Height = 25
      Caption = 'Run Double'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = RunDoubleButtonClick
    end
    object RunExtendedButton: TButton
      Left = 24
      Top = 184
      Width = 97
      Height = 25
      Caption = 'Run Extended'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = RunExtendedButtonClick
    end
    object RuntimeEdit: TEdit
      Left = 16
      Top = 64
      Width = 121
      Height = 21
      TabStop = False
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'RuntimeEdit'
    end
  end
  object ValidationGroupBox: TGroupBox
    Left = 16
    Top = 56
    Width = 161
    Height = 273
    Caption = 'Validation'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
    object ErrorLabel: TLabel
      Left = 24
      Top = 32
      Width = 66
      Height = 13
      Caption = 'Max Abs Error'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ValidateExtendedPrecisionButton: TButton
      Left = 24
      Top = 160
      Width = 113
      Height = 33
      Caption = 'Run Ext Precision'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ValidateExtendedPrecisionButtonClick
    end
    object MaxErrorEdit: TEdit
      Left = 24
      Top = 48
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
      TabOrder = 2
      Text = 'MaxErrorEdit'
    end
    object ValidateDoublePrecisionButton: TButton
      Left = 24
      Top = 120
      Width = 113
      Height = 33
      Caption = 'Run Double Precision'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ValidateDoublePrecisionButtonClick
    end
    object ValidateSinglePrecisionButton: TButton
      Left = 24
      Top = 80
      Width = 113
      Height = 33
      Caption = 'Run Single Precision'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ValidateSinglePrecisionButtonClick
    end
    object ValidateAllButton: TButton
      Left = 24
      Top = 208
      Width = 113
      Height = 41
      Caption = 'Validate All'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ValidateAllButtonClick
    end
  end
  object CloseBitBtn: TBitBtn
    Left = 784
    Top = 520
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 368
    Top = 64
    Width = 329
    Height = 417
    Hint = 'RTL version benchmark is not stable'
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ParentShowHint = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 4
    WantTabs = True
  end
  object BenchmarksAllButton: TButton
    Left = 576
    Top = 488
    Width = 105
    Height = 49
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarksAllButtonClick
  end
  object FunctionSelectionSingleRadioGroup: TRadioGroup
    Left = 712
    Top = 64
    Width = 153
    Height = 137
    Caption = 'Function Selection Single'
    ItemIndex = 0
    Items.Strings = (
      'Power_RTL_IA32_1'
      'Power_DKC_Pas_1'
      'Power_DKC_Pas_4'
      'Power_DKC_IA32_1'
      'Power_DKC_IA32_2'
      'Power_DKC_IA32_3'
      'Power_DKC_IA32Ext_2'
      'Power_DKC_IA32Ext_3'
      'Power_DKC_IA32Ext_4'
      'Power_DKC_IA32Ext_5'
      'Power_DKC_SSE_1'
      'Power_DKC_SSE_2'
      'Power_JOH_IA32_1')
    TabOrder = 5
    OnClick = FunctionSelectionSingleRadioGroupClick
  end
  object FunctionSelectionDoubleRadioGroup: TRadioGroup
    Left = 712
    Top = 208
    Width = 153
    Height = 145
    Caption = 'Function Selection Double'
    ItemIndex = 0
    Items.Strings = (
      'Power_RTL_IA32_1'
      'Power_DKC_Pas_1'
      'Power_DKC_Pas_4'
      'Power_DKC_IA32_1'
      'Power_DKC_IA32_2'
      'Power_DKC_IA32_3'
      'Power_DKC_IA32Ext_2'
      'Power_DKC_IA32Ext_3'
      'Power_DKC_IA32Ext_4'
      'Power_DKC_IA32Ext_5'
      'Power_DKC_SSE2_1'
      'Power_DKC_SSE2_2'
      'Power_JOH_IA32_1')
    TabOrder = 6
    OnClick = FunctionSelectionDoubleRadioGroupClick
  end
  object FunctionSelectionExtendedRadioGroup: TRadioGroup
    Left = 712
    Top = 360
    Width = 153
    Height = 121
    Caption = 'Function Selection Extended'
    ItemIndex = 0
    Items.Strings = (
      'Power_RTL_IA32_1'
      'Power_DKC_Pas_1'
      'Power_DKC_Pas_4'
      'Power_DKC_IA32_1'
      'Power_DKC_IA32_2'
      'Power_DKC_IA32_3'
      'Power_DKC_IA32Ext_2'
      'Power_DKC_IA32Ext_3'
      'Power_DKC_IA32Ext_4'
      'Power_DKC_IA32Ext_5'
      'Power_JOH_IA32_1')
    TabOrder = 7
    OnClick = FunctionSelectionExtendedRadioGroupClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 41
    Align = alTop
    TabOrder = 8
    object SaveSpeedButton: TSpeedButton
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
      OnClick = SaveSpeedButtonClick
    end
    object AboutSpeedButton: TSpeedButton
      Left = 48
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
  object DevelopExtendedButton: TButton
    Left = 40
    Top = 440
    Width = 113
    Height = 25
    Caption = 'Develop Extended'
    TabOrder = 9
    OnClick = DevelopExtendedButtonClick
  end
  object YEdit: TEdit
    Left = 40
    Top = 344
    Width = 113
    Height = 21
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'YEdit'
  end
  object ClearButton: TButton
    Left = 384
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 11
    OnClick = ClearButtonClick
  end
  object DevelopSingleButton: TButton
    Left = 40
    Top = 376
    Width = 113
    Height = 25
    Caption = 'Develop Single'
    TabOrder = 12
    OnClick = DevelopSingleButtonClick
  end
  object DevelopDoubleButton: TButton
    Left = 40
    Top = 408
    Width = 113
    Height = 25
    Caption = 'Develop Double'
    TabOrder = 13
    OnClick = DevelopDoubleButtonClick
  end
  object DevelopIntPowerButton: TButton
    Left = 40
    Top = 480
    Width = 113
    Height = 25
    Caption = 'Develop IntPower'
    TabOrder = 14
    OnClick = DevelopIntPowerButtonClick
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 192
    Top = 336
    Width = 161
    Height = 97
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 2
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 15
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object SetRoundModeRadioGroup: TRadioGroup
    Left = 192
    Top = 440
    Width = 161
    Height = 97
    Caption = 'Set Round Mode'
    ItemIndex = 0
    Items.Strings = (
      'rmNearest'
      'rmDown'
      'rmUp'
      'rmTruncate')
    TabOrder = 16
    OnClick = SetRoundModeRadioGroupClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 160
    Top = 56
  end
end
