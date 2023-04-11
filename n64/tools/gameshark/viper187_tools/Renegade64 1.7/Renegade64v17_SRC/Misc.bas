Attribute VB_Name = "Misc"
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
Public Declare Function SLL Lib "renegade64.dll" (ByVal value As Long, ByVal shift As Long) As Long
Public Declare Function SRL Lib "renegade64.dll" (ByVal value As Long, ByVal shift As Long) As Long
Public Declare Function Long2Single Lib "renegade64.dll" (ByVal value As Long) As Single
Public Declare Function Single2Long Lib "renegade64.dll" (ByVal value As Single) As Long
Public Declare Function Double2LLUpper Lib "renegade64.dll" (ByVal value As Double) As Long
Public Declare Function Double2LLLower Lib "renegade64.dll" (ByVal value As Double) As Long
Public Declare Function FileSearch Lib "renegade64.dll" (ByVal newname As String, ByVal oldname As String, _
ByVal resultsout As String, ByVal resultsin As String, ByVal headersize As Long, _
ByVal fileformat As Byte, ByVal searchtype As Byte, ByVal searchsize As Byte, ByVal xoptions As Long, ByRef values() As Long, ByVal searchstring As String, ByRef ivalues() As Long, ByVal rStart As Long, ByVal rEnd As Long) As Long
Public Declare Function WriteResults Lib "renegade64.dll" (ByVal resultsin As String, ByVal resultsout As String, ByVal oldresults As String, ByVal resformat As Byte, ByVal printold As Byte) As Long
Public Declare Function WriteAllResults Lib "renegade64.dll" (ByVal rPath As String, ByVal resultsout As String, ByVal resnum As Byte, ByVal resformat As Byte) As Long
Public Declare Function WriteDis Lib "renegade64.dll" (ByVal disfile As String, ByVal disout As String, ByVal fileformat As Byte, ByVal outformat As Byte, ByVal AddyOpt As Byte, ByVal alignment As Byte, ByVal dStart As Long, ByVal dEnd As Long) As Long
Public Declare Function CopyFileBytes Lib "renegade64.dll" (ByVal FileIn As String, ByVal FileOut As String, ByVal swap As Byte, ByVal fStart As Long, ByVal fEnd As Long) As Long
Public Declare Function SearchROM Lib "renegade64.dll" (ByVal romfile As String, ByVal resout As String, ByVal fileformat As Byte, ByVal rstype As Byte, ByVal Value1 As Long, ByVal Value2 As Long) As Long
Public Declare Function ListTasks Lib "renegade64.dll" (ByVal TaskFile As String) As Long
Public Declare Function DumpRAM Lib "renegade64.dll" (ByVal ProcId As Long, ByVal rStart As Long, ByVal RAM_CHUNK_SIZE As Long, ByVal DumpName As String) As Long
Public Declare Function InitResults Lib "renegade64.dll" (ByVal ramFile As String, ByVal searchFile As String, ByVal searchsize As Byte, ByVal rStart As Long, ByVal rEnd As Long, ByVal headersize As Long, ByVal fileformat As Byte) As Long
Public Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Public Declare Function WriteProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, ByRef lpBuffer As Any, ByVal nSize As Long, ByRef lpNumberOfBytesWritten As Long) As Long
Public Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, ByRef lpBuffer As Any, ByVal nSize As Long, ByRef lpNumberOfBytesWritten As Long) As Long
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Public Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Public Declare Function GetForegroundWindow Lib "user32" () As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Public Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Long) As Long
Public Const PROCESS_ALL_ACCESS As Long = &H1F0FFF
Public EditedData(13107200) As Long '20 megs \ 4 = 5242880, 50 megs - 13107200
Public EditedAddys(3276800) As Long '20 megs \ 32 = 655360, 50 megs - 1638400
Public ROMendian As Byte
Public TMPtype As Byte
Public CSendian As Byte
Public MEMendian As Byte
Public ROMhandle
Public tmpHandle
Public DefaultResPath As String
Public DefaultTextEditor As String
Public Const DefaultResDispMax% = 10000
Public EmuList() As String
Public EmuOffsets() As Long
Public EmuPointers() As Long
Public EmuEndian() As Byte
Public EmuId(1) As Long
Public EmuRAM() As Long
Public EmuName As String
Public OpenTools(20) As Boolean
Public Function GetData(ByVal address As Long) As Long
 If TMPtype = 1 Then
  Get #tmpHandle, address + 1, GetData
 Else
  GetData = EditedData(address \ 4)
 End If
End Function
Public Sub SetData(ByVal address As Long, ByVal value As Long)
 If TMPtype = 1 Then
  Put #tmpHandle, address + 1, value
 Else
  EditedData(address \ 4) = value
 End If
