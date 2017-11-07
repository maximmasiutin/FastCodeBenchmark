object MainForm: TMainForm
  Left = 156
  Top = 134
  Caption = 'RoundToEX B & V Tool for Fastcode Version 1.3.1'
  ClientHeight = 574
  ClientWidth = 868
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
    Top = 72
    Width = 46
    Height = 13
    Caption = 'Validation'
  end
  object Label2: TLabel
    Left = 8
    Top = 160
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label3: TLabel
    Left = 736
    Top = 72
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 736
    Top = 120
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 736
    Top = 168
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 736
    Top = 216
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 368
    Top = 56
    Width = 67
    Height = 13
    Caption = 'Functionname'
  end
  object Label8: TLabel
    Left = 472
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label9: TLabel
    Left = 536
    Top = 56
    Width = 55
    Height = 13
    Caption = 'Subbench2'
  end
  object Label10: TLabel
    Left = 600
    Top = 56
    Width = 49
    Height = 13
    Caption = 'Subench3'
  end
  object Label11: TLabel
    Left = 664
    Top = 56
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object ValidateButton: TButton
    Left = 32
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
    OnClick = ValidateButtonClick
  end
  object ValidationEdit: TEdit
    Left = 8
    Top = 88
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
    Left = 768
    Top = 520
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 368
    Top = 72
    Width = 353
    Height = 425
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
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
    OnClick = BenchmarkButtonClick
  end
  object RuntimeEdit: TEdit
    Left = 8
    Top = 176
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
  object DoubleFunctionSelectionRadioGroup: TRadioGroup
    Left = 152
    Top = 72
    Width = 210
    Height = 425
    Caption = 'Double Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'RoundToEX_Ref'
      'RoundToEX_DKC_Pas_1'
      'RoundToEX_DKC_Pas_2'
      'RoundToEX_DKC_Pas_3'
      'RoundToEX_DKC_Pas_4'
      'RoundToEX_DKC_IA32_1'
      'RoundToEX_DKC_IA32_2'
      'RoundToEX_DKC_IA32_3'
      'RoundToEX_DKC_IA32_4'
      'RoundToEX_JOH_PAS_1'
      'RoundToEX_JOH_PAS_2'
      'RoundToEX_JOH_IA32_1'
      'RoundToEX_JOH_IA32_2'
      'RoundToEX_JOH_IA32_3')
    TabOrder = 10
    OnClick = DoubleFunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 616
    Top = 512
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Bench1Edit: TEdit
    Left = 736
    Top = 88
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
    Left = 736
    Top = 136
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
    Left = 488
    Top = 512
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 376
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 736
    Top = 184
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
    Left = 736
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
    ReadOnly = True
    TabOrder = 15
    Text = 'FunctionNameEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 868
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
  end
  object BenchTestButton: TButton
    Left = 760
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object SpreadTestButton: TButton
    Left = 760
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 376
    Top = 544
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
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 8
    Top = 248
    Width = 113
    Height = 17
    Caption = 'Show Error Dialog'
    TabOrder = 18
  end
  object Set8087PrecisionRadioGroup: TRadioGroup
    Left = 8
    Top = 280
    Width = 137
    Height = 105
    Caption = 'Set 8087 CW - Precision'
    ItemIndex = 0
    Items.Strings = (
      'Single'
      'Double'
      'Extended')
    TabOrder = 19
    OnClick = Set8087PrecisionRadioGroupClick
  end
  object SetRoundModeRadioGroup: TRadioGroup
    Left = 8
    Top = 392
    Width = 137
    Height = 105
    Caption = 'Set Round Mode'
    ItemIndex = 1
    Items.Strings = (
      'rmNearest'
      'rmDown'
      'rmUp'
      'rmTruncate')
    TabOrder = 20
    OnClick = SetRoundModeRadioGroupClick
  end
  object YEdit: TEdit
    Left = 72
    Top = 528
    Width = 121
    Height = 21
    TabOrder = 21
    Text = 'YEdit'
    Visible = False
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 48
    Top = 208
  end
end
