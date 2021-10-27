VERSION 5.00
Begin VB.Form form1 
   AutoRedraw      =   -1  'True
   Caption         =   "飞机对战"
   ClientHeight    =   9795
   ClientLeft      =   5775
   ClientTop       =   1410
   ClientWidth     =   8355
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   9795
   ScaleWidth      =   8355
   Begin VB.CommandButton Command3 
      Caption         =   "逆时钟转动"
      Height          =   615
      Left            =   5880
      TabIndex        =   107
      Top             =   6960
      Width           =   1935
   End
   Begin VB.CommandButton Command2 
      Caption         =   "向下"
      Height          =   375
      Index           =   3
      Left            =   6240
      TabIndex        =   106
      Top             =   6240
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "向右"
      Height          =   375
      Index           =   2
      Left            =   6840
      TabIndex        =   105
      Top             =   5760
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "向左"
      Height          =   375
      Index           =   1
      Left            =   5640
      TabIndex        =   104
      Top             =   5760
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "向上"
      Height          =   375
      Index           =   0
      Left            =   6240
      TabIndex        =   103
      Top             =   5280
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "开始"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   5880
      TabIndex        =   99
      Top             =   3840
      Width           =   1815
   End
   Begin VB.Label Label9 
      Caption         =   "本游戏采用19局10胜制"
      Height          =   375
      Left            =   6000
      TabIndex        =   113
      Top             =   3240
      Width           =   1815
   End
   Begin VB.Label score 
      Caption         =   "0  :  0"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   6480
      TabIndex        =   112
      Top             =   2760
      Width           =   1455
   End
   Begin VB.Label Label7 
      Caption         =   "计算机  ：  玩家"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5880
      TabIndex        =   111
      Top             =   2160
      Width           =   2055
   End
   Begin VB.Label Label6 
      Caption         =   "比分"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6600
      TabIndex        =   110
      Top             =   1680
      Width           =   615
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      Height          =   180
      Left            =   480
      TabIndex        =   109
      Top             =   360
      Width           =   90
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   49
      Left            =   4680
      TabIndex        =   108
      Top             =   360
      Width           =   615
   End
   Begin VB.Label Label5 
      BackColor       =   &H0000FF00&
      Height          =   135
      Left            =   5400
      TabIndex        =   102
      Top             =   720
      Width           =   375
   End
   Begin VB.Label Label4 
      BackColor       =   &H000000FF&
      Height          =   135
      Left            =   5400
      TabIndex        =   101
      Top             =   480
      Width           =   375
   End
   Begin VB.Label Label3 
      Caption         =   "红色表示击中绿色表示未击中"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   15
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   5880
      TabIndex        =   100
      Top             =   360
      Width           =   1935
   End
   Begin VB.Label Label2 
      Caption         =   "玩家"
      BeginProperty Font 
         Name            =   "隶书"
         Size            =   24
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   375
      Left            =   2640
      TabIndex        =   98
      Top             =   9120
      Width           =   1095
   End
   Begin VB.Line Line1 
      BorderColor     =   &H000000FF&
      BorderWidth     =   5
      X1              =   840
      X2              =   5520
      Y1              =   4680
      Y2              =   4680
   End
   Begin VB.Label Label1 
      Caption         =   "计算机"
      BeginProperty Font 
         Name            =   "隶书"
         Size            =   24
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   375
      Left            =   2640
      TabIndex        =   97
      Top             =   -120
      Width           =   1695
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   48
      Left            =   4080
      TabIndex        =   96
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   47
      Left            =   3480
      TabIndex        =   95
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   46
      Left            =   2880
      TabIndex        =   94
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   45
      Left            =   2280
      TabIndex        =   93
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   44
      Left            =   1680
      TabIndex        =   92
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   43
      Left            =   1080
      TabIndex        =   91
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   42
      Left            =   4680
      TabIndex        =   90
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   41
      Left            =   4080
      TabIndex        =   89
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   40
      Left            =   3480
      TabIndex        =   88
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   39
      Left            =   2880
      TabIndex        =   87
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   38
      Left            =   2280
      TabIndex        =   86
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   37
      Left            =   1680
      TabIndex        =   85
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   36
      Left            =   1080
      TabIndex        =   84
      Top             =   960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   35
      Left            =   4680
      TabIndex        =   83
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   34
      Left            =   4080
      TabIndex        =   82
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   33
      Left            =   3480
      TabIndex        =   81
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   32
      Left            =   2880
      TabIndex        =   80
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   31
      Left            =   2280
      TabIndex        =   79
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   30
      Left            =   1680
      TabIndex        =   78
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   29
      Left            =   1080
      TabIndex        =   77
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   28
      Left            =   4680
      TabIndex        =   76
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   27
      Left            =   4080
      TabIndex        =   75
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   26
      Left            =   3480
      TabIndex        =   74
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   25
      Left            =   2880
      TabIndex        =   73
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   24
      Left            =   2280
      TabIndex        =   72
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   23
      Left            =   1680
      TabIndex        =   71
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   22
      Left            =   1080
      TabIndex        =   70
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   21
      Left            =   4680
      TabIndex        =   69
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   20
      Left            =   4080
      TabIndex        =   68
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   19
      Left            =   3480
      TabIndex        =   67
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   18
      Left            =   2880
      TabIndex        =   66
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   17
      Left            =   2280
      TabIndex        =   65
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   16
      Left            =   1680
      TabIndex        =   64
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   15
      Left            =   1080
      TabIndex        =   63
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   14
      Left            =   4680
      TabIndex        =   62
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   13
      Left            =   4080
      TabIndex        =   61
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   12
      Left            =   3480
      TabIndex        =   60
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   11
      Left            =   2880
      TabIndex        =   59
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   10
      Left            =   2280
      TabIndex        =   58
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   9
      Left            =   1680
      TabIndex        =   57
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   8
      Left            =   1080
      TabIndex        =   56
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   7
      Left            =   4680
      TabIndex        =   55
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   6
      Left            =   4080
      TabIndex        =   54
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   5
      Left            =   3480
      TabIndex        =   53
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   4
      Left            =   2880
      TabIndex        =   52
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   3
      Left            =   2280
      TabIndex        =   51
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   2
      Left            =   1680
      TabIndex        =   50
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube1 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   1
      Left            =   1080
      TabIndex        =   49
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   49
      Left            =   4680
      TabIndex        =   48
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   48
      Left            =   4080
      TabIndex        =   47
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   47
      Left            =   3480
      TabIndex        =   46
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   46
      Left            =   2880
      TabIndex        =   45
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   45
      Left            =   2280
      TabIndex        =   44
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   44
      Left            =   1680
      TabIndex        =   43
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   43
      Left            =   1080
      TabIndex        =   42
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   42
      Left            =   4680
      TabIndex        =   41
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   41
      Left            =   4080
      TabIndex        =   40
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   40
      Left            =   3480
      TabIndex        =   39
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   39
      Left            =   2880
      TabIndex        =   38
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   38
      Left            =   2280
      TabIndex        =   37
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   37
      Left            =   1680
      TabIndex        =   36
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   36
      Left            =   1080
      TabIndex        =   35
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   35
      Left            =   4680
      TabIndex        =   34
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   34
      Left            =   4080
      TabIndex        =   33
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   33
      Left            =   3480
      TabIndex        =   32
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   32
      Left            =   2880
      TabIndex        =   31
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   31
      Left            =   2280
      TabIndex        =   30
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   30
      Left            =   1680
      TabIndex        =   29
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   29
      Left            =   1080
      TabIndex        =   28
      Top             =   6000
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   28
      Left            =   4680
      TabIndex        =   27
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   27
      Left            =   4080
      TabIndex        =   26
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   26
      Left            =   3480
      TabIndex        =   25
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   735
      Index           =   25
      Left            =   2880
      TabIndex        =   24
      Top             =   6480
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   24
      Left            =   2280
      TabIndex        =   23
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   23
      Left            =   1680
      TabIndex        =   22
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   22
      Left            =   1080
      TabIndex        =   21
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   21
      Left            =   4680
      TabIndex        =   20
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   20
      Left            =   4080
      TabIndex        =   19
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   19
      Left            =   3480
      TabIndex        =   18
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   18
      Left            =   2880
      TabIndex        =   17
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   17
      Left            =   2280
      TabIndex        =   16
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   16
      Left            =   1680
      TabIndex        =   15
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   15
      Left            =   1080
      TabIndex        =   14
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   14
      Left            =   4680
      TabIndex        =   13
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   13
      Left            =   4080
      TabIndex        =   12
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   12
      Left            =   3480
      TabIndex        =   11
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   11
      Left            =   2880
      TabIndex        =   10
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   10
      Left            =   2280
      TabIndex        =   9
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   9
      Left            =   1680
      TabIndex        =   8
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   8
      Left            =   1080
      TabIndex        =   7
      Top             =   7800
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   7
      Left            =   4680
      TabIndex        =   6
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   6
      Left            =   4080
      TabIndex        =   5
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   5
      Left            =   3480
      TabIndex        =   4
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   4
      Left            =   2880
      TabIndex        =   3
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   3
      Left            =   2280
      TabIndex        =   2
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   2
      Left            =   1680
      TabIndex        =   1
      Top             =   8400
      Width           =   615
   End
   Begin VB.Label lblCube 
      BorderStyle     =   1  'Fixed Single
      Height          =   615
      Index           =   1
      Left            =   1080
      TabIndex        =   0
      Top             =   8400
      Width           =   615
   End
