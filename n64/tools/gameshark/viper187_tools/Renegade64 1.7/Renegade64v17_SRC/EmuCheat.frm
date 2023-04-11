VERSION 5.00
Begin VB.Form EmuCheat 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Trainer/Patcher"
   ClientHeight    =   9000
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.ComboBox cmbTrnSystem 
      Height          =   315
      ItemData        =   "EmuCheat.frx":0000
      Left            =   9480
      List            =   "EmuCheat.frx":0016
      TabIndex        =   28
      Text            =   "Combo1"
      Top             =   2040
      Width           =   975
   End
   Begin VB.CheckBox chkAutoSave 
      Caption         =   "Auto Save"
      Height          =   255
      Left            =   2520
      TabIndex        =   27
      Top             =   0
      Width           =   1695
   End
   Begin VB.ComboBox cmbFileMenu 
      Height          =   315
      ItemData        =   "EmuCheat.frx":0038
      Left            =   0
      List            =   "EmuCheat.frx":0048
      TabIndex        =   26
      Text            =   "Combo1"
      Top             =   0
      Width           =   2295
   End
   Begin VB.Frame frmPatch 
      Caption         =   "Patching Options"
      Height          =   975
      Left            =   6960
      TabIndex        =   20
      Top             =   120
      Width           =   3855
      Begin VB.ComboBox cmbEndian 
         Height          =   315
         ItemData        =   "EmuCheat.frx":007C
         Left            =   1440
         List            =   "EmuCheat.frx":008C
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   480
         Width           =   2175
      End
      Begin VB.CommandButton cmdPatch 
         Caption         =   "Patch File"
         Height          =   375
         Left            =   240
         TabIndex        =   21
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "Endian (Choose Before Patch!)"
         Height          =   255
         Left            =   1440
         TabIndex        =   25
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.Frame frmTrain 
      Caption         =   "Training Options (Must Be Attached To Process)"
      Height          =   1575
      Left            =   6960
      TabIndex        =   15
      Top             =   1320
      Width           =   3855
      Begin VB.CommandButton cmdActOnce 
         Caption         =   "Activate Once"
         Enabled         =   0   'False
         Height          =   495
         Left            =   1320
         TabIndex        =   18
         Top             =   360
         Width           =   855
      End
      Begin VB.CommandButton cmdActivateCC 
         Caption         =   "Activate Codes"
         Enabled         =   0   'False
         Height          =   495
         Left            =   360
         TabIndex        =   17
         Top             =   360
         Width           =   855
      End
      Begin VB.TextBox txtTrainRate 
         Height          =   285
         Left            =   2160
         TabIndex        =   16
         Top             =   1200
         Width           =   855
      End
      Begin VB.Label Label8 
         Caption         =   "System:"
         Height          =   255
         Left            =   2520
         TabIndex        =   29
         Top             =   480
         Width           =   975
      End
      Begin VB.Label Label5 
         Caption         =   "Write Speed (ms):"
         Height          =   255
         Left            =   840
         TabIndex        =   19
         Top             =   1200
         Width           =   1335
      End
   End
   Begin VB.Timer tmrTrain 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   11280
      Top             =   120
   End
   Begin VB.CommandButton cmdUnselectAllCC 
      Caption         =   "Unselect All"
      Height          =   375
      Left            =   5040
      TabIndex        =   14
      Top             =   8040
      Width           =   975
   End
   Begin VB.CommandButton cmdSelectAllCC 
      Caption         =   "Select All"
      Height          =   375
      Left            =   3000
      TabIndex        =   13
      Top             =   8040
      Width           =   975
   End
   Begin VB.CommandButton cmdClearCode 
      Caption         =   "Clear"
      Height          =   375
      Left            =   9840
      TabIndex        =   12
      Top             =   8160
      Width           =   735
   End
   Begin VB.CommandButton cmdAddGame 
      Caption         =   "Add"
      Height          =   285
      Left            =   2160
      TabIndex        =   11
      Top             =   8160
      Width           =   495
   End
   Begin VB.TextBox txtNewGame 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   480
      TabIndex        =   10
      Top             =   8160
      Width           =   1695
   End
   Begin VB.CommandButton cmdNewCode 
      Caption         =   "Set As New"
      Height          =   375
      Left            =   8400
      TabIndex        =   9
      Top             =   8160
      Width           =   1095
   End
   Begin VB.CommandButton cmdSetCode 
      Caption         =   "Set"
      Height          =   375
      Left            =   7200
      TabIndex        =   5
      Top             =   8160
      Width           =   855
   End
   Begin VB.TextBox txtNote 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   6960
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   4
      Top             =   6360
      Width           =   3855
   End
   Begin VB.TextBox txtCode 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   6960
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   3
      Top             =   4080
      Width           =   3855
   End
   Begin VB.TextBox txtCodeName 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   6960
      TabIndex        =   2
      Top             =   3360
      Width           =   3855
   End
   Begin VB.ListBox lstCodes 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7410
      ItemData        =   "EmuCheat.frx":00DB
      Left            =   3000
      List            =   "EmuCheat.frx":00DD
      Style           =   1  'Checkbox
      TabIndex        =   1
      Top             =   600
      Width           =   3015
   End
   Begin VB.ListBox lstGames 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7440
      ItemData        =   "EmuCheat.frx":00DF
      Left            =   480
      List            =   "EmuCheat.frx":00E1
      TabIndex        =   0
      Top             =   600
      Width           =   2175
   End
   Begin VB.Label Label6 
      Caption         =   "Codes"
      Height          =   255
      Left            =   3000
      TabIndex        =   23
      Top             =   420
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "Games"
      Height          =   255
      Left            =   480
      TabIndex        =   22
      Top             =   420
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "Code Name:"
      Height          =   255
      Left            =   6960
      TabIndex        =   8
      Top             =   3120
      Width           =   1335
   End
   Begin VB.Label Label2 
      Caption         =   "Codes:"
      Height          =   255
      Left            =   6960
      TabIndex        =   7
      Top             =   3840
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Notes:"
      Height          =   255
      Left            =   6960
      TabIndex        =   6
      Top             =   6120
      Width           =   1095
   End
