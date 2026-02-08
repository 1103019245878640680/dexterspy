# 🔍 Ultimate Remote Spy v3.0.0

<div align="center">

![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Roblox](https://img.shields.io/badge/Roblox-Lua-red.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)

**The most advanced and feature-rich Remote Spy for Roblox**

*Monitor, analyze, and debug RemoteEvents/RemoteFunctions with unprecedented detail*

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Configuration](#%EF%B8%8F-configuration)
- [UI Guide](#-ui-guide)
- [Advanced Features](#-advanced-features)
- [API Documentation](#-api-documentation)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌟 Overview

**Ultimate Remote Spy** is a comprehensive monitoring tool for Roblox that intercepts and logs all RemoteEvent and RemoteFunction calls. It features a beautiful, customizable UI, advanced filtering, exploit detection, and much more.

### Why Ultimate Remote Spy?

- 🎯 **Multi-Level Hooking**: Captures ALL remote calls using metamethod interception
- 📊 **Rich Data Collection**: Full argument serialization with deep copy support
- 🛡️ **Built-in Exploit Detection**: ML-powered pattern recognition for suspicious activity
- 🎨 **Beautiful UI**: Modern, draggable interface with multiple themes
- 🔍 **Advanced Filtering**: Search, filter, and analyze logs in real-time
- 📈 **Live Statistics**: Monitor calls per second, data transfer, and more
- 💾 **Export Support**: JSON, CSV, and more formats
- ⚡ **High Performance**: Handles 1000+ calls/second with minimal impact

---

## ✨ Features

### 🎯 Core Interception

<details>
<summary><b>Click to expand</b></summary>

- **Metamethod Hooking**
  - `__namecall` interception for FireServer/InvokeServer
  - `__index` interception for OnClientEvent
  - Anti-unhook protection
  
- **Universal Detection**
  - Auto-discovery of all RemoteEvents
  - Auto-discovery of all RemoteFunctions
  - BindableEvent/BindableFunction tracking
  - Dynamic remote creation tracking

- **Capture Modes**
  - Full capture (everything)
  - Selective capture (whitelist/blacklist)
  - Smart sampling (capture X% of calls)
  - Burst capture for debugging

</details>

### 📊 Data Collection

<details>
<summary><b>Click to expand</b></summary>

- **Comprehensive Call Data**
  - Remote name and full path
  - Direction (Client→Server or Server→Client)
  - Millisecond-precision timestamps
  - Full argument serialization
  - Return value tracking (InvokeServer)
  - Caller script information
  - Call stack traces

- **Advanced Serialization**
  - Deep table recursion
  - Instance path preservation
  - CFrame/Vector3/Color3 formatting
  - Enum resolution
  - Circular reference detection

- **Metadata Tracking**
  - Player information (UserId, Name, AccountAge)
  - Game state snapshots
  - Memory/CPU usage
  - Network statistics

</details>

### 🔍 Filtering & Search

<details>
<summary><b>Click to expand</b></summary>

- **Real-Time Filtering**
  - Filter by remote name (wildcard support)
  - Filter by direction
  - Filter by player
  - Filter by argument values
  - Time range filtering
  - Composite filters (AND/OR/NOT)

- **Search Capabilities**
  - Full-text search in arguments
  - Type-based search
  - Pattern matching
  - Similarity search

</details>

### 🛡️ Security & Detection

<details>
<summary><b>Click to expand</b></summary>

- **Exploit Detection**
  - Speed exploit detection (rapid calls)
  - Impossible value detection (inf, nan, huge numbers)
  - Pattern recognition
  - Heuristic analysis

- **Auto-Flagging**
  - Automatic suspicious call flagging
  - Visual indicators in UI
  - Detailed exploit reports
  - Alert system

</details>

### 🎨 UI Features

<details>
<summary><b>Click to expand</b></summary>

- **Modern Interface**
  - Draggable windows
  - Resizable panels
  - Multiple themes (Dark, Light, Midnight, Ocean)
  - Smooth animations
  - Rounded corners

- **Live Monitoring**
  - Real-time event stream
  - Auto-scroll with pause
  - Visual alerts
  - Performance meters

- **Statistics Dashboard**
  - Total calls counter
  - Calls per second (CPS)
  - Flagged events counter
  - Data size tracking

</details>

### 📁 Export & Integration

<details>
<summary><b>Click to expand</b></summary>

- **Export Formats**
  - JSON (with full metadata)
  - CSV (for spreadsheet analysis)
  - Clipboard copy support

- **Extensibility**
  - Modular architecture
  - Easy to customize
  - Plugin system ready
  - API endpoints

</details>

---

## 🚀 Installation

### Method 1: Direct Execution (Recommended)

1. Copy the contents of `RemoteSpy.lua`
2. Paste into your executor
3. Execute the script
4. Press **K** to toggle the UI

### Method 2: Loadstring (Advanced)

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/RemoteSpy/main/RemoteSpy.lua"))()
```

### Method 3: Module Script

1. Create a ModuleScript in your executor's workspace
2. Paste the code
3. Require the module:

```lua
local RemoteSpy = require(script.RemoteSpy)
RemoteSpy:Initialize()
```

---

## 🎮 Quick Start

### Basic Usage

1. **Execute the script** in your Roblox executor
2. **Press K** to open the UI
3. **Start playing** - all remote calls are automatically logged
4. **Use the search bar** to filter specific remotes
5. **Press Ctrl+C** to clear logs
6. **Press Ctrl+E** to export data to clipboard

### Keybinds

| Key | Action |
|-----|--------|
| `K` | Toggle UI visibility |
| `Ctrl+F` | Focus search box |
| `Ctrl+C` | Clear all logs |
| `Ctrl+E` | Export logs to clipboard |

### First Steps

1. **Open the UI** and familiarize yourself with the layout
2. **Perform actions** in the game to see remotes being logged
3. **Click on log entries** to see detailed information
4. **Use filters** to find specific remote calls
5. **Check the Security tab** for flagged exploits

---

## ⚙️ Configuration

### Customizing Settings

Edit the `RemoteSpy.Config` table at the top of the script:

```lua
RemoteSpy.Config = {
    UI = {
        ToggleKey = Enum.KeyCode.K,        -- Change toggle key
        Theme = "Dark",                     -- Dark, Light, Midnight, Ocean
        WindowSize = UDim2.new(0, 900, 0, 600),
        Transparency = 0.05,
        Animations = true
    },
    
    Capture = {
        Mode = "Full",                      -- Full, Selective, Smart, Burst
        MaxBuffer = 10000,                  -- Max logs to keep
        SamplingRate = 100,                 -- Percentage of calls to capture
        AutoStart = true,
        DeepCopy = true                     -- Full argument copying
    },
    
    Security = {
        DetectExploits = true,              -- Enable exploit detection
        AutoFlag = true,                    -- Auto-flag suspicious calls
        AntiUnhook = true
    }
}
```

### Themes

Available themes:
- **Dark** - Classic dark theme (default)
- **Light** - Clean light theme
- **Midnight** - Deep blue theme
- **Ocean** - Aqua/teal theme
- **Sunset** - Coming soon!

---

## 🎨 UI Guide

### Main Window

```
╔══════════════════════════════════════════════════╗
║  🔍 ULTIMATE REMOTE SPY v3.0.0    [─] [✕]      ║
╠══════════════════════════════════════════════════╣
║  [📋 Logs] [📊 Stats] [🛡️ Security] [⚙️ Settings] ║
╠══════════════════════════════════════════════════╣
║                                                  ║
║  ↗️ RemoteName              12:34:56           ║
║     Args: {...}                       ⚠️ FLAGGED ║
║                                                  ║
║  ↙️ AnotherRemote           12:34:57           ║
║     Args: {...}                                  ║
║                                                  ║
╠══════════════════════════════════════════════════╣
║  🔍 Search logs...                     [Clear]  ║
╚══════════════════════════════════════════════════╝
```

### Tabs

1. **📋 Logs Tab**
   - Real-time log display
   - Scroll through captured calls
   - Click to expand details

2. **📊 Statistics Tab**
   - Total calls
   - Calls per second
   - Data transfer stats
   - Top callers

3. **🛡️ Security Tab**
   - Flagged events
   - Exploit patterns
   - Security alerts

4. **⚙️ Settings Tab**
   - Theme selection
   - Filter configuration
   - Export options

---

## 🔥 Advanced Features

### Custom Filters

Add custom filters programmatically:

```lua
-- Filter by remote name
DataStore.Filters.Active = {
    {
        Name = "OnlyDamageRemotes",
        Check = function(log)
            return log.RemoteName:match("Damage") ~= nil
        end
    }
}
```

### Export to File

```lua
-- Export as JSON
local data = DataStore:Export("JSON")
writefile("RemoteSpy_Export.json", data)

-- Export as CSV
local csv = DataStore:Export("CSV")
writefile("RemoteSpy_Export.csv", csv)
```

### Custom Exploit Patterns

```lua
-- Add custom detection pattern
ExploitDetector:AddPattern("CustomPattern", function(log)
    -- Your detection logic
    if log.Args[1] == "suspicious_value" then
        return true, "Custom exploit detected"
    end
    return false
end)
```

### Replay Calls

```lua
-- Replay a specific call
local log = DataStore.Logs[1]
local remote = game:GetService("ReplicatedStorage"):FindFirstChild(log.RemoteName)
if remote then
    remote:FireServer(unpack(log.Args))
end
```

---

## 📚 API Documentation

### RemoteSpy Module

```lua
RemoteSpy:Initialize()              -- Initialize all systems
RemoteSpy.UI:Toggle()               -- Toggle UI visibility
RemoteSpy.UI:UpdateLogDisplay()     -- Refresh log display
```

### DataStore API

```lua
DataStore:AddLog(logEntry)          -- Add a log entry
DataStore:GetFilteredLogs()         -- Get filtered logs
DataStore:Clear()                   -- Clear all logs
DataStore:Export(format)            -- Export logs (JSON/CSV)
```

### HookEngine API

```lua
HookEngine:Initialize()             -- Start hooking
HookEngine:LogRemoteCall(...)       -- Manually log a call
```

### ExploitDetector API

```lua
ExploitDetector:Initialize()        -- Initialize detector
ExploitDetector:AddPattern(name, func)  -- Add detection pattern
ExploitDetector:Analyze(log)        -- Analyze a log entry
```

---

## 🐛 Troubleshooting

### UI Not Showing

1. Check if CoreGui access is available
2. Try changing the toggle key in config
3. Verify the script executed without errors

### Missing Remote Calls

1. Ensure `AutoStart` is enabled in config
2. Check if the game uses custom networking
3. Try increasing `SamplingRate` to 100%

### Performance Issues

1. Reduce `MaxBuffer` size
2. Disable `DeepCopy` for faster logging
3. Lower `SamplingRate` for less frequent capture
4. Disable exploit detection if not needed

### Export Not Working

1. Ensure clipboard access is available
2. Try exporting to file instead
3. Check if data size exceeds limits

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

### Reporting Bugs

1. Check existing issues first
2. Create a detailed bug report with:
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Roblox version and executor used

### Feature Requests

1. Search existing feature requests
2. Describe the feature in detail
3. Explain use cases and benefits

### Code Contributions

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Style

- Use 4 spaces for indentation
- Add comments for complex logic
- Follow existing naming conventions
- Keep functions focused and modular

---

## 📜 Changelog

### v3.0.0 (Current)
- ✨ Complete rewrite with modular architecture
- 🎨 New modern UI with multiple themes
- 🛡️ Advanced exploit detection system
- 📊 Real-time statistics dashboard
- 🔍 Enhanced filtering and search
- 💾 Multiple export formats
- ⚡ Performance optimizations

### v2.0.0
- Added basic UI
- Metamethod hooking
- Simple logging

### v1.0.0
- Initial release
- Basic remote interception

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- Roblox Community for inspiration
- All contributors and testers
- You for using Ultimate Remote Spy!

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/RemoteSpy/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/RemoteSpy/discussions)
- **Discord**: Coming soon!

---

<div align="center">

**Made with ❤️ for the Roblox community**

⭐ Star this repo if you find it useful!

[⬆ Back to Top](#-ultimate-remote-spy-v300)

</div>
