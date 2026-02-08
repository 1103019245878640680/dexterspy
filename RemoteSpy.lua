--[[ 
    ULTIMATE REMOTE SPY – CLEAN & WORKING
    Keybind : K
    Stable | Fast | No UI Lag
]]

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

-- CONFIG
local TOGGLE_KEY = Enum.KeyCode.K
local MAX_LOGS = 300

-- DATA
local Logs = {}
local Stats = {
    Total = 0,
    C2S = 0,
    S2C = 0
}

-- UI VARS
local ScreenGui, Main, List, SearchBox, StatsLabel
local UI_VISIBLE = false

-- ===================== UTILS =====================

local function serialize(v, d)
    d = d or 0
    if d > 4 then return "..." end

    if typeof(v) == "string" then
        return '"' .. v:sub(1, 60) .. '"'
    elseif typeof(v) == "number" or typeof(v) == "boolean" then
        return tostring(v)
    elseif typeof(v) == "Instance" then
        return v:GetFullName()
    elseif typeof(v) == "Vector3" then
        return ("Vector3(%d,%d,%d)"):format(v.X, v.Y, v.Z)
    elseif typeof(v) == "table" then
        local t = {}
        local c = 0
        for k,val in pairs(v) do
            c += 1
            if c > 3 then break end
            table.insert(t, tostring(k).."="..serialize(val,d+1))
        end
        return "{"..table.concat(t,", ").."}"
    end
    return typeof(v)
end

local function formatArgs(args)
    local t = {}
    for _,v in ipairs(args) do
        table.insert(t, serialize(v))
    end
    return #t > 0 and table.concat(t,", ") or "no args"
end

-- ===================== LOG SYSTEM =====================

local function addLog(remote, dir, args)
    Stats.Total += 1
    if dir == "→" then Stats.C2S += 1 else Stats.S2C += 1 end

    table.insert(Logs, {
        Remote = remote,
        Dir = dir,
        Args = formatArgs(args),
        Time = os.date("%H:%M:%S")
    })

    if #Logs > MAX_LOGS then
        table.remove(Logs, 1)
    end
end

-- ===================== UI =====================

local function createUI()
    ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.ResetOnSpawn = false

    Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(750, 450)
    Main.Position = UDim2.fromScale(0.5,0.5) - UDim2.fromOffset(375,225)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
    Main.Visible = false
    Main.Active = true
    Main.Draggable = true

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

    local top = Instance.new("TextLabel", Main)
    top.Size = UDim2.new(1,0,0,40)
    top.Text = "🔍 Ultimate Remote Spy"
    top.Font = Enum.Font.GothamBold
    top.TextSize = 16
    top.TextColor3 = Color3.new(1,1,1)
    top.BackgroundColor3 = Color3.fromRGB(35,35,40)

    SearchBox = Instance.new("TextBox", Main)
    SearchBox.Size = UDim2.new(1,-20,0,30)
    SearchBox.Position = UDim2.fromOffset(10,50)
    SearchBox.PlaceholderText = "Search remote..."
    SearchBox.Text = ""
    SearchBox.BackgroundColor3 = Color3.fromRGB(40,40,45)
    SearchBox.TextColor3 = Color3.new(1,1,1)

    List = Instance.new("ScrollingFrame", Main)
    List.Position = UDim2.fromOffset(10,90)
    List.Size = UDim2.new(1,-20,1,-130)
    List.CanvasSize = UDim2.new(0,0,0,0)
    List.ScrollBarThickness = 6
    List.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", List)
    layout.Padding = UDim.new(0,6)

    StatsLabel = Instance.new("TextLabel", Main)
    StatsLabel.Size = UDim2.new(1,0,0,30)
    StatsLabel.Position = UDim2.new(0,0,1,-30)
    StatsLabel.TextColor3 = Color3.fromRGB(170,170,170)
    StatsLabel.BackgroundTransparency = 1
end

local function refreshUI()
    for _,v in ipairs(List:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    local filter = SearchBox.Text:lower()

    for _,log in ipairs(Logs) do
        if filter == "" or log.Remote:lower():find(filter,1,true) then
            local f = Instance.new("Frame", List)
            f.Size = UDim2.new(1,0,0,55)
            f.BackgroundColor3 = Color3.fromRGB(35,35,40)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)

            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1,-10,1,-10)
            t.Position = UDim2.fromOffset(5,5)
            t.BackgroundTransparency = 1
            t.TextWrapped = true
            t.TextXAlignment = Left
            t.TextYAlignment = Top
            t.TextSize = 12
            t.Font = Enum.Font.Code
            t.TextColor3 = Color3.new(1,1,1)
            t.Text = string.format("[%s] %s %s\n%s", log.Time, log.Dir, log.Remote, log.Args)
        end
    end

    StatsLabel.Text = ("Calls: %d | C→S: %d | S→C: %d"):format(
        Stats.Total, Stats.C2S, Stats.S2C
    )
end

-- ===================== REMOTE HOOK =====================

local mt = getrawmetatable(game)
setreadonly(mt,false)

local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    local method = getnamecallmethod()
    local args = {...}

    if typeof(self) == "Instance" then
        if method == "FireServer" then
            addLog(self.Name,"→",args)
        elseif method == "InvokeServer" then
            addLog(self.Name,"→",args)
        elseif method == "FireClient" or method == "FireAllClients" then
            addLog(self.Name,"←",args)
        end
    end

    return old(self,...)
end)

setreadonly(mt,true)

-- ===================== INPUT =====================

UserInputService.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode == TOGGLE_KEY then
        UI_VISIBLE = not UI_VISIBLE
        Main.Visible = UI_VISIBLE
        if UI_VISIBLE then refreshUI() end
    end
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(refreshUI)

-- INIT
createUI()
print("[RemoteSpy] READY | Press K")
