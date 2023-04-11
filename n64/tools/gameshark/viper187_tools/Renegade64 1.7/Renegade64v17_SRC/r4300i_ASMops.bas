Attribute VB_Name = "r4300i_ASMops"
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
Public AssembledOP(2) As Long
Public ASMerror As String
Public GSaddy As Long
Public Function MakeOp(ByVal address As Long, ByVal opcode As String) As Boolean
 Dim code As String, vars As String
 ASMerror = ""
 AssembledOP(1) = -1
 AssembledOP(2) = -1
 GSaddy = address
 opcode = UCase(opcode)
 If InStr(opcode, " ") Then
  code = Left(opcode, InStr(opcode, " ") - 1)
  vars = Replace(Mid(opcode, InStr(opcode, " ")), " ", "")
 Else
  code = opcode
  vars = vbNullString
 End If
Select Case code
 'Type 1:  rt,offset(base)
 Case "LB"
  MakeOp = ASMtype1(vars, -2147483648#)
 Case "LBU"
  MakeOp = ASMtype1(vars, -1879048192)
 Case "LD"
  MakeOp = ASMtype1(vars, -603979776)
 Case "LDL"
  MakeOp = ASMtype1(vars, 1744830464)
 Case "LDR"
  MakeOp = ASMtype1(vars, 1811939328)
 Case "LH"
  MakeOp = ASMtype1(vars, -2080374784)
 Case "LHU"
  MakeOp = ASMtype1(vars, -1811939328)
 Case "LL"
  MakeOp = ASMtype1(vars, -1073741824)
 Case "LLD"
  MakeOp = ASMtype1(vars, -805306368)
 Case "LW"
  MakeOp = ASMtype1(vars, -1946157056)
 Case "LWL"
  MakeOp = ASMtype1(vars, -2013265920)
 Case "LWR"
  MakeOp = ASMtype1(vars, -1744830464)
 Case "LWU"
  MakeOp = ASMtype1(vars, -1677721600)
 Case "SB"
  MakeOp = ASMtype1(vars, -1610612736)
 Case "SC"
  MakeOp = ASMtype1(vars, -536870912)
 Case "SCD"
  MakeOp = ASMtype1(vars, -268435456)
 Case "SD"
  MakeOp = ASMtype1(vars, -67108864)
 Case "SDL"
  MakeOp = ASMtype1(vars, -1342177280)
 Case "SDR"
  MakeOp = ASMtype1(vars, -1275068416)
 Case "SH"
  MakeOp = ASMtype1(vars, -1543503872)
 Case "SW"
  MakeOp = ASMtype1(vars, -1409286144)
 Case "SWL"
  MakeOp = ASMtype1(vars, -1476395008)
 Case "SWR"
  MakeOp = ASMtype1(vars, -1207959552)
 'Type 2/33: rd,rs,rt and rd,rt,rs
 Case "ADD"
  MakeOp = ASMtype2(vars, 32)
 Case "ADDU"
  MakeOp = ASMtype2(vars, 33)
 Case "AND"
  MakeOp = ASMtype2(vars, 36)
 Case "DADD"
  MakeOp = ASMtype2(vars, 44)
 Case "DADDU"
  MakeOp = ASMtype2(vars, 45)
 Case "DSLLV"
  MakeOp = ASMtype33(vars, 20)
 Case "DSRAV"
  MakeOp = ASMtype33(vars, 23)
 Case "DSRLV"
  MakeOp = ASMtype33(vars, 22)
 Case "DSUB"
  MakeOp = ASMtype2(vars, 46)
 Case "DSUBU"
  MakeOp = ASMtype2(vars, 47)
 Case "NOR"
  MakeOp = ASMtype2(vars, 39)
 Case "OR"
  MakeOp = ASMtype2(vars, 37)
 Case "SLLV"
  MakeOp = ASMtype33(vars, 4)
 Case "SLT"
  MakeOp = ASMtype2(vars, 42)
 Case "SLTU"
  MakeOp = ASMtype2(vars, 43)
 Case "SRAV"
  MakeOp = ASMtype33(vars, 7)
 Case "SRLV"
  MakeOp = ASMtype33(vars, 6)
 Case "SUB"
  MakeOp = ASMtype2(vars, 34)
 Case "SUBU"
  MakeOp = ASMtype2(vars, 35)
 Case "XOR"
  MakeOp = ASMtype2(vars, 38)
 'Type 3: rd,rt,sa
 Case "DSLL"
  MakeOp = ASMtype3(vars, 56)
 Case "DSLL32"
  MakeOp = ASMtype3(vars, 60)
 Case "DSRA"
  MakeOp = ASMtype3(vars, 59)
 Case "DSRA32"
  MakeOp = ASMtype3(vars, 63)
 Case "DSRL"
  MakeOp = ASMtype3(vars, 58)
 Case "DSRL32"
  MakeOp = ASMtype3(vars, 62)
 Case "SLL"
  MakeOp = ASMtype3(vars, 0)
 Case "SRA"
  MakeOp = ASMtype3(vars, 3)
 Case "SRL"
  MakeOp = ASMtype3(vars, 2)
 'Type 4: rt,rs,imm
 Case "ADDI"
  MakeOp = ASMtype4(vars, 536870912)
 Case "ADDIU"
  MakeOp = ASMtype4(vars, 603979776)
 Case "ANDI"
  MakeOp = ASMtype4(vars, 805306368)
 Case "DADDI"
  MakeOp = ASMtype4(vars, 1610612736)
 Case "DADDIU"
  MakeOp = ASMtype4(vars, 1677721600)
 Case "ORI"
  MakeOp = ASMtype4(vars, 872415232)
 Case "SLTI"
  MakeOp = ASMtype4(vars, 671088640)
 Case "SLTIU"
  MakeOp = ASMtype4(vars, 738197504)
 Case "XORI"
  MakeOp = ASMtype4(vars, 939524096)
 'Type 5: rs,rt
 Case "DDIV"
  MakeOp = ASMtype5(vars, 30)
 Case "DDIVU"
  MakeOp = ASMtype5(vars, 31)
 Case "DIV"
  MakeOp = ASMtype5(vars, 26)
 Case "DIVU"
  MakeOp = ASMtype5(vars, 27)
 Case "DMULT"
  MakeOp = ASMtype5(vars, 28)
 Case "DMULTU"
  MakeOp = ASMtype5(vars, 29)
 Case "MULT"
  MakeOp = ASMtype5(vars, 24)
 Case "MULTU"
  MakeOp = ASMtype5(vars, 25)
 'Type 6: rd
 Case "MFHI"
  MakeOp = ASMtype6(vars, 16, 11)
 Case "MFLO"
  MakeOp = ASMtype6(vars, 18, 11)
 Case "MTHI"
  MakeOp = ASMtype6(vars, 17, 21)
 Case "MTLO"
  MakeOp = ASMtype6(vars, 19, 21)
 'Type 7: LUI rt,imm
 Case "LUI"
  MakeOp = ASMtype7(vars, 1006632960)
 'Type 8: rs,rt,offset
 Case "BEQ"
  MakeOp = ASMtype8(vars, 268435456)
 Case "BEQL"
  MakeOp = ASMtype8(vars, 1342177280)
 Case "BNE"
  MakeOp = ASMtype8(vars, 335544320)
 Case "BNEL"
  MakeOp = ASMtype8(vars, 1409286144)
 'Type 9: rs,offset
 Case "BGEZ"
  MakeOp = ASMtype9(vars, 67108864, 1)
 Case "BGEZAL"
  MakeOp = ASMtype9(vars, 67108864, 17)
 Case "BGEZALL"
  MakeOp = ASMtype9(vars, 67108864, 19)
 Case "BGEZL"
  MakeOp = ASMtype9(vars, 67108864, 3)
 Case "BGTZ"
  MakeOp = ASMtype9(vars, 469762048, 0)
 Case "BGTZL"
  MakeOp = ASMtype9(vars, 1543503872, 0)
 Case "BLEZ"
  MakeOp = ASMtype9(vars, 402653184, 0)
 Case "BLEZL"
  MakeOp = ASMtype9(vars, 1476395008, 0)
 Case "BLTZ"
  MakeOp = ASMtype9(vars, 67108864, 0)
 Case "BLTZAL"
  MakeOp = ASMtype9(vars, 67108864, 16)
 Case "BLTZALL"
  MakeOp = ASMtype9(vars, 67108864, 18)
 Case "BLTZL"
  MakeOp = ASMtype9(vars, 67108864, 2)
 'Type 10: target
 Case "J"
  MakeOp = ASMtype10(vars, 134217728)
 Case "JAL"
  MakeOp = ASMtype10(vars, 201326592)
 'Type 11: JALR rs,rd
 Case "JALR"
  MakeOp = ASMtype11(vars, 9)
 'Type 12: JR rs
 Case "JR"
  MakeOp = ASMtype12(vars, 8)
 'Type 13: rs,rt
 Case "TEQ"
  MakeOp = ASMtype13(vars, 52)
 Case "TGE"
  MakeOp = ASMtype13(vars, 48)
 Case "TGEU"
  MakeOp = ASMtype13(vars, 49)
 Case "TLT"
  MakeOp = ASMtype13(vars, 50)
 Case "TLTU"
  MakeOp = ASMtype13(vars, 51)
 Case "TNE"
  MakeOp = ASMtype13(vars, 54)
 'Type 14: rs,imm
 Case "TEQI"
  MakeOp = ASMtype14(vars, 12)
 Case "TGEI"
  MakeOp = ASMtype14(vars, 8)
 Case "TGEIU"
  MakeOp = ASMtype14(vars, 9)
 Case "TLTI"
  MakeOp = ASMtype14(vars, 10)
 Case "TLTIU"
  MakeOp = ASMtype14(vars, 11)
 Case "TNEI"
  MakeOp = ASMtype14(vars, 14)
 'Type 15: Special shit - offest
 Case "BREAK"
  MakeOp = ASMtype15(vars, 13)
 Case "SYSCALL"
  MakeOp = ASMtype15(vars, 12)
 'SYNC
 Case "SYNC"
  MakeOp = ASMtype00()
 'Type 16: COP0
 Case "ERET"
  MakeOp = ASMtype16(vars, 24)
 Case "TLBP"
  MakeOp = ASMtype16(vars, 8)
 Case "TLBR"
  MakeOp = ASMtype16(vars, 1)
 Case "TLBWI"
  MakeOp = ASMtype16(vars, 2)
 Case "TLBWR"
  MakeOp = ASMtype16(vars, 6)
 'Type 17: CACHE op,offset(base)
 Case "CACHE"
  MakeOp = ASMtype17(vars, 0)
 'Type 18: MxC0 rt,fs
 Case "MFC0"
  MakeOp = ASMtype18(vars, 1073741824)
 Case "MTC0"
  MakeOp = ASMtype18(vars, 1082130432)
 'COP1
 'Type 19: fd,fs
 Case "ABS.S"
  MakeOp = ASMtype19(vars, 1174405120, 5)
 Case "ABS.D"
  MakeOp = ASMtype19(vars, 1176502272, 5)
 Case "CEIL.L.S"
  MakeOp = ASMtype19(vars, 1174405120, 10)
 Case "CEIL.L.D"
  MakeOp = ASMtype19(vars, 1176502272, 10)
 Case "CEIL.W.S"
  MakeOp = ASMtype19(vars, 1174405120, 14)
 Case "CEIL.W.D"
  MakeOp = ASMtype19(vars, 1176502272, 14)
 Case "CVT.D.S"
  MakeOp = ASMtype19(vars, 1174405120, 33)
 Case "CVT.D.W"
  MakeOp = ASMtype19(vars, 1182793728, 33)
 Case "CVT.D.L"
  MakeOp = ASMtype19(vars, 1184890880, 33)
 Case "CVT.L.S"
  MakeOp = ASMtype19(vars, 1174405120, 37)
 Case "CVT.L.D"
  MakeOp = ASMtype19(vars, 1176502272, 37)
 Case "CVT.S.D"
  MakeOp = ASMtype19(vars, 1176502272, 32)
 Case "CVT.S.W"
  MakeOp = ASMtype19(vars, 1182793728, 32)
 Case "CVT.S.L"
  MakeOp = ASMtype19(vars, 1184890880, 32)
 Case "CVT.W.S"
  MakeOp = ASMtype19(vars, 1174405120, 36)
 Case "CVT.W.D"
  MakeOp = ASMtype19(vars, 1176502272, 36)
 Case "FLOOR.L.S"
  MakeOp = ASMtype19(vars, 1174405120, 11)
 Case "FLOOR.L.D"
  MakeOp = ASMtype19(vars, 1176502272, 11)
 Case "FLOOR.W.S"
  MakeOp = ASMtype19(vars, 1174405120, 15)
 Case "FLOOR.W.D"
  MakeOp = ASMtype19(vars, 1176502272, 15)
 Case "MOV.S"
  MakeOp = ASMtype19(vars, 1174405120, 6)
 Case "MOV.D"
  MakeOp = ASMtype19(vars, 1176502272, 6)
 Case "NEG.S"
  MakeOp = ASMtype19(vars, 1174405120, 7)
 Case "NEG.D"
  MakeOp = ASMtype19(vars, 1176502272, 7)
 Case "ROUND.L.S"
  MakeOp = ASMtype19(vars, 1174405120, 8)
 Case "ROUND.L.D"
  MakeOp = ASMtype19(vars, 1176502272, 8)
 Case "ROUND.W.S"
  MakeOp = ASMtype19(vars, 1174405120, 12)
 Case "ROUND.W.D"
  MakeOp = ASMtype19(vars, 1176502272, 12)
 Case "SQRT.S"
  MakeOp = ASMtype19(vars, 1174405120, 4)
 Case "SQRT.D"
  MakeOp = ASMtype19(vars, 1176502272, 4)
 Case "TRUNC.L.S"
  MakeOp = ASMtype19(vars, 1174405120, 9)
 Case "TRUNC.L.D"
  MakeOp = ASMtype19(vars, 1176502272, 9)
 Case "TRUNC.W.S"
  MakeOp = ASMtype19(vars, 1174405120, 13)
 Case "TRUNC.W.D"
  MakeOp = ASMtype19(vars, 1176502272, 13)
 'Type 20: fd,fs,ft
 Case "ADD.S"
  MakeOp = ASMtype20(vars, 1174405120, 0)
 Case "ADD.D"
  MakeOp = ASMtype20(vars, 1176502272, 0)
 Case "DIV.S"
  MakeOp = ASMtype20(vars, 1174405120, 3)
 Case "DIV.D"
  MakeOp = ASMtype20(vars, 1176502272, 3)
 Case "MUL.S"
  MakeOp = ASMtype20(vars, 1174405120, 2)
 Case "MUL.D"
  MakeOp = ASMtype20(vars, 1176502272, 2)
 Case "SUB.S"
  MakeOp = ASMtype20(vars, 1174405120, 1)
 Case "SUB.D"
  MakeOp = ASMtype20(vars, 1176502272, 1)
 'Type 21: rt,fs
 Case "CFC1"
  MakeOp = ASMtype21(vars, 1145044992)
 Case "CTC1"
  MakeOp = ASMtype21(vars, 1153433600)
 Case "DMFC1"
  MakeOp = ASMtype21(vars, 1142947840)
 Case "DMTC1"
  MakeOp = ASMtype21(vars, 1151336448)
 Case "MFC1"
  MakeOp = ASMtype21(vars, 1140850688)
 Case "MTC1"
  MakeOp = ASMtype21(vars, 1149239296)
 'Type 22: ft,offset(base)
 Case "LDC1"
  MakeOp = ASMtype22(vars, -738197504)
 Case "LWC1", "L.S"
  MakeOp = ASMtype22(vars, -1006632960)
 Case "SDC1"
  MakeOp = ASMtype22(vars, -201326592)
 Case "SWC1", "S.S"
  MakeOp = ASMtype22(vars, -469762048)
 'Type 23: offset
 Case "BC1F"
  MakeOp = ASMtype23(vars, 1157627904)
 Case "BC1FL"
  MakeOp = ASMtype23(vars, 1157758976)
 Case "BC1T"
  MakeOp = ASMtype23(vars, 1157693440)
 Case "BC1TL"
  MakeOp = ASMtype23(vars, 1157824512)
 'Type 24: C.Cond.Fmt fs,ft
 Case "C.F.S"
  MakeOp = ASMtype24(vars, 1174405120, 48)
 Case "C.UN.S"
  MakeOp = ASMtype24(vars, 1174405120, 49)
 Case "C.EQ.S"
  MakeOp = ASMtype24(vars, 1174405120, 50)
 Case "C.UEQ.S"
  MakeOp = ASMtype24(vars, 1174405120, 51)
 Case "C.OLT.S"
  MakeOp = ASMtype24(vars, 1174405120, 52)
 Case "C.ULT.S"
  MakeOp = ASMtype24(vars, 1174405120, 53)
 Case "C.OLE.S"
  MakeOp = ASMtype24(vars, 1174405120, 54)
 Case "C.ULE.S"
  MakeOp = ASMtype24(vars, 1174405120, 55)
 Case "C.SF.S"
  MakeOp = ASMtype24(vars, 1174405120, 56)
 Case "C.NGLE.S"
  MakeOp = ASMtype24(vars, 1174405120, 57)
 Case "C.SEQ.S"
  MakeOp = ASMtype24(vars, 1174405120, 58)
 Case "C.NGL.S"
  MakeOp = ASMtype24(vars, 1174405120, 59)
 Case "C.LT.S"
  MakeOp = ASMtype24(vars, 1174405120, 60)
 Case "C.NGE.S"
  MakeOp = ASMtype24(vars, 1174405120, 61)
 Case "C.LE.S"
  MakeOp = ASMtype24(vars, 1174405120, 62)
 Case "C.NGT.S"
  MakeOp = ASMtype24(vars, 1174405120, 63)
 Case "C.F.D"
  MakeOp = ASMtype24(vars, 1176502272, 48)
 Case "C.UN.D"
  MakeOp = ASMtype24(vars, 1176502272, 49)
 Case "C.EQ.D"
  MakeOp = ASMtype24(vars, 1176502272, 50)
 Case "C.UEQ.D"
  MakeOp = ASMtype24(vars, 1176502272, 51)
 Case "C.OLT.D"
  MakeOp = ASMtype24(vars, 1176502272, 52)
 Case "C.ULT.D"
  MakeOp = ASMtype24(vars, 1176502272, 53)
 Case "C.OLE.D"
  MakeOp = ASMtype24(vars, 1176502272, 54)
 Case "C.ULE.D"
  MakeOp = ASMtype24(vars, 1176502272, 55)
 Case "C.SF.D"
  MakeOp = ASMtype24(vars, 1176502272, 56)
 Case "C.NGLE.D"
  MakeOp = ASMtype24(vars, 1176502272, 57)
 Case "C.SEQ.D"
  MakeOp = ASMtype24(vars, 1176502272, 58)
 Case "C.NGL.D"
  MakeOp = ASMtype24(vars, 1176502272, 59)
 Case "C.LT.D"
  MakeOp = ASMtype24(vars, 1176502272, 60)
 Case "C.NGE.D"
  MakeOp = ASMtype24(vars, 1176502272, 61)
 Case "C.LE.D"
  MakeOp = ASMtype24(vars, 1176502272, 62)
 Case "C.NGT.D"
  MakeOp = ASMtype24(vars, 1176502272, 63)
 'Pseudo OPs
 Case "NOP"
  MakeOp = ASMtype25()
 Case "MOVE" 'rd,rs
  MakeOp = ASMtype26(vars, 32)
 Case "NEG" 'rd,rs
  MakeOp = ASMtype26(vars, 34)
 Case "NEGU" 'rd,rs
  MakeOp = ASMtype26(vars, 35)
 Case "BNEZ" 'rs,offset
  MakeOp = ASMtype9(vars, 335544320, 0)
 Case "BNEZL" 'rs,offset
  MakeOp = ASMtype9(vars, 1409286144, 0)
 Case "BEQZ" 'rs,offset
  MakeOp = ASMtype9(vars, 268435456, 0)
 Case "BEQZL" 'rs,offset
  MakeOp = ASMtype9(vars, 1342177280, 0)
 Case "B", "BR", "BRA" 'offset
  MakeOp = ASMtype23(vars, 268435456)
 Case "BAL", "BRL", "BRAL" 'offset
  MakeOp = ASMtype23(vars, 68222976)
 Case "LI" 'offset
  MakeOp = ASMtype27(vars)
 Case "LBI", "LBA" 'offset
  MakeOp = ASMtype28(vars, -2147483648#)
 Case "LBIU", "LBAU" 'offset
  MakeOp = ASMtype28(vars, -1879048192)
 Case "LDI", "LDA" 'offset
  MakeOp = ASMtype28(vars, -603979776)
 Case "LDLI", "LDLA" 'offset
  MakeOp = ASMtype28(vars, 1744830464)
 Case "LDRI", "LDRA" 'offset
  MakeOp = ASMtype28(vars, 1811939328)
 Case "LHI", "LHA" 'offset
  MakeOp = ASMtype28(vars, -2080374784)
 Case "LHIU", "LHAU" 'offset
  MakeOp = ASMtype28(vars, -1811939328)
 Case "LLI", "LLA" 'offset
  MakeOp = ASMtype28(vars, -1073741824)
 Case "LLDI", "LLDA"
  MakeOp = ASMtype28(vars, -805306368)
 Case "LWI", "LWA"
  MakeOp = ASMtype28(vars, -1946157056)
 Case "LWLI", "LWLA"
  MakeOp = ASMtype28(vars, -2013265920)
 Case "LWRI", "LWRA"
  MakeOp = ASMtype28(vars, -1744830464)
 Case "LWIU", "LWAU"
  MakeOp = ASMtype28(vars, -1677721600)
 Case "DDIVHI"
  MakeOp = ASMtype29(vars, 30, 16)
 Case "DDIVLO"
  MakeOp = ASMtype29(vars, 30, 18)
 Case "DDIVUHI"
  MakeOp = ASMtype29(vars, 31, 16)
 Case "DDIVULO"
  MakeOp = ASMtype29(vars, 31, 18)
 Case "DIVHI"
  MakeOp = ASMtype29(vars, 26, 16)
 Case "DIVLO"
  MakeOp = ASMtype29(vars, 26, 18)
 Case "DIVUHI"
  MakeOp = ASMtype29(vars, 27, 16)
 Case "DIVULO"
  MakeOp = ASMtype29(vars, 27, 18)
 Case "DMULTHI"
  MakeOp = ASMtype29(vars, 28, 16)
 Case "DMULTLO"
  MakeOp = ASMtype29(vars, 28, 18)
 Case "DMULTUHI"
  MakeOp = ASMtype29(vars, 29, 16)
 Case "DMULTULO"
  MakeOp = ASMtype29(vars, 29, 18)
 Case "MULTHI"
  MakeOp = ASMtype29(vars, 24, 16)
 Case "MULTLO"
  MakeOp = ASMtype29(vars, 24, 18)
 Case "MULTUHI"
  MakeOp = ASMtype29(vars, 25, 16)
 Case "MULTULO"
  MakeOp = ASMtype29(vars, 25, 18)
 Case "LTC1", "LIC1"
  MakeOp = ASMtype30(vars)
 Case "LAC1"
  MakeOp = ASMtype31(vars)
 Case "LFP", "LFC1", "LFTC1"
  MakeOp = ASMtype32(vars)
 Case Else
  MakeOp = False
  ASMerror = "Unknown Opcode: " & code
End Select
If (MakeOp = False) And (ASMerror = "") Then ASMerror = "Error: Could not assemble: " & opcode
End Function

