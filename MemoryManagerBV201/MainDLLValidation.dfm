object Form1: TForm1
  Left = 232
  Top = 159
  Width = 617
  Height = 454
  Caption = 'FastCode MM Challenge DLL Validation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    609
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object btnValidate: TButton
    Left = 8
    Top = 8
    Width = 173
    Height = 25
    Caption = 'Validate Selected MM'
    TabOrder = 0
    OnClick = btnValidateSelectedClick
  end
  object ListView1: TListView
    Left = 8
    Top = 40
    Width = 593
    Height = 353
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Memory Manager'
        Width = 200
      end
      item
        Caption = 'Validation Result'
        Width = 350
      end>
    HideSelection = False
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 408
    Width = 609
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object btnValidateAll: TButton
    Left = 200
    Top = 8
    Width = 173
    Height = 25
    Caption = 'Validate All MM'
    TabOrder = 3
    OnClick = btnValidateAllClick
  end
end
