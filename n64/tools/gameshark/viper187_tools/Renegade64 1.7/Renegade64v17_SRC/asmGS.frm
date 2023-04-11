VERSION 5.00
Begin VB.Form asmGS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Code Assembler"
   ClientHeight    =   8775
   ClientLeft      =   150
   ClientTop       =   240
   ClientWidth     =   10350
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   585
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   690
   Begin VB.CheckBox chkEmuWrite 
      Caption         =   "Write To Emulator"
      Height          =   255
      Left            =   4800
      TabIndex        =   26
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton cmdCopyASM 
      Caption         =   "Copy"
      Enabled         =   0   'False
      Height          =   255
      Left            =   2760
      TabIndex        =   25
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdCopyGS 
      Caption         =   "Copy"
      Enabled         =   0   'False
      Height          =   255
      Left            =   8040
      TabIndex        =   24
      Top             =   120
      Width           =   735
   End
   Begin VB.Frame frmLang 
      Caption         =   "Language"
      Height          =   855
      Left            =   4680
      TabIndex        =   22
      Top             =   1080
      Width           =   1695
      Begin VB.ComboBox cmbLang 
         Height          =   315
         ItemData        =   "asmGS.frx":0000
         Left            =   240
         List            =   "asmGS.frx":000A
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   350
         Width           =   1215
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Mode"
      Height          =   855
      Left            =   4560
      TabIndex        =   20
      Top             =   2160
      Width           =   1935
      Begin VB.ComboBox cmbASMmode 
         Height          =   315
         ItemData        =   "asmGS.frx":001D
         Left            =   240
         List            =   "asmGS.frx":0027
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   360
         Width           =   1575
      End
   End
   Begin VB.CommandButton cmdSaveCodes 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   7200
      TabIndex        =   19
      ToolTipText     =   "Ctrl+Shift+S"
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdSaveR4300i 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   1920
      TabIndex        =   18
      ToolTipText     =   "Ctrl+S"
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdOpenASM 
      Caption         =   "Open"
      Height          =   255
      Left            =   1080
      TabIndex        =   17
      ToolTipText     =   "Ctrl+O"
      Top             =   120
      Width           =   735
   End
   Begin VB.Frame Frame3 
      Caption         =   "Output Type"
      Height          =   1215
      Left            =   4560
      TabIndex        =   13
      Top             =   5400
      Width           =   1935
      Begin VB.TextBox txtNemuNum 
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
         Left            =   840
         TabIndex        =   15
         Top             =   720
         Width           =   375
      End
      Begin VB.ComboBox cmbCodeFMT 
         Height          =   315
         ItemData        =   "asmGS.frx":0043
         Left            =   240
         List            =   "asmGS.frx":0056
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   360
         Width           =   1575
      End
      Begin VB.Label lblNemuNum 
         Caption         =   "Number:"
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   720
         Width           =   615
      End
   End
   Begin VB.CommandButton cmdClearCodes 
      Caption         =   "Clear"
      Enabled         =   0   'False
      Height          =   255
      Left            =   9240
      TabIndex        =   12
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdClearASM 
      Caption         =   "Clear"
      Enabled         =   0   'False
      Height          =   255
      Left            =   3720
      TabIndex        =   11
      Top             =   120
      Width           =   735
   End
   Begin VB.TextBox txtWarning 
      Height          =   1575
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   9
      Top             =   6840
      Width           =   9615
   End
   Begin VB.Frame frmNOPtype 
      Caption         =   "NOP Type"
      Height          =   855
      Left            =   4800
      TabIndex        =   7
      Top             =   4320
      Width           =   1455
      Begin VB.ComboBox cmbNOP 
         Height          =   315
         ItemData        =   "asmGS.frx":00B4
         Left            =   240
         List            =   "asmGS.frx":00C1
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Frame frmCodeType 
      Caption         =   "Code Type"
      Height          =   855
      Left            =   4800
      TabIndex        =   5
      Top             =   3240
      Width           =   1455
      Begin VB.ComboBox cmbPrefix 
         Height          =   315
         ItemData        =   "asmGS.frx":00DA
         Left            =   240
         List            =   "asmGS.frx":00ED
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.CommandButton cmdAssemble 
      Caption         =   "Assemble"
      Enabled         =   0   'False
      Height          =   375
      Left            =   4920
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox txtGS 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6015
      Left            =   6600
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   360
      Width           =   3375
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6015
      Left            =   360
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   360
      Width           =   4095
   End
   Begin VB.Label Label3 
      Caption         =   "Warnings:"
      Height          =   255
      Left            =   360
      TabIndex        =   10
      Top             =   6600
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Codes:"
      Height          =   255
      Left            =   6600
      TabIndex        =   4
      Top             =   120
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "R4300i:"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   120
      Width           =   735
   End
