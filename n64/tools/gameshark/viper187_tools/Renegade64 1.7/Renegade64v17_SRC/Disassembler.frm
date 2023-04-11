VERSION 5.00
Begin VB.Form Disassembler 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "R4300i Disassembler"
   ClientHeight    =   9000
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   7950
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   530
   Begin VB.CheckBox chkNemu 
      Caption         =   "Auto Unpause Nemu"
      Enabled         =   0   'False
      Height          =   255
      Left            =   6000
      TabIndex        =   96
      Top             =   600
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Timer tmrNemu 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   7440
      Top             =   1080
   End
   Begin VB.CheckBox chkEmuEdit 
      Caption         =   "Emulator RAM"
      Enabled         =   0   'False
      Height          =   255
      Left            =   6480
      TabIndex        =   95
      Top             =   360
      Width           =   1455
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   28
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   94
      Top             =   7680
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   27
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   93
      Top             =   7440
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   26
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   92
      Top             =   7200
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   25
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   91
      Top             =   6960
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   24
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   90
      Top             =   6720
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   23
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   89
      Top             =   6480
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   22
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   88
      Top             =   6240
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   21
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   87
      Top             =   6000
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   20
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   86
      Top             =   5760
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   19
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   85
      Top             =   5520
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   18
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   84
      Top             =   5280
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   17
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   83
      Top             =   5040
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   16
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   82
      Top             =   4800
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   15
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   81
      Top             =   4560
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   14
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   80
      Top             =   4320
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   13
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   79
      Top             =   4080
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   12
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   78
      Top             =   3840
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   11
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   77
      Top             =   3600
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   10
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   76
      Top             =   3360
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   9
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   75
      Top             =   3120
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   8
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   74
      Top             =   2880
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   7
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   73
      Top             =   2640
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   6
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   72
      Top             =   2400
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   5
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   71
      Top             =   2160
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   4
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   70
      Top             =   1920
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   3
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   69
      Top             =   1680
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   2
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   68
      Top             =   1440
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
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
      Height          =   270
      Index           =   1
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   8
      TabIndex        =   67
      Top             =   1200
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   28
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   66
      Top             =   7680
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   27
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   65
      Top             =   7440
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   26
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   64
      Top             =   7200
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   25
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   63
      Top             =   6960
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   24
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   62
      Top             =   6720
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   23
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   61
      Top             =   6480
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   22
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   60
      Top             =   6240
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   21
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   59
      Top             =   6000
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   20
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   58
      Top             =   5760
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   19
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   57
      Top             =   5520
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   18
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   56
      Top             =   5280
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   17
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   55
      Top             =   5040
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   16
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   54
      Top             =   4800
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   15
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   53
      Top             =   4560
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   14
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   52
      Top             =   4320
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   13
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   51
      Top             =   4080
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   12
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   50
      Top             =   3840
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   11
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   49
      Top             =   3600
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   10
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   48
      Top             =   3360
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   9
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   47
      Top             =   3120
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   8
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   46
      Top             =   2880
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   7
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   45
      Top             =   2640
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   6
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   44
      Top             =   2400
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   5
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   43
      Top             =   2160
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   4
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   42
      Top             =   1920
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   3
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   41
      Top             =   1680
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   2
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   40
      Top             =   1440
      Width           =   1050
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   1
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   39
      Top             =   1200
      Width           =   1050
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   28
      Left            =   3360
      TabIndex        =   38
      Top             =   7680
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   27
      Left            =   3360
      TabIndex        =   37
      Top             =   7440
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   26
      Left            =   3360
      TabIndex        =   36
      Top             =   7200
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   25
      Left            =   3360
      TabIndex        =   35
      Top             =   6960
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   24
      Left            =   3360
      TabIndex        =   34
      Top             =   6720
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   23
      Left            =   3360
      TabIndex        =   33
      Top             =   6480
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   22
      Left            =   3360
      TabIndex        =   32
      Top             =   6240
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   21
      Left            =   3360
      TabIndex        =   31
      Top             =   6000
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   20
      Left            =   3360
      TabIndex        =   30
      Top             =   5760
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   19
      Left            =   3360
      TabIndex        =   29
      Top             =   5520
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   18
      Left            =   3360
      TabIndex        =   28
      Top             =   5280
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   17
      Left            =   3360
      TabIndex        =   27
      Top             =   5040
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   16
      Left            =   3360
      TabIndex        =   26
      Top             =   4800
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   15
      Left            =   3360
      TabIndex        =   25
      Top             =   4560
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   14
      Left            =   3360
      TabIndex        =   24
      Top             =   4320
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   13
      Left            =   3360
      TabIndex        =   23
      Top             =   4080
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   12
      Left            =   3360
      TabIndex        =   22
      Top             =   3840
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   11
      Left            =   3360
      TabIndex        =   21
      Top             =   3600
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   10
      Left            =   3360
      TabIndex        =   20
      Top             =   3360
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   9
      Left            =   3360
      TabIndex        =   19
      Top             =   3120
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   8
      Left            =   3360
      TabIndex        =   18
      Top             =   2880
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   7
      Left            =   3360
      TabIndex        =   17
      Top             =   2640
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   6
      Left            =   3360
      TabIndex        =   16
      Top             =   2400
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   5
      Left            =   3360
      TabIndex        =   15
      Top             =   2160
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   4
      Left            =   3360
      TabIndex        =   14
      Top             =   1920
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   3
      Left            =   3360
      TabIndex        =   13
      Top             =   1680
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   2
      Left            =   3360
      TabIndex        =   12
      Top             =   1440
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   1
      Left            =   3360
      TabIndex        =   11
      Top             =   1200
      Width           =   3495
   End
   Begin VB.TextBox txtASM 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   0
      Left            =   3360
      TabIndex        =   10
      Top             =   960
      Width           =   3495
   End
   Begin VB.TextBox txtHex 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   0
      Left            =   2280
      MaxLength       =   8
      TabIndex        =   7
      Top             =   960
      Width           =   1050
   End
   Begin VB.TextBox txtAddys 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Index           =   0
      Left            =   1200
      MaxLength       =   8
      TabIndex        =   6
      Top             =   960
      Width           =   1050
   End
   Begin VB.ComboBox cmbSetEndian 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0000
      Left            =   0
      List            =   "Disassembler.frx":0010
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   360
      Width           =   2625
   End
   Begin VB.ComboBox cmbRegView 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0054
      Left            =   5280
      List            =   "Disassembler.frx":0067
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   0
      Width           =   2625
   End
   Begin VB.ComboBox cmbEditMenu 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":009F
      Left            =   2640
      List            =   "Disassembler.frx":00B8
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   0
      Width           =   2625
   End
   Begin VB.ComboBox cmbFileMenu 
      BackColor       =   &H8000000F&
      Height          =   315
      ItemData        =   "Disassembler.frx":0146
      Left            =   0
      List            =   "Disassembler.frx":016B
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   0
      Width           =   2625
   End
   Begin VB.CommandButton cmdPrevPG 
      Caption         =   "Previous"
      Enabled         =   0   'False
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   8160
      Width           =   1095
   End
   Begin VB.CommandButton cmdNextPG 
      Caption         =   "Next"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   0
      Top             =   8160
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Value"
      Height          =   255
      Left            =   2325
      TabIndex        =   9
      Top             =   780
      Width           =   510
   End
   Begin VB.Label Label1 
      Caption         =   "Addy/GoTo"
      Height          =   255
      Left            =   1200
      TabIndex        =   8
      Top             =   780
      Width           =   1095
   End
