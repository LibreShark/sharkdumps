VERSION 5.00
Begin VB.Form DisSearch 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "R4300i Search"
   ClientHeight    =   9000
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   Begin VB.CommandButton cmdClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   2760
      TabIndex        =   8
      Top             =   1920
      Width           =   975
   End
   Begin VB.CommandButton cmdMoreRSRes 
      Caption         =   "More"
      Enabled         =   0   'False
      Height          =   375
      Left            =   10560
      TabIndex        =   6
      Top             =   8400
      Width           =   975
   End
   Begin VB.TextBox txtRSRescount 
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
      Left            =   8400
      TabIndex        =   5
      Top             =   240
      Width           =   1455
   End
   Begin VB.ListBox lstRSRes 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7620
      ItemData        =   "DisSearch.frx":0000
      Left            =   5760
      List            =   "DisSearch.frx":0002
      MultiSelect     =   2  'Extended
      TabIndex        =   3
      Top             =   720
      Width           =   5775
   End
   Begin VB.CommandButton cmdSearchASM 
      Caption         =   "Search"
      Height          =   375
      Left            =   1440
      TabIndex        =   2
      Top             =   1920
      Width           =   975
   End
   Begin VB.TextBox txtValue1 
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
      Left            =   4200
      MaxLength       =   8
      TabIndex        =   1
      Text            =   "0"
      Top             =   840
      Width           =   1095
   End
   Begin VB.ComboBox cmbRSType 
      Height          =   315
      ItemData        =   "DisSearch.frx":0004
      Left            =   240
      List            =   "DisSearch.frx":001D
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   840
      Width           =   3735
   End
   Begin VB.Label Label2 
      Caption         =   "Search Type:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   600
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "Results:"
      Height          =   255
      Left            =   7560
      TabIndex        =   4
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "DisSearch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim respath As String
Dim rstype As Integer
Dim opBitMax As Long
Dim dsROM As String
Private Sub Form_Load()
 OpenTools(6) = True
 cmbRSType.ListIndex = 0
 respath = GetCFG("respath", 3, DefaultResPath)
' If Dir$(respath & "romsearch.bin") <> vbNullString Then ShowRSRes
 If Disassembler.CurrentROM <> "" Then
  dsROM = Disassembler.CurrentROM
  DisSearch.Caption = "R4300i Search - " & dsROM
 End If
 OPprintType = 0
 GPRnames = Split(GPRNameList1, ",")
 FPRnames = Split(FPRNameList1, ",")
 CP0names = Split(CP0NameList1, ",")
End Sub
Private Sub Form_Unload(cancel As Integer)
 OpenTools(6) = False
End Sub
Private Sub cmbRSType_Click()
 Dim size As Integer
 Dim vtype As Integer
 rstype = cmbRSType.ListIndex
 Select Case rstype
  Case 0 '32-bit access
   size = 8
   vtype = 1
  Case 1, 2, 3 'addiu/ori and lui/MTCx
   size = 4
   vtype = 1
  Case 4 'opcode
   size = 8
   vtype = 0
  Case 5, 6 'MTC0, 80000180
   vtype = -1
 End Select
 Select Case vtype
  Case -1
   txtValue1.Visible = False
  Case 0
   txtValue1.MaxLength = size
   txtValue1.Visible = True
  Case 1
   txtValue1.Visible = True
   txtValue1.text = FilterHexValues(txtValue1.text)
   If Len(txtValue1.text) > size Then txtValue1.text = "0"
   txtValue1.MaxLength = size
 End Select
End Sub
Private Sub cmdSearchASM_Click()
 Dim errnumber As Long
 Dim val1 As Long, val2 As Long
 Dim op As String
 If cmbRSType.ListIndex = 4 Then
  val2 = GetOpBits(txtValue1.text)
  val1 = opBitMax
  If (val1 = 0) And (opBitMax = 0) Then
   MsgBox "invalid OP", vbOKOnly
   Exit Sub
  End If
 Else
  val1 = CLng("&H" & txtValue1.text)
 End If
 If dsROM = "" Then
  If Not ChooseFile(dsROM, "N64 ROMs & Saves (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur,*.pj)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur;*.pj|All Files (*.*)|*", 1) Then Exit Sub
  DisSearch.Caption = "R4300i Search - " & MainMDI.FileDlg.FileTitle
  dlgEndianSelect.Show vbModal
 End If
 errnumber = SearchROM(dsROM, respath & "romsearch.bin", ROMendian, cmbRSType.ListIndex, val1, val2)
 If errnumber <> 0 Then
  ShowDLLError errnumber
  Exit Sub
 End If
 ShowRSRes
