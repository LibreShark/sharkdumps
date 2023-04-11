VERSION 5.00
Begin VB.Form GE007TTcalc 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Goldeneye 007 Target Time Calculator"
   ClientHeight    =   2595
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4530
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2595
   ScaleWidth      =   4530
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   2760
      MaxLength       =   4
      TabIndex        =   1
      Text            =   "0000"
      Top             =   1080
      Width           =   855
   End
   Begin VB.TextBox txtTime 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   840
      MaxLength       =   6
      TabIndex        =   0
      Text            =   "000:00"
      Top             =   1080
      Width           =   1170
   End
   Begin VB.Label Label2 
      Caption         =   "Hex (7FFF Max):"
      Height          =   255
      Left            =   2760
      TabIndex        =   3
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Time (546:07 Max):"
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   840
      Width           =   1575
   End
End
Attribute VB_Name = "GE007TTcalc"
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
 OpenTools(8) = True
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(8) = False
End Sub
Private Sub txtTime_KeyPress(PressedKey As Integer)
 If (PressedKey < Asc("0")) Or (PressedKey > Asc("9")) Then PressedKey = 0
 If txtTime.SelLength <> 1 Then txtTime.SelLength = 1
 If txtTime.SelText = ":" Then
  txtTime.SelStart = txtTime.SelStart + 1
  txtTime.SelLength = 1
 End If
End Sub
Private Sub txtTime_Change()
 Dim tmplong As Long
 If (IsNumeric(Left(txtTime.text, 3))) And (IsNumeric(Mid(txtTime.text, 5))) Then
  tmplong = (CLng(Left(txtTime.text, 3)) * 60) + CLng(Mid(txtTime.text, 5))
  If tmplong > 32767 Then tmplong = 32767
  txtHex.text = String(4 - Len(Hex(tmplong)), "0") & Hex(tmplong)
 Else
  txtTime.text = "000:00"
 End If
End Sub
Private Sub txtHex_KeyPress(PressedKey As Integer)
 PressedKey = FilterHexKeys(PressedKey)
 If txtHex.SelLength <> 1 Then txtHex.SelLength = 1
End Sub
Private Sub txtHex_Change()
 Dim tmplong As Long
 Dim minutes As Long, seconds As Long
 If IsHex(txtHex.text) Then
  tmplong = CLng("&H" & txtHex.text)
  If (tmplong > 32767) Or (tmplong = 0) Then
   txtTime.text = "000:00"
  Else
   minutes = tmplong \ 60
   seconds = tmplong Mod 60
   txtTime.text = String(3 - Len(CStr(minutes)), "0") & minutes & ":" & _
                 String(2 - Len(CStr(seconds)), "0") & seconds
  End If
 Else
  txtHex.text = "0000"
 End If
End Sub