End
Attribute VB_Name = "Disassembler"
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
Dim addy As Long, ROMsize As Long
Dim ROMEdited As Boolean, ROMloaded As Boolean, pgLoading As Boolean
Public CurrentROM As String
Const PageSize = 28
 '100mb 26214400
Private Sub Form_Load()
 OpenTools(4) = True
 OPprintType = 0
 GPRnames = Split(GPRNameList1, ",")
 FPRnames = Split(FPRNameList1, ",")
 CP0names = Split(CP0NameList1, ",")
 fmt(16) = "S"
 fmt(17) = "D"
 fmt(20) = "W"
 fmt(21) = "L"
 cmbFileMenu.ListIndex = 0
 cmbEditMenu.ListIndex = 0
 cmbRegView.ListIndex = 0
 cmbSetEndian.ListIndex = 0
 EmuVarsDis
End Sub
Private Sub Form_Unload(cancel As Integer)
 Dim i As Integer
 If Right(Disassembler.Caption, 1) = "*" Then
  i = MsgBox("Save file before closing?", vbYesNoCancel)
  If i = vbYes Then
   mnuSaveROM
  ElseIf i = vbCancel Then
   cancel = 1
  End If
 End If
 If cancel <> 1 Then
  Close #ROMhandle
  Close #tmpHandle
  OpenTools(4) = False
 End If
