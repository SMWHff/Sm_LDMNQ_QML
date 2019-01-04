[General]
SyntaxVersion=2
MacroID=7743181e-0489-467c-93e9-4608680c58cb
[Comment]

[Script]
'======================================[请勿删除下面声明，切记！]====================================
'【雷电模拟器命令库】
'版本：v1.3
'更新：2018.12.24
'作者：神梦无痕
'ＱＱ：1042207232
'Ｑ群：624655641
'=======================================[需要脚本定制可以找我]=======================================
'
'
'
'==================================================【API声明】==================================================
Declare Function IsWindow Lib "user32" Alias "IsWindow" (ByVal hwnd As Long) As Long
Declare Function GetAncestor Lib "user32.dll" (ByVal hwnd As Long, ByVal GetAncestorFlags As Long) As Long
Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Declare Function WindowFromPoint Lib "user32" Alias "WindowFromPoint" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Declare Function SetWindowPos Lib "user32" Alias "SetWindowPos" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Declare Function ScreenToClient Lib "user32" Alias "ScreenToClient" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long,ByVal wMsg As Long, ByVal wParam As Long,lParam As Any) As Long
Declare Function SendMsgLong Lib "user32.dll" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Declare Function SendMsgText Lib "user32.dll" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Declare Function SendMsgRefs Lib "user32.dll" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByRef lParam As String) As Long
Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, ByRef lpdwProcessId As Long) As Long
Declare Function PathFileExists Lib "shlwapi.dll" Alias "PathFileExistsA" (ByVal pszPath As String) As Long '判断文件是否存在
Declare Function PathIsDirectory Lib "shlwapi.dll" Alias "PathIsDirectoryA" (ByVal pszPath As String) As Long '判断目录是否存在
Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Declare Function GetCommandLine Lib "kernel32" Alias "GetCommandLineW" () As Long
Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Long) As Long
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (pDst As Any, pSrc As Any, ByVal ByteLen As Long)
Declare Function GetModuleFileName Lib "kernel32" Alias "GetModuleFileNameA" (ByVal hModule As Long, ByVal lpFileName As String, ByVal nSize As Long) As Long
Declare Function 取设备句柄 Lib "user32" Alias "GetWindowDC" (ByVal hwnd As Long) As Long
Declare Function 置背景模式 Lib "gdi32" Alias "SetBkMode" (ByVal hdc As Long,ByVal 模式 As Long) As Long
Declare Function 置前景颜色 Lib "gdi32" Alias "SetTextColor" (ByVal hdc As Long,ByVal 模式 As Long) As Long
Declare Function 绘制文本 Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long,ByVal x As Long,ByVal y As Long,ByVal 文本 As String,ByVal 长度 As Long) As Long
Declare Function 释放场景 Lib "user32" Alias "ReleaseDC" (ByVal hwnd As Long, ByVal hdc As Long) As Long
'
'==================================================【变量声明】==================================================
DimEnv DimEnv_VM_Init, DimEnv_VM_Dir, DimEnv_VM_Ver
 