End Sub
Public Function IsHex(ByVal TempValue As String) As Boolean
 Dim tmpvalue As String
 IsHex = False
 tmpvalue = vbNullString
 On Error Resume Next
 tmpvalue = CLng("&H" & TempValue)
 If tmpvalue <> vbNullString Then IsHex = True
End Function
Public Function isHexKey(ByVal KeyIn As Integer) As Boolean
 If (KeyIn >= Asc("0")) And (KeyIn <= Asc("9")) Or _
    (KeyIn >= Asc("a")) And (KeyIn <= Asc("f")) Or _
    (KeyIn >= Asc("A")) And (KeyIn <= Asc("F")) Then
  isHexKey = True
 Else
  isHexKey = False
 End If
End Function
Public Function FilterHexKeys(ByVal KeyIn As Integer) As Integer
 If (KeyIn >= Asc("0")) And (KeyIn <= Asc("9")) Or _
    (KeyIn >= Asc("A")) And (KeyIn <= Asc("F")) Then
  FilterHexKeys = KeyIn
 ElseIf (KeyIn >= Asc("a")) And (KeyIn <= Asc("f")) Then
  FilterHexKeys = KeyIn - 32
 Else
  FilterHexKeys = 0
 End If
End Function
Public Function FilterHexValues(ByVal ValIn As String) As String
 Dim tmpstring As String
 FilterHexValues = "0"
 If Len(ValIn) < 1 Then ValIn = "0"
 If Len(ValIn) > 16 Then Exit Function
 tmpstring = String(16 - Len(ValIn), "0") & ValIn
 If (IsHex(Left(tmpstring, 8))) And (IsHex(Mid(tmpstring, 9))) Then
  FilterHexValues = ValIn
 End If
End Function
Public Function HexString(ByVal value As Long, ByVal padding As Byte) As String
 If (padding) And (padding > Len(Hex(value))) Then
  HexString = String(padding - Len(Hex(value)), "0") & Hex(value)
 Else
  HexString = Hex(value)
 End If
End Function
Public Function ASCIItoHex(ByVal text As String, padding As Byte, Optional wild As Byte) As String
 Dim tmpletter As String
 Dim l As Integer
 ASCIItoHex = ""
 For l = 1 To Len(text)
  If (wild <> 0) And (Mid(text, l, 1) = "*") Then
   ASCIItoHex = ASCIItoHex & "00"
  ElseIf (wild = 2) And (Mid(text, l, 1) <> "*") Then
   ASCIItoHex = ASCIItoHex & "FF"
  Else
   tmpletter = Hex(Asc(Mid(text, l, 1)))
   ASCIItoHex = ASCIItoHex & String(2 - Len(tmpletter), "0") & tmpletter
  End If
 Next
 If padding Then ASCIItoHex = String(padding - Len(ASCIItoHex), "0") & ASCIItoHex
End Function
Public Function HexToASCII(ByVal hVal As Long, ByVal size As Byte) As String
 Dim l As Integer
 Dim tmpchar As Byte
 size = size - 1
 For l = 0 To size
  tmpchar = SRL(hVal, 8 * (size - l)) And 255
  If (tmpchar < 33) Or (tmpchar > 129) Then tmpchar = 46
  HexToASCII = HexToASCII & Chr(tmpchar)
 Next
End Function
Public Function FlipShort(ByVal short As Long, ByVal endian As Byte) As Long
 Dim tmpval As Long
 'use SRL?
 If endian = 2 Then
  tmpval = ((short And -256) / 256) And 255
  short = short And 255
  FlipShort = SLL(short, 8) Or tmpval
 Else
  FlipShort = short
 End If
End Function
Public Function FlipWord(ByVal word As Long, ByVal endian As Byte) As Long
 Dim tmpval As Long
 Dim oldword As Long
 oldword = word
 tmpval = ((word And -65536) / 65536) And 65535
 word = word And 65535
 If endian = 1 Then
  FlipWord = SLL(word, 16) Or tmpval
 ElseIf endian = 2 Then
  FlipWord = SLL(FlipShort(word, endian), 16) Or FlipShort(tmpval, endian)
 Else
  FlipWord = oldword
 End If
End Function
Public Function ByteFlipWord(ByVal word As Long) As Long
 Dim tmpval As Long
 Dim tmpval2 As Long
 tmpval = SRL(word, 16)
 tmpval = SLL((tmpval And &HFF), 8) Or SRL(tmpval, 8)
 tmpval2 = word And 65535
 tmpval2 = SLL((tmpval2 And &HFF), 8) Or SRL(tmpval2, 8)
 ByteFlipWord = tmpval Or tmpval2
