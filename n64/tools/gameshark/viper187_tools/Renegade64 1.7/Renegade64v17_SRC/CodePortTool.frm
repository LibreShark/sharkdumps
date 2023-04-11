VERSION 5.00
Begin VB.Form CodePortTool 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Porter"
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
   Begin VB.CheckBox chkCopy 
      Caption         =   "Auto Copy"
      Height          =   255
      Left            =   3600
      TabIndex        =   13
      Top             =   4800
      Width           =   1215
   End
   Begin VB.CommandButton cmdCopyCodes 
      Caption         =   "Copy"
      Height          =   255
      Left            =   2520
      TabIndex        =   12
      Top             =   4800
      Width           =   735
   End
   Begin VB.CommandButton cmdSaveCodes 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1560
      TabIndex        =   11
      ToolTipText     =   "Ctrl+S"
      Top             =   4800
      Width           =   735
   End
   Begin VB.CommandButton cmdOpenCodes 
      Caption         =   "Open"
      Height          =   255
      Left            =   1920
      TabIndex        =   10
      ToolTipText     =   "Ctrl+O"
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdClearInput 
      Caption         =   "Clear Input"
      Enabled         =   0   'False
      Height          =   315
      Left            =   10080
      TabIndex        =   8
      Top             =   4080
      Width           =   1095
   End
   Begin VB.ComboBox cmbMath 
      Height          =   315
      ItemData        =   "CodePortTool.frx":0000
      Left            =   1320
      List            =   "CodePortTool.frx":000A
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   4200
      Width           =   975
   End
   Begin VB.CheckBox chkDtype 
      Caption         =   "Ignore D0/D1 Codes"
      Height          =   255
      Left            =   5040
      TabIndex        =   3
      Top             =   4200
      Width           =   2055
   End
   Begin VB.CommandButton cmdPort 
      Caption         =   "Port"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Top             =   4155
      Width           =   1095
   End
   Begin VB.TextBox txtCodesOut 
      Height          =   3495
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   4
      Top             =   5040
      Width           =   10455
   End
   Begin VB.TextBox txtOffSet 
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
      TabIndex        =   2
      Text            =   "0"
      Top             =   4200
      Width           =   810
   End
   Begin VB.TextBox txtCodesIn 
      Height          =   3615
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   360
      Width           =   10455
   End
   Begin VB.Label Label3 
      Caption         =   "Output:"
      Height          =   255
      Left            =   720
      TabIndex        =   9
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Codes Input:"
      Height          =   255
      Left            =   720
      TabIndex        =   7
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Offset:"
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   4230
      Width           =   615
   End
End
Attribute VB_Name = "CodePortTool"
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
 cmbMath.ListIndex = 0
 chkCopy.value = GetCFG("codeport_autocpy", 1, 0)
 OpenTools(2) = True
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(2) = False
End Sub
Private Sub cmdPort_Click()
 Dim i As Integer, e As Integer
 Dim offset As Long
 Dim tmpcode As Long
 Dim codes As String
 Dim ported As String
 Dim tmpstring As String
 Dim cTypes() As String
 tmpstring = "80,81,88,89,A0,A1,30,00,10,11,20,21,D0,D1,D2,D3,E0,E1,E2,E3"
 cTypes = Split(tmpstring, ",")
 If txtCodesIn = "" Then Exit Sub
 codes = txtCodesIn.text
 ported = ""
 offset = CLng("&H" & txtOffSet.text)
 If cmbMath.ListIndex = 1 Then offset = 0 - offset
 For e = 0 To UBound(cTypes)
  If (cTypes(e) = "D0") And (chkDtype.value = 1) Then Exit For
  Do
   i = InStr(UCase(codes), cTypes(e))
   If i > 0 Then
    tmpstring = Mid(codes, i + 2, 6)
    If (IsHex(tmpstring)) And (Mid(codes, i + 8, 1) = " ") And _
       ((IsHex(Mid(codes, i + 9, 4))) Or (InStr(Mid(codes, i + 9, 4), "??")) Or _
       (InStr(Mid(codes, i + 9, 4), "0?")) Or (InStr(UCase(Mid(codes, i + 9, 4)), "XX"))) Then
     ported = ported & Left(codes, i - 1) & UCase(Mid(codes, i, 2))
     tmpcode = CLng("&H" & tmpstring) + offset
     ported = ported & String(6 - Len(Hex(tmpcode)), "0") & Hex(tmpcode)
     codes = Mid(codes, i + 8)
    Else
     ported = ported & Left(codes, i + 1)
     codes = Mid(codes, i + 2)
    End If
   End If
  Loop While i > 0
  If ported <> "" Then
   codes = ported & codes
   ported = ""
  End If
 Next
 txtCodesOut.text = codes
 If chkCopy.value = 1 Then Clipboard.SetText codes
End Sub
Private Sub txtOffSet_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdPort_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtOffSet_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtOffSet.text = Clipboard.GetText
 End If
End Sub
Private Sub txtOffSet_Change()
 txtOffSet.text = FilterHexValues(txtOffSet.text)
End Sub
Private Sub cmdClearInput_Click()
 txtCodesIn.text = ""
End Sub
Private Sub txtCodesIn_Change()
 cmdClearInput.Enabled = CBool(Len(txtCodesIn.text))
 cmdPort.Enabled = CBool(Len(txtCodesIn.text))
End Sub
Private Sub txtCodesOut_Change()
 cmdSaveCodes.Enabled = CBool(Len(txtCodesOut.text))
End Sub
Private Sub cmdSaveCodes_Click()
 If cmdSaveCodes.Enabled Then SaveText txtCodesOut.text
End Sub
Private Sub SaveText(text As String)
 Dim temphandle As Integer
 Dim tmpstring As String
 temphandle = FreeFile
 If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
 Open (tmpstring) For Output As #temphandle
 Print #temphandle, text
 Close #temphandle
End Sub
Private Sub cmdOpenCodes_Click()
 Dim tmpstring As String
 Dim temphandle As Integer
 temphandle = FreeFile
 If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 1) Then Exit Sub
 Open (tmpstring) For Input As #temphandle
 Do
  Line Input #temphandle, tmpstring
  txtCodesIn.text = txtCodesIn.text & tmpstring & vbCrLf
 Loop Until EOF(temphandle)
 Close #temphandle
End Sub
Private Sub txtCodesIn_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenCodes_Click
 End If
End Sub
Private Sub txtCodesOut_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenCodes_Click
 ElseIf (keycode = 65) And (shift = 2) Then 'CTRL+A
  txtCodesOut.SelStart = 0
  txtCodesOut.SelLength = Len(txtCodesOut.text)
 End If
End Sub
Private Sub cmdCopyCodes_Click()
 Clipboard.SetText txtCodesOut.text
End Sub
Private Sub chkCopy_Click()
 WriteCFG "codeport_autocpy", chkCopy.value
End Sub
