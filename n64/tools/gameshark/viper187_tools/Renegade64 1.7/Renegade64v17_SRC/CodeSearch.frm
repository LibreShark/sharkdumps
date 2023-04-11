VERSION 5.00
Begin VB.Form CodeSearch 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Search"
   ClientHeight    =   9000
   ClientLeft      =   150
   ClientTop       =   240
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.Frame frmRange 
      Caption         =   "Search Area"
      Height          =   1215
      Left            =   6360
      TabIndex        =   34
      Top             =   1680
      Width           =   2895
      Begin VB.OptionButton optRangeAll 
         Caption         =   "All"
         Height          =   255
         Left            =   1560
         TabIndex        =   38
         Top             =   360
         Value           =   -1  'True
         Width           =   855
      End
      Begin VB.OptionButton optRangeSpec 
         Caption         =   "Specify"
         Height          =   255
         Left            =   480
         TabIndex        =   37
         Top             =   360
         Width           =   975
      End
      Begin VB.TextBox txtRangeHi 
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
         Left            =   1560
         MaxLength       =   8
         TabIndex        =   36
         Top             =   720
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.TextBox txtRangeLo 
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
         Left            =   120
         MaxLength       =   8
         TabIndex        =   35
         Top             =   720
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.Label lblRange 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1320
         TabIndex        =   39
         Top             =   720
         Visible         =   0   'False
         Width           =   255
      End
   End
   Begin VB.CommandButton cmdUndo 
      Caption         =   "Undo Last"
      Height          =   495
      Left            =   8640
      TabIndex        =   27
      Top             =   360
      Width           =   1095
   End
   Begin VB.Frame frmRAMsize 
      Caption         =   "RAM Size"
      Height          =   615
      Left            =   9960
      TabIndex        =   26
      Top             =   240
      Visible         =   0   'False
      Width           =   1815
      Begin VB.TextBox txtRAMSize 
         BackColor       =   &H8000000F&
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
         Left            =   240
         TabIndex        =   40
         Top             =   240
         Width           =   1320
      End
   End
   Begin VB.CommandButton cmdLoadResults 
      Caption         =   "Load Search"
      Height          =   495
      Left            =   7440
      TabIndex        =   25
      Top             =   360
      Width           =   1095
   End
   Begin VB.Frame Frame7 
      Caption         =   "Search History"
      Height          =   1935
      Left            =   480
      TabIndex        =   20
      Top             =   6960
      Width           =   11295
      Begin VB.TextBox txtHistory 
         Height          =   1455
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   21
         TabStop         =   0   'False
         Top             =   240
         Width           =   10815
      End
   End
   Begin VB.TextBox txtResults 
      BackColor       =   &H8000000F&
      Height          =   285
      Left            =   8880
      Locked          =   -1  'True
      TabIndex        =   17
      TabStop         =   0   'False
      Top             =   1200
      Width           =   1815
   End
   Begin VB.CommandButton cmdShowResults 
      Caption         =   "Show Results"
      Height          =   495
      Left            =   10800
      TabIndex        =   16
      Top             =   1080
      Width           =   975
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search"
      Height          =   495
      Left            =   6240
      TabIndex        =   15
      Top             =   360
      Width           =   1095
   End
   Begin VB.Frame Frame6 
      Caption         =   "Compare To"
      Height          =   735
      Left            =   3720
      TabIndex        =   13
      Top             =   240
      Width           =   1815
      Begin VB.ComboBox cmbCompareTo 
         Height          =   315
         ItemData        =   "CodeSearch.frx":0000
         Left            =   240
         List            =   "CodeSearch.frx":0007
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   270
         Width           =   1335
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Search Size"
      Height          =   735
      Left            =   480
      TabIndex        =   11
      Top             =   240
      Width           =   2895
      Begin VB.ComboBox cmbSearchSize 
         Height          =   315
         ItemData        =   "CodeSearch.frx":0017
         Left            =   360
         List            =   "CodeSearch.frx":0042
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   270
         Width           =   2295
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Extended Search Options"
      Height          =   3615
      Left            =   480
      TabIndex        =   5
      Top             =   3120
      Width           =   11295
      Begin VB.TextBox txtXValue2 
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
         Left            =   5760
         TabIndex        =   19
         Text            =   "0"
         Top             =   2880
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.TextBox txtXValue1 
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
         Left            =   2520
         TabIndex        =   18
         Text            =   "0"
         Top             =   2880
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.ListBox lstXOptions 
         Height          =   2310
         ItemData        =   "CodeSearch.frx":018A
         Left            =   360
         List            =   "CodeSearch.frx":01CA
         Style           =   1  'Checkbox
         TabIndex        =   6
         Top             =   360
         Width           =   10575
      End
      Begin VB.Label lblXValue1 
         Caption         =   "Value(s):"
         Height          =   255
         Left            =   1800
         TabIndex        =   24
         Top             =   2880
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.Label lblXValueDash 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   18
            Charset         =   255
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4560
         TabIndex        =   22
         Top             =   2880
         Visible         =   0   'False
         Width           =   1215
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Search Type"
      Height          =   1695
      Left            =   480
      TabIndex        =   4
      Top             =   1200
      Width           =   5535
      Begin VB.CommandButton cmdLess 
         Caption         =   "<"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   4320
         TabIndex        =   32
         ToolTipText     =   "Less Than"
         Top             =   120
         Width           =   495
      End
      Begin VB.CommandButton cmdGreater 
         Caption         =   ">"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3600
         TabIndex        =   31
         ToolTipText     =   "Greater Than"
         Top             =   120
         Width           =   495
      End
      Begin VB.CommandButton cmdNotEqual 
         Caption         =   "!="
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2880
         TabIndex        =   30
         ToolTipText     =   "Not Equal"
         Top             =   120
         Width           =   495
      End
      Begin VB.CommandButton cmdEqual 
         Caption         =   "=="
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   29
         ToolTipText     =   "Equal To"
         Top             =   120
         Width           =   495
      End
      Begin VB.CommandButton cmdInit 
         Caption         =   "I"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   12
            Charset         =   255
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1560
         TabIndex        =   28
         ToolTipText     =   "Initial Dump (Emulator Only)"
         Top             =   120
         Width           =   375
      End
      Begin VB.TextBox txtValue2 
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
         Left            =   3000
         TabIndex        =   9
         Text            =   "0"
         Top             =   1200
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.TextBox txtValue1 
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
         TabIndex        =   8
         Text            =   "0"
         Top             =   1200
         Width           =   2055
      End
      Begin VB.ComboBox cmbSearchType 
         Height          =   315
         ItemData        =   "CodeSearch.frx":05C2
         Left            =   240
         List            =   "CodeSearch.frx":0638
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   480
         Width           =   5055
      End
      Begin VB.Label lblValue1 
         Caption         =   "Value(s):"
         Height          =   255
         Left            =   480
         TabIndex        =   23
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label lblValueDash 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   18
            Charset         =   255
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2520
         TabIndex        =   10
         Top             =   1200
         Visible         =   0   'False
         Width           =   495
      End
   End
   Begin VB.Frame frmHeader 
      Caption         =   "Header"
      Height          =   1215
      Left            =   9480
      TabIndex        =   1
      Top             =   1680
      Width           =   2295
      Begin VB.TextBox txtHeader 
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
         Left            =   360
         MaxLength       =   8
         TabIndex        =   3
         Text            =   "0"
         Top             =   720
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.ComboBox cmbHeader 
         Height          =   315
         ItemData        =   "CodeSearch.frx":09F2
         Left            =   360
         List            =   "CodeSearch.frx":09FF
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   315
         Width           =   1695
      End
   End
   Begin VB.Frame frmEndian 
      Caption         =   "Byte Order"
      Height          =   615
      Left            =   6360
      TabIndex        =   0
      Top             =   960
      Width           =   2295
      Begin VB.ComboBox cmbEndian 
         Height          =   315
         ItemData        =   "CodeSearch.frx":0A1D
         Left            =   120
         List            =   "CodeSearch.frx":0A2D
         Style           =   2  'Dropdown List
         TabIndex        =   33
         Top             =   230
         Width           =   2055
      End
   End