End
Attribute VB_Name = "EmuCheat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Renegade / Renegade 64 (VB6+C Combo App)
'
'Copyright notice for this file:
'Copyright (C) 2006 Viper187 / Psycho Snake Creations
'
'This program is free software: you can redistribute it and/or modify
'it under the terms of the GNU General Public License as published by
'the Free Software Foundation, either version 2 of the License, or
'(at your option) any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU General Public License for more details.
'
'You should have received a copy of the GNU General Public License
'along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit
Dim codes(0 To 255, 0 To 1000, 0 To 2) As String
Dim EditedCC As Boolean
Dim ActiveCC As Integer
Dim pHandle As Long
Dim ccfile As String
Dim TrnEndian As Byte
Private Sub Form_Load()
 OpenTools(7) = True
 txtTrainRate.text = GetCFG("emucheat_refresh", 1, 100)
 tmrTrain.Interval = txtTrainRate.text
 cmbFileMenu.ListIndex = 0
 If EmuId(0) = -1 Then MainMDI.mnuEmuAttach_Click
 EmuVarsTrn
 cmbTrnSystem.ListIndex = 0
End Sub
Private Sub Form_Unload(cancel As Integer)
 Dim i As Integer
 If EditedCC Then
  i = MsgBox("Save file before closing?", vbYesNoCancel)
  If i = vbYes Then
   mnuSaveCC
  ElseIf i = vbCancel Then
   cancel = 1
  End If
 End If
 If cancel <> 1 Then OpenTools(7) = False
End Sub
Private Sub LoadCodes(ByVal codefile As String)
 Dim TEXThandle As Integer, gamecount As Integer, cc As Integer
 Dim tmpline As String
 Erase codes
 TEXThandle = FreeFile
 lstGames.Clear
 lstCodes.Clear
 gamecount = -1
 If Not Exists(codefile, 1) Then Exit Sub
 Open (codefile) For Input As #TEXThandle
 Line Input #TEXThandle, tmpline
 Do
  If Left(tmpline, 1) = "#" Then
   lstGames.AddItem Mid(tmpline, 2)
   gamecount = gamecount + 1
   cc = 0
  End If
  If Left(tmpline, 1) = Chr(34) Then
   codes(gamecount, cc, 0) = Mid(tmpline, 2)
   Do
    Line Input #TEXThandle, tmpline
    'ishex the line or allow digits input?
'    If IsHex(Left(tmpline, 2)) Then
    If FilterHexValues(Replace(tmpline, " ", "")) <> "0" Then
     If codes(gamecount, cc, 1) <> "" Then codes(gamecount, cc, 1) = codes(gamecount, cc, 1) & ","
     codes(gamecount, cc, 1) = codes(gamecount, cc, 1) & tmpline
    ElseIf Left(tmpline, 1) = "*" Then
     codes(gamecount, cc, 2) = codes(gamecount, cc, 2) & tmpline
    End If
    If (Left(tmpline, 1) = Chr(34)) Or (Left(tmpline, 1) = "#") Then Exit Do
   Loop Until EOF(TEXThandle)
   cc = cc + 1
  Else: Line Input #TEXThandle, tmpline
  End If
 Loop Until EOF(TEXThandle)
 Close #TEXThandle
 EditedCC = False
 chkAutoSave = GetCFG("emucheat_autosave", 1, 0)
End Sub
Private Sub mnuLoadCC()
 If ChooseFile(ccfile, "Cheat Files (*.ini)|*.ini|All Files (*.*)|*", 1) Then LoadCodes ccfile
End Sub
Private Sub lstGames_Click()
 Dim i As Integer, game As Integer
 lstCodes.Clear
 game = lstGames.ListIndex
 For i = 0 To UBound(codes, 2)
  If codes(game, i, 0) <> "" Then
   lstCodes.AddItem codes(game, i, 0)
  Else: Exit For
  End If
 Next
End Sub
Private Sub lstCodes_Click()
 Dim i As Integer
 txtCodeName.text = codes(lstGames.ListIndex, lstCodes.ListIndex, 0)
 txtCode.text = Replace(codes(lstGames.ListIndex, lstCodes.ListIndex, 1), ",", vbCrLf)
 txtNote.text = Mid(codes(lstGames.ListIndex, lstCodes.ListIndex, 2), 2)
 If tmrTrain.Enabled Then
  ActiveCC = 0
  For i = 0 To lstCodes.ListCount - 1
   If lstCodes.Selected(i) Then ActiveCC = ActiveCC + 1
  Next
 End If