End Sub
Public Sub EmuVarsDis()
 If EmuId(0) <> -1 Then
  chkEmuEdit.Enabled = True
  chkEmuEdit.value = 1
 Else
  chkEmuEdit.value = 0
  chkEmuEdit.Enabled = False
 End If
End Sub
Private Sub chkEmuEdit_Click()
 If chkEmuEdit.value Then
'  ROMsize = &H800000
  ROMsize = EmuRAM(EmuId(1))
'  chkNemu.Enabled = True
  cmdNextPG.Enabled = True
  RefreshPage
' Else
'  chkNemu.Enabled = False
 End If
End Sub
Private Sub mnuOpenROM()
 Dim tmpbyte As Byte
 Dim romname As String
 Close #ROMhandle
 ROMhandle = FreeFile
 If Not ChooseFile(CurrentROM, "N64 ROMs & Saves (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur,*.pj)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur;*.pj|All Files (*.*)|*", 1) Then Exit Sub
 Disassembler.Caption = "R4300i Disassembler - " & MainMDI.FileDlg.FileTitle
 Open (CurrentROM) For Binary As #ROMhandle
 ROMsize = LOF(ROMhandle)
 If LOF(ROMhandle) >= 52428800 Then
  TMPtype = 1
  Close #tmpHandle
  tmpHandle = FreeFile
  Open (App.path & "\renegade.tmp") For Binary As #tmpHandle
  Erase EditedAddys
 Else
  TMPtype = 0
  Erase EditedData
  Erase EditedAddys
 End If
 addy = 0
 Get #ROMhandle, 1, tmpbyte
  If tmpbyte = &H80 Then
  ROMendian = 2 'big endian
 ElseIf tmpbyte = &H37 Then
  ROMendian = 1 'byteswapped
 ElseIf tmpbyte = &H40 Then
  ROMendian = 0 'little endian
 Else
  dlgEndianSelect.Show vbModal
 End If
 ROMloaded = True
 cmdPrevPG.Enabled = False
 cmdNextPG.Enabled = True
 addy = 0
 cmbRegView.ListIndex = GetCFG("asmregfmt", 1, 1)
 ShowPage 0
End Sub
Private Sub ShowPage(ByVal addy As Long)
 Dim tmplong As Long, pHandle As Long, bah As Long
 Dim i As Long
