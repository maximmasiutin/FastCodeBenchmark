object MainForm: TMainForm
  Left = 5
  Top = 85
  Caption = 'Trim B&V for Fastcode Version 1.0.0'
  ClientHeight = 679
  ClientWidth = 1028
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
  object Label3: TLabel
    Left = 640
    Top = 55
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label4: TLabel
    Left = 704
    Top = 55
    Width = 56
    Height = 13
    Caption = 'SubBench2'
  end
  object Label5: TLabel
    Left = 784
    Top = 55
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label6: TLabel
    Left = 600
    Top = 55
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label7: TLabel
    Left = 463
    Top = 54
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label8: TLabel
    Left = 864
    Top = 55
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label13: TLabel
    Left = 864
    Top = 95
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label14: TLabel
    Left = 864
    Top = 311
    Width = 106
    Height = 13
    Caption = 'Alignment Max Spread'
  end
  object Label15: TLabel
    Left = 864
    Top = 351
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label16: TLabel
    Left = 864
    Top = 391
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object Label17: TLabel
    Left = 864
    Top = 135
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label18: TLabel
    Left = 864
    Top = 175
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label1: TLabel
    Left = 864
    Top = 231
    Width = 63
    Height = 13
    Caption = 'Benchmark 1'
  end
  object Label9: TLabel
    Left = 864
    Top = 271
    Width = 63
    Height = 13
    Caption = 'Benchmark 2'
  end
  object Label2: TLabel
    Left = 8
    Top = 312
    Width = 80
    Height = 13
    Caption = 'OptThreadPrority'
  end
  object Label12: TLabel
    Left = 8
    Top = 440
    Width = 64
    Height = 13
    Caption = 'BestPrecision'
  end
  object Label19: TLabel
    Left = 8
    Top = 360
    Width = 76
    Height = 13
    Caption = 'OptNoOfReruns'
  end
  object Label20: TLabel
    Left = 8
    Top = 400
    Width = 114
    Height = 13
    Caption = 'OptMaxNoOfRunsScale'
  end
  object CloseBitBtn: TBitBtn
    Left = 919
    Top = 620
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 463
    Top = 73
    Width = 386
    Height = 512
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
    WordWrap = False
  end
  object BenchmarkAllButton: TButton
    Left = 728
    Top = 600
    Width = 121
    Height = 49
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 160
    Top = 69
    Width = 297
    Height = 588
    Caption = 'Function Selection'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = FunctionSelectionRadioGroupClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 49
    Align = alTop
    TabOrder = 6
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
    object AboutSpeedButton: TSpeedButton
      Left = 88
      Top = 16
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
  object ValidateAllButton: TButton
    Left = 592
    Top = 600
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
    Left = 32
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
    Left = 9
    Top = 576
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'ResultEdit'
    Visible = False
  end
  object ValidateButton: TButton
    Left = 32
    Top = 86
    Width = 97
    Height = 33
    Caption = 'Validate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = ValidateButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 660
    Width = 1028
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ShowErrorDialogCheckBox: TCheckBox
    Left = 24
    Top = 192
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 10
  end
  object SpreadBench1Edit: TEdit
    Left = 865
    Top = 71
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 865
    Top = 111
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Text = 'SpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 865
    Top = 327
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
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 865
    Top = 367
    Width = 144
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 865
    Top = 407
    Width = 144
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 865
    Top = 151
    Width = 144
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 865
    Top = 191
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
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object BenchTestButton: TButton
    Left = 887
    Top = 439
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 18
    OnClick = BenchTestButtonClick
  end
  object ClearButton: TButton
    Left = 472
    Top = 599
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 19
    OnClick = ClearButtonClick
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 864
    Top = 247
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
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 864
    Top = 287
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
    TabOrder = 21
    Text = 'AlignSpreadBench2Edit'
  end
  object AlignCheckButton: TButton
    Left = 40
    Top = 268
    Width = 75
    Height = 25
    Caption = 'Align Check'
    TabOrder = 22
    OnClick = AlignCheckButtonClick
  end
  object AlignCheckEdit: TEdit
    Left = 8
    Top = 233
    Width = 146
    Height = 21
    Color = 14811135
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 23
    Text = 'AlignCheckEdit'
  end
  object CleanButton: TButton
    Left = 472
    Top = 631
    Width = 75
    Height = 25
    Caption = 'Clean'
    TabOrder = 24
    OnClick = CleanButtonClick
  end
  object OptimizeBenchStabilityButton: TButton
    Left = 16
    Top = 488
    Width = 121
    Height = 25
    Caption = 'Optimize Bench Stability'
    TabOrder = 25
    OnClick = OptimizeBenchStabilityButtonClick
  end
  object BestPrecisionEdit: TEdit
    Left = 8
    Top = 456
    Width = 145
    Height = 21
    Color = 14811135
    ReadOnly = True
    TabOrder = 26
    Text = 'BestPrecisionEdit'
  end
  object OptNoOfRerunsEdit: TEdit
    Left = 8
    Top = 376
    Width = 145
    Height = 21
    Color = 14811135
    ReadOnly = True
    TabOrder = 27
    Text = 'OptNoOfRerunsEdit'
  end
  object OptMaxNoOfRunsScaleEdit: TEdit
    Left = 8
    Top = 416
    Width = 145
    Height = 21
    Color = 14811135
    ReadOnly = True
    TabOrder = 28
    Text = 'OptMaxNoOfRunsScaleEdit'
  end
  object OptThreadProrityEdit: TEdit
    Left = 8
    Top = 328
    Width = 145
    Height = 21
    Color = 14811135
    ReadOnly = True
    TabOrder = 29
    Text = 'OptThreadProrityEdit'
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 17
    Top = 56
  end
end
