VERSION 5.00
Begin VB.Form dlgEndianSelect 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Select Byte Order"
   ClientHeight    =   2025
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4590
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   4590
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdSetEndian 
      Caption         =   "Ok"
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   720
      Width           =   495
   End
   Begin VB.ComboBox cmbPickEndian 
      Height          =   315
      ItemData        =   "dlgEndianSelect.frx":0000
      Left            =   720
      List            =   "dlgEndianSelect.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   720
      Width           =   2175
   End
End
Attribute VB_Name = "dlgEndianSelect"
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
Private Sub Form_Load()
cmbPickEndian.ListIndex = GetCFG("dis_endian", 1, 2)
End Sub
Private Sub Form_Unload(cancel As Integer)
 ROMendian = cmbPickEndian.ListIndex
 WriteCFG "dis_endian", cmbPickEndian.ListIndex
End Sub
Private Sub cmbPickEndian_Change()
 If cmbPickEndian.ListIndex = -1 Then cmbPickEndian.ListIndex = 0
End Sub
Private Sub cmdSetEndian_Click()
 If cmbPickEndian.ListIndex = -1 Then Exit Sub
 Unload dlgEndianSelect
End Sub
Private Sub cmbPickEndian_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 13) And (shift = 0) Then cmdSetEndian_Click 'Enter
End Sub