End
Attribute VB_Name = "CodeSearch"
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
Dim ixValues(32) As Long
Dim xOptionsval As Long
Dim sBytes As Byte
Dim respath As String
Dim resFMT As Byte
Dim ResMax As Long
Dim AutoRes As Byte
'Dim TextEditor As String
Private Sub Form_Load()
 OpenTools(3) = True
 SetCSOptions
 cmbSearchSize.ListIndex = 0
 cmbCompareTo.Clear
 cmbCompareTo.List(0) = "Start New"
 cmbCompareTo.ListIndex = 0
 cmbSearchType.ListIndex = 0
 cmbHeader.ListIndex = 0
 lstXOptions.ListIndex = 0
 If EmuId(0) = -1 Then
  UnSetEmuVarsCS
 Else: SetEmuVarsCS
 End If
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(3) = False
 Unload CSresults
End Sub
Private Sub cmdSearch_Click()
 Dim tmpstring As String
 Dim txtString As String, Newfl As String, Oldfl As String
 Dim NewRes As String, OldRes As String
 Dim sType As Byte, resnum As Byte, sSize As Byte
 Dim fHeader As Long, errnumber As Long, memLo As Long, memHi As Long
 Dim ivList(100) As Long
 Dim ivtemp() As String
 Dim i As Integer
 errnumber = 0
 memLo = 0
 memHi = 0
 If optRangeSpec.value = True Then
  memLo = CLng("&H" & txtRangeLo.text)
  memLo = memLo And &H7FFFFFC
  txtRangeLo.text = Hex(memLo)
  memHi = CLng("&H" & txtRangeHi.text)
  memHi = memHi And &H7FFFFFC
  txtRangeHi.text = Hex(memHi)
 End If
 Select Case cmbHeader.ListIndex
  Case 0: fHeader = 0
  Case 1: fHeader = &H75C
  Case 2: fHeader = CLng("&H" & txtHeader.text)
 End Select
 sType = cmbSearchType.ListIndex + 1
 resnum = cmbCompareTo.ListCount - 1
 If cmbCompareTo.ListIndex = 0 Then resnum = 0
 sSize = cmbSearchSize.ListIndex + 1