End Sub
Private Sub cmdSetCode_Click()
 If ChkCode(txtCode.text) Or (txtCodeName.text = "") Or (txtCode.text = "") Then
  MsgBox "Bad Input", vbOKOnly, "Error"
  Exit Sub
 End If
 If (lstGames.ListIndex = -1) Or (lstCodes.ListIndex = -1) Then
  MsgBox "Choose a Game.", vbOKOnly, "Error"
  Exit Sub
 End If
 codes(lstGames.ListIndex, lstCodes.ListIndex, 0) = txtCodeName.text
 codes(lstGames.ListIndex, lstCodes.ListIndex, 1) = Replace(Trim(txtCode.text), vbCrLf, ",")
 If txtNote.text <> "" Then
  codes(lstGames.ListIndex, lstCodes.ListIndex, 2) = "*" & txtNote.text
 Else: codes(lstGames.ListIndex, lstCodes.ListIndex, 2) = ""
 End If
 EditedCC = True
 If chkAutoSave.value And (ccfile <> "") Then SaveCodes ccfile
End Sub
Private Sub cmdNewCode_Click()
 If ChkCode(txtCode.text) Or (txtCodeName.text = "") Or (txtCode.text = "") Then
  MsgBox "Bad Input", vbOKOnly, "Error"
  Exit Sub
 End If
 If lstGames.ListIndex = -1 Then
  MsgBox "Choose a Game.", vbOKOnly, "Error"
  Exit Sub
 End If
 codes(lstGames.ListIndex, lstCodes.ListCount, 0) = txtCodeName.text
 codes(lstGames.ListIndex, lstCodes.ListCount, 1) = Replace(Trim(txtCode.text), vbCrLf, ",")
 If txtNote.text <> "" Then
  codes(lstGames.ListIndex, lstCodes.ListIndex, 2) = "*" & txtNote.text
 Else: codes(lstGames.ListIndex, lstCodes.ListCount, 2) = ""
 End If
 lstCodes.AddItem txtCodeName.text
 lstCodes.ListIndex = lstCodes.ListCount - 1
 EditedCC = True
 If chkAutoSave.value And (ccfile <> "") Then SaveCodes ccfile
End Sub
Private Sub cmdAddGame_Click()
 lstGames.AddItem txtNewGame.text
 lstGames.ListIndex = lstGames.ListCount - 1
End Sub
Private Sub cmdClearCode_Click()
 txtCodeName.text = ""
 txtCode.text = ""
 txtNote.text = ""
End Sub
Private Function ChkCode(ByVal code As String) As Boolean
 ChkCode = False
 code = Replace(Replace(code, vbCrLf, ""), " ", "")
 Do
  If Len(code) > 16 Then
   If IsHex(Left(code, 8)) = False Then ChkCode = True
   code = Mid(code, 9)
  Else
   If FilterHexValues(code) = "0" Then ChkCode = True
   If (Len(code) <> 12) And (Len(code) <> 16) Then ChkCode = True
   code = ""
  End If
 Loop While code <> ""
End Function
Public Sub EmuVarsTrn()
' dlgEmuAttach.Show
 If EmuId(0) <> -1 Then
  cmdActivateCC.Enabled = True
  cmdActOnce.Enabled = True
 Else
  cmdActivateCC.Enabled = False
  cmdActOnce.Enabled = False
 End If
End Sub
Private Sub cmdSelectAllCC_Click()
 Dim i As Integer
 For i = 0 To lstCodes.ListCount - 1
  lstCodes.Selected(i) = True
 Next
End Sub
Private Sub cmdUnSelectAllCC_Click()
 Dim i As Integer
 For i = 0 To lstCodes.ListCount - 1
  lstCodes.Selected(i) = False
 Next
End Sub
Private Sub lstCodes_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 17) And (shift = 2) Then 'CTRL+S
  cmdSelectAllCC_Click
 End If
End Sub
Private Sub tmrTrain_Timer()
 Dim i As Integer
 Dim gscodes() As String
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) = -1 Then
  tmrTrain.Enabled = False
  cmdActivateCC.Enabled = False
  cmdActOnce.Enabled = False
  Exit Sub
 End If
 pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
 If pHandle = 0 Then
  MsgBox "OpenProcess failed"
  MainMDI.mnuEmuDetach_Click
  Exit Sub
 End If
 For i = 0 To UBound(codes, 2)
  Erase gscodes
  If codes(lstGames.ListIndex, i, 0) = "" Then Exit For
  If lstCodes.Selected(i) = False Then GoTo loopnext
  If InStr(codes(lstGames.ListIndex, i, 1), ",") Then
   gscodes = Split(Replace(codes(lstGames.ListIndex, i, 1), " ", ""), ",")
  Else
   ReDim gscodes(0)
   gscodes(0) = Replace(codes(lstGames.ListIndex, i, 1), " ", "")
  End If
  TrnEndian = IIf(EmuEndian(EmuId(1)) = 3, 2, EmuEndian(EmuId(1)))
  Select Case cmbTrnSystem.ListIndex
  Case 0 'N64
   CheatN64 gscodes(), i
  Case 1 ' PSX
   CheatPSX gscodes(), i
  Case 2 'DS
   CheatDS gscodes(), i
  Case 3 'PC
   CheatPC gscodes(), i
  Case 4 'NGPx
   CheatNGPx gscodes(), i
  Case 5 'PS2
   CheatPS2 gscodes(), i
  End Select
loopnext:
 Next
 CloseHandle pHandle
