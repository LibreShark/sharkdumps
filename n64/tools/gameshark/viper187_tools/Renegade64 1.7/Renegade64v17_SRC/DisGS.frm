VERSION 5.00
Begin VB.Form DisGS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Disassembler"
   ClientHeight    =   7500
   ClientLeft      =   150
   ClientTop       =   240
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   500
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.CommandButton cmdCopyDis 
      Caption         =   "Copy"
      Enabled         =   0   'False
      Height          =   255
      Left            =   8040
      TabIndex        =   20
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdHTMLdis 
      Caption         =   "HTML"
      Enabled         =   0   'False
      Height          =   255
      Left            =   8760
      TabIndex        =   18
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdSaveR4300i 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   7320
      TabIndex        =   16
      ToolTipText     =   "Ctrl+S"
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdSaveCodes 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1800
      TabIndex        =   15
      ToolTipText     =   "Ctrl+Shift+S"
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdOpenCodes 
      Caption         =   "Open"
      Height          =   255
      Left            =   1080
      TabIndex        =   14
      ToolTipText     =   "Ctrl+O"
      Top             =   480
      Width           =   615
   End
   Begin VB.Frame Frame2 
      Caption         =   "Options"
      Height          =   2295
      Left            =   3840
      TabIndex        =   10
      Top             =   3120
      Width           =   2055
      Begin VB.CheckBox chkHexPrefix 
         Caption         =   "Prefix Hex (0x)"
         Height          =   255
         Left            =   240
         TabIndex        =   19
         Top             =   1920
         Width           =   1455
      End
      Begin VB.CheckBox chkPSX 
         Caption         =   "PSX"
         Height          =   375
         Left            =   240
         TabIndex        =   17
         Top             =   1440
         Width           =   1575
      End
      Begin VB.CheckBox chkAlignDis 
         Caption         =   "Align Disassembly"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   1080
         Value           =   1  'Checked
         Width           =   1575
      End
      Begin VB.CheckBox chkShowOrg 
         Caption         =   "Show .ORG Ops"
         Height          =   255
         Left            =   240
         TabIndex        =   12
         Top             =   720
         Width           =   1575
      End
      Begin VB.CheckBox chkShowAddys 
         Caption         =   "Show Addresses"
         Height          =   255
         Left            =   240
         TabIndex        =   11
         Top             =   360
         Value           =   1  'Checked
         Width           =   1575
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Reg Format"
      Height          =   735
      Left            =   3840
      TabIndex        =   8
      Top             =   2160
      Width           =   2055
      Begin VB.ComboBox cmbRegFMT 
         Height          =   315
         ItemData        =   "DisGS.frx":0000
         Left            =   240
         List            =   "DisGS.frx":0010
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   275
         Width           =   1575
      End
   End
   Begin VB.CommandButton cmdClearASM 
      Caption         =   "Clear"
      Enabled         =   0   'False
      Height          =   255
      Left            =   10920
      TabIndex        =   7
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdClearCodes 
      Caption         =   "Clear"
      Enabled         =   0   'False
      Height          =   255
      Left            =   2880
      TabIndex        =   6
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton cmdDisGS 
      Caption         =   "Disassemble"
      Enabled         =   0   'False
      Height          =   375
      Left            =   4320
      TabIndex        =   2
      Top             =   1440
      Width           =   1095
   End
   Begin VB.TextBox txtDis 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5535
      Left            =   6240
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   720
      Width           =   5295
   End
   Begin VB.TextBox txtCodes 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5535
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   720
      Width           =   3135
   End
   Begin VB.Label Label3 
      Caption         =   "* incomplete opcode data"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   6240
      TabIndex        =   5
      Top             =   6240
      Width           =   3135
   End
   Begin VB.Label Label2 
      Caption         =   "Disassembly:"
      Height          =   255
      Left            =   6240
      TabIndex        =   4
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Codes:"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   480
      Width           =   615
   End
End
Attribute VB_Name = "DisGS"
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
Private Sub Form_Load()
 OpenTools(5) = True
 cmbRegFMT.ListIndex = GetCFG("asmregfmt", 1, 1)
 FPRnames = Split(FPRNameList1, ",")
 CP0names = Split(CP0NameList1, ",")
 fmt(16) = "S"
 fmt(17) = "D"
 fmt(20) = "W"
 fmt(21) = "L"
 chkShowAddys.value = GetCFG("disgs_showaddys", 1, 0)
 chkShowOrg.value = GetCFG("disgs_showorg", 1, 1)
 chkAlignDis.value = GetCFG("disgs_aligndis", 1, 1)
 chkPSX.value = GetCFG("disgs_psx", 1, 0)
 chkHexPrefix.value = GetCFG("disgs_hexprefix", 1, 0)
