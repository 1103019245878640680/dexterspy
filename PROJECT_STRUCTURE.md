# 📁 Project Structure

This document explains the organization of the Ultimate Remote Spy project.

## 📂 Directory Layout

```
RemoteSpy/
├── 📄 RemoteSpy.lua           # Main script (REQUIRED)
├── 📄 README.md               # Project documentation
├── 📄 QUICKSTART.md           # Quick start guide
├── 📄 INSTALLATION.md         # Detailed installation guide
├── 📄 CHANGELOG.md            # Version history
├── 📄 CONTRIBUTING.md         # Contribution guidelines
├── 📄 LICENSE                 # MIT License
├── 📄 .gitignore             # Git ignore rules
├── 📄 Examples.lua            # Usage examples
├── 📄 AdvancedConfig.lua      # Advanced configuration
└── 📄 PROJECT_STRUCTURE.md    # This file
```

## 📄 File Descriptions

### Core Files

#### `RemoteSpy.lua` ⭐
**Purpose:** The main script that does everything
**Size:** ~37KB
**Lines:** ~1,200
**Required:** YES

**Contains:**
- Configuration system
- Hooking engine
- Data storage
- Exploit detection
- UI system
- All core functionality

**Usage:**
```lua
-- Execute directly
loadstring(readfile("RemoteSpy.lua"))()

-- Or via HTTP
loadstring(game:HttpGet("URL"))()
```

### Documentation Files

#### `README.md` 📖
**Purpose:** Main project documentation
**Contents:**
- Feature overview
- Installation instructions
- Basic usage guide
- API documentation
- Troubleshooting
- Links to other docs

**Target Audience:** Everyone

#### `QUICKSTART.md` 🚀
**Purpose:** Get started in 5 minutes
**Contents:**
- One-line installation
- Essential keybinds
- Quick tips
- Common issues

**Target Audience:** New users

#### `INSTALLATION.md` 📥
**Purpose:** Comprehensive installation guide
**Contents:**
- Prerequisites
- Multiple installation methods
- Step-by-step setup
- Detailed troubleshooting
- Executor compatibility

**Target Audience:** All users, especially those having issues

#### `CHANGELOG.md` 📋
**Purpose:** Version history and release notes
**Contents:**
- All version changes
- Breaking changes
- Upgrade guides
- Known issues
- Roadmap

**Target Audience:** Users tracking updates

#### `CONTRIBUTING.md` 🤝
**Purpose:** Guide for contributors
**Contents:**
- How to contribute
- Code style guide
- Development setup
- Pull request process
- Community guidelines

**Target Audience:** Developers and contributors

#### `PROJECT_STRUCTURE.md` 📁
**Purpose:** Explain project organization
**Contents:**
- This file!
- Directory layout
- File descriptions
- Relationships

**Target Audience:** Developers

### Example and Configuration Files

#### `Examples.lua` 💡
**Purpose:** Practical usage examples
**Size:** ~18KB
**Lines:** ~500+

**Contains:**
- 12+ different example scenarios
- Custom filters
- Exploit detection patterns
- Export examples
- Real-time monitoring
- Integration examples

**Usage:**
```lua
-- Load for reference, don't execute directly
-- Copy relevant examples to your script
```

#### `AdvancedConfig.lua` ⚙️
**Purpose:** Complete configuration reference
**Size:** ~19KB
**Lines:** ~600+

**Contains:**
- All configuration options
- Preset configurations
- Validation functions
- Save/Load functions

**Usage:**
```lua
local Config = require(script.AdvancedConfig)
Config:ApplyPreset("HighPerformance")
```

### Meta Files

#### `LICENSE` ⚖️
**Purpose:** Legal license (MIT)
**Required:** YES (for open source)

#### `.gitignore` 🚫
**Purpose:** Git ignore rules
**Required:** Only for development

## 🏗️ Code Architecture

### RemoteSpy.lua Internal Structure

```lua
RemoteSpy.lua (36KB)
│
├── [1] Configuration (lines 1-120)
│   ├── UI Settings
│   ├── Capture Settings
│   ├── Performance Settings
│   └── Security Settings
│
├── [2] Services & Imports (lines 121-140)
│   └── Roblox service references
│
├── [3] Utility Functions (lines 141-250)
│   ├── DeepCopy
│   ├── SerializeValue
│   ├── Timestamps
│   └── Path helpers
│
├── [4] Data Storage (lines 251-350)
│   ├── Log storage
│   ├── Statistics
│   ├── Filters
│   └── Export functions
│
├── [5] Hooking Engine (lines 351-500)
│   ├── Metamethod hooks
│   ├── Function hooks
│   ├── Remote call logging
│   └── Anti-unhook
│
├── [6] Exploit Detector (lines 501-620)
│   ├── Pattern definitions
│   ├── Analysis functions
│   └── Flagging system
│
├── [7] UI Themes (lines 621-720)
│   └── Color definitions
│
├── [8] UI Creation (lines 721-1100)
│   ├── Window creation
│   ├── Component builders
│   ├── Event handlers
│   └── Update functions
│
├── [9] Input Handling (lines 1101-1150)
│   └── Keyboard shortcuts
│
└── [10] Initialization (lines 1151-1200)
    └── Startup sequence
```

## 🔄 Data Flow