End Sub
Private Sub CheatN64(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Integer
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 2))
  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
   Case 0, 1, 2, 3, 4, 8, 9, &HA, &HB, &HC, &H10, &H11, &H12, &H13, &H14, _
        &H18, &H19, &H1A, &H1B, &H1C, &H20, &H21, &H22, &H23, &H24, &H28, _
        &H29, &H2A, &H2B, &H2C 'inc/dec/and/or/xor
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If Not BitModRAM(tmpcode, tmpvalue, GetSizeR(SRL(CT, 4)), CT And 7) Then lstCodes.Selected(ccnum) = False
    End If
   Case &H50 'patch code
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    inc = tmpcode And &HFF
    val = tmpvalue
    i = SRL(tmpcode, 8)
    tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
    tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
    For i = i - 1 To 0 Step -1
     tempcode(0) = Left(tmpcodes(c), 2) & HexString(tmpcode, 6) & Hex(tmpvalue)
     CheatN64 tempcode(), ccnum
     tmpcode = tmpcode + inc
     tmpvalue = tmpvalue + val
    Next
   Case &H60 'slide
    val = tmpvalue - 1
    For i = 0 To val
     If (c >= UBound(tmpcodes)) Then Exit For
     c = c + 1
     tmpvalue = CLng("&H" & Left(tmpcodes(c), 8))
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
     i = i + 1
     If i > val Then Exit For
     tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
    Next
   Case &H70, &H71, &H78, &H79 'pointer
    tmpcode = ReadRAM(tmpcode, 4)
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
'     If tmpcode <> -1 Then
     If (SRL(tmpcode, 24) = &H80) Or (SRL(tmpcode, 24) = &H70) Then
      If Not WriteRAM((tmpcode And &HFFFFFF) + SRL(tmpvalue, 16), tmpvalue And 65535, GetSize(CT And 1)) Then lstCodes.Selected(ccnum) = False
     End If
    End If
   Case &H80, &H81, &H82, &H88, &H89, &H8A, &HA0, &HA1, &HA2 'constant write
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If Not WriteRAM(tmpcode, tmpvalue, GetSize(CT And 3)) Then lstCodes.Selected(ccnum) = False
    End If
   Case &HC2 'copy bytes
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    val = tmpcode
    tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
    If Not CopyMem(val, tmpcode, tmpvalue) Then lstCodes.Selected(ccnum) = False
   Case &HD0, &HD1, &HD2, &HD3, &HE0, &HE1, &HE2, &HE3 'equal/not equal/greater/less
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    If (CT And &HE0) = &HE0 Then CT = CT Or 4
    If cmpRAM(tmpcode, tmpvalue, GetSize(CT And 1), (CT And &HF) \ 2) Then
     tempcode(0) = tmpcodes(c + 1)
     CheatN64 tempcode(), ccnum
    Else
     Do
      c = c + 1
      If (c >= UBound(tmpcodes)) Then GoTo nextcode
      CT = CByte("&H" & Left(tmpcodes(c), 2))
     Loop While ((CT And &HF0) = &HD0) Or ((CT And &HF0) = &HE0) _
                Or ((CT And &H50) = &H50) Or ((CT And &HC2) = &HC2)
    End If
  End Select
nextcode:
 Next
End Sub
Private Sub CheatPSX(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Integer
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 2))
  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
   Case 0, 1, 2, 3, 4, 8, 9, &HA, &HB, &HC, &H10, &H11, &H12, &H13, &H14, _
        &H18, &H19, &H1A, &H1B, &H1C, &H20, &H21, &H22, &H23, &H24, &H28, _
        &H29, &H2A, &H2B, &H2C 'inc/dec/and/or/xor
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If (CT = 0) Then tmpvalue = FlipWord(tmpvalue, 1)
     If Not BitModRAM(tmpcode, tmpvalue, GetSizeR(SRL(CT, 4)), CT And 7) Then lstCodes.Selected(ccnum) = False
    End If
   Case &H50 'patch code
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    inc = tmpcode And &HFF
    val = tmpvalue
    i = SRL(tmpcode, 8)
    tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
    tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
    For i = i - 1 To 0 Step -1
     tempcode(0) = Left(tmpcodes(c), 2) & HexString(tmpcode, 6) & Hex(tmpvalue)
     CheatPSX tempcode(), ccnum
     tmpcode = tmpcode + inc
     tmpvalue = tmpvalue + val
    Next
   Case &H60 'slide
    val = tmpvalue - 1
    For i = 0 To val
     If (c >= UBound(tmpcodes)) Then Exit For
     c = c + 1
     tmpvalue = FlipWord(CLng("&H" & Left(tmpcodes(c), 8)), 1)
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
     i = i + 1
     If i > val Then Exit For
     tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
    Next
   Case &H70, &H71, &H78, &H79 'pointer
    tmpcode = ReadRAM(tmpcode, 4)
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If (SRL(tmpcode, 24) = &H80) Or (SRL(tmpcode, 24) = &H70) Then
      If Not WriteRAM((tmpcode And &HFFFFFF) + SRL(tmpvalue, 16), tmpvalue And 65535, GetSize(CT And 1)) Then lstCodes.Selected(ccnum) = False
     End If
    End If
   Case &H30, &H80, &HA0, &H38, &H88, &HA8 'constant write
    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     CT = SRL(CT, 4)
     Select Case CT
      Case 3: CT = 0
      Case 8: CT = 1
      Case 10: CT = 2
     End Select
     If Not WriteRAM(tmpcode, tmpvalue, GetSize(CT And 3)) Then lstCodes.Selected(ccnum) = False
    End If
   Case &HC2 'copy bytes
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    val = tmpcode
    tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
    If Not CopyMem(val, tmpcode, tmpvalue) Then lstCodes.Selected(ccnum) = False
   Case &HD0, &HD1, &HD2, &HD3, &HE0, &HE1, &HE2, &HE3 'equal/not equal/greater/less
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    If cmpRAM(tmpcode, tmpvalue, IIf((CT And &HE0) = &HE0, 1, 2), (CT And &HF)) Then
     tempcode(0) = tmpcodes(c + 1)
     CheatPSX tempcode(), ccnum
    Else
     Do
      c = c + 1 'fix for multiple checks
      If (c >= UBound(tmpcodes)) Then GoTo nextcode
      CT = CByte("&H" & Left(tmpcodes(c), 2))
     Loop While ((CT And &HF0) = &HD0) Or ((CT And &HF0) = &HE0) _
                Or ((CT And &H50) = &H50) Or ((CT And &HC2) = &HC2)
    End If
  End Select
