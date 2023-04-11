VERSION 5.00
Begin VB.Form MemEditor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Memory Editor"
   ClientHeight    =   6855
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   12000
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   457
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.Frame frmRAMsize 
      Caption         =   "RAM Size"
      Height          =   615
      Left            =   600
      TabIndex        =   26
      Top             =   5760
      Width           =   1815
      Begin VB.TextBox txtRAMSize 
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
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   27
         Top             =   240
         Width           =   1320
      End
   End
   Begin VB.Frame Frame16 
      Caption         =   "Endian"
      Height          =   615
      Left            =   3720
      TabIndex        =   24
      Top             =   5760
      Width           =   2775
      Begin VB.ComboBox cmbEndian 
         Height          =   315
         ItemData        =   "MemEditor.frx":0000
         Left            =   360
         List            =   "MemEditor.frx":0010
         TabIndex        =   25
         Text            =   "Combo1"
         Top             =   230
         Width           =   2055
      End
   End
   Begin VB.ComboBox cmbRefreshRate 
      Height          =   315
      ItemData        =   "MemEditor.frx":0062
      Left            =   4920
      List            =   "MemEditor.frx":0072
      Style           =   2  'Dropdown List
      TabIndex        =   22
      Top             =   1080
      Width           =   1575
   End
   Begin VB.Timer tmrMemRefresh 
      Interval        =   5000
      Left            =   11280
      Top             =   240
   End
   Begin VB.CommandButton cmdUp 
      Caption         =   "Up"
      Height          =   375
      Left            =   7440
      TabIndex        =   21
      Top             =   1080
      Width           =   735
   End
   Begin VB.CommandButton cmdDown 
      Caption         =   "Down"
      Height          =   375
      Left            =   7440
      TabIndex        =   20
      Top             =   5370
      Width           =   735
   End
   Begin VB.CommandButton cmdGoTo 
      Caption         =   "Go To"
      Height          =   375
      Left            =   2280
      TabIndex        =   19
      Top             =   1080
      Width           =   780
   End
   Begin VB.TextBox txtGoTo 
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
      Left            =   675
      MaxLength       =   8
      TabIndex        =   18
      Top             =   1080
      Width           =   1575
   End
   Begin VB.Frame Frame15 
      Caption         =   "Frame15"
      Height          =   3975
      Left            =   7710
      TabIndex        =   17
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame14 
      Caption         =   "Frame14"
      Height          =   3975
      Left            =   7350
      TabIndex        =   16
      Top             =   1440
      Width           =   15
   End
   Begin VB.Frame Frame13 
      Caption         =   "Frame13"
      Height          =   3975
      Left            =   6990
      TabIndex        =   15
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame12 
      Caption         =   "Frame12"
      Height          =   3975
      Left            =   6630
      TabIndex        =   14
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame11 
      Caption         =   "Frame11"
      Height          =   3975
      Left            =   6270
      TabIndex        =   13
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame10 
      Caption         =   "Frame10"
      Height          =   3975
      Left            =   5910
      TabIndex        =   12
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame9 
      Caption         =   "Frame9"
      Height          =   3975
      Left            =   5550
      TabIndex        =   11
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame8 
      Caption         =   "Frame8"
      Height          =   3975
      Left            =   5190
      TabIndex        =   10
      Top             =   1440
      Width           =   15
   End
   Begin VB.Frame Frame7 
      Caption         =   "Frame7"
      Height          =   3975
      Left            =   4830
      TabIndex        =   9
      Top             =   1440
      Width           =   15
   End
   Begin VB.Frame Frame6 
      Caption         =   "Frame6"
      Height          =   3975
      Left            =   4470
      TabIndex        =   8
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame5 
      Caption         =   "Frame5"
      Height          =   3975
      Left            =   4110
      TabIndex        =   7
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame4 
      Caption         =   "Frame4"
      Height          =   3975
      Left            =   3030
      TabIndex        =   6
      Top             =   1440
      Width           =   30
   End
   Begin VB.Frame Frame3 
      Caption         =   "Frame3"
      Height          =   3975
      Left            =   2685
      TabIndex        =   5
      Top             =   1440
      Width           =   30
   End
   Begin VB.TextBox txtASCII 
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
      Height          =   3930
      Left            =   8160
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   4
      Top             =   1440
      Width           =   3015
   End
   Begin VB.TextBox txtAddys 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3930
      Left            =   675
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   3
      Top             =   1440
      Width           =   1575
   End
   Begin VB.Frame Frame2 
      Caption         =   "Frame2"
      Height          =   4095
      Left            =   3765
      TabIndex        =   2
      Top             =   1320
      Width           =   30
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   3975
      Left            =   3390
      TabIndex        =   1
      Top             =   1440
      Width           =   30
   End
   Begin VB.TextBox txtRAM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   12
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3930
      Left            =   2280
      MaxLength       =   512
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   1440
      Width           =   5850
   End
   Begin VB.Label Label1 
      Caption         =   "Auto Refresh"
      Height          =   255
      Left            =   3960
      TabIndex        =   23
      Top             =   1080
      Width           =   975
   End
