--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║           ULTIMATE REMOTE SPY v3.0.0 - FIXED                 ║
    ║              The Most Advanced Remote Monitor                 ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    Press K to toggle UI
]]

-- ═══════════════════════════════════════════════════════════════
--                         SERVICES
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
--                         CONFIGURATION
-- ═══════════════════════════════════════════════════════════════

local Config = {
    ToggleKey = Enum.KeyCode.K,
    Theme = "Dark",
    MaxLogs = 500,
    AutoScroll = true,
    ShowTimestamp = true,
    DetectExploits = true
}

-- ═══════════════════════════════════════════════════════════════
--                         THEMES
-- ═══════════════════════════════════════════════════════════════

local Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 35),
        Secondary = Color3.fromRGB(40, 40, 45),
        Tertiary = Color3.fromRGB(50, 50, 55),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(150, 150, 150),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Danger = Color3.fromRGB(240, 71, 71),
        Border = Color3.fromRGB(60, 60, 65)
    }
}

local CurrentTheme = Themes[Config.Theme]

-- ═══════════════════════════════════════════════════════════════
--                         DATA STORAGE
-- ═══════════════════════════════════════════════════════════════

local Logs = {}
local Stats = {
    TotalCalls = 0,
    ClientToServer = 0,
    ServerToClient = 0,
    Flagged = 0
}

-- ═══════════════════════════════════════════════════════════════
--                         UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function SerializeValue(value, depth)
    depth = depth or 0
    if depth > 5 then return "..." end
    
    local valueType = typeof(value)
    
    if valueType == "string" then
        return string.format('"%s"', value:sub(1, 50))
    elseif valueType == "number" then
        return tostring(value)
    elseif valueType == "boolean" then
        return tostring(value)
    elseif valueType == "nil" then
        return "nil"
    elseif valueType == "Instance" then
        return value:GetFullName()
    elseif valueType == "Vector3" then
        return string.format("Vector3(%d, %d, %d)", value.X, value.Y, value.Z)
    elseif valueType == "CFrame" then
        return "CFrame(...)"
    elseif valueType == "Color3" then
        return string.format("Color3(%d, %d, %d)", value.R*255, value.G*255, value.B*255)
    elseif valueType == "table" then
        local items = {}
        local count = 0
        for k, v in pairs(value) do
            count = count + 1
            if count > 3 then
                table.insert(items, "...")
                break
            end
            table.insert(items, string.format("%s = %s", tostring(k), SerializeValue(v, depth + 1)))
        end
        return "{" .. table.concat(items, ", ") .. "}"
    else
        return tostring(valueType)
    end
end

local function FormatArgs(args)
    if not args or #args == 0 then return "no args" end
    
    local formatted = {}
    for i, arg in ipairs(args) do
        table.insert(formatted, SerializeValue(arg))
    end
    return table.concat(formatted, ", ")
end

local function GetTimestamp()
    return os.date("%H:%M:%S")
end

-- ═══════════════════════════════════════════════════════════════
--                         LOGGING SYSTEM
-- ═══════════════════════════════════════════════════════════════

local function AddLog(remoteName, direction, args, flagged)
    local log = {
        Remote = remoteName,
        Direction = direction,
        Args = args,
        FormattedArgs = FormatArgs(args),
        Timestamp = GetTimestamp(),
        Time = tick(),
        Flagged = flagged or false
    }
    
    table.insert(Logs, log)
    
    -- Keep only last N logs
    if #Logs > Config.MaxLogs then
        table.remove(Logs, 1)
    end
    
    -- Update stats
    Stats.TotalCalls = Stats.TotalCalls + 1
    if direction == "→" then
        Stats.ClientToServer = Stats.ClientToServer + 1
    else
        Stats.ServerToClient = Stats.ServerToClient + 1
    end
    if flagged then
        Stats.Flagged = Stats.Flagged + 1
    end
    
    return log
end

