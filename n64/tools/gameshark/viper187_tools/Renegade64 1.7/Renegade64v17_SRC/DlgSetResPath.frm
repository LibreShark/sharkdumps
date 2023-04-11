VERSION 5.00
Begin VB.Form DlgSetResPath 
   Caption         =   "Choose Results Folder"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   960
      TabIndex        =   1
      Top             =   360
      Width           =   2295
   End
   Begin VB.DirListBox dirRes 
      Height          =   1665
      Left            =   960
      TabIndex        =   0
      Top             =   720
      Width           =   2295
   End
End
Attribute VB_Name = "DlgSetResPath"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