End
Attribute VB_Name = "form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim isTurn As Integer                                       '0为计算机，1为玩家
Dim w(1 To 7, 1 To 7, 11 To 77, 1 To 4) As Integer
Dim isMaybe(1 To 7, 1 To 7, 11 To 77, 1 To 4) As Boolean            '1-4表示方向，11-77表示飞机头
Dim cubeValue(1 To 7, 1 To 7) As Integer
Dim isFact(1 To 7, 1 To 7) As Integer
Dim head(1 To 7, 1 To 7) As Boolean
Dim Direct As Integer
Dim head1(1 To 7, 1 To 7) As Boolean
Dim direct1 As Integer
Dim max As Integer
Dim maxX As Integer
Dim maxY As Integer
Dim changeX As Integer
Dim changeY As Integer
Dim clr(8, 8) As String
Dim isStart As Boolean
Dim ph As Integer
Const pb = 1
Const none = 0
Dim way As Integer
Dim jc As Integer, wc As Integer

Private Sub Command1_Click()    '开始按钮
    ph = 5
    If isStart = True Then Exit Sub
    isStart = True
    isTurn = 1
    Call Init
   
    Call computerPlay
End Sub

Private Sub Command2_Click(Index As Integer)
    If isStart = True Then Exit Sub
    Select Case Index
        Case 0
            Call moveCube(0)
        Case 1
            Call moveCube(1)
        Case 2
            Call moveCube(2)
        Case 3
            Call moveCube(3)
    End Select