' If opt4MB.value = True Then
'  RAMsize = &H400000
' Else
'  RAMsize = &H800000
' End If
' If EmuId(2) = 2 Then RAMsize = &H200000
 If sType = 25 Then resnum = 0
 NewRes = respath & "search" & (resnum + 1) & ".bin"
 OldRes = ""
 Oldfl = ""
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) <> -1 Then
  Newfl = respath & "RAM" & resnum & ".bin"
  errnumber = DumpRAM(EmuId(0), EmuOffsets(EmuId(1)), EmuRAM(EmuId(1)), Newfl)
  If (resnum = 0) And (sType >= 2) And (sType <= 18) Then
   sType = 25
   cmbSearchType.ListIndex = 24
  End If
  If sType = 25 Then txtResults.text = "????"
  If (resnum = 0) And (errnumber = 0) Then errnumber = InitResults(Newfl, NewRes, sSize, memLo, memHi, fHeader, CSendian)
 End If
 If (resnum > 0) Then
  OldRes = respath & "search" & resnum & ".bin"
  If Dir$(OldRes) = vbNullString Then
   MsgBox "previous results file not found", vbOKOnly
   Exit Sub
  End If
  If EmuId(0) = -1 Then
   If ChooseFile(Newfl, "Binary Files (Next File) (*.*)|*", 1) = False Then Exit Sub
  Else
'   Oldfl = respath & "RAM" & resnum - 1 & ".bin"
  End If
  If (cmbCompareTo.ListCount - 1) <> cmbCompareTo.ListIndex Then 'compare to previous
   Oldfl = GetSFName(respath & "search" & cmbCompareTo.ListIndex & ".bin")
   If Oldfl = "" Then Exit Sub
  End If
 ElseIf (sType >= 2) And (sType <= 18) Then
'  If EmuId(0) <> -1 Then
'   Oldfl = respath & "RAM" & resnum - 1 & ".bin"
'  Else
   If ChooseFile(Oldfl, "Binary Files (1st File) (*.*)|*", 1) = False Then Exit Sub
   If ChooseFile(Newfl, "Binary Files (Next File) (*.*)|*", 1) = False Then Exit Sub
'  End If
 Else
  If EmuId(0) = -1 Then
   If ChooseFile(Newfl, "Binary Files (1st File) (*.*)|*", 1) = False Then Exit Sub
  End If
 End If