```
Game Remote Call
        ↓
Hook Intercepts
        ↓
Create Log Entry
        ↓
Add to DataStore
        ↓
    ┌───┴───┐
    ↓       ↓
Exploit   Update UI
Detector
    ↓
  Flag if
Suspicious
```

## 🎨 UI Component Hierarchy

```
ScreenGui
└── MainWindow
    ├── TopBar
    │   ├── Title
    │   ├── Stats Label
    │   ├── Minimize Button
    │   └── Close Button
    │
    └── Content
        ├── TabBar
        │   ├── Logs Tab
        │   ├── Statistics Tab
        │   ├── Security Tab
        │   └── Settings Tab
        │
        ├── TabContent
        │   └── LogScroll
        │       └── Log Entries (dynamic)
        │
        └── SearchBar
            ├── SearchBox
            └── Clear Button
```

## 💾 Data Structures

### Log Entry Structure
```lua
{
    ID = 1234567890,
    Timestamp = 1706860800000,
    RemoteName = "DamageRemote",
    RemotePath = "game.ReplicatedStorage.Remotes.DamageRemote",
    Method = "FireServer",
    Direction = "Client->Server",
    Args = {...},
    SerializedArgs = "{10, 'sword'}",
    Caller = {Source = "...", Line = 42, Name = "..."},
    PlayerInfo = {Name = "...", UserId = 12345, ...}
}
```

### Statistics Structure
```lua
{
    TotalCalls = 1523,
    CallsPerSecond = 15,
    UniqueRemotes = 23,
    DataTransferred = 1024000,
    LastReset = 1706860800
}
```

## 🔧 Module Dependencies

```
RemoteSpy
├── CoreGui (UI display)
├── RunService (frame updates)
├── HttpService (JSON encoding)
├── TweenService (animations)
├── UserInputService (keyboard input)
└── Players (player info)
```

## 📊 Performance Characteristics

### Memory Usage
- **Base:** ~2-5 MB
- **With 1000 logs:** ~10-15 MB
- **With 10000 logs:** ~50-80 MB
- **Max recommended:** 100 MB

### CPU Usage
- **Idle:** <1% CPU
- **Active logging:** 1-3% CPU
- **UI updates:** 2-5% CPU
- **Peak:** <10% CPU

### Optimization Points
1. **Lazy Rendering** - Only visible logs
2. **Ring Buffer** - Limited log storage
3. **Deferred Serialization** - Serialize on view
4. **Cached Paths** - Don't recalculate
5. **Throttled Updates** - Update UI at intervals

## 🎯 Design Patterns Used

### Singleton Pattern
```lua
-- Single RemoteSpy instance
local RemoteSpy = {}
```

### Observer Pattern
```lua
-- UI updates on data changes
RunService.Heartbeat:Connect(updateUI)
```

### Factory Pattern
```lua
-- Create UI components
UI:CreateButton(...)
UI:CreateLogEntry(...)
```

### Strategy Pattern
```lua
-- Different capture modes
Capture.Mode = "Full" | "Selective" | "Smart"
```

## 📝 File Relationships

```
README.md ──references──> All other docs
    │
    ├──links to──> INSTALLATION.md
    ├──links to──> QUICKSTART.md
    ├──links to──> Examples.lua
    └──links to──> CONTRIBUTING.md

RemoteSpy.lua ──imports──> AdvancedConfig.lua (optional)
    │
    └──examples in──> Examples.lua

Examples.lua ──uses──> RemoteSpy.lua API
    │
    └──references──> AdvancedConfig.lua

CONTRIBUTING.md ──references──> PROJECT_STRUCTURE.md
    │
    └──references──> README.md
```

## 🚀 Build Process

No build process required! This is pure Lua.

But for development:

1. **Edit** any .lua file
2. **Test** in Roblox
3. **Commit** to git
4. **Push** to GitHub
5. **Users** pull via loadstring

## 📦 Distribution

### For Users
```
Just download RemoteSpy.lua
Everything else is optional documentation
```

### For Developers
```
Clone entire repository
All files included
```

## 🔄 Version Control

### Git Branching Strategy

```
main (stable)
    ├── develop (active development)
    │   ├── feature/new-theme
    │   ├── feature/ml-detection
    │   └── bugfix/ui-freeze
    └── hotfix/critical-bug
```

### Release Process

1. Develop on `develop` branch
2. Test thoroughly
3. Update CHANGELOG.md
4. Merge to `main`
5. Tag version (v3.0.0)
6. Create GitHub release

## 🎓 Learning Path

### For Users
1. Read QUICKSTART.md (5 min)
2. Execute RemoteSpy.lua
3. Read README.md sections as needed
4. Check Examples.lua for ideas

### For Developers
1. Read PROJECT_STRUCTURE.md (this file)
2. Study RemoteSpy.lua code
3. Read CONTRIBUTING.md
4. Check AdvancedConfig.lua
5. Review Examples.lua
6. Start contributing!

## 📞 Support Structure

```
Question/Issue
    ↓
Search Documentation
    ↓
Still Need Help?
    ↓
GitHub Issues
    ↓
Community Support
```

---

<div align="center">

**Now you understand the entire project structure!** 🎉

Ready to contribute? Check [CONTRIBUTING.md](CONTRIBUTING.md)

</div>