End Sub
Private Sub moveCube(dir)
    changeX = 0
    changeY = 0
    For i = 1 To 7
        For j = 1 To 7
            If head(i, j) = -1 Then
                Select Case Direct
                    Case 1
                        Select Case dir
                            Case 0
                                If j = 7 Then Exit Sub
                                changeY = 1
                            Case 1
                                If i = 3 Then Exit Sub
                                changeX = -1
                            Case 2
                                If i = 5 Then Exit Sub
                                changeX = 1
                            Case 3
                                If j = 4 Then Exit Sub
                                changeY = -1
                        End Select
                    Case 2
                        Select Case dir
                            Case 0
                                If j = 5 Then Exit Sub
                                changeY = 1
                            Case 1
                                If i = 4 Then Exit Sub
                                changeX = -1
                            Case 2
                                If i = 7 Then Exit Sub
                                changeX = 1
                            Case 3
                                If j = 3 Then Exit Sub
                                changeY = -1
                        End Select
                    Case 3
                         Select Case dir
                            Case 0
                                If j = 4 Then Exit Sub
                                changeY = 1
                            Case 1
                                If i = 3 Then Exit Sub
                                changeX = -1
                            Case 2
                                If i = 5 Then Exit Sub
                                changeX = 1
                            Case 3
                                If j = 1 Then Exit Sub
                                changeY = -1
                        End Select
                    Case 4
                         Select Case dir
                            Case 0
                                If j = 5 Then Exit Sub
                                changeY = 1
                            Case 1
                                If i = 1 Then Exit Sub
                                changeX = -1
                            Case 2
                                If i = 4 Then Exit Sub
                                changeX = 1
                            Case 3
                                If j = 3 Then Exit Sub
                                changeY = -1
                        End Select
                End Select
                head(i, j) = 0
                head(i + changeX, j + changeY) = -1
                Call moves
            End If
        Next j
    Next i
End Sub
Private Sub moves()
    For i1 = 1 To 7
        For j1 = 1 To 7
            clr(i1, j1) = lblCube((j1 - 1) * 7 + i1).BackColor
        Next j1
    Next i1
    For i2 = 1 To 7
        For j2 = 1 To 7
            If clr(i2 - changeX, j2 - changeY) = "" Then
                clr(i2 - changeX, j2 - changeY) = "&H8000000F"
            End If
            lblCube((j2 - 1) * 7 + i2).BackColor = clr(i2 - changeX, j2 - changeY)
        Next j2
    Next i2
End Sub

Private Sub Command3_Click()            '飞机的旋转
    If isStart = True Then Exit Sub
    Dim headChange As Boolean
    Direct = Direct + 1
    If Direct = 5 Then
        Direct = 1
    End If
    For i2 = 1 To 7
        For j2 = 1 To 7
            If head(i2, j2) = -1 And headChange = 0 Then
                head(i2, j2) = 0
                head(j2, 8 - i2) = -1
                headChange = -1
            End If
        Next j2
    Next i2
    For i1 = 1 To 7
        For j1 = 1 To 7
            clr(i1, j1) = lblCube((j1 - 1) * 7 + i1).BackColor
        Next j1
    Next i1
    For i = 1 To 7
        For j = 1 To 7
            lblCube((j - 1) * 7 + i).BackColor = clr(8 - j, i)
        Next j
    Next i
End Sub