End Sub
Private Sub Form_Unload(cancel As Integer)
 WriteCFG "disgs_showaddys", chkShowAddys.value
 WriteCFG "disgs_showorg", chkShowOrg.value
 WriteCFG "disgs_aligndis", chkAlignDis.value
 WriteCFG "disgs_psx", chkPSX.value
 WriteCFG "disgs_hexprefix", chkHexPrefix.value
 OpenTools(5) = False
End Sub
Private Sub cmdDisGS_Click()
 Dim codes() As String, disout As String, tmpcode As String, tmpcode2 As String
 Dim tmpaddy As Long, tmpvalue As Long, tmpaddy2 As Long, tmpvalue2 As Long
 Dim i As Integer
 Static PrevAddy As Long
 If txtCodes.text = "" Then Exit Sub
 txtCodes.text = txtCodes.text & vbCrLf
 codes = Split(txtCodes.text, Chr(13) + Chr(10))
 disout = ""
 If chkHexPrefix.value = 1 Then
  immpre = "0x"
 Else
  immpre = ""
 End If
 For i = 0 To UBound(codes)
  tmpcode = Trim(Replace(codes(i), " ", ""))
  If (FilterHexValues(tmpcode) <> "0") And (Len(tmpcode) = 12) Then
   tmpaddy = CLng("&H" & Mid(tmpcode, 3, 6))
   tmpvalue = CLng("&H" & Mid(tmpcode, 9))
   If ((tmpaddy - 4) <> PrevAddy) And chkShowOrg.value Then
    disout = disout & ".ORG      " & immpre & HexString(tmpaddy, 8) & vbCrLf
   End If
   PrevAddy = tmpaddy
   If (i = UBound(codes)) And (tmpvalue <> &H24000000) Then
    disout = disout & "*" & fmtAddy(Left(tmpcode, 8)) & "*" & AlignDis(Disassemble(tmpaddy, SLL(tmpvalue, 16))) & vbCrLf
    Exit For
   End If
   tmpcode2 = Trim(Replace(codes(i + 1), " ", ""))
   If ((tmpaddy Mod 4) = 0) And (FilterHexValues(tmpcode2) <> "0") And (Len(tmpcode2) = 12) Then
    tmpaddy2 = CLng("&H" & Mid(tmpcode2, 3, 6))
   Else
    tmpaddy2 = 0
   End If
   If tmpaddy = (tmpaddy2 - 2) Then
    tmpvalue2 = CLng("&H" & Mid(tmpcode2, 9))
    If chkPSX = 0 Then
     disout = disout & fmtAddy(Left(codes(i), 8)) & AlignDis(Disassemble(tmpaddy, (SLL(tmpvalue, 16) Or tmpvalue2))) & vbCrLf
    Else
     disout = disout & fmtAddy(Left(codes(i), 8)) & AlignDis(Disassemble(tmpaddy, (SLL(tmpvalue2, 16) Or tmpvalue))) & vbCrLf
    End If
    i = i + 1
   ElseIf (tmpaddy Mod 4 = 0) Or ((chkPSX.value = 1) And (tmpaddy Mod 4 = 2)) Then
    If (tmpvalue <> &H24000000) Then
    disout = disout & fmtAddy(Left(tmpcode, 8)) & AlignDis(Disassemble(tmpaddy, SLL(tmpvalue, 16))) & vbCrLf
    Else
    disout = disout & fmtAddy(Left(tmpcode, 8)) & "*" & AlignDis(Disassemble(tmpaddy, SLL(tmpvalue, 16))) & vbCrLf
    End If
   Else
    disout = disout & fmtAddy(Left(tmpcode, 8)) & "? (0x" & Hex(tmpvalue) & ")" & vbCrLf
   End If
  ElseIf (FilterHexValues(tmpcode) <> "0") And (Len(tmpcode) = 16) Then
   tmpaddy = CLng("&H" & Mid(tmpcode, 3, 6))
   tmpvalue = CLng("&H" & Mid(tmpcode, 9))
   If (tmpaddy Mod 4 = 0) Then
    disout = disout & fmtAddy(Left(codes(i), 8)) & AlignDis(Disassemble(tmpaddy, tmpvalue)) & vbCrLf
   Else
    disout = disout & fmtAddy(Left(tmpcode, 8)) & "? (0x" & Hex(tmpvalue) & ")" & vbCrLf
   End If
  Else
   disout = disout & codes(i) & vbCrLf
  End If
 Next
 txtDis.text = disout
