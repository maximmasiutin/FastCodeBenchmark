object MainForm: TMainForm
  Left = 156
  Top = 134
  Width = 800
  Height = 576
  Caption = 'ScaleDown Benchmark & Validation Tool for Fastcode Version 0.3'
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
    Left = 656
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 656
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 656
    Top = 152
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 656
    Top = 200
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label7: TLabel
    Left = 656
    Top = 320
    Width = 97
    Height = 13
    Caption = 'Alignment Spread[%]'
  end
  object Label8: TLabel
    Left = 656
    Top = 360
    Width = 81
    Height = 13
    Caption = 'Function Name 1'
  end
  object Label9: TLabel
    Left = 656
    Top = 400
    Width = 81
    Height = 13
    Caption = 'Function Name 2'
  end
  object ValidateButton: TButton
    Left = 32
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
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
    TabOrder = 6
    Text = 'ValidationEdit'
  end
  object BitBtn1: TBitBtn
    Left = 696
    Top = 496
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 312
    Top = 56
    Width = 329
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
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
    OnClick = BenchmarkButtonClick
  end
  object RuntimeEdit: TEdit
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
    Text = 'RuntimeEdit'
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 136
    Top = 56
    Width = 169
    Height = 433
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'ScaleDownRMKPas1'
      'ScaleDownDKCPas1'
      'ScaleDownDKCPas2'
      'ScaleDownDKCPas3'
      'ScaleDownDKCPas4'
      'ScaleDownDKCPas5'
      'ScaleDownDKCPas6'
      'ScaleDownDKCPas7'
      'ScaleDownDKCPas8'
      'ScaleDownDKCPas9'
      'ScaleDownDKCPas10')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 536
    Top = 488
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Bench1Edit: TEdit
    Left = 656
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
    Left = 656
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
    TabOrder = 12
    Text = 'Bench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 416
    Top = 488
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 320
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 656
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
    TabOrder = 14
    Text = 'MaxSpreadBenchPercentageEdit'
    OnClick = MaxSpreadBenchPercentageEditClick
  end
  object FunctionNameEdit: TEdit
    Left = 656
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
    TabOrder = 15
    Text = 'FunctionNameEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
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
    object ShowImageFormSpeedButton: TSpeedButton
      Left = 96
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Show Image Form'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        033333777777777773333330777777703333333773F333773333333330888033
        33333FFFF7FFF7FFFFFF0000000000000003777777777777777F0FFFFFFFFFF9
        FF037F3333333337337F0F78888888887F037F33FFFFFFFFF37F0F7000000000
        8F037F3777777777F37F0F70AAAAAAA08F037F37F3333337F37F0F70ADDDDDA0
        8F037F37F3333337F37F0F70A99A99A08F037F37F3333337F37F0F70A99A99A0
        8F037F37F3333337F37F0F70AAAAAAA08F037F37FFFFFFF7F37F0F7000000000
        8F037F3777777777337F0F77777777777F037F3333333333337F0FFFFFFFFFFF
        FF037FFFFFFFFFFFFF7F00000000000000037777777777777773}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ShowImageFormSpeedButtonClick
    end
  end
  object BenchTestButton: TButton
    Left = 680
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object AlignFunctionName1Edit: TEdit
    Left = 656
    Top = 376
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
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 656
    Top = 416
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
    TabOrder = 18
    Text = 'AlignFunctionName2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 656
    Top = 336
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
    TabOrder = 19
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object SpreadTestButton: TButton
    Left = 680
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 680
    Top = 456
    Width = 75
    Height = 25
    Hint = 
      'Removes multiple results from same function. Preserves the faste' +
      'st result'
    Caption = 'Clean Results'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnClick = CleanResultsButtonClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 248
  end
end