' sAddy = sAddy + EmuOffsets(EmuId(1))
 pgLoading = True
 If chkEmuEdit.value Then
  If EmuId(0) = -1 Then Exit Sub
  pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
  If pHandle = 0 Then
   MsgBox "OpenProcess failed"
   MainMDI.mnuEmuDetach_Click
   Exit Sub
  End If
 End If
 For i = 0 To PageSize
  If (addy + 1) > ROMsize Then Exit For '????
  If chkEmuEdit.value Then
   If ReadProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + addy), tmplong, 4, bah) = 0 Then
    MsgBox "ReadProcessMemory failed"
    Exit Sub
   End If
  ElseIf GetAddyFlag(addy) Then
   tmplong = GetData(addy)
   txtHex(i).ForeColor = &H80000007
  ElseIf chkEmuEdit.value = 0 Then
   Get #ROMhandle, addy + 1, tmplong
   tmplong = FlipWord(tmplong, ROMendian)
   txtHex(i).ForeColor = &H80000008
  Else: txtHex(i).ForeColor = &H80000008
  End If
  txtAddys(i).text = String(8 - Len(Hex(addy)), "0") & Hex(addy)
  txtHex(i).text = String(8 - Len(Hex(tmplong)), "0") & Hex(tmplong)
  txtASM(i).text = Disassemble(addy, tmplong)
  addy = addy + 4
 Next
 If chkEmuEdit.value Then CloseHandle pHandle
 pgLoading = False
End Sub
Private Sub cmdNextPG_Click()
 cmdPrevPG.Enabled = True
 addy = addy + ((PageSize + 1) * 4)
 ShowPage addy
End Sub
Private Sub cmdPrevPG_Click()
 addy = addy - ((PageSize + 1) * 4)
 If addy <= 0 Then
  addy = 0
  cmdPrevPG.Enabled = False
 End If
 ShowPage addy
End Sub
Private Sub KeyDownCommon(ByVal index As Integer, ByVal keycode As Integer, ByVal shift As Integer)
 Dim i As Integer
 If (keycode = 40) And (shift = 2) Then 'CTRL + Down
  cmdNextPG_Click
 ElseIf (keycode = 40) And (shift = 0) And (index = PageSize) Then 'Down
  ScrollDown
 ElseIf (keycode = 38) And (shift = 2) Then 'CTRL + Up
  cmdPrevPG_Click
 ElseIf (keycode = 38) And (shift = 0) And (index = 0) Then 'Up
  ScrollUp
 ElseIf (keycode = 71) And (shift = 2) Then 'CTRL+G
  txtAddys(0).SetFocus
 ElseIf (keycode = 72) And (shift = 2) Then 'CTRL+H
  mnuViewROMHeader
' ElseIf (keycode = 67) And (shift = 2) Then 'CTRL+C
'  mnuCopyLine
'  Clipboard.SetText txtAddys(index).text & " " & txtHex(index).text & " " & txtASM(index).text
 ElseIf (keycode = 67) And (shift = 6) Then 'CTRL+Alt+C
  mnuCopyChanges
 ElseIf (keycode = 67) And (shift = 3) Then 'CTRL+Shift+C
  mnuCopyChangesGS
 ElseIf (keycode = 83) And (shift = 2) Then 'CTRL+S
  mnuSaveROM
 ElseIf (keycode = 83) And (shift = 3) Then 'CTRL+Shift+S
  mnuSaveROMas
 ElseIf (keycode = 79) And (shift = 2) Then 'CTRL+O
  mnuOpenROM
 ElseIf (keycode = 69) And (shift = 2) Then 'CTRL+E
  mnuSavetxtROM
 ElseIf (keycode = 116) And (shift = 0) Then 'F5
  RefreshPage
 ElseIf (keycode = 116) And (shift = 2) Then 'CTRL+F5
  For i = 0 To PageSize
   SetAddyFlag addy + (i * 4), 0
  Next
  RefreshPage
 ElseIf (keycode = 27) And (shift = 0) Then 'CTRL+ESC
  SetAddyFlag addy + (index * 4), 0
  RefreshPage
 End If
End Sub
Private Sub txtHex_KeyDown(index As Integer, keycode As Integer, shift As Integer)
'MsgBox keycode & "," & shift, vbOKOnly
 If (keycode = 13) Then 'Enter
  If index < PageSize Then
   txtHex(index + 1).SetFocus
   txtHex(index + 1).SelStart = 0
  Else
   ScrollDown
  End If
 ElseIf (keycode = 114) Then  'F3
  txtASM(index).SetFocus
 ElseIf (keycode = 40) And (shift = 0) And (index < PageSize) Then 'Down
   txtHex(index + 1).SetFocus
   txtHex(index + 1).SelStart = 0
 ElseIf (keycode = 38) And (shift = 0) And (index > 0) Then 'Up
   txtHex(index - 1).SetFocus
   txtHex(index - 1).SelStart = 0
 Else: KeyDownCommon index, keycode, shift
 End If
