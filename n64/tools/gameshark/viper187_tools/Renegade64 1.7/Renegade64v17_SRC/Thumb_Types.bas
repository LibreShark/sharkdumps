Attribute VB_Name = "Thumb_Types"
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
Public Function ThumbType1(ByRef Regs() As Long, ByVal OP As String) As Boolean
 Select Case OP
  Case "LSL": AssembledOP(0) = SLL(0, 11)
  Case "LSR": AssembledOP(0) = SLL(1, 11)
  Case "ASR": AssembledOP(0) = SLL(2, 11)
  Case Else
   ThumbType1 = False
   Exit Function
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(2) And 31, 6) Or SLL(Regs(1) And 7, 3) Or (Regs(0) And 7)
 ThumbType1 = True
End Function
Public Function ThumbType2(ByRef Regs() As Long, ByVal OP As String, ByVal otype As Long) As Boolean
 AssembledOP(0) = SLL(3, 11)
 Select Case OP
  Case "ADD": AssembledOP(0) = AssembledOP(0) Or SLL(0 Or otype, 9)
  Case "SUB": AssembledOP(0) = AssembledOP(0) Or SLL(1 Or otype, 9)
  Case Else
   ThumbType2 = False
   Exit Function
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(2) And 7, 6) Or SLL(Regs(1) And 7, 3) Or (Regs(0) And 7)
 ThumbType2 = True
End Function
Public Function ThumbType3(ByRef Regs() As Long, ByVal OP As String) As Boolean
 Select Case OP
  Case "MOV": AssembledOP(0) = SLL(4, 11)
  Case "CMP": AssembledOP(0) = SLL(5, 11)
  Case "ADD": AssembledOP(0) = SLL(6, 11)
  Case "SUB": AssembledOP(0) = SLL(7, 11)
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(0) And 7, 8) Or (Regs(1) And 255)
 ThumbType3 = True
End Function
Public Function ThumbType4(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(16, 10)
 Select Case OP
  Case "AND": AssembledOP(0) = AssembledOP(0) Or SLL(0, 6)
  Case "EOR": AssembledOP(0) = AssembledOP(0) Or SLL(1, 6)
  Case "LSL": AssembledOP(0) = AssembledOP(0) Or SLL(2, 6)
  Case "LSR": AssembledOP(0) = AssembledOP(0) Or SLL(3, 6)
  Case "ASR": AssembledOP(0) = AssembledOP(0) Or SLL(4, 6)
  Case "ADC": AssembledOP(0) = AssembledOP(0) Or SLL(5, 6)
  Case "SBC": AssembledOP(0) = AssembledOP(0) Or SLL(6, 6)
  Case "ROR": AssembledOP(0) = AssembledOP(0) Or SLL(7, 6)
  Case "TST": AssembledOP(0) = AssembledOP(0) Or SLL(8, 6)
  Case "NEG": AssembledOP(0) = AssembledOP(0) Or SLL(9, 6)
  Case "CMP": AssembledOP(0) = AssembledOP(0) Or SLL(10, 6)
  Case "CMN": AssembledOP(0) = AssembledOP(0) Or SLL(11, 6)
  Case "ORR": AssembledOP(0) = AssembledOP(0) Or SLL(12, 6)
  Case "MUL": AssembledOP(0) = AssembledOP(0) Or SLL(13, 6)
  Case "BIC": AssembledOP(0) = AssembledOP(0) Or SLL(14, 6)
  Case "MVN": AssembledOP(0) = AssembledOP(0) Or SLL(15, 6)
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(1) And 7, 3) Or (Regs(0) And 7)
 ThumbType4 = True
