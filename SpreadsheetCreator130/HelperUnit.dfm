object HelperForm: THelperForm
  Left = 8
  Top = 77
  Caption = 'HelperForm'
  ClientHeight = 594
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 60
    Height = 13
    Caption = 'All Functions'
  end
  object Label2: TLabel
    Left = 320
    Top = 24
    Width = 87
    Height = 13
    Caption = 'Function Sizes File'
  end
  object Label3: TLabel
    Left = 608
    Top = 24
    Width = 68
    Height = 13
    Caption = 'Errors/Actions'
  end
  object AllFunctionsRichEdit: TRichEdit
    Left = 16
    Top = 40
    Width = 297
    Height = 505
    Lines.Strings = (
      'AllFunctionsRichEdit')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object FunctionSizesRichEdit: TRichEdit
    Left = 320
    Top = 40
    Width = 281
    Height = 505
    Lines.Strings = (
      'FunctionSizesRichEdit')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MatchRichEdit: TRichEdit
    Left = 608
    Top = 40
    Width = 273
    Height = 506
    Lines.Strings = (
      'MatchRichEdit')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 792
    Top = 552
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object CompareButton: TButton
    Left = 280
    Top = 561
    Width = 75
    Height = 25
    Hint = 'Compare lists line by line'
    Caption = 'Compare'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = CompareButtonClick
  end
end
