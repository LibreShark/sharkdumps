Attribute VB_Name = "r4300i_dis"
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
Public OPprintType As Byte
Public GPRnames() As String
Public FPRnames() As String
Public CP0names() As String
Public fmt(31) As String
Public Const GPRNameList1 As String = "$ZERO,$AT,$V0,$V1,$A0,$A1,$A2,$A3,$T0,$T1,$T2,$T3,$T4,$T5,$T6,$T7,$S0,$S1,$S2,$S3,$S4,$S5,$S6,$S7,$T8,$T9,$K0,$K1,$GP,$SP,$S8,$RA"
Public Const GPRNameList2 As String = "ZERO,AT,V0,V1,A0,A1,A2,A3,T0,T1,T2,T3,T4,T5,T6,T7,S0,S1,S2,S3,S4,S5,S6,S7,T8,T9,K0,K1,GP,SP,S8,RA"
Public Const GPRNameList3 As String = "R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31"
Public Const FPRNameList1 As String = "F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31"
Public Const CP0NameList1 As String = "Index,Random,EntryLo0,EntryLo1,Context,PageMask,Wired,*RESERVED*,BadVAddr,Count,EntryHi,Compare,Status,Cause,EPC,PRevID,Config,LLAddr,WatchLo,WatchHi,XContext,*RESERVED*,*RESERVED*,*RESERVED*,*RESERVED*,*RESERVED*,PErr,CacheErr,TagLo,TagHi,ErrorEPC,*RESERVED*"
Public immpre As String
Public Function Disassemble(ByVal Haddy As Long, ByVal Hvalue As Long) As String
Dim numSPC As Byte
numSPC = 10
Disassemble = "?"
'immpre = "0x"
Select Case Hvalue
 Case 0, 603979776
  Disassemble = ("NOP")
  Exit Function
 Case 15
  Disassemble = ("SYNC")
  Exit Function
' Case Else
'  Disassemble = "?"
End Select