nextcode:
 Next
End Sub
Private Sub CheatDS(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Integer
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 2))
  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
   Case &HB2 'pointer
    'tmpcode = FlipWord(ReadRAM(tmpcode, 4), 2)
    tmpcode = ReadRAM(tmpcode, 4)
    c = c + 1
    CT = CByte("&H" & Left(tmpcodes(c), 1))
    inc = CLng("&H" & Mid(tmpcodes(c), 3, 6))
    tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
     If tmpcode <> 0 Then
      If Not WriteRAM((tmpcode And &HFFFFFF) + inc, tmpvalue, GetSizeR(SRL(CT, 4) And 3)) Then lstCodes.Selected(ccnum) = False
     End If
   Case &H2, &H12, &H22 'constant write
     If Not WriteRAM(tmpcode, tmpvalue, GetSizeR(SRL(CT, 4) And 3)) Then lstCodes.Selected(ccnum) = False
  End Select
nextcode:
 Next
End Sub
Private Sub CheatPS2(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Long
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 2, 7))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 1))
  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
'   Case 0, 1, 2, 3, 4, 8, 9, &HA, &HB, &HC, &H10, &H11, &H12, &H13, &H14, _
'        &H18, &H19, &H1A, &H1B, &H1C, &H20, &H21, &H22, &H23, &H24, &H28, _
'        &H29, &H2A, &H2B, &H2C 'inc/dec/and/or/xor
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
'     If (CT = 0) Then tmpvalue = FlipWord(tmpvalue, 1)
'     If Not BitModRAM(tmpcode, tmpvalue, GetSizeR(SRL(CT, 4)), CT And 7) Then lstCodes.Selected(ccnum) = False
'    End If
   Case &H4 'patch code
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    inc = tmpvalue And 65535
    i = SRL(tmpvalue, 16)
    tmpvalue = CLng("&H" & Mid(tmpcodes(c), 1, 8))
    val = CLng("&H" & Mid(tmpcodes(c), 9))
    For i = i - 1 To 0 Step -1
'     tempcode(0) = Left(tmpcodes(c), 2) & HexString(tmpcode, 6) & Hex(tmpvalue)
'     CheatPS2 tempcode(), ccnum
     If Not WriteRAM(tmpcode, tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
     tmpcode = tmpcode + (inc * 4)
     tmpvalue = tmpvalue + val
    Next
'   Case &H60 'slide
'    val = tmpvalue - 1
'    For i = 0 To val
'     If (c >= UBound(tmpcodes)) Then Exit For
'     c = c + 1
'     tmpvalue = FlipWord(CLng("&H" & Left(tmpcodes(c), 8)), 1)
'     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
'     i = i + 1
'     If i > val Then Exit For
'     tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
'     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
'    Next
'   Case &H6 'pointer
'    tmpcode = ReadRAM(tmpcode, 4)
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
'     If (SRL(tmpcode, 24) = &H80) Or (SRL(tmpcode, 24) = &H70) Then
'      If Not WriteRAM((tmpcode And &HFFFFFF) + SRL(tmpvalue, 16), tmpvalue And 65535, GetSize(CT And 1)) Then lstCodes.Selected(ccnum) = False
'     End If
'    End If
   Case 0, 1, 2 'constant write
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If Not WriteRAM(tmpcode, tmpvalue, GetSize(CT)) Then lstCodes.Selected(ccnum) = False
'    End If
'   Case &HC2 'copy bytes
'    If (c >= UBound(tmpcodes)) Then GoTo nextcode
'    c = c + 1
'    val = tmpcode
'    tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
'    If Not CopyMem(val, tmpcode, tmpvalue) Then lstCodes.Selected(ccnum) = False
   Case &HD 'equal/not equal/greater/less
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    val = SRL(tmpvalue, 20)
    tmpvalue = tmpvalue And 65535
    If cmpRAM(tmpcode, tmpvalue, 2, val) Then
     tempcode(0) = tmpcodes(c + 1)
     CheatPS2 tempcode(), ccnum
    Else
     Do
      c = c + 1 'fix for multiple checks
      If (c >= UBound(tmpcodes)) Then GoTo nextcode
      CT = CByte("&H" & Left(tmpcodes(c), 1))
     Loop While (CT = &HD) Or (CT = 4)
    End If
   Case &HE 'equal/not equal/greater/less multi skip
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    val = SRL(tmpvalue, 28)
    inc = SRL(tmpcode, 16) And &HFF
    i = tmpvalue And &H7FFFFFF
    tmpvalue = tmpcode And 65535
    CT = SRL(tmpcode, 24) And &HF
    tmpcode = i
    If cmpRAM(tmpcode, tmpvalue, IIf(CT = 0, 2, 1), val) Then
     For inc = inc - 1 To 0 Step -1
      c = c + 1
      If (c >= UBound(tmpcodes)) Then Exit For
      tempcode(0) = tmpcodes(c)
      CheatPS2 tempcode(), ccnum
     Next
    Else
     c = c + inc
'     Do
'      c = c + 1 'fix for multiple checks
'      If (c >= UBound(tmpcodes)) Then GoTo nextcode
'      CT = CByte("&H" & Left(tmpcodes(c), 1))
'     Loop While (CT = &HD) Or (CT = 4)
    End If
  End Select
nextcode:
 Next
End Sub

Private Sub CheatPC(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Integer
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 2, 7))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 1))
'  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
   Case 3 'inc/dec/and/or/xor
    CT = SRL(tmpcode, 16)
    Select Case CT
     Case &H10 '8-bit inc
      CT = 0
     Case &H20 '8-bit dec
      CT = 1
     Case &H30 '16-bit inc
      CT = &H10
     Case &H40 '16-bit dec
      CT = &H11
     Case &H50 '32-bit inc
      CT = &H20
     Case &H60 '32-bit dec
      CT = &H21
     Case &H70 '8-bit and
      CT = &H2
     Case &H71 '8-bit or
      CT = &H3
     Case &H72 '8-bit xor
      CT = &H4
     Case &H80 '16-bit and
      CT = &H12
     Case &H81 '16-bit or
      CT = &H13
     Case &H82 '16-bit xor
      CT = &H14
     Case &H90 '32-bit and
      CT = &H22
     Case &H91 '32-bit or
      CT = &H23
     Case &H92 '32-bit xor
      CT = &H24
    End Select
    val = tmpcode And 65535
    tmpcode = tmpvalue
    tmpvalue = val
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
     If Not BitModRAM(tmpcode, tmpvalue, GetSize(SRL(CT, 4)), CT And 7) Then lstCodes.Selected(ccnum) = False