End Function
Public Function FlipAddy(ByVal address As Long, ByVal size As Byte, ByVal endian As Byte)
If size = 1 Then
 Select Case endian
  Case 0 '32 bit little endian
   FlipAddy = address Xor 3
  Case 1 '16 bit little endian
   FlipAddy = address Xor 1
  Case 2 'big endian
   FlipAddy = address
  End Select
ElseIf size = 2 Then
 If endian = 0 Then
  FlipAddy = address Xor 2
 Else: FlipAddy = address
 End If
Else: FlipAddy = address
End If
End Function
Public Function FlipVal(ByVal val As Long, ByVal size As Byte, ByVal endian As Byte) As Long
 Select Case size
  Case 2: FlipVal = FlipShort(val, endian)
  Case 4: FlipVal = FlipWord(val, endian)
  Case Else: FlipVal = val
 End Select
End Function
Public Function GetAddyFlag(ByVal addy As Long) As Boolean
 Dim flag As Long
 Dim bit As Long
 flag = SRL(addy, 5)
 bit = (addy And 31) \ 4
 If (EditedAddys(flag) And SLL(1, bit)) <> 0 Then
  GetAddyFlag = True
 Else
  GetAddyFlag = False
 End If
End Function
Public Sub SetAddyFlag(ByVal addy As Long, ByVal value As Byte)
 Dim flag As Long
 Dim bit As Long
 flag = SRL(addy, 5)
 bit = (addy And 31) \ 4
 If value = 0 Then
  EditedAddys(flag) = EditedAddys(flag) And (Not SLL(1, bit))
 Else
  EditedAddys(flag) = EditedAddys(flag) Or SLL(1, bit)
 End If
End Sub
Public Function GetCFG(ByVal opt As String, ByVal otype As Byte, ByVal optdefault As Variant) As Variant
 Dim tmpstring As String
 Dim found As Boolean
 Dim temphandle
 temphandle = FreeFile
 found = False
 If Dir$(App.path & "\renegade.cfg") = vbNullString Then
  GetCFG = optdefault
  Exit Function
 End If
 Open (App.path & "\renegade.cfg") For Input As #temphandle
 Do
  Line Input #temphandle, tmpstring
  If Left(tmpstring, Len(opt) + 1) = (opt & "=") Then
   tmpstring = Mid(tmpstring, Len(opt) + 2)
   Select Case otype
    Case 1: GetCFG = CLng(tmpstring)
    Case 2: GetCFG = CLng("&H" & tmpstring)
    Case 3: GetCFG = tmpstring
   End Select
   found = True
   Exit Do
  End If
 Loop Until EOF(temphandle)
 Close #temphandle
 If found = False Then GetCFG = optdefault
End Function
Public Function WriteCFG(ByVal opt As String, ByVal val As Variant, Optional ByVal defaultval As Variant)
 Dim tmpstring As String
 Dim newsetts As String
 Dim found As Boolean
 Dim temphandle
 temphandle = FreeFile
 newsetts = ""
 found = False
 If val = "" Then val = defaultval
 If Dir$(App.path & "\renegade.cfg") = vbNullString Then
  Open (App.path & "\renegade.cfg") For Output As #temphandle
  Print #temphandle, opt & "=" & val & vbCrLf
  Close #temphandle
  Exit Function
 End If
 Open (App.path & "\renegade.cfg") For Input As #temphandle
 Do
  Line Input #temphandle, tmpstring
  If Left(tmpstring, Len(opt) + 1) = (opt & "=") Then
   newsetts = newsetts & opt & "=" & val & vbCrLf
   found = True
  Else
   If tmpstring <> "" Then newsetts = newsetts & tmpstring & vbCrLf
  End If
 Loop Until EOF(temphandle)
 Close #temphandle
 If found = False Then newsetts = newsetts & opt & "=" & val & vbCrLf
 Open (App.path & "\renegade.cfg") For Output As #temphandle
 Print #temphandle, newsetts
 Close #temphandle
End Function
Public Sub ShowDLLError(ByVal errornum As Long)
 Dim DLLerrors(20) As String
 DLLerrors(1) = "Memory allocation error."
 DLLerrors(2) = "Error opening file or file not found."
 DLLerrors(3) = "Error opening file. WTF dude? The header is bigger than the file. Try again, numbnuts."
 DLLerrors(4) = "Error opening result flags file. Resume/Continue info not saved. Results path must exist."
 DLLerrors(5) = "Error finding processes."
 DLLerrors(6) = "Error dumping memory from process."
 If errornum <> -1 Then MsgBox DLLerrors(errornum), vbOKOnly, "Error"
