--[[
    ═══════════════════════════════════════════════════════════════
                    ULTIMATE REMOTE SPY - EXAMPLES
    ═══════════════════════════════════════════════════════════════
    
    This file contains various usage examples and advanced features
    of the Ultimate Remote Spy.
]]

-- ═══════════════════════════════════════════════════════════════
--                      EXAMPLE 1: BASIC USAGE
-- ═══════════════════════════════════════════════════════════════

--[[
    Simply execute the main script and press K to toggle the UI.
    All remote calls will be automatically logged.
]]

loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 2: CUSTOM CONFIGURATION
-- ═══════════════════════════════════════════════════════════════

-- Load the script
local RemoteSpy = loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()

-- Customize before initialization
RemoteSpy.Config.UI.Theme = "Ocean"
RemoteSpy.Config.UI.ToggleKey = Enum.KeyCode.Insert
RemoteSpy.Config.Capture.MaxBuffer = 5000
RemoteSpy.Config.Security.DetectExploits = true

-- Now initialize
RemoteSpy:Initialize()

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 3: CUSTOM FILTERS
-- ═══════════════════════════════════════════════════════════════

-- Filter only damage-related remotes
RemoteSpy.DataStore.Filters.Active = {
    {
        Name = "DamageOnly",
        Check = function(log)
            return log.RemoteName:lower():match("damage") or 
                   log.RemoteName:lower():match("hit") or
                   log.RemoteName:lower():match("attack")
        end
    }
}

-- Filter by argument value
RemoteSpy.DataStore.Filters.Active = {
    {
        Name = "LargeNumbers",
        Check = function(log)
            for _, arg in ipairs(log.Args) do
                if type(arg) == "number" and arg > 1000 then
                    return true
                end
            end
            return false
        end
    }
}

-- Multiple filters (AND logic)
RemoteSpy.DataStore.Filters.Active = {
    {
        Name = "ClientToServer",
        Check = function(log)
            return log.Direction == "Client->Server"
        end
    },
    {
        Name = "RecentCalls",
        Check = function(log)
            return (tick() * 1000 - log.Timestamp) < 10000 -- Last 10 seconds
        end
    }
}

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 4: EXPLOIT DETECTION
-- ═══════════════════════════════════════════════════════════════

-- Add custom exploit detection pattern
RemoteSpy.ExploitDetector:AddPattern("GodMode", function(log)
    -- Detect if player is sending impossible health values
    if log.RemoteName:match("Health") or log.RemoteName:match("HP") then
        for _, arg in ipairs(log.Args) do
            if type(arg) == "number" and (arg > 1000 or arg == math.huge) then
                return true, "Impossible health value detected: " .. tostring(arg)
            end
        end
    end
    return false
end)

-- Teleport detection
RemoteSpy.ExploitDetector:AddPattern("Teleport", function(log)
    if log.RemoteName:match("Position") or log.RemoteName:match("CFrame") then
        for _, arg in ipairs(log.Args) do
            if typeof(arg) == "Vector3" then
                local magnitude = arg.Magnitude
                if magnitude > 10000 then
                    return true, "Impossible position detected: " .. tostring(arg)
                end
            end
        end
    end
    return false
end)