Function _初始化(路径)
    Dim ret, tmp, Hwnd, 内容, Rect, PrintX, dllPath, 设备场景, 当前版本
     
    '-----------------------【当前版本号】-----------------------
    当前版本 = "1.3"
    '-----------------------------------------------------------
    DimEnv_VM_Ver = 当前版本 : Dim_VM_NewTips = "无需更新！"
    If Not IsObject(Msg)   And DimEnv_VM_Init <> "" Then Set Msg = CreateObject("QMPlugin.Msg")
    If Not IsObject(File)  And DimEnv_VM_Init <> "" Then Set File = CreateObject("QMPlugin.File")
    If Not IsObject(Sys)   And DimEnv_VM_Init <> "" Then Set Sys = CreateObject("QMPlugin.Sys")
    If Not IsObject(Window)And DimEnv_VM_Init <> "" Then Set Window = CreateObject("QMPlugin.Window")
    If Not IsObject(SMWH)  And DimEnv_VM_Init <> "" Then Set SMWH = CreateObject("QMPlugin.SMWH")
	If DimEnv_VM_Init = "" Then Import "Msg.dll"
	If DimEnv_VM_Init = "" Then Import "File.dll"
	If DimEnv_VM_Init = "" Then Import "Sys.dll"
	If DimEnv_VM_Init = "" Then Import "Window.dll"
	If DimEnv_VM_Init = "" Then Import "SMWH.dll"
	Import "SMWH.vbs" :    Execute Join(Data, "") '请勿删除这行，否则出错
    ret = False
    tmp = 路径
    If SMWH.IsDebug() Then 
		'写屏
		Hwnd = SMWH.FindSelector("0|按键精灵 > MDIClient|0 > 0|0 > 0|0|6 > #32770|0")
		内容 = "神梦辅助    QQ：1042207232    Q群：624655641" '请勿删除这行，否则出错
		Rect = Split(Window.GetClientRect(Hwnd), "|")
		PrintX = CLng(Rect(2)) - CLng(Rect(0)) - 420
		设备场景 = 取设备句柄(Hwnd)
		Call 置背景模式(设备场景, 1)
		Call 置前景颜色(设备场景, 255)
		Call 绘制文本(设备场景, PrintX, 5, 内容, len(内容))
		Call 释放场景(Hwnd, 设备场景)
		'判断 SMWH.dll 插件版本
		dllPath = Sys.GetDir(0) & "\plugin\SMWH.dll"
		If SMWH.Ver() <> CreateObject("Scripting.FileSystemObject").GetFileVersion(dllPath) Then 
			If SMWH.GetBasePath() = dllPath Then 
				MsgBox "插件路径："& SMWH.GetBasePath() & vbCrLf & vbCrLf  &"出错，您使用的 SMWH.dll 插件版本过低！"& vbCrLf & vbCrLf &"解决方法："& vbCrLf &"导入最新版插件！", 1 + 16 + 4096, "雷电模拟器【QQ：1042207232】"
			Else 
				MsgBox "插件路径："& SMWH.GetBasePath() & vbCrLf & vbCrLf  &"出错，您使用的 SMWH.dll 插件版本过低！"& vbCrLf & vbCrLf &"解决方法："& vbCrLf &"被低版本覆盖了，【我的命令库】展开后右键刷新下！", 1 + 16 + 4096, "雷电模拟器【QQ：1042207232】"
			End If
			ExitScript
			Exit Function 
		End If 
        '统计命令库使用人数
        使用人数 = SMWH.GETEnv("雷电模拟器_使用人数")
        If 使用人数 = "" Then 
        	使用人数 = SMWH.SoftwTally("雷电模拟器", 授权码, 当前版本)
        	If IsNumeric(CStr(使用人数)) = False Then 使用人数 = 0
        	SMWH.SETEnv "雷电模拟器_使用人数", 使用人数
        End If
        TracePrint "【库名】：雷电模拟器  （v"& 当前版本 &"）"
        TracePrint "【作者】：神梦无痕"
        TracePrint "【ＱＱ】：1042207232"
        TracePrint "【Ｑ群】：624655641"
        TracePrint "【网站】：www.神梦.com"
		TracePrint "【人数】：" & 使用人数 & " 人"
		TracePrint "【更新】：" & Dim_VM_NewTips
    End If
    DimEnv_VM_Init = VM_Init(tmp)
    _初始化 = DimEnv_VM_Init
