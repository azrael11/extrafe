object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ID3v2 Custom Frames Tutorial'
  ClientHeight = 478
  ClientWidth = 673
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
    Width = 673
    Height = 478
    Align = alClient
    Caption = ' Options: '
    TabOrder = 0
    ExplicitHeight = 324
    object Label1: TLabel
      Left = 20
      Top = 32
      Width = 49
      Height = 13
      Caption = 'File name:'
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 100
      Width = 631
      Height = 205
      Caption = ' Frames: '
      TabOrder = 5
      object Label2: TLabel
        Left = 18
        Top = 36
        Width = 57
        Height = 13
        Caption = 'Description:'
      end
      object Label3: TLabel
        Left = 18
        Top = 63
        Width = 43
        Height = 13
        Caption = 'Content:'
      end
      object Button4: TButton
        Left = 540
        Top = 168
        Width = 75
        Height = 25
        Caption = 'Set'
        TabOrder = 0
        OnClick = Button4Click
      end
      object Edit2: TEdit
        Left = 81
        Top = 33
        Width = 453
        Height = 21
        TabOrder = 1
      end
      object Memo1: TMemo
        Left = 81
        Top = 60
        Width = 532
        Height = 102
        TabOrder = 2
      end
      object Button5: TButton
        Left = 540
        Top = 29
        Width = 75
        Height = 25
        Caption = 'Find!'
        TabOrder = 3
        OnClick = Button5Click
      end
      object Button7: TButton
        Left = 459
        Top = 168
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 4
        OnClick = Button7Click
      end
    end
    object Edit1: TEdit
      Left = 75
      Top = 29
      Width = 543
      Height = 21
      TabOrder = 0
      Text = 'CustomFrameTest.tag'
    end
    object Button1: TButton
      Left = 624
      Top = 27
      Width = 27
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 504
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 585
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 98
      Width = 90
      Height = 21
      TabOrder = 4
      OnSelect = ComboBox1Selct
    end
    object Button6: TButton
      Left = 398
      Top = 268
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 6
      OnClick = Button6Click
    end
    object GroupBox3: TGroupBox
      Left = 20
      Top = 320
      Width = 631
      Height = 137
      Caption = ' Rating: '
      TabOrder = 7
      object Label4: TLabel
        Left = 18
        Top = 36
        Width = 32
        Height = 13
        Caption = 'E-mail:'
      end
      object Label5: TLabel
        Left = 18
        Top = 64
        Width = 35
        Height = 13
        Caption = 'Rating:'
      end
      object Label6: TLabel
        Left = 18
        Top = 96
        Width = 51
        Height = 13
        Caption = 'Playcount:'
      end
      object Edit3: TEdit
        Left = 81
        Top = 33
        Width = 453
        Height = 21
        TabOrder = 0
      end
      object SpinEdit1: TSpinEdit
        Left = 81
        Top = 61
        Width = 99
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object SpinEdit2: TSpinEdit
        Left = 81
        Top = 94
        Width = 99
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object Button8: TButton
        Left = 540
        Top = 96
        Width = 75
        Height = 25
        Caption = 'Set'
        TabOrder = 3
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 459
        Top = 96
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 4
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 378
        Top = 96
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 5
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 540
        Top = 29
        Width = 75
        Height = 25
        Caption = 'Find!'
        TabOrder = 6
        OnClick = Button11Click
      end
      object Button12: TButton
        Left = 186
        Top = 92
        Width = 75
        Height = 25
        Caption = 'Increment'
        TabOrder = 7
        OnClick = Button12Click
      end
    end
    object ComboBox2: TComboBox
      Left = 68
      Top = 318
      Width = 90
      Height = 21
      TabOrder = 8
      OnSelect = ComboBox2Select
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 540
    Top = 16
  end
end