End Sub
Private Sub txtASM_KeyDown(index As Integer, keycode As Integer, shift As Integer)
'MsgBox keycode & "," & shift, vbOKOnly
 If (keycode = 13) Then 'Enter
  If MakeOp(addy + (index * 4), UCase(txtASM(index).text)) Then
   SetASM index
   If index < PageSize Then
    txtASM(index + 1).SetFocus
   Else
    ScrollDown
   End If
  Else
   MsgBox ASMerror, vbOKOnly, "Assembly Error"
  End If
 ElseIf (keycode = 40) And (shift = 0) And (index < PageSize) Then 'Down
   txtASM(index + 1).SetFocus
'   txtASM(index + 1).SelStart = 0
 ElseIf (keycode = 38) And (shift = 0) And (index > 0) Then 'Up
   txtASM(index - 1).SetFocus
'   txtASM(index - 1).SelStart = 0
 Else: KeyDownCommon index, keycode, shift
 End If
End Sub
Private Sub txtASM_GotFocus(index As Integer)
 txtASM(index).SelStart = 0
 txtASM(index).SelLength = Len(txtASM(index).text)
End Sub
Private Sub txtASM_LostFocus(index As Integer)
 txtASM(index).text = Disassemble(addy + (index * 4), CLng("&H" & txtHex(index).text))
End Sub
Private Sub txtAddys_KeyDown(index As Integer, keycode As Integer, shift As Integer)
 Dim tmpaddy As Long
 If (keycode = 13) And (index = 0) Then 'Enter
  tmpaddy = CLng("&H" & txtAddys(index).text)
  If (tmpaddy >= 0) And (tmpaddy < ROMsize) Then
   cmdPrevPG.Enabled = True
   addy = tmpaddy
   ShowPage addy
  End If
 ElseIf (keycode = 86) And (shift = 2) Then 'CTRL+V
  txtAddys(0).text = Clipboard.GetText
 Else: KeyDownCommon index, keycode, shift
 End If
End Sub
Private Sub txtAddys_Keypress(index As Integer, PressedKey As Integer)
 PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtAddys_Change(index As Integer)
 If index = 0 Then txtAddys(0).text = FilterHexValues(txtAddys(0).text)
End Sub
Private Sub txtHex_KeyPress(index As Integer, PressedKey As Integer)
 Dim tmpaddy As Long, tmpval As Long
 If txtHex(index).SelLength <> 1 Then txtHex(index).SelLength = 1
 PressedKey = FilterHexKeys(PressedKey)
End Sub
Private Sub txtHex_Change(index As Integer)
 Dim tmpvalue As Long, defvalue As Long, tmpaddy As Long
 If pgLoading Then Exit Sub
 tmpaddy = addy + (index * 4)
 If Len(txtHex(index).text) > 8 Then txtHex(index).text = "00000000"
 txtHex(index).text = HexString(CLng("&H" & FilterHexValues(txtHex(index).text)), 8)
 tmpvalue = CLng("&H" & FilterHexValues(txtHex(index).text))
 If chkEmuEdit.value Then
  If Not WriteDisEmu(tmpaddy, tmpvalue) Then Exit Sub
  txtASM(index).text = Disassemble(tmpaddy, tmpvalue)
  txtHex(index).ForeColor = &H80000007
  ROMEdited = True
 Else
  Get #ROMhandle, tmpaddy + 1, defvalue
  defvalue = FlipWord(defvalue, ROMendian)
  If tmpvalue = defvalue Then
   SetAddyFlag tmpaddy, 0
   txtHex(index).ForeColor = &H80000008
  Else
   SetData tmpaddy, tmpvalue
   SetAddyFlag tmpaddy, 1
  txtASM(index).text = Disassemble(tmpaddy, tmpvalue)
  txtHex(index).ForeColor = &H80000007
  ROMEdited = True
  End If
 End If