End
Attribute VB_Name = "asmGS"
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
'branches?
'override input prefixes checkbox
'modifiers,xxxx,$x - loop to find right regs
Dim opSize As Long
Dim addy As Long
Private Sub Form_Load()
 OpenTools(0) = True
 cmbPrefix.ListIndex = GetCFG("asmgs_prefix", 1, 1)
 cmbNOP.ListIndex = GetCFG("asmgs_nop", 1, 0)
' cmbCodeFMT.ListIndex = GetCFG("asmgs_codefmt", 1, 0)
 cmbCodeFMT.ListIndex = 0
 cmbASMmode.ListIndex = GetCFG("asmgs_mode", 1, 0)
 cmbLang.ListIndex = GetCFG("asmgs_lang", 1, 0)
 chkEmuWrite.value = GetCFG("asmgs_emuwrite", 1, 0)
 SetEmuVarsASM
End Sub
Private Sub Form_Unload(cancel As Integer)
 WriteCFG "asmgs_prefix", cmbPrefix.ListIndex
 WriteCFG "asmgs_nop", cmbNOP.ListIndex
' WriteCFG "asmgs_codefmt", cmbCodeFMT.ListIndex
 WriteCFG "asmgs_lang", cmbLang.ListIndex
 WriteCFG "asmgs_emuwrite", chkEmuWrite.value
 OpenTools(0) = False
End Sub
Private Sub cmbASMmode_Click()
 WriteCFG "asmgs_mode", cmbASMmode.ListIndex
End Sub
Private Sub txtASM_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 13) And cmbASMmode.ListIndex = 1 Then
  cmdAssemble_Click
 ElseIf (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveR4300i_Click
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenASM_Click
 ElseIf (keycode = 65) And (shift = 2) Then 'CTRL+A
  txtASM.SelStart = 0
  txtASM.SelLength = Len(txtASM.text)
 End If
End Sub
Private Sub txtGS_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 83) And (shift = 2) Then 'CTRL+S
  cmdSaveR4300i_Click
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  cmdSaveCodes_Click
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  cmdOpenASM_Click
 ElseIf (keycode = 65) And (shift = 2) Then 'CTRL+A
  txtGS.SelStart = 0
  txtGS.SelLength = Len(txtGS.text)
 End If
