VERSION 5.00
Begin VB.Form CSresults 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Search - Results"
   ClientHeight    =   9000
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.CommandButton cmdRmvAll 
      Caption         =   "Remove All"
      Height          =   255
      Left            =   10200
      TabIndex        =   19
      Top             =   8160
      Width           =   975
   End
   Begin VB.CommandButton cmdEditCode 
      Caption         =   "<<"
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   7320
      TabIndex        =   17
      Top             =   8640
      Width           =   735
   End
   Begin VB.CommandButton cmdDeActivate 
      Caption         =   "Remove"
      Height          =   255
      Left            =   10200
      TabIndex        =   16
      Top             =   8640
      Width           =   735
   End
   Begin VB.CheckBox chkActivate 
      Caption         =   "On/Off"
      Height          =   255
      Left            =   7320
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   7920
      Width           =   735
   End
   Begin VB.CommandButton cmdView 
      Caption         =   "View"
      Height          =   315
      Left            =   5640
      TabIndex        =   14
      Top             =   8040
      Width           =   1050
   End
   Begin VB.Timer tmrResTrain 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   120
      Top             =   8400
   End
   Begin VB.CommandButton cmdActivateCode 
      Caption         =   "Activate"
      Height          =   315
      Left            =   4440
      TabIndex        =   13
      Top             =   8400
      Width           =   1050
   End
   Begin VB.ComboBox cmbWriteSize 
      Height          =   315
      ItemData        =   "CSresults.frx":0000
      Left            =   3480
      List            =   "CSresults.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   12
      Top             =   8280
      Width           =   855
   End
   Begin VB.ListBox lstActiveCodes 
      Height          =   960
      Left            =   8040
      Style           =   1  'Checkbox
      TabIndex        =   11
      Top             =   7920
      Width           =   2175
   End
   Begin VB.CommandButton cmdWrite 
      Caption         =   "Write Once"
      Height          =   315
      Left            =   4440
      TabIndex        =   10
      Top             =   8040
      Width           =   1050
   End
   Begin VB.TextBox txtValue 
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
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   7
      Top             =   8280
      Width           =   1050
   End
   Begin VB.TextBox txtAddy 
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
      Left            =   960
      MaxLength       =   8
      TabIndex        =   6
      Top             =   8280
      Width           =   1050
   End
   Begin VB.ComboBox cmbViewFMT 
      Height          =   315
      ItemData        =   "CSresults.frx":0028
      Left            =   8640
      List            =   "CSresults.frx":003B
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   120
      Width           =   2415
   End
   Begin VB.ListBox lstRes 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7080
      Left            =   240
      TabIndex        =   3
      Top             =   480
      Width           =   11415
   End
   Begin VB.CommandButton cmdExport 
      Caption         =   "Export"
      Height          =   375
      Left            =   10560
      TabIndex        =   1
      Top             =   7560
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "Adresss   Value    Size"
      Height          =   255
      Left            =   8280
      TabIndex        =   18
      Top             =   7680
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Value:"
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   8040
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "Address:"
      Height          =   255
      Left            =   960
      TabIndex        =   8
      Top             =   8040
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "View:"
      Height          =   255
      Left            =   8160
      TabIndex        =   4
      Top             =   150
      Width           =   495
   End
   Begin VB.Label lblNumShown 
      Caption         =   "Showing first # of "
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   7560
      Width           =   3015
   End
   Begin VB.Label Label1 
      Caption         =   "Address: Current Value   Previous Value(s) "
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   5415
   End
End
Attribute VB_Name = "CSresults"
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
Dim searchnum As Byte
Dim pHandle As Long
'Const rsPageSize = 10000
Private Sub Form_Load()
 Dim tmpfmt As Integer
 tmpfmt = GetCFG("resfmt2", 1, 1) - 1
 If tmpfmt = 12 Then tmpfmt = 4
 cmbViewFMT.ListIndex = tmpfmt
 cmbWriteSize.ListIndex = 0