End Function
Function 雷电_启动模拟器(编号或标题)
    Dim 当前目录, 返回值, ret, cs
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" launch --index " & 编号或标题)
        Else 
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" launch --name " & 编号或标题)
        End If
        'TracePrint 返回值 & "=" & Len(返回值)
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_启动模拟器 = ret
End Function
Function 雷电_修改模拟器配置(编号或标题, 分辨率宽, 分辨率高, DPI, CPU, 内存)
    Dim ret, 当前目录, 返回值, 命令, 手机号码, 手机厂商, 手机型号
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        Randomize
        手机号码 = "158" & Int(((99999999 - 12345678) * Rnd) + 12345678)
        手机厂商 = Chr(Int(((122 - 97) * Rnd) + 97)) & Int(((9999 - 1289) * Rnd) + 1289)
        手机型号 = Chr(Int(((122 - 97) * Rnd) + 97)) & Int(((9999 - 1289) * Rnd) + 1289)
        命令 = ""
        If Not (分辨率宽 = "" Or 分辨率宽 = "0" Or 分辨率高 = "" Or 分辨率高 = "0" Or DPI = "" Or DPI = "0") Then 
            命令 = 命令 & " --resolution "& 分辨率宽 &","& 分辨率高 &","& DPI & " "
        End If
        If InStr("|1|2|3|4|", "|"& CPU &"|") > 0 Then 
            命令 = 命令 & " --cpu "& CPU & " "
        End If
        If InStr("|256|512|768|1024|1536|2048|4096|8192|", "|"& 内存 &"|") > 0 Then 
            命令 = 命令 & " --memory "& 内存 & " "
        End If
        命令 = 命令 & " --imei auto --manufacturer " & 手机厂商 & " --model " & 手机型号 & " --pnumber " & 手机号码 & " --simserial auto --androidid auto --mac auto"
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --index " & 编号或标题  & 命令)
        Else 
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --name " & 编号或标题 & 命令)
        End If 
        'TracePrint 返回值
        If CStr(返回值) = "0" And Len(返回值) = 0 Then 
            ret = True 
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_修改模拟器配置 = ret
End Function
Function 雷电_修改模拟器分辨率(编号或标题, 宽, 高, DPI)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then 
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --index " & 编号或标题 & " --resolution " & 宽 & "," & 高 & "," & DPI)
        Else 
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --name " & 编号或标题 & " --resolution " & 宽 & "," & 高 & "," & DPI)
        End If
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            ret = True 
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_修改模拟器分辨率 = ret
End Function
Function 雷电_修改模拟器IMEI(编号或标题, IMEI)
    Dim 当前目录, 返回值, ret
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then 
        If Len(IMEI) = 0 Then IMEI = "auto"
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --index " & 编号或标题 & " --imei " & IMEI)
        Else 
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" modify --name " & 编号或标题 & " --imei " & IMEI)
        End If
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            ret = True 
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_修改模拟器IMEI = ret
End Function
//Function 雷电_修复模拟器配置()
//    Dim 当前目录, 数据目录, 配置模拟器列表, 存在模拟器列表, 唯一标识, 手机号码, 手机厂商, 手机型号, Stm, 写入内容
//    当前目录 = GetEnv("雷电模拟器路径")
//    If Dir(当前目录 & "\dnconsole.exe") Then
//        数据目录 = CreateObject("Shell.Application").Namespace(&H1A).Self.Path & "\ChangZhi\"
//        配置模拟器列表 = Split(SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list "), "|")
//        存在模拟器列表 = Split(SMWH.GetDOS("dir /ad/w/b " & 当前目录 & "\vms"), "|")
//        If UBound(配置模拟器列表) < UBound(存在模拟器列表) Then 
//            写入内容 = "<?xml version='1.0' encoding='UTF-8' ?>" & vbCrLf 
//            写入内容 = 写入内容 & "<players name='雷电模拟器'>" & vbCrLf 
//            For i = 0 To UBound(存在模拟器列表) - 1
//                If File.ExistFile(数据目录 & 存在模拟器列表(i)) <> 2 And 存在模拟器列表(i) <> "" Then 
//                    Randomize
//                    唯一标识 = Int(((9999999 - 1234567) * Rnd) + 1234567) & Int(((99999999 - 12345678) * Rnd) + 12345678)
//                    手机号码 = "158" & Int(((99999999 - 12345678) * Rnd) + 12345678)
//                    手机厂商 = Chr(Int(((122 - 97) * Rnd) + 97)) & Int(((9999 - 1289) * Rnd) + 1289)
//                    手机型号 = Chr(Int(((122 - 97) * Rnd) + 97)) & Int(((9999 - 1289) * Rnd) + 1289)
//                    JOSN = "{'basicSettings.bossKey':{'modifiers':3,'key':77},'basicSettings.fullScreenKey':{'modifiers':0,'key':122},'basicSettings.keyMappingKey':{'modifiers':0,'key':123},'basicSettings.keyZoomInKey':{'modifiers':0,'key':113},'basicSettings.keyZoomOutKey':{'modifiers':0,'key':114},'advancedSettings.resolutionDpi':280,'advancedSettings.resolutionWidth':1280,'advancedSettings.resolutionHeight':720,'advancedSettings.cpuCount':1,'advancedSettings.memorySize':1024,'propertySettings.phoneIMEI':'"& 唯一标识 &"','propertySettings.phoneManufacturer':'"& 手机厂商 &"','propertySettings.phoneModel':'"& 手机型号 &"','propertySettings.phoneNumber':'"& 手机号码 &"','advancedSettings.autoRotate':true,'advancedSettings.lockWindow':false,'advancedSettings.sharedApkPath':'','advancedSettings.sharedPicPath':'','advancedSettings.sharedMiscPath':''}"
//                End If
//                GUID = Left(CreateObject("Scriptlet.TypeLib").Guid, 38)
//                mutex = Left(CreateObject("Scriptlet.TypeLib").Guid, 38)
//                Call File.CreateFolder(数据目录 & 存在模拟器列表(i))
//                Call File.WriteFileEx(数据目录 & 存在模拟器列表(i) & "/configs.config", JOSN)
//                If i > 0 Then 写入内容 = 写入内容 & "<player id='" & i & "' name='雷电模拟器-" & i & "' guid='" & GUID & "' mutex='" & mutex & "'/>" & vbCrLf 
//            Next
//            写入内容 = 写入内容 & "</players>"
//            Set Stm = CreateObject("ADODB.Stream")
//            Stm.Type = 2
//            Stm.Open
//            Stm.Charset = "UTF-8"
//            Stm.WriteText 写入内容
//            Stm.SaveToFile 数据目录 & "playerlist.xml", 2
//            Stm.Close
//            Set Stm = nothing
//        End If
//        雷电_修复模拟器配置 = True 
//    Else
//        雷电_修复模拟器配置 = False
//        TracePrint "出错，未进行初始化操作！"
//    End If
//End Function
Function 雷电_克隆模拟器(编号, 标题)
    Dim ret, 当前目录, 返回值, list, cs
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号) And CStr(编号) >= "0" Then 
            If 标题 <> "" Then 标题 = " --name " & 标题
            list = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list")
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" copy " & 标题 & " --from " & 编号)
            If 返回值 = "0" Or Len(返回值) = 0 Then 
                ret = True
            End If 
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_克隆模拟器 = ret
End Function
Function 雷电_新建模拟器(标题)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If 标题 <> "" Then 标题 = " --name " & 标题
        返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" add " & 标题)
        'TracePrint 返回值
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            ret = True 
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_新建模拟器 = ret
End Function
Function 雷电_删除模拟器(编号或标题)
    Dim ret, 当前目录, list, cs
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        For 3
            list = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list")
            If IsNumeric(编号或标题) Then
                返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" remove --index " & 编号或标题)
            Else
                返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" remove --name " & 编号或标题)
            End If
            If 返回值 = "0" Or Len(返回值) = 0 Then 
                ret = True
                cs = Timer()
                Do
                    Delay 3500
                Loop Until SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list") <> list Or Timer() - cs > 30
                Exit For 
            End If
        Next 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_删除模拟器 = ret