' If optBigEndian = True Then
'  fileEndian = 2
' ElseIf optLittleEndian16 = True Then
'  fileEndian = 1
' ElseIf optLittleEndian32 = True Then
'  fileEndian = 0
' End If
 If (sType = 35) Then 'opcode
  ixValues(3) = GetOpBits(ixValues(5), txtValue1.text)
  If (ixValues(3) = 0) And (ixValues(5) = 0) Then
   MsgBox "Invalid OP", vbOKOnly, "Error"
   Exit Sub
  End If
 ElseIf (sType <= 20) Or (sType >= 29) Then
  tmpstring = String(16 - Len(txtValue1.text), "0") & txtValue1.text
  ixValues(0) = CLng("&H" & Left(tmpstring, 8))
  ixValues(1) = CLng("&H" & Mid(tmpstring, 9))
  ixValues(2) = ixValues(0)
  ixValues(3) = ixValues(1)
  tmpstring = String(16 - Len(txtValue2.text), "0") & txtValue2.text
  ixValues(4) = CLng("&H" & Left(tmpstring, 8))
  ixValues(5) = CLng("&H" & Mid(tmpstring, 9))
 ElseIf (sType = 26) Then
  tmpstring = String(16 - Len(txtValue1.text), "0") & Replace(txtValue1.text, "?", "0")
  ixValues(2) = CLng("&H" & Left(tmpstring, 8))
  ixValues(3) = CLng("&H" & Mid(tmpstring, 9))
  tmpstring = txtValue1.text
  For i = 1 To Len(tmpstring)
   If Mid(tmpstring, i, 1) <> "?" Then
    Mid(tmpstring, i, 1) = "F"
   Else
    Mid(tmpstring, i, 1) = "0"
   End If
  Next
  tmpstring = String(16 - Len(txtValue1.text), "0") & tmpstring
  ixValues(4) = CLng("&H" & Left(tmpstring, 8))
  ixValues(5) = CLng("&H" & Mid(tmpstring, 9))
 ElseIf (sType >= 21) And (sType <= 24) Then
 tmpstring = txtValue1.text
 Select Case sType
  Case 21, 22
   If sType = 22 Then tmpstring = UCase(tmpstring)
   tmpstring = ASCIItoHex(tmpstring, 16, 0)
   ixValues(0) = CLng("&H" & Left(tmpstring, 8))
   ixValues(1) = CLng("&H" & Mid(tmpstring, 9))
  Case 23, 24
   If sType = 24 Then tmpstring = UCase(tmpstring)
   txtString = ASCIItoHex(tmpstring, 16, 1)
   ixValues(2) = CLng("&H" & Left(txtString, 8))
   ixValues(3) = CLng("&H" & Mid(txtString, 9))
   txtString = ASCIItoHex(tmpstring, 16, 2)
   ixValues(4) = CLng("&H" & Left(txtString, 8))
   ixValues(5) = CLng("&H" & Mid(txtString, 9))
  End Select
 ElseIf (sType = 27) Or (sType = 28) Then
  ivtemp = Split(txtValue1.text, ",")
  For i = 0 To UBound(ivtemp)
   If i > 99 Then Exit For
   ivList(i + 1) = CLng("&H" & ivtemp(i))
  Next
  ivList(0) = UBound(ivtemp) + 1
 Else
  txtString = txtValue1.text
 End If
 If sType <> 25 Then
  errnumber = FileSearch(Newfl, Oldfl, NewRes, OldRes, fHeader, CSendian, sType, sSize, xOptionsval, ixValues, txtString, ivList, memLo, memHi)
 End If
 If errnumber <> 0 Then
  ShowDLLError errnumber
  Exit Sub
 End If
 'MsgBox errnumber, vbOKOnly
 'txtHistory.Text = "New File: " & Newfl & vbCrLf & "Old File: " & Oldfl & vbCrLf & _
                   "New Results: " & NewRes & vbCrLf & "Old Results: " & OldRes & _
                   vbCrLf & "Header: " & fHeader & vbCrLf & "Endian: " & fileEndian & _
                   vbCrLf & "Search Type: " & sType & vbCrLf & "Search Size: " & sSize & _
                   vbCrLf & "xOptions: " & xOptionsval & vbCrLf & "Value 1: " & ixValues(1) & _
                   vbCrLf & "Text String: " & txtString & vbCrLf
 If resnum = 0 Then
  cmbCompareTo.Clear
  cmbCompareTo.AddItem "New Search"
  txtHistory.text = ""
 End If
 cmbCompareTo.AddItem "Search " & resnum + 1
 cmbCompareTo.ListIndex = resnum + 1
 If sType <> 25 Then GetResultCount 1
 txtHistory.text = txtHistory.text & "[Search " & resnum + 1 & "] " & cmbSearchType.List(cmbSearchType.ListIndex) & _
                   ": File(s)=" & Newfl & ", " & Oldfl & "; Header=" & Hex(fHeader) & _
                   "; Endian=" & CSendian & "; Size=" & cmbSearchSize.List(cmbSearchSize.ListIndex) & _
                   "; xOptions=" & Hex(xOptionsval) & "; Value(s)=" & txtValue1.text & "," & txtValue2.text & vbCrLf