End Sub
Private Sub cmdAssemble_Click()
 Dim asm() As String, lblnames(50) As String, codes As String, codes32 As String
 Dim tmp1 As String, tmp2() As String
 Dim lbladdys(50) As Long, tmplong As Long
 Dim i As Integer, lblnum As Integer, e As Integer, opcount As Integer
 Erase lbladdys
 Erase lblnames
 lblnum = 0
 If txtASM.text = "" Then Exit Sub
 asm = Split(txtASM.text, Chr(13) + Chr(10))
 e = 0
 txtWarning.text = ""
 Select Case cmbLang.ListIndex
  Case -1, 0
   opSize = 4
  Case 1
   opSize = 2
 End Select
 Do
  codes = ""
  codes32 = ""
  addy = 0
  For i = 0 To UBound(asm)
   asm(i) = Replace(Replace(asm(i), vbTab, " "), "  ", " ")
   asm(i) = UCase(Trim(asm(i)))
   If asm(i) <> "" Then
   If ((Right(asm(i), 1) = ":") And IsHex(Left(asm(i), Len(asm(i)) - 1)) And _
       (Len(asm(i)) = 9) And (Left(asm(i), 1) = "8")) Or IsHex(asm(i)) Or _
      (Left(asm(i), 4) = ".ORG") Or (Left(asm(i), 1) = "0x") Then
    tmplong = GetGSaddy(asm(i))
    If (tmplong Mod opSize) = 0 Then 'change for thumb?
     addy = tmplong
    Else 'warning
     txtWarning.text = txtWarning.text & Hex(tmplong) & " has been ignored. It's not a " & opSize & " byte, aligned address." & vbCrLf
    End If
   ElseIf (Right(asm(i), 1) = ":") And (e = 0) Then
    lblnames(lblnum) = Left(asm(i), Len(asm(i)) - 1)
    lbladdys(lblnum) = addy
    lblnum = lblnum + 1
   ElseIf Assemble(addy, asm(i), cmbLang.ListIndex) And (e = 0) Then
     For opcount = 0 To UBound(AssembledOP)
      If (AssembledOP(opcount) <> -1) Then addy = addy + opSize
     Next
   ElseIf (Left(asm(i), 1) <> ";") And (Right(asm(i), 1) <> ":") And (e <> 0) Then
     asm(i) = ReplaceLabels(asm(i), lblnames, lbladdys)
    If InStr(asm(i), ";") > 0 Then
     tmp2 = Split(asm(i), ";")
     asm(i) = tmp2(0)
     Erase tmp2
    End If
    If Assemble(addy, asm(i), cmbLang.ListIndex) Then
     codes = codes & GetCodeString(addy)
     codes32 = codes32 & GetCodeString(addy, 1)
     If ASMerror <> "" Then txtWarning.text = txtWarning.text & ASMerror & vbCrLf
     For opcount = 0 To UBound(AssembledOP)
      If (AssembledOP(opcount) <> -1) And (opcount > 0) Then addy = addy + opSize
     Next
    Else 'warning
     txtWarning.text = txtWarning.text & ASMerror & vbCrLf
    End If
    addy = addy + opSize
   ElseIf (Left(asm(i), 1) <> ";") And (e = 0) Then
    addy = addy + opSize
   End If
   End If
  Next
  e = e + 1
 Loop While e < 2
 If cmbCodeFMT.ListIndex > 3 Then codes = SpecFMT(codes)
 If (cmbLang.ListIndex = 1) And (cmbCodeFMT.ListIndex = 1) Then codes = ThumbFMT32(codes)
 txtGS.text = codes
 If (chkEmuWrite.value = 1) And (chkEmuWrite.Enabled = True) And (txtWarning.text = "") Then WriteEmu codes32
End Sub
Private Function ReplaceLabels(ByVal asmtext As String, ByRef lnames() As String, ByRef laddys() As Long) As String
 Dim l As Integer
 For l = 0 To UBound(lnames)
  If lnames(l) <> "" Then asmtext = Replace(asmtext, lnames(l), Hex(laddys(l)))
 Next
 ReplaceLabels = asmtext
End Function
Private Function GetPrefix(address) As Long
 If cmbPrefix.ListIndex < 0 Then cmbPrefix.ListIndex = 0
 Select Case cmbLang.ListIndex
  Case 0 'R4300i
'   If (address And &H81000000) Then
'    GetPrefix = address Or &H1000000
'   Else
    GetPrefix = address Or SLL(CLng("&H" & cmbPrefix.List(cmbPrefix.ListIndex)), 24)
'   End If
  Case 1 'Thumb
   GetPrefix = address
 End Select