End
Attribute VB_Name = "MemEditor"
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
'Dim tmpram(64) As Long
Option Explicit
Dim CurrAddy As Long
Private Sub Form_Load()
 OpenTools(9) = True
 cmbEndian.ListIndex = 0
 If EmuId(0) = -1 Then
  MainMDI.mnuEmuAttach_Click
 Else: SetEmuVarsME
 End If
' If EmuId(0) <> -1 Then GetRAM 0
 cmbRefreshRate.ListIndex = GetCFG("memeditor_refresh", 1, 0)
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(9) = False
End Sub
Public Sub GetRAM(ByVal sAddy As Long)
 Dim pHandle As Long, bah As Long, i As Long, tmpword As Long, errnumber As Long
 Dim tmphex As String, tmpascii As String, tmpaddys As String
 CurrAddy = sAddy
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) = -1 Then Exit Sub
 pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
 If pHandle = 0 Then
  MsgBox "OpenProcess failed"
  MainMDI.mnuEmuDetach_Click
  Exit Sub
 End If
 sAddy = sAddy + EmuOffsets(EmuId(1))
 tmphex = ""
 For i = 0 To 63
  If ReadProcessMemory(pHandle, (sAddy + (i * 4)), tmpword, 4, bah) = 0 Then
   MsgBox "ReadProcessMemory failed"
   cmbRefreshRate.ListIndex = 3
   Exit Sub
  End If
  tmpword = FlipWord(tmpword, IIf((MEMendian = 3), 2, MEMendian))
  tmphex = tmphex & HexString(tmpword, 8)
  tmpascii = tmpascii & HexToASCII(tmpword, 4)
  If (i Mod 4) = 0 Then tmpaddys = tmpaddys & HexString(CurrAddy + (i * 4), 8)
 Next
 txtRAM.text = tmphex
 txtASCII.text = tmpascii
 txtAddys.text = tmpaddys
 CloseHandle pHandle
' MsgBox tmpram(0) & vbCrLf & tmpram(1) & vbCrLf & tmpram(2) & vbCrLf & tmpram(3)
End Sub
Private Sub txtRAM_KeyPress(PressedKey As Integer)
 Dim tmpaddy As Long, tmpval As Long, pHandle As Long, bah As Long
 If txtRAM.SelLength <> 1 Then txtRAM.SelLength = 1
 PressedKey = FilterHexKeys(PressedKey)
 If PressedKey <> 0 Then
  tmpaddy = txtRAM.SelStart \ 2
  If (txtRAM.SelStart Mod 2) Then
   tmpval = CLng("&H" & Mid(txtRAM.text, txtRAM.SelStart, 1) & Chr(PressedKey))
  Else
   tmpval = CLng("&H" & Chr(PressedKey) & Mid(txtRAM.text, txtRAM.SelStart + 2, 1))
  End If
  If EmuId(0) <> -1 Then
   pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
   If pHandle = 0 Then
    MsgBox "OpenProcess failed"
    MainMDI.mnuEmuDetach_Click
    Exit Sub
   End If
   tmpaddy = FlipAddy(tmpaddy, 1, IIf((MEMendian = 3), 2, MEMendian))
   If WriteProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + CurrAddy + tmpaddy), tmpval, 1, bah) = 0 Then
    MsgBox "Write failed"
   End If
   CloseHandle pHandle
  End If
 End If
