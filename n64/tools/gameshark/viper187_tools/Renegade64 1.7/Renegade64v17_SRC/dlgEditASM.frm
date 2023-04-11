VERSION 5.00
Begin VB.Form dlgEditASM 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edit"
   ClientHeight    =   3090
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   5430
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3090
   ScaleWidth      =   5430
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox chkPseudoWarn 
      Caption         =   "Warn about multi-line Pseudo OPs"
      Height          =   255
      Left            =   0
      TabIndex        =   17
      Top             =   0
      Width           =   2895
   End
   Begin VB.CommandButton cmdSetASM 
      Caption         =   "Set"
      Height          =   375
      Left            =   3360
      TabIndex        =   16
      Top             =   360
      Width           =   855
   End
   Begin VB.CheckBox chkAutoSet 
      Caption         =   "Auto-Set on Scroll"
      Height          =   195
      Left            =   1080
      TabIndex        =   15
      Top             =   720
      Width           =   1575
   End
   Begin VB.CommandButton cmdNextAddy 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2400
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   360
      Width           =   255
   End
   Begin VB.CommandButton cmdPrevAddy 
      Caption         =   "<"
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2160
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   360
      Width           =   255
   End
   Begin VB.CommandButton cmdRevertEdit 
      Caption         =   "Revert"
      Enabled         =   0   'False
      Height          =   375
      Left            =   4320
      TabIndex        =   12
      Top             =   1320
      Width           =   855
   End
   Begin VB.CommandButton cmdCancelEdit 
      Caption         =   "Close"
      Height          =   375
      Left            =   4320
      TabIndex        =   11
      Top             =   840
      Width           =   855
   End
   Begin VB.CommandButton cmdDoEdit 
      Caption         =   "Ok"
      Height          =   375
      Left            =   4320
      TabIndex        =   10
      Top             =   360
      Width           =   855
   End
   Begin VB.TextBox txtDefaultOP 
      BackColor       =   &H8000000F&
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
      Left            =   1680
      Locked          =   -1  'True
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2520
      Width           =   3015
   End
   Begin VB.TextBox txtDefaultVal 
      BackColor       =   &H8000000F&
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
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2520
      Width           =   1095
   End
   Begin VB.TextBox txtOP 
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
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Width           =   3255
   End
   Begin VB.TextBox txtValue 
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
      Left            =   120
      MaxLength       =   8
      TabIndex        =   3
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox txtAddress 
      BackColor       =   &H8000000F&
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
      Left            =   1080
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   360
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "Original Opcode:"
      Height          =   255
      Left            =   1680
      TabIndex        =   8
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Original Value:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Opcode:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Value:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   360
      Width           =   735
   End
End
Attribute VB_Name = "dlgEditASM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
 Dim tmpinfo() As String
 tmpinfo = Split(Disassembler.lstASM.List(Disassembler.lstASM.ListIndex), Space(2))
 SetupForm CLng("&H" & tmpinfo(0))
 chkAutoSet.value = GetCFG("editasm_autoset", 1, 0)
 chkPseudoWarn.value = GetCFG("editasm_pseudowarn", 1, 1)
End Sub
Private Sub Form_Unload(cancel As Integer)
 WriteCFG "editasm_autoset", chkAutoSet.value
 WriteCFG "editasm_pseudowarn", chkPseudoWarn.value
 Disassembler.RefreshPage
End Sub
Private Sub KillForm()
Unload dlgEditASM
End Sub
Private Sub SetupForm(ByVal tmpaddy As Long)
 Dim tmpvalue As Long
 txtAddress.text = HexString(tmpaddy, 8)
 Get #ROMhandle, tmpaddy + 1, tmpvalue
 tmpvalue = FlipWord(tmpvalue, ROMendian)
 txtDefaultVal.text = HexString(tmpvalue, 8)
 txtDefaultOP.text = CleanSPC(Disassemble(tmpaddy, tmpvalue))
 If GetAddyFlag(tmpaddy) Then
  tmpvalue = GetData(tmpaddy)
  cmdRevertEdit.Enabled = True
 Else
  cmdRevertEdit.Enabled = False
 End If
 txtValue.text = HexString(tmpvalue, 8)
 txtOP.text = CleanSPC(Disassemble(tmpaddy, tmpvalue))
 cmdSetASM.Enabled = False
End Sub
Private Sub cmdCancelEdit_Click()
 KillForm
End Sub
Private Sub cmdRevertEdit_Click()
 Dim tmpaddy As Long
 Dim tmpvalue As Long
 tmpaddy = CLng("&H" & txtAddress.text)
 SetAddyFlag tmpaddy, 0
 SetupForm tmpaddy
End Sub
Private Sub cmdDoEdit_Click()
 cmdSetASM_Click
 KillForm
