VERSION 5.00
Begin VB.Form Disassembler 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "R4300i Disassembler"
   ClientHeight    =   8175
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   7950
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   545
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   530
   Begin VB.ComboBox cmbSetEndian 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0000
      Left            =   0
      List            =   "Disassembler.frx":0010
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   360
      Width           =   2625
   End
   Begin VB.ComboBox cmbRegView 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0054
      Left            =   5280
      List            =   "Disassembler.frx":0067
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   0
      Width           =   2625
   End
   Begin VB.ComboBox cmbEditMenu 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":009F
      Left            =   2640
      List            =   "Disassembler.frx":00BB
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   0
      Width           =   2625
   End
   Begin VB.ComboBox cmbFileMenu 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0164
      Left            =   0
      List            =   "Disassembler.frx":018C
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   0
      Width           =   2625
   End
   Begin VB.CommandButton cmdPrevPG 
      Caption         =   "Previous"
      Enabled         =   0   'False
      Height          =   375
      Left            =   1320
      TabIndex        =   2
      Top             =   7080
      Width           =   1095
   End
   Begin VB.CommandButton cmdNextPG 
      Caption         =   "Next"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5520
      TabIndex        =   1
      Top             =   7080
      Width           =   1095
   End
   Begin VB.ListBox lstASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6000
      ItemData        =   "Disassembler.frx":027B
      Left            =   840
      List            =   "Disassembler.frx":027D
      TabIndex        =   0
      Top             =   1080
      Width           =   6255
   End
End
Attribute VB_Name = "Disassembler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim addy As Long
Dim ROMEdited As Boolean, ROMloaded As Boolean
Public CurrentROM As String
Const PageSize = 32
 '100mb 26214400
Private Sub Form_Load()
 OpenTools(4) = True
 OPprintType = 0
 GPRnames = Split(GPRNameList1, ",")
 FPRnames = Split(FPRNameList1, ",")
 CP0names = Split(CP0NameList1, ",")
 fmt(16) = "S"
 fmt(17) = "D"
 fmt(20) = "W"
 fmt(21) = "L"
 cmbFileMenu.ListIndex = 0
 cmbEditMenu.ListIndex = 0
 cmbRegView.ListIndex = 0
 cmbSetEndian.ListIndex = 0
End Sub
Private Sub Form_Unload(cancel As Integer)
 Dim i As Integer
 If Right(Disassembler.Caption, 1) = "*" Then
  i = MsgBox("Save file before closing?", vbYesNoCancel)
  If i = vbYes Then
   mnuSaveROM
  ElseIf i = vbCancel Then
   cancel = 1
  End If
 End If
 If cancel <> 1 Then
  Close #ROMhandle
  Close #tmpHandle
  OpenTools(4) = False
 End If
End Sub
Private Sub mnuOpenROM()
 Dim tmpbyte As Byte
 Dim romname As String
 Close #ROMhandle
 ROMhandle = FreeFile
 If Not ChooseFile(CurrentROM, "N64 ROMs & Saves (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur,*.pj)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur;*.pj|All Files (*.*)|*", 1) Then Exit Sub
 Disassembler.Caption = "R4300i Disassembler - " & MainMDI.FileDlg.FileTitle
 Open (CurrentROM) For Binary As #ROMhandle
 If LOF(ROMhandle) >= 52428800 Then
  TMPtype = 1
  Close #tmpHandle
  tmpHandle = FreeFile
  Open (App.path & "\renegade.tmp") For Binary As #tmpHandle
  Erase EditedAddys
 Else
  TMPtype = 0
  Erase EditedData
  Erase EditedAddys
 End If
 addy = 0
 Get #ROMhandle, 1, tmpbyte
  If tmpbyte = &H80 Then
  ROMendian = 2 'big endian
 ElseIf tmpbyte = &H37 Then
  ROMendian = 1 'byteswapped
 ElseIf tmpbyte = &H40 Then
  ROMendian = 0 'little endian
 Else
  dlgEndianSelect.Show vbModal
 End If
 ROMloaded = True
 cmdPrevPG.Enabled = False
 cmdNextPG.Enabled = True
 addy = 0
 cmbRegView.ListIndex = GetCFG("asmregfmt", 1, 1)
 ShowPage
