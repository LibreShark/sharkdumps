VERSION 5.00
Begin VB.Form dlgEmuAttach 
   Caption         =   "Attach To Emulator"
   ClientHeight    =   4995
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   5745
   LinkTopic       =   "Form1"
   ScaleHeight     =   4995
   ScaleWidth      =   5745
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox lstEmuInfo 
      Height          =   255
      ItemData        =   "dlgEmuAttach.frx":0000
      Left            =   4800
      List            =   "dlgEmuAttach.frx":002B
      TabIndex        =   4
      Top             =   120
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      Top             =   2040
      Width           =   1335
   End
   Begin VB.CommandButton cmdSetEmu 
      Caption         =   "Attach"
      Height          =   375
      Left            =   1320
      TabIndex        =   2
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox txtEmuStatus 
      BackColor       =   &H8000000F&
      Height          =   285
      Left            =   3120
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   720
      Width           =   1575
   End
   Begin VB.ComboBox cmbEmuSelect 
      Height          =   315
      ItemData        =   "dlgEmuAttach.frx":00E1
      Left            =   360
      List            =   "dlgEmuAttach.frx":0106
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   720
      Width           =   2415
   End
End
Attribute VB_Name = "dlgEmuAttach"
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
Private Sub Form_Load()
  cmdSetEmu.Enabled = False
End Sub
Private Sub cmbEmuSelect_Click()
' Dim tmp() As String
' tmp = Split(lstEmuInfo.List(cmbEmuSelect.ListIndex), "|")
' If UBound(tmp) < 1 Then
'  txtEmuStatus.text = ""
'  Exit Sub
' End If
' EmuId(3) = -1
 EmuId(0) = FindEmu(cmbEmuSelect.ListIndex)
 EmuId(1) = cmbEmuSelect.ListIndex
 EmuName = cmbEmuSelect.List(cmbEmuSelect.ListIndex)
 If EmuId(0) = -1 Then
  txtEmuStatus.text = "Not Running"
  cmdSetEmu.Enabled = False
 Else
  txtEmuStatus.text = "Running"
  cmdSetEmu.Enabled = True
 ' EmuId(3) = &H4664B8
 End If
End Sub
Private Sub cmdCancel_Click()
 EmuId(0) = -1
 Unload dlgEmuAttach
End Sub
Private Sub cmdSetEmu_Click()
 Unload dlgEmuAttach
 'MsgBox EmuId, vbOKOnly
' Dim process As Long, ramstart As Long, ramend As Long
' Dim fname As String
' fname = "c:\temp\bah.bin"
' process = 2944
' ramstart = &H20000000
' ramend = &H20400000
' MsgBox DumpRAM(EmuId, ramstart, ramend, fname), vbOKOnly
End Sub
Public Sub ReadEmuVars()
 Dim tmpstring As String, emuinfo() As String
 Dim temphandle As Integer, i As Integer, e As Integer
 cmbEmuSelect.Clear
 temphandle = FreeFile
 If Dir$(App.path & "\emulators.cfg") = vbNullString Then
  MsgBox App.path & "\emulators.cfg not found.", vbOKOnly, "Error"
  Exit Sub
 End If
 Open (App.path & "\emulators.cfg") For Input As #temphandle
 i = 0
 Do
  Line Input #temphandle, tmpstring
  If (Left(tmpstring, 1) <> ";") And (InStr(tmpstring, "|") > 0) Then
   ReDim Preserve EmuList(i) As String
   ReDim Preserve EmuOffsets(i) As Long
   ReDim Preserve EmuPointers(i) As Long
   ReDim Preserve EmuRAM(i) As Long
   ReDim Preserve EmuEndian(i) As Byte
   emuinfo = Split(tmpstring, "|")
   If UBound(emuinfo) < 5 Then
    MsgBox "Not enough vars or improper format on: " & tmpstring & vbCrLf & "Quit typing like a deranged circus chimp on crack!", vbOKOnly, "Error"
    Exit Sub
   End If
   For e = 2 To 5
    If (Not IsHex(emuinfo(e))) Or (Len(emuinfo(e)) > 8) Then
     MsgBox emuinfo(e) & "is NOT hex."
    End If
   Next
   cmbEmuSelect.AddItem emuinfo(0)
   EmuList(i) = emuinfo(1)
   EmuOffsets(i) = CLng("&H" & emuinfo(2))
   EmuPointers(i) = CLng("&H" & emuinfo(3))
   EmuRAM(i) = CLng("&H" & emuinfo(4))
   EmuEndian(i) = CLng("&H" & emuinfo(5)) And 3
   Erase emuinfo
   i = i + 1
  End If
 Loop Until EOF(temphandle)
 Close #temphandle
End Sub