Private Sub Restart()
    isTurn = 1
    way = 0
    
    For i = 1 To 7
        For j = 1 To 7
            head(i, j) = 0
            head1(i, j) = 0
        Next j
    Next i
    
    score.Caption = jc & "  :  " & wc
    
    isStart = False
    head(4, 5) = -1
    Direct = 1
    
    For i = 1 To 49
            lblCube(i).BackColor = &H8000000F
            lblCube1(i).BackColor = &H8000000F
    Next i
    
    lblCube(32).BackColor = &HFF0000
    For i = 0 To 4
        lblCube(23 + i).BackColor = lblCube(32).BackColor
    Next i
    lblCube(18).BackColor = lblCube(32).BackColor
    lblCube(10).BackColor = lblCube(32).BackColor
    lblCube(11).BackColor = lblCube(32).BackColor
    lblCube(12).BackColor = lblCube(32).BackColor
    
    
End Sub

Private Sub Command5_Click()
    For i1 = 1 To 7
        For j1 = 1 To 7
            lblCube((j1 - 1) * 7 + i1 + 49).BackColor = RGB(Int(255 * (cubeValue(i1, j1) / max)), 0, 0)
        Next
    Next
End Sub



Private Sub Command4_Click()
    Stop
End Sub

Private Sub Form_Load()
    isStart = False
    head(4, 5) = -1
    Direct = 1
End Sub
Private Sub Init()
'//////////////////////////计算机设置//////////////////////////
Dim shueiji As Integer
Dim x0 As Integer, y0 As Integer
Randomize
shueiji = Int(Rnd * 4) + 1
direct1 = shueiji

Select Case direct1
    Case 1
        x0 = Int(Rnd * 3) + 3
        y0 = Int(Rnd * 4) + 4
        'head1(x0, y0) = -1
    Case 2
        x0 = Int(Rnd * 4) + 4
        y0 = Int(Rnd * 3) + 3
    Case 3
        x0 = Int(Rnd * 3) + 3
        y0 = Int(Rnd * 4) + 1
    Case 4
        x0 = Int(Rnd * 4) + 1
        y0 = Int(Rnd * 3) + 3
End Select
head1(x0, y0) = True
'Print direct1, x0, y0

'/////////////////////////////////////////////////////////////
    isTurn = 0
    For i = 1 To 7
        For j = 1 To 7
            isFact(i, j) = -1
        Next j
    Next i
'//////////////////////////////////////////////////////////
    For m1 = 3 To 5
        For n1 = 4 To 7
            Call changePlane(m1, n1, 1, 1)
        Next n1
    Next m1
    For m2 = 4 To 7
        For n2 = 3 To 5
            Call changePlane(m2, n2, 2, 1)
        Next n2
    Next m2
    For m3 = 3 To 5
        For n3 = 1 To 4
            Call changePlane(m3, n3, 3, 1)
        Next n3
    Next m3
    For m4 = 1 To 4
        For n4 = 3 To 5
             Call changePlane(m4, n4, 4, 1)
        Next n4
    Next m4
'/////////////////////////////////////////////////////////
    isTurn = 0