-- Speed exploit detection
local lastPositions = {}
RemoteSpy.ExploitDetector:AddPattern("SpeedHack", function(log)
    if log.RemoteName:match("Move") or log.RemoteName:match("Position") then
        local userId = log.PlayerInfo.UserId
        lastPositions[userId] = lastPositions[userId] or {}
        
        for _, arg in ipairs(log.Args) do
            if typeof(arg) == "Vector3" then
                local history = lastPositions[userId]
                
                if #history > 0 then
                    local lastPos = history[#history].pos
                    local lastTime = history[#history].time
                    local distance = (arg - lastPos).Magnitude
                    local timeDiff = (log.Timestamp - lastTime) / 1000
                    local speed = distance / timeDiff
                    
                    if speed > 100 then -- Humanoid max speed is ~16
                        return true, string.format("Suspicious speed: %.2f studs/second", speed)
                    end
                end
                
                table.insert(history, {pos = arg, time = log.Timestamp})
                if #history > 5 then
                    table.remove(history, 1)
                end
            end
        end
    end
    return false
end)

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 5: DATA EXPORT
-- ═══════════════════════════════════════════════════════════════

-- Export to JSON
local jsonData = RemoteSpy.DataStore:Export("JSON")
print("Exported JSON:", jsonData)

-- Copy to clipboard
setclipboard(jsonData)
print("Data copied to clipboard!")

-- Export to CSV
local csvData = RemoteSpy.DataStore:Export("CSV")
writefile("RemoteSpy_Log.csv", csvData)
print("Saved to RemoteSpy_Log.csv")

-- Export only flagged events
local flaggedExport = {
    Version = RemoteSpy.Version,
    ExportDate = os.date(),
    FlaggedEvents = RemoteSpy.DataStore.DetectedExploits
}
writefile("FlaggedEvents.json", game:GetService("HttpService"):JSONEncode(flaggedExport))

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 6: CALL REPLAY
-- ═══════════════════════════════════════════════════════════════

-- Replay the last call
local lastLog = RemoteSpy.DataStore.Logs[#RemoteSpy.DataStore.Logs]
if lastLog then
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(lastLog.RemoteName, true)
    if remote and remote:IsA("RemoteEvent") then
        print("Replaying:", lastLog.RemoteName)
        remote:FireServer(unpack(lastLog.Args))
    end
end

-- Replay all damage calls
for _, log in ipairs(RemoteSpy.DataStore.Logs) do
    if log.RemoteName:match("Damage") then
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild(log.RemoteName, true)
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(unpack(log.Args))
            wait(0.1) -- Small delay between calls
        end
    end
end

-- Stress test a remote
local function stressTest(remoteName, args, count)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName, true)
    if not remote then
        warn("Remote not found:", remoteName)
        return
    end
    
    print(string.format("Stress testing %s with %d calls...", remoteName, count))
    for i = 1, count do
        remote:FireServer(unpack(args))
        if i % 100 == 0 then
            print(string.format("Progress: %d/%d", i, count))
            wait() -- Yield to prevent timeout
        end
    end
    print("Stress test complete!")
end

-- Usage
stressTest("DamageRemote", {10, "sword"}, 1000)

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 7: STATISTICS & ANALYSIS
-- ═══════════════════════════════════════════════════════════════

-- Get top 5 most called remotes
local remoteCounts = {}
for _, log in ipairs(RemoteSpy.DataStore.Logs) do
    remoteCounts[log.RemoteName] = (remoteCounts[log.RemoteName] or 0) + 1
end

local sorted = {}
for name, count in pairs(remoteCounts) do
    table.insert(sorted, {name = name, count = count})
end

table.sort(sorted, function(a, b) return a.count > b.count end)

print("Top 5 Most Called Remotes:")
for i = 1, math.min(5, #sorted) do
    print(string.format("%d. %s: %d calls", i, sorted[i].name, sorted[i].count))
end

-- Calculate average calls per second
local totalTime = (RemoteSpy.DataStore.Logs[#RemoteSpy.DataStore.Logs].Timestamp - 
                   RemoteSpy.DataStore.Logs[1].Timestamp) / 1000
local avgCPS = #RemoteSpy.DataStore.Logs / totalTime
print(string.format("Average CPS: %.2f", avgCPS))

-- Find suspicious patterns
local suspiciousRemotes = {}
for _, log in ipairs(RemoteSpy.DataStore.Logs) do
    if RemoteSpy.DataStore.DetectedExploits[log.ID] then
        suspiciousRemotes[log.RemoteName] = (suspiciousRemotes[log.RemoteName] or 0) + 1
    end
end

if next(suspiciousRemotes) then
    print("\n⚠️ Suspicious Remotes:")
    for name, count in pairs(suspiciousRemotes) do
        print(string.format("  - %s: %d flagged calls", name, count))
    end
end

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 8: REAL-TIME MONITORING
-- ═══════════════════════════════════════════════════════════════

-- Monitor specific remote in real-time
local function monitorRemote(remoteName, callback)
    local lastCount = 0
    
    game:GetService("RunService").Heartbeat:Connect(function()
        local currentCount = 0
        for _, log in ipairs(RemoteSpy.DataStore.Logs) do
            if log.RemoteName == remoteName then
                currentCount = currentCount + 1
            end
        end
        
        if currentCount > lastCount then
            local newLogs = {}
            for i = #RemoteSpy.DataStore.Logs - (currentCount - lastCount) + 1, #RemoteSpy.DataStore.Logs do
                if RemoteSpy.DataStore.Logs[i].RemoteName == remoteName then
                    table.insert(newLogs, RemoteSpy.DataStore.Logs[i])
                end
            end
            
            callback(newLogs)
            lastCount = currentCount
        end
    end)
end

-- Usage
monitorRemote("DamageRemote", function(newLogs)
    for _, log in ipairs(newLogs) do
        print("New damage call detected:", log.SerializedArgs)
    end
end)

-- Alert on suspicious activity
local function alertOnExploit()
    local lastCheck = 0
    
    game:GetService("RunService").Heartbeat:Connect(function()
        local exploitCount = #RemoteSpy.DataStore.DetectedExploits
        
        if exploitCount > lastCheck then
            local newExploits = exploitCount - lastCheck
            warn(string.format("⚠️ WARNING: %d new exploit(s) detected!", newExploits))
            
            -- Play alert sound (if supported)
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9114397506" -- Alert sound
            sound.Volume = 0.5
            sound.Parent = game:GetService("SoundService")
            sound:Play()
            sound.Ended:Connect(function() sound:Destroy() end)
            
            lastCheck = exploitCount
        end
    end)
end

alertOnExploit()

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 9: CUSTOM UI THEMES
-- ═══════════════════════════════════════════════════════════════

-- Create a custom theme
RemoteSpy.Themes.Custom = {
    Background = Color3.fromRGB(30, 30, 30),
    Secondary = Color3.fromRGB(45, 45, 45),
    Accent = Color3.fromRGB(255, 100, 200),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Success = Color3.fromRGB(100, 255, 100),
    Warning = Color3.fromRGB(255, 200, 50),
    Danger = Color3.fromRGB(255, 50, 50),
    Border = Color3.fromRGB(60, 60, 60)
}

-- Apply the theme
RemoteSpy.Config.UI.Theme = "Custom"
RemoteSpy.UI.CurrentTheme = RemoteSpy.Themes.Custom

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 10: INTEGRATION WITH OTHER SCRIPTS
-- ═══════════════════════════════════════════════════════════════

-- Share data with external script
_G.RemoteSpyData = RemoteSpy.DataStore.Logs

-- External script can now access:
-- local logs = _G.RemoteSpyData

-- Create webhook integration
local function sendToWebhook(url, data)
    local HttpService = game:GetService("HttpService")
    
    local payload = {
        content = "Remote Spy Report",
        embeds = {
            {
                title = "📊 Remote Spy Statistics",
                description = string.format("Total Calls: %d\nFlagged: %d", 
                    #data.Logs, 
                    #data.DetectedExploits),
                color = 5814783,
                timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
            }
        }
    }
    
    local success, result = pcall(function()
        return HttpService:PostAsync(url, HttpService:JSONEncode(payload), 
            Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        print("✅ Webhook sent successfully!")
    else
        warn("❌ Failed to send webhook:", result)
    end
end

-- Usage (Discord webhook)
sendToWebhook("YOUR_DISCORD_WEBHOOK_URL", RemoteSpy.DataStore)

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 11: PERFORMANCE OPTIMIZATION
-- ═══════════════════════════════════════════════════════════════

-- For high-traffic games, optimize performance
RemoteSpy.Config.Capture.SamplingRate = 50 -- Only capture 50% of calls
RemoteSpy.Config.Capture.MaxBuffer = 5000 -- Reduce buffer size
RemoteSpy.Config.Capture.DeepCopy = false -- Disable deep copying
RemoteSpy.Config.Performance.LazyLoad = true -- Enable lazy loading

-- Clear old logs periodically
spawn(function()
    while wait(60) do -- Every minute
        if #RemoteSpy.DataStore.Logs > 5000 then
            print("Cleaning old logs...")
            local toRemove = #RemoteSpy.DataStore.Logs - 5000
            for i = 1, toRemove do
                table.remove(RemoteSpy.DataStore.Logs, 1)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
--              EXAMPLE 12: DEBUGGING TOOLS
-- ═══════════════════════════════════════════════════════════════

-- Find all remotes in game
local function findAllRemotes()
    local remotes = {}
    
    local function scan(parent)
        for _, child in ipairs(parent:GetDescendants()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                table.insert(remotes, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Type = child.ClassName
                })
            end
        end
    end
    
    scan(game:GetService("ReplicatedStorage"))
    scan(game:GetService("ReplicatedFirst"))
    
    return remotes
end

local allRemotes = findAllRemotes()
print("Found", #allRemotes, "remotes in game:")
for _, remote in ipairs(allRemotes) do
    print(string.format("  - %s (%s): %s", remote.Name, remote.Type, remote.Path))
end

-- Test if a remote exists
local function testRemote(remoteName)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName, true)
    if remote then
        print("✅ Remote found:", remote:GetFullName())
        print("   Type:", remote.ClassName)
        return true
    else
        warn("❌ Remote not found:", remoteName)
        return false
    end
end

testRemote("DamageRemote")

print("\n✅ All examples loaded! Check the code above for usage.")
