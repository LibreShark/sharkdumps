VERSION 5.00
Begin VB.Form dlgROMheader 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "View ROM Header"
   ClientHeight    =   7095
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   473
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   441
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdHideHeader 
      Caption         =   "Close"
      Height          =   375
      Left            =   2520
      TabIndex        =   0
      Top             =   6360
      Width           =   1095
   End
   Begin VB.TextBox txtCountry 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   30
      Top             =   5640
      Width           =   2775
   End
   Begin VB.TextBox txtCartID 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   29
      Top             =   5280
      Width           =   2775
   End
   Begin VB.TextBox txtManID 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   27
      Top             =   4920
      Width           =   2775
   End
   Begin VB.TextBox txtUnknown2 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   26
      Top             =   4560
      Width           =   2775
   End
   Begin VB.TextBox txtName 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   25
      Top             =   4200
      Width           =   2775
   End
   Begin VB.TextBox txtUnknown 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   24
      Top             =   3840
      Width           =   2775
   End
   Begin VB.TextBox txtCRC2 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   23
      Top             =   3480
      Width           =   2775
   End
   Begin VB.TextBox txtCRC1 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   22
      Top             =   3120
      Width           =   2775
   End
   Begin VB.TextBox txtRelease 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   21
      Top             =   2760
      Width           =   2775
   End
   Begin VB.TextBox txtPC 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   20
      Top             =   2400
      Width           =   2775
   End
   Begin VB.TextBox txtClockRate 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   19
      Top             =   2040
      Width           =   2775
   End
   Begin VB.TextBox txtPGSREG2 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   1680
      Width           =   2775
   End
   Begin VB.TextBox txtPWDREG 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   1320
      Width           =   2775
   End
   Begin VB.TextBox txtPGSREG 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   15
      Top             =   960
      Width           =   2775
   End
   Begin VB.TextBox txtLATREG 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   14
      Top             =   600
      Width           =   2775
   End
   Begin VB.Label Label15 
      Caption         =   "Cartridge ID"
      Height          =   255
      Left            =   360
      TabIndex        =   28
      Top             =   5280
      Width           =   3015
   End
   Begin VB.Label Label14 
      Caption         =   "Initial PI_BSB_DOM1_PGS_REG value"
      Height          =   255
      Left            =   360
      TabIndex        =   17
      Top             =   1680
      Width           =   3015
   End
   Begin VB.Label Label13 
      Caption         =   "Country Code"
      Height          =   255
      Left            =   360
      TabIndex        =   13
      Top             =   5640
      Width           =   3015
   End
   Begin VB.Label Label12 
      Caption         =   "Manufacturer ID"
      Height          =   255
      Left            =   360
      TabIndex        =   12
      Top             =   4920
      Width           =   3015
   End
   Begin VB.Label Label11 
      Caption         =   "Unknown"
      Height          =   255
      Left            =   360
      TabIndex        =   11
      Top             =   4560
      Width           =   3015
   End
   Begin VB.Label Label10 
      Caption         =   "Image Name"
      Height          =   255
      Left            =   360
      TabIndex        =   10
      Top             =   4200
      Width           =   3015
   End
   Begin VB.Label Label9 
      Caption         =   "Unknown"
      Height          =   255
      Left            =   360
      TabIndex        =   9
      Top             =   3840
      Width           =   3015
   End
   Begin VB.Label Label8 
      Caption         =   "CRC2"
      Height          =   255
      Left            =   360
      TabIndex        =   8
      Top             =   3480
      Width           =   3015
   End
   Begin VB.Label Label7 
      Caption         =   "CRC1"
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   3120
      Width           =   3015
   End
   Begin VB.Label Label6 
      Caption         =   "Release"
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   2760
      Width           =   3015
   End
   Begin VB.Label Label5 
      Caption         =   "Program Counter (PC)"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   2400
      Width           =   3015
   End
   Begin VB.Label Label4 
      Caption         =   "ClockRate"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   2040
      Width           =   3015
   End
   Begin VB.Label Label3 
      Caption         =   "Initial PI_BSB_DOM1_PWD_REG value"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   1320
      Width           =   3015
   End
   Begin VB.Label Label2 
      Caption         =   "Initial PI_BSB_DOM1_PGS_REG value"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   960
      Width           =   3015
   End
   Begin VB.Label Label1 
      Caption         =   "Initial PI_BSB_DOM1_LAT_REG value"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   600
      Width           =   3015
   End
End
Attribute VB_Name = "dlgROMheader"
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
 Dim tmplong As Long
 Dim i As Integer
 Get #ROMhandle, 1, tmplong
 tmplong = FlipWord(tmplong, ROMendian)
 txtLATREG.text = Hex(SRL(tmplong, 24))
 txtPGSREG.text = Hex(SRL(tmplong, 16) And 255)
 txtPWDREG.text = Hex(SRL(tmplong, 8) And 255)
 txtPGSREG2.text = Hex(tmplong And 255)
 Get #ROMhandle, 5, tmplong
 txtClockRate.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 9, tmplong
 txtPC.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 13, tmplong
 txtRelease.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 17, tmplong
 txtCRC1.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 21, tmplong
 txtCRC2.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 25, tmplong
 txtUnknown.text = String(8 - Len(Hex(FlipWord(tmplong, ROMendian))), "0") & Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 29, tmplong
 txtUnknown.text = txtUnknown.text & String(8 - Len(Hex(FlipWord(tmplong, ROMendian))), "0") & Hex(FlipWord(tmplong, ROMendian))
 txtName.text = ""
 For i = 0 To 4
  Get #ROMhandle, 33 + (i * 4), tmplong
  tmplong = FlipWord(tmplong, ROMendian)
  txtName.text = txtName.text & Chr(SRL(tmplong, 24)) & Chr(SRL(tmplong, 16) And 255) & _
                 Chr(SRL(tmplong, 8) And 255) & Chr(tmplong And 255)
 Next
 Get #ROMhandle, 54, tmplong
 txtUnknown2.text = Hex(FlipWord(tmplong, ROMendian))
 Get #ROMhandle, 58, tmplong
 tmplong = FlipWord(tmplong, ROMendian)
 txtManID.text = Chr(SRL(tmplong, 24)) & Chr(SRL(tmplong, 16) And 255) & _
                 Chr(SRL(tmplong, 8) And 255) & Chr(tmplong And 255)
 
 Get #ROMhandle, 62, tmplong
 tmplong = FlipWord(tmplong, ROMendian)
 txtCartID.text = Hex(SRL(tmplong, 16))
 txtCountry.text = Hex(tmplong And 65535)
End Sub
Private Sub cmdHideHeader_Click()
 Unload dlgROMheader
End Sub