End Sub
Private Sub cmdSetASM_Click()
 Dim tmpaddy As Long
 Dim tmpvalue As Long
 Dim i As Integer, ops As Integer
 cmdSetASM.Enabled = False
 tmpaddy = CLng("&H" & txtAddress.text)
 tmpvalue = CLng("&H" & txtValue.text)
  If MakeOp(tmpaddy, UCase(txtOP.text)) Then
   If CLng("&H" & txtDefaultVal.text) = AssembledOP(0) Then
    SetAddyFlag tmpaddy, 0
   Else
    ops = 0
    If AssembledOP(1) <> -1 Then
     If chkPseudoWarn.value = 1 Then
      i = MsgBox("This opcode is a pseudo op. It changes more than 1 op. Are You sure?", vbYesNo)
      If i = vbNo Then
       txtAddress.text = HexString(tmpaddy - 4, 8)
       Exit Sub
      End If
     End If
     For i = 1 To UBound(AssembledOP)
      If AssembledOP(i) <> -1 Then
       If (tmpaddy + (i * 4)) > LOF(ROMhandle) Then
        MsgBox "Opcode writing incomplete. Operation would exceed end of file.", vbOKOnly
        Exit Sub
       End If
       SetData tmpaddy + (i * 4), AssembledOP(i)
       SetAddyFlag tmpaddy + (i * 4), 1
       ops = ops + 1
      End If
     Next
    End If
    SetData tmpaddy, AssembledOP(0)
    SetAddyFlag tmpaddy, 1
    Disassembler.DirtyDis True
    tmpaddy = tmpaddy + (ops * 4)
    txtAddress.text = HexString(tmpaddy, 8)
   End If
'   KillForm
  Else
   If (txtOP.text = "?") Or (txtOP.text = "") Then
    If CLng("&H" & txtDefaultVal.text) = tmpvalue Then
     SetAddyFlag tmpaddy, 0
    Else
    SetData tmpaddy, tmpvalue
    SetAddyFlag tmpaddy, 1
    Disassembler.DirtyDis True
    End If
'    KillForm
   Else
   MsgBox ASMerror, vbOKOnly
   End If
  End If
' KillForm
End Sub
Private Sub txtValue_KeyPress(PressedKey As Integer)
 If PressedKey = 8 Then
  If txtValue.SelLength <> 1 Then
   If txtValue.SelStart >= 1 Then txtValue.SelStart = txtValue.SelStart - 1
   txtValue.SelLength = 1
  End If
  txtValue.SelText = "0"
  If txtValue.SelStart >= 2 Then
   txtValue.SelStart = txtValue.SelStart - 2
  Else
   txtValue.SelStart = 0
  End If
  txtValue.SelLength = 1
  PressedKey = 0
 Else
  PressedKey = FilterHexKeys(PressedKey)
  If txtValue.SelLength <> 1 Then txtValue.SelLength = 1
 End If
End Sub
Private Sub txtValue_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 13) And (shift = 0) And (cmdSetASM.Enabled) Then 'Enter
  cmdSetASM_Click
  cmdNextAddy_Click
 ElseIf (keycode = 13) And (shift = 2) And (cmdSetASM.Enabled) Then 'CTRL+Enter
  cmdDoEdit_Click
 ElseIf keycode = 27 Then 'ESC
  cmdCancelEdit_Click
 End If
End Sub
Private Sub txtValue_Change()
 txtValue.text = FilterHexValues(txtValue.text)
 txtOP.text = CleanSPC(Disassemble(CLng("&H" & txtAddress.text), CLng("&H" & txtValue.text)))
 cmdSetASM.Enabled = True
End Sub
Private Sub txtOP_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 13) And (shift = 0) And (cmdSetASM.Enabled) Then 'Enter
  cmdSetASM_Click
  cmdNextAddy_Click
 ElseIf (keycode = 13) And (shift = 2) And (cmdSetASM.Enabled) Then 'CTRL+Enter
  cmdDoEdit_Click
 ElseIf keycode = 27 Then 'ESC
  cmdCancelEdit_Click
 End If
End Sub
Private Sub txtOP_Change()
 cmdSetASM.Enabled = True
End Sub
Private Sub cmdNextAddy_Click()
 Dim tmpaddy As Long
 tmpaddy = CLng("&H" & txtAddress.text)
 tmpaddy = tmpaddy + 4
 If tmpaddy > LOF(ROMhandle) Then Exit Sub
 If (chkAutoSet.value = 1) And (cmdSetASM.Enabled) Then cmdSetASM_Click
 SetupForm tmpaddy
End Sub
Private Sub cmdPrevAddy_Click()
 Dim tmpaddy As Long
 tmpaddy = CLng("&H" & txtAddress.text)
 tmpaddy = tmpaddy - 4
 If tmpaddy < 0 Then Exit Sub
 If (chkAutoSet.value = 1) And (cmdSetASM.Enabled) Then cmdSetASM_Click
 SetupForm tmpaddy
End Sub