End Sub
Private Sub cmbRegFMT_Click()
 WriteCFG "asmregfmt", cmbRegFMT.ListIndex
 Select Case cmbRegFMT.ListIndex
  Case 0: GPRnames = Split(LCase(GPRNameList1), ",")
  Case 1: GPRnames = Split(GPRNameList1, ",")
  Case 2: GPRnames = Split(GPRNameList2, ",")
  Case 3: GPRnames = Split(GPRNameList3, ",")
 End Select
End Sub
Private Sub txtCodes_Change()
 cmdSaveCodes.Enabled = CBool(Len(txtCodes.text))
 cmdClearCodes.Enabled = CBool(Len(txtCodes.text))
 cmdDisGS.Enabled = CBool(Len(txtCodes.text))
End Sub
Private Sub txtDis_Change()
 cmdSaveR4300i.Enabled = CBool(Len(txtDis.text))
 cmdClearASM.Enabled = CBool(Len(txtDis.text))
 cmdHTMLdis.Enabled = CBool(Len(txtDis.text))
 cmdCopyDis.Enabled = CBool(Len(txtDis.text))
End Sub
Private Sub cmdSaveCodes_Click()
 If cmdSaveCodes.Enabled Then SaveText txtCodes.text
End Sub
Private Sub cmdCopyDis_Click()
 Clipboard.SetText txtDis.text
End Sub
Private Sub cmdSaveR4300i_Click()
 If cmdSaveR4300i.Enabled Then SaveText txtDis.text
End Sub
Private Sub SaveText(text As String)
 Dim temphandle As Integer
 Dim txtfile As String
 temphandle = FreeFile
 If Not ChooseFile(txtfile, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
 Open (txtfile) For Output As #temphandle
 Print #temphandle, text
 Close #temphandle
End Sub
Private Sub cmdClearASM_Click()
 txtDis.text = ""
End Sub
Private Sub cmdClearCodes_Click()
 txtCodes.text = ""
End Sub
Private Sub cmdOpenCodes_Click()
 Dim tmpstring As String
 Dim temphandle As Integer
 temphandle = FreeFile
 If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 1) Then Exit Sub
 Open (tmpstring) For Input As #temphandle
 Do
  Line Input #temphandle, tmpstring
  txtCodes.text = txtCodes.text & tmpstring & vbCrLf
 Loop Until EOF(temphandle)
 Close #temphandle
End Sub
Private Sub txtDis_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveR4300i_Click
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenCodes_Click
 ElseIf (keycode = 65) And (shift = 2) Then 'CTRL+A
  txtDis.SelStart = 0
  txtDis.SelLength = Len(txtDis.text)
 End If
End Sub
Private Sub txtCodes_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveR4300i_Click
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenCodes_Click
 End If
End Sub
Private Sub chkShowAddys_Click()
 If chkShowAddys.value = 1 Then chkShowOrg.value = 0
End Sub
Private Sub chkShowOrg_Click()
 If chkShowOrg.value = 1 Then chkShowAddys.value = 0
End Sub
Private Function fmtAddy(ByVal address As String) As String
 If chkShowAddys.value = 1 Then
  fmtAddy = address & ": "
 Else
  fmtAddy = ""
 End If
End Function
Private Function AlignDis(ByVal distext As String) As String
 Dim tmpdis As String, tmpdis2() As String
 If chkAlignDis.value = 0 Then distext = CleanSPC(distext)
 AlignDis = distext
End Function
Private Sub cmdHTMLdis_Click()
 Dim tmpdis As String, tmpdis2() As String, dis() As String, disout As String
 Dim i As Integer
 disout = ""
 dis = Split(txtDis.text, vbCrLf)
 For i = 0 To UBound(dis)
  If dis(i) = "" Then GoTo HTMLnext
  tmpdis2 = Split(CleanSPC(dis(i)), " ")
  disout = disout & "<tr>" & vbCrLf & vbTab & "<td class=" & Chr(34) & "opcode" & Chr(34) & ">" & _
           tmpdis2(0) & "</td>" & vbCrLf & vbTab
  tmpdis2(0) = ""
  tmpdis = Trim(Join(tmpdis2, " "))
  disout = disout & "<td class=" & Chr(34) & "arguments" & Chr(34) & ">" & tmpdis & _
           "</td>" & vbCrLf & vbTab & "<td class=" & Chr(34) & "comments" & Chr(34) & _
           "></td>" & vbCrLf & "</tr>" & vbCrLf
HTMLnext:
 Next
 txtDis.text = disout
End Sub
