VERSION 5.00
Begin VB.Form CodeFormat 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Format Codes"
   ClientHeight    =   9000
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   552
   Begin VB.CommandButton cmdCopyParsed 
      Caption         =   "Copy"
      Height          =   375
      Left            =   5640
      TabIndex        =   8
      Top             =   3960
      Width           =   975
   End
   Begin VB.CommandButton cmdClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   6840
      TabIndex        =   7
      Top             =   3960
      Width           =   975
   End
   Begin VB.TextBox txtCreator 
      Height          =   285
      Left            =   5520
      TabIndex        =   4
      Top             =   7800
      Width           =   1695
   End
   Begin VB.CommandButton cmdParse 
      Caption         =   "Parse"
      Height          =   375
      Left            =   4440
      TabIndex        =   3
      Top             =   3960
      Width           =   975
   End
   Begin VB.ComboBox cmbParseType 
      Height          =   315
      ItemData        =   "CodeFormat.frx":0000
      Left            =   720
      List            =   "CodeFormat.frx":000A
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   4080
      Width           =   3015
   End
   Begin VB.TextBox txtCodesOut 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   4680
      Width           =   6855
   End
   Begin VB.TextBox txtCodesIn 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   840
      Width           =   6855
   End
   Begin VB.Label Label2 
      Caption         =   "Input:"
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   600
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Creator:"
      Height          =   255
      Left            =   4920
      TabIndex        =   5
      Top             =   7800
      Width           =   615
   End
End
Attribute VB_Name = "CodeFormat"
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
 cmbParseType.ListIndex = 0
End Sub
Private Sub cmdParse_Click()
 Select Case cmbParseType.ListIndex
  Case 0: BrokeToGSC
  Case 1: unGSC
 End Select
End Sub
Private Sub BrokeToGSC()
 Dim i As Integer
 Dim codes() As String, tmp1 As String, tmp2 As String, tmp3 As String, output As String
 If InStr(txtCodesIn.text, vbCrLf) = 0 Then Exit Sub
 codes = Split(txtCodesIn.text, Chr(13) + Chr(10))
 For i = 0 To UBound(codes)
  FixLine codes(i)
  If Left(codes(i), 2) = "T:" Then
   output = output & codes(i) & vbCrLf & vbCrLf
  ElseIf ((i + 1) <= UBound(codes)) And Trim(codes(i)) <> "" Then
   tmp1 = codes(i)
   tmp2 = ""
   tmp3 = ""
   Do
    i = i + 1
    If (Left(codes(i), 1) = "-") Or (Left(codes(i), 1) = "*") Then
     If tmp3 <> "" Then tmp3 = tmp3 & "<br />"
     tmp3 = tmp3 & Mid(codes(i), 2)
    Else
     If tmp2 <> "" Then tmp2 = tmp2 & "<br />"
     tmp2 = tmp2 & codes(i)
    End If
    If (i + 1) > UBound(codes) Then Exit Do
    If Trim(codes(i + 1)) = "" Then Exit Do
   Loop
   output = output & "C:" & tmp1 & "|" & tmp2 & "|" & txtCreator.text & "|" & tmp3 & vbCrLf
  End If
 Next
 txtCodesOut.text = output
End Sub
Private Sub unGSC()
 Dim gsc() As String, tmp1() As String
 Dim output As String, temp1 As String, splchar As String
 Dim i As Integer
 If InStr(txtCodesIn.text, vbCrLf) > 0 Then
  splchar = vbCrLf
 ElseIf InStr(txtCodesIn.text, Chr(10)) Then
  splchar = Chr(10)
 ElseIf InStr(txtCodesIn.text, Chr(13)) Then
  splchar = Chr(13)
 Else
  Exit Sub
 End If
 gsc = Split(txtCodesIn.text, splchar)
 For i = 0 To UBound(gsc)
  gsc(i) = Trim(gsc(i))
  If (Left(gsc(i), 2) = "T:") Or (Left(gsc(i), 2) = "G:") Then
   output = output & Mid(gsc(i), 3) & vbCrLf & vbCrLf
  ElseIf Left(gsc(i), 2) = "C:" Then
   tmp1 = Split(Mid(gsc(i), 3), "|")
   tmp1(1) = Replace(tmp1(1), " <", "<")
   tmp1(1) = Replace(tmp1(1), "> ", ">")
   tmp1(1) = Replace(UCase(tmp1(1)), "<BR>", vbCrLf)
   tmp1(1) = Replace(UCase(tmp1(1)), "<BR />", vbCrLf)
   output = output & Trim(tmp1(0)) & vbCrLf & Trim(tmp1(1)) & vbCrLf
   If UBound(tmp1) >= 3 Then
    If tmp1(3) <> "" Then output = output & vbCrLf & "-" & Trim(tmp1(3)) & vbCrLf
   End If
   output = output & vbCrLf
  End If
 Next
  txtCodesOut.text = output
End Sub
Private Sub FixLine(ByRef code As String)
 code = Replace(code, "inf.", "1nfinite")
 code = Replace(code, "Inf.", "1nfinite")
 code = Replace(code, "Infinite", "1nfinite")
 code = Replace(code, "infinite", "1nfinite")
 code = Replace(code, "inf ", "Infinite")
 code = Replace(code, "Inf ", "Infinite")
 code = Replace(code, "1nfinite", "Infinite")
 code = Replace(code, "Exp.", "E7perience")
 code = Replace(code, "exp.", "E7perience")
 code = Replace(code, "Experience", "E7perience")
 code = Replace(code, "experience", "E7perience")
 code = Replace(code, "Exp ", "Experience")
 code = Replace(code, "exp ", "Experience")
 code = Replace(code, "E7perience", "Experience")
 code = Replace(code, "Mods", "Modifiers")
 code = Replace(code, "Mod.", "Modifier")
 code = Replace(code, "mods", "Modifiers")
 code = Replace(code, "mod.", "Modifier")
 code = Replace(code, "Modifier", "M0difier")
 code = Replace(code, "modifier", "M0difier")
 code = Replace(code, "Mod ", "Modifier")
 code = Replace(code, "mod ", "Modifier")
 code = Replace(code, "M0difier", "Modifier")
 code = Replace(code, "Modifer", "Modifier")
 code = Replace(code, "modifer", "Modifier")
End Sub
Private Sub Label1_Click()
 txtCreator.text = "Viper187"
End Sub
Private Sub cmdClear_Click()
 txtCodesIn.text = ""
End Sub
Private Sub txtCodesOut_KeyDown(keycode As Integer, shift As Integer)
 If (keycode = 65) And (shift = 2) Then 'CTRL+A
  txtCodesOut.SelStart = 0
  txtCodesOut.SelLength = Len(txtCodesOut.text)
 End If
End Sub
Private Sub cmdCopyParsed_Click()
 Clipboard.SetText txtCodesOut.text
End Sub