End Function
Function 雷电_获取模拟器()
    Dim ret, 当前目录
    ret = "" 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        ret = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list ")
    Else 
        TracePrint "出错，未进行初始化操作！"
    End If
    雷电_获取模拟器 = ret
End Function
Function 雷电_获取正在运行的模拟器()
    Dim ret, 当前目录
    ret = ""
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        ret = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" runninglist ")
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取正在运行的模拟器 = ret
End Function
Function 雷电_获取启动模拟器编号()
    Dim ret, 当前目录
    ret = ""
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        ret = SMWH.GetDOS("""" & 当前目录 & "\adb.exe"" devices")
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取启动模拟器编号 = ret
End Function
Function 雷电_关闭模拟器(编号或标题)
    Dim ret, 当前目录, 返回值, list, cs
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        list = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe runninglist")
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" quit --index " & 编号或标题)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" quit --name " & 编号或标题)
        End If
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            cs = Timer()
            Do
                If SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" runninglist") <> list Or 雷电_获取模拟器信息(编号或标题, 4) = 0 Then Exit Do
                Delay 1500
            Loop Until Timer() - cs > 15
            Call 雷电_结束进程(编号或标题)
            ret = True 
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_关闭模拟器 = ret
End Function
Function 雷电_关闭所有模拟器()
    Dim ret, 当前目录, 返回值, cs
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" quitall")
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            cs = Timer()
            Do 
                If SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" runninglist") = "" Then Exit Do 
                Delay 100
            Loop Until Timer() - cs > 30
            Call 雷电_结束进程(- 1 )
            ret = True 
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_关闭所有模拟器 = ret
End Function
Function 雷电_修改定位信息(编号或标题, 经度, 纬度)
    '需要1.6以上的模拟器版本
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then 
        返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" quitall")
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" locate --index " & 编号或标题 & " --LLI " & 经度 & " " & 纬度)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" locate --name " & 编号或标题 & " --LLI " & 经度 & " " & 纬度)
        End If
        If 返回值 = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_修改定位信息 = ret
End Function
'-----------------------
'//优化CPU （需要1.8.0.5以上的模拟器版本）
'优化值范围：0~100
Function 雷电_优化CPU(编号或标题, 优化值)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" downcpu --index " & 编号或标题 & " --rate " & 优化值)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" downcpu --name " & 编号或标题 & " --rate " & 优化值)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_优化CPU = ret
End Function
'-----------------------
'//获取模拟器加强，采用命令 list2 （需要2.0.31以上的模拟器版本）
Function 雷电_获取模拟器加强()
    Dim ret, 当前目录
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then 
        ret = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list2")
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取模拟器加强 = ret
End Function
'-----------------------
'//获取模拟器信息，采用命令 list2 （需要2.0.31以上的模拟器版本）
'信息类型：0=索引；1=标题；2=顶层句柄；3=绑定句柄；4=是否进入；5=进程PID；6=Vbox进程PID
Function 雷电_获取模拟器信息(编号或标题, 信息类型)
    Dim ret, List1, List2, index, cs, 当前目录
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(信息类型) Then
            index = CLng(信息类型)
            cs = 0
            Do 
                List1 = Split(vbCrLf & SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" list2"), vbCr)
                List1 = Filter(List1, "Microsoft Windows", False)
                List1 = Filter(List1, "Microsoft Corporation", False)
                List1 = Filter(List1, ":\", False)
                If IsNumeric(编号或标题) Then 
                    List1 = Filter(List1, vbLf & 编号或标题 & ",")
                Else 
                    List1 = Filter(List1, "," & 编号或标题 & ",")
                End If
                If UBound(List1) > - 1  Then
                    List2 = Split(Replace(List1(0), vbLf, ""), ",")
                    If UBound(List2) = 6 Then 
                        ret = List2(index)
                    End If 
                End If
                If Len(ret) > 0 Then Exit Do 
                cs=cs+1
            Loop Until cs > 3
            If index <> 1 Then ret = CLng(ret)
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取模拟器信息=ret
End Function
'-----------------------
'//重启模拟器，启动后并打开【应用包名】, null 表示不打开任何应用
Function 雷电_重启模拟器(编号或标题, 应用包名)
    Dim 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNull(应用包名) Then 应用包名 = "null"
        If 应用包名 = "" And LCase(应用包名) <> "null" Then 
            If IsNumeric(编号或标题) Then
                返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" reboot --index " & 编号或标题)
            Else
                返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" reboot --name " & 编号或标题)
            End If
            If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
                ret = True
            End If 
        Else 
            ret = 雷电_执行动作命令(编号或标题, "call.reboot", 应用包名)
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_重启模拟器 = ret
End Function
'-----------------------
'//重命名模拟器
Function 雷电_重命名模拟器(编号或标题, 新标题)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" rename --index " & 编号或标题 & " --title " & 新标题)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" rename --name " & 编号或标题 & " --title " & 新标题)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_重命名模拟器=ret
End Function
'-----------------------
'//动态执行动作命令
Function 雷电_执行动作命令(编号或标题, 命令动作, 命令值)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" action --index " & 编号或标题 & " --key " & 命令动作 & " --value " & 命令值)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" action --name " & 编号或标题 & " --key " & 命令动作 & " --value " & 命令值)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_执行动作命令=ret
End Function
'-----------------------
'//执行Getprop命令
Function 雷电_Getprop命令(编号或标题, 键名)
    Dim ret,当前目录
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            ret = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" getprop --index " & 编号或标题 & " --key """ & 键名 & """")
        Else
            ret = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" getprop --name " & 编号或标题 & " --key """ & 键名 & """")
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_Getprop命令=ret
End Function
'-----------------------
'//执行Setprop命令
Function 雷电_Setprop命令(编号或标题, 键名, 键值)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" setprop --index " & 编号或标题 & " --key """ & 键名 & """ --value """ & 键值 & """")
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" setprop --name " & 编号或标题 & " --key """ & 键名 & """ --value """ & 键值 & """")
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_Setprop命令 = ret
End Function
'-----------------------
'//执行ADB命令并返回结果
Function 雷电_执行ADB命令(编号, ADB命令)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号) Then 
            ret = SMWH.GetDOS("""" & 当前目录 & "\ld.exe"" -s " & 编号 & " " & ADB命令)
        Else 
            Tips "出错，不支持用标题！" : TracePrint Dim_Tips
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_执行ADB命令=ret
End Function
'-----------------------
'//备份模拟器
Function 雷电_模拟器备份(编号或标题, 保存路径)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        For 2
        	If IsNumeric(编号或标题) Then
            	返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" backup --index " & 编号或标题 & " --file  " & 保存路径)
        	Else
            	返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" backup --name " & 编号或标题 & " --file " & 保存路径)
        	End If
        	If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
                Delay 20000
            	If Dir(保存路径) Then
            		If CreateObject("Scripting.FileSystemObject").GetFile(保存路径).size > 10000000 Then Exit For
            	End If
            	ret = True 
        	End If
        Next
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_模拟器备份=ret
End Function
'-----------------------
'//还原模拟器 
Function 雷电_模拟器还原(编号或标题, 备份文件)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" restore --index " & 编号或标题 & " --file  " & 备份文件)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" restore --name " & 编号或标题 & " --file " & 备份文件)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
            Delay 10000
        End If
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_模拟器还原 = ret
End Function
'-----------------------
'//摇一摇
Function 雷电_摇一摇(编号或标题)
    雷电_摇一摇 = 雷电_执行动作命令(编号或标题, "call.shake", "null")