End Function
Public Function GetCodeString(ByVal codeaddress As Long, Optional forcefmt As Integer = -1) As String
 Dim c As Integer
 For c = 0 To UBound(AssembledOP)
  If AssembledOP(c) <> -1 Then
   GetCodeString = GetCodeString & GetCodeText(codeaddress + (opSize * c), c, forcefmt)
'   If c > 0 Then addy = addy + opSize
  End If
 Next
End Function
Public Function GetCodeText(ByVal codeaddy As Long, ByVal opnum As Byte, ByVal forcefmt As Integer) As String
 Dim fmt As Integer
 fmt = cmbCodeFMT.ListIndex
 If forcefmt <> -1 Then fmt = forcefmt
 Select Case cmbLang.ListIndex
  Case 0 'r4300i
   If (cmbNOP.ListIndex = 2) And (AssembledOP(0) = 0) Then
    GetCodeText = ""
   ElseIf (cmbNOP.ListIndex = 0) And (AssembledOP(0) = 0) And (fmt <> 1) And (fmt <> 2) Then
    GetCodeText = Hex(GetPrefix(codeaddy + IIf(fmt = 3, 2, 0))) & " 2400" & vbCrLf
   ElseIf (fmt = 1) Then
    GetCodeText = Hex(GetPrefix(codeaddy)) & " " & HexString(AssembledOP(opnum), 8) & vbCrLf
   ElseIf (fmt = 2) Then
    GetCodeText = HexString(AssembledOP(opnum), 8) & vbCrLf
   ElseIf (fmt = 3) Then 'PSX
    GetCodeText = Hex(GetPrefix(codeaddy)) & " " & HexString((AssembledOP(opnum) And 65535), 4) & vbCrLf & _
                  Hex(GetPrefix(codeaddy + 2)) & " " & HexString(SRL(AssembledOP(opnum), 16), 4) & vbCrLf
   Else
    GetCodeText = Hex(GetPrefix(codeaddy)) & " " & HexString(SRL(AssembledOP(opnum), 16), 4) & vbCrLf & _
                  Hex(GetPrefix(codeaddy + 2)) & " " & HexString((AssembledOP(opnum) And 65535), 4) & vbCrLf
   End If
  Case 1 'Thumb
   If fmt = 2 Then
    GetCodeText = HexString(AssembledOP(opnum), 4) & vbCrLf
   Else
    GetCodeText = HexString(GetPrefix(codeaddy), 8) & " " & HexString(AssembledOP(opnum), 4) & vbCrLf
   End If
 End Select
End Function
Private Sub txtGS_Change()
 cmdSaveCodes.Enabled = CBool(Len(txtGS.text))
 cmdClearCodes.Enabled = CBool(Len(txtGS.text))
 cmdCopyGS.Enabled = CBool(Len(txtGS.text))
End Sub
Private Sub txtASM_Change()
 cmdSaveR4300i.Enabled = CBool(Len(txtASM.text))
 cmdAssemble.Enabled = CBool(Len(txtASM.text))
 cmdClearASM.Enabled = CBool(Len(txtASM.text))
 cmdCopyASM.Enabled = CBool(Len(txtASM.text))
End Sub
Private Sub cmdSaveCodes_Click()
 If cmdSaveCodes.Enabled Then SaveText txtGS.text
End Sub
Private Sub cmdSaveR4300i_Click()
 If cmdSaveR4300i.Enabled Then SaveText txtASM.text
End Sub
Private Sub cmdCopyASM_Click()
 Clipboard.SetText txtASM.text
End Sub
Private Sub cmdCopyGS_Click()
 Clipboard.SetText txtGS.text
