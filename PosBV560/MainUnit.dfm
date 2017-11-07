object MainForm: TMainForm
  Left = 167
  Top = 102
  Caption = 'Pos B & V for Fastcode Version 5.6.0'
  ClientHeight = 630
  ClientWidth = 794
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
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 82
    Height = 13
    Caption = 'Function Address'
  end
  object Label3: TLabel
    Left = 472
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench1'
  end
  object Label4: TLabel
    Left = 536
    Top = 56
    Width = 56
    Height = 13
    Caption = 'SubBench2'
  end
  object Label5: TLabel
    Left = 616
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label6: TLabel
    Left = 424
    Top = 56
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Label7: TLabel
    Left = 304
    Top = 56
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object CloseBitBtn: TBitBtn
    Left = 592
    Top = 544
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkClose
  end
  object ReportRichEdit: TRichEdit
    Left = 296
    Top = 72
    Width = 369
    Height = 433
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
    TabOrder = 5
    WantTabs = True
  end
  object RunAllBenchmarksButton: TButton
    Left = 440
    Top = 520
    Width = 121
    Height = 49
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = RunAllBenchmarksButtonClick
  end
  object FunctionSelectRadioGroup: TRadioGroup
    Left = 136
    Top = 64
    Width = 153
    Height = 505
    Caption = 'Function Selection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Pos_RTL_IA32'
      'Pos_RTL_PAS'
      'Pos_DKC_PAS_65'
      'Pos_Sha_Pas_0'
      'Pos_Sha_Pas_1'
      'Pos_Sha_Pas_2'
      'Pos_Sha_Pas_3'
      'Pos_Sha_IA32_3'
      'Pos_Sha_IA32_4'
      'Pos_Sha_IA32_5'
      'Pos_JOH_PAS_3'
      'Pos_JOH_PAS_4'
      'Pos_JOH_MMX_3'
      'Pos_JOH_SSE_3'
      'Pos_JOH_SSE2_3'
      'Pos_JOH_IA32_5'
      'Pos_JOH_IA32_6'
      'Pos_JOH_PAS_6'
      'Pos_JOH_IA32_7')
    ParentFont = False
    TabOrder = 6
    OnClick = FunctionSelectRadioGroupClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 613
    Width = 794
    Height = 17
    Align = alBottom
    TabOrder = 7
  end
  object AddressEdit: TEdit
    Left = 8
    Top = 272
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
    TabOrder = 8
    Text = 'AddressEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 49
    Align = alTop
    TabOrder = 9
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
  end
  object ValidateAllButton: TButton
    Left = 304
    Top = 520
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
  object Run: TButton
    Left = 16
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
    TabOrder = 3
    OnClick = RunClick
  end
  object BenchmarkPosRTLButton: TButton
    Left = 16
    Top = 184
    Width = 97
    Height = 33
    Hint = 'Call Pos directly without wrapper function'
    Caption = 'Bench PosRTL'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BenchmarkPosRTLButtonClick
  end
  object ResultEdit: TEdit
    Left = 8
    Top = 304
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'ResultEdit'
    Visible = False
  end
  object ValidateButton: TButton
    Left = 16
    Top = 88
    Width = 97
    Height = 33
    Caption = 'Validate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = ValidateButtonClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 594
    Width = 794
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object SaveDialog1: TSaveDialog
    Left = 56
    Top = 320
  end
end
