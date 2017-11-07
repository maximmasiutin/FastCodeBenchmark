object ReportForm: TReportForm
  Left = 265
  Top = 116
  Width = 680
  Height = 531
  Caption = 'Benchmark report'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtonContainer: TPanel
    Left = 0
    Top = 459
    Width = 672
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ButtonCopy: TButton
      Left = 12
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Copy to clipboard'
      TabOrder = 0
      OnClick = ButtonCopyClick
    end
    object ButtonClose: TButton
      Left = 140
      Top = 8
      Width = 113
      Height = 25
      Cancel = True
      Caption = 'Close form'
      TabOrder = 1
      OnClick = ButtonCloseClick
    end
  end
  object RichEditReport: TRichEdit
    Left = 0
    Top = 0
    Width = 672
    Height = 459
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
end
