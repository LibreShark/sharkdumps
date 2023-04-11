Attribute VB_Name = "Thumb_Misc"
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
Public Function GetThumbReg(ByVal reg As String) As Long
 GetThumbReg = -1
 reg = Trim(reg)
 Select Case reg
  Case "R0", "R00"
   GetThumbReg = 0
  Case "R1", "R01"
   GetThumbReg = 1
  Case "R2", "R02"
   GetThumbReg = 2
  Case "R3", "R03"
   GetThumbReg = 3
  Case "R4", "R04"
   GetThumbReg = 4
  Case "R5", "R05"
   GetThumbReg = 5
  Case "R6", "R06"
   GetThumbReg = 6
  Case "R7", "R07"
   GetThumbReg = 7
  Case "R8", "R08"
   GetThumbReg = 8
  Case "R9", "R09"
   GetThumbReg = 9
  Case "R10"
   GetThumbReg = 10
  Case "R11"
   GetThumbReg = 11
  Case "R12"
   GetThumbReg = 12
  Case "R13", "SP"
   GetThumbReg = 13
  Case "R14", "LR"
   GetThumbReg = 14
  Case "R15", "PC"
   GetThumbReg = 15
 End Select
 If GetThumbReg <> -1 Then Exit Function
 reg = Replace(Replace(Replace(Replace(Replace(reg, "0X", ""), "$", ""), "*", ""), "#", ""), "-", "")
 If IsHex(reg) Then GetThumbReg = CLng("&H" & reg)
' If Left(reg, 1) = "#" Then
'  reg = Mid(reg, 2)
'  reg = Replace(reg, "-", "")
'  If Left(reg, 2) = "0X" Then reg = Mid(reg, 3)
'  If IsHex(reg) Then GetThumbReg = CLng("&H" & reg)
''  Else
''   If IsNumeric(reg) Then GetThumbReg = CLng(reg)
''  End If
'' ElseIf Left(reg, 1) = "$" Then
'  reg = Mid(reg, 2)
'  If IsHex(reg) Then GetThumbReg = CLng("&H" & reg)
' Else
'  reg = Replace(reg, "0X", "")
'  If IsHex(reg) Then GetThumbReg = CLng("&H" & reg)
' End If
End Function
Public Function IsThumbImm(ByVal arg As String) As Boolean
 arg = Trim(arg)
 arg = Replace(Replace(Replace(Replace(Replace(arg, "0X", ""), "$", ""), "*", ""), "#", ""), "-", "")
 If IsHex(arg) Then IsThumbImm = True
End Function
Public Function IsThumbReg(ByVal arg As String)
 arg = Trim(arg)
 Select Case arg
 Case "R0", "R00", "R1", "R01", "R2", "R02", "R3", "R03", "R4", "R04", "R5", "R05", "R6", "R06", "R7", "R07", "R8", "R08", "R9", "R09", "R10", "R11", "R12", "R13", "SP", "R14", "LR", "R15", "PC"
  IsThumbReg = True
 Case Else
  IsThumbReg = False
 End Select
End Function