End Sub
Private Sub cmdShowResults_Click()
 If cmbCompareTo.ListIndex < 1 Then
  MsgBox "I've heard of 'pilot error,' but you just flew the plane straight into the fuckin ground." & vbCrLf & "Try actually starting a search before asking for results next time, dumbass.", vbOKOnly, "Error"
  Exit Sub
 End If
 CSresults.Show
 CSresults.GetRes cmbCompareTo.ListIndex
' MsgBox errnumber, vbOKOnly
' Shell "notepad.exe " & ResPath & resnum & ".txt", vbNormalFocus
' Shell "c:\Program Files\TextPad 4\Textpad.exe " & ResPath & resnum & ".txt", vbNormalFocus
' Shell TextEditor & " " & respath & "search" & resnum & ".txt", vbNormalFocus
End Sub
Private Sub GetResultCount(ByVal usage As Byte)
 Dim resnum As Byte
 Dim resfile As String
 resnum = cmbCompareTo.ListIndex
 If resnum = 0 Then Exit Sub
 resfile = respath & "search" & resnum & ".bin"
 If Not Exists(resfile, 0) Then
  txtResults.text = "Error"
  Exit Sub
 End If
 txtResults.text = GetResCount(resfile)
 If usage = 1 Then
  If (AutoRes = 1) And (txtResults.text > 0) And (txtResults.text <= ResMax) Then cmdShowResults_Click
 End If
End Sub
Private Sub cmbSearchSize_Click()
 Select Case (cmbSearchSize.ListIndex + 1)
  Case 1 '8-bit
   sBytes = 1
   SetValueSize 2
  Case 2, 3, 4, 5 '16-bit
   sBytes = 2
   SetValueSize 4
  Case 6 '24-bit
   sBytes = 3
   SetValueSize 6
  Case 7, 8 '32-bit
   sBytes = 4
   SetValueSize 8
  Case 9 '40-bit
   sBytes = 5
   SetValueSize 10
  Case 10 '48-bit
   sBytes = 6
   SetValueSize 12
  Case 11 '56-bit
   sBytes = 7
   SetValueSize 14
  Case 12, 13 '64-bit
   sBytes = 8
   SetValueSize 16
 End Select
' If (cmbSearchType.ListIndex + 1) >= 21 Then SetValueSize 127
 Select Case (cmbSearchType.ListIndex + 1)
  Case 11, 17, 18: SetValueSize 2 'bits
'  Case 21, 22, 23, 24, 25, 26, 27, 28: SetValueSize 127
  Case 21, 22, 23, 24: SetValueSize sBytes
  Case 27, 28: SetValueSize 127
 End Select
 If (((cmbSearchType.ListIndex + 1) = 27) Or ((cmbSearchType.ListIndex + 1) = 28)) And _
    ((cmbSearchSize.ListIndex + 1) > 8) Then cmbSearchSize.ListIndex = 6
' If EmuId(2) = 2 Then
'  If cmbSearchSize.ListIndex > 0 Then
'   optLittleEndian16.value = True
'  Else: optBigEndian.value = True
'  End If
' End If
 If ((cmbSearchType.ListIndex + 1) >= 31) Then cmbSearchSize.ListIndex = 6
End Sub
Private Sub SetValueSize(ByVal size As Integer)
 txtValue1.MaxLength = size
 txtValue2.MaxLength = size
 If Len(txtValue1.text) > txtValue1.MaxLength Then txtValue1.text = "0"
 If Len(txtValue2.text) > txtValue2.MaxLength Then txtValue2.text = "0"
 txtXValue1.MaxLength = size
 txtXValue2.MaxLength = size
 If Len(txtXValue1.text) > txtXValue1.MaxLength Then txtXValue1.text = "0"
 If Len(txtXValue2.text) > txtXValue2.MaxLength Then txtXValue2.text = "0"
End Sub
Private Sub cmbHeader_Click()
 If cmbHeader.ListIndex = 2 Then
  txtHeader.Visible = True
 ElseIf cmbHeader.ListIndex = 1 Then
  cmbEndian.ListIndex = 0
 Else
  txtHeader.Visible = False
 End If
