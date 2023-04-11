VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form dlgOptionsCS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Search Options"
   ClientHeight    =   3585
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6360
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3585
   ScaleWidth      =   6360
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtMaxResDisp 
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
      Left            =   4920
      MaxLength       =   5
      TabIndex        =   11
      Top             =   2040
      Width           =   1215
   End
   Begin MSComDlg.CommonDialog FileDlg 
      Left            =   120
      Top             =   2880
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.TextBox txtTextEditor 
      BackColor       =   &H80000011&
      Height          =   285
      Left            =   1800
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   1560
      Width           =   3975
   End
   Begin VB.TextBox txtResPath 
      BackColor       =   &H80000011&
      Height          =   285
      Left            =   2520
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   1080
      Width           =   3015
   End
   Begin VB.CommandButton cmdCancelOptions 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3360
      TabIndex        =   5
      Top             =   3000
      Width           =   1095
   End
   Begin VB.CommandButton cmdSaveOptions 
      Caption         =   "Ok"
      Height          =   375
      Left            =   1680
      TabIndex        =   4
      Top             =   3000
      Width           =   1095
   End
   Begin VB.ComboBox cmbResFMT 
      Height          =   315
      ItemData        =   "dlgOptionsCS.frx":0000
      Left            =   2520
      List            =   "dlgOptionsCS.frx":001F
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   600
      Width           =   3375
   End
   Begin VB.TextBox txtResMax 
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
      Left            =   4440
      TabIndex        =   1
      Text            =   "1000"
      Top             =   240
      Width           =   1305
   End
   Begin VB.CheckBox chkAutoRes 
      Caption         =   "Automatically display results when there's less than:"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   240
      Value           =   1  'Checked
      Width           =   3975
   End
   Begin VB.Label Label4 
      Caption         =   "Maximum Results Shown In Results Window (0 - 32767):"
      Height          =   255
      Left            =   600
      TabIndex        =   10
      Top             =   2040
      Width           =   4095
   End
   Begin VB.Label Label3 
      Caption         =   "Text Editor:"
      Height          =   255
      Left            =   600
      TabIndex        =   8
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Search Results Path:"
      Height          =   255
      Left            =   600
      TabIndex        =   7
      Top             =   1080
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "Default Result Export Format:"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   600
      Width           =   2415
   End
End
Attribute VB_Name = "dlgOptionsCS"
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
Private Sub Form_Load()
 txtResPath.text = GetCFG("respath", 3, DefaultResPath)
' cmbResFMT.ListIndex = GetCFG("resfmt", 1, 6)
 txtResMax.text = GetCFG("resmax", 1, 1000)
 chkAutoRes.value = GetCFG("autores", 1, 1)
 txtTextEditor.text = GetCFG("cs_texteditor", 3, DefaultTextEditor)
 txtMaxResDisp.text = GetCFG("maxresdisp", 1, DefaultResDispMax)
' txtPrevRes.text = GetCFG("prevres", 1, 2)
 Select Case GetCFG("resfmt", 1, 1)
  Case 1: cmbResFMT.ListIndex = 0
  Case 2: cmbResFMT.ListIndex = 1
  Case 3: cmbResFMT.ListIndex = 2
  Case 4: cmbResFMT.ListIndex = 3
  Case 5: cmbResFMT.ListIndex = 4
  Case 6: cmbResFMT.ListIndex = 5
  Case 7: cmbResFMT.ListIndex = 6
  Case 8: cmbResFMT.ListIndex = 7
  Case 13: cmbResFMT.ListIndex = 8
 End Select
End Sub
Private Sub cmdSaveOptions_Click()
 If Right(txtResPath.text, 1) <> "\" Then txtResPath.text = txtResPath.text & "\"
 If Dir$(txtResPath.text, vbDirectory) = "" Then
  MsgBox "Results path doesn't seem to exist", vbOKOnly
  Exit Sub
 End If
 WriteCFG "respath", txtResPath.text, DefaultResPath
 WriteCFG "resmax", txtResMax.text, 1000
 WriteCFG "autores", chkAutoRes.value
 WriteCFG "cs_texteditor", txtTextEditor.text, DefaultTextEditor
 WriteCFG "maxresdisp", txtMaxResDisp.text, DefaultResDispMax
' WriteCFG "prevres", txtPrevRes.text, 2
 Select Case cmbResFMT.ListIndex
  Case 0: WriteCFG "resfmt", 1
  Case 1: WriteCFG "resfmt", 2
  Case 2: WriteCFG "resfmt", 3
  Case 3: WriteCFG "resfmt", 4
  Case 4: WriteCFG "resfmt", 5
  Case 5: WriteCFG "resfmt", 6
  Case 6: WriteCFG "resfmt", 7
  Case 7: WriteCFG "resfmt", 8
  Case 8: WriteCFG "resfmt", 13
 End Select
 Unload dlgOptionsCS
End Sub
Private Sub cmdCancelOptions_Click()
 Unload dlgOptionsCS
End Sub
Private Sub txtResMax_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
End Sub
Private Sub txtResMax_Change()
 If IsNumeric(txtResMax.text) = False Then txtResMax.text = "0"
End Sub
Private Sub txtMaxResDisp_KeyPress(PressedKey As Integer)
 If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
End Sub
Private Sub txtMaxResDisp_Change()
 If IsNumeric(txtMaxResDisp.text) = False Then txtMaxResDisp.text = "0"
 If CLng(txtMaxResDisp.text) > 32767 Then txtMaxResDisp.text = "32767"
End Sub
Private Sub txtTextEditor_Click()
 If Not ChooseFile(txtTextEditor.text, "Programs (*.exe)|*.exe", 1) Then txtTextEditor.text = DefaultTextEditor
End Sub
Private Sub txtResPath_Click()
 Dim tmpstring As String
 'DlgSetResPath.Show vbModal
 tmpstring = GetDirectory("Choose Results Folder")
 If tmpstring <> "" Then txtResPath.text = tmpstring
End Sub
