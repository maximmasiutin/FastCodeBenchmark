object MainForm: TMainForm
  Left = 255
  Top = 98
  Caption = 'FastCode Benchmark & Validation Utility'
  ClientHeight = 550
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl: TTabControl
    Left = 0
    Top = 29
    Width = 800
    Height = 486
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Challenge1')
    TabIndex = 0
    OnChange = TabControlChange
    DesignSize = (
      800
      486)
    object LabelFunctionSelection: TLabel
      Left = 12
      Top = 28
      Width = 86
      Height = 13
      Caption = 'Function selection'
    end
    object LabelAuthor: TLabel
      Left = 12
      Top = 433
      Width = 45
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'By author'
      ExplicitTop = 452
    end
    object LabelCategory: TLabel
      Left = 12
      Top = 405
      Width = 56
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'By category'
      ExplicitTop = 424
    end
    object LabelSelectAll: TLabel
      Left = 12
      Top = 377
      Width = 61
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '(De)select all'
      ExplicitTop = 396
    end
    object LabelResults: TLabel
      Left = 324
      Top = 28
      Width = 54
      Height = 13
      Caption = 'Test results'
    end
    object LabelLog: TLabel
      Left = 324
      Top = 234
      Width = 47
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Result log'
      ExplicitTop = 253
    end
    object LabelSpread: TLabel
      Left = 324
      Top = 208
      Width = 37
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Spread:'
      ExplicitTop = 227
    end
    object CheckListBoxFunction: TCheckListBox
      Left = 12
      Top = 44
      Width = 301
      Height = 318
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
    end
    object ComboBoxAuthor: TComboBox
      Left = 72
      Top = 429
      Width = 125
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      ItemHeight = 13
      TabOrder = 6
    end
    object ComboBoxCategory: TComboBox
      Left = 72
      Top = 401
      Width = 125
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      ItemHeight = 13
      TabOrder = 3
    end
    object ButtonAuthorSelect: TButton
      Left = 200
      Top = 431
      Width = 53
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Select'
      TabOrder = 7
      OnClick = ButtonAuthorSelectClick
    end
    object ButtonAuthorDeselect: TButton
      Left = 259
      Top = 431
      Width = 56
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Deselect'
      TabOrder = 8
      OnClick = ButtonAuthorDeselectClick
    end
    object ButtonCategorySelect: TButton
      Left = 200
      Top = 400
      Width = 53
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Select'
      TabOrder = 4
      OnClick = ButtonCategorySelectClick
    end
    object ButtonCategoryDeselect: TButton
      Left = 259
      Top = 400
      Width = 54
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Deselect'
      TabOrder = 5
      OnClick = ButtonCategoryDeselectClick
    end
    object ButtonAllSelect: TButton
      Left = 200
      Top = 369
      Width = 53
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Select'
      TabOrder = 1
      OnClick = ButtonAllSelectClick
    end
    object ButtonAllDeselect: TButton
      Left = 259
      Top = 369
      Width = 54
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Deselect'
      TabOrder = 2
      OnClick = ButtonAllDeselectClick
    end
    object ListViewResults: TListView
      Left = 324
      Top = 44
      Width = 455
      Height = 157
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      ReadOnly = True
      SmallImages = SortImageList
      SortType = stData
      TabOrder = 9
      TabStop = False
      ViewStyle = vsReport
      OnColumnClick = ListViewResultsColumnClick
      OnColumnRightClick = ListViewResultsColumnRightClick
      OnCompare = ListViewResultsCompare
    end
    object MemoLog: TMemo
      Left = 324
      Top = 250
      Width = 455
      Height = 112
      Anchors = [akLeft, akRight, akBottom]
      Color = clInfoBk
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 11
    end
    object ButtonValidateSel: TButton
      Left = 348
      Top = 368
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Validate selected'
      TabOrder = 12
      OnClick = ButtonValidateSelClick
    end
    object ButtonValidateAll: TButton
      Left = 348
      Top = 399
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Validate all'
      TabOrder = 13
      OnClick = ButtonValidateAllClick
    end
    object ButtonBenchmarkAll: TButton
      Left = 504
      Top = 399
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Benchmark all'
      TabOrder = 15
      OnClick = ButtonBenchmarkAllClick
    end
    object ButtonBenchmarkSel: TButton
      Left = 504
      Top = 368
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Benchmark selected'
      TabOrder = 14
      OnClick = ButtonBenchmarkSelClick
    end
    object ButtonReportShow: TButton
      Left = 660
      Top = 368
      Width = 113
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = 'Show report'
      TabOrder = 17
      OnClick = ButtonReportShowClick
    end
    object ButtonReportCopy: TButton
      Left = 660
      Top = 396
      Width = 113
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = 'Report to clipboard'
      TabOrder = 18
      OnClick = ButtonReportCopyClick
    end
    object ButtonBenchmarkSpread: TButton
      Left = 504
      Top = 431
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Benchmark all 10'#215
      TabOrder = 16
      OnClick = ButtonBenchmarkSpreadClick
    end
    object EditSpread: TEdit
      Left = 368
      Top = 204
      Width = 105
      Height = 21
      Anchors = [akLeft, akBottom]
      ReadOnly = True
      TabOrder = 10
    end
    object BreakOnFailCheckBox: TCheckBox
      Left = 348
      Top = 431
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Break on Failure'
      TabOrder = 19
      OnClick = BreakOnFailCheckBoxClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 36
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Export (CSV)'
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
      OnClick = MenuItemReportFileCSVClick
    end
    object SpeedButton2: TSpeedButton
      Left = 4
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Save (tab-separated)'
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
      OnClick = MenuItemReportFileTabSeparatedClick
    end
    object SpeedButton3: TSpeedButton
      Left = 68
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Exit'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = MenuItemExitClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 515
    Width = 800
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 531
    Width = 800
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PopupMenuResultColumns: TPopupMenu
    Left = 140
    Top = 44
    object PopupMenuResultColumnsItem1: TMenuItem
      Caption = '&Name'
      Enabled = False
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem2: TMenuItem
      Tag = 1
      Caption = '&Alignment'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem3: TMenuItem
      Tag = 2
      Caption = '&Category'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem4: TMenuItem
      Tag = 3
      Caption = 'A&uthor'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem5: TMenuItem
      Tag = 4
      Caption = '&Validation status'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem6: TMenuItem
      Tag = 5
      Caption = 'Benchmark &result'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem7: TMenuItem
      Tag = 6
      Caption = 'Benchmark result s&pread'
      OnClick = PopupMenuResultColumnsItemClick
    end
    object PopupMenuResultColumnsItem8: TMenuItem
      Tag = 7
      Caption = '&Subbenchmarks'
      OnClick = PopupMenuResultColumnsItemClick
    end
  end
  object SortImageList: TImageList
    Height = 7
    Width = 13
    Left = 172
    Top = 44
    Bitmap = {
      494C01010200040004000D000700FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000034000000070000000100200000000000B005
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000340000000700000001000100
      00000000380000000000000000000000000000000000000000000000FFFFFF00
      FDF8000000000000F8FC004000000000F07E00C000000000E03F01C000000000
      C01F83C000000000800FC7C0000000000007EFC0000000000000000000000000
      0000000000000000000000000000}
  end
  object MainMenu: TMainMenu
    Left = 204
    Top = 44
    object MenuItemFile: TMenuItem
      Caption = '&File'
      object MenuItemExit: TMenuItem
        Caption = '&Exit'
        OnClick = MenuItemExitClick
      end
    end
    object MenuItemSubchallenge: TMenuItem
      Caption = '&Subchallenge'
      object MenuItemSubValidate: TMenuItem
        Caption = '&Validate all'
        OnClick = ButtonValidateAllClick
      end
      object MenuItemSubBenchmark: TMenuItem
        Caption = '&Benchmark all'
        OnClick = ButtonBenchmarkAllClick
      end
    end
    object MenuItemGlobal: TMenuItem
      Caption = '&Global'
      object MenuItemValidate: TMenuItem
        Caption = '&Validate all'
        ShortCut = 16470
        OnClick = MenuItemValidateClick
      end
      object MenuItemBenchmark: TMenuItem
        Caption = '&Benchmark all'
        ShortCut = 16450
        OnClick = MenuItemBenchmarkClick
      end
      object MenuItemReport: TMenuItem
        Caption = '&Report'
        ShortCut = 16466
        OnClick = MenuItemReportClick
      end
      object MenuItemReportClipboard: TMenuItem
        Caption = 'Report to &Clipboard'
        ShortCut = 16460
        OnClick = MenuItemReportClipboardClick
      end
      object MenuItemReportFile: TMenuItem
        Caption = 'Report to &File'
        object MenuItemReportFileCSV: TMenuItem
          Caption = '&CSV'
          ShortCut = 16467
          OnClick = MenuItemReportFileCSVClick
        end
        object MenuItemReportFileTabSeparated: TMenuItem
          Caption = '&Tab separated'
          OnClick = MenuItemReportFileTabSeparatedClick
        end
      end
    end
  end
  object SaveDialogReport: TSaveDialog
    DefaultExt = '.txt'
    Filter = 
      'Text and CSV files (*.txt; *.csv)|*.txt; *.csv|All files (*.*)|*' +
      '.*'
    Title = 'Save report'
    Left = 236
    Top = 44
  end
end