local function ClearLogs()
    Logs = {}
    Stats.TotalCalls = 0
    Stats.ClientToServer = 0
    Stats.ServerToClient = 0
    Stats.Flagged = 0
end

-- ═══════════════════════════════════════════════════════════════
--                         EXPLOIT DETECTION
-- ═══════════════════════════════════════════════════════════════

local CallHistory = {}

local function CheckExploit(remoteName, args)
    -- Track call frequency
    CallHistory[remoteName] = CallHistory[remoteName] or {}
    local history = CallHistory[remoteName]
    
    table.insert(history, tick())
    
    -- Keep only last 20 calls
    if #history > 20 then
        table.remove(history, 1)
    end
    
    -- Check if more than 10 calls in 1 second
    if #history >= 10 then
        local firstTime = history[#history - 9]
        local lastTime = history[#history]
        if (lastTime - firstTime) < 1 then
            return true -- Suspicious rapid calls
        end
    end
    
    -- Check for impossible values
    for _, arg in ipairs(args) do
        if type(arg) == "number" then
            if arg == math.huge or arg ~= arg or math.abs(arg) > 1e15 then
                return true -- Impossible value
            end
        end
    end
    
    return false
end

-- ═══════════════════════════════════════════════════════════════
--                         HOOKING ENGINE
-- ═══════════════════════════════════════════════════════════════

local HookedRemotes = {}

local function HookRemote(remote)
    if HookedRemotes[remote] then return end
    HookedRemotes[remote] = true
    
    if remote:IsA("RemoteEvent") then
        -- Hook FireServer
        local oldFireServer = remote.FireServer
        remote.FireServer = function(self, ...)
            local args = {...}
            local flagged = Config.DetectExploits and CheckExploit(remote.Name, args)
            AddLog(remote.Name, "→", args, flagged)
            return oldFireServer(self, ...)
        end
        
        -- Hook OnClientEvent
        remote.OnClientEvent:Connect(function(...)
            local args = {...}
            AddLog(remote.Name, "←", args, false)
        end)
    elseif remote:IsA("RemoteFunction") then
        -- Hook InvokeServer
        local oldInvokeServer = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            local args = {...}
            local flagged = Config.DetectExploits and CheckExploit(remote.Name, args)
            AddLog(remote.Name, "→", args, flagged)
            return oldInvokeServer(self, ...)
        end
    end
end

local function FindAndHookRemotes()
    local function scanContainer(container)
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                HookRemote(obj)
            end
        end
        
        container.DescendantAdded:Connect(function(obj)
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                task.wait(0.1)
                HookRemote(obj)
            end
        end)
    end
    
    scanContainer(game:GetService("ReplicatedStorage"))
    scanContainer(game:GetService("ReplicatedFirst"))
    
    print("[RemoteSpy] Hooked all remotes")
end

-- ═══════════════════════════════════════════════════════════════
--                         UI CREATION
-- ═══════════════════════════════════════════════════════════════

local ScreenGui
local MainFrame
local LogsContainer
local SearchBox
local StatsLabel

local function CreateUI()
    -- Clean up old UI
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    -- Create ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RemoteSpyUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Protection
    local success = pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    
    if not success then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 800, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
    MainFrame.BackgroundColor3 = CurrentTheme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = CurrentTheme.Border
    MainStroke.Thickness = 2
    MainStroke.Parent = MainFrame
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = CurrentTheme.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔍 REMOTE SPY v3.0"
    Title.TextColor3 = CurrentTheme.Text
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Stats Label
    StatsLabel = Instance.new("TextLabel")
    StatsLabel.Name = "Stats"
    StatsLabel.Size = UDim2.new(0, 300, 1, 0)
    StatsLabel.Position = UDim2.new(1, -315, 0, 0)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.Text = "Calls: 0 | Flagged: 0"
    StatsLabel.TextColor3 = CurrentTheme.TextDark
    StatsLabel.TextSize = 12
    StatsLabel.Font = Enum.Font.Gotham
    StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
    StatsLabel.Parent = TopBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = CurrentTheme.Danger
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    
    -- Search Bar
    local SearchFrame = Instance.new("Frame")
    SearchFrame.Name = "SearchFrame"
    SearchFrame.Size = UDim2.new(1, -20, 0, 35)
    SearchFrame.Position = UDim2.new(0, 10, 0, 50)
    SearchFrame.BackgroundColor3 = CurrentTheme.Tertiary
    SearchFrame.BorderSizePixel = 0
    SearchFrame.Parent = MainFrame
    
    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 6)
    SearchCorner.Parent = SearchFrame
    
    SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBox"
    SearchBox.Size = UDim2.new(1, -170, 1, -10)
    SearchBox.Position = UDim2.new(0, 10, 0, 5)
    SearchBox.BackgroundTransparency = 1
    SearchBox.PlaceholderText = "🔍 Search remotes..."
    SearchBox.PlaceholderColor3 = CurrentTheme.TextDark
    SearchBox.Text = ""
    SearchBox.TextColor3 = CurrentTheme.Text
    SearchBox.TextSize = 13
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.ClearTextOnFocus = false
    SearchBox.Parent = SearchFrame
    
    -- Clear Button
    local ClearButton = Instance.new("TextButton")
    ClearButton.Name = "ClearButton"
    ClearButton.Size = UDim2.new(0, 70, 1, -10)
    ClearButton.Position = UDim2.new(1, -150, 0, 5)
    ClearButton.BackgroundColor3 = CurrentTheme.Warning
    ClearButton.Text = "Clear"
    ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClearButton.TextSize = 13
    ClearButton.Font = Enum.Font.GothamMedium
    ClearButton.BorderSizePixel = 0
    ClearButton.Parent = SearchFrame
    
    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, 6)
    ClearCorner.Parent = ClearButton
    
    ClearButton.MouseButton1Click:Connect(function()
        ClearLogs()
        UpdateLogDisplay()
    end)
    
    -- Export Button
    local ExportButton = Instance.new("TextButton")
    ExportButton.Name = "ExportButton"
    ExportButton.Size = UDim2.new(0, 70, 1, -10)
    ExportButton.Position = UDim2.new(1, -75, 0, 5)
    ExportButton.BackgroundColor3 = CurrentTheme.Success
    ExportButton.Text = "Export"
    ExportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExportButton.TextSize = 13
    ExportButton.Font = Enum.Font.GothamMedium
    ExportButton.BorderSizePixel = 0
    ExportButton.Parent = SearchFrame
    
    local ExportCorner = Instance.new("UICorner")
    ExportCorner.CornerRadius = UDim.new(0, 6)
    ExportCorner.Parent = ExportButton
    
    ExportButton.MouseButton1Click:Connect(function()
        local data = HttpService:JSONEncode({
            Logs = Logs,
            Stats = Stats,
            ExportTime = os.date()
        })
        if setclipboard then
            setclipboard(data)
            print("[RemoteSpy] Exported to clipboard!")
        else
            print(data)
        end
    end)
    
    -- Logs Container
    local LogsFrame = Instance.new("Frame")
    LogsFrame.Name = "LogsFrame"
    LogsFrame.Size = UDim2.new(1, -20, 1, -105)
    LogsFrame.Position = UDim2.new(0, 10, 0, 95)
    LogsFrame.BackgroundColor3 = CurrentTheme.Tertiary
    LogsFrame.BorderSizePixel = 0
    LogsFrame.Parent = MainFrame
    
    local LogsFrameCorner = Instance.new("UICorner")
    LogsFrameCorner.CornerRadius = UDim.new(0, 6)
    LogsFrameCorner.Parent = LogsFrame
    
    LogsContainer = Instance.new("ScrollingFrame")
    LogsContainer.Name = "LogsContainer"
    LogsContainer.Size = UDim2.new(1, -10, 1, -10)
    LogsContainer.Position = UDim2.new(0, 5, 0, 5)
    LogsContainer.BackgroundTransparency = 1
    LogsContainer.BorderSizePixel = 0
    LogsContainer.ScrollBarThickness = 6
    LogsContainer.ScrollBarImageColor3 = CurrentTheme.Accent
    LogsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    LogsContainer.Parent = LogsFrame
    
    local LogsLayout = Instance.new("UIListLayout")
    LogsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LogsLayout.Padding = UDim.new(0, 5)
    LogsLayout.Parent = LogsContainer
    
    LogsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        LogsContainer.CanvasSize = UDim2.new(0, 0, 0, LogsLayout.AbsoluteContentSize.Y + 10)
        if Config.AutoScroll then
            LogsContainer.CanvasPosition = Vector2.new(0, LogsContainer.AbsoluteCanvasSize.Y)
        end
    end)
    
    MainFrame.Visible = false
