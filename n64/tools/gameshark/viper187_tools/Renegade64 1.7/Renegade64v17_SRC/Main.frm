VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Main 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Renegade64 v1.58"
   ClientHeight    =   8520
   ClientLeft      =   4650
   ClientTop       =   3495
   ClientWidth     =   11895
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "Main.frx":0000
   ScaleHeight     =   568
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   793
   Begin MSComDlg.CommonDialog FileDlg 
      Left            =   11160
      Top             =   7920
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label Label2 
      Caption         =   "©2006 Psycho Snake Creations"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   8160
      Width           =   2655
   End
   Begin VB.Label Label1 
      Caption         =   "Written by Viper187 "
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   7920
      Width           =   1815
   End
   Begin VB.Menu FileMenu 
      Caption         =   "File"
      Begin VB.Menu KillApp 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu CheatMenu 
      Caption         =   "Cheating"
      Begin VB.Menu mnuCodeSearch 
         Caption         =   "Code Search"
      End
      Begin VB.Menu mnuEmuCheat 
         Caption         =   "Trainer / Patcher"
      End
   End
   Begin VB.Menu ASMmenu 
      Caption         =   "ASM"
      Begin VB.Menu OpenDisassembler 
         Caption         =   "R4300i Disassembler"
      End
      Begin VB.Menu mnuGSDis 
         Caption         =   "Disassemble Codes"
      End
      Begin VB.Menu mnuGSASM 
         Caption         =   "Assemble Codes"
      End
   End
   Begin VB.Menu ToolsMenu 
      Caption         =   "Tools"
      Begin VB.Menu mnuByteSwap 
         Caption         =   "Byteswap File"
      End
      Begin VB.Menu mnuCodePort 
         Caption         =   "Code Porter"
      End
      Begin VB.Menu mnuUnpatcher 
         Caption         =   "Patch('50') Code Expander"
      End
      Begin VB.Menu mnu007Calc 
         Caption         =   "Goldeneye Target Time Calc"
      End
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
DefaultResPath = App.path & "\searches\"
DefaultTextEditor = "notepad.exe"
EmuList(1) = "1964"
EmuList(2) = "mupen"
EmuList(3) = "mupen"
EmuList(4) = "nemu"
EmuList(5) = "psxfin"
EmuList(6) = "ssspsx"
EmuList(7) = "no$gba"
EmuOffsets(1) = &H20000000
EmuOffsets(2) = &H8D7CD0
EmuOffsets(3) = &H8DCC00
EmuOffsets(4) = &H10020000
EmuOffsets(5) = &H1B90020
EmuOffsets(6) = &H40000000
EmuOffsets(7) = &H14E100
EmuRAM(1) = &H400000
EmuRAM(2) = &H200000
EmuRAM(3) = &H40000
End Sub
Private Sub KillApp_Click()
 Unload Main
End Sub
Private Sub OpenDisassembler_Click()
 Main.Hide
 Disassembler.Show
End Sub
Private Sub mnuCodeSearch_Click()
 Main.Hide
 CodeSearch.Show
End Sub
Private Sub mnuByteSwap_Click()
 Main.Hide
 ByteSwapTool.Show
End Sub
Private Sub mnuCodePort_Click()
 Main.Hide
 CodePortTool.Show
End Sub
Private Sub mnu007Calc_Click()
 Main.Hide
 GE007TTcalc.Show
End Sub
Private Sub mnuUnpatcher_Click()
' Main.Hide
 Unpatcher.Show
End Sub
Private Sub mnuGSDis_Click()
 Main.Hide
 DisGS.Show
End Sub
Private Sub mnuGSASM_Click()
 Main.Hide
 asmGS.Show
End Sub
Private Sub mnuEmuCheat_Click()
 Main.Hide
 EmuCheat.Show
End Sub

'-rom format swapper
'-code porter
'/base converter
'-007 calc
'-unpatcher
'/Xploder encryption
'/activator tool
'ips/aps/pkpatch
'-ucase hex values
'CRC
'eeprom/memcard dexdrive to emulator?
'show results in VB?
'opcode helper/gs dis?
'rewrite disassembly and use bitmasks like dissearch
'-change ASM funtion for pseudo op usage
'-branches - $ or 0x for immediate
'-disassembler - codes copy/output
'-save page bugs?
'-min/max buttons on forms
'-save text on gs asm/dis
'-open/save on code porter
'disassembler - warn about saving on open,verify open option enabled before save/copy
'-emu code files from code assembler
'-check signing on asm search with addiu/ori
'-search LUI by itself?
'/branch greater/less pseudo ops
'-use AND for wild value searches?
'-within range of previous value search - not equal to by at most
'search - include/exclude matching results
'-fix search results - use output option
'-code assembler output options- 32-bit
'-code dis output options
'prevent searching files with non-matching size and or add option for warning or auto-new search
