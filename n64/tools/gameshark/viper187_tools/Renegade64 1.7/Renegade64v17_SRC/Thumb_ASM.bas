Attribute VB_Name = "Thumb_ASM"
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
Public Function AssembleThumb(ByVal address As Long, ByVal opcode As String) As Boolean
 Dim code As String, vars As String, args() As String
 Dim Regs(2) As Long
 Dim i As Integer
 AssembleThumb = False
 ASMerror = ""
 AssembledOP(1) = -1
 AssembledOP(2) = -1
 GSaddy = address
 opcode = UCase(opcode)
 If InStr(opcode, " ") Then
  code = Left(opcode, InStr(opcode, " ") - 1)
  vars = Replace(Mid(opcode, InStr(opcode, " ")), " ", "")
  vars = Replace(Replace(vars, "{", ""), "}", "")
  vars = Replace(Replace(vars, "[", ""), "]", "")
  args() = Split(vars, ",")
  For i = 0 To UBound(args)
   Regs(i) = GetThumbReg(args(i))
  Next
 Else
  code = opcode
  vars = vbNullString
 End If
Select Case code
 Case "NOP"
  AssembledOP(0) = &H46C0
  AssembleThumb = True
 Case "MOV", "ADD", "SUB", "CMP"
  If UBound(args) < 1 Then
   ASMerror = "Wrong number of arguments: " & opcode
   Exit Function
  End If
  If (UBound(args) = 1) And (code = "CMP") And IsThumbReg(args(0)) And IsThumbReg(args(1)) And (Regs(0) <= 7) And (Regs(1) <= 7) Then GoTo Thumb4
  If (UBound(args) = 1) And IsThumbImm(args(1)) Then 'Rd,Imm8bit
   AssembleThumb = ThumbType3(Regs, code)
  ElseIf (code = "MOV") And (UBound(args) = 1) And (Regs(0) <= 7) And (Regs(1) <= 7) Then 'Rd,Rs
   Regs(2) = 0
   AssembleThumb = ThumbType2(Regs, "ADD", 2)
  ElseIf (code = "ADD") And (UBound(args) = 1) And (Regs(0) = 13) And IsThumbImm(args(1)) Then 'SP,Imm8bit
   AssembleThumb = ThumbType13(Regs, code, IIf(InStr(args(1), "-"), 1, 0))
  ElseIf (UBound(args) = 1) And ((Regs(0) > 7) Or (Regs(1) > 7)) Then 'Rd,Rs hi-reg
   AssembleThumb = ThumbType5(Regs, code)
  ElseIf (UBound(args) = 2) And (Regs(0) <= 7) Then
   If (Regs(1) <= 7) And IsThumbReg(args(2)) Then  'Rd,Rs,Imm3bit
    AssembleThumb = ThumbType2(Regs, code, 0)
   ElseIf (code = "ADD") And (Regs(1) >= 13) And IsThumbImm(args(2)) Then 'Rd,SP/PC,Imm8bit
    AssembleThumb = ThumbType12(Regs, code, IIf(Regs(1) = 13, 1, 0))
   ElseIf (Regs(1) <= 7) And (Regs(2) <= 7) Then 'Rd,Rs,Rn
    AssembleThumb = ThumbType2(Regs, code, 2)
   End If
  End If
 Case "BX"
  If IsThumbReg(args(0)) Then AssembleThumb = ThumbType5(Regs, code)
 Case "AND", "EOR", "LSL", "LSR", "ASR", "ADC", "SBC", "ROR", "TST", "NEG", "CMP", "CMN", "ORR", "MUL", "BIC", "MVN"
Thumb4:
  If (UBound(args) = 2) And IsThumbImm(args(2)) Then
   AssembleThumb = ThumbType1(Regs, code)
  ElseIf UBound(args) = 1 Then
   AssembleThumb = ThumbType4(Regs, code)
  End If
 Case "B"
  If (UBound(args) = 0) Then AssembleThumb = ThumbType18(Regs, code, args(0))
 Case "BL"
  If (UBound(args) = 0) Then AssembleThumb = ThumbType19(Regs, code, args(0))
 Case "BEQ", "BNE", "BCS", "BCC", "BMI", "BPL", "BVS", "BVC", "BHI", "BLS", "BGE", "BLT", "BGT", "BLE"
  If (UBound(args) = 0) Then AssembleThumb = ThumbType16(Regs, code, args(0))
 Case "SWI"
  If (UBound(args) = 0) Then AssembleThumb = ThumbType17(Regs, code)
 Case "PUSH", "POP", "SDMIA", "LDMIA"
  If (UBound(args) >= 0) Then AssembleThumb = ThumbType14_15(args, code)
 Case "LDR", "LDRB", "STR", "STRB", "LDRH", "STRH", "LDSB", "LDSH"
  If UBound(args) <> 2 Then
   ASMerror = "Wrong number of arguments: " & opcode
   Exit Function
  End If
  If (code = "LDR") And (Regs(0) <= 7) And (Regs(1) = 15) And IsThumbImm(args(2)) Then 'Rd[PC,Imm8bit]
   AssembleThumb = ThumbType6(Regs, code)
  ElseIf ((code = "LDR") Or (code = "STR")) And (Regs(0) <= 7) And (Regs(1) = 13) And IsThumbImm(args(2)) Then 'Rd[PC,Imm8bit]
   AssembleThumb = ThumbType11(Regs, code)
  ElseIf ((code = "LDRH") Or (code = "STRH")) And (Regs(0) <= 7) And (Regs(1) <= 7) And (Regs(2) <= 7) And IsThumbImm(args(2)) Then 'Rd[Rs,imm]
   AssembleThumb = ThumbType10(Regs, code)
  ElseIf (UBound(args) = 2) And (Regs(0) <= 7) And (Regs(1) <= 7) And (Regs(2) <= 7) And IsThumbReg(args(2)) Then 'Rd[Rs,Rn]
   AssembleThumb = ThumbType7_8(Regs, code)
  ElseIf (UBound(args) = 2) And (Regs(0) <= 7) And (Regs(1) <= 7) And (Regs(2) <= 7) And IsThumbImm(args(2)) Then 'Rd[Rs,imm]
   AssembleThumb = ThumbType9(Regs, code)
  End If
 Case Else
  ASMerror = "Unknown Op: " & opcode
End Select
End Function