end

-- ═══════════════════════════════════════════════════════════════
--                         LOG DISPLAY
-- ═══════════════════════════════════════════════════════════════

local function CreateLogEntry(log, index)
    local LogEntry = Instance.new("Frame")
    LogEntry.Name = "LogEntry" .. index
    LogEntry.Size = UDim2.new(1, -10, 0, 70)
    LogEntry.BackgroundColor3 = CurrentTheme.Secondary
    LogEntry.BorderSizePixel = 0
    LogEntry.LayoutOrder = index
    
    local LogCorner = Instance.new("UICorner")
    LogCorner.CornerRadius = UDim.new(0, 6)
    LogCorner.Parent = LogEntry
    
    -- Direction indicator
    local directionColor = log.Direction == "→" and CurrentTheme.Warning or CurrentTheme.Success
    local directionSymbol = log.Direction == "→" and "↗️" or "↙️"
    
    local DirectionBar = Instance.new("Frame")
    DirectionBar.Size = UDim2.new(0, 4, 1, 0)
    DirectionBar.BackgroundColor3 = directionColor
    DirectionBar.BorderSizePixel = 0
    DirectionBar.Parent = LogEntry
    
    local DirCorner = Instance.new("UICorner")
    DirCorner.CornerRadius = UDim.new(0, 6)
    DirCorner.Parent = DirectionBar
    
    -- Remote name
    local RemoteName = Instance.new("TextLabel")
    RemoteName.Size = UDim2.new(1, -120, 0, 20)
    RemoteName.Position = UDim2.new(0, 15, 0, 5)
    RemoteName.BackgroundTransparency = 1
    RemoteName.Text = directionSymbol .. " " .. log.Remote
    RemoteName.TextColor3 = CurrentTheme.Text
    RemoteName.TextSize = 14
    RemoteName.Font = Enum.Font.GothamBold
    RemoteName.TextXAlignment = Enum.TextXAlignment.Left
    RemoteName.TextTruncate = Enum.TextTruncate.AtEnd
    RemoteName.Parent = LogEntry
    
    -- Timestamp
    local Timestamp = Instance.new("TextLabel")
    Timestamp.Size = UDim2.new(0, 100, 0, 20)
    Timestamp.Position = UDim2.new(1, -105, 0, 5)
    Timestamp.BackgroundTransparency = 1
    Timestamp.Text = log.Timestamp
    Timestamp.TextColor3 = CurrentTheme.TextDark
    Timestamp.TextSize = 11
    Timestamp.Font = Enum.Font.Gotham
    Timestamp.TextXAlignment = Enum.TextXAlignment.Right
    Timestamp.Parent = LogEntry
    
    -- Args
    local ArgsLabel = Instance.new("TextLabel")
    ArgsLabel.Size = UDim2.new(1, -20, 0, 40)
    ArgsLabel.Position = UDim2.new(0, 15, 0, 28)
    ArgsLabel.BackgroundTransparency = 1
    ArgsLabel.Text = log.FormattedArgs
    ArgsLabel.TextColor3 = CurrentTheme.TextDark
    ArgsLabel.TextSize = 11
    ArgsLabel.Font = Enum.Font.Code
    ArgsLabel.TextXAlignment = Enum.TextXAlignment.Left
    ArgsLabel.TextYAlignment = Enum.TextYAlignment.Top
    ArgsLabel.TextWrapped = true
    ArgsLabel.TextTruncate = Enum.TextTruncate.AtEnd
    ArgsLabel.Parent = LogEntry
    
    -- Flagged indicator
    if log.Flagged then
        local FlagLabel = Instance.new("TextLabel")
        FlagLabel.Size = UDim2.new(0, 70, 0, 18)
        FlagLabel.Position = UDim2.new(1, -75, 0, 28)
        FlagLabel.BackgroundColor3 = CurrentTheme.Danger
        FlagLabel.Text = "⚠ FLAGGED"
        FlagLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        FlagLabel.TextSize = 10
        FlagLabel.Font = Enum.Font.GothamBold
        FlagLabel.BorderSizePixel = 0
        FlagLabel.Parent = LogEntry
        
        local FlagCorner = Instance.new("UICorner")
        FlagCorner.CornerRadius = UDim.new(0, 4)
        FlagCorner.Parent = FlagLabel
    end
    
    return LogEntry
