object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tags Library Tutorial BASS'
  ClientHeight = 733
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1008
    Height = 733
    Align = alClient
    Caption = ' Options: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1008
      733)
    object GroupBox2: TGroupBox
      Left = 8
      Top = 175
      Width = 990
      Height = 346
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' Tags: '
      TabOrder = 0
      DesignSize = (
        990
        346)
      object ListView1: TListView
        Left = 8
        Top = 24
        Width = 974
        Height = 310
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end
          item
            Caption = 'Value'
            Width = 650
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 527
      Width = 990
      Height = 198
      Anchors = [akLeft, akRight, akBottom]
      Caption = ' Cover arts: '
      TabOrder = 1
      DesignSize = (
        990
        198)
      object ListView2: TListView
        Left = 8
        Top = 24
        Width = 974
        Height = 164
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Name'
            Width = 250
          end
          item
            Caption = 'Value'
            Width = 650
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        LargeImages = ImageListThumbs
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 24
      Width = 990
      Height = 73
      Anchors = [akLeft, akTop, akRight]
      Caption = ' File: '
      TabOrder = 2
      DesignSize = (
        990
        73)
      object Label1: TLabel
        Left = 16
        Top = 32
        Width = 49
        Height = 13
        Caption = 'File name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Button1: TButton
        Left = 863
        Top = 27
        Width = 27
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 896
        Top = 27
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button4Click
      end
      object Edit1: TEdit
        Left = 80
        Top = 29
        Width = 777
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 103
      Width = 990
      Height = 66
      Anchors = [akLeft, akTop, akRight]
      Caption = ' URL Stream: '
      TabOrder = 3
      DesignSize = (
        990
        66)
      object Label2: TLabel
        Left = 16
        Top = 32
        Width = 23
        Height = 13
        Caption = 'URL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Edit2: TEdit
        Left = 45
        Top = 29
        Width = 845
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'http://www.3delite.hu/Test.mp3'
      end
      object Button2: TButton
        Left = 896
        Top = 28
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 904
    Top = 448
  end
  object ImageListThumbs: TImageList
    Height = 120
    Width = 160
    Left = 904
    Top = 584
  end
end
