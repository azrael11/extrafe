object Form1: TForm1
  Left = 560
  Top = 104
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ID3v2 Library Tutorial C++'
  ClientHeight = 807
  ClientWidth = 803
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesigned
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 20
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
  object Edit1: TEdit
    Left = 74
    Top = 18
    Width = 623
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button8: TButton
    Left = 708
    Top = 18
    Width = 59
    Height = 22
    Caption = 'Select...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button8Click
  end
  object PageControl1: TPageControl
    Left = 10
    Top = 46
    Width = 785
    Height = 755
    ActivePage = TabSheet2
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'ID3v1'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 753
        Height = 209
        Caption = ' ID3v1: '
        TabOrder = 0
        DesignSize = (
          753
          209)
        object Label4: TLabel
          Left = 16
          Top = 28
          Width = 24
          Height = 13
          Caption = 'Title:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 16
          Top = 52
          Width = 30
          Height = 13
          Caption = 'Artist:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 16
          Top = 76
          Width = 33
          Height = 13
          Caption = 'Album:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 16
          Top = 98
          Width = 26
          Height = 13
          Caption = 'Year:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 16
          Top = 122
          Width = 49
          Height = 13
          Caption = 'Comment:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 16
          Top = 146
          Width = 33
          Height = 13
          Caption = 'Genre:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 16
          Top = 170
          Width = 30
          Height = 13
          Caption = 'Track:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Button5: TButton
          Left = 674
          Top = 24
          Width = 59
          Height = 22
          Caption = 'Load'
          TabOrder = 0
          OnClick = Button5Click
        end
        object Edit4: TEdit
          Left = 76
          Top = 24
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Edit5: TEdit
          Left = 76
          Top = 48
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Edit6: TEdit
          Left = 76
          Top = 72
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Edit7: TEdit
          Left = 76
          Top = 96
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Edit8: TEdit
          Left = 76
          Top = 120
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object Button9: TButton
          Left = 674
          Top = 48
          Width = 59
          Height = 22
          Caption = 'Save'
          TabOrder = 6
          OnClick = Button9Click
        end
        object Button15: TButton
          Left = 674
          Top = 73
          Width = 59
          Height = 22
          Caption = 'Remove'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = Button15Click
        end
        object Edit16: TEdit
          Left = 76
          Top = 168
          Width = 565
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object ComboBoxID3v1_Genre: TComboBox
          Left = 76
          Top = 144
          Width = 565
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DropDownCount = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          Items.Strings = (
            'A Cappella'
            'Acid'
            'Acid Jazz'
            'Acid Punk'
            'Acoustic'
            'Alt. Rock'
            'Alternative'
            'Ambient'
            'Anime'
            'Avantgarde'
            'Ballad'
            'Bass'
            'Beat'
            'Bebob'
            'Big Band'
            'Black Metal'
            'Bluegrass'
            'Blues'
            'Booty Bass'
            'BritPop'
            'Cabaret'
            'Celtic'
            'Chamber Music'
            'Chanson'
            'Chorus'
            'Christian Gangsta'
            'Christian Rap'
            'Christian Rock'
            'Classic Rock'
            'Classical'
            'Club'
            'Club-House'
            'Comedy'
            'Contemporary Christian'
            'Country'
            'Crossover'
            'Cult'
            'Dance'
            'Dance Hall'
            'Darkwave'
            'Death Metal'
            'Disco'
            'Dream'
            'Drum & Base'
            'Drum Solo'
            'Duet'
            'Easy Listening'
            'Electronic'
            'Ethnic'
            'Eurodance'
            'Euro-House'
            'Euro-Techno'
            'Fast-Fusion'
            'Folk'
            'Folk/Rock'
            'Folklore'
            'Freestyle'
            'Funk'
            'Fusion'
            'Game'
            'Gangsta Rap'
            'Goa'
            'Gospel'
            'Gothic'
            'Gothic Rock'
            'Grunge'
            'Hard Rock'
            'Hardcore'
            'Heavy Metal'
            'Hip-Hop'
            'House'
            'Humour'
            'Indie'
            'Industrial'
            'Instrumental'
            'Instrumental Pop'
            'Instrumental Rock'
            'Jazz'
            'Jazz+Funk'
            'JPop'
            'Jungle'
            'Latin'
            'Lo-Fi'
            'Meditative'
            'Merengue'
            'Metal'
            'Musical'
            'National Folk'
            'Native American'
            'Negerpunk'
            'New Age'
            'New Wave'
            'Noise'
            'Oldies'
            'Opera'
            'Other'
            'Polka'
            'Polsk Punk'
            'Pop'
            'Pop/Funk'
            'Pop-Folk'
            'Porn Groove'
            'Power Ballad'
            'Pranks'
            'Primus'
            'Progressive Rock'
            'Psychedelic'
            'Psychedelic Rock'
            'Punk'
            'Punk Rock'
            'R&B'
            'Rap'
            'Rave'
            'Reggae'
            'Retro'
            'Revival'
            'Rhythmic Soul'
            'Rock'
            'Rock & Roll'
            'Salsa'
            'Samba'
            'Satire'
            'Showtunes'
            'Ska'
            'Slow Jam'
            'Slow Rock'
            'Sonata'
            'Soul'
            'Sound Clip'
            'Soundtrack'
            'Southern Rock'
            'Space'
            'Speech'
            'Swing'
            'Symphonic Rock'
            'Symphony'
            'Synthpop'
            'Tango'
            'Techno'
            'Techno-Industrial'
            'Terror'
            'Thrash Metal'
            'Top 40'
            'Trailer'
            'Trance'
            'Tribal'
            'Trip-Hop'
            'Vocal')
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'ID3v2'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 761
        Height = 713
        Caption = ' ID3v2: '
        TabOrder = 0
        object Button3: TButton
          Left = 686
          Top = 17
          Width = 59
          Height = 22
          Caption = 'Load'
          TabOrder = 0
          OnClick = Button3Click
        end
        object Button6: TButton
          Left = 686
          Top = 45
          Width = 59
          Height = 22
          Caption = 'Save'
          TabOrder = 1
          OnClick = Button6Click
        end
        object GroupBox3: TGroupBox
          Left = 15
          Top = 365
          Width = 729
          Height = 141
          Caption = ' Album Cover Picture: '
          TabOrder = 2
          object Label19: TLabel
            Left = 184
            Top = 115
            Width = 84
            Height = 13
            Alignment = taRightJustify
            Caption = 'APIC Description:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 240
            Top = 87
            Width = 28
            Height = 13
            Caption = 'Type:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 274
            Top = 87
            Width = 44
            Height = 13
            Caption = 'Unknown'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label45: TLabel
            Left = 212
            Top = 64
            Width = 56
            Height = 13
            Caption = 'Image Size:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LabelImgSize: TLabel
            Left = 275
            Top = 64
            Width = 18
            Height = 13
            Caption = '0x0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Panel1: TPanel
            Left = 596
            Top = 8
            Width = 130
            Height = 130
            BevelOuter = bvLowered
            Caption = 'APIC'
            TabOrder = 0
            object Image1: TImage
              Left = 1
              Top = 1
              Width = 128
              Height = 128
              Align = alClient
              ExplicitLeft = 0
              ExplicitHeight = 117
            end
          end
          object Button10: TButton
            Left = 22
            Top = 106
            Width = 145
            Height = 22
            Caption = 'Add APIC from file...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = Button10Click
          end
          object Button11: TButton
            Left = 22
            Top = 78
            Width = 145
            Height = 22
            Caption = 'Save APIC to file...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = Button11Click
          end
          object Button12: TButton
            Left = 23
            Top = 19
            Width = 144
            Height = 22
            Caption = 'Show first picture'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = Button12Click
          end
          object Edit15: TEdit
            Left = 274
            Top = 112
            Width = 313
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = 'Description'
          end
          object UpDown1: TUpDown
            Left = 548
            Top = 10
            Width = 41
            Height = 20
            Max = 10000
            Orientation = udHorizontal
            TabOrder = 5
            OnClick = UpDown1Click
          end
          object Button17: TButton
            Left = 22
            Top = 47
            Width = 145
            Height = 25
            Caption = 'Delete this APIC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = Button17Click
          end
        end
        object Button16: TButton
          Left = 686
          Top = 72
          Width = 59
          Height = 22
          Caption = 'Remove'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = Button16Click
        end
        object GroupBox4: TGroupBox
          Left = 470
          Top = 101
          Width = 275
          Height = 174
          Caption = ' Lyrics: '
          TabOrder = 4
          object Label23: TLabel
            Left = 16
            Top = 20
            Width = 65
            Height = 13
            Caption = 'Language ID:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 16
            Top = 47
            Width = 57
            Height = 13
            Caption = 'Description:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Memo3: TMemo
            Left = 16
            Top = 71
            Width = 249
            Height = 90
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Edit17: TEdit
            Left = 87
            Top = 17
            Width = 178
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Edit20: TEdit
            Left = 87
            Top = 44
            Width = 178
            Height = 21
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
          Left = 15
          Top = 512
          Width = 729
          Height = 193
          Caption = ' All frames: '
          TabOrder = 5
          object Label2: TLabel
            Left = 230
            Top = 17
            Width = 34
            Height = 13
            Caption = 'Frame:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 19
            Top = 36
            Width = 111
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tag alter preservation:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 136
            Top = 36
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 107
            Top = 17
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = 'Size:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 136
            Top = 17
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 136
            Top = 55
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 21
            Top = 55
            Width = 109
            Height = 13
            Alignment = taRightJustify
            Caption = 'File alter preservation:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label33: TLabel
            Left = 136
            Top = 74
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label34: TLabel
            Left = 78
            Top = 74
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'Read only:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 136
            Top = 93
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label36: TLabel
            Left = 44
            Top = 93
            Width = 86
            Height = 13
            Alignment = taRightJustify
            Caption = 'Grouping identity:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 136
            Top = 112
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label38: TLabel
            Left = 67
            Top = 112
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'Compressed:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label39: TLabel
            Left = 136
            Top = 131
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label40: TLabel
            Left = 77
            Top = 131
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Encrypted:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label41: TLabel
            Left = 136
            Top = 150
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label42: TLabel
            Left = 50
            Top = 150
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'Unsynchronised:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label43: TLabel
            Left = 136
            Top = 169
            Width = 15
            Height = 13
            Caption = '???'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label44: TLabel
            Left = 26
            Top = 169
            Width = 104
            Height = 13
            Alignment = taRightJustify
            Caption = 'Data length indicator:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Memo1: TMemo
            Left = 171
            Top = 41
            Width = 554
            Height = 112
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Lucida Console'
            Font.Style = []
            Lines.Strings = (
              '...')
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Button1: TButton
            Left = 319
            Top = 159
            Width = 78
            Height = 22
            Caption = 'DeCompress'
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
            Left = 235
            Top = 159
            Width = 78
            Height = 22
            Caption = 'Compress'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = Button2Click
          end
          object ComboBox1: TComboBox
            Left = 274
            Top = 14
            Width = 79
            Height = 21
            DropDownCount = 16
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = ComboBox1Change
          end
          object Button4: TButton
            Left = 559
            Top = 159
            Width = 154
            Height = 22
            Caption = 'Remove Unsynchronisation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = Button4Click
          end
          object Button7: TButton
            Left = 409
            Top = 159
            Width = 144
            Height = 22
            Caption = 'Apply Unsynchronisation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = Button7Click
          end
        end
        object GroupBox6: TGroupBox
          Left = 15
          Top = 281
          Width = 730
          Height = 78
          Caption = ' Comment: '
          TabOrder = 6
          object Label26: TLabel
            Left = 477
            Top = 45
            Width = 57
            Height = 13
            Caption = 'Description:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 477
            Top = 23
            Width = 65
            Height = 13
            Caption = 'Language ID:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Memo2: TMemo
            Left = 9
            Top = 16
            Width = 456
            Height = 49
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Edit18: TEdit
            Left = 550
            Top = 42
            Width = 167
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Edit19: TEdit
            Left = 550
            Top = 20
            Width = 167
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
        object GroupBox7: TGroupBox
          Left = 15
          Top = 16
          Width = 653
          Height = 78
          Caption = ' Tag Attributes:  (reference only)'
          Enabled = False
          TabOrder = 7
          object Label16: TLabel
            Left = 16
            Top = 51
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tag version:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 82
            Top = 51
            Width = 44
            Height = 13
            Caption = 'Unknown'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CheckBox1: TCheckBox
            Left = 149
            Top = 22
            Width = 97
            Height = 17
            Caption = 'Unsynchronised'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object CheckBox2: TCheckBox
            Left = 149
            Top = 45
            Width = 108
            Height = 17
            Caption = 'Extended header'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object CheckBox3: TCheckBox
            Left = 288
            Top = 22
            Width = 97
            Height = 17
            Caption = 'Experimental'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object CheckBox4: TCheckBox
            Left = 288
            Top = 45
            Width = 97
            Height = 17
            Caption = 'CRC present'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
        end
        object GroupBox8: TGroupBox
          Left = 15
          Top = 101
          Width = 449
          Height = 174
          Caption = ' Information: '
          TabOrder = 8
          object Label18: TLabel
            Left = 124
            Top = 96
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'Track:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 16
            Top = 143
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
          object Label14: TLabel
            Left = 16
            Top = 119
            Width = 33
            Height = 13
            Caption = 'Genre:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 16
            Top = 96
            Width = 26
            Height = 13
            Caption = 'Year:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 16
            Top = 73
            Width = 33
            Height = 13
            Caption = 'Album:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 16
            Top = 49
            Width = 30
            Height = 13
            Caption = 'Artist:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 16
            Top = 25
            Width = 24
            Height = 13
            Caption = 'Title:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 217
            Top = 96
            Width = 52
            Height = 13
            Caption = 'Composer:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Edit14: TEdit
            Left = 160
            Top = 93
            Width = 54
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object Edit12: TEdit
            Left = 62
            Top = 141
            Width = 373
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object ComboBox2: TComboBox
            Left = 62
            Top = 117
            Width = 373
            Height = 21
            DropDownCount = 24
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Items.Strings = (
              'A Cappella'
              'Acid'
              'Acid Jazz'
              'Acid Punk'
              'Acoustic'
              'Alt. Rock'
              'Alternative'
              'Ambient'
              'Anime'
              'Avantgarde'
              'Ballad'
              'Bass'
              'Beat'
              'Bebob'
              'Big Band'
              'Black Metal'
              'Bluegrass'
              'Blues'
              'Booty Bass'
              'BritPop'
              'Cabaret'
              'Celtic'
              'Chamber Music'
              'Chanson'
              'Chorus'
              'Christian Gangsta'
              'Christian Rap'
              'Christian Rock'
              'Classic Rock'
              'Classical'
              'Club'
              'Club-House'
              'Comedy'
              'Contemporary Christian'
              'Country'
              'Crossover'
              'Cult'
              'Dance'
              'Dance Hall'
              'Darkwave'
              'Death Metal'
              'Disco'
              'Dream'
              'Drum & Base'
              'Drum Solo'
              'Duet'
              'Easy Listening'
              'Electronic'
              'Ethnic'
              'Eurodance'
              'Euro-House'
              'Euro-Techno'
              'Fast-Fusion'
              'Folk'
              'Folk/Rock'
              'Folklore'
              'Freestyle'
              'Funk'
              'Fusion'
              'Game'
              'Gangsta Rap'
              'Goa'
              'Gospel'
              'Gothic'
              'Gothic Rock'
              'Grunge'
              'Hard Rock'
              'Hardcore'
              'Heavy Metal'
              'Hip-Hop'
              'House'
              'Humour'
              'Indie'
              'Industrial'
              'Instrumental'
              'Instrumental Pop'
              'Instrumental Rock'
              'Jazz'
              'Jazz+Funk'
              'JPop'
              'Jungle'
              'Latin'
              'Lo-Fi'
              'Meditative'
              'Merengue'
              'Metal'
              'Musical'
              'National Folk'
              'Native American'
              'Negerpunk'
              'New Age'
              'New Wave'
              'Noise'
              'Oldies'
              'Opera'
              'Other'
              'Polka'
              'Polsk Punk'
              'Pop'
              'Pop/Funk'
              'Pop-Folk'
              'Porn Groove'
              'Power Ballad'
              'Pranks'
              'Primus'
              'Progressive Rock'
              'Psychedelic'
              'Psychedelic Rock'
              'Punk'
              'Punk Rock'
              'R&B'
              'Rap'
              'Rave'
              'Reggae'
              'Retro'
              'Revival'
              'Rhythmic Soul'
              'Rock'
              'Rock & Roll'
              'Salsa'
              'Samba'
              'Satire'
              'Showtunes'
              'Ska'
              'Slow Jam'
              'Slow Rock'
              'Sonata'
              'Soul'
              'Sound Clip'
              'Soundtrack'
              'Southern Rock'
              'Space'
              'Speech'
              'Swing'
              'Symphonic Rock'
              'Symphony'
              'Synthpop'
              'Tango'
              'Techno'
              'Techno-Industrial'
              'Terror'
              'Thrash Metal'
              'Top 40'
              'Trailer'
              'Trance'
              'Tribal'
              'Trip-Hop'
              'Vocal')
          end
          object Edit11: TEdit
            Left = 62
            Top = 93
            Width = 57
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object Edit10: TEdit
            Left = 62
            Top = 69
            Width = 373
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object Edit3: TEdit
            Left = 62
            Top = 45
            Width = 373
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object Edit2: TEdit
            Left = 62
            Top = 21
            Width = 373
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object Edit9: TEdit
            Left = 274
            Top = 93
            Width = 160
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 534
    Top = 116
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Left = 606
    Top = 116
  end
end