End Sub
Private Sub changePlane(xPos, yPos, der, how)

    If der = 1 Then
        If how = 1 Then
            w(xPos, yPos, 10 * xPos + yPos, 1) = ph
            w(xPos - 2, yPos - 1, xPos * 10 + yPos, 1) = 1
            w(xPos - 1, yPos - 1, xPos * 10 + yPos, 1) = 1
            w(xPos, yPos - 1, xPos * 10 + yPos, 1) = 1
            w(xPos + 1, yPos - 1, xPos * 10 + yPos, 1) = 1
            w(xPos + 2, yPos - 1, xPos * 10 + yPos, 1) = 1
            w(xPos, yPos - 2, xPos * 10 + yPos, 1) = 1
            w(xPos - 1, yPos - 3, xPos * 10 + yPos, 1) = 1
            w(xPos, yPos - 3, xPos * 10 + yPos, 1) = 1
            w(xPos + 1, yPos - 3, xPos * 10 + yPos, 1) = 1
        Else
            w(xPos, yPos, 10 * xPos + yPos, 1) = 0
            w(xPos - 2, yPos - 1, xPos * 10 + yPos, 1) = 0
            w(xPos - 1, yPos - 1, xPos * 10 + yPos, 1) = 0
            w(xPos, yPos - 1, xPos * 10 + yPos, 1) = 0
            w(xPos + 1, yPos - 1, xPos * 10 + yPos, 1) = 0
            w(xPos + 2, yPos - 1, xPos * 10 + yPos, 1) = 0
            w(xPos, yPos - 2, xPos * 10 + yPos, 1) = 0
            w(xPos - 1, yPos - 3, xPos * 10 + yPos, 1) = 0
            w(xPos, yPos - 3, xPos * 10 + yPos, 1) = 0
            w(xPos + 1, yPos - 3, xPos * 10 + yPos, 1) = 0
        End If
    ElseIf der = 2 Then
        If how = 1 Then
            w(xPos, yPos, 10 * xPos + yPos, 2) = ph
            w(xPos - 1, yPos - 2, xPos * 10 + yPos, 2) = 1
            w(xPos - 1, yPos - 1, xPos * 10 + yPos, 2) = 1
            w(xPos - 1, yPos, xPos * 10 + yPos, 2) = 1
            w(xPos - 1, yPos + 1, xPos * 10 + yPos, 2) = 1
            w(xPos - 1, yPos + 2, xPos * 10 + yPos, 2) = 1
            w(xPos - 2, yPos, xPos * 10 + yPos, 2) = 1
            w(xPos - 3, yPos - 1, xPos * 10 + yPos, 2) = 1
            w(xPos - 3, yPos, xPos * 10 + yPos, 2) = 1
            w(xPos - 3, yPos + 1, xPos * 10 + yPos, 2) = 1
        Else
            w(xPos, yPos, 10 * xPos + yPos, 2) = 0
            w(xPos - 1, yPos - 2, xPos * 10 + yPos, 2) = 0
            w(xPos - 1, yPos - 1, xPos * 10 + yPos, 2) = 0
            w(xPos - 1, yPos, xPos * 10 + yPos, 2) = 0
            w(xPos - 1, yPos + 1, xPos * 10 + yPos, 2) = 0
            w(xPos - 1, yPos + 2, xPos * 10 + yPos, 2) = 0
            w(xPos - 2, yPos, xPos * 10 + yPos, 2) = 0
            w(xPos - 3, yPos - 1, xPos * 10 + yPos, 2) = 0
            w(xPos - 3, yPos, xPos * 10 + yPos, 2) = 0
            w(xPos - 3, yPos + 1, xPos * 10 + yPos, 2) = 0
        End If
    ElseIf der = 3 Then
        If how = 1 Then
            w(xPos, yPos, 10 * xPos + yPos, 3) = ph
            w(xPos - 2, yPos + 1, xPos * 10 + yPos, 3) = 1
            w(xPos - 1, yPos + 1, xPos * 10 + yPos, 3) = 1
            w(xPos, yPos + 1, xPos * 10 + yPos, 3) = 1
            w(xPos + 1, yPos + 1, xPos * 10 + yPos, 3) = 1
            w(xPos + 2, yPos + 1, xPos * 10 + yPos, 3) = 1
            w(xPos, yPos + 2, xPos * 10 + yPos, 3) = 1
            w(xPos - 1, yPos + 3, xPos * 10 + yPos, 3) = 1
            w(xPos, yPos + 3, xPos * 10 + yPos, 3) = 1
            w(xPos + 1, yPos + 3, xPos * 10 + yPos, 3) = 1
        ElseIf how = 0 Then
            w(xPos, yPos, 10 * xPos + yPos, 3) = 0
            w(xPos - 2, yPos + 1, xPos * 10 + yPos, 3) = 0
            w(xPos - 1, yPos + 1, xPos * 10 + yPos, 3) = 0
            w(xPos, yPos + 1, xPos * 10 + yPos, 3) = 0
            w(xPos + 1, yPos + 1, xPos * 10 + yPos, 3) = 0
            w(xPos + 2, yPos + 1, xPos * 10 + yPos, 3) = 0
            w(xPos, yPos + 2, xPos * 10 + yPos, 3) = 0
            w(xPos - 1, yPos + 3, xPos * 10 + yPos, 3) = 0
            w(xPos, yPos + 3, xPos * 10 + yPos, 3) = 0
            w(xPos + 1, yPos + 3, xPos * 10 + yPos, 3) = 0
        End If
    ElseIf der = 4 Then
        If how = 1 Then
            w(xPos, yPos, 10 * xPos + yPos, 4) = ph
            w(xPos + 1, yPos - 2, xPos * 10 + yPos, 4) = 1
            w(xPos + 1, yPos - 1, xPos * 10 + yPos, 4) = 1
            w(xPos + 1, yPos, xPos * 10 + yPos, 4) = 1
            w(xPos + 1, yPos + 1, xPos * 10 + yPos, 4) = 1
            w(xPos + 1, yPos + 2, xPos * 10 + yPos, 4) = 1
            w(xPos + 2, yPos, xPos * 10 + yPos, 4) = 1
            w(xPos + 3, yPos - 1, xPos * 10 + yPos, 4) = 1
            w(xPos + 3, yPos, xPos * 10 + yPos, 4) = 1
            w(xPos + 3, yPos + 1, xPos * 10 + yPos, 4) = 1
        Else
            w(xPos, yPos, 10 * xPos + yPos, 4) = 0
            'Print w(xPos, yPos, 10 * xPos + yPos, 4)
            w(xPos + 1, yPos - 2, xPos * 10 + yPos, 4) = 0
            w(xPos + 1, yPos - 1, xPos * 10 + yPos, 4) = 0
            w(xPos + 1, yPos, xPos * 10 + yPos, 4) = 0
            w(xPos + 1, yPos + 1, xPos * 10 + yPos, 4) = 0
            w(xPos + 1, yPos + 2, xPos * 10 + yPos, 4) = 0
            w(xPos + 2, yPos, xPos * 10 + yPos, 4) = 0
            w(xPos + 3, yPos - 1, xPos * 10 + yPos, 4) = 0
            w(xPos + 3, yPos, xPos * 10 + yPos, 4) = 0
            w(xPos + 3, yPos + 1, xPos * 10 + yPos, 4) = 0
        End If
    End If