Select Case SRL(Hvalue, 26)
 Case 0
  If (Hvalue And 2097151) = 8 Then
   Disassemble = ("JR" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2047) = 9) And ((SRL(Hvalue, 16) And 31) = 0) Then
   Disassemble = ("JALR" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2047) = 32) Then
   Disassemble = ("ADD" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 33) Then
   Disassemble = ("ADDU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 36) Then
   Disassemble = ("AND" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 44) Then
   Disassemble = ("DADD" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 45) Then
   Disassemble = ("DADDU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 30) Then
   Disassemble = ("DDIV" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 31) Then
   Disassemble = ("DDIVU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 26) Then
   Disassemble = ("DIV" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 27) Then
   Disassemble = ("DIVU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 28) Then
   Disassemble = ("DMULT" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 29) Then
   Disassemble = ("DMULTU" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 56) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSLL" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 63) = 60) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSLL32" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 20) Then
   Disassemble = ("DSLLV" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 63) = 59) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSRA" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 63) = 63) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSRA32" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 23) Then
   Disassemble = ("DSRAV" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 63) = 58) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSRL" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 63) = 62) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("DSRL32" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 22) Then
   Disassemble = ("DSRLV" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2047) = 46) Then
   Disassemble = ("DSUB" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 47) Then
   Disassemble = ("DSUBU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 16) And ((SRL(Hvalue, 16) And 1023) = 0) Then
   Disassemble = ("MFHI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 18) And ((SRL(Hvalue, 16) And 1023) = 0) Then
   Disassemble = ("MFLO" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2097151) = 17) Then
   Disassemble = ("MTHI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2097151) = 19) Then
   Disassemble = ("MTLO" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 65535) = 24) Then
   Disassemble = ("MULT" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 65535) = 25) Then
   Disassemble = ("MULTU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 39) Then
   Disassemble = ("NOR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 37) Then
   Disassemble = ("OR" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 0) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("SLL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 4) Then
   Disassemble = ("SLLV" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2047) = 42) Then
   Disassemble = ("SLT" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 43) Then
   Disassemble = ("SLTU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 3) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("SRA" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 7) Then
   Disassemble = ("SRAV" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 63) = 2) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("SRL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 31))
  ElseIf ((Hvalue And 2047) = 6) Then
   Disassemble = ("SRLV" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31))
  ElseIf ((Hvalue And 2047) = 34) Then
   Disassemble = ("SUB" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 35) Then
   Disassemble = ("SUBU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 2047) = 38) Then
   Disassemble = ("XOR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 11) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 13) Then
   Disassemble = ("BREAK" & Space(numSPC - 5) & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 12) Then
   Disassemble = ("SYSCALL" & Space(numSPC - 7) & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 52) Then
   Disassemble = ("TEQ" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 48) Then
   Disassemble = ("TGE" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 49) Then
   Disassemble = ("TGEU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 50) Then
   Disassemble = ("TLT" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 50) Then
   Disassemble = ("TLTU" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
  ElseIf ((Hvalue And 63) = 50) Then
   Disassemble = ("TNE" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & Hex(SRL(Hvalue, 6) And 1048575))
'  Else: Disassemble = "?"
  End If
 Case 1
  If ((SRL(Hvalue, 16) And 31) = 1) Then
   Disassemble = ("BGEZ" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 17) Then
   Disassemble = ("BGEZAL" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 19) Then
   Disassemble = ("BGEZALL" & Space(numSPC - 7) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 3) Then
   Disassemble = ("BGEZL" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 0) Then
   Disassemble = ("BLTZ" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 16) Then
   Disassemble = ("BLTZAL" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 18) Then
   Disassemble = ("BLTZALL" & Space(numSPC - 7) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 2) Then
   Disassemble = ("BLTZL" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 16) And 31) = 12) Then
   Disassemble = ("TEQI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
  ElseIf ((SRL(Hvalue, 16) And 31) = 8) Then
   Disassemble = ("TGEI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
  ElseIf ((SRL(Hvalue, 16) And 31) = 9) Then
   Disassemble = ("TGEIU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
  ElseIf ((SRL(Hvalue, 16) And 31) = 10) Then
   Disassemble = ("TLTI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
  ElseIf ((SRL(Hvalue, 16) And 31) = 11) Then
   Disassemble = ("TLTIU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
  ElseIf ((SRL(Hvalue, 16) And 31) = 14) Then
   Disassemble = ("TNEI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
'  Else: Disassemble = "?"
  End If
 Case 2: Disassemble = ("J" & Space(numSPC - 1) & immpre & HexString((Hvalue And 67108863) * 4, 8))
 Case 3: Disassemble = ("JAL" & Space(numSPC - 3) & immpre & HexString((Hvalue And 67108863) * 4, 8))
 Case 4: Disassemble = ("BEQ" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 5: Disassemble = ("BNE" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 6: Disassemble = ("BLEZ" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 7: Disassemble = ("BGTZ" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 8: Disassemble = ("ADDI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 9: Disassemble = ("ADDIU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 10: Disassemble = ("SLTI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 11: Disassemble = ("SLTIU" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 12: Disassemble = ("ANDI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 13: Disassemble = ("ORI" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 14: Disassemble = ("XORI" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 15: Disassemble = ("LUI" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 16
  If ((Hvalue And 33554431) = 24) Then
   Disassemble = ("ERET")
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("MFC0" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & CP0names(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 4) Then
   Disassemble = ("MTC0" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & CP0names(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 33554431) = 8) Then
   Disassemble = ("TLBP")
  ElseIf ((Hvalue And 33554431) = 1) Then
   Disassemble = ("TLBR")
  ElseIf ((Hvalue And 33554431) = 2) Then
   Disassemble = ("TLBWI")
  ElseIf ((Hvalue And 33554431) = 6) Then
   Disassemble = ("TLBWR")
'  Else: Disassemble = "?"
  End If
 Case 17
  If ((Hvalue And 63) = 5) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("ABS." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((SRL(Hvalue, 21) And 31) = 8) And ((SRL(Hvalue, 16) And 31) = 0) Then
   Disassemble = ("BC1F" & Space(numSPC - 4) & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 21) And 31) = 8) And ((SRL(Hvalue, 16) And 31) = 2) Then
   Disassemble = ("BC1FL" & Space(numSPC - 5) & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 21) And 31) = 8) And ((SRL(Hvalue, 16) And 31) = 1) Then
   Disassemble = ("BC1T" & Space(numSPC - 4) & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((SRL(Hvalue, 21) And 31) = 8) And ((SRL(Hvalue, 16) And 31) = 3) Then
   Disassemble = ("BC1TL" & Space(numSPC - 5) & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
  ElseIf ((Hvalue And 63) = 10) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CEIL.L." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 8) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 14) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CEIL.W." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 8) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 2) Then
   Disassemble = ("CFC1" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 6) Then
   Disassemble = ("CTC1" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 33) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CVT.D." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 37) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CVT.L." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 32) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CVT.S." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 36) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("CVT.W." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 1) Then
   Disassemble = ("DMFC1" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 5) Then
   Disassemble = ("DMTC1" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 11) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("FLOOR.L." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 15) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("FLOOR.W." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 0) Then
   Disassemble = ("MFC1" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 2047) = 0) And ((SRL(Hvalue, 21) And 31) = 4) Then
   Disassemble = ("MTC1" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 16) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 6) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("MOV." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 7) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("NEG." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 8) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("ROUND.L." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 12) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("ROUND.W." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 4) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("SQRT." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 9) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("TRUNC.L." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 13) And ((SRL(Hvalue, 16) And 31) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("TRUNC.W." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 9) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31))
  ElseIf ((Hvalue And 63) = 0) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("ADD." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 3) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("DIV." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 2) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("MUL." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((Hvalue And 63) = 1) And isFMT(SRL(Hvalue, 21) And 31) Then
   Disassemble = ("SUB." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 6) And 31) & "," & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
  ElseIf ((SRL(Hvalue, 4) And 127) = 3) And isFMT(SRL(Hvalue, 21) And 31) Then
   Select Case (Hvalue And 15)
    Case 0: Disassemble = ("C." & "F." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 5) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 1: Disassemble = ("C." & "UN." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 2: Disassemble = ("C." & "EQ." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 3: Disassemble = ("C." & "UEQ." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 4: Disassemble = ("C." & "OLT." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 5: Disassemble = ("C." & "ULT." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 6: Disassemble = ("C." & "OLE." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 7: Disassemble = ("C." & "ULE." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 8: Disassemble = ("C." & "SF." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 9: Disassemble = ("C." & "NGLE." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 8) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 10: Disassemble = ("C." & "SEQ." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 11: Disassemble = ("C." & "NGL." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 12: Disassemble = ("C." & "LT." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 13: Disassemble = ("C." & "NGE." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 14: Disassemble = ("C." & "LE." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 6) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
    Case 15: Disassemble = ("C." & "NGT." & fmt((SRL(Hvalue, 21) And 31)) & Space(numSPC - 7) & FPRnames(SRL(Hvalue, 11) And 31) & "," & FPRnames(SRL(Hvalue, 16) And 31))
   End Select
 ' Else: Disassemble = "?"
  End If
 Case 20: Disassemble = ("BEQL" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 21: Disassemble = ("BNEL" & Space(numSPC - 4) & GPRnames(SRL(Hvalue, 21) And 31) & "," & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 22: Disassemble = ("BLEZL" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 23: Disassemble = ("BGTZL" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(CalcBranch(Haddy, Hvalue And 65535), 8))
 Case 24: Disassemble = ("DADDI" & Space(numSPC - 5) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 25: Disassemble = ("DADDIU" & Space(numSPC - 6) & GPRnames(SRL(Hvalue, 16) And 31) & "," & GPRnames(SRL(Hvalue, 21) And 31) & "," & immpre & HexString(Hvalue And 65535, 4))
 Case 26: Disassemble = ("LDL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 27: Disassemble = ("LDR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 32: Disassemble = ("LB" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 33: Disassemble = ("LH" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 34: Disassemble = ("LWL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 35: Disassemble = ("LW" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 36: Disassemble = ("LBU" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 37: Disassemble = ("LHU" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 38: Disassemble = ("LWR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 39: Disassemble = ("LWU" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 40: Disassemble = ("SB" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 41: Disassemble = ("SH" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 42: Disassemble = ("SWL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 43: Disassemble = ("SW" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 44: Disassemble = ("SDL" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 45: Disassemble = ("SDR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 46: Disassemble = ("SWR" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 47: Disassemble = ("CACHE" & Space(numSPC - 5) & CP0names(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 48: Disassemble = ("LL" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 49: Disassemble = ("LWC1" & Space(numSPC - 4) & FPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 52: Disassemble = ("LLD" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 53: Disassemble = ("LDC1" & Space(numSPC - 4) & FPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 55: Disassemble = ("LD" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 56: Disassemble = ("SC" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 57: Disassemble = ("SWC1" & Space(numSPC - 4) & FPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 60: Disassemble = ("SCD" & Space(numSPC - 3) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 61: Disassemble = ("SDC1" & Space(numSPC - 4) & FPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
 Case 63: Disassemble = ("SD" & Space(numSPC - 2) & GPRnames(SRL(Hvalue, 16) And 31) & "," & immpre & HexString(Hvalue And 65535, 4) & "(" & GPRnames(SRL(Hvalue, 21) And 31) & ")")
' Case Else: Disassemble = "?"
End Select
End Function
Private Function CalcBranch(ByVal Baddy As Long, ByVal Bvalue As Long) As Long
 If Bvalue > 32767 Then Bvalue = 0 - (65536 - Bvalue)
 CalcBranch = (Baddy + 4) + (Bvalue * 4)
End Function
Private Function isFMT(ByVal fmtBits As Byte) As Boolean
 Select Case fmtBits
  Case 16, 17, 20, 21
   isFMT = True
  Case Else
   isFMT = False
 End Select
End Function