End Sub
Private Sub ShowPage()
 Dim tmplong As Long
 Dim i As Long
 lstASM.Clear
 For i = 0 To PageSize
  If (addy + 1) > LOF(ROMhandle) Then Exit For '????
  If GetAddyFlag(addy) Then
   tmplong = GetData(addy)
  Else
   Get #ROMhandle, addy + 1, tmplong
   tmplong = FlipWord(tmplong, ROMendian)
  End If
  lstASM.AddItem String(8 - Len(Hex(addy)), "0") & Hex(addy) & Space(2) & _
                 String(8 - Len(Hex(tmplong)), "0") & Hex(tmplong) & Space(2) & _
                 Disassemble(addy, tmplong)
  addy = addy + 4
 Next
End Sub
Private Sub cmdNextPG_Click()
 cmdPrevPG.Enabled = True
 ShowPage
End Sub
Private Sub cmdPrevPG_Click()
 addy = addy - ((PageSize + 1) * 8)
 If addy <= 0 Then
  addy = 0
  cmdPrevPG.Enabled = False
 End If
 ShowPage
End Sub
Private Sub lstASM_KeyDown(keycode As Integer, shift As Integer)
'MsgBox keycode & "," & shift, vbOKOnly
 If (keycode = 40) And (shift = 2) Then 'CTRL + Down
  cmdNextPG_Click
 ElseIf (keycode = 40) And (lstASM.ListIndex = 32) Then 'Down
  ScrollDown
 ElseIf (keycode = 38) And (shift = 2) Then 'CTRL + Up
  cmdPrevPG_Click
 ElseIf (keycode = 38) And (lstASM.ListIndex = 0) Then 'Up
  ScrollUp
 ElseIf ((keycode = 13) Or (keycode = 114)) Then  'Enter or F3
  If ROMloaded = True Then mnuEditASM
 ElseIf (keycode = 71) And (shift = 2) Then 'CTRL+G
  mnuGoToAddy
 ElseIf (keycode = 72) And (shift = 2) Then 'CTRL+H
  mnuViewROMHeader
 ElseIf (keycode = 67) And (shift = 2) Then 'CTRL+C
  mnuCopyLine
 ElseIf (keycode = 67) And (shift = 6) Then 'CTRL+Alt+C
  mnuCopyChanges
 ElseIf (keycode = 67) And (shift = 3) Then 'CTRL+Shift+C
  mnuCopyChangesGS
 ElseIf (keycode = 83) And (shift = 2) Then 'CTRL+S
  mnuSaveROM
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  mnuSaveROMas
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  mnuOpenROM
' ElseIf (keycode = 70) And (shift = 2) Then 'CTRL+F
'  mnuSearchROM
 ElseIf (keycode = 69) And (shift = 2) Then 'CTRL+E
  mnuSavetxtROM
 End If
End Sub
Private Sub ScrollDown()
 Dim tmplong As Long
 If (addy + 1) > LOF(ROMhandle) Then Exit Sub '????
 If GetAddyFlag(addy) Then
  tmplong = GetData(addy)
 Else
  Get #ROMhandle, addy + 1, tmplong
  tmplong = FlipWord(tmplong, ROMendian)
 End If
 lstASM.RemoveItem 0
 lstASM.AddItem String(8 - Len(Hex(addy)), "0") & Hex(addy) & Space(2) & _
                  String(8 - Len(Hex(tmplong)), "0") & Hex(tmplong) & Space(2) & _
                  Disassemble(addy, tmplong)
 addy = addy + 4
End Sub
Private Sub ScrollUp()
 Dim tmplong As Long
 Dim tmpaddy As Long
 tmpaddy = addy - ((PageSize + 2) * 4)
 If tmpaddy < 0 Then Exit Sub
 If GetAddyFlag(tmpaddy) Then
  tmplong = GetData(tmpaddy)
 Else
  Get #ROMhandle, tmpaddy + 1, tmplong
  tmplong = FlipWord(tmplong, ROMendian)
 End If
 If lstASM.ListCount = 33 Then lstASM.RemoveItem 32
 lstASM.AddItem String(8 - Len(Hex(tmpaddy)), "0") & Hex(tmpaddy) & Space(2) & _
                String(8 - Len(Hex(tmplong)), "0") & Hex(tmplong) & Space(2) & _
                Disassemble(tmpaddy, tmplong), 0
 addy = addy - 4
End Sub
Private Sub mnuSaveROM()
 If ROMEdited Then SaveChanges 1
End Sub
Private Sub mnuSaveROMas()
 If ROMloaded Then SaveChanges 2
End Sub
Private Sub mnuGoToAddy()
 If ROMloaded Then dlgGoToASM.Show vbModal
End Sub
Public Sub GoToPage(newaddy As Long)
 addy = newaddy
 ShowPage
