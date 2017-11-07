object MainForm: TMainForm
  Left = 86
  Top = 111
  Caption = 'CharPos Challenge B & V Tool for Fastcode Version 5.2.0'
  ClientHeight = 675
  ClientWidth = 1049
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
    Left = 608
    Top = 392
    Width = 117
    Height = 13
    Caption = 'Function entry point addr'
  end
  object Label2: TLabel
    Left = 304
    Top = 56
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label3: TLabel
    Left = 448
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Alignment'
  end
  object Label4: TLabel
    Left = 528
    Top = 56
    Width = 54
    Height = 13
    Caption = 'Benchmark'
  end
  object Label6: TLabel
    Left = 744
    Top = 472
    Width = 85
    Height = 13
    Caption = 'Spread Bench [%]'
  end
  object Label7: TLabel
    Left = 744
    Top = 392
    Width = 54
    Height = 13
    Caption = 'Max Bench'
  end
  object Label8: TLabel
    Left = 744
    Top = 432
    Width = 51
    Height = 13
    Caption = 'Min Bench'
  end
  object Label9: TLabel
    Left = 608
    Top = 432
    Width = 16
    Height = 13
    Caption = 'Chr'
  end
  object Label10: TLabel
    Left = 608
    Top = 472
    Width = 13
    Height = 13
    Caption = 'Str'
  end
  object Label11: TLabel
    Left = 608
    Top = 512
    Width = 40
    Height = 13
    Caption = 'CharPos'
  end
  object Label13: TLabel
    Left = 744
    Top = 592
    Width = 74
    Height = 13
    Caption = 'Max Spread [%]'
  end
  object Label5: TLabel
    Left = 880
    Top = 392
    Width = 103
    Height = 13
    Caption = 'Align Spread Bench 1'
  end
  object Label12: TLabel
    Left = 744
    Top = 512
    Width = 72
    Height = 13
    Caption = 'Function Name'
  end
  object Label14: TLabel
    Left = 880
    Top = 432
    Width = 103
    Height = 13
    Caption = 'Align Spread Bench 2'
  end
  object Label15: TLabel
    Left = 880
    Top = 472
    Width = 134
    Height = 13
    Caption = 'Align Max Spread Bench [%]'
  end
  object Label16: TLabel
    Left = 880
    Top = 512
    Width = 107
    Height = 13
    Caption = 'Align Function Name 1'
  end
  object Label17: TLabel
    Left = 880
    Top = 552
    Width = 107
    Height = 13
    Caption = 'Align Function Name 2'
  end
  object StrEdit: TEdit
    Left = 608
    Top = 488
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
    TabOrder = 2
    Text = 'StrEdit'
  end
  object CharEdit: TEdit
    Left = 608
    Top = 448
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
    TabOrder = 3
    Text = 'CharEdit'
  end
  object CharPosEdit: TEdit
    Left = 608
    Top = 528
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
    TabOrder = 4
    Text = 'CharPosEdit'
  end
  object CloseBitBtn: TBitBtn
    Left = 960
    Top = 640
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkClose
  end
  object Chart1: TChart
    Left = 608
    Top = 56
    Width = 433
    Height = 321
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    Legend.Visible = False
    View3D = False
    TabOrder = 6
    object Series1: TLineSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
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
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
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
    object Series3: TLineSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
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
  object FunctionSelectRadioGroup: TRadioGroup
    Left = 16
    Top = 64
    Width = 282
    Height = 609
    Caption = 'Function'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'CharPos_DKC_Pas_1_a'
      'CharPos_DKC_Pas_1_b'
      'CharPos_DKC_Pas_1_c'
      'CharPos_DKC_Pas_1_d'
      'CharPos_PERL_IA32_1_a'
      'CharPos_PERL_IA32_1_b'
      'CharPos_PERL_IA32_1_c'
      'CharPos_PERL_IA32_1_d'
      'CharPos_JOH_MMX_1_a'
      'CharPos_JOH_MMX_1_b'
      'CharPos_JOH_MMX_1_c'
      'CharPos_JOH_MMX_1_d'
      'CharPos_JOH_SSE_1_a'
      'CharPos_JOH_SSE_1_b'
      'CharPos_JOH_SSE_1_c'
      'CharPos_JOH_SSE_1_d'
      'CharPos_DD_Pas_1_a'
      'CharPos_DD_Pas_1_b'
      'CharPos_DD_Pas_1_c'
      'CharPos_DD_Pas_1_d'
      'CharPos_JOH_Pas_1_a'
      'CharPos_JOH_Pas_1_b'
      'CharPos_JOH_Pas_1_c'
      'CharPos_JOH_Pas_1_d'
      'CharPos_Mw_PAS_2_a'
      'CharPos_Mw_PAS_2_b'
      'CharPos_Mw_PAS_2_c'
      'CharPos_Mw_PAS_2_d'
      'CharPos_JOH_SSE2_1_a'
      'CharPos_JOH_SSE2_1_b'
      'CharPos_JOH_SSE2_1_c'
      'CharPos_JOH_SSE2_1_d'
      'CharPos_DKC_MMX_1_a'
      'CharPos_DKC_MMX_1_b'
      'CharPos_DKC_MMX_1_c'
      'CharPos_DKC_MMX_1_d'
      'CharPos_DKC_SSE_1_a'
      'CharPos_DKC_SSE_1_b'
      'CharPos_DKC_SSE_1_c'
      'CharPos_DKC_SSE_1_d'
      'CharPos_JOH_Pas_2_a'
      'CharPos_JOH_Pas_2_b'
      'CharPos_JOH_Pas_2_c'
      'CharPos_JOH_Pas_2_d'
      'CharPos_CJG_Pas_3_a'
      'CharPos_CJG_Pas_3_b'
      'CharPos_CJG_Pas_3_c'
      'CharPos_CJG_Pas_3_d'
      'CharPos_JOH_IA32_1_a'
      'CharPos_JOH_IA32_1_b'
      'CharPos_JOH_IA32_1_c'
      'CharPos_JOH_IA32_1_d'
      'CharPos_Sha_Pas_1_a'
      'CharPos_Sha_Pas_1_b'
      'CharPos_Sha_Pas_1_c'
      'CharPos_Sha_Pas_1_d'
      'CharPos_Sha_Pas_2_a'
      'CharPos_Sha_Pas_2_b'
      'CharPos_Sha_Pas_2_c'
      'CharPos_Sha_Pas_2_d'
      'CharPos_Sha_IA32_1_a'
      'CharPos_Sha_IA32_1_b'
      'CharPos_Sha_IA32_1_c'
      'CharPos_Sha_IA32_1_d'
      'CharPos_CJG_Pas_5_a'
      'CharPos_CJG_Pas_5_b'
      'CharPos_CJG_Pas_5_c'
      'CharPos_CJG_Pas_5_d'
      'CharPos_CJG_Pas_6_a'
      'CharPos_CJG_Pas_6_b'
      'CharPos_CJG_Pas_6_c'
      'CharPos_CJG_Pas_6_d'
      'CharPos_CJG_Pas_7_a'
      'CharPos_CJG_Pas_7_b'
      'CharPos_CJG_Pas_7_c'
      'CharPos_CJG_Pas_7_d'
      'CharPos_CJG_Pas_9_a'
      'CharPos_CJG_Pas_9_b'
      'CharPos_CJG_Pas_9_c'
      'CharPos_CJG_Pas_9_d')
    TabOrder = 7
    OnClick = FunctionSelectRadioGroupClick
  end
  object ReportRichEdit: TRichEdit
    Left = 304
    Top = 72
    Width = 289
    Height = 521
    TabStop = False
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Lines.Strings = (
      'ReportRichEdit')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object ValidateButton: TButton
    Left = 624
    Top = 560
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 9
    OnClick = ValidateButtonClick
  end
  object ValidateAllButton: TButton
    Left = 392
    Top = 608
    Width = 75
    Height = 57
    Caption = 'Validate All'
    TabOrder = 1
    OnClick = ValidateAllButtonClick
  end
  object BenchmarkButton: TButton
    Left = 624
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Benchmark'
    TabOrder = 10
    OnClick = BenchmarkButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 496
    Top = 608
    Width = 89
    Height = 57
    Caption = 'Benchmark All'
    TabOrder = 0
    OnClick = BenchmarkAllButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1049
    Height = 41
    Align = alTop
    TabOrder = 11
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
  end
  object ErrorEdit: TEdit
    Left = 608
    Top = 624
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
    TabOrder = 12
    Text = 'ErrorEdit'
  end
  object AddressEdit: TEdit
    Left = 608
    Top = 408
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
    Text = 'AddressEdit'
  end
  object ClearButton: TButton
    Left = 304
    Top = 608
    Width = 73
    Height = 25
    Caption = 'Clear'
    TabOrder = 14
    OnClick = ClearButtonClick
  end
  object RepeatBenchButton: TButton
    Left = 760
    Top = 560
    Width = 75
    Height = 25
    Caption = 'Repeat Bench'
    TabOrder = 15
    OnClick = RepeatBenchButtonClick
  end
  object SpreadBenchPercentageEdit: TEdit
    Left = 744
    Top = 488
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
    TabOrder = 16
    Text = 'SpreadBenchPercentageEdit'
  end
  object SpreadBench1Edit: TEdit
    Left = 744
    Top = 408
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
    TabOrder = 17
    Text = 'SpreadBench1Edit'
  end
  object SpreadBench2Edit: TEdit
    Left = 744
    Top = 448
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
    TabOrder = 18
    Text = 'SpreadBench2Edit'
  end
  object MaxSpreadButton: TButton
    Left = 760
    Top = 640
    Width = 75
    Height = 25
    Caption = 'Max Spread'
    TabOrder = 19
    OnClick = MaxSpreadButtonClick
  end
  object MaxSpreadBenchPercentageEdit: TEdit
    Left = 744
    Top = 608
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
    TabOrder = 20
    Text = 'MaxSpreadBenchPercentageEdit'
  end
  object AlignSpreadBench1Edit: TEdit
    Left = 880
    Top = 408
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    Text = 'AlignSpreadBench1Edit'
  end
  object AlignSpreadBench2Edit: TEdit
    Left = 880
    Top = 448
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
    Text = 'AlignSpreadBench2Edit'
  end
  object AlignMaxSpreadBenchPercentageEdit: TEdit
    Left = 880
    Top = 488
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 23
    Text = 'AlignMaxSpreadBenchPercentageEdit'
  end
  object AlignFunctionName1Edit: TEdit
    Left = 880
    Top = 528
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 24
    Text = 'AlignFunctionName1Edit'
  end
  object AlignFunctionName2Edit: TEdit
    Left = 880
    Top = 568
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 25
    Text = 'AlignFunctionName2Edit'
  end
  object FunctionNameEdit: TEdit
    Left = 744
    Top = 528
    Width = 121
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 26
    Text = 'FunctionNameEdit'
  end
  object CleanButton: TButton
    Left = 304
    Top = 640
    Width = 73
    Height = 25
    Caption = 'Clean'
    TabOrder = 27
    OnClick = CleanButtonClick
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 904
    Top = 608
  end
end