End Sub
Private Sub cmbSearchType_Click()
 Select Case (cmbSearchType.ListIndex + 1)
  Case 1, 3, 4, 5, 7, 8, 9, 11, 13, 14, 15, 16, 17, 18, 29, 30, 31, 32, 33, 34 'single value searches
   txtValue1.Visible = True
   txtValue2.Visible = False
   lblValue1.Visible = True
   lblValueDash.Visible = False
  Case 2, 6, 10, 12, 25, 36, 37 'greater/less/equal/nequal/init
   txtValue1.Visible = False
   txtValue2.Visible = False
   lblValue1.Visible = False
   lblValueDash.Visible = False
  Case 19, 20 'in-range
   txtValue1.Visible = True
   txtValue2.Visible = True
   lblValue1.Visible = True
   lblValueDash.Visible = True
  Case 21, 22, 23, 24, 26, 27, 28, 35 'text/wildval/knownlist/not list
   txtValue1.Visible = True
   txtValue2.Visible = False
   lblValue1.Visible = True
   lblValueDash.Visible = False
 End Select
 If (((cmbSearchType.ListIndex + 1) = 27) Or ((cmbSearchType.ListIndex + 1) = 28)) And _
    ((cmbSearchSize.ListIndex + 1) > 8) Then cmbSearchSize.ListIndex = 6
 cmbSearchSize_Click
 If (cmbSearchType.ListIndex + 1 = 25) And (EmuId(0) = -1) Then cmbSearchType.ListIndex = 25
 txtValue1_Change
 txtValue2_Change
End Sub
Private Sub lstXOptions_Click()
 Select Case (lstXOptions.ListIndex + 1)
  Case 1, 2, 3, 4, 8 'Signed, Or Equal, 0, FF, Pointers
   SetXinputSize 0, 0
  Case 5 'not value
   SetXinputSize 0, 1
   cmbSearchSize_Click
  Case 6, 7 'range/not range
   SetXinputSize 0, 2
   cmbSearchSize_Click
  Case 9 '8-bit value
   SetXinputSize 2, 1
  Case 10 '16-bit value
   SetXinputSize 4, 1
  Case 11 '32-bit value
   SetXinputSize 8, 1
  Case 12 '64-bit value
   SetXinputSize 16, 1
  Case 13 '8-bit range
   SetXinputSize 2, 2
  Case 14 '16-bit value
   SetXinputSize 4, 2
  Case 15 '32-bit value
   SetXinputSize 8, 2
  Case 16 '64-bit value
   SetXinputSize 16, 2
  Case 17, 18, 19, 20 'consec addresses
   SetXinputSize 2, 1
 End Select
 SetXOpt lstXOptions.ListIndex, lstXOptions.Selected(lstXOptions.ListIndex)
End Sub
Private Sub SetXinputSize(ByVal size, ByVal numboxes)
 txtXValue1.MaxLength = size
 txtXValue2.MaxLength = size
 txtXValue1.text = "0"
 txtXValue2.text = "0"
 Select Case numboxes
  Case 0
   lblXValue1.Visible = False
   txtXValue1.Visible = False
   txtXValue2.Visible = False
   lblXValueDash.Visible = False
  Case 1
   lblXValue1.Visible = True
   txtXValue1.Visible = True
   txtXValue2.Visible = False
   lblXValueDash.Visible = False
  Case 2
   lblXValue1.Visible = True
   txtXValue1.Visible = True
   txtXValue2.Visible = True
   lblXValueDash.Visible = True
 End Select
End Sub
Private Sub SetXOpt(ByVal optnum As Long, ByVal status As Boolean)
 If status = False Then
  xOptionsval = xOptionsval And (Not SLL(1, optnum))
 Else
  xOptionsval = xOptionsval Or SLL(1, optnum)
 End If
' MsgBox xOptionsval, vbOKOnly
End Sub
Private Sub txtValue1_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey = 13 Then 'Enter
  cmdSearch_Click
 End If
 Select Case (cmbSearchType.ListIndex + 1)
  Case 1, 3, 4, 5, 7, 8, 9, 13, 14, 15, 16, 19, 20, 29, 30, 31, 32, 33, 34 'value searches
   If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
  Case 11, 17, 18 'bit searches
   If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
  Case 26: 'wildval
   If (PressedKey <> 8) And (PressedKey <> 63) Then PressedKey = FilterHexKeys(PressedKey)
  Case 27, 28: 'known/not list
   If (PressedKey <> 8) And (PressedKey <> 44) Then PressedKey = FilterHexKeys(PressedKey)
 End Select