end

function UpdateLogDisplay()
    -- Clear existing logs
    for _, child in ipairs(LogsContainer:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Apply search filter
    local searchTerm = SearchBox.Text:lower()
    local filteredLogs = {}
    
    for i, log in ipairs(Logs) do
        if searchTerm == "" or log.Remote:lower():find(searchTerm, 1, true) then
            table.insert(filteredLogs, log)
        end
    end
    
    -- Create log entries (show last 100)
    local startIndex = math.max(1, #filteredLogs - 99)
    for i = startIndex, #filteredLogs do
        local logEntry = CreateLogEntry(filteredLogs[i], i)
        logEntry.Parent = LogsContainer
    end
    
    -- Update stats
    if StatsLabel then
        StatsLabel.Text = string.format("Calls: %d | C→S: %d | S→C: %d | Flagged: %d",
            Stats.TotalCalls,
            Stats.ClientToServer,
            Stats.ServerToClient,
            Stats.Flagged
        )
    end
end

-- ═══════════════════════════════════════════════════════════════
--                         INPUT HANDLING
-- ═══════════════════════════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Config.ToggleKey then
        if MainFrame then
            MainFrame.Visible = not MainFrame.Visible
            if MainFrame.Visible then
                UpdateLogDisplay()
            end
        end
    end
end)

SearchBox.Changed:Connect(function(property)
    if property == "Text" then
        UpdateLogDisplay()
    end
end)

-- ═══════════════════════════════════════════════════════════════
--                         AUTO UPDATE
-- ═══════════════════════════════════════════════════════════════

local lastUpdate = tick()
RunService.Heartbeat:Connect(function()
    if MainFrame and MainFrame.Visible and (tick() - lastUpdate) > 0.5 then
        lastUpdate = tick()
        UpdateLogDisplay()
    end
end)

-- ═══════════════════════════════════════════════════════════════
--                         INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

print("╔═══════════════════════════════════════════════════════════════╗")
print("║           ULTIMATE REMOTE SPY v3.0.0                         ║")
print("║              Press K to toggle UI                            ║")
print("╚═══════════════════════════════════════════════════════════════╝")

CreateUI()
FindAndHookRemotes()

-- Test logs
task.wait(1)
AddLog("TestRemote", "→", {"arg1", "arg2", 123}, false)
AddLog("AnotherRemote", "←", {Vector3.new(0, 10, 0)}, false)

print("[RemoteSpy] ✅ Ready! Press K to toggle UI")

return {
    ToggleUI = function()
        if MainFrame then
            MainFrame.Visible = not MainFrame.Visible
        end
    end,
    ClearLogs = ClearLogs,
    GetLogs = function() return Logs end,
    GetStats = function() return Stats end
}