End Sub
Private Sub ScrollDown()
 addy = addy + 4
 cmdPrevPG.Enabled = True
 If addy > ROMsize Then Exit Sub
 ShowPage addy
End Sub
Private Sub ScrollUp()
 addy = addy - 4
 If addy < 0 Then Exit Sub
 If addy = 0 Then cmdPrevPG.Enabled = False
 ShowPage addy
End Sub
Private Sub SetASM(ByVal index As Integer)
 Dim tmpaddy As Long, i As Integer
 tmpaddy = addy + (index * 4)
 For i = 0 To UBound(AssembledOP)
  If AssembledOP(i) <> -1 Then
   If (tmpaddy + (i * 4)) > ROMsize Then
    MsgBox "Opcode writing incomplete. Operation would exceed end of file.", vbOKOnly
    Exit Sub
   End If
   If chkEmuEdit.value Then
    If Not WriteDisEmu(tmpaddy + (i * 4), AssembledOP(i)) Then Exit Sub
   Else
    SetData tmpaddy + (i * 4), AssembledOP(i)
   End If
   SetAddyFlag tmpaddy + (i * 4), 1
  End If
 Next
 ROMEdited = True
 RefreshPage
End Sub
Private Function WriteDisEmu(ByVal addy As Long, ByVal value As Long) As Boolean
 Dim pHandle As Long, bah As Long
 WriteDisEmu = False
 If EmuId(0) = -1 Then Exit Function
 pHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, EmuId(0))
 If pHandle = 0 Then
  MsgBox "OpenProcess failed"
  MainMDI.mnuEmuDetach_Click
  Exit Function
 End If
 If WriteProcessMemory(pHandle, (EmuOffsets(EmuId(1)) + addy), value, 4, bah) = 0 Then
  MsgBox "Write failed"
  Exit Function
 End If
 CloseHandle pHandle
 WriteDisEmu = True
' tmrNemu.Enabled = True
End Function
Private Sub mnuSaveROM()
 If ROMEdited Then SaveChanges 1
End Sub
Private Sub mnuSaveROMas()
 If ROMloaded Then SaveChanges 2
End Sub
Private Sub mnuViewROMHeader()
 If ROMloaded Then dlgROMheader.Show vbModal
End Sub
Private Sub mnuCopyChanges()
 If ROMEdited Then SaveChanges 4
End Sub
Private Sub mnuCopyChangesGS()
 If ROMEdited Then SaveChanges 6
End Sub
Private Sub mnuCopyPage()
 If ROMloaded Then SavePage 0
End Sub
Private Sub mnuCopyPageGS()
 If ROMloaded Then SavePage 2
End Sub
Private Sub mnuSaveChangesTXT()
 If ROMEdited Then SaveChanges 3
End Sub
Private Sub mnuSaveChangesGS()
 If ROMEdited Then SaveChanges 5
End Sub
Private Sub mnuSavePageTXT()
 If ROMloaded Then SavePage 1
End Sub
Private Sub mnuSavePageGS()
 If ROMloaded Then SavePage 3
