object ImageForm: TImageForm
  Left = 51
  Top = 89
  Width = 1057
  Height = 702
  Caption = 'ImageForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 56
    Width = 513
    Height = 369
  end
  object Image2: TImage
    Left = 528
    Top = 56
    Width = 513
    Height = 369
  end
  object Label1: TLabel
    Left = 472
    Top = 440
    Width = 27
    Height = 13
    Caption = 'Scale'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1049
    Height = 41
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 16
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
  end
  object BitBtn1: TBitBtn
    Left = 912
    Top = 616
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkClose
  end
  object ScaleDownButton: TButton
    Left = 472
    Top = 520
    Width = 81
    Height = 49
    Caption = 'Scale Down'
    Enabled = False
    TabOrder = 2
    OnClick = ScaleDownButtonClick
  end
  object Edit1: TEdit
    Left = 72
    Top = 464
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 72
    Top = 504
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 72
    Top = 544
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 72
    Top = 584
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit4'
  end
  object RadioGroup1: TRadioGroup
    Left = 256
    Top = 480
    Width = 185
    Height = 185
    Caption = 'RadioGroup1'
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'ScaleDownRMKPas1'
      'ScaleDownDKCPas1'
      'ScaleDownDKCPas2'
      'ScaleDownDKCPas3'
      'ScaleDownDKCPas4'
      'ScaleDownDKCPas5'
      'ScaleDownDKCPas6'
      'ScaleDownDKCPas7'
      'ScaleDownDKCPas8'
      'ScaleDownDKCPas9'
      'ScaleDownDKCPas10')
    TabOrder = 7
    OnClick = ScaleDownButtonClick
  end
  object ScaleEdit: TEdit
    Left = 456
    Top = 488
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'ScaleEdit'
  end
  object TrackBar1: TTrackBar
    Left = 248
    Top = 432
    Width = 529
    Height = 45
    Enabled = False
    Max = 100
    Min = 10
    Orientation = trHorizontal
    Frequency = 1
    Position = 10
    SelEnd = 0
    SelStart = 0
    TabOrder = 9
    TickMarks = tmBottomRight
    TickStyle = tsAuto
    OnChange = TrackBar1Change
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 24
    Top = 440
  end
end