'    End If
   Case 4 'patch code
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    inc = (tmpvalue And 65535) * 4
    i = SRL(tmpvalue, 16)
    tmpvalue = CLng("&H" & Mid(tmpcodes(c), 1, 8))
    val = CLng("&H" & Mid(tmpcodes(c), 9))
    For i = i - 1 To 0 Step -1
     tempcode(0) = "2" & HexString(tmpcode, 7) & Hex(tmpvalue)
     CheatN64 tempcode(), ccnum
     tmpcode = tmpcode + inc
     tmpvalue = tmpvalue + val
    Next
   Case 6 'slide
    val = tmpvalue - 1
    For i = 0 To val
     If (c >= UBound(tmpcodes)) Then Exit For
     c = c + 1
     tmpvalue = CLng("&H" & Left(tmpcodes(c), 8))
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
     i = i + 1
     If i > val Then Exit For
     tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
     If Not WriteRAM(tmpcode + (i * 4), tmpvalue, 4) Then lstCodes.Selected(ccnum) = False
    Next
   Case 7 'pointer
    tmpcode = ReadRAM(tmpcode, 4) And &HFFFFFFF
    CT = GetSize(SRL(tmpvalue, 28))
    val = SRL(tmpvalue, 24) And 7
    inc = tmpvalue And &HFFFFFF '16777215
    c = c + 1
    tmpvalue = CLng("&H" & Left(tmpcodes(c), 8)) And SRL(&HFFFFFFFF, ((4 - CT) * 8))
    If (tmpcode = 0) Or (tmpcode = -1) Then GoTo nextcode
    If val = 0 Then
     If Not WriteRAM(tmpcode + inc, tmpvalue, CT) Then lstCodes.Selected(ccnum) = False
    Else
     If Not BitModRAM(tmpcode + inc, tmpvalue, CT, val - 1) Then lstCodes.Selected(ccnum) = False
    End If
'    End If
   Case 0, 1, 2 'constant write
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
    If Not WriteRAM(tmpcode, tmpvalue, GetSize(CT)) Then lstCodes.Selected(ccnum) = False
'    End If
   Case 5 'copy bytes
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    c = c + 1
    val = tmpcode
    tmpcode = CLng("&H" & Mid(tmpcodes(c), 2, 7))
    If Not CopyMem(val, tmpcode, tmpvalue) Then lstCodes.Selected(ccnum) = False
   Case &HD 'equal/not equal/greater/less Daaaaaaa XXXXYYYY
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    val = SRL(tmpvalue, 20) And 7
    inc = SRL(tmpvalue, 16) And 7
    CT = SRL(tmpvalue, 24) And 7
    tmpvalue = tmpvalue And 65535
    Select Case CT
     Case 0: CT = 2
     Case 1: CT = 1
 '    Case 2: CT = 4
    End Select
    If cmpRAM(tmpcode, tmpvalue, CT, val) Or (cmpRAM(tmpcode, tmpvalue, CT, 0) And (inc = 1)) Then
     tempcode(0) = tmpcodes(c + 1)
     CheatPC tempcode(), ccnum
    Else
     Do
      c = c + 1
      If (c >= UBound(tmpcodes)) Then GoTo nextcode
      CT = CByte("&H" & Left(tmpcodes(c), 1))
     Loop While (CT = &HD) Or (CT = &HE) Or (CT = 5) Or (CT = 4) Or (CT = 6) Or (CT = 7) Or (CT = 9)
    End If
   Case &H9 'keyboard activator 90000000 000000??
    If (c >= UBound(tmpcodes)) Then GoTo nextcode
    val = GetAsyncKeyState(tmpvalue) And 32768
    If val = 32768 Then
     tempcode(0) = tmpcodes(c + 1)
     CheatPC tempcode(), ccnum
    Else
     Do
      c = c + 1
      If (c >= UBound(tmpcodes)) Then GoTo nextcode
      CT = CByte("&H" & Left(tmpcodes(c), 1))
     Loop While (CT = &HD) Or (CT = &HE) Or (CT = 5) Or (CT = 4) Or (CT = 6) Or (CT = 7) Or (CT = 9)
    End If
  End Select
nextcode:
 Next
