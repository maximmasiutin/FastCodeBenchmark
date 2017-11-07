object MainForm: TMainForm
  Left = 358
  Top = 157
  Caption = 'Fastcode MaxInt64 B & V Version 1.6.0'
  ClientHeight = 504
  ClientWidth = 765
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
    Top = 280
    Width = 39
    Height = 13
    Caption = 'Runtime'
  end
  object Label1: TLabel
    Left = 512
    Top = 47
    Width = 41
    Height = 13
    Caption = 'Function'
  end
  object Label2: TLabel
    Left = 592
    Top = 47
    Width = 46
    Height = 13
    Caption = 'Alignment'
  end
  object Label3: TLabel
    Left = 688
    Top = 47
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label4: TLabel
    Left = 16
    Top = 376
    Width = 81
    Height = 13
    Caption = 'Function address'
  end
  object DevelopButton: TButton
    Left = 40
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Develop'
    TabOrder = 2
    OnClick = DevelopButtonClick
  end
  object BenchmarkButton: TButton
    Left = 40
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
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
    TabOrder = 5
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
    TabOrder = 6
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
    TabOrder = 7
    Text = 'Y2Edit'
  end
  object RunTimeEdit1: TEdit
    Left = 16
    Top = 296
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
    Text = 'RuntimeEdit1'
  end
  object FunctionSelectRadioGroup: TRadioGroup
    Left = 152
    Top = 64
    Width = 354
    Height = 417
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'MaxRTL_a'
      'MaxRTL_b'
      'MaxRTL_c'
      'MaxRTL_d'
      'MaxDKCPas_a'
      'MaxDKCPas_b'
      'MaxDKCPas_c'
      'MaxDKCPas_d'
      'MaxShaInt64_a'
      'MaxShaInt64_b'
      'MaxShaInt64_c'
      'MaxShaInt64_d'
      'MaxDKCAsmIA32_a'
      'MaxDKCAsmIA32_b'
      'MaxDKCAsmIA32_c'
      'MaxDKCAsmIA32_d'
      'MaxInt64JOH_a'
      'MaxInt64JOH_b'
      'MaxInt64JOH_c'
      'MaxInt64JOH_d'
      'MaxInt64JOH2_a'
      'MaxInt64JOH2_b'
      'MaxInt64JOH2_c'
      'MaxInt64JOH2_d'
      'MaxShaInt64_2_a'
      'MaxShaInt64_2_b'
      'MaxShaInt64_2_c'
      'MaxShaInt64_2_d')
    TabOrder = 9
    OnClick = FunctionSelectRadioGroupClick
  end
  object CloseBitBtn: TBitBtn
    Left = 640
    Top = 447
    Width = 91
    Height = 25
    TabOrder = 10
    Kind = bkClose
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 765
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 11
    ExplicitWidth = 560
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
  object ResultsRichEdit: TRichEdit
    Left = 512
    Top = 63
    Width = 233
    Height = 321
    TabStop = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'ResultsRichEdit')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 12
  end
  object BenchmarkAllButton: TButton
    Left = 640
    Top = 399
    Width = 89
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateButton: TButton
    Left = 40
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
    OnClick = ValidateButtonClick
  end
  object ValidEdit: TEdit
    Left = 16
    Top = 208
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
    Text = 'ValidEdit'
  end
  object ClearButton: TButton
    Left = 528
    Top = 447
    Width = 97
    Height = 25
    Caption = 'Clear'
    TabOrder = 14
    OnClick = ClearButtonClick
  end
  object AddressEdit: TEdit
    Left = 16
    Top = 392
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
    TabOrder = 15
    Text = 'AddressEdit'
  end
  object ValidateAllButton: TButton
    Left = 528
    Top = 399
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 48
  end
end
