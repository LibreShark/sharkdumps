VERSION 5.00
Begin VB.Form ActWriter 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Activator Tool"
   ClientHeight    =   7200
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9600
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   480
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   640
   Begin VB.TextBox txtActList 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   1680
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   8
      Top             =   2400
      Width           =   6135
   End
   Begin VB.CommandButton cmdPrintAct 
      Caption         =   "Make List"
      Height          =   375
      Left            =   6480
      TabIndex        =   7
      Top             =   1200
      Width           =   975
   End
   Begin VB.CheckBox chkStick16 
      Caption         =   "16-Bit Stick"
      Height          =   255
      Left            =   1800
      TabIndex        =   6
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox txtActNum 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   5040
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1320
      Width           =   495
   End
   Begin VB.TextBox txtActOffset 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3960
      MaxLength       =   2
      TabIndex        =   2
      Top             =   1320
      Width           =   495
   End
   Begin VB.TextBox txtActAddy 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1800
      MaxLength       =   8
      TabIndex        =   0
      Top             =   1320
      Width           =   1575
   End
   Begin VB.Label Label3 
      Caption         =   "#"
      Height          =   255
      Left            =   5040
      TabIndex        =   5
      Top             =   1080
      Width           =   255
   End
   Begin VB.Label Label2 
      Caption         =   "Offset"
      Height          =   255
      Left            =   3960
      TabIndex        =   3
      Top             =   1080
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "Address"
      Height          =   255
      Left            =   1800
      TabIndex        =   1
      Top             =   1080
      Width           =   735
   End
End
Attribute VB_Name = "ActWriter"
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
Private Sub cmdPrintAct_Click()
 Dim ActStart As Long, offset As Long
 Dim i As Integer
 Dim actnum As String, StickActs As String
 StickActs = ""
 txtActAddy_Change
 txtActOffset_Change
 txtActNum_Change
 ActStart = (CLng("&H" & txtActAddy.text) And &HD0FFFFFF) Or &HD0000000
 offset = CLng("&H" & txtActOffset.text)
 actnum = ""
 If txtActNum.text <> "0" Then actnum = " #" & txtActNum.text
 txtActList.text = ""
 For i = 0 To 4
  txtActList.text = txtActList.text & "Activator 1 P" & i + 1 & actnum & vbCrLf & _
                    Hex(ActStart + (i * offset)) & " 00??" & vbCrLf & vbCrLf & "Activator 2 P" & _
                    i + 1 & actnum & vbCrLf & Hex(ActStart + 1 + (i * offset)) & " 00??" & _
                    vbCrLf & vbCrLf & "Dual Activator P" & i + 1 & actnum & vbCrLf & _
                    Hex((ActStart Or &H1000000) + (i * offset)) & " ????" & vbCrLf & vbCrLf
  If chkStick16.value Then
   StickActs = StickActs & "Control Stick Activator 1 P" & i + 1 & actnum & vbCrLf & _
               Hex((ActStart Or &H1000000) + 2 + (i * offset)) & " ????" & vbCrLf & vbCrLf & _
               "Control Stick Activator 2 P" & i + 1 & actnum & vbCrLf & _
               Hex((ActStart Or &H1000000) + 4 + (i * offset)) & " ????" & vbCrLf & vbCrLf
  Else
  StickActs = StickActs & "Control Stick Activator 1 P" & i + 1 & actnum & vbCrLf & _
              Hex(ActStart + 2 + (i * offset)) & " 00??" & vbCrLf & vbCrLf & _
              "Control Stick  Activator 2 P" & i + 1 & actnum & vbCrLf & _
              Hex(ActStart + 3 + (i * offset)) & " 00??" & vbCrLf & vbCrLf & _
              "Dual Control Stick Activator P" & i + 1 & actnum & vbCrLf & _
              Hex((ActStart Or &H1000000) + 2 + (i * offset)) & " ????" & vbCrLf & vbCrLf
  End If
 Next
 txtActList.text = txtActList.text & StickActs
End Sub
Private Sub txtActAddy_Keypress(PressedKey As Integer)
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtActAddy_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 67) And (shift = 2) Then 'CTRL+C
  Clipboard.SetText txtActAddy.text
 ElseIf (keycode = 88) And (shift = 2) Then 'CTRL+X
  Clipboard.SetText txtActAddy.text
  txtActAddy.text = "0"
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtActAddy.text = FilterHexValues(Clipboard.GetText)
 End If
End Sub
Private Sub txtActAddy_Change()
 txtActAddy.text = FilterHexValues(txtActAddy.text)
End Sub
Private Sub txtActOffset_Keypress(PressedKey As Integer)
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtActOffset_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 67) And (shift = 2) Then 'CTRL+C
  Clipboard.SetText txtActOffset.text
 ElseIf (keycode = 88) And (shift = 2) Then 'CTRL+X
  Clipboard.SetText txtActOffset.text
  txtActOffset.text = "0"
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtActOffset.text = FilterHexValues(Clipboard.GetText)
 End If
End Sub
Private Sub txtActOffset_Change()
 txtActOffset.text = FilterHexValues(txtActOffset.text)
End Sub
Private Sub txtActNum_KeyPress(PressedKey As Integer)
 If ((PressedKey < Asc("0")) Or (PressedKey > Asc("9"))) And PressedKey <> 8 Then PressedKey = 0
End Sub
Private Sub txtActNum_Change()
 If IsNumeric(txtActNum.text) = False Then txtActNum.text = "0"
End Sub