End Sub
Private Sub computerPlay()              '计算机进攻
    Call LargeCube
    If way < 2 Then
        Call tanCe
    End If
    
    Call See(maxX, maxY)

    Call checkCube(maxX, maxY)
    Call LargeCube
    way = way + 1
   
    isTurn = 0
End Sub
Private Sub tanCe()
    Randomize
    If Rnd * 100 >= 90 Then
        Call tanCe1
        Exit Sub
    End If
    maxX = Int(Rnd * 7) + 1
    If maxX >= 3 And maxX <= 5 Then
        maxY = Int(Rnd * 7) + 1
    Else
        maxY = Int(Rnd * 3) + 3
    End If
    If maxX = 7 Then maxX = 6
    If maxY = 7 Then maxY = 6
    If maxX = 1 Then maxX = 2
    If maxY = 1 Then maxY = 2
    If (Not (lblCube((maxY - 1) * 7 + maxX).BackColor = &H8000000F Or _
    lblCube((maxY - 1) * 7 + maxX).BackColor = &HFF0000)) _
    Or cubeValue(maxX, maxY) <= 1 Then
        Call tanCe
    End If
End Sub
Private Sub tanCe1()
    Randomize
    maxX = Rnd * 2 + 1
    If maxX = 2 Then
        maxX = 7
    End If
    maxY = Rnd * 2 + 1
    If maxY = 2 Then
        maxY = 7
    End If
    If (Not (lblCube((maxY - 1) * 7 + maxX).BackColor = &H8000000F Or _
    lblCube((maxY - 1) * 7 + maxX).BackColor = &HFF0000)) _
    Or cubeValue(maxX, maxY) <= 1 Then
        Call tanCe1
    End If
End Sub

Private Sub LargeCube()
    max = 0
    maxX = 0
    maxY = 0
    
For j = 7 To 1 Step -1
    For i = 1 To 7
            cubeValue(i, j) = 0
            If (lblCube((j - 1) * 7 + i).BackColor = &H8000000F Or lblCube((j - 1) * 7 + i).BackColor = &HFF0000) Then
                For m = 11 To 77
                    For n = 1 To 4
                        cubeValue(i, j) = cubeValue(i, j) + w(i, j, m, n)
                    Next n
                Next m
            End If
        
            
            If cubeValue(i, j) > max Then
                max = cubeValue(i, j)
                maxX = i
                maxY = j
            End If
        Next
        
    Next
    
    
   
     dd = 0
    For i2 = 1 To 7
        For j2 = 1 To 7
        For k = 1 To 4
            If w(i2, j2, i2 * 10 + j2, k) = ph Then
            
                        
                        dd = dd + 1
                    
            End If
        Next
        Next
    Next
    
    shui = Int(Rnd * 49) + 1
    a = 0
    For i = 1 To 7
        For j = 1 To 7
            If cubeValue(i, j) = max Then
                maxX = i: maxY = j
                a = a + 1
                If a = shui Then
                    Exit Sub
                End If
            End If
        Next
    Next
End Sub
Private Sub See(xx, yy)
    pos = (yy - 1) * 7 + xx
    If lblCube(pos).BackColor = &H8000000F Then
        isFact(xx, yy) = none
        lblCube(pos).BackColor = &HFF00&
    ElseIf head(xx, yy) = -1 Then
        jc = jc + 1
        If jc = 10 Then
            aa = jc & "  :  " & wc
            score.Caption = aa
            a = MsgBox("哈哈！你输了！还要来吗？", vbOKCancel)
            If a = vbOK Then
                jc = 0: wc = 0
                Call Restart
            Else
                End
            End If
        Else
            MsgBox "本局计算机赢了"
            Call Restart
        End If
    ElseIf lblCube(pos).BackColor = &HFF0000 Then
        isFact(xx, yy) = pb
        lblCube(pos).BackColor = &HFF&
    End If
