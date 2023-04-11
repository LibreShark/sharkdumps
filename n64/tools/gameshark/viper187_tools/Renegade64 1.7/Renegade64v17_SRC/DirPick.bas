Attribute VB_Name = "Module1"
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
Public Type BROWSEINFO
    hOwner As Long
    pidlRoot As Long
    pszDisplayName As String
    lpszTitle As String
    ulFlags As Long
    lpfn As Long
    lParam As Long
    iImage As Long
End Type

'32-bit API declarations
Declare Function SHGetPathFromIDList Lib "shell32.dll" _
  Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long

Declare Function SHBrowseForFolder Lib "shell32.dll" _
Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long
'This function will bring up a form to let the user select a directory
Function GetDirectory(Optional Msg) As String
    Dim bInfo As BROWSEINFO
    Dim path As String
    Dim r As Long, X As Long, i As Integer

'   Root folder = Desktop
    bInfo.pidlRoot = 0&

'   Title in the dialog
    If IsMissing(Msg) Then
        bInfo.lpszTitle = "Select a folder."
    Else
        bInfo.lpszTitle = Msg
    End If
    
'   Type of directory to return
    bInfo.ulFlags = &H1

'   Display the dialog
    X = SHBrowseForFolder(bInfo)
    
'   Parse the result
    path = Space$(512)
    r = SHGetPathFromIDList(ByVal X, ByVal path)
    If r Then
          i = InStr(path, Chr$(0))
        GetDirectory = Left(path, i - 1)
    Else
        GetDirectory = ""
    End If
End Function


