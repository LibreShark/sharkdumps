Attribute VB_Name = "r4300i_ASMoptypes"
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
Public Function ASMtype1(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'Load OPs rt,offset(base)
Dim rt As Long, base As Long, offset As Long
Dim p As Integer, q As Integer

p = InStr(OPargs, ",")
q = InStr(OPargs, "(")
If (p < 1) Or (q < p) Then
 ASMtype1 = False
 Exit Function
End If
rt = GetRegValue(Left(OPargs, p - 1))
offset = GetImm(Mid(OPargs, p + 1, q - p - 1))
base = GetRegValue(Mid(OPargs, q + 1, Len(OPargs) - q - 1))
If (rt = 32) Or (base = 32) Then
 ASMtype1 = False
 Exit Function
End If
If (offset > 65535) Or (offset < 0) Then
 ASMerror = "Warning: " & OPargs & " - offest value can only be 0-FFFF"
 ASMtype1 = False
 Exit Function
End If
AssembledOP(0) = OPvalue Or SLL(base, 21) Or SLL(rt, 16) Or offset
ASMtype1 = True
End Function
Public Function ASMtype2(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rd,rs,rt
Dim rd As Long, rs As Long, rt As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype2 = False
 Exit Function
End If
rd = GetRegValue(SplitRegs(0))
rs = GetRegValue(SplitRegs(1))
rt = GetRegValue(SplitRegs(2))

If (rd = 32) Or (rs = 32) Or (rt = 32) Then
 ASMtype2 = False
 Exit Function
End If

AssembledOP(0) = SLL(rs, 21) Or SLL(rt, 16) Or SLL(rd, 11) Or OPvalue
ASMtype2 = True
End Function
Public Function ASMtype3(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rd,rt,sa
Dim rd As Long, rt As Long, sa As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype3 = False
 Exit Function
End If
rd = GetRegValue(SplitRegs(0))
rt = GetRegValue(SplitRegs(1))
'If IsNumeric(SplitRegs(2)) Then
' sa = CLng(SplitRegs(2))
sa = GetImm(SplitRegs(2))
If (sa = -1) Or (sa > 31) Then
 If sa > 31 Then ASMerror = "Error: You can't shift by more than 31 bits. Idiot"
 ASMtype3 = False
 Exit Function
End If
If (rd = 32) Or (rt = 32) Then
 ASMtype3 = False
 Exit Function
End If
If (sa > 31) Or (sa < 0) Then
 ASMerror = "Warning: " & OPargs & " - shift value can only be 0-1F"
 ASMtype3 = False
 Exit Function
End If

AssembledOP(0) = SLL(rt, 16) Or SLL(rd, 11) Or SLL(sa, 6) Or OPvalue
ASMtype3 = True
End Function
Public Function ASMtype4(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rt,rs,imm
Dim rt As Long, rs As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype4 = False
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
rs = GetRegValue(SplitRegs(1))
imm = GetImm(SplitRegs(2))

If (rs = 32) Or (rt = 32) Then
 ASMtype4 = False
 Exit Function
End If
If (imm > 65536) Or (imm < 0) Then
 ASMerror = "Warning: " & OPargs & " - immediate value can only be 0-FFFF"
 ASMtype4 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or SLL(rs, 21) Or SLL(rt, 16) Or imm
ASMtype4 = True
End Function
Public Function ASMtype5(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rs,rt
Dim rt As Long, rs As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) <> 1 Then
 ASMtype5 = False
 Exit Function
End If
rs = GetRegValue(SplitRegs(0))
rt = GetRegValue(SplitRegs(1))

If (rs = 32) Or (rt = 32) Then
 ASMtype5 = False
 Exit Function
End If

AssembledOP(0) = SLL(rs, 21) Or SLL(rt, 16) Or OPvalue
ASMtype5 = True
End Function
Public Function ASMtype6(ByRef OPargs As String, ByVal OPvalue As Long, ByVal Shifter As Byte) As Boolean 'rd
Dim rd As Long

rd = GetRegValue(OPargs)

If (rd = 32) Or (Shifter = 0) Then
 ASMtype6 = False
 Exit Function
End If

AssembledOP(0) = SLL(rd, Shifter) Or OPvalue
ASMtype6 = True
End Function
Public Function ASMtype7(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rt,imm
Dim rt As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If (UBound(SplitRegs) <> 1) Then
 ASMtype7 = False
 ASMerror = "Wrong number of arguments: LUI " & OPargs
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
imm = GetImm(SplitRegs(1))

If (rt = 32) Then
 ASMtype7 = False
 Exit Function
End If
If (imm > 65536) Or (imm < 0) Then
 ASMerror = "Warning: " & OPargs & " - immediate value can only be 0-FFFF"
 ASMtype7 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or SLL(rt, 16) Or imm
ASMtype7 = True
End Function
Public Function ASMtype8(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rs,rt,offset
Dim rt As Long, rs As Long, imm As Long
Dim e As Integer
Dim lchk As Boolean
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype8 = False
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
rs = GetRegValue(SplitRegs(1))
imm = GetImm(SplitRegs(2))
If (InStr(OPargs, "*") > 0) Then
 If imm <= 32767 Then
  imm = GSaddy + (imm * 4) + 4
 Else
  imm = 65535 - imm
  imm = GSaddy - (imm * 4)
 End If
End If
If (imm = -1) Or (imm Mod 4 <> 0) Then
 ASMerror = "Warning: " & OPargs & " - Unknown branch location. Use a RAM address (must end in 0,4,8, or C), offset (value preceeded by $ or 0x), or a label (code assembler ONLY)"
 ASMtype8 = False
 Exit Function
End If
imm = ((imm - (GSaddy + 4)) \ 4)
If (imm > 32767) Or (imm < -32767) Then
 ASMerror = "Warning: " & OPargs & " - Branch location outside available range. Branches can only go 0x20000 away."
 ASMtype8 = False
 Exit Function
End If
imm = imm And 65535
If (imm = 65535) Or (imm = 0) Then
 ASMerror = "Warning: " & OPargs & " - Invalid branch location. You can't branch to the branch itself or its delay slot."
 ASMtype8 = False
 Exit Function
End If
If (rs = 32) Or (rt = 32) Then
 ASMtype8 = False
 Exit Function
End If
'sign sll?
AssembledOP(0) = OPvalue Or SLL(rs, 21) Or SLL(rt, 16) Or imm
ASMtype8 = True
End Function
Public Function ASMtype9(ByRef OPargs As String, ByVal OPvalue As Long, ByVal OPvalue2 As Long) As Boolean 'rs,offset
Dim rs As Long, imm As Long
Dim e As Integer
Dim lchk As Boolean
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype9 = False
 Exit Function
End If
rs = GetRegValue(SplitRegs(0))
imm = GetImm(SplitRegs(1))
If (InStr(OPargs, "*") > 0) Then
 If imm <= 32767 Then
  imm = GSaddy + (imm * 4) + 4
 Else
  imm = 65535 - imm
  imm = GSaddy - (imm * 4)
 End If
End If
If (imm = -1) Or (imm Mod 4 <> 0) Then
 ASMerror = "Warning: " & OPargs & " - Unknown branch location. Use a RAM address (must end in 0,4,8, or C), offset (value preceeded by $ or 0x), or a label (code assembler ONLY)"
 ASMtype9 = False
 Exit Function
End If
imm = ((imm - (GSaddy + 4)) \ 4)
If (imm > 32767) Or (imm < -32767) Then
 ASMerror = "Warning: " & OPargs & " - Branch location outside available range. Branches can only go 0x20000 away."
 ASMtype9 = False
 Exit Function
End If
imm = imm And 65535
If (imm = 65535) Or (imm = 0) Then
 ASMerror = "Warning: " & OPargs & " - Invalid branch location. You can't branch to the branch itself or its delay slot."
 ASMtype9 = False
 Exit Function
End If
If (rs = 32) Then
 ASMtype9 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or SLL(rs, 21) Or SLL(OPvalue2, 16) Or imm
ASMtype9 = True
End Function
Public Function ASMtype10(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'target
Dim target As Long

target = GetImm(OPargs)

If (target = -1) Or (target Mod 4 <> 0) Then
 ASMerror = "Warning: " & OPargs & " - invalid target"
 ASMtype10 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or ((target / 4) And 67108863)
ASMtype10 = True
End Function
Public Function ASMtype11(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'JALR rs,rd
Dim rs As Long, rd As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype11 = False
 Exit Function
End If
rs = GetRegValue(SplitRegs(0))
rd = GetRegValue(SplitRegs(1))
If (rs = 32) Or (rd = 32) Then
 ASMtype11 = False
 Exit Function
End If

AssembledOP(0) = SLL(rd, 21) Or SLL(rs, 11) Or OPvalue
ASMtype11 = True
End Function
Public Function ASMtype12(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'JR rs
Dim rs As Long

rs = GetRegValue(OPargs)

If (rs = 32) Then
 ASMtype12 = False
 Exit Function
End If

AssembledOP(0) = SLL(rs, 21) Or OPvalue
ASMtype12 = True
End Function
Public Function ASMtype13(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'Traps rs,rt[,code]
Dim rt As Long, rs As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype13 = False
 Exit Function
End If
rs = GetRegValue(SplitRegs(0))
rt = GetRegValue(SplitRegs(1))
If UBound(SplitRegs) < 2 Then
 imm = 0
Else
 imm = GetImm(SplitRegs(2))
End If
If (rs = 32) Or (rt = 32) Or (imm < 0) Or (imm > 1023) Then
 ASMtype13 = False
 Exit Function
End If
ASMerror = "Warning: Traps aren't fully supported. I don't know what the hell to do with the 'code' argument."
AssembledOP(0) = SLL(rs, 21) Or SLL(rt, 16) Or SLL(imm, 6) Or OPvalue
ASMtype13 = True
End Function
Public Function ASMtype14(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'Traps rs,imm
Dim rs As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype14 = False
 Exit Function
End If
rs = GetRegValue(SplitRegs(0))
imm = GetImm(SplitRegs(1))

If (rs = 32) Then
 ASMtype14 = False
 Exit Function
End If
If (imm > 65536) Or (imm < 0) Then
 ASMerror = "Warning: " & OPargs & " - immediate value can only be 0-FFFF"
 ASMtype14 = False
 Exit Function
End If

AssembledOP(0) = 67108864 Or SLL(rs, 21) Or SLL(OPvalue, 16) Or imm
ASMtype14 = True
End Function
Public Function ASMtype15(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'offset
Dim offset As Long

offset = GetImm(OPargs)

If (offset < 0) Or (offset > 1048575) Then
 ASMerror = "Warning: " & OPargs & " - invalid offset."
 ASMtype15 = False
 Exit Function
End If

AssembledOP(0) = SLL(offset, 6) Or OPvalue
ASMtype15 = True
End Function
Public Function ASMtype00() As Boolean 'SYNC
AssembledOP(0) = 15
ASMtype00 = True
End Function
Public Function ASMtype16(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'cop0
AssembledOP(0) = 1073741824 Or 33554432 Or OPvalue
ASMtype16 = True
End Function
Public Function ASMtype17(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'cop0 CACHE
ASMerror = "Error: CACHE not supported. Somebody tell be how the fuck to assemble this OP."
ASMtype17 = False
End Function
Public Function ASMtype18(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'MxC0 rt,c0r
Dim rt As Long, c0r As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype18 = False
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
c0r = GetCOP0RValue(SplitRegs(1))
If (rt = 32) Or (c0r = 32) Then
 ASMtype18 = False
 Exit Function
End If
AssembledOP(0) = OPvalue Or SLL(rt, 16) Or SLL(c0r, 11)
ASMtype18 = True
End Function
Public Function ASMtype19(ByRef OPargs As String, ByVal OPvalue As Long, ByVal OPvalue2 As Long) As Boolean 'fd,fs
Dim fd As Long, fs As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype19 = False
 Exit Function
End If
fd = GetFPRValue(SplitRegs(0))
fs = GetFPRValue(SplitRegs(1))
If (fd = 32) Or (fs = 32) Then
 ASMtype19 = False
 Exit Function
End If
Select Case fd
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
Select Case fs
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
AssembledOP(0) = OPvalue Or SLL(fs, 11) Or SLL(fd, 6) Or OPvalue2
ASMtype19 = True
End Function
Public Function ASMtype20(ByRef OPargs As String, ByVal OPvalue As Long, ByVal OPvalue2 As Long) As Boolean 'fd,fs,ft
Dim fd As Long, fs As Long, ft As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype20 = False
 Exit Function
End If
fd = GetFPRValue(SplitRegs(0))
fs = GetFPRValue(SplitRegs(1))
ft = GetFPRValue(SplitRegs(2))
If (fd = 32) Or (fs = 32) Or (ft = 32) Then
 ASMtype20 = False
 Exit Function
End If
Select Case fd
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
Select Case fs
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
Select Case ft
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select

AssembledOP(0) = OPvalue Or SLL(ft, 16) Or SLL(fs, 11) Or SLL(fd, 6) Or OPvalue2
ASMtype20 = True
End Function
Public Function ASMtype21(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rt,fs
Dim rt As Long, fs As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype21 = False
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
fs = GetFPRValue(SplitRegs(1))
If (fs = 32) Or (rt = 32) Then
 ASMtype21 = False
 Exit Function
End If
Select Case fs
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select

AssembledOP(0) = OPvalue Or SLL(rt, 16) Or SLL(fs, 11)
ASMtype21 = True
End Function
Public Function ASMtype22(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'ft,offset(base)
Dim ft As Long, offset As Long, base As Long
Dim p As Integer, q As Integer

p = InStr(OPargs, ",")
q = InStr(OPargs, "(")
If (p < 1) Or (q < p) Then
 ASMtype22 = False
 Exit Function
End If
ft = GetFPRValue(Left(OPargs, p - 1))
offset = GetImm(Mid(OPargs, p + 1, q - p - 1))
base = GetRegValue(Mid(OPargs, q + 1, Len(OPargs) - q - 1))

If (ft = 32) Or (base = 32) Then
 ASMtype22 = False
 Exit Function
End If
Select Case ft
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select

If (offset > 65535) Or (offset < 0) Then
 ASMerror = "Warning: " & OPargs & " - immediate value can only be 0-FFFF"
 ASMtype22 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or SLL(base, 21) Or SLL(ft, 16) Or offset
ASMtype22 = True
End Function
Public Function ASMtype23(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'offset
Dim imm As Long
Dim e As Integer
Dim lchk As Boolean

imm = GetImm(OPargs)
If (InStr(OPargs, "*") > 0) Then
 If imm <= 32767 Then
  imm = GSaddy + (imm * 4) + 4
 Else
  imm = 65535 - imm
  imm = GSaddy - (imm * 4)
 End If
End If
If (imm = -1) Or (imm Mod 4 <> 0) Then
 ASMerror = "Warning: " & OPargs & " - Unknown branch location. Use a RAM address (must end in 0,4,8, or C), offset (value preceeded by $ or 0x), or a label (code assembler ONLY)"
 ASMtype23 = False
 Exit Function
End If
imm = ((imm - (GSaddy + 4)) \ 4)
If (imm > 32767) Or (imm < -32767) Then
 ASMerror = "Warning: " & OPargs & " - Branch location outside available range. Branches can only go 0x20000 away."
 ASMtype23 = False
 Exit Function
End If
imm = imm And 65535
If (imm = 65535) Or (imm = 0) Then
 ASMerror = "Warning: " & OPargs & " - Invalid branch location. You can't branch to the branch itself or its delay slot."
 ASMtype23 = False
 Exit Function
End If

AssembledOP(0) = OPvalue Or imm
ASMtype23 = True
End Function
Public Function ASMtype24(ByRef OPargs As String, ByVal OPvalue As Long, ByVal OPvalue2 As Long) As Boolean 'fs,ft
Dim fs As Long, ft As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype24 = False
 Exit Function
End If
fs = GetFPRValue(SplitRegs(0))
ft = GetFPRValue(SplitRegs(1))
If (fs = 32) Or (ft = 32) Then
 ASMtype24 = False
 Exit Function
End If
Select Case fs
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
Select Case ft
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
AssembledOP(0) = OPvalue Or SLL(ft, 16) Or SLL(fs, 11) Or OPvalue2
ASMtype24 = True
End Function
Public Function ASMtype25() As Boolean 'NOP
'AssembledOP(0) = 603979776
AssembledOP(0) = 0
ASMtype25 = True
End Function
Public Function ASMtype26(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rd,rt
Dim rd As Long, rt As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype26 = False
 Exit Function
End If
rd = GetRegValue(SplitRegs(0))
rt = GetRegValue(SplitRegs(1))

If (rd = 32) Or (rt = 32) Then
 ASMtype26 = False
 Exit Function
End If

AssembledOP(0) = SLL(rt, 16) Or SLL(rd, 11) Or OPvalue
ASMtype26 = True
End Function
Public Function ASMtype27(ByRef OPargs As String) As Boolean 'rt,imm
Dim rt As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype27 = False
 Exit Function
End If
rt = GetRegValue(SplitRegs(0))
imm = GetImm(SplitRegs(1))

If (rt = 32) Then
 ASMtype27 = False
 Exit Function
End If
If (imm >= 0) And (imm <= 65535) Then
 AssembledOP(0) = 872415232 Or SLL(rt, 16) Or (imm And 65535)
Else
 AssembledOP(0) = 1006632960 Or SLL(rt, 16) Or SRL(imm, 16)
 GSaddy = GSaddy + 1
 AssembledOP(1) = 872415232 Or SLL(rt, 21) Or SLL(rt, 16) Or (imm And 65535)
End If
ASMtype27 = True
End Function
Public Function ASMtype28(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rt,imm[(base)]
Dim base As Long, rt As Long, imm As Long
Dim p As Integer, q As Integer

ASMtype28 = False
Exit Function
p = InStr(OPargs, ",")
q = InStr(OPargs, "(")
If (p < 1) Then
 ASMtype28 = False
 Exit Function
End If
rt = GetRegValue(Left(OPargs, p - 1))
If q > p Then
 imm = GetImm(Mid(OPargs, p + 1, q - p - 1))
 base = GetRegValue(Mid(OPargs, q + 1, Len(OPargs) - q - 1))
Else
 imm = GetImm(Mid(OPargs, p + 1))
 base = rt
End If
If (rt = 32) Or (base = 32) Or (imm = -1) Then
 ASMtype28 = False
 Exit Function
End If
If SRL(imm, 28) = 0 Then imm = imm Or -2147483648#
If (imm And 65535) > 32768 Then imm = imm Or 65536
AssembledOP(0) = 1006632960 Or SLL(base, 16) Or SRL(imm, 16)
GSaddy = GSaddy + 1
AssembledOP(1) = OPvalue Or SLL(base, 21) Or SLL(rt, 16) Or (imm And 65535)
ASMtype28 = True
End Function
Public Function ASMtype29(ByRef OPargs As String, ByVal OPvalue As Long, ByVal OP2value) As Boolean 'rd,rs,rt
Dim rd As Long, rs As Long, rt As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype29 = False
 Exit Function
End If
rd = GetRegValue(SplitRegs(0))
rs = GetRegValue(SplitRegs(1))
rt = GetRegValue(SplitRegs(2))
If (rd = 32) Or (rs = 32) Or (rt = 32) Then
 ASMtype29 = False
 Exit Function
End If
AssembledOP(0) = SLL(rs, 21) Or SLL(rt, 16) Or OPvalue
GSaddy = GSaddy + 1
AssembledOP(1) = SLL(rd, 11) Or OP2value
ASMtype29 = True
End Function
Public Function ASMtype30(ByRef OPargs As String) As Boolean 'fd,rs,imm
Dim fd As Long, rs As Long, imm As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 1 Then
 ASMtype30 = False
 Exit Function
End If
fd = GetFPRValue(SplitRegs(0))
If UBound(SplitRegs) < 2 Then
 rs = 27
 imm = GetImm(SplitRegs(1))
Else
 rs = GetRegValue(SplitRegs(1))
 imm = GetImm(SplitRegs(2))
End If
If (fd = 32) Or (rs = 32) Then
 ASMtype30 = False
 Exit Function
End If
Select Case fd
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
If ((imm >= 0) And (imm <= 65535)) Or ((imm And 65535) = 0) Then
 If (imm And 65535) = 0 Then imm = SRL(imm, 16)
 AssembledOP(0) = 1006632960 Or SLL(rs, 16) Or imm
 GSaddy = GSaddy + 1
 AssembledOP(1) = 1149239296 Or SLL(rs, 16) Or SLL(fd, 11)
Else
 AssembledOP(0) = 1006632960 Or SLL(rs, 16) Or SRL(imm, 16)
 GSaddy = GSaddy + 1
 AssembledOP(1) = 872415232 Or SLL(rs, 21) Or SLL(rs, 16) Or (imm And 65535)
 GSaddy = GSaddy + 1
 AssembledOP(2) = 1149239296 Or SLL(rs, 16) Or SLL(fd, 11)
End If
ASMtype30 = True
End Function
Public Function ASMtype31(ByRef OPargs As String) As Boolean 'fd,base,offset
Dim fd As Long, base As Long, imm As Long
Dim p As Integer, q As Integer

p = InStr(OPargs, ",")
q = InStr(OPargs, "(")
If (p < 1) Then
 ASMtype31 = False
 Exit Function
End If
fd = GetFPRValue(Left(OPargs, p - 1))
If q > p Then
 imm = GetImm(Mid(OPargs, p + 1, q - p - 1))
 base = GetRegValue(Mid(OPargs, q + 1, Len(OPargs) - q - 1))
Else
 imm = GetImm(Mid(OPargs, p + 1))
 base = 27
End If

If (fd = 32) Or (base = 32) Then
 ASMtype31 = False
 Exit Function
End If
Select Case fd
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
If SRL(imm, 28) = 0 Then imm = imm Or -2147483648#
If (imm And 65535) > 32768 Then imm = imm Or 65536
AssembledOP(0) = 1006632960 Or SLL(base, 16) Or SRL(imm, 16)
GSaddy = GSaddy + 1
AssembledOP(1) = -1006632960 Or SLL(base, 21) Or SLL(fd, 16) Or (imm And 65535)
ASMtype31 = True
End Function
Public Function ASMtype32(ByRef OPargs As String) As Boolean 'fd,rs,imm
Dim fd As Long, rs As Long, imm As Long
Dim SplitRegs() As String
Dim p As Byte

SplitRegs = Split(OPargs, ",")
fd = GetFPRValue(SplitRegs(0))
If UBound(SplitRegs) < 1 Then
 ASMerror = "Error: Wrong number of arguments."
 ASMtype32 = False
 Exit Function
ElseIf UBound(SplitRegs) < 2 Then
 rs = 27
 p = 1
Else
 rs = GetRegValue(SplitRegs(1))
 p = 2
End If
If IsNumeric(SplitRegs(p)) Then
 imm = Single2Long(SplitRegs(p))
Else
 ASMerror = "Warning: Bad Value - " & OPargs
 ASMtype32 = False
 Exit Function
End If
If (fd = 32) Or (rs = 32) Then
 ASMtype32 = False
 Exit Function
End If
Select Case fd
 Case 7, 21, 22, 23, 24, 25, 31
 ASMerror = "Warning: F7, F21-F25, and F31 are Reserved and shouldn't be used."
End Select
If ((imm >= 0) And (imm <= 65535)) Or ((imm And 65535) = 0) Then
 If (imm And 65535) = 0 Then imm = SRL(imm, 16)
 AssembledOP(0) = 1006632960 Or SLL(rs, 16) Or imm
 GSaddy = GSaddy + 1
 AssembledOP(1) = 1149239296 Or SLL(rs, 16) Or SLL(fd, 11)
Else
 AssembledOP(0) = 1006632960 Or SLL(rs, 16) Or SRL(imm, 16)
 GSaddy = GSaddy + 1
 AssembledOP(1) = 872415232 Or SLL(rs, 21) Or SLL(rs, 16) Or (imm And 65535)
 GSaddy = GSaddy + 1
 AssembledOP(2) = 1149239296 Or SLL(rs, 16) Or SLL(fd, 11)
End If
ASMtype32 = True
End Function
Public Function ASMtype33(ByRef OPargs As String, ByVal OPvalue As Long) As Boolean 'rd,rt,rs
Dim rd As Long, rs As Long, rt As Long
Dim SplitRegs() As String

SplitRegs = Split(OPargs, ",")
If UBound(SplitRegs) < 2 Then
 ASMtype33 = False
 Exit Function
End If
rd = GetRegValue(SplitRegs(0))
rt = GetRegValue(SplitRegs(1))
rs = GetRegValue(SplitRegs(2))

If (rd = 32) Or (rs = 32) Or (rt = 32) Then
 ASMtype33 = False
 Exit Function
End If

AssembledOP(0) = SLL(rs, 21) Or SLL(rt, 16) Or SLL(rd, 11) Or OPvalue
ASMtype33 = True
End Function