End Sub
Private Sub checkCube(i, j)
    

  
            If isFact(i, j) = pb Then
                For xxpos = 1 To 7
                For yypos = 1 To 7
                    For d = 1 To 4
                        If w(xxpos, yypos, xxpos * 10 + yypos, d) = ph Then
                        
                            Select Case d
                                Case 1
                                                                                                      If Not ((xxpos = i And yypos = j) Or _
                                    (xxpos - 2 = i And yypos - 1 = j) Or (xxpos - 1 = i And yypos - 1 = j) Or (xxpos = i And yypos - 1 = j) Or (xxpos + 1 = i And yypos - 1 = j) Or (xxpos + 2 = i And yypos - 1 = j) Or _
                                                                                                              (xxpos = i And yypos - 2 = j) Or _
                                                                         (xxpos - 1 = i And yypos - 3 = j) Or (xxpos = i And yypos - 3 = j) Or (xxpos + 1 = i And yypos - 3 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                    
                                    End If
                                Case 2
                                                                                                      If Not ((xxpos = i And yypos = j) Or _
                                    (xxpos - 1 = i And yypos - 2 = j) Or (xxpos - 1 = i And yypos - 1 = j) Or (xxpos - 1 = i And yypos = j) Or (xxpos - 1 = i And yypos + 1 = j) Or (xxpos - 1 = i And yypos + 2 = j) Or _
                                                                                                              (xxpos - 2 = i And yypos = j) Or _
                                                                         (xxpos - 3 = i And yypos - 1 = j) Or (xxpos - 3 = i And yypos = j) Or (xxpos - 3 = i And yypos + 1 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                                Case 3
                                                                                                      If Not ((xxpos = i And yypos = j) Or _
                                    (xxpos - 2 = i And yypos + 1 = j) Or (xxpos - 1 = i And yypos + 1 = j) Or (xxpos = i And yypos + 1 = j) Or (xxpos + 1 = i And yypos + 1 = j) Or (xxpos + 2 = i And yypos + 1 = j) Or _
                                                                                                              (xxpos = i And yypos + 2 = j) Or _
                                                                         (xxpos - 1 = i And yypos + 3 = j) Or (xxpos = i And yypos + 3 = j) Or (xxpos + 1 = i And yypos + 3 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                                Case 4
                                                                                                       If Not ((xxpos = i And yypos = j) Or _
                                    (xxpos + 1 = i And yypos - 2 = j) Or (xxpos + 1 = i And yypos - 1 = j) Or (xxpos + 1 = i And yypos = j) Or (xxpos + 1 = i And yypos + 1 = j) Or (xxpos + 1 = i And yypos + 2 = j) Or _
                                                                                                              (xxpos + 2 = i And yypos = j) Or _
                                                                         (xxpos + 3 = i And yypos - 1 = j) Or (xxpos + 3 = i And yypos = j) Or (xxpos + 3 = i And yypos + 1 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                            End Select
                        End If
                    Next d
                Next
                Next
                
            ElseIf isFact(i, j) = none Then
              
                For xxpos = 1 To 7
                For yypos = 1 To 7
                    For d = 1 To 4
                        If w(xxpos, yypos, xxpos * 10 + yypos, d) <> 0 Then
                           
                            Select Case d
                                Case 1
                                                                                                      If ((xxpos = i And yypox = j) Or _
                                    (xxpos - 2 = i And yypos - 1 = j) Or (xxpos - 1 = i And yypos - 1 = j) Or (xxpos = i And yypos - 1 = j) Or (xxpos + 1 = i And yypos - 1 = j) Or (xxpos + 2 = i And yypos - 1 = j) Or _
                                                                                                              (xxpos = i And yypos - 2 = j) Or _
                                                                         (xxpos - 1 = i And yypos - 3 = j) Or (xxpos = i And yypos - 3 = j) Or (xxpos + 1 = i And yypos - 3 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                                Case 2
                                                                                                      If ((xxpos = i And yypox = j) Or _
                                    (xxpos - 1 = i And yypos - 2 = j) Or (xxpos - 1 = i And yypos - 1 = j) Or (xxpos - 1 = i And yypos = j) Or (xxpos - 1 = i And yypos + 1 = j) Or (xxpos - 1 = i And yypos + 2 = j) Or _
                                                                                                              (xxpos - 2 = i And yypos = j) Or _
                                                                         (xxpos - 3 = i And yypos - 1 = j) Or (xxpos - 3 = i And yypos = j) Or (xxpos - 3 = i And yypos + 1 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                                Case 3
                                                                                                      If ((xxpos = i And yypox = j) Or _
                                    (xxpos - 2 = i And yypos + 1 = j) Or (xxpos - 1 = i And yypos + 1 = j) Or (xxpos = i And yypos + 1 = j) Or (xxpos + 1 = i And yypos + 1 = j) Or (xxpos + 2 = i And yypos + 1 = j) Or _
                                                                                                              (xxpos = i And yypos + 2 = j) Or _
                                                                         (xxpos - 1 = i And yypos + 3 = j) Or (xxpos = i And yypos + 3 = j) Or (xxpos + 1 = i And yypos + 3 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                                Case 4
                                                                                                       If ((xxpos = i And yypox = j) Or _
                                    (xxpos + 1 = i And yypos - 2 = j) Or (xxpos + 1 = i And yypos - 1 = j) Or (xxpos + 1 = i And yypos = j) Or (xxpos + 1 = i And yypos + 1 = j) Or (xxpos + 1 = i And yypos + 2 = j) Or _
                                                                                                              (xxpos - 2 = i And yypos = j) Or _
                                                                         (xxpos + 3 = i And yypos - 1 = j) Or (xxpos + 3 = i And yypos = j) Or (xxpos + 3 = i And yypos + 1 = j)) Then
                                        Call changePlane(xxpos, yypos, d, 0)
                                    End If
                            End Select
                        End If
                    Next d
                Next
                Next
                   
           
            End If
       
End Sub




Private Sub lblCube1_Click(Index As Integer)
If isStart = False Then Exit Sub
If Not (lblCube1(Index).BackColor = &H8000000F Or lblCube1(Index).BackColor = &HFF0000) Then
    MsgBox "该位置已经被攻击过，请攻击其他位置！"
    Exit Sub
End If
Dim xPos As Integer
Dim yPos As Integer
Dim re As Integer
If isTurn = 1 Then Exit Sub

xPos = Index Mod 7
If xPos = 0 Then
    xPos = 7
    yPos = -1
End If
yPos = yPos + Index \ 7 + 1
'Print xPos, yPos       取得index所在的位置
re = See1(xPos, yPos)
Select Case re
    Case 2
        wc = wc + 1
        If wc = 10 Then
            aa = jc & "  :  " & wc
            score.Caption = aa
            a = MsgBox("恭喜你！你赢了！是否再来？", vbOKCancel)
            If a = vbOK Then
                jc = 0: wc = 0
                Call Restart
                Exit Sub
            Else
                End
            End If
        Else
            MsgBox "本局你赢了"
            Call Restart
            Exit Sub
        End If
    Case 1
        lblCube1(Index).BackColor = &HFF&
    Case 0
        lblCube1(Index).BackColor = &HFF00&
End Select
isTurn = 1

Call computerPlay
End Sub
Private Function See1(xx As Integer, yy As Integer) As Integer
    See1 = 0        'see1=0表示没有=1表示有机身=2表示有机头
    Dim hx As Integer, hy As Integer
    For i = 1 To 7
        For j = 1 To 7
            If head1(i, j) = True Then
                 hx = i: hy = j
            End If
        Next
    Next
    If xx = hx And yy = hy Then
        See1 = 2
        Exit Function
    End If
    Select Case direct1
                                Case 1
                                                                                                    If ( _
                                    (hx - 2 = xx And hy - 1 = yy) Or (hx - 1 = xx And hy - 1 = yy) Or (hx = xx And hy - 1 = yy) Or (hx + 1 = xx And hy - 1 = yy) Or (hx + 2 = xx And hy - 1 = yy) Or _
                                                                                                              (hx = xx And hy - 2 = yy) Or _
                                                                         (hx - 1 = xx And hy - 3 = yy) Or (hx = xx And hy - 3 = yy) Or (hx + 1 = xx And hy - 3 = yy)) Then
                                        See1 = 1
                    
                                    End If
                                Case 2
                                                                                                      If ( _
                                    (hx - 1 = xx And hy - 2 = yy) Or (hx - 1 = xx And hy - 1 = yy) Or (hx - 1 = xx And hy = yy) Or (hx - 1 = xx And hy + 1 = yy) Or (hx - 1 = xx And hy + 2 = yy) Or _
                                                                                                              (hx - 2 = xx And hy = yy) Or _
                                                                         (hx - 3 = xx And hy - 1 = yy) Or (hx - 3 = xx And hy = yy) Or (hx - 3 = xx And hy + 1 = yy)) Then
                                        See1 = 1
                                    End If
                                Case 3
                                                                                                      If ( _
                                    (hx - 2 = xx And hy + 1 = yy) Or (hx - 1 = xx And hy + 1 = yy) Or (hx = xx And hy + 1 = yy) Or (hx + 1 = xx And hy + 1 = yy) Or (hx + 2 = xx And hy + 1 = yy) Or _
                                                                                                              (hx = xx And hy + 2 = yy) Or _
                                                                         (hx - 1 = xx And hy + 3 = yy) Or (hx = xx And hy + 3 = yy) Or (hx + 1 = xx And hy + 3 = yy)) Then
                                        See1 = 1
                                    End If
                                Case 4
                                                                                                       If ( _
                                    (hx + 1 = xx And hy - 2 = yy) Or (hx + 1 = xx And hy - 1 = yy) Or (hx + 1 = xx And hy = yy) Or (hx + 1 = xx And hy + 1 = yy) Or (hx + 1 = xx And hy + 2 = yy) Or _
                                                                                                              (hx + 2 = xx And hy = yy) Or _
                                                                         (hx + 3 = xx And hy - 1 = yy) Or (hx + 3 = xx And hy = yy) Or (hx + 3 = xx And hy + 1 = yy)) Then
                                        See1 = 1
                                    End If

    End Select
End Function




