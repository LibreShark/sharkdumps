VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.MDIForm MainMDI 
   BackColor       =   &H8000000C&
   Caption         =   "Renegade v1.7: Anti-GSC Edition (Kodewerx 0wnz j00!)"
   ClientHeight    =   8985
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   11985
   Icon            =   "MainMDI.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog FileDlg 
      Left            =   11520
      Top             =   8520
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
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
      Begin VB.Menu mnuMemEdit 
         Caption         =   "Memory Editor"
      End
      Begin VB.Menu mnuEmuAttach 
         Caption         =   "Attach To Emulator"
      End
      Begin VB.Menu mnuEmuDetach 
         Caption         =   "Detach From Emulator"
         Enabled         =   0   'False
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
      Begin VB.Menu mnuOptions 
         Caption         =   "Options"
         Begin VB.Menu mnuCSOptions 
            Caption         =   "Code Searcher"
         End
      End
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
      Begin VB.Menu mnuHexCalc 
         Caption         =   "Hex Calculator"
      End
      Begin VB.Menu mnuCodeFormat 
         Caption         =   "Code Formatter"
      End
      Begin VB.Menu mnuActWriter 
         Caption         =   "N64 Activator Writer"
      End
   End
End
Attribute VB_Name = "MainMDI"
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
Private Const frmName = "Renegade v1.7: Anti-GSC Edition (Kodewerx 0wnz j00!)"
Private Sub MDIForm_Load()
Dim tmptext As String, spltxt() As String
Dim blah As Integer
dlgSplash.Show vbModal
tmptext = StrReverse("92%12%03%03%A6%02%A7%E6%77%03%02%87%27%56%77%56%46%F6%B4%82%02%E6%F6%96%47%96%46%54%02%34%35%74%D2%96%47%E6%14%02%A3%73%E2%13%67%02%56%46%16%76%56%E6%56%25")
spltxt = Split(tmptext, "%")
tmptext = ""
For blah = 0 To UBound(spltxt)
 tmptext = tmptext & Chr(CLng("&H" & spltxt(blah)))
Next
If Len(tmptext) = 53 Then MainMDI.Caption = tmptext
If tmptext <> frmName Then Unload MainMDI
DefaultResPath = App.path & "\searches\"
DefaultTextEditor = "notepad.exe"
EmuId(0) = -1
'EmuId(3) = -1
End Sub
Private Sub KillApp_Click()
 Unload MainMDI
End Sub
Private Sub OpenDisassembler_Click()
  Disassembler.Show
End Sub
Private Sub mnuCodeSearch_Click()
  CodeSearch.Show
End Sub
Private Sub mnuByteSwap_Click()
  ByteSwapTool.Show
End Sub
Private Sub mnuCodePort_Click()
  CodePortTool.Show
End Sub
Private Sub mnu007Calc_Click()
  GE007TTcalc.Show
End Sub
Private Sub mnuUnpatcher_Click()
  Unpatcher.Show
End Sub
Private Sub mnuGSDis_Click()
  DisGS.Show
End Sub
Private Sub mnuGSASM_Click()
  asmGS.Show
End Sub
Private Sub mnuEmuCheat_Click()
  EmuCheat.Show
End Sub
Private Sub mnuMemEdit_Click()
  MemEditor.Show
End Sub
Public Sub mnuEmuAttach_Click()
 EmuId(0) = -1
 dlgEmuAttach.ReadEmuVars
 dlgEmuAttach.Show vbModal
 If EmuId(0) <> -1 Then
  mnuEmuAttach.Enabled = False
  mnuEmuDetach.Enabled = True
  MainMDI.Caption = frmName & " ~ " & EmuName
 End If
 If OpenTools(3) Then CodeSearch.SetEmuVarsCS
 If OpenTools(4) Then Disassembler.EmuVarsDis
 If OpenTools(7) Then EmuCheat.EmuVarsTrn
 If OpenTools(9) Then MemEditor.SetEmuVarsME
 If OpenTools(0) Then asmGS.SetEmuVarsASM
End Sub
Public Sub mnuEmuDetach_Click()
 mnuEmuAttach.Enabled = True
 mnuEmuDetach.Enabled = False
 MainMDI.Caption = frmName
 EmuId(0) = -1
' EmuId(3) = -1
 If OpenTools(3) Then CodeSearch.UnSetEmuVarsCS
 If OpenTools(4) Then Disassembler.EmuVarsDis
 If OpenTools(7) Then EmuCheat.EmuVarsTrn
 If OpenTools(9) Then MemEditor.SetEmuVarsME
 If OpenTools(0) Then asmGS.SetEmuVarsASM
End Sub
Private Sub mnuCSOptions_Click()
 dlgOptionsCS.Show vbModal
 If OpenTools(3) Then CodeSearch.SetCSOptions
End Sub
Private Sub mnuSearchR4300i_Click()
 ' DisSearch.Show
End Sub
Private Sub mnuHexCalc_Click()
  HexCalc.Show
End Sub
Private Sub mnuCodeFormat_Click()
 CodeFormat.Show
End Sub
Private Sub mnuActWriter_Click()
 ActWriter.Show
End Sub

'headers for other emulator saves
'new disassembler - inline