End Function
'-----------------------
'//文字输入命令
Function 雷电_输入文字(编号或标题, 字符串)
    雷电_输入文字 = 雷电_执行动作命令(编号或标题, "call.input", 字符串)
End Function
'-----------------------
'//模拟安卓按键
Function 雷电_模拟按键(编号或标题, 按键名)
    雷电_模拟按键 = 雷电_执行动作命令(编号或标题, "call.keyboard", 按键名)
End Function
'-----------------------
'//应用安装
Function 雷电_应用安装(编号或标题, 安装包路径)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" installapp --index " & 编号或标题 & " --filename " & 安装包路径)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" installapp --name " & 编号或标题 & " --filename " & 安装包路径)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_应用安装 = ret
End Function
'-----------------------
'//应用包名安装
Function 雷电_应用包名安装(编号或标题, 包名)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" installapp --index " & 编号或标题 & " --packagename " & 包名)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" installapp --name " & 编号或标题 & " --packagename " & 包名)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_应用包名安装 = ret
End Function
'-----------------------
'//应用卸载
Function 雷电_应用卸载(编号或标题, 包名)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" uninstallapp --index " & 编号或标题 & " --packagename " & 包名)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" uninstallapp --name " & 编号或标题 & " --packagename " & 包名)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_应用卸载=ret
End Function
'-----------------------
'//应用启动
Function 雷电_应用启动(编号或标题, 包名)
    Dim ret,当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" runapp --index " & 编号或标题 & " --packagename " & 包名)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" runapp --name " & 编号或标题 & " --packagename " & 包名)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_应用启动=ret