End Sub
Public Sub GetRes(ByVal resnum As Byte)
 Dim rshandle As Integer, rsPageSize As Integer
 Dim rsPath As String, rsOut As String, rsLine As String
 Dim rsFMT As Byte
 Dim errnumber As Long, res As Long, rsCount As Long, tmpval As Long
 rsPath = GetCFG("respath", 3, DefaultResPath)
 searchnum = resnum
 rsFMT = GetCFG("resfmt2", 1, 1)
 rsPageSize = GetCFG("maxresdisp", 1, DefaultResDispMax)
 rsOut = rsPath & "search" & resnum & ".txt"
 If resnum = 0 Then Exit Sub
 errnumber = WriteAllResults(rsPath, rsOut, searchnum, rsFMT)
 If errnumber <> 0 Then
  ShowDLLError errnumber
  Exit Sub
 End If
 If Not Exists(rsOut, 1) Then Exit Sub
 rsCount = GetResCount(rsPath & "search" & resnum & ".bin")
 rshandle = FreeFile
 Open (rsPath & "search" & resnum & ".txt") For Input As #rshandle
 lstRes.Clear
 res = 0
 Do
  Line Input #rshandle, rsLine
  lstRes.AddItem rsLine
  res = res + 1
 Loop Until EOF(rshandle) Or (res >= rsPageSize)
 Close #rshandle
 lblNumShown.Caption = "Showing " & res & " of " & rsCount & " results"
 If EmuId(0) = -1 Then
  cmdActivateCode.Enabled = False
  cmdWrite.Enabled = False
  cmdView.Enabled = False
  chkActivate.value = 0
  chkActivate.Enabled = False
  tmrResTrain.Enabled = False
 Else
  cmdActivateCode.Enabled = True
  cmdWrite.Enabled = True
  cmdView.Enabled = True
  chkActivate.Enabled = True
 End If
End Sub
Private Sub cmbViewFMT_Click()
 Select Case cmbViewFMT.ListIndex
  Case 0: WriteCFG "resfmt2", 1
  Case 1: WriteCFG "resfmt2", 2
  Case 2: WriteCFG "resfmt2", 3
  Case 3: WriteCFG "resfmt2", 4
  Case 4: WriteCFG "resfmt2", 13
 End Select
 GetRes searchnum
End Sub
Private Sub cmdExport_Click()
 dlgExportCS.Show vbModal
End Sub
Public Sub ExportResSingle(ByVal resnum As Byte)
 Dim resName As String, txtName As String, txteditor As String, dfname As String
 Dim resFMT As Byte, tmpchar As Byte
 Dim errnumber As Long
 Dim rshandle As Integer, l As Integer
 resFMT = GetCFG("resfmt", 1, 1)
 resName = GetCFG("respath", 3, DefaultResPath) & "search" & searchnum & ".bin"
 If Not Exists(resName, 1) Then Exit Sub
 dfname = GetCFG("respath", 3, DefaultResPath) & "search" & resnum & ".bin"
 If Not Exists(dfname, 1) Then Exit Sub
 rshandle = FreeFile
 Open (dfname) For Binary As #rshandle
 dfname = GetSFName(dfname)
 If dfname = "" Then Exit Sub
 If Not ChooseFile(txtName, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
 errnumber = WriteResults(resName, txtName, dfname, resFMT, 1)
 If errnumber <> 0 Then
  ShowDLLError errnumber
  Exit Sub
 End If
 txteditor = GetCFG("cs_texteditor", 3, DefaultTextEditor)
 Shell txteditor & " " & txtName, vbNormalFocus
End Sub
Private Sub lstRes_Click()
 If lstRes.ListIndex = -1 Then Exit Sub
 Dim tmpcode() As String
 tmpcode = Split(Replace(Trim(lstRes.text), "  ", " "), " ")
 If UBound(tmpcode) < 1 Then Exit Sub
 txtAddy.text = tmpcode(0)
 txtValue.text = tmpcode(1)
 Select Case Len(tmpcode(1)) And 7
  Case 1, 2: cmbWriteSize.ListIndex = 0
  Case 3, 4: cmbWriteSize.ListIndex = 1
  Case Is > 5: cmbWriteSize.ListIndex = 2
 End Select
End Sub
Private Sub cmdWrite_Click()
 Dim address As Long, value As Long, size As Long
 Dim errbool As Boolean
 If IsHex(txtAddy.text) = False Then Exit Sub
 If IsHex(txtValue.text) = False Then Exit Sub
 address = CLng("&H" & txtAddy.text) And &H7FFFFFF
 value = CLng("&H" & txtValue.text)
 Select Case cmbWriteSize.ListIndex
  Case 0: size = 1
  Case 1: size = 2
  Case 2: size = 4
 End Select
 If GetHandle Then
  errbool = WriteRAM(address, value, size)
  CloseHandle pHandle
 End If
End Sub
Private Sub cmdActivateCode_Click()
 Dim address As Long, value As Long, size As Long
 Dim i As Integer, actcode As Boolean
 If IsHex(txtAddy.text) = False Then Exit Sub
 If IsHex(txtValue.text) = False Then Exit Sub
 address = CLng("&H" & txtAddy.text) And &H7FFFFFF
 value = CLng("&H" & txtValue.text)
 Select Case cmbWriteSize.ListIndex
  Case 0: size = 1
  Case 1: size = 2
  Case 2: size = 4
 End Select
 actcode = False
 For i = 0 To lstActiveCodes.ListCount
  If Len(lstActiveCodes.List(i)) < 8 Then Exit For
  If CLng("&H" & Left(lstActiveCodes.List(i), 8)) = address Then
   lstActiveCodes.List(i) = HexString(address, 8) & "  " & HexString(value, (size * 2)) & "  " & size
   lstActiveCodes.Selected(i) = True
   actcode = True
  End If
 Next
 If actcode = False Then
  lstActiveCodes.AddItem HexString(address, 8) & "  " & HexString(value, (size * 2)) & "  " & size
  lstActiveCodes.Selected(lstActiveCodes.ListCount - 1) = True
 End If
 chkActivate.value = 1
End Sub
Private Sub tmrResTrain_Timer()
 Dim address As Long, value As Long, size As Long
 Dim i As Integer
 Dim tmpcode() As String
 If GetHandle = False Then
  MsgBox "Unable to open process.", vbOKOnly, "Error"
  tmrResTrain.Enabled = False
  Exit Sub
 End If
 For i = 0 To lstActiveCodes.ListCount - 1
'  If lstActiveCodes.List(i) = "" Then GoTo NextCode
  If lstActiveCodes.Selected(i) = False Then GoTo nextcode
  tmpcode = Split(lstActiveCodes.List(i), "  ")
  address = CLng("&H" & tmpcode(0))
  value = CLng("&H" & tmpcode(1))
  size = tmpcode(2)
  Erase tmpcode
  If Not WriteRAM(address, value, size) Then
   tmrResTrain.Enabled = False
   Exit Sub
  End If
nextcode:
 Next
  
  CloseHandle pHandle
End Sub
Private Function GetHandle() As Boolean
 GetHandle = False
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) = -1 Then
  Exit Function
 End If
 pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
 If pHandle = 0 Then
  MsgBox "OpenProcess failed"
  MainMDI.mnuEmuDetach_Click
  Exit Function
 End If
 GetHandle = True