End Sub
Private Sub ShowRSRes()
 Dim i As Long, tmpaddy1 As Long, tmpaddy2 As Long, tmpval1 As Long, tmpval2 As Long, rescount As Long
 Dim combo As Boolean
 Dim resHandle As Integer, rHandle As Integer, txtHandle As Integer
 resHandle = FreeFile
 Open (respath & "romsearch.bin") For Binary As #resHandle
 Get #resHandle, 1, rescount
 cmbRSType.ListIndex = SRL(rescount, 24)
 rescount = rescount And &HFFFFFF
 lstRSRes.Clear
 txtRSRescount.text = rescount
 If rescount = 0 Then Exit Sub
 If rescount > 2000 Then
  cmdMoreRSRes.Enabled = True
 Else
  cmdMoreRSRes.Enabled = False
 End If
  txtHandle = FreeFile
  Open (respath & "romsearch.txt") For Output As #txtHandle
  rHandle = FreeFile
 Open (respath & "romsearch.bin") For Binary As #rHandle
' End If
 i = 1
 If (rstype = 0) Or (rstype = 3) Or (rstype = 6) Then combo = True
 Do
  Get #resHandle, (i * 4) + 1, tmpaddy1
  Get #resHandle, ((i + 1) * 4) + 1, tmpaddy2
  Get #rHandle, tmpaddy1 + 1, tmpval1
  Get #rHandle, tmpaddy2 + 1, tmpval2
  tmpval1 = FlipWord(tmpval1, ROMendian)
  tmpval2 = FlipWord(tmpval2, ROMendian)
  If i <= 2000 Then
   lstRSRes.AddItem String(8 - Len(Hex(tmpaddy1)), "0") & Hex(tmpaddy1) & ": " & String(8 - Len(Hex(tmpval1)), "0") & _
                    Hex(tmpval1) & "  " & Disassemble(tmpaddy1, tmpval1)
   If combo Then lstRSRes.AddItem String(8 - Len(Hex(tmpaddy2)), "0") & Hex(tmpaddy2) & ": " & String(8 - Len(Hex(tmpval2)), "0") & _
                    Hex(tmpval2) & "  " & Disassemble(tmpaddy2, tmpval2)
'  Else
  End If
   Print #txtHandle, String(8 - Len(Hex(tmpaddy1)), "0") & Hex(tmpaddy1) & ": " & String(8 - Len(Hex(tmpval1)), "0") & _
                      Hex(tmpval1) & "  " & Disassemble(tmpaddy1, tmpval1) & vbCrLf
   If combo Then Print #txtHandle, String(8 - Len(Hex(tmpaddy2)), "0") & Hex(tmpaddy2) & ": " & String(8 - Len(Hex(tmpval2)), "0") & _
                      Hex(tmpval2) & "  " & Disassemble(tmpaddy2, tmpval2)
'  End If
 If combo Then
  i = i + 2
 Else
  i = i + 1
 End If
 Loop While i < rescount
 Close #resHandle
 Close #txtHandle
 Close #rHandle
End Sub
Private Sub lstRSRes_Click()
 Dim sel As Integer
 Dim tmpaddy As Long
 Dim tmpstring() As String
 sel = lstRSRes.ListIndex
 If (sel < 0) Or (lstRSRes.List(lstRSRes.ListIndex) = "") Then Exit Sub
 tmpstring = Split(lstRSRes.List(lstRSRes.ListIndex), ":")
 tmpaddy = CLng("&H" & tmpstring(0))
 If (tmpaddy + 1) < LOF(ROMhandle) Then
  Disassembler.txtAddys(0).text = Hex(tmpaddy)
  DisSearch.Hide
 End If
' If (rstype = 0) Or (rstype = 3) Then
'  If sel Mod 2 Then
'   lstRSRes.Selected(sel - 1) = True
'  Else
'   lstRSRes.Selected(sel + 1) = True
'  End If
' End If
End Sub
Private Sub cmdClear_Click()
 dsROM = ""
 lstRSRes.Clear
 txtRSRescount.text = ""
 DisSearch.Caption = "R4300i Search"
