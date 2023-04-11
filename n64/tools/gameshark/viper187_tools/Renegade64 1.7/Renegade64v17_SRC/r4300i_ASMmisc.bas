Attribute VB_Name = "r4300i_ASMmisc"
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
Public Function GetImm(ByRef Immediate As String) As Long
'GetImm = -1
'On Error Resume Next
'GetImm = CLng("&H" & Replace(Replace(Immediate, "0X", ""), "$", ""))
Immediate = Replace(Replace(Replace(Immediate, "0X", ""), "$", ""), "*", "")
If IsHex(Immediate) Then
 GetImm = CLng("&H" & Immediate)
Else
 GetImm = -1
End If
End Function
Public Function GetRegValue(ByRef reg As String) As Long
Select Case reg
 Case "R00", "R0", "$ZERO", "ZERO"
  GetRegValue = 0
 Case "R01", "R1", "$AT", "AT"
  GetRegValue = 1
 Case "R02", "R2", "$V0", "V0"
  GetRegValue = 2
 Case "R03", "R3", "$V1", "V1"
  GetRegValue = 3
 Case "R04", "R4", "$A0", "A0"
  GetRegValue = 4
 Case "R05", "R5", "$A1", "A1"
  GetRegValue = 5
 Case "R06", "R6", "$A2", "A2"
  GetRegValue = 6
 Case "R07", "R7", "$A3", "A3"
  GetRegValue = 7
 Case "R08", "R8", "$T0", "T0"
  GetRegValue = 8
 Case "R09", "R9", "$T1", "T1"
  GetRegValue = 9
 Case "R10", "$T2", "T2"
  GetRegValue = 10
 Case "R11", "$T3", "T3"
  GetRegValue = 11
 Case "R12", "$T4", "T4"
  GetRegValue = 12
 Case "R13", "$T5", "T5"
  GetRegValue = 13
 Case "R14", "$T6", "T6"
  GetRegValue = 14
 Case "R15", "$T7", "T7"
  GetRegValue = 15
 Case "R16", "$S0", "S0"
  GetRegValue = 16
 Case "R17", "$S1", "S1"
  GetRegValue = 17
 Case "R18", "$S2", "S2"
  GetRegValue = 18
 Case "R19", "$S3", "S3"
  GetRegValue = 19
 Case "R20", "$S4", "S4"
  GetRegValue = 20
 Case "R21", "$S5", "S5"
  GetRegValue = 21
 Case "R22", "$S6", "S6"
  GetRegValue = 22
 Case "R23", "$S7", "S7"
  GetRegValue = 23
 Case "R24", "$T8", "T8"
  GetRegValue = 24
 Case "R25", "$T9", "T9"
  GetRegValue = 25
 Case "R26", "$K0", "K0"
  GetRegValue = 26
 Case "R27", "$K1", "K1"
  GetRegValue = 27
 Case "R28", "$GP", "GP"
  GetRegValue = 28
 Case "R29", "$SP", "SP"
  GetRegValue = 29
 Case "R30", "$S8", "S8"
  GetRegValue = 30
 Case "R31", "$RA", "RA"
  GetRegValue = 31
 Case Else
  GetRegValue = 32
 End Select
