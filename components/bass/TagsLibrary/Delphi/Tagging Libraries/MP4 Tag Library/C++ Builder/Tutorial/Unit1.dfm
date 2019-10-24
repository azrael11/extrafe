object Form1: TForm1
  Left = 500
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MP4 TAG'
  ClientHeight = 531
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnDestroy = FormDestroy
  DesignSize = (
    667
    531)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 1
    Top = 0
    Width = 661
    Height = 494
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Options: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      661
      494)
    object Label1: TLabel
      Left = 18
      Top = 28
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
      Left = 18
      Top = 88
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
    object Label3: TLabel
      Left = 19
      Top = 115
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
    object Label4: TLabel
      Left = 19
      Top = 142
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
    object Label5: TLabel
      Left = 19
      Top = 169
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
    object Label6: TLabel
      Left = 19
      Top = 196
      Width = 27
      Height = 13
      Caption = 'Date:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 18
      Top = 223
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
    object Label8: TLabel
      Left = 19
      Top = 250
      Width = 23
      Height = 13
      Caption = 'Disc:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 19
      Top = 277
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
    object Label10: TLabel
      Left = 127
      Top = 223
      Width = 10
      Height = 13
      Caption = 'of'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 127
      Top = 250
      Width = 10
      Height = 13
      Caption = 'of'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 73
      Top = 25
      Width = 538
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button2: TButton
      Left = 617
      Top = 23
      Width = 25
      Height = 25
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 486
      Top = 54
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Memo1: TMemo
      Left = 18
      Top = 313
      Width = 363
      Height = 164
      Anchors = [akLeft, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object Panel1: TPanel
      Left = 493
      Top = 328
      Width = 150
      Height = 150
      Anchors = [akLeft, akBottom]
      BevelOuter = bvLowered
      Caption = 'Cover'
      TabOrder = 4
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 148
        Height = 148
        Align = alClient
        Stretch = True
        ExplicitLeft = 5
        ExplicitTop = 2
      end
    end
    object Button4: TButton
      Left = 567
      Top = 54
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Edit2: TEdit
      Left = 73
      Top = 85
      Width = 569
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object Edit3: TEdit
      Left = 73
      Top = 112
      Width = 570
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object Edit4: TEdit
      Left = 73
      Top = 139
      Width = 570
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object Edit5: TEdit
      Left = 73
      Top = 166
      Width = 570
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object Edit6: TEdit
      Left = 73
      Top = 193
      Width = 570
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object Edit7: TEdit
      Left = 73
      Top = 220
      Width = 48
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object Edit8: TEdit
      Left = 73
      Top = 247
      Width = 48
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object Edit9: TEdit
      Left = 73
      Top = 274
      Width = 570
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object Button5: TButton
      Left = 405
      Top = 54
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 14
      OnClick = Button5Click
    end
    object Edit10: TEdit
      Left = 143
      Top = 220
      Width = 50
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object Edit11: TEdit
      Left = 143
      Top = 247
      Width = 50
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
    object Button6: TButton
      Left = 399
      Top = 452
      Width = 70
      Height = 25
      Caption = 'Add...'
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 17
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 399
      Top = 424
      Width = 70
      Height = 25
      Caption = 'Delete'
      TabOrder = 18
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 399
      Top = 397
      Width = 70
      Height = 25
      Caption = 'Export...'
      TabOrder = 19
      OnClick = Button8Click
    end
    object UpDown1: TUpDown
      Left = 408
      Top = 364
      Width = 48
      Height = 25
      Orientation = udHorizontal
      TabOrder = 20
      OnClick = UpDown1Click
    end
  end
  object Button1: TButton
    Left = 519
    Top = 498
    Width = 98
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object OpenDialog: TOpenDialog
    Left = 368
    Top = 48
  end
  object SaveDialog1: TSaveDialog
    Left = 420
    Top = 320
  end
end