End Sub
Private Sub txtValue1_Change()
 Select Case (cmbSearchType.ListIndex + 1)
  Case 1, 3, 4, 5, 7, 8, 9, 13, 14, 15, 16, 19, 20, 29, 30, 31, 32, 33, 34 'single value searches
    txtValue1.text = FilterHexValues(txtValue1.text)
  Case 11, 17, 18 'bits
   If IsNumeric(txtValue1.text) = False Then
    txtValue1.text = "0"
   Else
    If CLng(txtValue1.text) > (sBytes * 8) Then
     MsgBox "That's more bits than the goddamn search size. " & sBytes & " bytes == " & (sBytes * 8) & " bits", vbOKOnly
     txtValue1.text = "0"
    End If
   End If
   Case 2, 6, 10, 12, 25 'greater/less/equal/nequal/init
    txtValue1.text = FilterHexValues(txtValue1.text)
 End Select
End Sub
Private Sub txtValue2_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey = 13 Then 'Enter
  cmdSearch_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtValue2_Change()
 txtValue2.text = FilterHexValues(txtValue2.text)
End Sub
Private Sub txtXValue1_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey = 13 Then 'Enter
  cmdSearch_Click
 End If
 If (lstXOptions.ListIndex + 1) <= 16 Then
  If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
 Else
  If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
 End If
End Sub
Private Sub txtXValue1_Change()
 Dim tmpstring As String
 txtXValue1.text = FilterHexValues(txtXValue1.text)
 If (lstXOptions.ListIndex + 1) >= 17 Then
  If IsNumeric(txtXValue1.text) = False Then txtXValue1.text = ""
 End If
 Select Case (lstXOptions.ListIndex + 1)
  Case 5 'not value
   tmpstring = String(16 - Len(txtXValue1.text), "0") & txtXValue1.text
   ixValues(6) = CLng("&H" & Left(tmpstring, 8))
   ixValues(7) = CLng("&H" & Mid(tmpstring, 9))
  Case 6 'range
   tmpstring = String(16 - Len(txtXValue1.text), "0") & txtXValue1.text
   ixValues(8) = CLng("&H" & Left(tmpstring, 8))
   ixValues(9) = CLng("&H" & Mid(tmpstring, 9))
  Case 7 'not range
   tmpstring = String(16 - Len(txtXValue1.text), "0") & txtXValue1.text
   ixValues(12) = CLng("&H" & Left(tmpstring, 8))
   ixValues(13) = CLng("&H" & Mid(tmpstring, 9))
  Case 9 'part of byte
   ixValues(16) = CLng("&H" & txtXValue1.text)
  Case 10 'part of short
   ixValues(19) = CLng("&H" & txtXValue1.text)
  Case 11 'part of word
   ixValues(22) = CLng("&H" & txtXValue1.text)
  Case 12 'part of dword
   tmpstring = String(16 - Len(txtXValue1.text), "0") & txtXValue1.text
   ixValues(25) = CLng("&H" & Left(tmpstring, 8))
   ixValues(26) = CLng("&H" & Mid(tmpstring, 9))
  Case 13 'part of byte range
   ixValues(17) = CLng("&H" & txtXValue1.text)
  Case 14 'part of short range
   ixValues(20) = CLng("&H" & txtXValue1.text)
  Case 15 'part of word range
   ixValues(23) = CLng("&H" & txtXValue1.text)
  Case 16 'part of dword range
   tmpstring = String(16 - Len(txtXValue1.text), "0") & txtXValue1.text
   ixValues(27) = CLng("&H" & Left(tmpstring, 8))
   ixValues(28) = CLng("&H" & Mid(tmpstring, 9))
  Case 17, 18, 19, 20 'consecutive results
   ixValues(31) = CLng(txtXValue1.text)
 End Select
End Sub
Private Sub txtXValue2_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey = 13 Then 'Enter
  cmdSearch_Click
 End If
 If (lstXOptions.ListIndex + 1) <= 16 Then
  If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtXValue2_Change()
 Dim tmpstring As String
 txtXValue2.text = FilterHexValues(txtXValue2.text)
 If (lstXOptions.ListIndex + 1) >= 17 Then
  If IsNumeric(txtXValue2.text) = False Then txtXValue2.text = ""
 End If
 Select Case (lstXOptions.ListIndex + 1)
  Case 6 'range
   tmpstring = String(16 - Len(txtXValue2.text), "0") & txtXValue2.text
   ixValues(10) = CLng("&H" & Left(tmpstring, 8))
   ixValues(11) = CLng("&H" & Mid(tmpstring, 9))
  Case 7 'not range
   tmpstring = String(16 - Len(txtXValue2.text), "0") & txtXValue2.text
   ixValues(14) = CLng("&H" & Left(tmpstring, 8))
   ixValues(15) = CLng("&H" & Mid(tmpstring, 9))
  Case 13 'part of byte range
   ixValues(18) = CLng("&H" & txtXValue2.text)
  Case 14 'part of short range
   ixValues(21) = CLng("&H" & txtXValue2.text)
  Case 15 'part of word range
   ixValues(24) = CLng("&H" & txtXValue2.text)
  Case 16 'part of dword range
   tmpstring = String(16 - Len(txtXValue2.text), "0") & txtXValue2.text
   ixValues(29) = CLng("&H" & Left(tmpstring, 8))
   ixValues(30) = CLng("&H" & Mid(tmpstring, 9))
 End Select