End Sub
Private Sub SaveChanges(ByVal save As Byte)
 Dim i As Long
 Dim e As Long
 Dim tmpaddy As Long, tmpvalue As Long
 Dim tmpstring As String
 Dim errnumber As Long
 Dim temphandle
 temphandle = FreeFile
 If save = 2 Then
  If Not ChooseFile(tmpstring, "N64 ROMs (*.v64,*.z64,*.bin,*.rom,*.usa,*.jap,*.eur)|*.v64;*.z64;*.bin;*.rom;*.usa;*.jap;*.eur|All Files (*.*)|*", 0) Then Exit Sub
   errnumber = CopyFileBytes(CurrentROM, tmpstring, 0, 0, 0)
   If errnumber <> 0 Then
    ShowDLLError errnumber
    Exit Sub
   End If
  Open (tmpstring) For Binary Access Write As #temphandle
  CurrentROM = tmpstring
  Disassembler.Caption = "R4300i Disassembler - " & MainMDI.FileDlg.FileTitle
 ElseIf (save = 3) Or (save = 5) Then
  If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
  Open (tmpstring) For Output As #temphandle
 End If
 i = 0
 tmpstring = ""
 Do
    tmpaddy = i
    If GetAddyFlag(tmpaddy) Then
     tmpvalue = GetData(tmpaddy)
     Select Case save
      Case 1 'Save
       Put #ROMhandle, tmpaddy + 1, FlipWord(tmpvalue, ROMendian)
      Case 2 'Save As
       Put #temphandle, tmpaddy + 1, FlipWord(tmpvalue, ROMendian)
      Case 3 'Save TXT
       Print #temphandle, HexString(tmpaddy, 8) & Space(2) & HexString(tmpvalue, 8) & Space(2) & _
                    Disassemble(tmpaddy, tmpvalue)
      Case 4 'Copy TXT
       tmpstring = tmpstring & HexString(tmpaddy, 8) & Space(2) & HexString(tmpvalue, 8) & _
                   Space(2) & Disassemble(tmpaddy, tmpvalue) & vbCrLf
      Case 5 'Save GS
       If tmpvalue <> 0 Then
        Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                           "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4)
       Else
        Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & "2400"
       End If
      Case 6 'Copy GS
       If tmpvalue <> 0 Then
        tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                                "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4) & vbCrLf
       Else
        tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & "2400" & vbCrLf
       End If
     End Select
    End If
  If (EditedAddys(i \ 32) = 0) And save <> 2 Then
   i = i + (32 - (i Mod 32))
  Else
   i = i + 4
  End If
 Loop While i < ROMsize
 If (save = 2) Or (save = 3) Or (save = 5) Then Close #temphandle
 If save <= 2 Then
  ROMEdited = False
  Erase EditedAddys
 End If
 If (save = 4) Or (save = 6) Then
  Clipboard.Clear
  Clipboard.SetText tmpstring
 End If
End Sub
Private Sub mnuSavetxtROM()
 If Not ROMloaded Then Exit Sub
 Dim i As Integer
 If Right(Disassembler.Caption, 1) = "*" Then
  i = MsgBox("Save file before exporting?", vbYesNo)
  If i = vbYes Then mnuSaveROM
 End If
 dlgExportDis.Show vbModal
End Sub
Public Sub ExportDis(ByVal OutFile As String, ByVal GPRtype As Byte, ByVal AlignOpt As Byte, ByVal AddysOpt As Byte, ByVal RangeLO As Long, ByVal RangeHi As Long)
 Dim errnumber As Long
 If (RangeLO >= RangeHi) Or (RangeHi > ROMsize) Then RangeHi = 0
 errnumber = WriteDis(CurrentROM, OutFile, ROMendian, GPRtype, AddysOpt, AlignOpt, RangeLO, RangeHi)
 If errnumber <> 0 Then ShowDLLError errnumber
