object MainForm: TMainForm
  Left = 138
  Top = 107
  Caption = 'Move Validation & Benchmark 9.4.1'
  ClientHeight = 657
  ClientWidth = 818
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
  object Label7: TLabel
    Left = 16
    Top = 480
    Width = 47
    Height = 13
    Caption = 'Array Size'
  end
  object Label8: TLabel
    Left = 16
    Top = 520
    Width = 38
    Height = 13
    Caption = 'MB/sec'
  end
  object Label12: TLabel
    Left = 16
    Top = 560
    Width = 59
    Height = 13
    Caption = 'Benchmarks'
  end
  object Label13: TLabel
    Left = 672
    Top = 312
    Width = 78
    Height = 13
    Caption = 'Best Benchmark'
  end
  object CloseBitBtn: TBitBtn
    Left = 720
    Top = 608
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkClose
  end
  object BenchmarkButton: TButton
    Left = 688
    Top = 361
    Width = 81
    Height = 33
    Caption = 'Benchmark'
    TabOrder = 0
    OnClick = BenchmarkButtonClick
  end
  object SummedNoOfMBytesPerSecEdit: TEdit
    Left = 16
    Top = 536
    Width = 785
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'SummedNoOfMBytesPerSecEdit'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 638
    Width = 818
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 41
    Align = alTop
    TabOrder = 4
    object SaveTestResultsSpeedButton: TSpeedButton
      Left = 16
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Save Text or Report'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SaveTestResultsSpeedButtonClick
    end
    object Label17: TLabel
      Left = 432
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Function'
    end
    object PrintSpeedButton: TSpeedButton
      Left = 48
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Print Text or Report'
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
    object ShowOptionsSpeedButton: TSpeedButton
      Left = 80
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
        1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
        1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
        193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
        11155557F755F777777555000755033305555577755F75F77F55555555503335
        0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
        05555757F75F75557F5505000333555505557F777FF755557F55000000355557
        07557777777F55557F5555000005555707555577777FF5557F55553000075557
        0755557F7777FFF5755555335000005555555577577777555555}
      NumGlyphs = 2
      OnClick = ShowOptionsSpeedButtonClick
    end
    object CopyChartToClipboardSpeedButton: TSpeedButton
      Left = 112
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Copy Chart to Clipboard'
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
      OnClick = CopyChartToClipboardSpeedButtonClick
    end
    object FunctionSelectComboBox: TComboBox
      Left = 480
      Top = 8
      Width = 145
      Height = 21
      Hint = 'Select function to validate and benchmark'
      Color = clInfoBk
      DropDownCount = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'Move_RTL_IA32_1'
      OnChange = FunctionSelectComboBoxChange
      Items.Strings = (
        'Move_RTL_IA32_1'
        'Move_RTL_PAS_1'
        'Move_JOH_PAS_10'
        'Move_JOH_IA32_10'
        'Move_JOH_MMX_10'
        'Move_JOH_SSE_10'
        'Move_JOH_SSE2_10'
        'Move_JOH_SSE3_10'
        'Move_RL_IA32_1'
        'Move_DKC_IA32_5'
        'Move_DKC_SSE_1'
        'Move_DKC_SSE3_1'
        'Move_DKC_SSE2_3'
        'Move_DKC_IA32_1'
        'Move_DKC_IA32_2'
        'Move_DKC_IA32_4'
        'Move_DKC_Pas_16'
        'Move_DKC_Pas_37'
        'Move_DKC_Pas_38')
    end
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 608
    Width = 681
    Height = 16
    Smooth = True
    TabOrder = 5
  end
  object SummedArraySizeEdit: TEdit
    Left = 16
    Top = 496
    Width = 785
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'SummedArraySizeEdit'
  end
  object ValidateButton: TButton
    Left = 488
    Top = 403
    Width = 97
    Height = 41
    Caption = 'Validate'
    TabOrder = 7
    OnClick = ValidateButtonClick
  end
  object ErrorEdit: TEdit
    Left = 472
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
    TabOrder = 8
    Text = 'ErrorEdit'
  end
  object AllBenchmarkEdit: TEdit
    Left = 16
    Top = 576
    Width = 785
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Text = 'AllBenchmarkEdit'
  end
  object RunResultsGroupBox: TGroupBox
    Left = 8
    Top = 48
    Width = 153
    Height = 233
    TabOrder = 10
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 95
      Height = 13
      Caption = 'NoOfMBytesPerSec'
    end
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 39
      Height = 13
      Caption = 'Runtime'
    end
    object Label4: TLabel
      Left = 16
      Top = 144
      Width = 72
      Height = 13
      Caption = 'AddressSource'
    end
    object Label5: TLabel
      Left = 16
      Top = 184
      Width = 60
      Height = 13
      Caption = 'AddressDest'
    end
    object RunTimeEdit: TEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'RunTimeEdit'
    end
    object NoOfMBytesPerSecEdit: TEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'NoOfMBytesPerSecEdit'
    end
    object ArraySizeLabeledEdit: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      Color = clInfoBk
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'ArraySize [B]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'ArraySizeLabeledEdit'
    end
    object AddressSourceEdit: TEdit
      Left = 16
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
      TabOrder = 3
      Text = 'AddressSourceEdit'
    end
    object AddressDestEdit: TEdit
      Left = 16
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
      TabOrder = 4
      Text = 'AddressDestEdit'
    end
  end
  object RunStatisticsGroupBox: TGroupBox
    Left = 8
    Top = 288
    Width = 153
    Height = 185
    TabOrder = 11
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 115
      Height = 13
      Caption = 'NoOfMBytesPerSecMax'
    end
    object Label9: TLabel
      Left = 16
      Top = 56
      Width = 112
      Height = 13
      Caption = 'NoOfMBytesPerSecMin'
    end
    object Label10: TLabel
      Left = 16
      Top = 16
      Width = 119
      Height = 13
      Caption = 'NoOfMBytesPerSecTotal'
    end
    object Label11: TLabel
      Left = 16
      Top = 136
      Width = 135
      Height = 13
      Caption = 'NoOfMBytesPerSecAverage'
    end
    object NoOfMBytesPerSecMaxEdit: TEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'NoOfMBytesPerSecMaxEdit'
    end
    object NoOfMBytesPerSecMinEdit: TEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'NoOfMBytesPerSecMinEdit'
    end
    object NoOfMBytesPerSecTotalEdit: TEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'NoOfMBytesPerSecTotalEdit'
    end
    object NoOfMBytesPerSecAverageEdit: TEdit
      Left = 16
      Top = 152
      Width = 121
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'NoOfMBytesPerSecAverageEdit'
      OnClick = NoOfMBytesPerSecAverageEditClick
    end
  end
  object BenchmarkResultsGroupBox: TGroupBox
    Left = 664
    Top = 48
    Width = 145
    Height = 257
    TabOrder = 12
    object Label18: TLabel
      Left = 8
      Top = 8
      Width = 85
      Height = 13
      Caption = 'Sub Benchmark 1'
    end
    object Label19: TLabel
      Left = 8
      Top = 48
      Width = 85
      Height = 13
      Caption = 'Sub Benchmark 2'
    end
    object Label20: TLabel
      Left = 8
      Top = 88
      Width = 85
      Height = 13
      Caption = 'Sub Benchmark 3'
    end
    object Label21: TLabel
      Left = 8
      Top = 208
      Width = 54
      Height = 13
      Caption = 'Benchmark'
    end
    object Label22: TLabel
      Left = 8
      Top = 128
      Width = 85
      Height = 13
      Caption = 'Sub Benchmark 4'
    end
    object Label23: TLabel
      Left = 8
      Top = 168
      Width = 85
      Height = 13
      Caption = 'Sub Benchmark 5'
    end
    object SubBenchmark5SpeedButton: TSpeedButton
      Left = 104
      Top = 184
      Width = 23
      Height = 22
      OnClick = SubBenchmark5SpeedButtonClick
    end
    object SubBenchmark4SpeedButton: TSpeedButton
      Left = 104
      Top = 144
      Width = 23
      Height = 22
      OnClick = SubBenchmark4SpeedButtonClick
    end
    object SubBenchmark3SpeedButton: TSpeedButton
      Left = 104
      Top = 104
      Width = 23
      Height = 22
      OnClick = SubBenchmark3SpeedButtonClick
    end
    object SubBenchmark2SpeedButton: TSpeedButton
      Left = 104
      Top = 64
      Width = 23
      Height = 22
      OnClick = SubBenchmark2SpeedButtonClick
    end
    object SubBenchmark1SpeedButton: TSpeedButton
      Left = 104
      Top = 24
      Width = 23
      Height = 22
      OnClick = SubBenchmark1SpeedButtonClick
    end
    object SubBenchmark1Edit: TEdit
      Left = 8
      Top = 24
      Width = 89
      Height = 21
      Hint = 'Click and text is copied to clipboard'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'SubBenchmark1Edit'
      OnClick = SubBenchmark1EditClick
    end
    object SubBenchmark2Edit: TEdit
      Left = 8
      Top = 64
      Width = 89
      Height = 21
      Hint = 'Click and text is copied to clipboard'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'SubBenchmark2Edit'
      OnClick = SubBenchmark2EditClick
    end
    object SubBenchmark3Edit: TEdit
      Left = 8
      Top = 104
      Width = 89
      Height = 21
      Hint = 'Click and text is copied to clipboard'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = 'SubBenchmark3Edit'
      OnClick = SubBenchmark3EditClick
    end
    object BenchmarkEdit: TEdit
      Left = 8
      Top = 224
      Width = 121
      Height = 21
      Hint = 'Click and text is copied to clipboard'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = 'BenchmarkEdit'
      OnClick = BenchmarkEditClick
    end
    object SubBenchmark4Edit: TEdit
      Left = 8
      Top = 144
      Width = 89
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'SubBenchmark4Edit'
      OnClick = SubBenchmark4EditClick
    end
    object SubBenchmark5Edit: TEdit
      Left = 8
      Top = 184
      Width = 89
      Height = 21
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'SubBenchmark5Edit'
      OnClick = SubBenchmark5EditClick
    end
  end
  object BestBenchmarkEdit: TEdit
    Left = 672
    Top = 328
    Width = 121
    Height = 21
    Hint = 'Click and text is copied to clipboard'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    Text = 'BestBenchmarkEdit'
    OnClick = BestBenchmarkEditClick
  end
  object PageControl: TPageControl
    Left = 168
    Top = 48
    Width = 489
    Height = 313
    ActivePage = GraphTabSheet
    TabOrder = 14
    object GraphTabSheet: TTabSheet
      Caption = 'Graph'
      ImageIndex = 1
      object Chart1: TChart
        Left = 8
        Top = 8
        Width = 465
        Height = 273
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Logarithmic = True
        BottomAxis.Maximum = 4000000.000000000000000000
        BottomAxis.Minimum = 0.750000000000000000
        Legend.Visible = False
        View3D = False
        TabOrder = 0
        object Series1: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clRed
          ShowInLegend = False
          BarPen.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series2: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clRed
          ShowInLegend = False
          BarPen.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series3: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clRed
          ShowInLegend = False
          BarPen.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series5: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clRed
          ShowInLegend = False
          BarPen.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series6: TLineSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clBlue
          ShowInLegend = False
          LinePen.Color = clLime
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
        object Series4: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
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
    end
    object ReportTabSheet: TTabSheet
      Caption = 'Report'
      ImageIndex = 3
      object ReportRichEdit: TRichEdit
        Left = 8
        Top = 8
        Width = 465
        Height = 265
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
        ScrollBars = ssVertical
        TabOrder = 0
        WantTabs = True
      end
    end
  end
  object BenchmarkTwiceButton: TButton
    Left = 688
    Top = 400
    Width = 81
    Height = 25
    Caption = 'Bench Twice'
    TabOrder = 15
    OnClick = BenchmarkTwiceButtonClick
  end
  object BenchThreeTimesButton: TButton
    Left = 688
    Top = 432
    Width = 81
    Height = 25
    Caption = 'Bench 3 Times'
    TabOrder = 16
    OnClick = BenchThreeTimesButtonClick
  end
  object BenchmarkAllButton: TButton
    Left = 688
    Top = 464
    Width = 81
    Height = 25
    Hint = 'Benchmark All'
    Caption = 'Bench All'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = BenchmarkAllButtonClick
  end
  object ValidateAllButton: TButton
    Left = 488
    Top = 465
    Width = 97
    Height = 25
    Caption = 'Validate all'
    TabOrder = 18
    OnClick = ValidateAllButtonClick
  end
  object ReportSaveDialog: TSaveDialog
    Left = 784
    Top = 408
  end
  object TextSaveDialog: TSaveDialog
    Left = 784
    Top = 376
  end
end