End Sub
Private Sub mnuViewROMHeader()
 If ROMloaded Then dlgROMheader.Show vbModal
End Sub
Public Sub DirtyDis(ByVal FileStatus As Boolean)
 ROMEdited = FileStatus
End Sub
Private Sub mnuCopyLine()
  Clipboard.SetText lstASM.List(lstASM.ListIndex)
End Sub
Private Sub mnuCopyChanges()
 If ROMEdited Then SaveChanges 4
End Sub
Private Sub mnuCopyChangesGS()
 If ROMEdited Then SaveChanges 6
End Sub
Private Sub mnuCopyPage()
 If ROMloaded Then SavePage 0
End Sub
Private Sub mnuCopyPageGS()
 If ROMloaded Then SavePage 2
End Sub
Private Sub mnuSaveChangesTXT()
 If ROMEdited Then SaveChanges 3
End Sub
Private Sub mnuSaveChangesGS()
 If ROMEdited Then SaveChanges 5
End Sub
Private Sub mnuSavePageTXT()
 If ROMloaded Then SavePage 1
End Sub
Private Sub mnuSavePageGS()
 If ROMloaded Then SavePage 3
End Sub
Private Sub SaveChanges(ByVal save As Byte)
 Dim i As Long
 Dim e As Long
 Dim tmpaddy As Long, tmpvalue As Long
 Dim tmpstring As String
 Dim errnumber As Long
 Dim temphandle
 temphandle = FreeFile
 If save = 2 Then
  If Not ChooseFile(tmpstring, "N64 ROMs (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur|All Files (*.*)|*", 0) Then Exit Sub
   errnumber = CopyFileBytes(CurrentROM, tmpstring, 0, 0, 0)
   If errnumber <> 0 Then
    ShowDLLError errnumber
    Exit Sub
   End If
  Open (tmpstring) For Binary Access Write As #temphandle
  CurrentROM = tmpstring
  Disassembler.Caption = "R4300i Disassembler - " & MainMDI.FileDlg.FileTitle
 ElseIf (save = 3) Or (save = 5) Then
  If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
  Open (tmpstring) For Output As #temphandle
 End If
 i = 0
 tmpstring = ""
 Do
    tmpaddy = i
    If GetAddyFlag(tmpaddy) Then
     tmpvalue = GetData(tmpaddy)
     Select Case save
      Case 1 'Save
       Put #ROMhandle, tmpaddy + 1, FlipWord(tmpvalue, ROMendian)
      Case 2 'Save As
       Put #temphandle, tmpaddy + 1, FlipWord(tmpvalue, ROMendian)
      Case 3 'Save TXT
       Print #temphandle, HexString(tmpaddy, 8) & Space(2) & HexString(tmpvalue, 8) & Space(2) & _
                    Disassemble(tmpaddy, tmpvalue)
      Case 4 'Copy TXT
       tmpstring = tmpstring & HexString(tmpaddy, 8) & Space(2) & HexString(tmpvalue, 8) & _
                   Space(2) & Disassemble(tmpaddy, tmpvalue) & vbCrLf
      Case 5 'Save GS
       If tmpvalue <> 0 Then
        Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                           "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4)
       Else
        Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & "2400"
       End If
      Case 6 'Copy GS
       If tmpvalue <> 0 Then
        tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                                "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4) & vbCrLf
       Else
        tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & "2400" & vbCrLf
       End If
     End Select
    End If
  If (EditedAddys(i \ 32) = 0) And save <> 2 Then
   i = i + (32 - (i Mod 32))
  Else
   i = i + 4
  End If
 Loop While i < LOF(ROMhandle)
 If (save = 2) Or (save = 3) Or (save = 5) Then Close #temphandle
 If save <= 2 Then
  DirtyDis False
  Erase EditedAddys
 End If
 If (save = 4) Or (save = 6) Then
  Clipboard.Clear
  Clipboard.SetText tmpstring
 End If
End Sub
Private Sub mnuSavetxtROM()
 If Not ROMloaded Then Exit Sub
 Dim i As Integer
 If Right(Disassembler.Caption, 1) = "*" Then
  i = MsgBox("Save file before exporting?", vbYesNo)
  If i = vbYes Then mnuSaveROM
 End If
 dlgExportDis.Show vbModal
End Sub
Public Sub ExportDis(ByVal OutFile As String, ByVal GPRtype As Byte, ByVal AlignOpt As Byte, ByVal AddysOpt As Byte, ByVal RangeLO As Long, ByVal RangeHi As Long)
 Dim errnumber As Long
 If (RangeLO >= RangeHi) Or (RangeHi > LOF(ROMhandle)) Then RangeHi = 0
 errnumber = WriteDis(CurrentROM, OutFile, ROMendian, GPRtype, AddysOpt, AlignOpt, RangeLO, RangeHi)
 If errnumber <> 0 Then ShowDLLError errnumber