End Sub
Private Sub CheatNGPx(ByRef tmpcodes() As String, ByVal ccnum As Integer)
 Dim c As Integer, i As Integer
 Dim tmpcode As Long, tmpvalue As Long, inc As Long, val As Long
 Dim tempcode(0) As String
 Dim CT As Byte
 For c = 0 To UBound(tmpcodes)
  If Len(tmpcodes(c)) < 12 Then GoTo nextcode
  tmpcode = CLng("&H" & Mid(tmpcodes(c), 2, 7))
  tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
  CT = CByte("&H" & Left(tmpcodes(c), 1))
'  val = GetAsyncKeyState(&HC0) And 32768
  Select Case CT
   Case 0, 1, 2 'constant write
'    If ((CT And 8) = 0) Or ((CT And 8) And (val = 32768)) Then
    If Not WriteRAM(tmpcode, tmpvalue, GetSize(CT)) Then lstCodes.Selected(ccnum) = False
'    End If
  End Select
nextcode:
 Next
End Sub
Private Function WriteRAM(ByVal addy As Long, ByVal value As Long, ByVal size As Long) As Boolean
 Dim bah As Long
 Dim err As Long
 WriteRAM = True
 addy = FlipAddy(addy, size, TrnEndian)
 If WriteProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + addy), value, size, bah) = 0 Then
  MsgBox "Write failed: " & Hex(FlipAddy(addy, size, TrnEndian)) & ":" & Hex(value), vbOKOnly, "Error"
  WriteRAM = False
 End If
End Function
Private Function ReadRAM(ByVal addy As Long, ByVal size As Long) As Long
 Dim bah As Long
 addy = FlipAddy(addy, size, TrnEndian)
 If ReadProcessMemory(pHandle, EmuOffsets(EmuId(1)) + addy, ReadRAM, size, bah) = 0 Then
  MsgBox "Read failed: " & Hex(FlipAddy(addy, size, TrnEndian)), vbOKOnly, "error"
  ReadRAM = -1
  Exit Function
 End If
' ReadRAM = tmpval
End Function
Private Function cmpRAM(ByVal addy As Long, ByVal value As Long, ByVal size As Long, ByVal cmptype As Integer) As Boolean
 Dim tmpval As Long, bah As Long
 addy = FlipAddy(addy, size, TrnEndian)
 cmpRAM = False
 If ReadProcessMemory(pHandle, EmuOffsets(EmuId(1)) + addy, tmpval, size, bah) = 0 Then
'  MsgBox "Read failed: " & Hex(addy), vbOKOnly, "error"
  Exit Function
 End If
 Select Case cmptype
  Case 0 'equal
   If tmpval = value Then cmpRAM = True
  Case 1 'not equal
   If tmpval <> value Then cmpRAM = True
  Case 2 'less than
   If tmpval < value Then cmpRAM = True
  Case 3 'greater than
   If tmpval > value Then cmpRAM = True
 End Select
End Function
Private Function CopyMem(ByVal start As Long, ByVal target, ByVal count As Long) As Boolean
 Dim addy As Long, tmpval As Long, bah As Long, offset As Long
 CopyMem = True
 For offset = 0 To count - 1
  addy = FlipAddy(start + offset, 1, TrnEndian)
  If ReadProcessMemory(pHandle, EmuOffsets(EmuId(1)) + addy, tmpval, 1, bah) = 0 Then
   MsgBox "Copy Bytes - read failed: " & Hex(FlipAddy(addy, 1, TrnEndian)), vbOKOnly, "error"
   CopyMem = False
   Exit Function
  End If
  If Not WriteRAM(target + offset, tmpval, 1) Then
   CopyMem = False
   Exit Function
  End If
 Next
End Function
Private Function BitModRAM(ByVal addy As Long, ByVal value As Long, ByVal size As Long, ByVal optype As Integer) As Boolean
 Dim tmpval As Long, bah As Long
 addy = FlipAddy(addy, size, TrnEndian)
 BitModRAM = False
 If ReadProcessMemory(pHandle, EmuOffsets(EmuId(1)) + addy, tmpval, size, bah) = 0 Then
  MsgBox "Read failed: " & Hex(FlipAddy(addy, size, TrnEndian)), vbOKOnly, "error"
  Exit Function
 End If
 Select Case optype
  Case 0 'inc
   tmpval = tmpval + value
  Case 1 'dec
   tmpval = tmpval - value
  Case 2 'and
   tmpval = tmpval And value
  Case 3 'or
   tmpval = tmpval Or value
  Case 4 'xor
   tmpval = tmpval Xor value
 End Select
 If WriteProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + addy), tmpval, size, bah) = 0 Then
  MsgBox "Write failed: " & Hex(FlipAddy(addy, size, TrnEndian)) & ":" & Hex(value), vbOKOnly, "Error"
  Exit Function
 End If
 BitModRAM = True
End Function
Private Sub cmdActivateCC_Click()
 If lstGames.ListIndex = -1 Then
  MsgBox "Choose a Game.", vbOKOnly, "Error"
  Exit Sub
 End If
 If tmrTrain.Enabled Then
  tmrTrain.Enabled = False
  cmdActivateCC.Caption = "Activate Codes"
 Else
  tmrTrain.Enabled = True
  cmdActivateCC.Caption = "Deactivate Codes"
 End If
End Sub
Private Sub cmdActOnce_Click()
 If lstGames.ListIndex = -1 Then
  MsgBox "Choose a Game.", vbOKOnly, "Error"
  Exit Sub
 End If
 tmrTrain_Timer
