VERSION 5.00
Begin VB.Form HexCalc 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Hex Calculator"
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
   Begin VB.CommandButton cmdSRL 
      Caption         =   ">>"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6360
      TabIndex        =   15
      Top             =   3480
      Width           =   735
   End
   Begin VB.CommandButton cmdSLL 
      Caption         =   "<<"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6360
      TabIndex        =   14
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton cmdNOT 
      Caption         =   "NOT"
      Height          =   375
      Left            =   5160
      TabIndex        =   13
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton cmdXOR 
      Caption         =   "XOR"
      Height          =   375
      Left            =   4080
      TabIndex        =   12
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton cmdOR 
      Caption         =   "OR"
      Height          =   375
      Left            =   3000
      TabIndex        =   11
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton cmdAND 
      Caption         =   "AND"
      Height          =   375
      Left            =   1920
      TabIndex        =   10
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton cmdMult 
      Caption         =   "*"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6360
      TabIndex        =   9
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton cmdMod 
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5160
      TabIndex        =   8
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton cmdDiv 
      Caption         =   "/"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4080
      TabIndex        =   7
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton cmdSub 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3000
      TabIndex        =   6
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1920
      TabIndex        =   5
      Top             =   1800
      Width           =   735
   End
   Begin VB.TextBox txtResult 
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5880
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox txtVar2 
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
      Left            =   3720
      MaxLength       =   8
      TabIndex        =   1
      Text            =   "0"
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox txtVar1 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1560
      MaxLength       =   8
      TabIndex        =   0
      Text            =   "0"
      Top             =   840
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "="
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   24
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5400
      TabIndex        =   3
      Top             =   750
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "<=>"
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   13.5
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3165
      TabIndex        =   2
      Top             =   900
      Width           =   495
   End
End
Attribute VB_Name = "HexCalc"
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
Private Sub txtVar1_Keypress(PressedKey As Integer)
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtVar1_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 67) And (shift = 2) Then 'CTRL+C
  Clipboard.SetText txtVar1.text
 ElseIf (keycode = 88) And (shift = 2) Then 'CTRL+X
  Clipboard.SetText txtVar1.text
  txtVar1.text = "0"
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtVar1.text = FilterHexValues(Clipboard.GetText)
 End If
End Sub
Private Sub txtVar2_Keypress(PressedKey As Integer)
 If PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtVar2_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 67) And (shift = 2) Then 'CTRL+C
  Clipboard.SetText txtVar2.text
 ElseIf (keycode = 88) And (shift = 2) Then 'CTRL+X
  Clipboard.SetText txtVar2.text
  txtVar2.text = "0"
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtVar2.text = FilterHexValues(Clipboard.GetText)
 End If
End Sub
Private Sub txtVar1_Change()
 txtVar1.text = FilterHexValues(txtVar1.text)
End Sub
Private Sub txtVar2_Change()
 txtVar2.text = FilterHexValues(txtVar2.text)
End Sub
Private Sub cmdAdd_Click() 'overflows
 txtResult.text = ""
 On Error Resume Next
 txtResult.text = Hex(CLng("&H" & txtVar1.text) + CLng("&H" & txtVar2.text))
 If txtResult.text = "" Then MsgBox "Overflow", vbOKOnly, "Error"
End Sub
Private Sub cmdSub_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) - CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdDiv_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) \ CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdMod_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) Mod CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdMult_Click()
 txtResult.text = ""
 On Error Resume Next
 txtResult.text = Hex(CLng("&H" & txtVar1.text) * CLng("&H" & txtVar2.text))
 If txtResult.text = "" Then MsgBox "Overflow", vbOKOnly, "Error"
End Sub
Private Sub cmdAND_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) And CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdOR_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) Or CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdXOR_Click()
 txtResult.text = Hex(CLng("&H" & txtVar1.text) Xor CLng("&H" & txtVar2.text))
End Sub
Private Sub cmdNOT_Click()
 txtResult.text = Hex(Not CLng("&H" & txtVar1.text))
End Sub
Private Sub cmdSLL_Click()
 txtResult.text = Hex(SLL(CLng("&H" & txtVar1.text), CLng("&H" & txtVar2.text)))
End Sub
Private Sub cmdSRL_Click()
 txtResult.text = Hex(SRL(CLng("&H" & txtVar1.text), CLng("&H" & txtVar2.text)))
End Sub