End Sub
Private Sub SavePage(ByVal save As Byte)
 Dim i As Integer
 Dim tmpstring As String
 Dim tmpaddy As Long, tmpvalue As Long
 Dim temphandle
 tmpaddy = addy - ((PageSize + 1) * 4)
 If tmpaddy < 0 Then tmpaddy = 0
 If (save = 1) Or (save = 3) Then
  temphandle = FreeFile
  If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
  Open (tmpstring) For Output As #temphandle
 End If
 tmpstring = ""
 For i = 0 To PageSize
  If GetAddyFlag(tmpaddy) Then
   tmpvalue = GetData(tmpaddy)
  Else
   Get #ROMhandle, tmpaddy + 1, tmpvalue
   tmpvalue = FlipWord(tmpvalue, ROMendian)
  End If
  Select Case save
   Case 0 'copy page
    tmpstring = tmpstring & lstASM.List(i) & vbCrLf
   Case 1 'save page txt
    Print #temphandle, lstASM.List(i)
   Case 2 'copy page GS
    If tmpvalue <> 0 Then
     tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                             "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4) & vbCrLf
    Else
     tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & "2400" & vbCrLf
    End If
   Case 3 'save page GS
    If tmpvalue <> 0 Then
     Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                        "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4)
    Else
     Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & "2400"
    End If
  End Select
  tmpaddy = tmpaddy + 4
 Next
 If (save = 1) Or (save = 3) Then
  Close #temphandle
 Else
  Clipboard.SetText tmpstring
 End If
End Sub
Private Sub cmbRegView_Click()
 WriteCFG "asmregfmt", cmbRegView.ListIndex
 Select Case cmbRegView.ListIndex
  Case 0: Exit Sub
  Case 1: GPRnames = Split(LCase(GPRNameList1), ",")
  Case 2: GPRnames = Split(GPRNameList1, ",")
  Case 3: GPRnames = Split(GPRNameList2, ",")
  Case 4: GPRnames = Split(GPRNameList3, ",")
 End Select
 cmbRegView.ListIndex = 0
 If Not ROMloaded Then Exit Sub
 addy = addy - ((PageSize + 1) * 4)
 If addy < 0 Then addy = 0
 ShowPage
End Sub
Private Sub mnuEditASM()
 If lstASM.List(lstASM.ListIndex) <> "" Then
  dlgEditASM.Show vbModal
 Else
  MsgBox "Select a line to edit first, jack off.", vbOKOnly
 End If
End Sub
Private Sub cmbSetEndian_Click()
 If cmbSetEndian.ListIndex = 0 Then Exit Sub
 ROMendian = cmbSetEndian.ListIndex - 1
 cmbSetEndian.ListIndex = 0
 If Not ROMloaded Then Exit Sub
 addy = addy - ((PageSize + 1) * 4)
 If addy < 0 Then addy = 0
 ShowPage
End Sub
Public Sub RefreshPage()
 addy = addy - ((PageSize + 1) * 4)
 If addy < 0 Then addy = 0
 ShowPage
End Sub
Private Sub mnuClearChanges()
 Erase EditedAddys
 DirtyDis False
 RefreshPage
End Sub
Private Sub cmbFileMenu_Click()
 Select Case cmbFileMenu.ListIndex
  Case 0: Exit Sub
  Case 1: mnuOpenROM
  Case 2: mnuSaveROMas
  Case 3: mnuSaveChangesTXT
  Case 4: mnuSaveChangesGS
  Case 5: mnuSavePageTXT
  Case 6: mnuSavePageGS
  Case 7: mnuSavetxtROM
  Case 8: mnuClearChanges
  Case 9: mnuViewROMHeader
  Case 10: Unload Disassembler
 End Select
 cmbFileMenu.ListIndex = 0
End Sub
Private Sub cmbEditMenu_Click()
 Select Case cmbEditMenu.ListIndex
  Case 0: Exit Sub
  Case 1: mnuEditASM
  Case 2: mnuCopyLine
  Case 3: mnuCopyChanges
  Case 4: mnuCopyChangesGS
  Case 5: mnuCopyPage
  Case 6: mnuCopyPageGS
  Case 7: mnuGoToAddy
 End Select
 cmbEditMenu.ListIndex = 0
End Sub

