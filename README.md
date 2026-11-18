# scripts

个人电脑自动化脚本集合。

## app-hotkeys：全局热键切换 APP（AppHotkeys.ahk）

用 AutoHotkey v2 实现「一键呼出 / 最小化」常用软件。

### 热键表

| 热键 | APP | 说明 |
|---|---|---|
| Alt+D | ZCode | `E:\user\Downloads\download6\ZCode\ZCode.exe` |
| Alt+E | Chrome | `C:\Users\lenovo\AppData\Local\Google\Chrome\Application\chrome.exe` |
| Alt+F | 飞书 | `E:\user\Downloads\download6\Feishu\Feishu.exe` |
| Alt+Q | 网易有道翻译 | 托盘隐藏也能呼出（`findHidden=true`） |
| Alt+A | 智谱清言 | `E:\user\Downloads\download6\chatglm\智谱清言.exe` |
| Alt+C | 汽水音乐 | 经 `SodaMusicLauncher.exe` 启动，升级不失效 |

### 统一行为逻辑

- APP 没运行 → 启动
- 在前台 → 最小化
- 在后台 / 托盘 / 最小化 → 呼出置顶（不改变窗口大小，最大化保持最大化）

### 三个特殊机制

1. **游戏保护**：第五人格（`dwrg.exe`）在前台时所有热键失效，按键原样传给游戏（`#HotIf`）
2. **跳过无标题辅助窗口**：Electron 类应用有无标题小窗口干扰窗口匹配，脚本只认「有标题的最顶层窗口」
3. **前台锁后备**：Win11 偶发拦截抢焦点时，短暂置顶强制插队再取消

### 运行方式

- 解释器：`C:\Users\lenovo\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe`（v2.0.31，winget 安装）
- 开机自启：启动文件夹里的 `AppHotkeys.lnk` → `shell:startup` 可见
- 改完脚本重载：双击 `.ahk`（`#SingleInstance Force` 自动替换旧实例），或托盘绿 H 图标右键 → Reload Script

### 修改记录

见 git log。已知坑：有道点 × 是藏托盘不是退出；ZCode 多个无标题窗口；右键 Edit Script 会弹「选择编辑器」框。
