# 📥 Installation Guide - Ultimate Remote Spy

This guide will walk you through installing and setting up Ultimate Remote Spy.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
- [First Time Setup](#first-time-setup)
- [Troubleshooting](#troubleshooting)
- [Next Steps](#next-steps)

## ✅ Prerequisites

Before installing, make sure you have:

### Required
- ✅ **Roblox Executor** - Any modern executor that supports:
  - `hookmetamethod`
  - `getnamecallmethod`
  - `setclipboard` (for export features)
  - `writefile`/`readfile` (optional, for saving configs)
- ✅ **Roblox Account** - To test in games

### Recommended
- ✅ **GitHub Account** - To star the repo and stay updated
- ✅ **Discord** - For community support (coming soon)
- ✅ **Basic Lua Knowledge** - Helpful for customization

### Executor Compatibility

| Executor | Status | Notes |
|----------|--------|-------|
| Synapse X | ✅ Fully Compatible | Recommended |
| Script-Ware | ✅ Fully Compatible | Recommended |
| KRNL | ✅ Compatible | Some features limited |
| Fluxus | ✅ Compatible | Good performance |
| Electron | ⚠️ Partial | Basic features only |
| JJSploit | ❌ Not Recommended | Outdated API |

## 🚀 Installation Methods

### Method 1: Direct Copy (Easiest)

**Best for:** Most users

1. **Download the Script**
   - Go to the [GitHub Repository](https://github.com/YOUR_USERNAME/RemoteSpy)
   - Click on `RemoteSpy.lua`
   - Click the "Raw" button
   - Press `Ctrl+A` to select all
   - Press `Ctrl+C` to copy

2. **Paste into Executor**
   - Open your executor
   - Paste the script into the script editor
   - Click "Execute" or "Inject"

3. **Done!**
   - Press `K` to toggle the UI
   - Start using Remote Spy

**Pros:**
- ✅ Simplest method
- ✅ Works on all executors
- ✅ No external dependencies

**Cons:**
- ❌ Manual updates required
- ❌ Need to re-paste for each session

---

### Method 2: Loadstring (Recommended)

**Best for:** Users who want auto-updates

1. **Copy the Loadstring**
   ```lua
   loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/RemoteSpy/main/RemoteSpy.lua"))()
   ```

2. **Paste into Executor**
   - Open your executor
   - Paste the loadstring
   - Execute

3. **Save for Later** (Optional)
   - Save the loadstring in your executor's script hub
   - Execute whenever needed

**Pros:**
- ✅ Always gets latest version
- ✅ One-line execution
- ✅ Easy to share

**Cons:**
- ❌ Requires HTTP requests enabled
- ❌ Slight delay on first load

**Troubleshooting Loadstring:**
If you get errors:
```lua
-- Try with longer timeout
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/YOUR_USERNAME/RemoteSpy/main/RemoteSpy.lua", true))()

-- Or download and save locally first
local script = game:HttpGet("...")
writefile("RemoteSpy.lua", script)
-- Then next time:
loadstring(readfile("RemoteSpy.lua"))()
```

---

### Method 3: Local File (Advanced)

**Best for:** Developers and power users

1. **Clone the Repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/RemoteSpy.git
   cd RemoteSpy
   ```

2. **Save to Executor Workspace**
   - Copy `RemoteSpy.lua` to your executor's workspace folder
   - Usually: `C:\Users\YourName\Executor\workspace\`

3. **Load in Game**
   ```lua
   loadfile("RemoteSpy.lua")()
   -- or
   loadstring(readfile("RemoteSpy.lua"))()
   ```

**Pros:**
- ✅ Offline access
- ✅ Easy to modify
- ✅ Version control with git

**Cons:**
- ❌ Manual setup required
- ❌ More complex

---

### Method 4: Module Script (Expert)

**Best for:** Integrating with other scripts

1. **Create ModuleScript**
   - In your executor's workspace
   - Name it `RemoteSpy`

2. **Paste the Code**
   - Copy all code from `RemoteSpy.lua`
   - Paste into the ModuleScript
   - Make sure it ends with `return RemoteSpy`

3. **Require in Your Script**
   ```lua
   local RemoteSpy = require(script.RemoteSpy)
   RemoteSpy:Initialize()
   
   -- Custom configuration
   RemoteSpy.Config.UI.Theme = "Ocean"
   
   -- Access API
   local logs = RemoteSpy.DataStore.Logs
   ```

**Pros:**
- ✅ Full programmatic control
- ✅ Can integrate with other tools
- ✅ Reusable across projects

**Cons:**
- ❌ Requires Lua knowledge
- ❌ More setup time

---

## 🎮 First Time Setup

### Step 1: Execute the Script

Choose your installation method and execute the script.

You should see:
```
╔═══════════════════════════════════════════════════════════════╗
║           ULTIMATE REMOTE SPY v3.0.0                         ║
║              Initializing all systems...                      ║
╚═══════════════════════════════════════════════════════════════╝
[RemoteSpy] Hooking engine initialized
[RemoteSpy] Exploit detector initialized
[RemoteSpy] UI initialized
[RemoteSpy] ✅ All systems operational!
[RemoteSpy] Press 'K' to toggle UI
```

### Step 2: Open the UI

Press `K` (or your configured toggle key) to open the interface.

You should see the main window with:
- Top bar with title and buttons
- Tab bar (Logs, Statistics, Security, Settings)
- Log display area
- Search bar at the bottom

### Step 3: Test It

1. **Perform actions in the game**
   - Walk around
   - Pick up items
   - Interact with objects

2. **Check the Logs tab**
   - You should see remote calls appearing
   - Each entry shows:
     - Direction (↗️ or ↙️)
     - Remote name
     - Timestamp
     - Arguments

3. **Try the search**
   - Click the search box (or press `Ctrl+F`)
   - Type a remote name
   - Logs are filtered in real-time

### Step 4: Customize (Optional)

Edit the configuration at the top of the script:

```lua
RemoteSpy.Config = {
    UI = {
        ToggleKey = Enum.KeyCode.K,  -- Change to any key
        Theme = "Dark",               -- Try: Light, Midnight, Ocean
        WindowSize = UDim2.new(0, 900, 0, 600),
    },
    
    Capture = {
        Mode = "Full",                -- Full, Selective, Smart
        MaxBuffer = 10000,            -- Max logs to keep
    },
    
    Security = {
        DetectExploits = true,        -- Enable/disable detection
    }
}
```

### Step 5: Explore Features

Try these features:

- **Clear logs**: Press `Ctrl+C`
- **Export data**: Press `Ctrl+E` (copies to clipboard)
- **Search**: Press `Ctrl+F` to focus search
- **Drag window**: Click and drag the top bar
- **Close**: Click the X button or press `K` again

## 🐛 Troubleshooting

### UI Not Appearing

**Problem:** Pressed K but nothing happens

**Solutions:**
1. Check console for errors
   ```lua
   -- Look for error messages
   ```

2. Try different key
   ```lua
   RemoteSpy.Config.UI.ToggleKey = Enum.KeyCode.Insert
   ```

3. Manually show UI
   ```lua
   RemoteSpy.UI:Toggle()
   ```

4. Check CoreGui access
   ```lua
   print(game:GetService("CoreGui"))
   -- Should not error
   ```

### No Remotes Being Captured

**Problem:** UI opens but no logs appear

**Solutions:**
1. Verify hooks are active
   ```lua
   print(RemoteSpy.HookEngine.IsHooked)
   -- Should print: true
   ```

2. Check if AutoStart is enabled
   ```lua
   print(RemoteSpy.Config.Capture.AutoStart)
   -- Should print: true
   ```

3. Perform obvious actions
   - Chat in-game
   - Pick up tools
   - Open GUI menus

4. Check for custom networking
   - Some games use custom remote systems
   - May require manual hook setup

### Performance Issues

**Problem:** Game lagging after using Remote Spy

**Solutions:**
1. Reduce buffer size
   ```lua
   RemoteSpy.Config.Capture.MaxBuffer = 1000
   ```

2. Disable deep copy
   ```lua
   RemoteSpy.Config.Capture.DeepCopy = false
   ```

3. Lower sampling rate
   ```lua
   RemoteSpy.Config.Capture.SamplingRate = 50  -- 50%
   ```

4. Disable exploit detection
   ```lua
   RemoteSpy.Config.Security.DetectExploits = false
   ```

5. Use high-performance preset
   ```lua
   local Config = require(script.AdvancedConfig)
   Config:ApplyPreset("HighPerformance")
   ```

### Export Not Working

**Problem:** Ctrl+E doesn't copy to clipboard

**Solutions:**
1. Check if setclipboard is supported
   ```lua
   if setclipboard then
       print("Clipboard supported")
   else
       warn("Clipboard not supported")
   end
   ```

2. Use file export instead
   ```lua
   local data = RemoteSpy.DataStore:Export("JSON")
   writefile("export.json", data)
   ```

3. Print to console
   ```lua
   local data = RemoteSpy.DataStore:Export("JSON")
   print(data)
   ```

### Script Errors

**Problem:** Error messages in console

**Common Errors:**

1. **"attempt to index nil value"**
   - Usually means a service or object doesn't exist
   - Check if you're in the right game/place

2. **"hookmetamethod is not a function"**
   - Your executor doesn't support required functions
   - Try a different executor

3. **"attempt to call a nil value"**
   - Missing dependency or function
   - Make sure you have the full script

### Game-Specific Issues

**Problem:** Works in some games but not others

**Solutions:**
1. Some games have anti-cheat
   - May detect or block the script
   - Use with caution

2. Some games use custom networking
   - May not use standard RemoteEvents
   - Consider requesting game-specific support

3. Check logs for specific errors
   - Enable debug mode
   ```lua
   RemoteSpy.Config.Logging.DebugMode = true
   ```

## 📚 Next Steps

### Learn More

- Read the [README](README.md) for feature overview
- Check [Examples.lua](Examples.lua) for usage examples
- Review [AdvancedConfig.lua](AdvancedConfig.lua) for all options
- Read [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

### Join Community

- ⭐ Star the repository on GitHub
- 🐛 Report bugs in [Issues](https://github.com/YOUR_USERNAME/RemoteSpy/issues)
- 💡 Suggest features in [Discussions](https://github.com/YOUR_USERNAME/RemoteSpy/discussions)
- 💬 Join our Discord (coming soon!)

### Customize Further

- Create custom themes
- Add custom exploit detection patterns
- Write your own plugins
- Integrate with other scripts

### Share Your Experience

- Write a review or tutorial
- Share on social media
- Help others in the community
- Submit improvements via PR

## 🆘 Still Need Help?

If you're still having issues:

1. **Search existing issues** on GitHub
2. **Create a new issue** with:
   - Your executor name
   - Roblox version
   - Error messages
   - Steps to reproduce
3. **Be patient** - maintainers will respond

## 🎉 Success!

You're all set up! Enjoy using Ultimate Remote Spy!

Press `K` to get started.

---

<div align="center">

**Happy Remote Spying! 🔍**

[⬆ Back to Top](#-installation-guide---ultimate-remote-spy)

</div>
