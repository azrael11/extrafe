object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'APEv2 Library Tutorial'
  ClientHeight = 679
  ClientWidth = 955
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    955
    679)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 955
    Height = 645
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Options: '
    TabOrder = 0
    DesignSize = (
      955
      645)
    object Label1: TLabel
      Left = 20
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
    object Label2: TLabel
      Left = 20
      Top = 544
      Width = 94
      Height = 13
      Caption = 'APEv2 Tag version:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 120
      Top = 544
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 563
      Width = 77
      Height = 13
      Caption = 'APEv2 Tag size:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 120
      Top = 563
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 20
      Top = 582
      Width = 92
      Height = 13
      Caption = 'Picture description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 120
      Top = 582
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 75
      Top = 29
      Width = 831
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Test.ape'
    end
    object Button2: TButton
      Left = 912
      Top = 27
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 704
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 785
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      OnClick = Button4Click
    end
    object ListView1: TListView
      Left = 12
      Top = 99
      Width = 932
      Height = 430
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Field name'
          Width = 250
        end
        item
          Caption = 'Value'
          Width = 500
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      SmallImages = ImageList1
      TabOrder = 4
      ViewStyle = vsReport
      OnClick = ListView1Click
      OnSelectItem = ListView1SelectItem
    end
    object Panel1: TPanel
      Left = 844
      Top = 535
      Width = 100
      Height = 100
      BevelOuter = bvLowered
      Caption = 'Picture'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 98
        Height = 98
        Align = alClient
        Stretch = True
        ExplicitLeft = 29
      end
    end
    object Button5: TButton
      Left = 866
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 6
      OnClick = Button5Click
    end
    object EditFieldValue: TEdit
      Left = 704
      Top = 544
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = 'EditFieldValue'
      Visible = False
      OnChange = EditFieldValueChange
      OnKeyDown = EditFieldValueKeyDown
    end
    object ComboBoxFieldName: TComboBox
      Left = 704
      Top = 571
      Width = 121
      Height = 21
      DropDownCount = 64
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = 'ComboBoxFieldName'
      Visible = False
      OnExit = ComboBoxFieldNameExit
      Items.Strings = (
        ' - Cancel -'
        'Artist'
        'Album'
        'Title'
        'Track'
        'Genre'
        'Year'
        'Comment'
        'Album Artist'
        'Band'
        'Disc'
        'Rating'
        'Temo'
        'Chorus'
        'Composer'
        'Conductor'
        'Instrument'
        'Label'
        'Orchestra'
        'Period'
        'Soloists'
        'Copyright'
        'ISRC'
        'Lyrics'
        'Lyricist'
        'Mood'
        'Style'
        'Subtitle'
        'DiscSubtitle'
        'UPC'
        'ArtistSort'
        'AlbumArtistSort'
        'AlbumSort'
        'ComposerSort'
        'ConductorSort'
        'TitleSort'
        'MixArtist'
        'Arranger'
        'Engineer'
        'Producer'
        'DJMixer'
        'Mixer'
        'Grouping'
        'Compilation'
        'BPM'
        'Media'
        'CatalogNumber'
        'Barcode'
        'EncodedBy'
        'Script'
        'Language'
        'LICENSE'
        'RELEASECOUNTRY')
    end
    object ButtonDeleteField: TButton
      Left = 115
      Top = 68
      Width = 130
      Height = 25
      Hint = 'Remove selected field and value.'
      Caption = 'Delete Selected Field'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = ButtonDeleteFieldClick
    end
    object ButtonAddField: TButton
      Left = 12
      Top = 68
      Width = 97
      Height = 25
      Hint = 'Create a new field and set it'#39's value.'
      Caption = 'Add New Field'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = ButtonAddFieldClick
    end
    object Button6: TButton
      Left = 251
      Top = 68
      Width = 126
      Height = 25
      Caption = 'Add a cover art...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = Button6Click
    end
  end
  object Button1: TButton
    Left = 872
    Top = 651
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 784
    Top = 132
  end
  object ImageList1: TImageList
    Height = 19
    Width = 1
    Left = 860
    Top = 132
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.gif;*.png;*.jpg;*.jpeg;*.bmp)|*.gif;*.png;*.jpg;*.jpeg|GI' +
      'F Image (*.gif)|*.gif|Portable Network Graphics (*.png)|*.png|JP' +
      'EG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitm' +
      'aps (*.bmp)|*.bmp'
    Left = 784
    Top = 184
  end
end
