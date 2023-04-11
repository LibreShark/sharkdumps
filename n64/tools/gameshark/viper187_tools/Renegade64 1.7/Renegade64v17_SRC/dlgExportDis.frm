VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form dlgExportDis 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Export Disassembly"
   ClientHeight    =   4950
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4980
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4950
   ScaleWidth      =   4980
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog FileDlg 
      Left            =   4200
      Top             =   3960
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdDisTextCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2760
      TabIndex        =   12
      Top             =   4200
      Width           =   1095
   End
   Begin VB.CommandButton cmdDis2Text 
      Caption         =   "Disassemble"
      Height          =   375
      Left            =   1080
      TabIndex        =   11
      Top             =   4200
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Other Options"
      Height          =   1455
      Left            =   360
      TabIndex        =   8
      Top             =   2520
      Width           =   4215
      Begin VB.CheckBox chkShowDisVal 
         Caption         =   "Include Values"
         Height          =   195
         Left            =   240
         TabIndex        =   13
         Top             =   1080
         Value           =   1  'Checked
         Width           =   1575
      End
      Begin VB.CheckBox chkShowDisAddys 
         Caption         =   "Include Addresses"
         Height          =   195
         Left            =   240
         TabIndex        =   10
         Top             =   720
         Value           =   1  'Checked
         Width           =   1695
      End
      Begin VB.CheckBox chkAlignDis 
         Caption         =   "Align Text"
         Height          =   240
         Left            =   240
         TabIndex        =   9
         Top             =   360
         Value           =   1  'Checked
         Width           =   1695
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "GPR Display Type"
      Height          =   735
      Left            =   360
      TabIndex        =   6
      Top             =   1560
      Width           =   4215
      Begin VB.ComboBox cmbGPRDisType 
         Height          =   315
         ItemData        =   "dlgExportDis.frx":0000
         Left            =   1080
         List            =   "dlgExportDis.frx":0010
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   280
         Width           =   2295
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Range"
      Height          =   1095
      Left            =   360
      TabIndex        =   0
      Top             =   240
      Width           =   4215
      Begin VB.TextBox txtDisRangeHi 
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
         Left            =   2880
         MaxLength       =   8
         TabIndex        =   5
         Text            =   "0"
         Top             =   620
         Width           =   1050
      End
      Begin VB.TextBox txtDisRangeLo 
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
         Left            =   1200
         MaxLength       =   8
         TabIndex        =   3
         Text            =   "0"
         Top             =   620
         Width           =   1050
      End
      Begin VB.OptionButton optRangeCust 
         Caption         =   "Specify"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   650
         Width           =   975
      End
      Begin VB.OptionButton optRangeAll 
         Caption         =   "All"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   320
         Value           =   -1  'True
         Width           =   615
      End
      Begin VB.Label Label1 
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
         Left            =   2280
         TabIndex        =   4
         Top             =   600
         Width           =   495
      End
   End
End
Attribute VB_Name = "dlgExportDis"
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
 cmbGPRDisType.ListIndex = GetCFG("asmregfmt", 1, 1)
End Sub
Private Sub cmdDis2Text_Click()
 Dim align As Byte, showaddy As Byte
 Dim RangeLow As Long, RangeHigh As Long
 Dim xpfile As String
 If Not ChooseFile(xpfile, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
 align = chkAlignDis.value
 If (chkShowDisAddys.value = 1) And (chkShowDisVal.value = 1) Then
  showaddy = 2
 ElseIf (chkShowDisAddys.value = 1) Then
  showaddy = 1
 ElseIf (chkShowDisVal.value = 1) Then
  showaddy = 3
 Else
  showaddy = 0
 End If
' If align = 0 Then align = 2
' If showaddy = 0 Then showaddy = 3
 If optRangeAll.value Then
  RangeLow = 0
  RangeHigh = 0
 Else
  RangeLow = CLng("&H" & txtDisRangeLo.text)
  RangeHigh = CLng("&H" & txtDisRangeHi.text)
 End If
 Disassembler.ExportDis xpfile, (cmbGPRDisType.ListIndex + 1), align, _
                        showaddy, RangeLow, RangeHigh
 Unload dlgExportDis
End Sub
Private Sub cmdDisTextCancel_Click()
 Unload dlgExportDis
End Sub
Private Sub txtDisRangeLo_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdDis2Text_Click
 ElseIf PressedKey = 27 Then 'ESC
  cmdDisTextCancel_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtDisRangeLo_Change()
 txtDisRangeLo.text = FilterHexValues(txtDisRangeLo.text)
End Sub
Private Sub txtDisRangeHi_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdDis2Text_Click
 ElseIf PressedKey = 27 Then 'ESC
  cmdDisTextCancel_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtDisRangeHi_Change()
 txtDisRangeHi.text = FilterHexValues(txtDisRangeHi.text)
End Sub

