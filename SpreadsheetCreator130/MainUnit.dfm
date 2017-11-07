object MainForm: TMainForm
  Left = 163
  Top = 101
  BorderStyle = bsSingle
  Caption = 'Fastcode Spreadsheet Creator 2008 version 1.3.0'
  ClientHeight = 626
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 24
    Top = 72
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 947
    Height = 41
    Align = alTop
    TabOrder = 2
    object AboutSpeedButton: TSpeedButton
      Left = 58
      Top = 8
      Width = 28
      Height = 28
      Hint = 'About Spreadsheet Creator'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDDBAA9D0B5AACCB0
        A4DCB7A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE0BDAF
        CCC1BDBCB6B6ADA5A5AF9F9AD5B2A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFE0BDAFDCD1D0D1CFD0C9C6C7BFB8BAADA5A5AD9D99D4B4A4FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFE1BFAFE6DCDAE2E2E3DCDADDD0BCB5C7B2ABBFBABBAFA6A7AC
        9D98D5B4A5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFE2C1B1EDE5E2EEEFF3E9E9EBD09174C05223C052
        23C28164BFB8BAAFA7A9AD9D99D3B1A3FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFE2C0B0F2EBE9F4F8FBF3F7FBD3906F
        BA400FBA4111BB4112BB4111C17958C0BABAAFA7A9A99A97D3B1A3FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE1BDADF4EDE9FBFEFFF8
        FEFFD99F82C25627D9906DDD9C7BDD9C7BD9906DC45424C17653BFBABBAFA7A9
        A99A97D3B1A3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE1BDADF6ED
        E9FEFFFFFEFFFFDEA68BBC4919BC4919DD9D7EFFFFFFFFFFFFDA9776BD4A1ABF
        4918C27B5BBFB8BAB0A9AAAB9C98D3B1A3FF00FFFF00FFFF00FFFF00FFFF00FF
        E1BFAFF8F0EEFFFFFFFFFFFFE0A588BD4A1ABD4B1CBC4716D17F56FFFFFFFFFF
        FFCF784FBC4718BF4E1EBF4A18C17552C0B7B7B0A9AAA99A97CEAFA1FF00FFFF
        00FFFF00FFE1BCACF8EFEBFFFFFFFFFFFFE7B79DC55926C45424C05122BC4716
        D38159FFFFFFFFFFFFD07A52BC4718BF4E1FBF4E1EBF4918C1724EBDB5B5AFA7
        A9A69997CEAFA1FF00FFE0BAA9F4E9E2FFFFFFFFFFFFEECAB0CF703ACB6833C9
        6430C65C2AC04D1CD4825AFFFFFFFFFFFFD07A52BC4718BF4E1FBF4E1FBF4E1E
        BF4717C17857BFB8BAAFA6A5AA9A97D8B5A5E7CABCFFFFFFFFFFFFFEFBF8DC93
        5DD47A41D17740CF703ACC6935C55926D78A63FFFFFFFFFFFFD07A52BC4718BF
        4E1FBF4E1FBF4E1FBF4C1DC05021C6B0A7BFBABBAFA6A5CBAFA4E7C9BCFFFFFF
        FFFFFFFEFBF8E2A069DA894BD8844AD47D44D1763FCB6730DA926AFFFFFFFFFF
        FFD17D54BC4718BF4E1FBF4E1FBF4E1FBD4A1AC05628D1C0BBC9C6C7BDB6B6D3
        B5A9E0BAA9F6E9E3FFFFFFFFFFFFF4DCC2E19A5CDD8F52DA894FD78248D07239
        E1A37BFFFFFFFFFFFFD5875EC04F1DC0501FBF4E1FBD4B1CBD4A1AD4A088DCDD
        E0D1CFD0CFC0BCE0BAA9FF00FFE1BCACF8EFEAFFFFFFFFFFFFF4DCC0E29E5FDE
        9556DA8E51DC8E56EEC6A9F4DECEF4DDCCD78658C75C28C55A28C0501FBD4B1C
        D89F84E9EDF0E2E2E3DCCFCBE0BBABFF00FFFF00FFFF00FFE1BCACF6EBE5FFFF
        FFFFFFFFF7E2CAE6A667E19A5AE0985CDD9055D9884ED58047D0743CCE6E38CA
        6530C65C28E0AF97F2F7FBEDEFF2E5D9D5E0BBABFF00FFFF00FFFF00FFFF00FF
        FF00FFE0BBABF4E9E2FFFFFFFFFFFFF8E5CEE9AC6DE29D5BE3A56DF7E3D3F6DE
        CEDA8C57D1763DCF6F37E7B79DF8FEFFF4F8FBEDE2DEE0BCACFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFE0BBABF4E9E3FFFFFFFFFFFFFAE9D3E9AB67
        EFC99EFFFFFFFFFFFFE7B287D57D3FE9BB9CFEFFFFFBFEFFF0E9E6E1BFAFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE1BCACF4E7E1FF
        FFFFFFFFFFF8E6CEEFC086F7E0C2F6DABDE3A065EEC7A5FFFFFFFEFFFFF6EDE9
        E2C0B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFE0BAA9F3E5DEFFFFFFFFFFFFFBEDD7F0C48AEBB77AF4D8B8FFFFFFFF
        FFFFF7EEEAE1BFAFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFE0BAA9F3E5DEFFFFFFFFFFFFFFFEFCFEFB
        F8FFFFFFFFFFFFFAF3F0E2C0B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE0BAA9F4E7E1
        FFFFFFFFFFFFFFFFFFFFFFFFFAF3F0E3C2B4FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFE0BAA9F2E0D7FEFCFCFFFEFEF7EEEAE3C2B2FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFE1BCABE6C5B7E7C9BCE1BCABFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = AboutSpeedButtonClick
    end
    object SpeedButton1: TSpeedButton
      Left = 12
      Top = 8
      Width = 28
      Height = 28
      Hint = 'Open folder settings dialog'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF019ACF019ACF019ACF019ACFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0D9FD18BD4EE6BD3F845C0ED28B0E0019ACF01
        9ACF019ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF069CD076C8E5A9E9FE6DD8
        FF75DBFF77DCFF77DBFF63D1F930B3E3029BD0019ACF019ACF019ACF019ACFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF
        34AFD9BCE9F86ED8FF6FD8FE70D8FE70D8FE71D8FF74DBFF7ADEFF79DDFF73D9
        FF5CCCF522ACDD019ACF019ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF019ACF1FA9D68FD3EB97E4FF6FD9FE71D9FE71D9FE71D9FE71D9FE
        71D9FE71D9FE73DAFE76DCFF7BDFFF7ADEFF78DCFF77DCFF019ACFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF019ACF31B1DC49B7DEBDEEFB71DDFE77DEFE77
        DEFE77DEFE77DEFE77DEFE77DEFE77DEFE76DEFE76DEFE76DEFE78DFFF7CE1FF
        65D2F8019ACFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF52C2E71DA7D5ADE2
        F38FE8FF7CE2FE7CE3FE7CE3FE7CE3FE7CE3FE7CE3FE7CE3FE7CE3FE7CE3FE7C
        E3FE7DE4FE7DE3FE5ED1F3019ACFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF
        60CAEF1FA8D85EC1E2BBF4FE7DE7FE82E8FE81E8FE81E8FE81E8FE81E8FE81E8
        FE81E8FE81E8FE81E8FE82E8FE84E9FE5ED3F18DEEFF019ACFFF00FFFF00FFFF
        00FFFF00FF019ACF65CFF53EB7E529ACD8BFEEF88DEFFF993300993300993300
        99330099330099330099330099330099330099330099330065D9F396F5FF019A
        CFFF00FFFF00FFFF00FFFF00FF019ACF69D1F855C4F31FA7D773CBE7C5FCFF99
        3300FEFEFEFEFEFEFEFEFEFEFEFEDFE5FE325BFCEEF1FEFEFEFEFEFEFE993300
        6ADEF395F8FF98FAFF019ACFFF00FFFF00FFFF00FF019ACF77D5FC5CC8FB3EB8
        E920A7D5B6E6F3993300FEFEFEFEFEFEFEFEFEAFBFFD1342FB0335FBA0B2FDFE
        FEFEFEFEFE99330071E3F39FFCFFA4FFFF43C1E2019ACFFF00FFFF00FF019ACF
        8BDBFF5FCDFF64CDFE2CAFE30D9FD3993300FEFEFEFEFEFE718DFC0335FB0335
        FB0335FB224EFBFEFEFEFEFEFE99330083E4F3B6FDFFBAFFFFB5FCFD019ACFFF
        00FFFF00FF019ACF99E2FF67D3FF6DD4FE6CD4FE69D1FE993300EEF1FE325BFC
        0335FB0335FB718DFC1342FB0335FBAFBFFDFEFEFE9933009CE4F2DAFEFFD9FE
        FFE3FFFFADE9F5019ACFFF00FF019ACF9FE9FF70DCFF76DDFE76DDFE76DDFE99
        3300224EFB0335FB1342FBAFBFFDFEFEFE8099FC0335FB224EFBFEFEFE993300
        CEEEF7F8FFFFF7FFFFFEFFFFE9F9FD019ACFFF00FF019ACFA7EFFF76E5FF7CE5
        FF7CE5FF7CE5FF993300A0B2FD325BFCCFD8FDFEFEFEFEFEFEEEF1FE1342FB03
        35FB8099FC993300019ACF019ACF019ACF019ACF019ACF019ACFFF00FF019ACF
        ABF6FF7EEDFF85ECFF85ECFF85ECFF993300FEFEFEFEFEFEFEFEFEFEFEFEFEFE
        FEFEFEFEA0B2FD0335FB0335FB7D332F019ACFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF019ACFC7FFFF82F5FF8FF5FF8FF5FF8FF5FF993300FEFEFEFEFEFE
        FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE5274FC0335FB0C35EB0194D2FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF019ACFA4E0F0A0FDFF8AFCFF90FCFF90FCFF99
        3300FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEEEF1FE325BFC0335FB
        0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACFECFFFFBCFF
        FFBCFFFFBCFFFF99330099330099330099330099330099330099330099330099
        33007D332F0C35EB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF019ACF019ACF019ACF019ACF019ACF019ACFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FB0335FBFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335
        FB0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = SpeedButton1Click
    end
    object Label5: TLabel
      Left = 152
      Top = 12
      Width = 92
      Height = 14
      Caption = 'Challenge Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Bodoni MT Black'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 608
      Top = 12
      Width = 43
      Height = 14
      Caption = 'Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Bodoni MT Black'
      Font.Style = []
      ParentFont = False
    end
    object ChallengeNameEdit: TEdit
      Left = 244
      Top = 8
      Width = 345
      Height = 22
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'Bodoni MT Black'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'ChallengeNameEdit'
    end
    object ChallengeVersionNumberEdit: TEdit
      Left = 656
      Top = 8
      Width = 121
      Height = 22
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -11
      Font.Name = 'Bodoni MT Black'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'ChallengeVersionNumberEdit'
    end
  end
  object CloseBitBtn: TBitBtn
    Left = 856
    Top = 575
    Width = 80
    Height = 42
    Hint = 'Close Spreasheet Creator'
    Caption = '&Close'
    TabOrder = 4
    OnClick = CloseBitBtnClick
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF153EE10732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF0632E10632E1153EE1FF00FFFF00FF5472E90732DE0732DEFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF0632E10632E1153EE1FF00FFFF00FFFF00FF4565E6
      0732DE0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF738CF00632E10632E1153EE1FF00FFFF00FFFF
      00FFFF00FFFF00FF0732DE0732DE0732DE0632E1FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF637FF00632E10533E9153EE1FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF153EE10732DE0632E10632E1FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF637FF00533E90533E9
      153EE1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3558
      E60632E10632E10632E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3459EE05
      33E90632E1143FECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF5472E90632E10533E90533E9FF00FFFF00FFFF00FFFF00
      FF3459EE0533E90533E9143FECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8298F10533E90533E90533E9
      FF00FFFF00FF3459EE0533E90533E9143FECFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF143FEC0533E90533E90533E90533E90533E9143FECFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF244CEE0533E90434F50434F5143FECFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1440F00434F50533E90434
      F5335AF2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0434F50533E9
      0434F50533E90434F50434F5335AF2FF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF04
      34F50434F50533E9335AF2FF00FFFF00FF0434F50434F5325BF9FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF6180F90434F50434F50533E9335AF2FF00FFFF00FFFF00FFFF00FF1341F703
      35F9325BF9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF6180F90434F50434F50434F5335AF2FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF325BF90335F9325BF9FF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF6180F90434F50434F50434F5335AF2FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6180F90335F9325BF9FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF325BF90335F90335F90434F5335AF2FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8099FC
      0335F91341F7FF00FFFF00FFFF00FFFF00FFFF00FF325BF90335F90335F90434
      F5325BF9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF1341F76180F9FF00FFFF00FFFF00FFFF00FF0335F9
      0335F90335F9325BF9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FF325BF90335F9325BF9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 60
    Width = 929
    Height = 509
    ActivePage = WinnersTabSheet
    TabOrder = 6
    object PenrynTabSheet: TTabSheet
      Caption = 'Penryn'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object FunctionNameLabel: TLabel
        Left = 8
        Top = 13
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object PenrynCol2Label: TLabel
        Left = 176
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Align'
      end
      object PenrynCol3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object PenrynCol4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object PenrynCol5Label: TLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object PenrynCol6Label: TLabel
        Left = 424
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 4'
      end
      object PenrynCol7Label: TLabel
        Left = 504
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 5'
      end
      object PenrynCol8Label: TLabel
        Left = 568
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object PenrynCPUTypeLabeledEdit: TLabeledEdit
        Left = 624
        Top = 32
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 0
      end
      object PenrynStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 1
        RowHeights = (
          24)
      end
      object PenrynSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object NorthwoodTabSheet: TTabSheet
      Caption = 'Northwood'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object NorthwoodCol2Label: TLabel
        Left = 176
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object NorthwoodCol3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object NorthwoodCol4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object NorthwoodCol5Label: TLabel
        Left = 360
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object NorthwoodCol6Label: TLabel
        Left = 424
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object NorthwoodCol7Label: TLabel
        Left = 488
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object NorthwoodCol8Label: TLabel
        Left = 552
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object NorthwoodStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 0
        RowHeights = (
          24)
      end
      object NorthwoodCPUTypeLabeledEdit: TLabeledEdit
        Left = 624
        Top = 32
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 1
      end
      object NorthwoodSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object YonahTabSheet: TTabSheet
      Caption = 'Yonah'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label6: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object YonahCol2Label: TLabel
        Left = 176
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Align'
      end
      object YonahCol3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object YonahCol4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object YonahCol5Label: TLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object YonahCol6Label: TLabel
        Left = 424
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 4'
      end
      object YonahCol7Label: TLabel
        Left = 504
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 5'
      end
      object YonahCol8Label: TLabel
        Left = 568
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object YonahCPUTypeLabeledEdit: TLabeledEdit
        Left = 624
        Top = 32
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 0
      end
      object YonahStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 1
        RowHeights = (
          24)
      end
      object YonahSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object ConroeTabSheet: TTabSheet
      Caption = 'Conroe'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label11: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object ConroeCol2Label: TLabel
        Left = 176
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Align'
      end
      object ConroeCol3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object ConroeCol4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object ConroeCol5Label: TLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object ConroeCol6Label: TLabel
        Left = 424
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 4'
      end
      object ConroeCol7Label: TLabel
        Left = 488
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 5'
      end
      object ConroeCol8Label: TLabel
        Left = 552
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object ConroeCPUTypeLabeledEdit: TLabeledEdit
        Left = 621
        Top = 31
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 0
      end
      object ConroeStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 1
        RowHeights = (
          24)
      end
      object ConroeSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object PhenomTabSheet: TTabSheet
      Caption = 'Phenom'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label16: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object PhenomCol2Label: TLabel
        Left = 176
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Align'
      end
      object PhenomCol3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object PhenomCol4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object PhenomCol5Label: TLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object PhenomCol6Label: TLabel
        Left = 424
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 4'
      end
      object PhenomCol7Label: TLabel
        Left = 488
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 5'
      end
      object PhenomCol8Label: TLabel
        Left = 552
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object PhenomStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 0
        RowHeights = (
          24)
      end
      object PhenomCPUTypeLabeledEdit: TLabeledEdit
        Left = 624
        Top = 32
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 1
      end
      object PhenomSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object AMD64X2TabSheet: TTabSheet
      Caption = 'AMD 64 X2'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label21: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object AMD64X2Col2Label: TLabel
        Left = 176
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Align'
      end
      object AMD64X2Col3Label: TLabel
        Left = 236
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 1'
      end
      object AMD64X2Col4Label: TLabel
        Left = 296
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 2'
      end
      object AMD64X2Col5Label: TLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 3'
      end
      object AMD64X2Col6Label: TLabel
        Left = 424
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 4'
      end
      object AMD64X2Col7Label: TLabel
        Left = 496
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Subbench 5'
      end
      object AMD64X2Col8Label: TLabel
        Left = 552
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object AMD64X2StringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 615
        Height = 436
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 0
        RowHeights = (
          24)
      end
      object AMD64X2CPUTypeLabeledEdit: TLabeledEdit
        Left = 624
        Top = 32
        Width = 193
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'CPU Type'
        TabOrder = 1
      end
      object AMD64X2SpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 624
        Top = 80
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object BlendedTabSheet: TTabSheet
      Caption = 'Blended'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label26: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object Label30: TLabel
        Left = 176
        Top = 16
        Width = 34
        Height = 13
        Caption = 'Penryn'
      end
      object Label27: TLabel
        Left = 248
        Top = 16
        Width = 53
        Height = 13
        Caption = 'Northwood'
      end
      object Label28: TLabel
        Left = 320
        Top = 16
        Width = 30
        Height = 13
        Caption = 'Yonah'
      end
      object Label29: TLabel
        Left = 392
        Top = 16
        Width = 35
        Height = 13
        Caption = 'Dothan'
      end
      object Label31: TLabel
        Left = 464
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Phenom'
      end
      object Label32: TLabel
        Left = 528
        Top = 16
        Width = 52
        Height = 13
        Caption = 'AMD 64 X2'
      end
      object TotalLabel: TLabel
        Left = 608
        Top = 16
        Width = 24
        Height = 13
        Caption = 'Total'
      end
      object BlendedStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 689
        Height = 436
        FixedCols = 0
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        TabOrder = 0
        RowHeights = (
          24
          24
          24
          24
          24)
      end
      object CalculateBlendedButton: TButton
        Left = 732
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Calculate'
        Enabled = False
        TabOrder = 1
        OnClick = CalculateBlendedButtonClick
      end
      object BlendedSpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 703
        Top = 32
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 2
      end
    end
    object BlendedSizePenaltyTabSheet: TTabSheet
      Caption = 'Blended Size Penalty'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label33: TLabel
        Left = 8
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object Label34: TLabel
        Left = 176
        Top = 16
        Width = 34
        Height = 13
        Caption = 'Penryn'
      end
      object Label35: TLabel
        Left = 224
        Top = 16
        Width = 47
        Height = 13
        Caption = 'Nortwood'
      end
      object Label36: TLabel
        Left = 280
        Top = 16
        Width = 30
        Height = 13
        Caption = 'Yonah'
      end
      object Label37: TLabel
        Left = 328
        Top = 16
        Width = 35
        Height = 13
        Caption = 'Dothan'
      end
      object Label38: TLabel
        Left = 376
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Phenom'
      end
      object Label39: TLabel
        Left = 424
        Top = 16
        Width = 52
        Height = 13
        Caption = 'AMD 64 X2'
      end
      object Label40: TLabel
        Left = 488
        Top = 16
        Width = 24
        Height = 13
        Caption = 'Total'
      end
      object Label41: TLabel
        Left = 528
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Size'
      end
      object Label42: TLabel
        Left = 576
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Benchmark'
      end
      object BlendedSizePenaltyStringGrid: TStringGrid
        Left = 8
        Top = 32
        Width = 641
        Height = 436
        FixedCols = 0
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing]
        TabOrder = 0
        RowHeights = (
          24
          24
          24
          24
          24)
      end
      object PenaltyForSizeLabeledEdit: TLabeledEdit
        Left = 655
        Top = 72
        Width = 121
        Height = 21
        EditLabel.Width = 124
        EditLabel.Height = 13
        EditLabel.Caption = 'Penalty For Size Constant'
        TabOrder = 1
      end
      object CalculateBlendedSizePenaltyButton: TButton
        Left = 680
        Top = 107
        Width = 75
        Height = 25
        Caption = 'Calculate'
        Enabled = False
        TabOrder = 2
        OnClick = CalculateBlendedSizePenaltyButtonClick
      end
      object BlendedSizePenaltySpeedUpOverRTLLabeledEdit: TLabeledEdit
        Left = 655
        Top = 32
        Width = 121
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Speedup Over RTL'
        TabOrder = 3
      end
    end
    object WinnersTabSheet: TTabSheet
      Caption = 'Winners'
      ImageIndex = 8
      object AuthorLabel: TLabel
        Left = 368
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Author'
      end
      object TargetsLabel: TLabel
        Left = 494
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Targets'
      end
      object WinnersLabel: TLabel
        Left = 546
        Top = 8
        Width = 39
        Height = 13
        Caption = 'Winners'
      end
      object PointsLabel: TLabel
        Left = 600
        Top = 8
        Width = 29
        Height = 13
        Caption = 'Points'
      end
      object TargetLabel: TLabel
        Left = 40
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Target'
      end
      object WinnerFunctionLabel: TLabel
        Left = 168
        Top = 8
        Width = 78
        Height = 13
        Caption = 'Winner Function'
      end
      object WinnersStringGrid: TStringGrid
        Left = 8
        Top = 24
        Width = 303
        Height = 409
        ColCount = 2
        FixedCols = 0
        RowCount = 16
        FixedRows = 0
        TabOrder = 0
      end
      object GetWinnersButton: TButton
        Left = 120
        Top = 450
        Width = 75
        Height = 25
        Caption = 'Get Winners'
        Enabled = False
        TabOrder = 1
        OnClick = GetWinnersButtonClick
      end
      object PointsStringGrid: TStringGrid
        Left = 368
        Top = 24
        Width = 344
        Height = 409
        ColCount = 4
        FixedCols = 0
        FixedRows = 0
        TabOrder = 2
      end
      object GivePointsButton: TButton
        Left = 496
        Top = 450
        Width = 75
        Height = 25
        Caption = 'Give Points'
        Enabled = False
        TabOrder = 3
        OnClick = GivePointsButtonClick
      end
    end
    object FunctionSizesTabSheet: TTabSheet
      Caption = 'Function Sizes'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label43: TLabel
        Left = 224
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Function Name'
      end
      object SizeLabel: TLabel
        Left = 376
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Size'
      end
      object FunctionSizesStringGrid: TStringGrid
        Left = 224
        Top = 32
        Width = 281
        Height = 436
        ColCount = 2
        FixedCols = 0
        FixedRows = 0
        TabOrder = 0
      end
    end
    object SpeedVersusSizeTabSheet: TTabSheet
      Caption = 'Speed Versus Size'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PenaltyForSizeLabel: TLabel
        Left = 8
        Top = 16
        Width = 58
        Height = 13
        Caption = 'Size Penalty'
      end
      object IA32WinnerLabel: TLabel
        Left = 88
        Top = 16
        Width = 120
        Height = 13
        Caption = 'RTL Replacement Winner'
      end
      object SizeLabel2: TLabel
        Left = 232
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Size'
      end
      object SpeedLabel: TLabel
        Left = 296
        Top = 16
        Width = 30
        Height = 13
        Caption = 'Speed'
      end
      object RelativeSpeedLabel: TLabel
        Left = 360
        Top = 16
        Width = 72
        Height = 13
        Caption = 'Relative Speed'
      end
      object StringGrid2: TStringGrid
        Left = 8
        Top = 32
        Width = 441
        Height = 425
        ColCount = 2
        FixedCols = 0
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect]
        TabOrder = 0
      end
      object CalculateSpeedVersusSizeTableButton: TButton
        Left = 672
        Top = 328
        Width = 153
        Height = 25
        Caption = 'CalculateSpeed Versus Size'
        TabOrder = 1
        OnClick = CalculateSpeedVersusSizeTableButtonClick
      end
      object LoadAndDoButton: TButton
        Left = 672
        Top = 360
        Width = 153
        Height = 25
        Caption = 'Load Data And Calculate'
        TabOrder = 2
        OnClick = LoadAndDoButtonClick
      end
      object RichEdit1: TRichEdit
        Left = 456
        Top = 32
        Width = 369
        Height = 281
        Lines.Strings = (
          'RichEdit1')
        ScrollBars = ssBoth
        TabOrder = 3
        WordWrap = False
      end
      object InstructionsetRadioGroup: TRadioGroup
        Left = 456
        Top = 320
        Width = 89
        Height = 137
        Caption = 'Instructionset'
        ItemIndex = 1
        Items.Strings = (
          'Pas'
          'IA32'
          'IA32Ext'
          'MMX'
          'SSE'
          'SSE2'
          'SSE3')
        TabOrder = 4
      end
      object AuthorRadioGroup: TRadioGroup
        Left = 552
        Top = 320
        Width = 89
        Height = 137
        Caption = 'Author'
        ItemIndex = 0
        Items.Strings = (
          'All'
          'JOH'
          'PLR'
          'DKC'
          'SHA'
          'LBG'
          'EG'
          'EWC'
          'AS'
          'DLA')
        TabOrder = 5
      end
      object PenaltyForSizeLabeledEdit2: TLabeledEdit
        Left = 672
        Top = 408
        Width = 121
        Height = 21
        EditLabel.Width = 71
        EditLabel.Height = 13
        EditLabel.Caption = 'PenaltyForSize'
        TabOrder = 6
      end
    end
    object FunctionsToRemoveTabSheet: TTabSheet
      Caption = 'Functions To Remove'
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 24
        Height = 13
        Caption = 'Keep'
      end
      object Label3: TLabel
        Left = 287
        Top = 16
        Width = 115
        Height = 13
        Caption = 'Candidates for Removal'
      end
      object Label4: TLabel
        Left = 568
        Top = 16
        Width = 82
        Height = 13
        Caption = 'Can be Removed'
      end
      object FunctionsToRemoveStringGrid: TStringGrid
        Left = 287
        Top = 32
        Width = 275
        Height = 441
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
      end
      object RunButton: TButton
        Left = 648
        Top = 399
        Width = 129
        Height = 25
        Caption = 'Calculate'
        TabOrder = 1
        OnClick = RunButtonClick
      end
      object FunctionsToKeepStringGrid: TStringGrid
        Left = 6
        Top = 32
        Width = 275
        Height = 441
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        TabOrder = 2
      end
      object FunctionsToRemoveRichEdit: TRichEdit
        Left = 568
        Top = 32
        Width = 257
        Height = 361
        Lines.Strings = (
          'FunctionsToRemoveRichEdit')
        ScrollBars = ssBoth
        TabOrder = 3
      end
      object LoadAndRunButton: TButton
        Left = 648
        Top = 432
        Width = 129
        Height = 25
        Caption = 'Load Data and Calculate'
        TabOrder = 4
        OnClick = LoadAndRunButtonClick
      end
    end
    object SubBenchWeightTabSheet: TTabSheet
      Caption = 'SubBenchWeight'
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SubBenchWeightsStringGrid: TStringGrid
        Left = 242
        Top = 32
        Width = 397
        Height = 258
        ColCount = 2
        FixedCols = 0
        RowCount = 9
        FixedRows = 0
        TabOrder = 0
      end
      object CalculateButton: TButton
        Left = 398
        Top = 312
        Width = 93
        Height = 57
        Caption = 'Calculate'
        TabOrder = 1
        OnClick = CalculateButtonClick
      end
    end
  end
  object LoadFileButton: TBitBtn
    Left = 300
    Top = 575
    Width = 92
    Height = 34
    Hint = 'Load one file'
    Caption = 'Load File'
    TabOrder = 1
    OnClick = LoadFileButtonClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000130B0000130B00000000000000000000FF00FF0C99CD
      019ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FF9D9D9D9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF83CAE68EDBF641B6E5019ACF019ACF019ACF01
      9ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BD0D0D0DADADAB9B9B99B9B
      9B9B9B9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF37AFD9
      C2EDFC71D7FB78D8FB77D7FA6FD2F64CBDE940B6E2019ACF019ACF019ACF019A
      CF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BB1B1B1EEEEEED1D1D1D3D3D3D3D3D3CFCFCFBEBEBEB7B7B79B9B9B
      9B9B9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF099DD0AFE1F180DAFA70D4F873D4F874D6F877
      D7F979D9FB79D8FB74D4F869CEF345B9E538B0DF019ACF019ACF019ACF019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9B9D9D9DE4E4E4D6D6D6D0D0
      D0D1D1D1D1D1D1D3D3D3D4D4D4D4D4D4D1D1D1CCCCCCBABABAB3B3B39B9B9B9B
      9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF3BBFE8
      4DB8DDACE8FC6DD3F872D4F872D4F872D4F872D4F873D4F873D5F877D7F979D8
      FB7AD9FB78D7FA73D5F74EBFEA44B8E4019ACFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BB7B7B7BABABAE6E6E6CFCFCFD1D1D1D1D1D1D1D1D1D1D1D1D1D1D1
      D1D1D1D3D3D3D4D4D4D4D4D4D3D3D3D1D1D1BFBFBFB9B9B99B9B9BFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF5FD3F619A3D3CBF0FB72D7F975D7F875D7F875
      D7F875D7F875D7F875D7F875D7F875D7F876D7F876D7F878D9F87CDAFA5FCAF1
      75D4F5019ACFFF00FFFF00FFFF00FFFF00FF9B9B9BC9C9C9A4A4A4F1F1F1D1D1
      D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D2D2D2D2D2D2D3
      D3D3D5D5D5C7C7C7D1D1D19B9B9BFF00FFFF00FFFF00FFFF00FF019ACF64D8F9
      019ACFA2DDF096E4FC78DBF87BDBF87BDBF87BDBF87BDBF87BDBF87BDBF87BDB
      F87BDBF87ADBF87ADBF97BDCF95CC9EE82DEFA019ACFFF00FFFF00FFFF00FFFF
      00FF9B9B9BCCCCCC9B9B9BDFDFDFDFDFDFD3D3D3D3D3D3D3D3D3D3D3D3D3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D4D4D4C5C5C5D7D7D79B9B9BFF00
      FFFF00FFFF00FFFF00FF019ACF66D9FA42B7E030ACD8BFF1FD7BDDF880DFF880
      DFF880DFF880DFF880DFF880DFF880DFF880DFF880DFF880E0F981E0F95FCCED
      90E8FB6CD0EE019ACFFF00FFFF00FFFF00FF9B9B9BCDCDCDB7B7B7AEAEAEEDED
      EDD3D3D3D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6
      D6D6D6D6D6C6C6C6DCDCDCCBCBCB9B9B9BFF00FFFF00FFFF00FF019ACF68DAFD
      5FC2E8069CD0D0F4FC88E5FA84E3F985E4F985E4F985E4F985E4F984E4F984E4
      F984E4F984E4F985E4F985E5FA63D0ED93EBFB87E3F7019ACFFF00FFFF00FFFF
      00FF9B9B9BCFCFCFC4C4C49D9D9DF3F3F3D9D9D9D7D7D7D8D8D8D8D8D8D8D8D8
      D8D8D8D7D7D7D7D7D7D7D7D7D7D7D7D8D8D8D8D8D8C7C7C7DDDDDDD8D8D89B9B
      9BFF00FFFF00FFFF00FF019ACF6ADDFF63C4EC019ACF92D8EDB2F3FD84E7F987
      E7F987E7F988E7F988E7F989E8F989E8F989E8F989E8F989E9F98AE9FA68D4EE
      95EDFB99F1FC019ACFFF00FFFF00FFFF00FF9B9B9BD0D0D0C7C7C79B9B9BD8D8
      D8E8E8E8D7D7D7D8D8D8D8D8D8D8D8D8D8D8D8D9D9D9D9D9D9D9D9D9D9D9D9D9
      D9D9DADADACACACADEDEDEDFDFDF9B9B9BFF00FFFF00FFFF00FF019ACF72DFFF
      67C7F044B9E413A1D2D5F8FD97F0FC95EFFB95EFFB92EFFB8FEDFA8CEBFA8DEC
      FA8DECFA8DECFA8EECFA8FEDFA6DD9EE99F2FAA1F7FD82E2F2019ACFFF00FFFF
      00FF9B9B9BD3D3D3CACACAB9B9B9A2A2A2F5F5F5DFDFDFDEDEDEDEDEDEDDDDDD
      DBDBDBDADADADADADADADADADADADADBDBDBDBDBDBCBCBCBDFDFDFE3E3E3D4D4
      D49B9B9BFF00FFFF00FF019ACF8EE5FF6AC9F364C5F0019ACFBFE7F4CEF1F9CC
      F2F9CFF4FAD0F6FBA4F2FA9CF3FB94F0FA95EFFA95F0FA95F0FA96F1FB74DDEE
      A0F6FBA5F9FCA0F5FB019ACFFF00FFFF00FF9B9B9BDDDDDDCCCCCCC9C9C99B9B
      9BEAEAEAF1F1F1F0F0F0F2F2F2F2F2F2E3E3E3E0E0E0DDDDDDDDDDDDDDDDDDDD
      DDDDDEDEDECECECEE1E1E1E4E4E4E1E1E19B9B9BFF00FFFF00FF019ACFA9EBFF
      6DCCF76AC9F568C6F350BAE8019ACF019ACF019ACF019ACF94D7EDC9F4FAB9F8
      FDAAF3FBA7F2FAA8F2FAAAF3FB88DFEEB8F8FBB7F8FBC2FEFE019ACFFF00FFFF
      00FF9B9B9BE6E6E6CFCFCFCCCCCCCBCBCBBFBFBF9B9B9B9B9B9B9B9B9B9B9B9B
      D8D8D8F0F0F0EBEBEBE5E5E5E4E4E4E4E4E4E5E5E5D5D5D5EAEAEAEAEAEAEFEF
      EF9B9B9BFF00FFFF00FF019ACFB9F3FF75D3F771D0F571D0F671CFF56ECDF46F
      CDF46FCEF44ABCE7079CD047B6DCD6F3F9D6F9FDCCF7FEC6F6FCC5F6FCA2E1F0
      D5FBFCD4FBFBE1FFFEB8EDF5019ACFFF00FF9B9B9BECECECD1D1D1CFCFCFCFCF
      CFCFCFCFCECECECECECECECECEBCBCBC9D9D9DB7B7B7F4F4F4F5F5F5F2F2F2F0
      F0F0EFEFEFDFDFDFF4F4F4F4F4F4FAFAFAE8E8E89B9B9BFF00FF019ACFBAF4FF
      7DDAF879D7F679D7F679D7F679D7F579D7F579D7F578D7F577D5F54BBEE715A2
      D39EDAEDDDF5FAD8F7FCD5F7FDB6E5F1F5FFFFF4FFFEFBFFFFF8FFFF019ACFFF
      00FF9B9B9BECECECD4D4D4D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D1D1D1
      D1D1D1BDBDBDA3A3A3DCDCDCF7F7F7F6F6F6F5F5F5E6E6E6FFFFFFFFFFFFFFFF
      FFFFFFFF9B9B9BFF00FF019ACFC3F8FF84E1F880DEF680DEF680DEF680DEF680
      DEF680DEF680DEF680DEF67FDDF656C7EA019ACF28A9D69DD9EEC1E8F4ACDCED
      D9EFF7DAEFF6DEF1F7E7F4F9019ACFFF00FF9B9B9BF0F0F0D7D7D7D5D5D5D5D5
      D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D4D4D4C2C2C29B9B9BABABABDC
      DCDCEBEBEBE1E1E1F4F4F4F4F4F4F6F6F6FAFAFA9B9B9BFF00FF019ACFC4FAFF
      8BE7F987E4F787E4F787E4F787E4F787E4F887E4F785E4F785E4F786E4F786E3
      F783E1F64EC2E4019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACFFF
      00FF9B9B9BF0F0F0DADADAD8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D7D7D7
      D7D7D7D7D7D7D7D7D7D6D6D6BDBDBD9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
      9B9B9B9B9B9B9BFF00FF019ACFD6FFFF8FEDFA8FEAF98FEAF98FEAF98FEAF98E
      EAF892EDFA96F0FC94F0FB93EFFB92EEFA90EEFA8FECFA90EDF998F2FC019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BF6F6F6DBDBDBDBDBDBDBDB
      DBDBDBDBDBDBDBDADADADDDDDDDFDFDFDDDDDDDDDDDDDDDDDDDCDCDCDBDBDBDB
      DBDBDFDFDF9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACFE1FEFF
      AAF9FD8EEFF993F1F993F1F993F1F995F1F9A0F0F8B3EDF7B4F0F8B6F1F9B8F3
      F9B7F4FAB1F4FBABF4FCAAFAFF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BFAFAFAE6E6E6DADADADDDDDDDDDDDDDDDDDDDDDDDDE1E1E1E7E7E7
      E8E8E8E8E8E8E9E9E9E9E9E9E8E8E8E6E6E6E6E6E69B9B9BFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF019ACFDBFFFFA4FBFDA0FAFC9DF8FB9CF8FC9B
      F6FA77D1E7019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BF8F8F8E4E4E4E2E2
      E2E1E1E1E1E1E1DFDFDFCCCCCC9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
      9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      019ACFBCEFF6B9F0F6BCF2F8C2F9FBB1EFF6019ACFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF9B9B9BEAEAEAE8E8E8EBEBEBEDEDEDE6E6E69B9B9BFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF019ACF019ACF019ACF01
      9ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9B9B9B
      9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object LoadAllButton: TBitBtn
    Left = 398
    Top = 575
    Width = 92
    Height = 34
    Hint = 'Load all files'
    Caption = 'Load All'
    TabOrder = 3
    OnClick = LoadAllButtonClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000130B0000130B00000000000000000000FF00FF0C99CD
      019ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FF9D9D9D9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF83CAE68EDBF641B6E5019ACF019ACF019ACF01
      9ACF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BD0D0D0DADADAB9B9B99B9B
      9B9B9B9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF37AFD9
      C2EDFC71D7FB78D8FB77D7FA6FD2F64CBDE940B6E2019ACF019ACF019ACF019A
      CF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BB1B1B1EEEEEED1D1D1D3D3D3D3D3D3CFCFCFBEBEBEB7B7B79B9B9B
      9B9B9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF099DD0AFE1F180DAFA70D4F873D4F874D6F877
      D7F979D9FB79D8FB74D4F869CEF345B9E538B0DF019ACF019ACF019ACF019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9B9D9D9DE4E4E4D6D6D6D0D0
      D0D1D1D1D1D1D1D3D3D3D4D4D4D4D4D4D1D1D1CCCCCCBABABAB3B3B39B9B9B9B
      9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF3BBFE8
      4DB8DDACE8FC6DD3F872D4F872D4F872D4F872D4F873D4F873D5F877D7F979D8
      FB7AD9FB78D7FA73D5F74EBFEA44B8E4019ACFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BB7B7B7BABABAE6E6E6CFCFCFD1D1D1D1D1D1D1D1D1D1D1D1D1D1D1
      D1D1D1D3D3D3D4D4D4D4D4D4D3D3D3D1D1D1BFBFBFB9B9B99B9B9BFF00FFFF00
      FFFF00FFFF00FFFF00FF019ACF5FD3F619A3D3CBF0FB72D7F975D7F875D7F875
      D7F875D7F875D7F875D7F875D7F875D7F876D7F876D7F878D9F87CDAFA5FCAF1
      75D4F5019ACFFF00FFFF00FFFF00FFFF00FF9B9B9BC9C9C9A4A4A4F1F1F1D1D1
      D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D2D2D2D2D2D2D3
      D3D3D5D5D5C7C7C7D1D1D19B9B9BFF00FFFF00FFFF00FFFF00FF019ACF64D8F9
      019ACFA2DDF096E4FC78DBF87BDBF87BDBF87BDBF87BDBF87BDBF87BDBF87BDB
      F87BDBF87ADBF87ADBF97BDCF95CC9EE82DEFA019ACFFF00FFFF00FFFF00FFFF
      00FF9B9B9BCCCCCC9B9B9BDFDFDFDFDFDFD3D3D3D3D3D3D3D3D3D3D3D3D3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D4D4D4C5C5C5D7D7D79B9B9BFF00
      FFFF00FFFF00FFFF00FF019ACF66D9FA42B7E030ACD8BFF1FD7BDDF880DFF880
      DFF880DFF880DFF880DFF880DFF880DFF880DFF880DFF880E0F981E0F95FCCED
      90E8FB6CD0EE019ACFFF00FFFF00FFFF00FF9B9B9BCDCDCDB7B7B7AEAEAEEDED
      EDD3D3D3D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6
      D6D6D6D6D6C6C6C6DCDCDCCBCBCB9B9B9BFF00FFFF00FFFF00FF019ACF68DAFD
      5FC2E8069CD0D0F4FC88E5FA84E3F985E4F985E4F985E4F985E4F984E4F984E4
      F984E4F984E4F985E4F985E5FA63D0ED93EBFB87E3F7019ACFFF00FFFF00FFFF
      00FF9B9B9BCFCFCFC4C4C49D9D9DF3F3F3D9D9D9D7D7D7D8D8D8D8D8D8D8D8D8
      D8D8D8D7D7D7D7D7D7D7D7D7D7D7D7D8D8D8D8D8D8C7C7C7DDDDDDD8D8D89B9B
      9BFF00FFFF00FFFF00FF019ACF6ADDFF63C4EC019ACF92D8EDB2F3FD84E7F987
      E7F987E7F988E7F988E7F989E8F989E8F989E8F989E8F989E9F98AE9FA68D4EE
      95EDFB99F1FC019ACFFF00FFFF00FFFF00FF9B9B9BD0D0D0C7C7C79B9B9BD8D8
      D8E8E8E8D7D7D7D8D8D8D8D8D8D8D8D8D8D8D8D9D9D9D9D9D9D9D9D9D9D9D9D9
      D9D9DADADACACACADEDEDEDFDFDF9B9B9BFF00FFFF00FFFF00FF019ACF72DFFF
      67C7F044B9E413A1D2D5F8FD97F0FC95EFFB95EFFB92EFFB8FEDFA8CEBFA8DEC
      FA8DECFA8DECFA8EECFA8FEDFA6DD9EE99F2FAA1F7FD82E2F2019ACFFF00FFFF
      00FF9B9B9BD3D3D3CACACAB9B9B9A2A2A2F5F5F5DFDFDFDEDEDEDEDEDEDDDDDD
      DBDBDBDADADADADADADADADADADADADBDBDBDBDBDBCBCBCBDFDFDFE3E3E3D4D4
      D49B9B9BFF00FFFF00FF019ACF8EE5FF6AC9F364C5F0019ACFBFE7F4CEF1F9CC
      F2F9CFF4FAD0F6FBA4F2FA9CF3FB94F0FA95EFFA95F0FA95F0FA96F1FB74DDEE
      A0F6FBA5F9FCA0F5FB019ACFFF00FFFF00FF9B9B9BDDDDDDCCCCCCC9C9C99B9B
      9BEAEAEAF1F1F1F0F0F0F2F2F2F2F2F2E3E3E3E0E0E0DDDDDDDDDDDDDDDDDDDD
      DDDDDEDEDECECECEE1E1E1E4E4E4E1E1E19B9B9BFF00FFFF00FF019ACFA9EBFF
      6DCCF76AC9F568C6F350BAE8019ACF019ACF019ACF019ACF94D7EDC9F4FAB9F8
      FDAAF3FBA7F2FAA8F2FAAAF3FB88DFEEB8F8FBB7F8FBC2FEFE019ACFFF00FFFF
      00FF9B9B9BE6E6E6CFCFCFCCCCCCCBCBCBBFBFBF9B9B9B9B9B9B9B9B9B9B9B9B
      D8D8D8F0F0F0EBEBEBE5E5E5E4E4E4E4E4E4E5E5E5D5D5D5EAEAEAEAEAEAEFEF
      EF9B9B9BFF00FFFF00FF019ACFB9F3FF75D3F771D0F571D0F671CFF56ECDF46F
      CDF46FCEF44ABCE7079CD047B6DCD6F3F9D6F9FDCCF7FEC6F6FCC5F6FCA2E1F0
      D5FBFCD4FBFBE1FFFEB8EDF5019ACFFF00FF9B9B9BECECECD1D1D1CFCFCFCFCF
      CFCFCFCFCECECECECECECECECEBCBCBC9D9D9DB7B7B7F4F4F4F5F5F5F2F2F2F0
      F0F0EFEFEFDFDFDFF4F4F4F4F4F4FAFAFAE8E8E89B9B9BFF00FF019ACFBAF4FF
      7DDAF879D7F679D7F679D7F679D7F579D7F579D7F578D7F577D5F54BBEE715A2
      D39EDAEDDDF5FAD8F7FCD5F7FDB6E5F1F5FFFFF4FFFEFBFFFFF8FFFF019ACFFF
      00FF9B9B9BECECECD4D4D4D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D1D1D1
      D1D1D1BDBDBDA3A3A3DCDCDCF7F7F7F6F6F6F5F5F5E6E6E6FFFFFFFFFFFFFFFF
      FFFFFFFF9B9B9BFF00FF019ACFC3F8FF84E1F880DEF680DEF680DEF680DEF680
      DEF680DEF680DEF680DEF67FDDF656C7EA019ACF28A9D69DD9EEC1E8F4ACDCED
      D9EFF7DAEFF6DEF1F7E7F4F9019ACFFF00FF9B9B9BF0F0F0D7D7D7D5D5D5D5D5
      D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D4D4D4C2C2C29B9B9BABABABDC
      DCDCEBEBEBE1E1E1F4F4F4F4F4F4F6F6F6FAFAFA9B9B9BFF00FF019ACFC4FAFF
      8BE7F987E4F787E4F787E4F787E4F787E4F887E4F785E4F785E4F786E4F786E3
      F783E1F64EC2E4019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACFFF
      00FF9B9B9BF0F0F0DADADAD8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D7D7D7
      D7D7D7D7D7D7D7D7D7D6D6D6BDBDBD9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
      9B9B9B9B9B9B9BFF00FF019ACFD6FFFF8FEDFA8FEAF98FEAF98FEAF98FEAF98E
      EAF892EDFA96F0FC94F0FB93EFFB92EEFA90EEFA8FECFA90EDF998F2FC019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BF6F6F6DBDBDBDBDBDBDBDB
      DBDBDBDBDBDBDBDADADADDDDDDDFDFDFDDDDDDDDDDDDDDDDDDDCDCDCDBDBDBDB
      DBDBDFDFDF9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACFE1FEFF
      AAF9FD8EEFF993F1F993F1F993F1F995F1F9A0F0F8B3EDF7B4F0F8B6F1F9B8F3
      F9B7F4FAB1F4FBABF4FCAAFAFF019ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF9B9B9BFAFAFAE6E6E6DADADADDDDDDDDDDDDDDDDDDDDDDDDE1E1E1E7E7E7
      E8E8E8E8E8E8E9E9E9E9E9E9E8E8E8E6E6E6E6E6E69B9B9BFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF019ACFDBFFFFA4FBFDA0FAFC9DF8FB9CF8FC9B
      F6FA77D1E7019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACF019ACF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BF8F8F8E4E4E4E2E2
      E2E1E1E1E1E1E1DFDFDFCCCCCC9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
      9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      019ACFBCEFF6B9F0F6BCF2F8C2F9FBB1EFF6019ACFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF9B9B9BEAEAEAE8E8E8EBEBEBEDEDEDE6E6E69B9B9BFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF019ACF019ACF019ACF019ACF01
      9ACFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9B9B9B
      9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object DoAllButton: TBitBtn
    Left = 754
    Top = 575
    Width = 96
    Height = 42
    Hint = 
      'Do all : Open all files, calculate winners, give points and save' +
      ' results in Excel spreasheet'
    Caption = 'Do All'
    TabOrder = 0
    OnClick = DoAllButtonClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000130B0000130B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA13B01B1541CA13B01A13B01A13B
      01A13B01A13B01A13B01FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7979798E8E8E
      797979797979797979797979797979797979FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA13B01A1
      3B01E39C5BEBA35DE3964CE08E41DF8B3ADA8434DB8430D47D2BB65714A13B01
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF797979797979C7C7C7CCCCCCBFBFBFB8B8B8B4B4B4AFAFAFADADADA7
      A7A78D8D8D797979FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFA13F0EDE985DF3B373D28244C7824ED3A376073BFEAE93
      94D5A97CC88652C0661FD57A20CC701DA13D04FF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7F7FC5C5C5DBDBDBB3B3B3B2B2B2
      CCCCCCAAAAAAC8C8C8D0D0D0B5B5B5979797A2A2A29C9C9C7A7A7AFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D3A09E6A369F3B373BE
      6D36DBB38EFCF9E7FEFCF3073BFEB8C8F2FEFDF5FFFFFAF5EBD9C37F50C96912
      CE70179E3902FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7B7B
      7BCFCFCFDBDBDBA2A2A2DCDCDCFFFFFFFFFFFFAAAAAAFDFDFDFFFFFFFFFFFFFF
      FFFFB1B1B19595959A9A9A787878FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFA13B01D68F57F7BC80BA6935E8D3B0FDF6E8FAE9CFF5D1A7EDC79DEDC7
      9DF6D5A8FAEACAFEFDF5FEFDFACC9772CA670DC4630FA13B01FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF797979BEBEBEE3E3E39F9F9FF4F4F4FFFFFFFFFFFF
      F6F6F6EDEDEDEDEDEDF7F7F7FFFFFFFFFFFFFFFFFFC7C7C79393939191917979
      79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB45C27FFCA91C97B44E3C49EFC
      F5E2F9E4BEF4D0A0F4CD9DF2C593F0BC88EFB883F0BE8AF5D5A7FEF9EAFEFDF9
      C17845D06F0CA13B01FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF959595F0F0
      F0AEAEAEE8E8E8FFFFFFFFFFFFF2F2F2F0F0F0EAEAEAE4E4E4E1E1E1E5E5E5F6
      F6F6FFFFFFFFFFFFABABAB969696797979FF00FFFF00FFFF00FFFF00FFFF00FF
      A13B01E29F6AECAB73C38355FEFDE5FDF9D9FDF8D0FDF8D0FDF8D0FCF2CAF9E3
      B7F3CA9AEFB883EFB984F5D2A2FEFCF3EEDDCEBA5502C66409A13B01FF00FFFF
      00FFFF00FFFF00FF797979CECECED7D7D7B4B4B4FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFEEEEEEE1E1E1E1E1E1F3F3F3FFFFFFFFFFFF8686868F8F
      8F797979FF00FFFF00FFFF00FFFF00FFA3420EFCC690CF834EDBB88FFFFEEEFF
      FFE2FFFFD9FFFFD9FFFFD9FFFFDEFFFEE1FBEFC8F4CD9DEFB883F0BC88F9E4C3
      FDFAF3B15413CD6A06A13B01FF00FFFF00FFFF00FFFF00FF808080EEEEEEB6B6
      B6DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0E1
      E1E1E4E4E4FFFFFFFFFFFF8A8A8A919191797979FF00FFFF00FFFF00FFFF00FF
      B45B28FEC993C67C4AFAEACAFFFFFCFFFFFAFFFFDDFFFFD9FFFFDBD6D6B8B0B0
      9AF5F5D2FBECC3F2C593EFB883F4D0A0FFFEEEBA6E37C96301A13B01FF00FFFF
      00FFFF00FFFF00FF969696F0F0F0B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFEFEFEFCDCDCDFFFFFFFFFFFFEAEAEAE1E1E1F2F2F2FFFFFFA0A0A08D8D
      8D797979FF00FFFF00FFFF00FFFF00FFBC6734FEC78FC680523694F93694F9FF
      FFFFFFFFF1FFFFDBFAFAD551514B838384B0B09AFEFCE2F6D9ABEFB883073BFE
      073BFEAC6D4DCB6300A13B01FF00FFFF00FFFF00FFFF00FFA0A0A0EEEEEEB4B4
      B4BFBFBFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFF767676ABABABCDCDCDFFFFFFF8
      F8F8E1E1E1AAAAAAAAAAAAA4A4A48D8D8D797979FF00FFFF00FFFF00FFFF00FF
      B8632FFDC891C98556D8DDD5F5FBFAFFFFFFFFFFFFFFFFEBFCFCDA8181732A2A
      2B5C5C54F0F0D1F9E4BEF0BC88E3C49EC6CDE8AC6945CB6300A13B01FF00FFFF
      00FFFF00FFFF00FF9B9B9BEFEFEFB7B7B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFA2A2A2525252808080FFFFFFFFFFFFE4E4E4E8E8E8FFFFFFA0A0A08D8D
      8D797979FF00FFFF00FFFF00FFFF00FFAB4E1AFFCB94CE8755F1DDBAFFFFFFFF
      FFFFFFFFFFFFFFFEFFFFEBFFFFDBE0E0C35C5C54575750F1DDBAF0BE8AF3CA9A
      FCF9E7B66023CB6704A13B01FF00FFFF00FFFF00FFFF00FF8A8A8AF1F1F1B9B9
      B9FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F98080807B7B7BFD
      FDFDE5E5E5EEEEEEFFFFFF9494948F8F8F797979FF00FFFF00FFFF00FFFF00FF
      A13B01EFB47EDD9B66DBB38EFEFDF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFF
      E6F4F4D4717166615C51EAC496F9E4C3EFDCC1B45006CB6909A13B01FF00FFFF
      00FFFF00FFFF00FF797979DEDEDEC9C9C9DCDCDCFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF939393818181E8E8E8FFFFFFFFFFFF8585859292
      92797979FF00FFFF00FFFF00FFFF00FFFF00FFC77944FEC78FC98556F6E6C9FF
      FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFF1FEFEE57575687F7B6CFCF5E2
      C38355C86406B85607FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFADADADEEEE
      EEB7B7B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF96
      96969D9D9DFFFFFFB4B4B48F8F8F878787FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFA03D0BF1B57DE39D61D6A47CFBF1DBFFFFFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFCFCE4EBEAD5DCB893BB580BD070119F3A02FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF7D7D7DDFDFDFCACACAD1D1D1FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF8B8B8B9898987878
      78FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB05622F8BE82D98E54D6
      A379F4E2C7FEFCF3FFFFFE3694F9D7ECF1FEFDFAFFFFFEFDFBE5D3A479BA5B13
      D47617AC4806FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191
      91E5E5E5BEBEBECFCFCFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFFFFFFFFFFFFF
      FFFFCECECE8E8E8E9D9D9D818181FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFB75F2AF8BD7EE39C5BCE8B5AE1B996EFDCC13694F9C3D4
      D7F5EBD9E2C3A5BF753FC56516D97E20B14F0CFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF989898E3E3E3C7C7C7BCBCBCE3E3E3
      FFFFFFBFBFBFF5F5F5FFFFFFEBEBEBA7A7A7959595A4A4A4868686FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE521EE3
      9D61F1AE69DB8E4BD0854BCE8954CB854FC8783ACD752AD9812AD27925AB490B
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF8E8E8ECACACAD5D5D5BBBBBBB5B5B5B9B9B9B5B5B5A9A9A9A3A3A3A9
      A9A9A3A3A3838383FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB45922CF7E3FDB8E47DC8B40DB8A
      3ED68237C86F26A13B01A13B01FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF939393AFAFAF
      B9B9B9B6B6B6B4B4B4AEAEAE9F9F9F797979797979FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFA13B01C37340A13B01A13B01B75102983200FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF797979A9A9A9797979797979848484747474FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA13B01CD8250EFB47ECD72
      1DBD55009A3300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF797979
      B6B6B6DEDEDE9D9D9D868686757575FF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFA13B01A13B01A13B01A13B01A13B01A13B01A13B01A13B01FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF79797979797979797979797979797979797979797979
      7979FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA13B01F1B884FFE8B5FEC685DD84
      25D16B00D16C01A84201FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF797979E2E2E2
      FFFFFFE9E9E9A9A9A99090909191917C7C7CFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFA13B01A13B01A13B01A13B01A13B01A13B01A13B01A13B01FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF79797979797979797979797979797979797979797979
      7979FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object CreateSpreadsheetsButton: TBitBtn
    Left = 605
    Top = 575
    Width = 143
    Height = 34
    Hint = 'Create Excel spreadsheet'
    Caption = 'Create Spreadsheets'
    Enabled = False
    TabOrder = 5
    OnClick = CreateSpreadsheetsButtonClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000C21E0000C21E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFB3DABA6496602248331A38291A3829
      1A38291A38291A38291A3829FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8A42
      4242333333333333333333333333333333333333FF00FFFF00FFFF00FFFF00FF
      51954C2248332248332248332248332248332248332248332248332248332248
      33106A122984332F88351475371A6E3B2569422F62493C5D521A3829FF00FFFF
      00FFFF00FFFF00FF868686424242424242424242424242424242424242424242
      4242424242424242425B5B5B7474747878786767676262625F5F5F5B5B5B5959
      59333333FF00FFFF00FFFF00FFFF00FF51954C1475371475371A6E3B25694225
      69422F62492F62493C5D523C5D520964092178248DC99372B677308C422D873D
      1E7D3E1E7D3E096409FF00FFFF00FFFF00FFFF00FFFF00FF8686866767676767
      676262625F5F5F5F5F5F5B5B5B5B5B5B595959595959555555686868BCBCBCA7
      A7A77C7C7C7777776F6F6F6F6F6F555555FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF51954C72B67772BB7B72BB7B6CB57366B06B5CAA6156A45B106A123B91
      4298CFA36CB57338964F328E472D89412D873D096409A4C6A1FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF868686A7A7A7ACACACACACACA6A6A6A0A0A09A9A9A
      9494945B5B5B818181C4C4C4A6A6A68686867F7F7F797979777777555555FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF51954C72B67772BB7B72
      BB7B66B06B56A45B106A123B91429FD4A96CB573529A513C9B5438964F328E47
      096409194D16A7B9A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8686
      86A7A7A7ACACACACACACA0A0A09494945B5B5B818181C9C9C9A6A6A68A8A8A8B
      8B8B8686867F7F7F555555434343FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF51954C72B67766B06B56A45B106A123B91429FD4A96CB5
      7356A45B56A45B529A513C9B540964092D89411E7D3E10561AFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF868686A7A7A7A0A0A09494945B5B5B
      818181C9C9C9A6A6A69494949494948A8A8A8B8B8B5555557979796F6F6F4A4A
      4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF51954C52
      9A51106A123B9142A9D7B272B67756A45B56A45B56A45B56A45B0964094A7647
      5E885D5E885D5E885DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF8686868A8A8A5B5B5B818181CDCDCDA7A7A794949494949494949494
      94945555556B6B6B7E7E7E7E7E7E7E7E7EFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF237C2B3B9142A9D7B27BBC815CAA615CAA
      6156A45B56A45B4A7647A4C6A1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6C6C6C818181CDCDCD
      ADADAD9A9A9A9A9A9A9494949494946B6B6BFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF95BC944C
      9246B3DABA8DC99366B06B5CAA615CAA6156A45B4A815D096409FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF828282D1D1D1BCBCBCA0A0A09A9A9A9A9A9A94949477777755
      5555FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF95BC94529A51BCE1C28DC9936CB57366B06B66B06B5CAA
      614A815D5B9B5A56855A096409FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8AD9D9D9BCBCBCA6A6A6
      A0A0A0A0A0A09A9A9A7777778D8D8D7B7B7B555555FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF95BC9456A45BC5E5CB98
      CFA372BB7B72BB7B6CB57366B06B4A815D6CB5736CB57356A45B56855A096409
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF949494DEDEDEC4C4C4ACACACACACACA6A6A6A0A0A0777777A6A6A6A6A6A694
      94947B7B7B555555FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFA4C6A15CAA61C5E5CB8DC9937DC28B7BBC8172BB7B66B06B5E885D66B0
      6B72BB7B72BB7B6CB57356A45B56855A096409FF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FF9A9A9ADEDEDEBCBCBCB4B4B4ADADADACACAC
      A0A0A07E7E7EA0A0A0ACACACACACACA6A6A69494947B7B7B555555FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFA4C6A166B06BC5E5CB9FD4A97DC28B7D
      C28B7DC28B72BB7B6A9368ABCAA864966072B67772BB7B72BB7B6CB57356A45B
      56855A096409FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA0A0A0DEDE
      DEC9C9C9B4B4B4B4B4B4B4B4B4ACACAC888888FF00FF8A8A8AA7A7A7ACACACAC
      ACACA6A6A69494947B7B7B555555FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      6CB573C5E5CB9FD4A98DC9938DC9937DC28B7BBC81639C61FF00FFFF00FFFF00
      FF64966072B67772BB7B72BB7B6CB57356A45B56855A096409FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFDEDEDEC9C9C9BCBCBCBCBCBCB4B4B4ADADAD8F8F8F
      FF00FFFF00FFFF00FF8A8A8AA7A7A7ACACACACACACA6A6A69494947B7B7B5555
      55FF00FFFF00FFFF00FFFF00FFFF00FF6CB5736CB57366B06B66B06B66A16766
      A167639C61FF00FFFF00FFFF00FFFF00FFFF00FF64966064966061945B5E885D
      5E885D56855A56855AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA0A0
      A0A0A0A09494949494948F8F8FFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8A8A
      8A8A8787877E7E7E7E7E7E7B7B7B7B7B7BFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object CalcWinnerButton: TBitBtn
    Left = 496
    Top = 575
    Width = 103
    Height = 34
    Hint = 'Calculate winners and give points'
    Caption = 'Get Winners'
    Enabled = False
    TabOrder = 7
    OnClick = CalcWinnerButtonClick
    Glyph.Data = {
      B60D0000424DB60D000000000000360000002800000030000000180000000100
      180000000000800D0000C21E0000C21E00000000000000000000FE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FED58000D58000D58000D58000D58000D5
      8000D58000D58000D58000D58000D58000D58000D58000D58000D58000D58000
      D58000D58000D58000D58000FE00FEFE00FEFE00FEFE00FE8989898989898989
      8989898989898989898989898989898989898989898989898989898989898989
      8989898989898989898989898989898989898989FE00FEFE00FEFE00FED58000
      FEE9D1FEE8D0FEE7CDFEE5C9FDE4C7FDE2C4FDE1C1FCE0C0FDDDB9FDDDB9FDDB
      B5FDDBB4FDDAB1FDDAB1FDD8AEFCD7AEFCD7AEFCD7AEFCD7AEFCD7AED58000FE
      00FEFE00FE898989E8E8E8E6E6E6E5E5E5E4E4E4E1E1E1E1E1E1E0E0E0DDDDDD
      DCDCDCDBDBDBD9D9D9D8D8D8D7D7D7D6D6D6D5D5D5D5D5D5D4D4D4D4D4D4D4D4
      D4D4D4D4898989FE00FEFE00FED58000FEEBD5FEEAD3FEE8D0FEE6CCFEE5C9FD
      E4C7FDE2C4FDE1C1FCE0C0FDDDB9FDDDB9FDDCB7FDDBB4FDDAB1FDDAB1FDD8AE
      FCD7AEFCD7AEFCD7AEFCD7AED58000FE00FEFE00FE898989E9E9E9E8E8E8E6E6
      E6E4E4E4E3E3E3E2E2E2E0E0E0E0E0E0DDDDDDDCDCDCDBDBDBDADADAD9D9D9D7
      D7D7D6D6D6D5D5D5D5D5D5D4D4D4D4D4D4D4D4D4898989FE00FEFE00FED58000
      FEEDD9FEEBD5FEE9D1FEE8D0FEE7CDFEE5C9FDE4C7FDE2C4FDE1C1FCE0C0FDDD
      B9FDDDB9FDDCB7FDDBB4FDDAB1FDDAB1FDD8AEFCD7AEFCD7AEFCD7AED58000FE
      00FEFE00FE898989EBEBEBEAEAEAE8E8E8E6E6E6E5E5E5E3E3E3E2E2E2E0E0E0
      E0E0E0DDDDDDDCDCDCDBDBDBDADADAD9D9D9D7D7D7D7D7D7D6D6D6D5D5D5D5D5
      D5D4D4D4898989FE00FEFE00FED58000FEEEDCFEEDD9FEEBD5FEEDD9FEEBD5FD
      EBD6F9DFC1FCE8D1FEEBD5FDD8AEFCD7AEFCD7ADF9CFA0FAD2A4FCD7AEFDD8AE
      FCD7AEFDD8AEFCD7AEFCD7AED58000FE00FEFE00FE898989EDEDEDEBEBEBFBFB
      FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB
      FBFBFBFBFBFBFBFBFBFBFBFBFBFBD5D5D5D4D4D4898989FE00FEFE00FED58000
      FEEFDEFEEEDCFEEDD9FEEEDCFEEDD9EFC496DA8831E1A66CFEEDD8FDDAB1FDD8
      AEF3C28CDA8835DA8F46FAD2A4FDDAB1FDD8AEFDDAB1FDD8AEFDD8AED58000FE
      00FEFE00FE898989EEEEEEEDEDEDFBFBFBFBFBFBFBFBFBB4B4B47D7D7D8D8D8D
      FBFBFBFBFBFBFBFBFBB6B6B68787878D8D8DFBFBFBFBFBFBFBFBFBFBFBFBD6D6
      D6D5D5D5898989FE00FEFE00FED58000FEF1E2FEF0DFFEEEDCFEF0DFFEEEDBDE
      9D5FD37819D38235FBE5CDFDDAB1FDDAB1E9AB6AD37819D77F23F1C393FDDAB1
      FDDAB1FDDAB1FDDAB1FDD8AED58000FE00FEFE00FE898989F0F0F0EFEFEFFBFB
      FBFBFBFBFBFBFB8D8D8D7777777E7E7EFBFBFBFBFBFBFBFBFBB4B4B47777777D
      7D7DB4B4B4FBFBFBFBFBFBFBFBFBD7D7D7D6D6D6898989FE00FEFE00FED58000
      FEF3E6FEF1E2FEF0DFFEF1E2FBE7D0DA8A3AD37819D88024F3D4B4FDDBB4FCD8
      AFDB9149D37819D37819E7AE78FDDBB4FDDAB1FDDBB4FDDAB1FDDAB1D58000FE
      00FEFE00FE898989F2F2F2F0F0F0FBFBFBFBFBFBFBFBFB8787877777777D7D7D
      B4B4B4FBFBFBFBFBFB8D8D8D777777777777B4B4B4FBFBFBFBFBFBFBFBFBD8D8
      D8D7D7D7898989FE00FEFE00FED58000FEF4E8FEF3E6FEF2E4FEF3E6F5D8B9D4
      7B1ED37819D37819E7BC96FDDCB7F9D1A5D88430D37819D37819D89357FDDCB6
      FDDBB4FDDCB7FDDBB4FDDAB1D58000FE00FEFE00FE898989F3F3F3F2F2F2FBFB
      FBFBFBFBB4B4B4777777777777777777B4B4B4FBFBFBFBFBFB7A7A7A77777777
      77778D8D8DFBFBFBFBFBFBFBFBFBD9D9D9D8D8D8898989FE00FEFE00FED58000
      FEF5EAFEF4E8FEF3E6FEF4E8EDC398D37819D98936D3781ADCA16FFDDDB9F2C2
      8DD3791BDA862ED88126D48335FBD7B0FDDCB7FDDDB9FDDCB7FDDBB5D58000FE
      00FEFE00FE898989F5F5F5F3F3F3FBFBFBFBFBFBB4B4B4777777818181777777
      8D8D8DFBFBFBB6B6B67777777D7D7D7D7D7D818181FBFBFBFBFBFBFBFBFBDADA
      DAD9D9D9898989FE00FEFE00FED58000FEF7EEFEF6ECFEF4E8FEF6ECE0A66DD3
      781AEBBD8FD7832ED6893FF9D8B4E9AC6ED37819E09E5FD88B42D17D2DF3CA9F
      FDDDB9FBDDBCFDDDB9FDDDB9D58000FE00FEFE00FE898989F7F7F7F5F5F5FBFB
      FBFBFBFB8D8D8D777777B4B4B47D7D7D818181FBFBFBB4B4B47777778D8D8D87
      87877A7A7AB4B4B4FBFBFBFBFBFBDCDCDCDADADA898989FE00FEFE00FED58000
      FEF8F1FEF7EEFEF6ECFCF1E3DB8F43D88227F5DCC1DB9044D88227F4CCA1DA92
      4CD3791AEBBA87DF9D5CD77F22E8B688FBDDBCFCE0C0FBDDBCFDDDB9D58000FE
      00FEFE00FE898989F7F7F7F7F7F7FBFBFBFBFBFB8787877D7D7DB4B4B4878787
      7D7D7DB4B4B48D8D8D777777B4B4B48D8D8D7D7D7DB4B4B4FBFBFBFBFBFBDDDD
      DDDCDCDC898989FE00FEFE00FED58000FEF9F3FEF8F1FEF7EEF7E2CDD9842BD6
      8940FCF1E3E0A770D37819EAB278D98634D27E2FF6CFA4EBB783D67F27DC9C65
      FCE0C0FDE1C1FCE0C0FBDDBCD58000FE00FEFE00FE898989F9F9F9F8F8F8FBFB
      FBB4B4B47D7D7D818181FBFBFB8D8D8D777777B4B4B48181817A7A7AB4B4B4B4
      B4B47D7D7D8D8D8DFBFBFBFBFBFBDEDEDEDDDDDD898989FE00FEFE00FED58000
      FEFAF5FEF9F3FEF8F1EFCBA6D88025DBA171FEF8F1EDC7A0D37819DB8C39D781
      2BD6873CFBDDBCF5CFA6D27E2FD48B4EFBDDBDFDE3C6FDE2C4FCE0C0D58000FE
      00FEFE00FE898989FAFAFAF9F9F9FBFBFBB4B4B47D7D7D8D8D8DFBFBFBB4B4B4
      7777778787877D7D7D878787FBFBFBB4B4B47A7A7A878787FBFBFBFBFBFBE0E0
      E0E0E0E0898989FE00FEFE00FED58000FEFBF7FEFAF5FEF9F3E7B380D88024E6
      BD9BFEF9F3F5DEC6D47B1ED37819D17C2BDA9860FEE5C8FBDDBCD48438D38031
      F7D6B0FEE5C9FDE4C7FDE2C4D58000FE00FEFE00FE898989FBFBFBFAFAFAFBFB
      FBA3A3A37D7D7DB4B4B4FBFBFBB4B4B47777777777777A7A7A8D8D8DFBFBFBFB
      FBFB8181817D7D7DB4B4B4FBFBFBE1E1E1E0E0E0898989FE00FEFE00FED58000
      FEFCFAFEFCF9FDF7F0DA9858D28031F3DCC6FEFBF7FBF2E8D98A3AD37819CE80
      3FE6B182FEE6CCFEE6CBDA9860D17C2BEDC097FEE6CCFEE5C9FDE3C6D58000FE
      00FEFE00FE898989FCFCFCFBFBFBFBFBFB8D8D8D7A7A7AB4B4B4FBFBFBFBFBFB
      818181777777818181B4B4B4FBFBFBFBFBFB8D8D8D7A7A7AB4B4B4FBFBFBE3E3
      E3E2E2E2898989FE00FEFE00FED58000FEFCFAFEFCFAF8EBDCD5883FD4863BFA
      EFE4FEFCF9FDFAF6DF9D5AD57D26CF8241F1C79CFEE8D0FEE8D0E3AC7CD17C2B
      DFA471FEE8D0FEE6CCFEE5C9D58000FE00FEFE00FE898989FCFCFCFCFCFCB4B4
      B4818181818181FBFBFBFBFBFBFBFBFB8D8D8D7D7D7D878787B6B6B6FBFBFBFB
      FBFBB4B4B47A7A7AA3A3A3FBFBFBE4E4E4E3E3E3898989FE00FEFE00FED58000
      FEFCFAFEFCFAF2D7BAD57E24DC9C5EFDFAF6FEFCFAFEFCFAECC194D88127D688
      3DFADDBEFEE9D1FEE9D1F1C9A1D7822DDB9450FDE5CBFEE8D0FEE6CCD58000FE
      00FEFE00FE898989FCFCFCFCFCFCB6B6B67D7D7D8D8D8DFBFBFBFBFBFBFBFBFB
      B4B4B47D7D7D878787FBFBFBFBFBFBFBFBFBB6B6B67D7D7D8D8D8DFBFBFBE6E6
      E6E5E5E5898989FE00FEFE00FED58000FEFCFAFEFCFAFBF3EBF6E4D1F9EEE0FE
      FBF7FEF9F3FEF8F1FBEFE1F6DFC6F8E2CBFEF3E5FEF3E6FEF1E2FDECD9F7DABA
      F8DCBCFEEBD4FEEAD3FEE8D0D58000FE00FEFE00FE898989FCFCFCFCFCFCC8C8
      C8B4B4B4FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBB4B4B4B4B4B4FBFBFBFBFBFBFB
      FBFBFBFBFBB4B4B4B4B4B4FBFBFBE8E8E8E7E7E7898989FE00FEFE00FED58000
      FEFCFAFEFCFAFEFCFAFEFCFAFEFCFAFEFCF9FEFBF7FEFAF5FEF9F2FEF8F1FEF6
      ECFEF5EAFEF4E8FEF2E4FEF1E2FEEFDEFEEEDCFEEDD9FEEBD5FEEAD3D58000FE
      00FEFE00FE898989FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFBFBFBFBF9F9F9
      F8F8F8F7F7F7F5F5F5F4F4F4F3F3F3F1F1F1F0F0F0EEEEEEEDEDEDEBEBEBEAEA
      EAE8E8E8898989FE00FEFE00FED58000FEFCFAFEFCFAFEFCFAFEFCFAFEFCFAFE
      FCFAFEFCFAFEFBF7FEFAF5FEF9F2FEF7EEFEF6ECFEF5EAFEF4E8FEF3E6FEF1E2
      FEEFDEFEEEDCFEEDD9FEEBD5D58000FE00FEFE00FE898989FCFCFCFCFCFCFCFC
      FCFCFCFCFCFCFCFCFCFCFCFCFCFAFAFAF9F9F9F8F8F8F7F7F7F5F5F5F4F4F4F3
      F3F3F1F1F1EFEFEFEEEEEEECECECEBEBEBE9E9E9898989FE00FEFE00FEFE00FE
      D58000D58000D58000D58000D58000D58000D58000D58000D58000D58000D580
      00D58000D58000D58000D58000D58000D58000D58000D58000D58000FE00FEFE
      00FEFE00FEFE00FE898989898989898989898989898989898989898989898989
      8989898989898989898989898989898989898989898989898989898989898989
      89898989FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE}
    NumGlyphs = 2
  end
  object FileOpenDialog: TOpenDialog
    Left = 88
    Top = 584
  end
end
