object OptionsForm: TOptionsForm
  Left = 212
  Top = 110
  Width = 424
  Height = 309
  Caption = 'Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CloseBitBtn: TBitBtn
    Left = 328
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkClose
  end
  object SortReportByRadioGroup: TRadioGroup
    Left = 80
    Top = 32
    Width = 185
    Height = 201
    Caption = 'Sort Report By'
    Items.Strings = (
      'Subbenchmark 1'
      'Subbenchmark 2'
      'Subbenchmark 3'
      'Subbenchmark 4'
      'Subbenchmark 5'
      'Benchmark')
    TabOrder = 1
    OnClick = SortReportByRadioGroupClick
  end
end
