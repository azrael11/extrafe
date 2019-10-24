VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPicFromMem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Add as Reference IStream.tlb

' ----==== GDI+ Konstanten ====----
Private Const GdiPlusVersion As Long = 1&

' ----==== GDI+ Typen ====----
Private Type GDIPlusStartupInput
    GdiPlusVersion As Long
    DebugEventCallback As Long
    SuppressBackgroundThread As Long
    SuppressExternalCodecs As Long
End Type

Private Type GdiplusStartupOutput
    NotificationHook As Long
    NotificationUnhook As Long
End Type

' ----==== Sonstige Typen ====----
Private Type PICTDESC
    cbSizeOfStruct As Long
    picType As Long
    hgdiObj As Long
    hPalOrXYExt As Long
End Type

Private Type IID
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(0 To 7)  As Byte
End Type

' ----==== GDI+ Enums ====----
Private Enum Status ' GDI+ Status
    OK = 0
    GenericError = 1
    InvalidParameter = 2
    OutOfMemory = 3
    ObjectBusy = 4
    InsufficientBuffer = 5
    NotImplemented = 6
    Win32Error = 7
    WrongState = 8
    Aborted = 9
    FileNotFound = 10
    ValueOverflow = 11
    AccessDenied = 12
    UnknownImageFormat = 13
    FontFamilyNotFound = 14
    FontStyleNotFound = 15
    NotTrueTypeFont = 16
    UnsupportedGdiplusVersion = 17
    GdiplusNotInitialized = 18
    PropertyNotFound = 19
    PropertyNotSupported = 20
    ProfileNotFound = 21
End Enum

' ----==== GDI+ Deklarationen ====----
Private Declare Function GdipCreateHBITMAPFromBitmap Lib "gdiplus" ( _
    ByVal bitmap As Long, _
    ByRef hbmReturn As Long, _
    ByVal Background As Long) As Status

Private Declare Function GdiplusShutdown Lib "gdiplus" ( _
    ByVal token As Long) As Status

Private Declare Function GdiplusStartup Lib "gdiplus" ( _
    ByRef token As Long, _
    ByRef lpInput As GDIPlusStartupInput, _
    ByRef lpOutput As Any) As Status

Private Declare Function GdipDisposeImage Lib "gdiplus" ( _
    ByVal mImage As Long) As Status

Private Declare Function GdipLoadImageFromStream Lib "gdiplus" ( _
    ByVal stream As IUnknown, _
    ByRef Image As Long) As Status

' ----==== OLE32 API Deklarationen ====----
Private Declare Function CreateStreamOnHGlobal Lib "ole32.dll" ( _
    ByRef hGlobal As Any, _
    ByVal fDeleteOnRelease As Long, _
    ByRef ppstm As Any) As Long

' ----==== OLEAUT32 API Deklarations ====----
Private Declare Sub OleCreatePictureIndirect Lib "oleaut32.dll" ( _
    lpPictDesc As PICTDESC, _
    riid As IID, _
    ByVal fOwn As Boolean, _
    lplpvObj As Object)

Private GdiPlusToken As Long

Private Sub Class_Initialize()

Dim GdipStartupInput As GDIPlusStartupInput

    GdipStartupInput.GdiPlusVersion = GdiPlusVersion

    If GdiplusStartup(GdiPlusToken, GdipStartupInput, ByVal 0&) <> OK Then

        MsgBox "GDI+ konnte nicht initialisiert werden.", vbOKOnly Or _
               vbInformation, "GDI+ Error"

    End If

End Sub

Private Sub Class_Terminate()

    If GdiPlusToken <> 0 Then

        Call GdiplusShutdown(GdiPlusToken)

    End If

End Sub

Private Function Execute(ByVal lReturn As Status) As Status

Dim lCurErr As Status

    If lReturn = Status.OK Then

        lCurErr = Status.OK

    Else

        lCurErr = lReturn

        MsgBox GdiErrorString(lReturn) & " GDI+ Error:" & lReturn, _
                              vbOKOnly, "GDI Error"

    End If

    Execute = lCurErr

