object MainForm: TMainForm
  Left = 107
  Top = 115
  Caption = 'StrCopy Bencmark & Validation Tool for Fastcode '
  ClientHeight = 621
  ClientWidth = 926
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 656
    Top = 144
    Width = 51
    Height = 13
    Caption = 'Spread [%]'
  end
  object Label2: TLabel
    Left = 656
    Top = 104
    Width = 51
    Height = 13
    Caption = 'Min Bench'
  end
  object Label3: TLabel
    Left = 656
    Top = 64
    Width = 54
    Height = 13
    Caption = 'Max Bench'
  end
  object Label4: TLabel
    Left = 16
    Top = 56
    Width = 41
    Height = 13
    Caption = 'Function'
  end
  object Label5: TLabel
    Left = 208
    Top = 56
    Width = 25
    Height = 13
    Caption = 'Sub1'
  end
  object Label6: TLabel
    Left = 264
    Top = 56
    Width = 25
    Height = 13
    Caption = 'Sub2'
  end
  object Label7: TLabel
    Left = 384
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Bench'
  end
  object Label8: TLabel
    Left = 792
    Top = 144
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label9: TLabel
    Left = 792
    Top = 184
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label10: TLabel
    Left = 792
    Top = 64
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label11: TLabel
    Left = 792
    Top = 104
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label12: TLabel
    Left = 792
    Top = 360
    Width = 98
    Height = 13
    Caption = 'AlignFunctionName1'
  end
  object Label13: TLabel
    Left = 792
    Top = 400
    Width = 98
    Height = 13
    Caption = 'AlignFunctionName2'
  end
  object Label14: TLabel
    Left = 792
    Top = 440
    Width = 122
    Height = 13
    Caption = 'AlignMaxSpreadBench[%]'
  end
  object Label15: TLabel
    Left = 152
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Alignment'
  end
  object Label16: TLabel
    Left = 792
    Top = 280
    Width = 40
    Height = 13
    Caption = 'Bench 1'
  end
  object Label17: TLabel
    Left = 792
    Top = 320
    Width = 40
    Height = 13
    Caption = 'Bench 2'
  end
  object Label18: TLabel
    Left = 320
    Top = 56
    Width = 25
    Height = 13
    Caption = 'Sub3'
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 926
    Height = 41
    Align = alTop
    TabOrder = 4
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
  end
  object ReportRichEdit: TRichEdit
    Left = 8
    Top = 72
    Width = 433
    Height = 489
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
    ScrollBars = ssVertical
    TabOrder = 5
    WantTabs = True
  end
  object CloseBitBtn: TBitBtn
    Left = 816
    Top = 576
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkClose
  end
  object BenchmarkButton: TButton
    Left = 680
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 7
    OnClick = BenchmarkButtonClick
  end
  object FunctionSelectionRadioGroup: TRadioGroup
    Left = 456
    Top = 60
    Width = 185
    Height = 553
    Caption = 'Function Selection'
    ItemIndex = 0
    Items.Strings = (
      'StrCopy_RTL_IA32'
      'StrCopy_DKC_IA32_1_a'
      'StrCopy_DKC_IA32_1_b'
      'StrCopy_DKC_IA32_1_c'
      'StrCopy_DKC_IA32_1_d'
      'StrCopy_Lbg_IA32_1_a'
      'StrCopy_Lbg_IA32_1_b'
      'StrCopy_Lbg_IA32_1_c'
      'StrCopy_Lbg_IA32_1_d'
      'StrCopy_Sha_Pas_1_a'
      'StrCopy_Sha_Pas_1_b'
      'StrCopy_Sha_Pas_1_c'
      'StrCopy_Sha_Pas_1_d'
      'StrCopy_DKC_Pas_13_a'
      'StrCopy_DKC_Pas_13_b'
      'StrCopy_AS_IA32_5_a'
      'StrCopy_AS_IA32_5_b'
      'StrCopy_AS_IA32_5_c'
      'StrCopy_AS_IA32_5_d'
      'StrCopy_DKC_IA32_2_a'
      'StrCopy_DKC_IA32_2_b'
      'StrCopy_DKC_IA32_2_c'
      'StrCopy_DKC_IA32_2_d'
      'StrCopy_Sha_IA32_4_a'
      'StrCopy_Sha_IA32_4_b'
      'StrCopy_Sha_IA32_4_c'
      'StrCopy_Sha_IA32_4_d'
      'StrCopy_DKC_IA32_3_a'
      'StrCopy_DKC_IA32_3_b'
      'StrCopy_DKC_IA32_3_c'
      'StrCopy_DKC_IA32_3_d'
      'StrCopy_AS_IA32_6_a'
      'StrCopy_AS_IA32_6_b'
      'StrCopy_AS_IA32_6_c'
      'StrCopy_AS_IA32_6_d'
      'StrCopy_Sha_IA32_2_a'
      'StrCopy_Sha_IA32_2_b'
      'StrCopy_Sha_IA32_2_c'
      'StrCopy_Sha_IA32_2_d'
      'StrCopy_Sha_IA32_3_a'
      'StrCopy_Sha_IA32_3_b'
      'StrCopy_Sha_IA32_3_c'
      'StrCopy_Sha_IA32_3_d'
      'StrCopy_DKC_IA32_4_a'
      'StrCopy_DKC_IA32_4_b'
      'StrCopy_DKC_IA32_4_c'
      'StrCopy_DKC_IA32_4_d'
      'StrCopy_DKC_IA32_5_a'
      'StrCopy_DKC_IA32_5_b'
      'StrCopy_DKC_IA32_5_c'
      'StrCopy_DKC_IA32_5_d'
      'StrCopy_JOH_PAS_4_a'
      'StrCopy_JOH_PAS_4_b'
      'StrCopy_JOH_PAS_4_c'
      'StrCopy_JOH_PAS_4_d'
      'StrCopy_JOH_IA32_6_a'
      'StrCopy_JOH_IA32_6_b'
      'StrCopy_JOH_IA32_6_c'
      'StrCopy_JOH_IA32_6_d'
      'StrCopy_JOH_IA32_7_a'
      'StrCopy_JOH_IA32_7_b'
      'StrCopy_JOH_IA32_7_c'
      'StrCopy_JOH_IA32_7_d'
      'StrCopy_JOH_IA32_8_a'
      'StrCopy_JOH_IA32_8_b'
      'StrCopy_JOH_IA32_8_c'
      'StrCopy_JOH_IA32_8_d'
      'StrCopy_JOH_MMX_1_a'
      'StrCopy_JOH_MMX_1_b'
      'StrCopy_JOH_MMX_1_c'
      'StrCopy_JOH_MMX_1_d'
      'StrCopy_JOH_IA32_9_a'
      'StrCopy_JOH_IA32_9_b'
      'StrCopy_JOH_IA32_9_c'
      'StrCopy_JOH_IA32_9_d')
    TabOrder = 8
    OnClick = FunctionSelectionRadioGroupClick
  end
  object ValidateButton: TButton
    Left = 680
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 9
    OnClick = ValidateButtonClick
  end
  object ValidateAllButton: TButton
    Left = 176
    Top = 568
    Width = 97
    Height = 41
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 328
    Top = 568
    Width = 97
    Height = 41
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object ClearButton: TButton
    Left = 40
    Top = 568
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 10
    OnClick = ClearButtonClick
  end
  object SpreadTestButton: TButton
    Left = 672
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Spread Test'
    TabOrder = 2
    OnClick = SpreadTestButtonClick
  end
  object MaxBenchEdit: TEdit
    Left = 656
    Top = 80
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
    TabOrder = 11
    Text = 'MaxBenchEdit'
  end
  object MinBenchEdit: TEdit
    Left = 656
    Top = 120
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
    TabOrder = 12
    Text = 'MinBenchEdit'
  end
  object SpreadBenchPercentageEdit: TEdit
    Left = 656
    Top = 160
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
    TabOrder = 13
    Text = 'SpreadBenchPercentageEdit'
    OnClick = SpreadBenchPercentageEditClick
  end
  object FunctionNameEdit: TEdit
    Left = 792
    Top = 200
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
    TabOrder = 14
    Text = 'FunctionNameEdit'
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 792
    Top = 160
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
    TabOrder = 15
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object Bench1Edit: TEdit
    Left = 792
    Top = 80
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
    TabOrder = 16
    Text = 'Bench1Edit'
  end
  object Bench2Edit: TEdit
    Left = 792
    Top = 120
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
    Text = 'Bench2Edit'
  end
  object ValidateBenchmarkButton: TButton
    Left = 800
    Top = 240
    Width = 105
    Height = 25
    Caption = 'Validate Benchmark'
    TabOrder = 3
    OnClick = ValidateBenchmarkButtonClick
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 792
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
    TabOrder = 18
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 792
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
    TabOrder = 19
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 792
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
    TabOrder = 20
    Text = 'AlignFunctionName2Edit'
  end
  object AlignmentBench1Edit: TEdit
    Left = 792
    Top = 296
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
    Text = 'AlignmentBench1Edit'
  end
  object AlignmentBench2Edit: TEdit
    Left = 792
    Top = 336
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
    TabOrder = 22
    Text = 'AlignmentBench2Edit'
  end
  object CleanButton: TButton
    Left = 680
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Clean'
    TabOrder = 23
    OnClick = CleanButtonClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 696
    Top = 232
  end
end