End Sub
Private Sub SaveText(text As String)
 Dim temphandle As Integer
 Dim txtName As String
 temphandle = FreeFile
 If Not ChooseFile(txtName, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
 Open (txtName) For Output As #temphandle
 Print #temphandle, text
 Close #temphandle
End Sub
Private Sub cmdClearASM_Click()
 txtASM.text = ""
End Sub
Private Sub cmdClearCodes_Click()
 txtGS.text = ""
End Sub
Private Sub cmdOpenASM_Click()
 Dim tmpstring As String
 Dim temphandle As Integer
 temphandle = FreeFile
 If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 1) Then Exit Sub
 Open (tmpstring) For Input As #temphandle
 Do
  Line Input #temphandle, tmpstring
  txtASM.text = txtASM.text & tmpstring & vbCrLf
 Loop Until EOF(temphandle)
 Close #temphandle
End Sub
Private Function GetGSaddy(ByVal asmtext As String) As Long
 Dim tmpasm1() As String
 asmtext = Replace(asmtext, ":", "")
 asmtext = Replace(asmtext, "0X", "")
 asmtext = Replace(asmtext, ".ORG", "")
 asmtext = Replace(asmtext, vbTab, "")
 asmtext = Trim(asmtext)
 If InStr(asmtext, ";") Then
  tmpasm1 = Split(asmtext, ";")
  asmtext = tmpasm1(0)
  Erase tmpasm1
 End If
 If IsHex(asmtext) Then
  GetGSaddy = CLng("&H" & asmtext)
 Else
  GetGSaddy = -1
 End If
End Function
Private Sub cmbCodeFMT_Click()
 If (cmbCodeFMT.ListIndex = 4) And (cmbLang.ListIndex <> 0) Then cmbCodeFMT.ListIndex = 0
 If cmbCodeFMT.ListIndex = 4 Then
  lblNemuNum.Visible = True
  txtNemuNum.Visible = True
  If txtNemuNum.text = "" Then txtNemuNum.text = "0"
 Else
  lblNemuNum.Visible = False
  txtNemuNum.Visible = False
 End If
 If cmbCodeFMT.ListIndex = 3 Then cmbPrefix.ListIndex = 1
 cmdAssemble_Click
End Sub
Private Sub cmbLang_Click()
 Dim fmtstring As String, FMTs() As String
 Dim i As Integer
 Select Case cmbLang.ListIndex
  Case 0 'R4300i
   frmCodeType.Enabled = True
   frmNOPtype.Enabled = True
   fmtstring = "Normal,32-Bit Values,32-Bit Values (No Addresses),Little Endian (PSX),Nemu INI Entry"
  Case 1 'Thumb
   frmCodeType.Enabled = False
   frmNOPtype.Enabled = False
   fmtstring = "Normal,32-Bit Values,16-Bit Values (No Addresses)"
 End Select
 FMTs() = Split(fmtstring, ",")
 cmbCodeFMT.Clear
 For i = 0 To UBound(FMTs)
  cmbCodeFMT.AddItem FMTs(i)
 Next
  cmbCodeFMT.ListIndex = 0
End Sub
Private Sub cmbPrefix_Click()
 If cmbPrefix.ListIndex = 1 Then cmbCodeFMT.ListIndex = 3
End Sub
Private Function SpecFMT(ByVal codestxt As String) As String
 Dim codesin() As String, tmpcode As String, nemuname As String
 Dim i As Integer, nemunum As Integer, numcodes As Integer
 Dim fmt As Integer
 fmt = cmbCodeFMT.ListIndex
 nemunum = 0
 If IsNumeric(txtNemuNum.text) Then nemunum = CInt(txtNemuNum.text)
 If InStr(codestxt, Chr(10)) <= 0 Then
  SpecFMT = codestxt
  Exit Function
 End If
 If fmt = 3 Then 'Nemu
  tmpcode = ""
  numcodes = 0
  codesin = Split(codestxt, Chr(13) + Chr(10))
  For i = 0 To UBound(codesin)
   codesin(i) = Trim(codesin(i))
   If codesin(i) <> "" Then
    If nemuname = "" Then nemuname = codesin(i)
    tmpcode = tmpcode & "CheatName" & nemunum & "Code" & numcodes & "=" & codesin(i) & vbCrLf
    numcodes = numcodes + 1
   End If
  Next
  SpecFMT = "CheatName" & nemunum & "=" & nemuname & vbCrLf & "CheatName" & nemunum & _
            "Count=" & numcodes & vbCrLf & tmpcode
 End If
