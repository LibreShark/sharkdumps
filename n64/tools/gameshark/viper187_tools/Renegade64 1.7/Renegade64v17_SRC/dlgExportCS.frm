VERSION 5.00
Begin VB.Form dlgExportCS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Export Search Results"
   ClientHeight    =   3210
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4260
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3210
   ScaleWidth      =   4260
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "Search Number"
      Height          =   735
      Left            =   600
      TabIndex        =   3
      Top             =   1440
      Width           =   3015
      Begin VB.ComboBox cmbSearchNum 
         Height          =   315
         Left            =   600
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   280
         Width           =   1815
      End
   End
   Begin VB.CommandButton cmdDoExport 
      Caption         =   "Export"
      Height          =   375
      Left            =   1560
      TabIndex        =   2
      Top             =   2400
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "Format"
      Height          =   855
      Left            =   600
      TabIndex        =   0
      Top             =   360
      Width           =   3015
      Begin VB.ComboBox cmbRSPtype 
         Height          =   315
         ItemData        =   "dlgExportCS.frx":0000
         Left            =   240
         List            =   "dlgExportCS.frx":001F
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   280
         Width           =   2535
      End
   End
End
Attribute VB_Name = "dlgExportCS"
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
 Dim i As Integer
 Select Case GetCFG("resfmt", 1, 1)
  Case 1: cmbRSPtype.ListIndex = 0
  Case 2: cmbRSPtype.ListIndex = 1
  Case 3: cmbRSPtype.ListIndex = 2
  Case 4: cmbRSPtype.ListIndex = 3
  Case 5: cmbRSPtype.ListIndex = 4
  Case 6: cmbRSPtype.ListIndex = 5
  Case 7: cmbRSPtype.ListIndex = 6
  Case 8: cmbRSPtype.ListIndex = 7
  Case 13: cmbRSPtype.ListIndex = 8
 End Select
 cmbSearchNum.Clear
 For i = 1 To CodeSearch.cmbCompareTo.ListCount - 1
  cmbSearchNum.AddItem "Search " & i
 Next
  cmbSearchNum.ListIndex = i - 2
End Sub
Private Sub cmbRSPtype_Click()
 Select Case cmbRSPtype.ListIndex
  Case 0: WriteCFG "resfmt", 1
  Case 1: WriteCFG "resfmt", 2
  Case 2: WriteCFG "resfmt", 3
  Case 3: WriteCFG "resfmt", 4
  Case 4: WriteCFG "resfmt", 5
  Case 5: WriteCFG "resfmt", 6
  Case 6: WriteCFG "resfmt", 7
  Case 7: WriteCFG "resfmt", 8
  Case 8: WriteCFG "resfmt", 13
 End Select
End Sub
Private Sub optAllVals_Click()
 cmbSearchNum.Enabled = False
End Sub
Private Sub optNewVals_Click()
 cmbSearchNum.Enabled = True
End Sub
Private Sub cmdDoExport_Click()
 CSresults.ExportResSingle (cmbSearchNum.ListIndex + 1)
 Unload dlgExportCS
End Sub