End Function
Private Function WriteRAM(ByVal addy As Long, ByVal value As Long, ByVal size As Long) As Boolean
 Dim bah As Long
 Dim err As Long
 WriteRAM = True
 addy = FlipAddy(addy, size, IIf((CSendian = 3), 2, CSendian))
 If WriteProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + addy), value, size, bah) = 0 Then
  MsgBox "Write failed: " & Hex(addy) & ":" & Hex(value), vbOKOnly, "Error"
  WriteRAM = False
 End If
End Function
Private Sub txtValue_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdWrite_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtValue_Change()
 txtValue.text = FilterHexValues(txtValue.text)
End Sub
Private Sub txtAddy_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdWrite_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtAddy_Change()
 txtAddy.text = FilterHexValues(txtAddy.text)
End Sub
Private Sub chkActivate_Click()
 tmrResTrain.Enabled = CBool(chkActivate.value)
End Sub
Private Sub cmbWriteSize_Click()
 Dim tmpaddy As Long
 If IsHex(txtAddy.text) = False Then Exit Sub
 tmpaddy = CLng("&H" & txtAddy.text) And &H7FFFFFF
 Select Case cmbWriteSize.ListIndex
  Case 1: tmpaddy = tmpaddy And &H7FFFFFE
  Case 2: tmpaddy = tmpaddy And &H7FFFFFC
 End Select
 txtAddy = HexString(tmpaddy, 8)
End Sub
Private Sub cmdDeActivate_Click()
 If lstActiveCodes.ListIndex = -1 Then Exit Sub
 lstActiveCodes.RemoveItem (lstActiveCodes.ListIndex)
End Sub
Private Sub cmdRmvAll_Click()
 lstActiveCodes.Clear
End Sub
Private Sub cmdEditCode_Click()
 Dim address As Long, value As Long, size As Long
 Dim tmpcode() As String
 If lstActiveCodes.ListIndex = -1 Then Exit Sub
 tmpcode = Split(lstActiveCodes.List(lstActiveCodes.ListIndex), "  ")
 lstActiveCodes.RemoveItem (lstActiveCodes.ListIndex)
 address = CLng("&H" & tmpcode(0))
 value = CLng("&H" & tmpcode(1))
 size = tmpcode(2)
 Select Case size
  Case 1: cmbWriteSize.ListIndex = 0
  Case 2: cmbWriteSize.ListIndex = 1
  Case 4: cmbWriteSize.ListIndex = 2
 End Select
 txtAddy.text = HexString(address, 8)
 txtValue.text = HexString(value, size)
End Sub
Private Sub cmdView_Click()
 Dim address As Long, value As Long, size As Long
 If IsHex(txtAddy.text) = False Then Exit Sub
 address = CLng("&H" & txtAddy.text) And &H7FFFFFC
 MemEditor.Show
 MemEditor.GetRAM address
End Sub
