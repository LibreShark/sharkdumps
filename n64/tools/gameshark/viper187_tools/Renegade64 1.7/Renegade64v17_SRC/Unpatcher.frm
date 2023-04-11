VERSION 5.00
Begin VB.Form Unpatcher 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Patch('50') Code Expander"
   ClientHeight    =   5100
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4350
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5100
   ScaleWidth      =   4350
   Begin VB.CommandButton cmdExpand 
      Caption         =   "Expand"
      Height          =   375
      Left            =   1680
      TabIndex        =   3
      Top             =   1320
      Width           =   855
   End
   Begin VB.TextBox txtExpanded 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Top             =   1920
      Width           =   2895
   End
   Begin VB.TextBox txtPatchCode 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1200
      MaxLength       =   28
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   600
      Width           =   1665
   End
   Begin VB.Label Label1 
      Caption         =   "Patch Code:"
      Height          =   255
      Left            =   1200
      TabIndex        =   1
      Top             =   360
      Width           =   1095
   End
End
Attribute VB_Name = "Unpatcher"
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
 OpenTools(10) = True
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(10) = False
End Sub
Private Sub cmdExpand_Click()
 Dim RPT As Long, AddyInc As Long, ValInc As Long
 Dim Prefix As Byte
 Dim addy As Long, value As Long
 Dim tmpstring As String
 Dim i As Integer
 tmpstring = Replace(Replace(txtPatchCode.text, Chr(32), ""), vbCrLf, "")
 If (Len(tmpstring) <> 24) Or (Left(tmpstring, 2) <> "50") Or _
    (IsHex(Left(tmpstring, 8)) = False) Or (IsHex(Mid(tmpstring, 9, 8)) = False) Or _
    (IsHex(Mid(tmpstring, 17, 8)) = False) Then
  MsgBox "How hard is it to paste in 2 fucking lines? Line 1 should be the '50' line. Then the 80/81/88/89/A0/A1/30 line. Easy, yes?"
  Exit Sub
 End If
 RPT = CLng("&H" & Mid(tmpstring, 3, 4))
 AddyInc = CLng("&H" & Mid(tmpstring, 7, 2))
 ValInc = CLng("&H" & Mid(tmpstring, 9, 4))
 Prefix = CByte("&H" & Mid(tmpstring, 13, 2))
 addy = CLng("&H" & Mid(tmpstring, 15, 6))
 value = CLng("&H" & Mid(tmpstring, 21, 4))
 i = 0
 tmpstring = ""
 Do
  i = i + 1
  tmpstring = tmpstring & Hex(Prefix) & String(6 - Len(Hex(addy)), "0") & Hex(addy) & _
              " " & String(4 - Len(Hex(value)), "0") & Hex(value) & vbCrLf
  addy = addy + AddyInc
  value = value + ValInc
 Loop While i < RPT
 txtExpanded.text = tmpstring
End Sub