End Sub
Private Sub txtTrainRefresh_KeyPress(PressedKey As Integer)
 If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
End Sub
Private Sub txtTrainRate_Change()
 If Not IsNumeric(txtTrainRate.text) Then txtTrainRate.text = "100"
 WriteCFG "emucheat_refresh", txtTrainRate.text
 tmrTrain.Interval = txtTrainRate.text
End Sub
Private Sub cmdPatch_Click()
 Dim tmpbyte As Byte, rEndian
 Dim i As Integer, c As Integer, rHandle As Integer, tmpint As Integer
 Dim code As String, tmpcodes() As String
 Dim tmpcode As Long, tmpvalue As Long, tmpword As Long
 rHandle = FreeFile
 If lstCodes.SelCount = 0 Then Exit Sub
 If cmbEndian.ListIndex = -1 Then
  MsgBox "Set endian, dumbshit.", vbOKOnly, "Error"
  Exit Sub
 End If
 If Not ChooseFile(code, "N64 ROMs (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur|All Files (*.*)|*", 1) Then Exit Sub
 Open (code) For Binary As #rHandle
 If cmbEndian.ListIndex = 3 Then
  Get #rHandle, 1, tmpbyte
  If tmpbyte = &H80 Then
   rEndian = 2 'big endian
  ElseIf tmpbyte = &H37 Then
   rEndian = 1 'byteswapped
  ElseIf tmpbyte = &H40 Then
   rEndian = 0 'little endian
  Else
   MsgBox "Couldn't automaticly determine endian. Please select one.", vbOKOnly, "Error"
   Exit Sub
  End If
 End If
 For i = 0 To UBound(codes, 2)
  Erase tmpcodes
  If codes(lstGames.ListIndex, i, 0) = "" Then Exit For
  If lstCodes.Selected(i) = False Then GoTo patchnext
  If InStr(codes(lstGames.ListIndex, i, 1), ",") Then
   tmpcodes = Split(Replace(codes(lstGames.ListIndex, i, 1), " ", ""), ",")
  Else
   ReDim tmpcodes(0)
   tmpcodes(0) = Replace(codes(lstGames.ListIndex, i, 1), " ", "")
  End If
  For c = 0 To UBound(tmpcodes)
  code = Mid(tmpcodes(c), 9)
   tmpcode = CLng("&H" & Mid(tmpcodes(c), 3, 6))
   tmpvalue = CLng("&H" & Mid(tmpcodes(c), 9))
   Select Case Left(tmpcodes(c), 2)
    Case "00" '8-bit write
     Put #rHandle, FlipAddy(tmpcode, 1, rEndian) + 1, CByte(tmpvalue)
    Case "10" '16-bit write
     Put #rHandle, FlipAddy(tmpcode, 2, rEndian) + 1, CInt(FlipShort(tmpvalue, rEndian))
    Case "20" '32-bit write
     Put #rHandle, tmpcode + 1, FlipWord(tmpvalue, rEndian)
    Case "D0" '16 bit equal
     Get #rHandle, FlipAddy(tmpcode, 2, rEndian) + 1, tmpint
     tmpvalue = FlipShort(tmpvalue, rEndian)
     If tmpint <> tmpvalue Then c = c + 1
    Case "D1" '32 bit equal
     Get #rHandle, tmpcode + 1, tmpword
     tmpvalue = FlipWord(tmpvalue, rEndian)
     If tmpint <> tmpvalue Then c = c + 1
   End Select
  Next
patchnext:
 Next
 
 Close #rHandle
End Sub
Private Sub mnuSaveCC()
 If ccfile = "" Then
  mnuSaveAsCC
 Else
  SaveCodes ccfile
 End If
End Sub
Private Sub mnuSaveAsCC()
 Dim tmpfile As String
 If ChooseFile(tmpfile, "Cheat Files (*.ini)|*.ini|All Files (*.*)|*", 0) Then
  ccfile = tmpfile
  SaveCodes ccfile
 End If
End Sub
Private Sub SaveCodes(ByVal codefile As String)
 Dim g As Integer, cc As Integer, ccHandle As Integer
 If codefile = "" Then Exit Sub
 ccHandle = FreeFile
 Open codefile For Output As #ccHandle
 For g = 0 To UBound(codes, 1)
  If codes(g, 0, 0) = "" Then Exit For
  Print #ccHandle, "#" & lstGames.List(g)
  For cc = 0 To UBound(codes, 2)
   If codes(g, cc, 0) = "" Then Exit For
   Print #ccHandle, Chr(34) & codes(g, cc, 0)
   Print #ccHandle, Replace(codes(g, cc, 1), ",", vbCrLf)
   If codes(g, cc, 2) <> "" Then Print #ccHandle, codes(g, cc, 2)
  Next
 Next
 Close #ccHandle
 EditedCC = False
End Sub
Private Sub chkAutoSave_Click()
 WriteCFG "emucheat_autosave", chkAutoSave.value
End Sub
Private Sub cmbFileMenu_Click()
 Select Case cmbFileMenu.ListIndex
  Case 1: mnuLoadCC
  Case 2: mnuSaveCC
  Case 3: mnuSaveAsCC
 End Select
End Sub
Private Function GetSize(ByVal cType As Byte) As Byte
 Select Case cType
  Case 0: GetSize = 1
  Case 1: GetSize = 2
  Case 2: GetSize = 4
 End Select
End Function
Private Function GetSizeR(ByVal cType As Byte) As Byte
 Select Case cType
  Case 0: GetSizeR = 4
  Case 1: GetSizeR = 2
  Case 2: GetSizeR = 1
 End Select
End Function