End Sub
Private Sub cmdMoreRSRes_Click()
 Shell GetCFG("cs_texteditor", 3, DefaultTextEditor) & " " & respath & "romsearch.txt", vbNormalFocus
End Sub
Private Sub txtValue1_KeyPress(PressedKey As Integer)
' MsgBox PressedKey, vbOKOnly
 If PressedKey = 13 Then 'Enter
  cmdSearchASM_Click
 ElseIf PressedKey <> 8 Then
  Select Case cmbRSType.ListIndex
   Case 0, 1, 2, 3: PressedKey = FilterHexKeys(PressedKey)
  End Select
 End If
End Sub
Private Sub txtValue1_Change()
 Select Case (cmbRSType.ListIndex)
  Case 0, 1, 2, 3: txtValue1.text = FilterHexValues(txtValue1.text)
 End Select
End Sub
Private Function GetOpBits(ByVal opcode As String) As Long
Select Case UCase(opcode)
 'Type 1:  rt,offset(base)
 Case "LB"
  GetOpBits = SLL(32, 26)
  opBitMax = BitsOn(6, 26)
 Case "LBU"
  GetOpBits = SLL(36, 26)
  opBitMax = BitsOn(6, 26)
 Case "LD"
  GetOpBits = SLL(55, 26)
  opBitMax = BitsOn(6, 26)
 Case "LDL"
  GetOpBits = SLL(26, 26)
  opBitMax = BitsOn(6, 26)
 Case "LDR"
  GetOpBits = SLL(27, 26)
  opBitMax = BitsOn(6, 26)
 Case "LH"
  GetOpBits = SLL(33, 26)
  opBitMax = BitsOn(6, 26)
 Case "LHU"
  GetOpBits = SLL(37, 26)
  opBitMax = BitsOn(6, 26)
 Case "LL"
  GetOpBits = SLL(48, 26)
  opBitMax = BitsOn(6, 26)
 Case "LLD"
  GetOpBits = SLL(52, 26)
  opBitMax = BitsOn(6, 26)
 Case "LW"
  GetOpBits = SLL(35, 26)
  opBitMax = BitsOn(6, 26)
 Case "LWL"
  GetOpBits = SLL(34, 26)
  opBitMax = BitsOn(6, 26)
 Case "LWR"
  GetOpBits = SLL(38, 26)
  opBitMax = BitsOn(6, 26)
 Case "LWU"
  GetOpBits = SLL(39, 26)
  opBitMax = BitsOn(6, 26)
 Case "SB"
  GetOpBits = SLL(40, 26)
  opBitMax = BitsOn(6, 26)
 Case "SC"
  GetOpBits = SLL(56, 26)
  opBitMax = BitsOn(6, 26)
 Case "SCD"
  GetOpBits = SLL(60, 26)
  opBitMax = BitsOn(6, 26)
 Case "SD"
  GetOpBits = SLL(63, 26)
  opBitMax = BitsOn(6, 26)
 Case "SDL"
  GetOpBits = SLL(44, 26)
  opBitMax = BitsOn(6, 26)
 Case "SDR"
  GetOpBits = SLL(45, 26)
  opBitMax = BitsOn(6, 26)
 Case "SH"
  GetOpBits = SLL(41, 26)
  opBitMax = BitsOn(6, 26)
 Case "SW"
  GetOpBits = SLL(43, 26)
  opBitMax = BitsOn(6, 26)
 Case "SWL"
  GetOpBits = SLL(42, 26)
  opBitMax = BitsOn(6, 26)
 Case "SWR"
  GetOpBits = SLL(46, 26)
  opBitMax = BitsOn(6, 26)
 'Type 2/33: rd,rs,rt and rd,rt,rs
 Case "ADD"
  GetOpBits = 32
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "ADDU"
  GetOpBits = 33
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "AND"
  GetOpBits = 36
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DADD"
  GetOpBits = 44
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DADDU"
  GetOpBits = 45
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DSLLV"
  GetOpBits = 20
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DSRAV"
  GetOpBits = 23
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DSRLV"
  GetOpBits = 22
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DSUB"
  GetOpBits = 46
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "DSUBU"
  GetOpBits = 47
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "NOR"
  GetOpBits = 39
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "OR"
  GetOpBits = 37
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SLLV"
  GetOpBits = 4
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SLT"
  GetOpBits = 42
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SLTU"
  GetOpBits = 43
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SRAV"
  GetOpBits = 7
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SRLV"
  GetOpBits = 6
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SUB"
  GetOpBits = 34
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "SUBU"
  GetOpBits = 35
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "XOR"
  GetOpBits = 38
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 'Type 3: rd,rt,sa
 Case "DSLL"
  GetOpBits = 56
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "DSLL32"
  GetOpBits = 60
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "DSRA"
  GetOpBits = 59
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "DSRA32"
  GetOpBits = 63
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "DSRL"
  GetOpBits = 58
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "DSRL32"
  GetOpBits = 62
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "SLL"
  GetOpBits = 0
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "SRA"
  GetOpBits = 3
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 Case "SRL"
  GetOpBits = 2
  opBitMax = BitsOn(11, 26) Or BitsOn(6, 0)
 'Type 4: rt,rs,imm
 Case "ADDI"
  GetOpBits = SLL(8, 26)
  opBitMax = BitsOn(6, 26)
 Case "ADDIU"
  GetOpBits = SLL(9, 26)
  opBitMax = BitsOn(6, 26)
 Case "ANDI"
  GetOpBits = SLL(12, 26)
  opBitMax = BitsOn(6, 26)
 Case "DADDI"
  GetOpBits = SLL(24, 26)
  opBitMax = BitsOn(6, 26)
 Case "DADDIU"
  GetOpBits = SLL(25, 26)
  opBitMax = BitsOn(6, 26)
 Case "ORI"
  GetOpBits = SLL(13, 26)
  opBitMax = BitsOn(6, 26)
 Case "SLTI"
  GetOpBits = SLL(10, 26)
  opBitMax = BitsOn(6, 26)
 Case "SLTIU"
  GetOpBits = SLL(11, 26)
  opBitMax = BitsOn(6, 26)
 Case "XORI"
  GetOpBits = SLL(14, 26)
  opBitMax = BitsOn(6, 26)
 'Type 5: rs,rt
 Case "DDIV"
  GetOpBits = 30
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "DDIVU"
  GetOpBits = 31
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "DIV"
  GetOpBits = 26
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "DIVU"
  GetOpBits = 27
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "DMULT"
  GetOpBits = 28
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "DMULTU"
  GetOpBits = 29
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "MULT"
  GetOpBits = 24
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 Case "MULTU"
  GetOpBits = 25
  opBitMax = BitsOn(6, 26) Or BitsOn(16, 0)
 'Type 6: rd
 Case "MFHI"
  GetOpBits = 16
  opBitMax = BitsOn(16, 16) Or BitsOn(11, 0)
 Case "MFLO"
  GetOpBits = 18
  opBitMax = BitsOn(16, 16) Or BitsOn(11, 0)
 Case "MTHI"
  GetOpBits = 17
  opBitMax = BitsOn(16, 16) Or BitsOn(11, 0)
 Case "MTLO"
  GetOpBits = 19
  opBitMax = BitsOn(16, 16) Or BitsOn(11, 0)
 'Type 7: LUI rt,imm
 Case "LUI"
  GetOpBits = SLL(15, 26)
  opBitMax = BitsOn(11, 21)
 'Type 8: rs,rt,offset
 Case "BEQ"
  GetOpBits = SLL(4, 26)
  opBitMax = BitsOn(6, 26)
 Case "BEQL"
  GetOpBits = SLL(20, 26)
  opBitMax = BitsOn(6, 26)
 Case "BNE"
  GetOpBits = SLL(5, 26)
  opBitMax = BitsOn(6, 26)
 Case "BNEL"
  GetOpBits = SLL(21, 26)
  opBitMax = BitsOn(6, 26)
 'Type 9: rs,offset
 Case "BGEZ"
  GetOpBits = SLL(1, 26) Or SLL(1, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BGEZAL"
  GetOpBits = SLL(1, 26) Or SLL(17, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BGEZALL"
  GetOpBits = SLL(1, 26) Or SLL(19, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BGEZL"
  GetOpBits = SLL(1, 26) Or SLL(3, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BGTZ"
  GetOpBits = SLL(7, 26)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BGTZL"
  GetOpBits = SLL(23, 26)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLEZ"
  GetOpBits = SLL(6, 26)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLEZL"
  GetOpBits = SLL(22, 26)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLTZ"
  GetOpBits = SLL(1, 26)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLTZAL"
  GetOpBits = SLL(1, 26) Or SLL(16, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLTZALL"
  GetOpBits = SLL(1, 26) Or SLL(18, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "BLTZL"
  GetOpBits = SLL(1, 26) Or SLL(2, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 'Type 10: target
 Case "J"
  GetOpBits = SLL(2, 26)
  opBitMax = BitsOn(6, 26)
 Case "JAL"
  GetOpBits = SLL(3, 26)
  opBitMax = BitsOn(6, 26)
 'Type 11: JALR rs,rd
 Case "JALR"
  GetOpBits = 9
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16) Or BitsOn(11, 0)
 'Type 12: JR rs
 Case "JR"
  GetOpBits = 8
  opBitMax = BitsOn(6, 26) Or BitsOn(21, 0)
 'Type 13: rs,rt
 Case "TEQ"
  GetOpBits = 52
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "TGE"
  GetOpBits = 48
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "TGEU"
  GetOpBits = 49
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "TLT"
  GetOpBits = 50
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "TLTU"
  GetOpBits = 51
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "TNE"
  GetOpBits = 54
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 'Type 14: rs,imm
 Case "TEQI"
  GetOpBits = SLL(12, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "TGEI"
  GetOpBits = SLL(8, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "TGEIU"
  GetOpBits = SLL(9, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "TLTI"
  GetOpBits = SLL(10, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "TLTIU"
  GetOpBits = SLL(11, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 Case "TNEI"
  GetOpBits = SLL(14, 16)
  opBitMax = BitsOn(6, 26) Or BitsOn(5, 16)
 'Type 15: Special shit - offest
 Case "BREAK"
  GetOpBits = 13
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 Case "SYSCALL"
  GetOpBits = 12
  opBitMax = BitsOn(6, 26) Or BitsOn(6, 0)
 'SYNC
 Case "SYNC"
  GetOpBits = 15
  opBitMax = BitsOn(21, 11) Or BitsOn(6, 0)
 'Type 16: COP0
 Case "ERET"
  GetOpBits = SLL(16, 26) Or 24
  opBitMax = BitsOn(6, 26) Or BitsOn(25, 0)
 Case "TLBP"
  GetOpBits = SLL(16, 26) Or 8
  opBitMax = BitsOn(6, 26) Or BitsOn(25, 0)
 Case "TLBR"
  GetOpBits = SLL(16, 26) Or 1
  opBitMax = BitsOn(21, 11) Or BitsOn(25, 0)
 Case "TLBWI"
  GetOpBits = SLL(16, 26) Or 2
  opBitMax = BitsOn(6, 26) Or BitsOn(25, 0)
 Case "TLBWR"
  GetOpBits = SLL(16, 26) Or 6
  opBitMax = BitsOn(6, 26) Or BitsOn(25, 0)
 'Type 17: CACHE op,offset(base)
 Case "CACHE"
  GetOpBits = SLL(47, 26)
  opBitMax = BitsOn(6, 26)
 'Type 18: MxC0 rt,fs
 Case "MFC0"
  GetOpBits = SLL(16, 26)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "MTC0"
  GetOpBits = SLL(16, 26) Or SLL(4, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 'COP1
 'Type 19: fd,fs
 Case "ABS.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 5
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "ABS.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 5
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CEIL.L.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 10
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CEIL.L.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 10
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CEIL.W.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 14
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CEIL.W.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 14
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.D.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 33
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.D.W"
  GetOpBits = SLL(17, 26) Or SLL(20, 21) Or 33
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.D.L"
  GetOpBits = SLL(17, 26) Or SLL(21, 21) Or 33
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.L.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 37
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.L.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 37
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.S.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 32
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.S.W"
  GetOpBits = SLL(17, 26) Or SLL(20, 21) Or 32
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.S.L"
  GetOpBits = SLL(17, 26) Or SLL(21, 21) Or 32
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.W.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 36
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "CVT.W.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 36
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "FLOOR.L.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 11
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "FLOOR.L.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 11
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "FLOOR.W.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 15
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "FLOOR.W.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 15
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "MOV.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 6
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "MOV.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 6
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "NEG.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 7
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "NEG.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 7
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "ROUND.L.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 8
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "ROUND.L.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 8
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "ROUND.W.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 12
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "ROUND.W.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 12
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "SQRT.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 4
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "SQRT.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 4
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "TRUNC.L.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 9
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "TRUNC.L.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 9
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "TRUNC.W.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 13
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 Case "TRUNC.W.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 13
  opBitMax = BitsOn(16, 16) Or BitsOn(6, 0)
 'Type 20: fd,fs,ft
 Case "ADD.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "ADD.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "DIV.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 3
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "DIV.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 3
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "MUL.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 2
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "MUL.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 2
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "SUB.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or 1
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 Case "SUB.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or 1
  opBitMax = BitsOn(11, 21) Or BitsOn(6, 0)
 'Type 21: rt,fs
 Case "CFC1"
  GetOpBits = SLL(17, 26) Or SLL(2, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "CTC1"
  GetOpBits = SLL(17, 26) Or SLL(6, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "DMFC1"
  GetOpBits = SLL(17, 26) Or SLL(1, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "DMTC1"
  GetOpBits = SLL(17, 26) Or SLL(5, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "MFC1"
  GetOpBits = SLL(17, 26)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 Case "MTC1"
  GetOpBits = SLL(17, 26) Or SLL(4, 21)
  opBitMax = BitsOn(11, 21) Or BitsOn(11, 0)
 'Type 22: ft,offset(base)
 Case "LDC1"
  GetOpBits = SLL(53, 26)
  opBitMax = BitsOn(6, 26)
 Case "LWC1", "L.S"
  GetOpBits = SLL(49, 26)
  opBitMax = BitsOn(6, 26)
 Case "SDC1"
  GetOpBits = SLL(61, 26)
  opBitMax = BitsOn(6, 26)
 Case "SWC1", "S.S"
  GetOpBits = SLL(57, 26)
  opBitMax = BitsOn(6, 26)
 'Type 23: offset
 Case "BC1F"
  GetOpBits = SLL(17, 26) Or SLL(8, 21)
  opBitMax = BitsOn(16, 16)
 Case "BC1FL"
  GetOpBits = SLL(17, 26) Or SLL(8, 21) Or SLL(1, 18)
  opBitMax = BitsOn(16, 16)
 Case "BC1T"
  GetOpBits = SLL(17, 26) Or SLL(8, 21) Or SLL(1, 17)
  opBitMax = BitsOn(16, 16)
 Case "BC1TL"
  GetOpBits = SLL(17, 26) Or SLL(8, 21) Or SLL(3, 17)
  opBitMax = BitsOn(16, 16)
 'Type 24: C.Cond.Fmt fs,ft
 Case "C.F.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4)
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.UN.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 1
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.EQ.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 2
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.UEQ.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 3
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.OLT.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 4
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.ULT.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 5
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.OLE.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 6
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.ULE.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 7
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.SF.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 8
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGLE.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 9
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.SEQ.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 10
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGL.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 11
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.LT.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 12
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGE.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 13
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.LE.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 14
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGT.S"
  GetOpBits = SLL(17, 26) Or SLL(16, 21) Or SLL(3, 4) Or 15
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.F.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4)
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.UN.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 1
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.EQ.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 2
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.UEQ.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 3
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.OLT.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 4
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.ULT.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 5
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.OLE.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 6
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.ULE.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 7
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.SF.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 8
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGLE.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 9
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.SEQ.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 10
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGL.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 11
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.LT.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 12
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGE.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 13
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.LE.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 14
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 Case "C.NGT.D"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 15
  opBitMax = BitsOn(6, 26) Or BitsOn(11, 0)
 'Pseudo OPs
 Case "NOP"
  GetOpBits = SLL(17, 26) Or SLL(17, 21) Or SLL(3, 4) Or 0
  opBitMax = BitsOn(32, 0)
 Case Else
  GetOpBits = 0
  opBitMax = 0
End Select
End Function
Private Function BitsOn(ByVal bits As Byte, ByVal pos As Byte) As Long
 BitsOn = SLL(SRL(&HFFFFFFFF, (32 - bits)), pos)
End Function

