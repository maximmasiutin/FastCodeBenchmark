object MainForm: TMainForm
  Left = 33
  Top = 88
  Caption = 'ArcCos Benchmark & Validation for Fastcode Version 1.7.1'
  ClientHeight = 562
  ClientWidth = 905
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
  object ChartLeftAxisLabel: TLabel
    Left = 24
    Top = 344
    Width = 26
    Height = 13
    Caption = 'Label'
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
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
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
      TabOrder = 2
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
      TabOrder = 3
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
      TabOrder = 4
      OnClick = ValidateAllButtonClick
    end
  end
  object CloseBitBtn: TBitBtn
    Left = 792
    Top = 520
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 368
    Top = 64
    Width = 361
    Height = 265
    Hint = 'RTL version benchmark is not stable'
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
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 4
    WantTabs = True
  end
  object BenchmarkAllButton: TButton
    Left = 624
    Top = 344
    Width = 89
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ErrorChart: TChart
    Left = 24
    Top = 360
    Width = 585
    Height = 185
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Error * 1E18')
    Title.Visible = False
    Legend.Visible = False
    View3D = False
    TabOrder = 5
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object FunctionSelectionSingleRadioGroup: TRadioGroup
    Left = 736
    Top = 56
    Width = 153
    Height = 105
    Caption = 'Function Selection Single'
    ItemIndex = 0
    Items.Strings = (
      'ArcCos_RTL_IA32_1'
      'ArcCos_NJ_IA32_1'
      'ArcCos_DKC_IA32_1'
      'ArcCos_JOH_IA32_1')
    TabOrder = 6
    OnClick = FunctionSelectionSingleRadioGroupClick
  end
  object FunctionSelectionDoubleRadioGroup: TRadioGroup
    Left = 735
    Top = 169
    Width = 153
    Height = 105
    Caption = 'Function Selection Double'
    ItemIndex = 0
    Items.Strings = (
      'ArcCos_RTL_IA32_1'
      'ArcCos_NJ_IA32_1'
      'ArcCos_DKC_IA32_1'
      'ArcCos_JOH_IA32_1')
    TabOrder = 7
    OnClick = FunctionSelectionDoubleRadioGroupClick
  end
  object FunctionSelectionExtendedRadioGroup: TRadioGroup
    Left = 736
    Top = 280
    Width = 153
    Height = 105
    Caption = 'Function Selection Extended'
    ItemIndex = 0
    Items.Strings = (
      'ArcCos_RTL_IA32_1'
      'ArcCos_NJ_IA32_1'
      'ArcCos_DKC_IA32_1'
      'ArcCos_JOH_IA32_1')
    TabOrder = 8
    OnClick = FunctionSelectionExtendedRadioGroupClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 905
    Height = 41
    Align = alTop
    TabOrder = 9
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
    object SpeedButton1: TSpeedButton
      Left = 80
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Copy Chart To Clipboard as Bitmap'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
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
      Left = 112
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
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 168
    Top = 64
  end
end
