VERSION 5.00
Begin VB.Form dlgCreateOP 
   Caption         =   "Make Opcode"
   ClientHeight    =   4215
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6780
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4215
   ScaleWidth      =   6780
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frFMT 
      Caption         =   "Format"
      Height          =   735
      Left            =   1800
      TabIndex        =   18
      Top             =   1320
      Width           =   3135
      Begin VB.TextBox txtFMT 
         BackColor       =   &H8000000F&
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
         Left            =   240
         TabIndex        =   19
         Top             =   300
         Width           =   2655
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Opcode"
      Height          =   735
      Left            =   1680
      TabIndex        =   16
      Top             =   3120
      Width           =   3495
      Begin VB.TextBox txtOP 
         BackColor       =   &H8000000F&
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
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   17
         Top             =   300
         Width           =   3015
      End
   End
   Begin VB.Frame frValue 
      Caption         =   "Opcode Value"
      Height          =   735
      Left            =   240
      TabIndex        =   14
      Top             =   3120
      Width           =   1335
      Begin VB.TextBox txtValue 
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
         Left            =   120
         MaxLength       =   8
         TabIndex        =   15
         Top             =   300
         Width           =   1055
      End
   End
   Begin VB.CommandButton CmdPrevAddy 
      Caption         =   ">"
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
      Left            =   2020
      TabIndex        =   12
      Top             =   240
      Width           =   255
   End
   Begin VB.CommandButton cmdNextAddy 
      Caption         =   "<"
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
      Left            =   1775
      TabIndex        =   11
      Top             =   240
      Width           =   255
   End
   Begin VB.TextBox txtaddress 
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
      Left            =   960
      TabIndex        =   10
      Top             =   240
      Width           =   815
   End
   Begin VB.Frame frImm 
      Caption         =   "Immediate"
      Height          =   735
      Left            =   3480
      TabIndex        =   8
      Top             =   2160
      Width           =   1455
      Begin VB.TextBox txtImm 
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
         Left            =   200
         TabIndex        =   9
         Top             =   300
         Width           =   1055
      End
   End
   Begin VB.Frame frReg3 
      Caption         =   "Reg3"
      Height          =   735
      Left            =   2400
      TabIndex        =   6
      Top             =   2160
      Width           =   975
      Begin VB.ComboBox cmbReg3 
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   9
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   200
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   300
         Width           =   615
      End
   End
   Begin VB.Frame frReg2 
      Caption         =   "Reg2"
      Height          =   735
      Left            =   1320
      TabIndex        =   4
      Top             =   2160
      Width           =   975
      Begin VB.ComboBox cmbReg2 
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   9
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   200
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   300
         Width           =   615
      End
   End
   Begin VB.Frame frReg1 
      Caption         =   "Reg1"
      Height          =   735
      Left            =   240
      TabIndex        =   2
      Top             =   2160
      Width           =   975
      Begin VB.ComboBox cmbReg1 
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   9
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   200
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   300
         Width           =   615
      End
   End
   Begin VB.Frame frOpcode 
      Caption         =   "Opcode"
      Height          =   735
      Left            =   240
      TabIndex        =   0
      Top             =   1320
      Width           =   1455
      Begin VB.ComboBox cmbOP 
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   9
            Charset         =   255
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   200
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   300
         Width           =   1095
      End
   End
   Begin VB.Label Label1 
      Caption         =   "Address:"
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "dlgCreateOP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