End Function
'-----------------------
'//应用关闭
Function 雷电_应用关闭(编号或标题, 包名)
    Dim ret, 当前目录, 返回值
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" killapp --index " & 编号或标题 & " --packagename " & 包名)
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" killapp --name " & 编号或标题 & " --packagename " & 包名)
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        Else 
        	TracePrint 返回值
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_应用关闭 = ret
End Function
'-----------------------
'//模拟器一键排列(在多开器配置排序规则, 3.18以上版本支持)
Function 雷电_一键排列()
    Dim ret, 当前目录, 返回值
    Dim GetScRX, GetScRY, HwndEx, i, Hwnd, RECT, pw, Sw, Sh, ph, px, py
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then
        If IsNumeric(编号或标题) Then
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" sortWnd")
        Else
            返回值 = SMWH.GetDOS("""" & 当前目录 & "\dnconsole.exe"" sortWnd")
        End If
        If CStr(返回值) = "0" Or Len(返回值) = 0 Then 
            ret = True
        Else
			pw = 0
			ph = 0
			GetScRX = Sys.GetScRX()
			GetScRY = Sys.GetScRY()
			HwndEx = Split(Window.SearchEx("LDPlayerMainFrame", 0, 1), "|")
			For i = 0 To UBound(HwndEx)
				Hwnd = HwndEx(i)
				If Hwnd > "0" Then 
					Hwnd = CLng(Hwnd)
					RECT = Split(Window.GetWindowRect(Hwnd), "|")
					If pw = 0 Or ph = 0 Then 
						pw = Fix(GetScRX / 4)
						Sw = CLng(RECT(2)) - CLng(RECT(0))
						Sh = CLng(RECT(3)) - CLng(RECT(1))
						ph = Fix(pw / sw) * Sh
						TracePrint pw & "," & ph
					End If 
					px = (i Mod 4) * pw + (i Mod 4) * 1
					py = Fix(i / 4) * ph + Fix(i / 4) * 1
					'TracePrint px & "," & py
					Call Window.Move(Hwnd, px, py)
					Call Window.Size(Hwnd, pw, ph)
				End If
			Next
        	'TracePrint "出错，必须模拟器3.18以上版本才支持该命令！"
        End If 
    Else 
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_一键排列 = ret
End Function
'-----------------------
'//通过模拟器编号获取IMEI，支持未运行的模拟器
Function 雷电_获取IMEI(编号)
    Dim ret, 当前目录, 返回值, 文件路径, JSON源文件
    Dim sc, L1, L2
    ret = "" 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    If Dir(当前目录 & "\dnconsole.exe") Then 
        分割目录 = Split(当前目录, "\")
        If IsNumeric(编号) And 编号 <> "" Then 
            文件路径 = CreateObject("Shell.Application").Namespace(&H1A).Self.Path & "\ChangZhi"& Replace(分割目录(UBound(分割目录)), "dnplayer", "") &"\config\leidian"& 编号 &".config"
            If Not Dir(文件路径) Then 文件路径 = DimEnv_VM_Dir &"\vms\config\leidian"& 编号 &".config"
            Set fso = CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(文件路径) Then 
                Set myfile = fso.openTextFile(文件路径, 1)
                JSON源文件 = myfile.ReadAll
                myfile.close 
                Set myfile = Nothing
                '解析JSON
                L1 = InStr(JSON源文件, "{")
                L2 = InStrRev(JSON源文件, "}")
                If L1 > 0 And L2 > 0 Then 
                    JSON源文件 = Mid(JSON源文件, L1, L2 - L1 + 1)
                    Set sc = CreateObject("MSScriptControl.ScriptControl")
                    sc.Language = "JScript"
                    sc.AddCode "var o = " & JSON源文件 & ";"
                    ret = sc.Eval("o['propertySettings.phoneIMEI']")
                    Set sc = Nothing 
                End If
            End If
            Set fso = Nothing
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取IMEI = ret
End Function
'-----------------------
'//通过模拟器编号获取分辨率宽度（只能获取自定义的），支持未运行的模拟器
Function 雷电_获取分辨率宽度(编号)
    Dim 当前目录, 返回值, 文件路径, JSON源文件
    Dim sc, L1, L2
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    返回值 = 1280
    If Dir(当前目录 & "\dnconsole.exe") Then 
        分割目录 = Split(当前目录, "\")
        If IsNumeric(编号) And 编号 <> "" Then 
            文件路径 = CreateObject("Shell.Application").Namespace(&H1A).Self.Path & "\ChangZhi"& Replace(分割目录(UBound(分割目录)), "dnplayer", "") &"\config\leidian"& 编号 &".config"
            If Not Dir(文件路径) Then 文件路径 = DimEnv_VM_Dir & "\vms\config\leidian" & 编号 & ".config"
            Set fso = CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(文件路径) Then 
                Set myfile = fso.openTextFile(文件路径, 1)
                JSON源文件 = myfile.ReadAll
                myfile.close 
                Set myfile = Nothing
                '解析JSON
                L1 = InStr(JSON源文件, "{")
                L2 = InStrRev(JSON源文件, "}")
                If L1 > 0 And L2 > 0 Then 
                    JSON源文件 = Mid(JSON源文件, L1, L2 - L1 + 1)
                    Set sc = CreateObject("MSScriptControl.ScriptControl")
                    sc.Language = "JScript"
                    sc.AddCode "var o = " & JSON源文件 & ";"
                    返回值 = sc.Eval("o['advancedSettings.resolution'].width")
                    Set sc = Nothing 
                End If
            End If
            Set fso = Nothing
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取分辨率宽度 = 返回值
End Function
'-----------------------
'//通过模拟器编号获取分辨率高度（只能获取自定义的），支持未运行的模拟器
Function 雷电_获取分辨率高度(编号)
    Dim 当前目录, 返回值, 文件路径, JSON源文件
    Dim sc, L1, L2
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    返回值 = 720
    If Dir(当前目录 & "\dnconsole.exe") Then 
        分割目录 = Split(当前目录, "\")
        If IsNumeric(编号) And 编号 <> "" Then 
            文件路径 = CreateObject("Shell.Application").Namespace(&H1A).Self.Path & "\ChangZhi"& Replace(分割目录(UBound(分割目录)), "dnplayer", "") &"\config\leidian"& 编号 &".config"
            If Not Dir(文件路径) Then 文件路径 = DimEnv_VM_Dir &"\vms\config\leidian"& 编号 &".config"
            Set fso = CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(文件路径) Then 
                Set myfile = fso.openTextFile(文件路径, 1)
                JSON源文件 = myfile.ReadAll
                myfile.close 
                Set myfile = Nothing
                '解析JSON
                L1 = InStr(JSON源文件, "{")
                L2 = InStrRev(JSON源文件, "}")
                If L1 > 0 And L2 > 0 Then 
                    JSON源文件 = Mid(JSON源文件, L1, L2 - L1 + 1)
                    Set sc = CreateObject("MSScriptControl.ScriptControl")
                    sc.Language = "JScript"
                    sc.AddCode "var o = " & JSON源文件 & ";"
                    返回值 = sc.Eval("o['advancedSettings.resolution'].height")
                    Set sc = Nothing 
                End If
            End If
            Set fso = Nothing
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取分辨率高度 = 返回值
End Function
'-----------------------
'//通过模拟器编号获取分辨率DPI（只能获取自定义的），支持未运行的模拟器
Function 雷电_获取分辨率DPI(编号)
    Dim 当前目录, 返回值, 文件路径, JSON源文件
    Dim sc, L1, L2
    ret = False 
    If Not IsObject(SMWH)  Then Call _初始化(DimEnv_VM_Dir)
    当前目录 = DimEnv_VM_Dir
    返回值 = 240
    If Dir(当前目录 & "\dnconsole.exe") Then 
        分割目录 = Split(当前目录, "\")
        If IsNumeric(编号) And 编号 <> "" Then 
            文件路径 = CreateObject("Shell.Application").Namespace(&H1A).Self.Path & "\ChangZhi"& Replace(分割目录(UBound(分割目录)), "dnplayer", "") &"\config\leidian"& 编号 &".config"
            If Not Dir(文件路径) Then 文件路径 = DimEnv_VM_Dir &"\vms\config\leidian"& 编号 &".config"
            Set fso = CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(文件路径) Then 
                Set myfile = fso.openTextFile(文件路径, 1)
                JSON源文件 = myfile.ReadAll
                myfile.close 
                Set myfile = Nothing
                '解析JSON
                L1 = InStr(JSON源文件, "{")
                L2 = InStrRev(JSON源文件, "}")
                If L1 > 0 And L2 > 0 Then 
                    JSON源文件 = Mid(JSON源文件, L1, L2 - L1 + 1)
                    Set sc = CreateObject("MSScriptControl.ScriptControl")
                    sc.Language = "JScript"
                    sc.AddCode "var o = " & JSON源文件 & ";"
                    返回值 = sc.Eval("o['advancedSettings.resolutionDpi']")
                    Set sc = Nothing 
                End If
            End If
            Set fso = Nothing
        End If 
    Else
        Tips "出错，未进行初始化操作！" : TracePrint Dim_Tips
    End If
    雷电_获取分辨率DPI = 返回值
End Function
'-----------------------
'//通过模拟器编号结束进程
Declare Function TerminateProcess Lib "kernel32" Alias "TerminateProcess" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long 
Function 雷电_结束进程(编号)
    Dim Win, Ps
    If IsNumeric(编号) Then 
        编号 = CLng(编号)
        Set Win = GetObject("winmgmts:\\.\root\cimv2")
        Set Ps = Win.ExecQuery("SELECT * FROM Win32_process Where Name = 'dnplayer.exe' Or Name = 'LdBoxHeadless.exe'")
        For Each PsEx in Ps
            If Not IsNull(PsEx.commandline) Then 
            	If InStr(PsEx.commandline, "index=" & 编号 & "|") > 0 Or InStr(PsEx.commandline, "--comment leidian" & 编号 & " --") > 0 Or 编号 = -1 Then 
                	Call TerminateProcess(OpenProcess(&H1F0FFF, 0, CLng(PsEx.processid)), 0)
            	End If
            End If 
        Next
        Set Ps = Nothing
        Set Win = Nothing
    End If
End Function
'-----------------------
'//获取当前应用包名与组件名
Function ADB_获取当前应用包名与组件名(编号)
    Dim 返回值
    返回值 = 雷电_执行ADB命令(编号, "dumpsys activity top")
    返回值 = SMWH.MidS(返回值, "ACTIVITY ", " ")
    If 返回值 <> "" Then 
        ADB_获取当前应用包名与组件名 = 返回值
    End If
End Function
'-----------------------
'//判断设备中是否有安装指定app
Function ADB_判断设备中是否有安装指定App(编号, 包名)
    Dim 返回值
    返回值 = 雷电_执行ADB命令(编号, "pm list packages -f " & 包名)
    ADB_判断设备中是否有安装指定App = (InStr(1, 返回值, 包名, 1) > 0)
End Function
'-----------------------
'//应用启动
Function ADB_应用启动(编号, 包名与组件名)
    ADB_应用启动 = 雷电_执行ADB命令(编号, " am start -n " & 包名与组件名)
End Function
'-----------------------
'//应用关闭
Function ADB_应用关闭(编号, 包名)
    ADB_应用关闭 = 雷电_执行ADB命令(编号, " am force-stop " & 包名)
End Function
'//应用数据删除
Function ADB_应用数据删除(编号, 包名)
    ADB_应用数据删除 = 雷电_执行ADB命令(编号, " pm clear " & 包名)
End Function
'//模拟滑动
Function ADB_模拟滑动(编号, X1坐标, Y1坐标, X2坐标, Y2坐标, 延迟)
    ADB_模拟滑动 = 雷电_执行ADB命令(编号, " input swipe " &  X1坐标 & " " & Y1坐标 & " " & X2坐标 & " " & Y2坐标 & " " & 延迟)	
End Function
'//模拟输入
Function ADB_模拟输入(编号, 文本内容)
    If IsArray(文本内容) Then 
    	ADB_模拟输入 = 雷电_执行ADB命令(编号, " am broadcast -a ADB_INPUT_CHARS --eia chars '"& Join(文本内容, ",") &"'")
    Else 
    	ADB_模拟输入 = 雷电_执行ADB命令(编号, " am broadcast -a ADB_INPUT_TEXT --es msg '"& 文本内容 &"'")
    End If
End Function
/*
	录制命令 
	'timing': 延迟（毫秒）
	'operationId': 命令ID
		PutMultiTouch 触摸点击
            "points": [
                {
                    "id": 触摸ID,
                    "x": 屏幕X坐标,
                    "y": 屏幕Y坐标,
                    "state": 0
                }
            ]
		
		ImeClipboard 设置剪切板
			'text': 文本内容
		StartApp 启动APP
			'app': 包名
		StopApp 关闭APP
			'app': 包名
		RockPhone 摇一摇
		SetLocation 修改GPS定位
			'longitude':经度
			'latitude': 纬度
		AndroidVolume 设置音量
			'up': 是否增加
		ImeCommit 输入文字
			'text': 文本内容
		
	
	录制设置
	'accelerateTimes': 加速执行倍数<1|2|3|4|5>
	'playOnBoot': 是否开机自启
	'rebootTiming': 模拟器重启倒计时（分钟）
*/
/*〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓【更新历史】〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓
雷电模拟器v1.3 2018.12.24
\
|-- 修复 ADB_判断设备中是否有安装指定App() 命令，返回值不准确问题
|-- 修复 SMWH.vbs 总是被杀毒软件误报删除问题

*/'〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