' MsgBox "write " & Hex(CurrAddy + tmpaddy) & " " & Hex(tmpval)
End Sub
Private Sub txtRAM_KeyUp(PressedKey As Integer, shift As Integer)
 If PressedKey = 33 Then 'Page Up'
  cmdUp_Click
 ElseIf PressedKey = 34 Then 'Page Down
  cmdDown_Click
 ElseIf PressedKey = 116 Then 'F5
  GetRAM CurrAddy
 ElseIf (PressedKey = 38) And txtRAM.SelStart < 32 Then 'Up
  If (CurrAddy - &H10) >= 0 Then GetRAM CurrAddy - &H10
 ElseIf (PressedKey = 40) And txtRAM.SelStart >= &H1E0 Then 'Down
  If (CurrAddy + &H10) < EmuRAM(EmuId(1)) Then GetRAM CurrAddy + &H10
 Else: PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtRAM_KeyDown(PressedKey As Integer, shift As Integer)
  If (PressedKey < 37) And (PressedKey > 40) Then PressedKey = 0
End Sub
Private Sub txtGoto_KeyPress(PressedKey As Integer)
 If PressedKey = 13 Then
  cmdGoTo_Click
 ElseIf PressedKey <> 8 Then PressedKey = FilterHexKeys(PressedKey)
 End If
End Sub
Private Sub txtGoTo_KeyUp(keycode As Integer, shift As Integer)
 If (keycode = 67) And (shift = 2) Then 'CTRL+C
  Clipboard.SetText txtGoTo.text
 ElseIf (keycode = 88) And (shift = 2) Then 'CTRL+X
  Clipboard.SetText txtGoTo.text
  txtGoTo.text = "0"
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtGoTo.text = FilterHexValues(Clipboard.GetText)
 ElseIf (keycode = 38) Then 'Up
  If (CurrAddy - &H10) >= 0 Then GetRAM CurrAddy - &H10
 ElseIf (keycode = 40) Then 'Down
  If (CurrAddy + &H10) < EmuRAM(EmuId(1)) Then GetRAM CurrAddy + &H10
 End If
End Sub
Private Sub cmdGoTo_Click()
 Dim tmpval As Long
 If IsHex(txtGoTo.text) Then
  tmpval = CLng("&H" & txtGoTo.text) And &H7FFFFFC
  txtGoTo.text = Hex(tmpval)
  If (tmpval > 0) And (tmpval < EmuRAM(EmuId(1))) Then GetRAM tmpval
 End If
End Sub
Private Sub cmdDown_Click()
 If (CurrAddy + &H100) < EmuRAM(EmuId(1)) Then GetRAM CurrAddy + &H100
End Sub
Private Sub cmdUp_Click()
 If (CurrAddy - &H100) >= 0 Then GetRAM CurrAddy - &H100
End Sub
Private Sub cmbRefreshRate_Click()
 WriteCFG "memeditor_refresh", cmbRefreshRate.ListIndex
 Select Case cmbRefreshRate.ListIndex
  Case 0
   tmrMemRefresh.Interval = 1000
   tmrMemRefresh.Enabled = True
  Case 1
   tmrMemRefresh.Interval = 5000
   tmrMemRefresh.Enabled = True
  Case 2
   tmrMemRefresh.Interval = 30000
   tmrMemRefresh.Enabled = True
  Case 3
   tmrMemRefresh.Enabled = False
  End Select
End Sub
Private Sub tmrMemRefresh_Timer()
 GetRAM CurrAddy
End Sub
Public Sub SetEmuVarsME()
 If EmuId(0) <> -1 Then
  txtRAMSize.text = "0x" & Hex(EmuRAM(EmuId(1)))
  MEMendian = EmuEndian(EmuId(1))
  cmbEndian.ListIndex = EmuEndian(EmuId(1))
  GetRAM 0
 End If
End Sub
Private Sub cmbEndian_Click()
 MEMendian = cmbEndian.ListIndex
' If cmbEndian.ListIndex = 0 Then
'  MEMendian = 2
' Else
'  MEMendian = 0
' End If
 GetRAM CurrAddy
End Sub

