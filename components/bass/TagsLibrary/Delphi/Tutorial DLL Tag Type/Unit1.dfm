object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tags Library Tutorial DLL Tag Type'
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
    object Label5: TLabel
      Left = 550
      Top = 64
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tag type:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 80
      Top = 29
      Width = 878
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 964
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
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 754
      Top = 58
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Remove'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 835
      Top = 58
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 916
      Top = 58
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
      TabOrder = 4
      OnClick = Button4Click
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 89
      Width = 990
      Height = 432
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' All Tags: '
      TabOrder = 5
      DesignSize = (
        990
        432)
      object ListView1: TListView
        Left = 8
        Top = 24
        Width = 972
        Height = 396
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
      Height = 194
      Anchors = [akLeft, akRight, akBottom]
      Caption = ' Cover arts: '
      TabOrder = 6
      DesignSize = (
        990
        194)
      object ListView2: TListView
        Left = 8
        Top = 24
        Width = 891
        Height = 160
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
      object Button5: TButton
        Left = 905
        Top = 24
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Add...'
        TabOrder = 1
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 905
        Top = 55
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Delete'
        TabOrder = 2
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 905
        Top = 86
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Export...'
        TabOrder = 3
        OnClick = Button7Click
      end
    end
    object ComboBox1: TComboBox
      Left = 603
      Top = 60
      Width = 145
      Height = 21
      Style = csDropDownList
      DropDownCount = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 3
      ParentFont = False
      TabOrder = 7
      Text = 'ttID3v2'
      OnChange = ComboBox1Change
      Items.Strings = (
        'ttAPEv2'
        'ttFlac'
        'ttID3v1'
        'ttID3v2'
        'ttMP4'
        'ttOpusVorbis'
        'ttWAV'
        'ttWMA')
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 904
    Top = 432
  end
  object ImageListThumbs: TImageList
    Height = 120
    Width = 160
    Left = 824
    Top = 648
  end
  object SaveDialog1: TSaveDialog
    Left = 824
    Top = 592
  end
end