End Function

Public Function MemToHBitmap(ByVal DataPtr As Long, ByVal Size As Long) As Long

Dim FNr As Long
Dim bArray() As Byte
Dim stream As IUnknown
Dim lBitmap As Long
Dim hBitmap As Long

    ' Array Redimensionieren
    ReDim bArray(Size - 1)
    Call CopyMemory(bArray(0), ByVal DataPtr, ByVal Size)
    
    ' Stream erstellen
    Call CreateStreamOnHGlobal(bArray(0), False, stream)

    ' ist ein Stream vorhanden
    If Not (stream Is Nothing) Then

        ' GDI+ Bitmapobjekt vom Stream erstellen
        If Execute(GdipLoadImageFromStream(stream, lBitmap)) = OK Then

            ' Handle des Bitmapobjektes ermitteln
            If Execute(GdipCreateHBITMAPFromBitmap(lBitmap, hBitmap, 0)) = OK Then
                       
                ' hBitmap zurück geben
                MemToHBitmap = hBitmap
            End If

            ' Bitmapobjekt löschen
            Call Execute(GdipDisposeImage(lBitmap))

        End If
    End If

End Function

Private Function GdiErrorString(ByVal eError As Status) As String

Dim s As String

    Select Case eError

    Case GenericError:              s = "Generic Error."
    Case InvalidParameter:          s = "Invalid Parameter."
    Case OutOfMemory:               s = "Out Of Memory."
    Case ObjectBusy:                s = "Object Busy."
    Case InsufficientBuffer:        s = "Insufficient Buffer."
    Case NotImplemented:            s = "Not Implemented."
    Case Win32Error:                s = "Win32 Error."
    Case WrongState:                s = "Wrong State."
    Case Aborted:                   s = "Aborted."
    Case FileNotFound:              s = "File Not Found."
    Case ValueOverflow:             s = "Value Overflow."
    Case AccessDenied:              s = "Access Denied."
    Case UnknownImageFormat:        s = "Unknown Image Format."
    Case FontFamilyNotFound:        s = "FontFamily Not Found."
    Case FontStyleNotFound:         s = "FontStyle Not Found."
    Case NotTrueTypeFont:           s = "Not TrueType Font."
    Case UnsupportedGdiplusVersion: s = "Unsupported Gdiplus Version."
    Case GdiplusNotInitialized:     s = "Gdiplus Not Initialized."
    Case PropertyNotFound:          s = "Property Not Found."
    Case PropertyNotSupported:      s = "Property Not Supported."
    Case ProfileNotFound:           s = "Profile Not Found."
    Case Else:                      s = "Unknown GDI+ Error."

    End Select

    GdiErrorString = s

End Function

Public Function HBitmapToStdPicture(ByVal hBitmap As Long, ByVal _
                                 ObjectType As PictureTypeConstants, Optional ByVal hPal As Long = 0) _
                                 As StdPicture

Dim tPictDesc As PICTDESC
Dim IID_IPicture As IID
Dim oPicture As IPicture

    ' Initialisiert die PICTDESC Structur
    With tPictDesc

        .cbSizeOfStruct = Len(tPictDesc)
        .picType = ObjectType
        .hgdiObj = hBitmap
        .hPalOrXYExt = hPal

    End With

    ' Initialisiert das IPicture Interface ID
    With IID_IPicture

        .Data1 = &H7BF80981
        .Data2 = &HBF32
        .Data3 = &H101A
        .Data4(0) = &H8B
        .Data4(1) = &HBB
        .Data4(3) = &HAA
        .Data4(5) = &H30
        .Data4(6) = &HC
        .Data4(7) = &HAB

    End With

    ' Erzeugen des Objekts
    Call OleCreatePictureIndirect(tPictDesc, IID_IPicture, True, oPicture)

    ' Rückgabe des Pictureobjekts
    Set HBitmapToStdPicture = oPicture

End Function