End Function
Public Function GetFPRValue(ByRef reg As String) As Long
'f21 - f25, and f31 are reserved and the others are for error handling (exceptions and etc) F7 is also reserved
Select Case reg
 Case "$F0", "F0", "F00", "FPR0"
  GetFPRValue = 0
 Case "$F1", "F1", "F01", "FPR1"
  GetFPRValue = 1
 Case "$F2", "F2", "F02", "FPR2"
  GetFPRValue = 2
 Case "$F3", "F3", "F03", "FPR3"
  GetFPRValue = 3
 Case "$F4", "F4", "F04", "FPR4"
  GetFPRValue = 4
 Case "$F5", "F5", "F05", "FPR5"
  GetFPRValue = 5
 Case "$F6", "F6", "F06", "FPR6"
  GetFPRValue = 6
 Case "$F7", "F7", "F07", "FPR7"
  GetFPRValue = 7
 Case "$F8", "F8", "F08", "FPR8"
  GetFPRValue = 8
 Case "$F9", "F9", "F09", "FPR9"
  GetFPRValue = 9
 Case "$F10", "F10", "FPR10"
  GetFPRValue = 10
 Case "$F11", "F11", "FPR11"
  GetFPRValue = 11
 Case "$F12", "F12", "FPR12"
  GetFPRValue = 12
 Case "$F13", "F13", "FPR13"
  GetFPRValue = 13
 Case "$F14", "F14", "FPR14"
  GetFPRValue = 14
 Case "$F15", "F15", "FPR15"
  GetFPRValue = 15
 Case "$F16", "F16", "FPR16"
  GetFPRValue = 16
 Case "$F17", "F17", "FPR17"
  GetFPRValue = 17
 Case "$F18", "F18", "FPR18"
  GetFPRValue = 18
 Case "$F19", "F19", "FPR19"
  GetFPRValue = 19
 Case "$F20", "F20", "FPR20"
  GetFPRValue = 20
 Case "$F21", "F21", "FPR21"
  GetFPRValue = 21
 Case "$F22", "F22", "FPR22"
  GetFPRValue = 22
 Case "$F23", "F23", "FPR23"
  GetFPRValue = 23
 Case "$F24", "F24", "FPR24"
  GetFPRValue = 24
 Case "$F25", "F25", "FPR25"
  GetFPRValue = 20
 Case "$F26", "F26", "FPR26"
  GetFPRValue = 26
 Case "$F27", "F27", "FPR27"
  GetFPRValue = 27
 Case "$F28", "F28", "FPR28"
  GetFPRValue = 28
 Case "$F29", "F29", "FPR29"
  GetFPRValue = 29
 Case "$F30", "F30", "FPR30"
  GetFPRValue = 30
 Case "$F31", "F31", "FPR31"
  GetFPRValue = 31
 Case Else
  GetFPRValue = 32
End Select
End Function
Public Function GetCOP0RValue(ByRef reg As String) As Long
Select Case reg
 Case "INDEX"
  GetCOP0RValue = 0
 Case "RANDOM"
  GetCOP0RValue = 1
 Case "ENTRYLO0"
  GetCOP0RValue = 2
 Case "ENTRYLO1"
  GetCOP0RValue = 3
 Case "CONTEXT"
  GetCOP0RValue = 4
 Case "PAGEMASK"
  GetCOP0RValue = 5
 Case "WIRED"
  GetCOP0RValue = 6
 Case "BADVADDR"
  GetCOP0RValue = 8
 Case "COUNT"
  GetCOP0RValue = 9
 Case "ENTRYHI"
  GetCOP0RValue = 10
 Case "COMPARE"
  GetCOP0RValue = 11
 Case "STATUS"
  GetCOP0RValue = 12
 Case "CAUSE"
  GetCOP0RValue = 13
 Case "EPC"
  GetCOP0RValue = 14
 Case "PREVID"
  GetCOP0RValue = 15
 Case "CONFIG"
  GetCOP0RValue = 16
 Case "LLADDR"
  GetCOP0RValue = 17
 Case "WATCHLO"
  GetCOP0RValue = 18
 Case "WATCHHI"
  GetCOP0RValue = 19
 Case "XCONTEXT"
  GetCOP0RValue = 20
 Case "PERR"
  GetCOP0RValue = 26
 Case "CACHERR"
  GetCOP0RValue = 27
 Case "TAGLO"
  GetCOP0RValue = 28
 Case "TAGHI"
  GetCOP0RValue = 29
 Case "ERREPC"
  GetCOP0RValue = 30
 Case Else
  GetCOP0RValue = 32
End Select
End Function
Public Function GetOpBits(ByRef opBitMax As Long, ByVal opcode As String) As Long
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
Public Function BitsOn(ByVal bits As Byte, ByVal pos As Byte) As Long
 BitsOn = SLL(SRL(&HFFFFFFFF, (32 - bits)), pos)
End Function