End Sub
Private Sub txtHeader_KeyPress(PressedKey As Integer)
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtHeader_Change()
 txtHeader.text = FilterHexValues(txtHeader.text)
End Sub
Public Sub SetCSOptions()
' ResPath = "c:\temp\search"
' ResPath = App.Path & "\search"
 respath = GetCFG("respath", 3, DefaultResPath)
 resFMT = GetCFG("resfmt", 1, 6)
 ResMax = GetCFG("resmax", 1, 1000)
 AutoRes = GetCFG("autores", 3, 1)
 cmbEndian.ListIndex = 2
' TextEditor = GetCFG("cs_texteditor", 3, DefaultTextEditor)
End Sub
Private Sub cmdLoadResults_Click()
 Dim errnumber As Long
 Dim resName As String
 If Not ChooseFile(resName, "Search Files (search*.bin)|search*.bin", 1) Then Exit Sub
 errnumber = CopyFileBytes(resName, respath & "search1.bin", 0, 0, 0)
 If errnumber <> 0 Then
  ShowDLLError errnumber
 End If
 cmbCompareTo.Clear
 cmbCompareTo.AddItem "New Search"
 cmbCompareTo.AddItem "Search 1"
 cmbCompareTo.ListIndex = 1
 GetResultCount 0
End Sub
Public Sub SetEmuVarsCS()
 If EmuId(0) <> -1 Then
  frmHeader.Enabled = False
  cmbHeader.ListIndex = 0
  CSendian = EmuEndian(EmuId(1))
  cmbEndian.ListIndex = EmuEndian(EmuId(1))
  cmbEndian.Enabled = False
  frmRAMsize.Visible = True
  txtRAMSize.text = "0x" & Hex(EmuRAM(EmuId(1)))
 End If
End Sub
Public Sub UnSetEmuVarsCS()
 frmRAMsize.Visible = False
 frmHeader.Enabled = True
 cmbEndian.Enabled = True
 EmuId(0) = -1
End Sub
Private Sub cmdUndo_Click()
 If cmbCompareTo.ListCount < 2 Then Exit Sub
 cmbCompareTo.RemoveItem cmbCompareTo.ListCount - 1
 cmbCompareTo.ListIndex = cmbCompareTo.ListCount - 1
 GetResultCount 0
End Sub
Private Sub cmdInit_Click()
 cmbSearchType.ListIndex = 24
 cmdSearch_Click
End Sub
Private Sub cmdEqual_Click()
 cmbSearchType.ListIndex = 9
 cmdSearch_Click
End Sub
Private Sub cmdNotEqual_Click()
 cmbSearchType.ListIndex = 11
 cmdSearch_Click
End Sub
Private Sub cmdGreater_Click()
 cmbSearchType.ListIndex = 1
 cmdSearch_Click
End Sub
Private Sub cmdLess_Click()
 cmbSearchType.ListIndex = 5
 cmdSearch_Click
End Sub
Private Sub cmbEndian_Click()
 CSendian = cmbEndian.ListIndex
End Sub
Private Sub optRangeSpec_Click()
 lblRange.Visible = True
 txtRangeLo.Visible = True
 txtRangeHi.Visible = True
 If EmuId(0) <> -1 Then
  If txtRangeLo.text = "" Then txtRangeLo.text = HexString(0, 8)
  If txtRangeHi.text = "" Then txtRangeHi.text = HexString(EmuRAM(EmuId(1)), 8)
 End If
End Sub
Private Sub optRangeAll_Click()
 lblRange.Visible = False
 txtRangeLo.Visible = False
 txtRangeHi.Visible = False
End Sub
Private Sub txtRangeLo_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtRangeLo_Change()
 txtRangeLo.text = FilterHexValues(txtRangeLo.text)
End Sub
Private Sub txtRangeHi_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtRangeHi_Change()
 txtRangeHi.text = FilterHexValues(txtRangeHi.text)
End Sub

