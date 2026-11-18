#Requires AutoHotkey v2.0
#SingleInstance Force

; ===== Alt+热键 切换 APP：呼出 / 最小化 =====
; 键位符号：! = Alt   ^ = Ctrl   + = Shift   # = Win

; 第五人格在前台时，下方热键全部失效，按键原样传给游戏
#HotIf !WinActive("ahk_exe dwrg.exe")

!d::ToggleApp("ZCode.exe",      '"E:\user\Downloads\download6\ZCode\ZCode.exe"')
!e::ToggleApp("chrome.exe",     '"C:\Users\lenovo\AppData\Local\Google\Chrome\Application\chrome.exe"')
!f::ToggleApp("Feishu.exe",     '"E:\user\Downloads\download6\Feishu\Feishu.exe"')
!q::ToggleApp("YoudaoDict.exe", '"E:\LenovoSoftstore\Install\wangyiweidaofanyi\YoudaoDict.exe"', true)
!a::ToggleApp("智谱清言.exe",    '"E:\user\Downloads\download6\chatglm\智谱清言.exe"')
!c::ToggleApp("SodaMusic.exe",   '"E:\user\Downloads\download5\Soda Music\SodaMusicLauncher.exe"')

#HotIf

ToggleApp(exeName, runPath, findHidden := false) {
    DetectHiddenWindows findHidden   ; 仅本次生效：托盘隐藏的窗口（如有道）需要 true 才能找到
    exe := "ahk_exe " exeName
    ; 在所有匹配窗口里挑「有标题的最顶层窗口」——跳过 Electron 类应用的无标题辅助窗口
    best := 0, fallback := 0
    for h in WinGetList(exe) {
        if (WinGetTitle("ahk_id " h) = "")
            continue
        if (WinGetStyle("ahk_id " h) & 0x10000000) {  ; WS_VISIBLE：可见窗口优先
            best := h
            break
        }
        if (!fallback)
            fallback := h
    }
    main := best ? best : fallback
    if !main {
        Run runPath       ; 没有可用窗口 → 视为未运行 → 启动
        return
    }
    hwnd := "ahk_id " main
    if WinActive(hwnd) {
        WinMinimize(hwnd)    ; 在前台 → 最小化（尺寸不变）
        return
    }
    WinShow(hwnd)                  ; 若被隐藏到托盘则先显示（对可见窗口无副作用）
    if (WinGetMinMax(hwnd) = -1)   ; 仅当处于最小化时才恢复
        WinRestore(hwnd)
    WinActivate(hwnd)              ; 抢焦点，不碰窗口大小
    if !WinActive(hwnd) {          ; Win11 偶发前台锁：短暂置顶强制插队后再激活
        Sleep 50
        WinSetAlwaysOnTop(true, hwnd)
        WinSetAlwaysOnTop(false, hwnd)
        WinActivate(hwnd)
    }
}
