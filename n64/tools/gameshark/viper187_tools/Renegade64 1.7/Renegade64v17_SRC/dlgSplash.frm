VERSION 5.00
Begin VB.Form dlgSplash 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   8985
   ClientLeft      =   255
   ClientTop       =   1410
   ClientWidth     =   11970
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "dlgSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "dlgSplash.frx":000C
   ScaleHeight     =   599
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   798
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label Label5 
      Caption         =   "NOTICE: A brain is required to use this program!"
      Height          =   255
      Left            =   8280
      TabIndex        =   3
      Top             =   120
      Width           =   3615
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "RENEGADE"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   855
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   3735
   End
   Begin VB.Label Label1 
      Caption         =   "Written by Viper187 "
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   8400
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "©2006 Psycho Snake Creations"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   8640
      Width           =   2655
   End
End
Attribute VB_Name = "dlgSplash"
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
'Dim tmptxt As String, spltext() As String
'Dim bah As Integer
'tmptxt = "57%41%52%4E%49%4E%47%3A%20%54%68%69%73%20%70%72%6F%67%72%61%6D%20%69%73%20%4E%" _
'         & "4F%54%20%70%75%62%6C%69%63%20%64%6F%6D%61%69%6E%20%6F%72%20%47%50%4C%21%20%49%74%20%6D%61%79%20%6E%6F%74%20%62%65%20%68%6F%73%74%65%64%20%6F%72%20%6C" _
'         & "%69%6E%6B%65%64%20%74%6F%20%62%79%20%61%6E%79%20%77%65%62%73%69%74%65%73%20%77%69%74%68%6F%75%74%20%61%64%76%61%6E%63%65%20%77%72%69%74%74%65%6E%20%70%65%72%6D%69%73%73%69%6F%6E%20%66%72%6F%6D%20%74%68%65%20%61%75%74" _
'         & "%68%6F%72%2E%20%54%68%65%20%61%75%74%68%6F%72%20%73%70%65%63%69%66%69%63%61%6C%6C%79%20%70%72%6F%68%69%62%69%74%73%20%47%53%43%65%6E%74%72%61%6C%20%66%72%6F%6D%20%68%6F%73%74%69%6E%67%20%6F%72%20%6C%69%6E%6B%69%6E%67%20%74%6F%20%69%74%2E%20%49%66%" _
'         & "20%79%6F%75%20%64%6F%77%6E%6C%6F%61%64%65%64%20%74%68%69%73%20%66%72%6F%6D%20%61%6E%79%77%68%65%72%65%20%62%75%74%20%54%68%65%20%53%6E%61%6B%65%20%50%69%74%20%6F%72%20%4B%6F%64%65%77%65%72%78%20%79%6F%75%20%73%68%6F%75%6C%64%20%70%65%72%66%6F%72%6D%20%61%20%66%75%6C%6C%20%76%69%" _
'         & "72%75%73%20%73%63%61%6E%20%6F%6E%20%79%6F%75%72%20%73%79%73%74%65%6D%20%69%6D%6D%65%64%69%61%74%65%6C%79%21"
'spltext = Split(tmptxt, "%")
'tmptxt = ""
'For bah = 0 To UBound(spltext)
' tmptxt = tmptxt & Chr(CLng("&H" & spltext(bah)))
'Next
' If Len(tmptxt) = 359 Then Label4.Caption = tmptxt
End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)
    Unload Me
End Sub
Private Sub Form_KeyUp(KeyAscii As Integer, shift As Integer)
    Unload Me
End Sub
Private Sub Form_Click()
    Unload Me
End Sub
Private Sub Label3_Click()
    Unload Me
End Sub
Private Sub Label4_Click()
    Unload Me
End Sub