End Function
Private Function ThumbFMT32(ByVal codestxt As String) As String
 Dim codesin() As String, tmpcodes As String, tmp1() As String, tmp2() As String
 Dim i As Integer
 Dim tmpaddy1 As Long, tmpaddy2 As Long
 If InStr(codestxt, Chr(10)) <= 0 Then
  ThumbFMT32 = codestxt
  Exit Function
 End If
 ThumbFMT32 = ""
 codesin = Split(codestxt, Chr(13) + Chr(10))
 For i = 0 To UBound(codesin)
  If (i < UBound(codesin)) And codesin(i) <> "" Then
   Erase tmp1
   tmp1() = Split(codesin(i), " ")
   tmpaddy1 = CLng("&H" & tmp1(0))
   If ((tmpaddy1 Mod 4) = 0) And (codesin(i + 1) <> "") Then
    Erase tmp2
    tmp2() = Split(codesin(i + 1), " ")
    tmpaddy2 = CLng("&H" & tmp2(0))
    If (tmpaddy2 - tmpaddy1) = 2 Then
     ThumbFMT32 = ThumbFMT32 & tmp1(0) & " " & tmp1(1) & tmp2(1) & vbCrLf
     i = i + 1
    Else
     ThumbFMT32 = ThumbFMT32 & codesin(i) & vbCrLf
    End If
   Else: ThumbFMT32 = ThumbFMT32 & codesin(i) & vbCrLf
   End If
  Else
   ThumbFMT32 = ThumbFMT32 & codesin(i) & vbCrLf
  End If
 Next
End Function
Public Sub SetEmuVarsASM()
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) <> -1 Then
    chkEmuWrite.Enabled = True
 Else
    chkEmuWrite.Enabled = False
 End If
End Sub
Private Sub WriteEmu(ByVal codestxt As String)
 Dim asmcodes() As String
 Dim i As Integer
 Dim tmpcode As Long, tmpvalue As Long
 Dim pHandle As Long
 EmuId(0) = ChkEmu(EmuId(0))
 If EmuId(0) = -1 Then
  MsgBox "Not attached to emulator.", vbOKOnly, "Error"
  Exit Sub
 End If
 pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
 If pHandle = 0 Then
  MsgBox "OpenProcess failed"
  MainMDI.mnuEmuDetach_Click
  Exit Sub
 End If
 asmcodes = Split(codestxt, vbCrLf)
 For i = 0 To UBound(asmcodes)
  asmcodes(i) = Trim(asmcodes(i))
  If asmcodes(i) <> "" Then
   If cmbPrefix.ListIndex = 0 Then 'ps2
    tmpcode = CLng("&H" & Mid(asmcodes(i), 2, 7))
   Else
    tmpcode = CLng("&H" & Mid(asmcodes(i), 3, 6))
   End If
   tmpvalue = CLng("&H" & Mid(asmcodes(i), 10))
   If Not WriteEmuRAM(pHandle, tmpcode, tmpvalue) Then Exit For
  End If
 Next
 CloseHandle pHandle
 txtWarning.text = txtWarning.text & "Emulator RAM written." & vbCrLf
End Sub
Private Function WriteEmuRAM(ByVal pId As Long, ByVal addy As Long, ByVal value As Long) As Boolean
 Dim bah As Long
 WriteEmuRAM = True
 If WriteProcessMemory(pId, (EmuOffsets(EmuId(1)) + addy), value, 4, bah) = 0 Then
  MsgBox "Write failed: " & Hex(addy) & ":" & Hex(value), vbOKOnly, "Error"
  WriteEmuRAM = False
 End If
End Function
