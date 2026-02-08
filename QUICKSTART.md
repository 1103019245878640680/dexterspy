# 🚀 Quick Start Guide

Get started with Ultimate Remote Spy in 5 minutes!

## ⚡ Fastest Way to Start

### 1. Copy & Paste (30 seconds)

```lua
-- Copy this entire script and paste into your executor
loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/RemoteSpy/main/RemoteSpy.lua"))()
```

### 2. Execute & Open (5 seconds)

- Execute the script
- Press `K` to open UI

### 3. You're Done! 🎉

All remote calls are now being logged automatically.

---

## 🎯 Essential Keybinds

| Key | Action |
|-----|--------|
| `K` | Toggle UI On/Off |
| `Ctrl+F` | Search Logs |
| `Ctrl+C` | Clear All Logs |
| `Ctrl+E` | Export to Clipboard |

---

## 💡 Quick Tips

### Tip 1: Find Specific Remotes
```
1. Press Ctrl+F
2. Type remote name
3. See filtered results
```

### Tip 2: Change Theme
```lua
-- At the top of the script, change:
Theme = "Dark"  -- Options: Dark, Light, Midnight, Ocean
```

### Tip 3: Export Your Data
```
1. Press Ctrl+E
2. Data is copied to clipboard
3. Paste in notepad/Discord/etc
```

### Tip 4: Clear When Too Many Logs
```
Press Ctrl+C to clear all logs and start fresh
```

---

## 🎨 Quick Customization

Want to change the toggle key?
```lua
-- Change this line:
ToggleKey = Enum.KeyCode.K,

-- To any key, for example:
ToggleKey = Enum.KeyCode.Insert,
```

Want fewer logs for better performance?
```lua
-- Change this line:
MaxBuffer = 10000,

-- To a lower number:
MaxBuffer = 1000,
```

---

## 📊 What You'll See

### Log Entry Example
```
↗️ DamageRemote              12:34:56
   Args: {10, "sword", Player}
```

**Breakdown:**
- `↗️` = Client→Server call
- `DamageRemote` = Remote name
- `12:34:56` = Time it was called
- `Args: {...}` = What was sent

### Direction Indicators
- `↗️` = You → Server (FireServer, InvokeServer)
- `↙️` = Server → You (OnClientEvent)

### Exploit Flags
- `⚠️ FLAGGED` = Suspicious activity detected

---

## 🆘 Common Issues

### UI Won't Open
**Try:** Press the key multiple times, or check console for errors

### No Logs Appearing
**Try:** Do obvious actions in game (chat, walk, pick up items)

### Game Lagging
**Try:** Reduce MaxBuffer to 1000 or less

### Need More Help?
Read the [full documentation](README.md) or [installation guide](INSTALLATION.md)

---

## 🎓 Next Steps

Once you're comfortable with the basics:

1. **Explore Themes** - Try all 4 built-in themes
2. **Read Examples** - Check `Examples.lua` for advanced usage
3. **Try Filters** - Create custom filters for specific remotes
4. **Export Data** - Save logs for later analysis
5. **Join Community** - Star the repo and join discussions

---

## 📚 Resources

- [Full README](README.md) - Complete feature list
- [Installation Guide](INSTALLATION.md) - Detailed setup
- [Examples](Examples.lua) - Code examples
- [Advanced Config](AdvancedConfig.lua) - All options
- [Contributing](CONTRIBUTING.md) - Help improve the project

---

<div align="center">

**Ready to spy on some remotes? Press K!** 🔍

Questions? Open an issue on GitHub!

</div>
