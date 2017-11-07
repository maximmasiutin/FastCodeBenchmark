object MainForm: TMainForm
  Left = 77
  Top = 87
  Width = 988
  Height = 740
  Caption = 
    'AES Encryption/Decryption Benchmark & Validation Tool for Fastco' +
    'de Version 1.5'
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
    Top = 120
    Width = 46
    Height = 13
    Caption = 'Validation'
  end
  object Label2: TLabel
    Left = 8
    Top = 208
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label3: TLabel
    Left = 848
    Top = 120
    Width = 37
    Height = 13
    Caption = 'Bench1'
  end
  object Label4: TLabel
    Left = 848
    Top = 168
    Width = 37
    Height = 13
    Caption = 'Bench2'
  end
  object Label5: TLabel
    Left = 848
    Top = 216
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label6: TLabel
    Left = 848
    Top = 264
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label10: TLabel
    Left = 440
    Top = 48
    Width = 272
    Height = 16
    Caption = 'MBits per second Encrypted/Decrypted'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 312
    Top = 104
    Width = 70
    Height = 13
    Caption = 'Function name'
  end
  object Label8: TLabel
    Left = 448
    Top = 104
    Width = 36
    Height = 13
    Caption = 'Encrypt'
  end
  object Label9: TLabel
    Left = 488
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Decrypt'
  end
  object Label11: TLabel
    Left = 312
    Top = 72
    Width = 36
    Height = 13
    Caption = 'Keysize'
  end
  object Label12: TLabel
    Left = 536
    Top = 72
    Width = 32
    Height = 13
    Caption = '192 bit'
  end
  object Label13: TLabel
    Left = 624
    Top = 72
    Width = 32
    Height = 13
    Caption = '256 bit'
  end
  object Label14: TLabel
    Left = 624
    Top = 104
    Width = 36
    Height = 13
    Caption = 'Encrypt'
  end
  object Label15: TLabel
    Left = 712
    Top = 104
    Width = 36
    Height = 13
    Caption = 'Encrypt'
  end
  object Label16: TLabel
    Left = 752
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Decrypt'
  end
  object Label17: TLabel
    Left = 664
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Decrypt'
  end
  object Label18: TLabel
    Left = 800
    Top = 104
    Width = 40
    Height = 13
    Caption = 'Average'
  end
  object Label19: TLabel
    Left = 312
    Top = 88
    Width = 116
    Height = 13
    Caption = 'Context/Block alignment'
  end
  object Label21: TLabel
    Left = 712
    Top = 88
    Width = 34
    Height = 13
    Caption = 'unalign'
  end
  object Label23: TLabel
    Left = 536
    Top = 104
    Width = 36
    Height = 13
    Caption = 'Encrypt'
  end
  object Label24: TLabel
    Left = 576
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Decrypt'
  end
  object Label25: TLabel
    Left = 448
    Top = 88
    Width = 35
    Height = 13
    Caption = '16 byte'
  end
  object Label26: TLabel
    Left = 448
    Top = 72
    Width = 32
    Height = 13
    Caption = '128 bit'
  end
  object Label27: TLabel
    Left = 536
    Top = 88
    Width = 29
    Height = 13
    Caption = '8 byte'
  end
  object Label20: TLabel
    Left = 624
    Top = 88
    Width = 29
    Height = 13
    Caption = '4 byte'
  end
  object Label22: TLabel
    Left = 712
    Top = 72
    Width = 32
    Height = 13
    Caption = '256 bit'
  end
  object ValidateButton: TButton
    Left = 32
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 4
    OnClick = ValidateButtonClick
  end
  object ValidationEdit: TEdit
    Left = 8
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
    TabOrder = 6
    Text = 'ValidationEdit'
  end
  object BitBtn1: TBitBtn
    Left = 872
    Top = 664
    Width = 75
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 312
    Top = 120
    Width = 529
    Height = 521
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
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 3
    OnClick = BenchmarkButtonClick
  end
  object RuntimeEdit: TEdit
    Left = 8
    Top = 224
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
    Top = 120
    Width = 169
    Height = 569
    Caption = 'Function Selection'
    ItemIndex = 24
    Items.Strings = (
      'AES_Ref_PAS_3'
      'AES_LockBox_PAS_1'
      'AES_WE_PAS_5'
      'AES_JOH_PAS'
      'AES_DKC_PAS_33'
      'AES_DKC_PAS_37'
      'AES_DKC_PAS_38'
      'AES_DKC_PAS_39'
      'AES_DKC_IA32_1'
      'AES_WE_PAS_6'
      'AES_DKC_PAS_40'
      'AES_DKC_IA32_2'
      'AES_DKC_IA32_3'
      'AES_DKC_PAS_41'
      'AES_DKC_PAS_42'
      'AES_JOH_PAS_2'
      'AES_DKC_MMX_1'
      'AES_DKC_SSE_1'
      'AES_DKC_SSE2_3'
      'AES_DKC_SSE2_1'
      'AES_DKC_SSE2_2'
      'AES_DKC_SSE2_4'
      'AES_DKC_SSE_2'
      'AES_DKC_IA32_4'
      'AES_DKC_MMX_2'
      'AES_DKC_IA32_5'
      'AES_DKC_IA32_6')
    TabOrder = 10
    OnClick = FunctionSelectionRadioGroupClick
  end
  object BenchmarkAllButton: TButton
    Left = 736
    Top = 656
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Bench1Edit: TEdit
    Left = 848
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
    TabOrder = 11
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 848
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
    TabOrder = 12
    Text = 'Bench2Edit'
  end
  object ValidateAllButton: TButton
    Left = 536
    Top = 656
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object ClearButton: TButton
    Left = 320
    Top = 656
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 13
    OnClick = ClearButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 848
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
    TabOrder = 14
    Text = 'MaxSpreadBenchPercentageEdit'
    OnClick = MaxSpreadBenchPercentageEditClick
  end
  object FunctionNameEdit: TEdit
    Left = 848
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
    TabOrder = 15
    Text = 'FunctionNameEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 980
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
    Left = 872
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Bench Test'
    TabOrder = 2
    OnClick = BenchTestButtonClick
  end
  object SpreadTestButton: TButton
    Left = 872
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 5
    OnClick = SpreadTestButtonClick
  end
  object CleanResultsButton: TButton
    Left = 872
    Top = 376
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
    Top = 384
    Width = 97
    Height = 17
    Caption = 'ShowErrorDialogCheckBox'
    TabOrder = 18
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 312
  end
end
