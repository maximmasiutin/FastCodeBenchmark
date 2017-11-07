object MainForm: TMainForm
  Left = 242
  Top = 113
  Caption = 'Fastcode MinInt B & V Version 1.3.0'
  ClientHeight = 650
  ClientWidth = 705
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
  object RunTimeLabel: TLabel
    Left = 16
    Top = 264
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object Label1: TLabel
    Left = 16
    Top = 344
    Width = 82
    Height = 13
    Caption = 'Function Address'
  end
  object Label2: TLabel
    Left = 16
    Top = 384
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label3: TLabel
    Left = 16
    Top = 424
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label4: TLabel
    Left = 16
    Top = 464
    Width = 100
    Height = 13
    Caption = 'Align Max Spread [%]'
  end
  object Label5: TLabel
    Left = 16
    Top = 504
    Width = 107
    Height = 13
    Caption = 'Align Function Name 1'
  end
  object Label6: TLabel
    Left = 16
    Top = 544
    Width = 107
    Height = 13
    Caption = 'Align Function Name 2'
  end
  object Label7: TLabel
    Left = 144
    Top = 504
    Width = 108
    Height = 13
    Caption = 'Max Spread Bench [%]'
  end
  object Label8: TLabel
    Left = 144
    Top = 544
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object DevelopButton: TButton
    Left = 40
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Develop'
    TabOrder = 1
    OnClick = DevelopButtonClick
  end
  object BenchmarkButton: TButton
    Left = 40
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 2
    OnClick = BenchmarkButtonClick
  end
  object X1Edit: TEdit
    Left = 16
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
    TabOrder = 3
    Text = 'X1Edit'
  end
  object X2Edit: TEdit
    Left = 16
    Top = 104
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
    TabOrder = 4
    Text = 'X2Edit'
  end
  object Y2Edit: TEdit
    Left = 16
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
    TabOrder = 5
    Text = 'Y2Edit'
  end
  object RunTimeEdit1: TEdit
    Left = 16
    Top = 280
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
    Text = 'RuntimeEdit1'
  end
  object FunctionSelectRadioGroup: TRadioGroup
    Left = 144
    Top = 72
    Width = 256
    Height = 425
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'MinRTL'
      'MinDKCPas_a'
      'MinDKCPas_b'
      'MinDKCPas_c'
      'MinDKCPas_d'
      'MinLBGAsm_a'
      'MinLBGAsm_b'
      'MinLBGAsm_c'
      'MinLBGAsm_d'
      'MinShaIntegerPas_a'
      'MinShaIntegerPas_b'
      'MinShaIntegerPas_c'
      'MinShaIntegerPas_d'
      'MinShaInteger_a'
      'MinShaInteger_b'
      'MinShaInteger_c'
      'MinShaInteger_d')
    TabOrder = 7
    OnClick = FunctionSelectRadioGroupClick
  end
  object CloseBitBtn: TBitBtn
    Left = 622
    Top = 602
    Width = 75
    Height = 25
    TabOrder = 8
    Kind = bkClose
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 9
    ExplicitWidth = 604
    object SaveResultsSpeedButton: TSpeedButton
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
      OnClick = SaveResultsSpeedButtonClick
    end
    object PrintResultsSpeedButton: TSpeedButton
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
      OnClick = PrintResultsSpeedButtonClick
    end
  end
  object ReportRichEdit: TRichEdit
    Left = 406
    Top = 74
    Width = 281
    Height = 425
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 10
  end
  object BenchmarkAllButton: TButton
    Left = 606
    Top = 506
    Width = 81
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateButton: TButton
    Left = 40
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 11
    OnClick = ValidateButtonClick
  end
  object ValidEdit: TEdit
    Left = 16
    Top = 200
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
    Text = 'ValidEdit'
  end
  object ClearButton: TButton
    Left = 406
    Top = 506
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object ValidateAllButton: TButton
    Left = 502
    Top = 506
    Width = 89
    Height = 41
    Caption = 'Validate All'
    TabOrder = 14
    OnClick = ValidateAllButtonClick
  end
  object AddressEdit: TEdit
    Left = 16
    Top = 360
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
    Text = 'AddressEdit'
  end
  object Bench1Edit: TEdit
    Left = 16
    Top = 400
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
    TabOrder = 16
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 16
    Top = 440
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
    TabOrder = 17
    Text = 'Bench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 16
    Top = 480
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
    TabOrder = 18
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 16
    Top = 520
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
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 16
    Top = 560
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
    TabOrder = 20
    Text = 'AlignFunctionName2Edit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 144
    Top = 520
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
    TabOrder = 21
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object FunctionNameEdit: TEdit
    Left = 144
    Top = 560
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
    TabOrder = 22
    Text = 'FunctionNameEdit'
  end
  object BenchTestButton: TButton
    Left = 40
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 23
    OnClick = BenchTestButtonClick
  end
  object SpreadTestButton: TButton
    Left = 168
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 24
    OnClick = SpreadTestButtonClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 633
    Width = 705
    Height = 17
    Align = alBottom
    TabOrder = 25
    ExplicitWidth = 604
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 48
  end
end