End Sub
Public Function CleanSPC(ByVal tmpStr As String) As String
 If InStr(tmpStr, "  ") Then
  CleanSPC = Left(tmpStr, InStr(tmpStr, " ")) & Trim(Mid(tmpStr, InStr(tmpStr, " ")))
' CleanSPC = tmpStr
 Else
  CleanSPC = tmpStr
 End If
End Function
Public Function FindEmu(ByVal emu As Byte) As Long
 Dim errnumber As Long
 Dim tlHandle
 Dim taskname As String
 Dim tmp1() As String
 FindEmu = -1
Dim tlFile As String
tlFile = App.path & "\tasklist.txt"
 errnumber = ListTasks(tlFile)
 If (errnumber <> 0) Or (Dir$(App.path & "\tasklist.txt") = vbNullString) Then
  ShowDLLError errnumber
  Exit Function
 End If
 tlHandle = FreeFile
 Open (App.path & "\tasklist.txt") For Input As #tlHandle
 Do
  Line Input #tlHandle, taskname
  If LCase(Left(taskname, Len(EmuList(emu)))) = EmuList(emu) Then
   tmp1 = Split(taskname, "|")
   If IsNumeric(tmp1(1)) Then FindEmu = tmp1(1)
   Erase tmp1
   Exit Do
  End If
 Loop Until EOF(tlHandle)
 Close tlHandle
End Function
Public Function ChkEmu(ByVal tmpid As Long) As Long
 Dim tmpHandle As Long, bah As Long, chkword As Long
 ChkEmu = -1
 If tmpid = -1 Then Exit Function
 tmpHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, tmpid)
 If tmpHandle = 0 Then
  MsgBox "Failed to open process. Maybe it's no longer running?"
  MainMDI.mnuEmuDetach_Click
  Exit Function
 End If
 If EmuPointers(EmuId(1)) > 0 Then
  If ReadProcessMemory(tmpHandle, EmuPointers(EmuId(1)), chkword, 4, bah) = 0 Then
   MsgBox "ReadProcessMemory failed"
   Exit Function
  End If
  EmuOffsets(EmuId(1)) = chkword
 End If
 ChkEmu = tmpid
 CloseHandle tmpHandle
End Function
Public Function ChooseFile(ByRef fname As String, ByVal filter As String, ByVal fType As Byte) As Boolean
 ChooseFile = True
 MainMDI.FileDlg.FileName = ""
 MainMDI.FileDlg.filter = filter
 MainMDI.FileDlg.ShowOpen
 Select Case fType
  Case 0: If MainMDI.FileDlg.FileName = "" Then ChooseFile = False
  Case 1: If Dir$(MainMDI.FileDlg.FileName) = vbNullString Or MainMDI.FileDlg.FileName = "" Then ChooseFile = False
 End Select
 fname = MainMDI.FileDlg.FileName
End Function
Public Function Exists(ByVal FileName As String, ByVal eType As Byte) As Boolean
 If Dir$(FileName) = vbNullString Then
  Exists = False
 Else
  Exists = True
  Exit Function
 End If
 Select Case eType
  Case 1: MsgBox "file " & FileName & "not found.", vbOKOnly, "Error"
 End Select
End Function
Public Function GetSFName(ByVal sname As String) As String
 Dim rshandle As Integer, l As Integer
 Dim tmpchar As Byte
 Dim dfname As String
 GetSFName = ""
 rshandle = FreeFile
 Open (sname) For Binary As #rshandle
 sname = ""
 For l = 1 To 256
  Get #rshandle, l, tmpchar
  If tmpchar <> 0 Then
   sname = sname & Chr(tmpchar)
  End If
 Next
 Close #rshandle
 If Exists(sname, 1) Then GetSFName = sname
End Function
Public Function GetResCount(ByVal sname As String) As Long
 Dim rshandle As Integer
 rshandle = FreeFile
 Open (sname) For Binary As #rshandle
 Get #rshandle, 257, GetResCount
 GetResCount = FlipWord(GetResCount, 2)
 Close #rshandle
End Function
Public Function Assemble(ByVal address As Long, ByVal opcode As String, ByVal asmLang As Integer) As Boolean
 Select Case asmLang
  Case -1, 0: Assemble = MakeOp(address, opcode)
  Case 1: Assemble = AssembleThumb(address, opcode)
 End Select
End Function
'Public Sub GBAOffset(ByVal region As Byte)
' If region = 0 Then
'  EmuOffsets(7) = &H14E100
'  EmuOffsets(10) = &H122E680
'  EmuOffsets(11) = &H2B00048
'  EmuRAM(3) = &H40000
' Else
'  EmuOffsets(7) = &H192100
'  EmuOffsets(10) = &H1272690
'  EmuOffsets(11) = &H2B40050
'  EmuRAM(3) = &H8000
' End If
'End Sub