End Function
Public Function ThumbType5(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(17, 10)
 Select Case OP
  Case "MOV": AssembledOP(0) = AssembledOP(0) Or SLL(2, 8)
  Case "CMP": AssembledOP(0) = AssembledOP(0) Or SLL(1, 8)
  Case "ADD": AssembledOP(0) = AssembledOP(0)
  Case "BX": AssembledOP(0) = AssembledOP(0) Or SLL(3, 8)
  Case Else
   ThumbType5 = False
   Exit Function
 End Select
 If OP = "BX" Then
  If Regs(0) > 7 Then AssembledOP(0) = AssembledOP(0) Or SLL(1, 6)
  AssembledOP(0) = AssembledOP(0) Or SLL(Regs(0) And 7, 3)
 Else
  If Regs(0) > 7 Then AssembledOP(0) = AssembledOP(0) Or SLL(1, 7)
  If Regs(1) > 7 Then AssembledOP(0) = AssembledOP(0) Or SLL(1, 6)
  AssembledOP(0) = AssembledOP(0) Or SLL(Regs(1) And 7, 3) Or (Regs(0) And 7)
 End If
 ThumbType5 = True
End Function
Public Function ThumbType6(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(9, 11) Or SLL(Regs(0) And 7, 8) Or Regs(2)
 ThumbType6 = True
 If (Regs(2) > 255) Then ThumbType6 = False
End Function
Public Function ThumbType7_8(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(5, 12)
 Select Case OP
  Case "STR": AssembledOP(0) = AssembledOP(0)
  Case "STRB": AssembledOP(0) = AssembledOP(0) Or SLL(1, 10)
  Case "LDR": AssembledOP(0) = AssembledOP(0) Or SLL(2, 10)
  Case "LDRB": AssembledOP(0) = AssembledOP(0) Or SLL(3, 10)
  Case "STRH": AssembledOP(0) = AssembledOP(0) Or SLL(1, 9)
  Case "LDSB": AssembledOP(0) = AssembledOP(0) Or SLL(1, 10) Or SLL(1, 9)
  Case "LDRH": AssembledOP(0) = AssembledOP(0) Or SLL(2, 10) Or SLL(1, 9)
  Case "LDSH": AssembledOP(0) = AssembledOP(0) Or SLL(3, 10) Or SLL(1, 9)
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(2), 6) Or SLL(Regs(1), 3) Or Regs(0)
 ThumbType7_8 = True
End Function
Public Function ThumbType9(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(3, 13)
 Select Case OP
  Case "STR": AssembledOP(0) = AssembledOP(0)
  Case "STRB": AssembledOP(0) = AssembledOP(0) Or SLL(2, 11)
  Case "LDR": AssembledOP(0) = AssembledOP(0) Or SLL(1, 11)
  Case "LDRB": AssembledOP(0) = AssembledOP(0) Or SLL(3, 11)
 End Select
 AssembledOP(0) = AssembledOP(0) Or SLL(Regs(2), 6) Or SLL(Regs(1), 3) Or Regs(0)
 ThumbType9 = True
 If Regs(2) > 31 Then
  ASMerror = OP & ": Invalid immediate (" & Hex(Regs(2)) & "). Immediate must be 00-1F"
  ThumbType9 = False
 End If
End Function
Public Function ThumbType10(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(8, 12) Or SLL(IIf(OP = "LDRH", 1, 0), 11) Or SLL(Regs(2), 6) Or SLL(Regs(1), 3) Or Regs(0)
 ThumbType10 = True
 If Regs(2) > 31 Then
  ASMerror = OP & ": Invalid immediate (" & Hex(Regs(2)) & "). Immediate must be 00-1F"
  ThumbType10 = False
 End If
End Function
Public Function ThumbType11(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(9, 12) Or SLL(IIf(OP = "LDR", 1, 0), 11) Or SLL(Regs(0) And 7, 8) Or Regs(2)
 ThumbType11 = True
 If (Regs(2) > 255) Then ThumbType11 = False
End Function
Public Function ThumbType12(ByRef Regs() As Long, ByVal OP As String, ByVal otype As Long) As Boolean
 AssembledOP(0) = SLL(10, 12) Or SLL(otype, 11) Or SLL(Regs(0) And 7, 8) Or Regs(2)
 ThumbType12 = True
 If Regs(1) > 1020 Then ThumbType12 = False
End Function
Public Function ThumbType13(ByRef Regs() As Long, ByVal OP As String, ByVal otype As Long) As Boolean
 AssembledOP(0) = SLL(176, 8) Or SLL(otype, 7) Or Regs(1)
 ThumbType13 = True
 If Regs(1) > 508 Then ThumbType13 = False
End Function
Public Function ThumbType14_15(ByRef args() As String, ByVal OP As String) As Boolean
 Dim i As Integer, e As Integer
 Dim tmp() As String
 Dim reg1 As Long, reg2 As Long, reglist As Long, LRPC As Long
 LRPC = 0
 reglist = 0
 For i = 0 To UBound(args)
  If InStr(args(i), "-") Then
   tmp() = Split(args(i), "-")
   reg1 = GetThumbReg(tmp(0))
   reg2 = GetThumbReg(tmp(1))
   If (reg1 < reg2) And IsThumbReg(tmp(0)) And IsThumbReg(tmp(1)) Then
    For e = reg1 To reg2
     reglist = reglist Or SLL(1, e)
    Next
   Else
    ASMerror = "Invalid use of PUSH/POP: " & args(i)
   End If
  ElseIf IsThumbReg(args(i)) Then
   reg1 = GetThumbReg(args(i))
   If (reg1 = 14) Or (reg1 = 15) Then
    LRPC = 1
   Else
    reglist = reglist Or SLL(1, reg1)
   End If
  ElseIf Right(args(i), 1) = "!" Then
   args(i) = Replace(args(i), "!", "")
   LRPC = GetThumbReg(args(i))
   If (IsThumbReg(args(i)) = False) Or (LRPC > 7) Then ASMerror = "Invalid args: " & OP & " " & args(i)
  End If
 Next
 Select Case OP
  Case "PUSH", "POP"
   AssembledOP(0) = SLL(11, 12) Or SLL(IIf(OP = "POP", 1, 0), 11) Or SLL(2, 9) Or SLL(LRPC, 8) Or (reglist And 255)
  Case "SDMIA", "LDMIA"
   AssembledOP(0) = SLL(12, 12) Or SLL(IIf(OP = "LDMIA", 1, 0), 11) Or SLL(LRPC, 8) Or (reglist And 255)
 End Select
 ThumbType14_15 = True
 If ASMerror <> "" Then ThumbType14_15 = False
End Function
Public Function ThumbType16(ByRef Regs() As Long, ByVal OP As String, arg0 As String) As Boolean
 ASMerror = ""
 AssembledOP(0) = SLL(13, 12)
 If InStr(arg0, "*") Then
  If InStr(arg0, "-") Then Regs(0) = 254 - Regs(0)
 Else
  If (Regs(0) Mod 2) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
  If GSaddy > Regs(0) Then
   Regs(0) = 254 - ((GSaddy - Regs(0)) \ 2)
  Else
   Regs(0) = ((Regs(0) - GSaddy) \ 2) - 2
  End If
 End If
 Select Case OP
  Case "BEQ": AssembledOP(0) = AssembledOP(0)
  Case "BNE": AssembledOP(0) = AssembledOP(0) Or SLL(1, 8)
  Case "BCS": AssembledOP(0) = AssembledOP(0) Or SLL(2, 8)
  Case "BCC": AssembledOP(0) = AssembledOP(0) Or SLL(3, 8)
  Case "BMI": AssembledOP(0) = AssembledOP(0) Or SLL(4, 8)
  Case "BPL": AssembledOP(0) = AssembledOP(0) Or SLL(5, 8)
  Case "BVS": AssembledOP(0) = AssembledOP(0) Or SLL(6, 8)
  Case "BVC": AssembledOP(0) = AssembledOP(0) Or SLL(7, 8)
  Case "BHI": AssembledOP(0) = AssembledOP(0) Or SLL(8, 8)
  Case "BLS": AssembledOP(0) = AssembledOP(0) Or SLL(9, 8)
  Case "BGE": AssembledOP(0) = AssembledOP(0) Or SLL(10, 8)
  Case "BLT": AssembledOP(0) = AssembledOP(0) Or SLL(11, 8)
  Case "BGT": AssembledOP(0) = AssembledOP(0) Or SLL(12, 8)
  Case "BLE": AssembledOP(0) = AssembledOP(0) Or SLL(13, 8)
 End Select
 If (Regs(0) < 0) Or (Regs(0) > 255) Or (Regs(0) = 254) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
 AssembledOP(0) = AssembledOP(0) Or Regs(0)
 ThumbType16 = True
 If ASMerror <> "" Then ThumbType16 = False
End Function
Public Function ThumbType17(ByRef Regs() As Long, ByVal OP As String) As Boolean
 AssembledOP(0) = SLL(223, 8) Or (Regs(0) And 255)
 ThumbType17 = True
End Function
Public Function ThumbType18(ByRef Regs() As Long, ByVal OP As String, arg0 As String) As Boolean
 ASMerror = ""
 If InStr(arg0, "*") Then
  If InStr(arg0, "-") Then Regs(0) = &H7FE - Regs(0)
 Else
  If (Regs(0) Mod 2) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
  If GSaddy > Regs(0) Then
   Regs(0) = &H7FE - ((GSaddy - Regs(0)) \ 2)
  Else
   Regs(0) = ((Regs(0) - GSaddy) \ 2) - 2
  End If
 End If
 If (Regs(0) < 0) Or (Regs(0) > 2047) Or (Regs(0) = &H7FE) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
 AssembledOP(0) = SLL(28, 11) Or Regs(0)
 ThumbType18 = True
 If ASMerror <> "" Then ThumbType18 = False
End Function
Public Function ThumbType19(ByRef Regs() As Long, ByVal OP As String, arg0 As String) As Boolean
 ASMerror = ""
 If InStr(arg0, "*") Then
  If InStr(arg0, "-") Then Regs(0) = &H7FFFFE - Regs(0)
 Else
  If (Regs(0) Mod 2) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
  If GSaddy > Regs(0) Then
   Regs(0) = &H7FFFFE - ((GSaddy - Regs(0)) \ 2)
  Else
   Regs(0) = ((Regs(0) - GSaddy) \ 2) - 2
  End If
 End If
 If (Regs(0) < 0) Or (Regs(0) > &H7FFFFD) Then ASMerror = "Invalid branch location: " & Hex(Regs(0))
 AssembledOP(0) = SLL(30, 11) Or SRL(Regs(0), 12)
 AssembledOP(1) = SLL(31, 11) Or (Regs(0) And 2047)
 ThumbType19 = True
 If ASMerror <> "" Then ThumbType19 = False
End Function