End Sub
Private Sub SavePage(ByVal save As Byte)
 Dim i As Integer
 Dim tmpstring As String
 Dim tmpaddy As Long, tmpvalue As Long
 Dim temphandle
 tmpaddy = addy
 If tmpaddy < 0 Then tmpaddy = 0
 If (save = 1) Or (save = 3) Then
  temphandle = FreeFile
  If Not ChooseFile(tmpstring, "Text Files (*.txt)|*.txt", 0) Then Exit Sub
  Open (tmpstring) For Output As #temphandle
 End If
 tmpstring = ""
 For i = 0 To PageSize
  If GetAddyFlag(tmpaddy) Then
   tmpvalue = GetData(tmpaddy)
  Else
   Get #ROMhandle, tmpaddy + 1, tmpvalue
   tmpvalue = FlipWord(tmpvalue, ROMendian)
  End If
  Select Case save
   Case 0 'copy page
    tmpstring = tmpstring & txtAddys(i).text & " " & txtHex(i).text & " " & txtASM(i).text & vbCrLf
   Case 1 'save page txt
    Print #temphandle, txtAddys(i).text & " " & txtHex(i).text & " " & txtASM(i).text
   Case 2 'copy page GS
    If tmpvalue <> 0 Then
     tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                             "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4) & vbCrLf
    Else
     tmpstring = tmpstring & "81" & HexString(tmpaddy, 6) & " " & "2400" & vbCrLf
    End If
   Case 3 'save page GS
    If tmpvalue <> 0 Then
     Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & HexString(SRL(tmpvalue, 16), 4) & vbCrLf & _
                        "81" & HexString(tmpaddy + 2, 6) & " " & HexString((tmpvalue And 65535), 4)
    Else
     Print #temphandle, "81" & HexString(tmpaddy, 6) & " " & "2400"
    End If
  End Select
  tmpaddy = tmpaddy + 4
 Next
 If (save = 1) Or (save = 3) Then
  Close #temphandle
 Else
  Clipboard.SetText tmpstring
 End If
End Sub
Private Sub cmbRegView_Click()
 WriteCFG "asmregfmt", cmbRegView.ListIndex
 Select Case cmbRegView.ListIndex
  Case 0: Exit Sub
  Case 1: GPRnames = Split(LCase(GPRNameList1), ",")
  Case 2: GPRnames = Split(GPRNameList1, ",")
  Case 3: GPRnames = Split(GPRNameList2, ",")
  Case 4: GPRnames = Split(GPRNameList3, ",")
 End Select
 cmbRegView.ListIndex = 0
 If Not ROMloaded Then Exit Sub
 RefreshPage
End Sub
Private Sub cmbSetEndian_Click()
 If cmbSetEndian.ListIndex = 0 Then Exit Sub
 ROMendian = cmbSetEndian.ListIndex - 1
 cmbSetEndian.ListIndex = 0
 If Not ROMloaded Then Exit Sub
 RefreshPage
End Sub
Public Sub RefreshPage()
 ShowPage addy
End Sub
Private Sub mnuClearChanges()
 Erase EditedAddys
 ROMEdited = False
 RefreshPage
End Sub
Private Sub cmbFileMenu_Click()
 Select Case cmbFileMenu.ListIndex
  Case 0: Exit Sub
  Case 1: mnuOpenROM
  Case 2: mnuSaveROM
  Case 3: mnuSaveROMas
  Case 4: mnuSaveChangesTXT
  Case 5: mnuSaveChangesGS
  Case 6: mnuSavePageTXT
  Case 7: mnuSavePageGS
  Case 8: mnuSavetxtROM
  Case 9: mnuClearChanges
  Case 10: mnuViewROMHeader
'  Case 11: Unload Disassembler
 End Select
 cmbFileMenu.ListIndex = 0
End Sub
Private Sub cmbEditMenu_Click()
 Select Case cmbEditMenu.ListIndex
  Case 0: Exit Sub
  Case 1: mnuCopyChanges
  Case 2: mnuCopyChangesGS
  Case 3: mnuCopyPage
  Case 4: mnuCopyPageGS
  Case 5: RefreshPage
  Case 6: KeyDownCommon 0, 116, 2
 End Select
 cmbEditMenu.ListIndex = 0
End Sub
Private Sub tmrNemu_Timer()
 Dim fgwindow As Long
 Dim WindowCaption As String
 fgwindow = GetForegroundWindow
 If IsWindowVisible(fgwindow) <> 0 Then
  WindowCaption = Space(GetWindowTextLength(fgwindow) + 1)
  WindowCaption = Left$(WindowCaption, GetWindowText(fgwindow, WindowCaption, Len(WindowCaption)))
  If InStr(LCase(WindowCaption), "nemu64") Then
   If chkNemu.value Then SendKeys "{F4}"
   SendKeys "^K"
   tmrNemu.Enabled = False
  End If
 End If
End Sub
