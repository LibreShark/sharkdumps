VERSION 5.00
Begin VB.Form ByteSwapTool 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Byteswap Tool"
   ClientHeight    =   5505
   ClientLeft      =   150
   ClientTop       =   240
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5505
   ScaleWidth      =   7200
   Begin VB.Frame Frame4 
      Caption         =   "Presests"
      Height          =   855
      Left            =   2520
      TabIndex        =   12
      Top             =   240
      Width           =   2055
      Begin VB.ComboBox cmbPresets 
         Height          =   315
         ItemData        =   "ByteSwapTool.frx":0000
         Left            =   240
         List            =   "ByteSwapTool.frx":0007
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   360
         Width           =   1575
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Range"
      Height          =   1215
      Left            =   1440
      TabIndex        =   6
      Top             =   2640
      Width           =   4215
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
         Left            =   2740
         MaxLength       =   8
         TabIndex        =   10
         Text            =   "0"
         Top             =   720
         Width           =   1095
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
         Left            =   1320
         MaxLength       =   8
         TabIndex        =   9
         Text            =   "0"
         Top             =   720
         Width           =   1095
      End
      Begin VB.OptionButton optRangeSet 
         Caption         =   "Choose"
         Height          =   255
         Left            =   240
         TabIndex        =   8
         Top             =   720
         Width           =   975
      End
      Begin VB.OptionButton OptRangeAll 
         Caption         =   "All"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Value           =   -1  'True
         Width           =   975
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   18
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2400
         TabIndex        =   11
         Top             =   720
         Width           =   375
      End
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3480
      TabIndex        =   5
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton cmdSwap 
      Caption         =   "Byteswap"
      Height          =   375
      Left            =   1920
      TabIndex        =   4
      Top             =   4560
      Width           =   975
   End
   Begin VB.Frame Frame2 
      Caption         =   "Destination Format"
      Height          =   855
      Left            =   3720
      TabIndex        =   2
      Top             =   1560
      Width           =   2535
      Begin VB.ComboBox cmbDestFMT 
         Height          =   315
         ItemData        =   "ByteSwapTool.frx":0017
         Left            =   240
         List            =   "ByteSwapTool.frx":0024
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   360
         Width           =   2055
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Source Format"
      Height          =   855
      Left            =   840
      TabIndex        =   0
      Top             =   1560
      Width           =   2535
      Begin VB.ComboBox cmbSourceFMT 
         Height          =   315
         ItemData        =   "ByteSwapTool.frx":0073
         Left            =   240
         List            =   "ByteSwapTool.frx":0080
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   360
         Width           =   2055
      End
   End
End
Attribute VB_Name = "ByteSwapTool"
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
 cmbSourceFMT.ListIndex = 0
 cmbDestFMT.ListIndex = 0
 OpenTools(1) = True
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(1) = False
End Sub
Private Sub cmdSwap_Click()
 Dim errnumber As Long
 Dim fmt As Byte
 Dim RangeLO As Long, RangeHi As Long
 Dim src As String, dest As String
 If cmbSourceFMT.ListIndex = cmbDestFMT.ListIndex Then
  fmt = 0
'  MsgBox "Uh, if the source and destination format are the same, guess what??? You aren't fuckin doing anything!", vbOKOnly
'  Exit Sub
 Else
  fmt = cmbSourceFMT.ListIndex + cmbDestFMT.ListIndex
 End If
 RangeLO = CLng("&H" & txtRangeLo.text)
 RangeHi = CLng("&H" & txtRangeHi.text)
 If (RangeLO >= RangeHi) Then RangeHi = 0
 If (optRangeAll.value = True) Then
  RangeLO = 0
  RangeHi = 0
 End If
 If Not ChooseFile(src, "Source ROM (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur|PJ64 Save States (*.pj)|*.pj|All Files (*.*)|*", 1) Then Exit Sub
 If Not ChooseFile(dest, "Destination ROM (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur|All Files (*.*)|*", 0) Then Exit Sub
 errnumber = CopyFileBytes(src, dest, fmt, RangeLO, RangeHi)
 If errnumber <> 0 Then
  ShowDLLError errnumber
  Exit Sub
 End If
End Sub
Private Sub cmdCancel_Click()
 Unload ByteSwapTool
End Sub
Private Sub cmbPresets_Click()
 Select Case cmbPresets.ListIndex
  Case 0 'PJ64 > Bin
   optRangeSet.value = True
   txtRangeLo.text = "75C"
   txtRangeHi.text = "0"
   cmbSourceFMT.ListIndex = 2
   cmbDestFMT.ListIndex = 0
 End Select
End Sub
