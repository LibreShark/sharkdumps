VERSION 5.00
Begin VB.Form dlgGoToASM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Goto Address"
   ClientHeight    =   1950
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3720
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1950
   ScaleWidth      =   3720
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancelGoTo 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2040
      TabIndex        =   3
      Top             =   1200
      Width           =   735
   End
   Begin VB.CommandButton cmdGoTo 
      Caption         =   "Go"
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Top             =   1200
      Width           =   735
   End
   Begin VB.TextBox txtGoToAddy 
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
      TabIndex        =   0
      Text            =   "0"
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Address:"
      Height          =   255
      Left            =   600
      TabIndex        =   1
      Top             =   480
      Width           =   735
   End
End
Attribute VB_Name = "dlgGoToASM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
 Dim tmpinfo() As String
 If Disassembler.lstASM.ListIndex >= 0 Then
  tmpinfo = Split(Disassembler.lstASM.List(Disassembler.lstASM.ListIndex), "  ")
 ElseIf Disassembler.lstASM.ListCount > 0 Then
  tmpinfo = Split(Disassembler.lstASM.List(0), "  ")
 End If
  txtGoToAddy.text = tmpinfo(0)
End Sub
Private Sub cmdGoTo_Click()
 Dim tmpaddy As Long
 tmpaddy = CLng("&H" & txtGoToAddy.text)
 If (tmpaddy + 1) < LOF(ROMhandle) Then
  Disassembler.GoToPage tmpaddy
 End If
 Unload dlgGoToASM
End Sub
Private Sub cmdCancelGoto_Click()
 Unload dlgGoToASM
End Sub
Private Sub txtGoToAddy_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then 'Enter
  cmdGoTo_Click
 ElseIf PressedKey = 27 Then 'ESC
  cmdCancelGoto_Click
 ElseIf PressedKey <> 8 Then
  PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtGoToAddy_Change()
 txtGoToAddy.text = FilterHexValues(txtGoToAddy.text)
End Sub
