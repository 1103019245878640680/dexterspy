--[[
    ═══════════════════════════════════════════════════════════════
                ULTIMATE REMOTE SPY - ADVANCED CONFIG
    ═══════════════════════════════════════════════════════════════
    
    This file contains advanced configuration options for power users.
    Copy and modify these settings to customize your Remote Spy.
]]

local AdvancedConfig = {
    
    -- ═══════════════════════════════════════════════════════════
    --                    UI CUSTOMIZATION
    -- ═══════════════════════════════════════════════════════════
    
    UI = {
        -- Window Settings
        WindowSize = UDim2.new(0, 1000, 0, 700),
        DefaultPosition = UDim2.new(0.5, -500, 0.5, -350),
        MinSize = UDim2.new(0, 600, 0, 400),
        MaxSize = UDim2.new(0, 1920, 0, 1080),
        
        -- Keybinds
        ToggleKey = Enum.KeyCode.K,
        SearchKey = Enum.KeyCode.F,
        ClearKey = Enum.KeyCode.C,
        ExportKey = Enum.KeyCode.E,
        RefreshKey = Enum.KeyCode.R,
        
        -- Visual Settings
        Theme = "Dark", -- Dark, Light, Midnight, Ocean, Custom
        Transparency = 0.05,
        BlurBackground = true,
        RoundedCorners = true,
        CornerRadius = 12,
        Animations = true,
        AnimationSpeed = 0.3,
        SmoothScrolling = true,
        
        -- Font Settings
        FontFamily = Enum.Font.Gotham,
        TitleFontSize = 16,
        TextFontSize = 12,
        CodeFontSize = 11,
        
        -- Colors (can override theme)
        CustomColors = {
            -- Background = Color3.fromRGB(25, 25, 30),
            -- Accent = Color3.fromRGB(88, 101, 242),
            -- etc...
        },
        
        -- Layout
        ShowTopBar = true,
        ShowStatusBar = true,
        ShowLineNumbers = true,
        CompactMode = false,
        
        -- Performance
        MaxVisibleLogs = 100,
        VirtualScrolling = true,
        LazyRender = true,
        UpdateInterval = 0.1, -- seconds
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    CAPTURE SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Capture = {
        -- Mode: "Full", "Selective", "Smart", "Burst"
        Mode = "Full",
        
        -- Buffer Settings
        MaxBuffer = 10000,
        RingBuffer = true, -- Overwrite oldest when full
        AutoSave = false,
        SaveInterval = 300, -- seconds
        
        -- Sampling
        SamplingRate = 100, -- Percentage (1-100)
        AdaptiveSampling = false, -- Reduce rate under load
        
        -- Capture Options
        AutoStart = true,
        CaptureDirection = "Both", -- Both, ClientToServer, ServerToClient
        CaptureReturn = true,
        CaptureStack = true,
        CaptureMetadata = true,
        DeepCopy = true,
        MaxDepth = 10, -- For deep copy
        
        -- Filtering (whitelist/blacklist)
        UseWhitelist = false,
        Whitelist = {
            -- "RemoteName1",
            -- "RemoteName2",
        },
        UseBlacklist = false,
        Blacklist = {
            -- "IgnoreThisRemote",
        },
        
        -- Advanced
        HookPriority = 1,
        CaptureBindables = true,
        CaptureUnreliable = true,
        TrackCoroutines = true,
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    PERFORMANCE SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Performance = {
        -- Limits
        MaxCallsPerSecond = 1000,
        MaxMemoryUsage = 100 * 1024 * 1024, -- 100MB
        ThrottleThreshold = 800, -- Start throttling at this CPS
        
        -- Optimization
        UseCompression = true,
        CompressionLevel = 6, -- 1-9
        LazyLoad = true,
        BackgroundProcessing = true,
        DeferredSerialization = true,
        
        -- Memory Management
        AutoGarbageCollect = true,
        GCInterval = 60, -- seconds
        MemoryWarningThreshold = 0.8, -- 80% of max
        
        -- CPU Management
        YieldInterval = 100, -- Process X logs then yield
        MaxProcessingTime = 0.016, -- Max time per frame (60fps)
        
        -- Caching
        CacheSerializedValues = true,
        CacheRemotePaths = true,
        CacheSize = 1000,
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    SECURITY SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Security = {
        -- Detection
        DetectExploits = true,
        AutoFlag = true,
        FlagThreshold = 0.7, -- Confidence threshold (0-1)
        
        -- Protection
        AntiUnhook = true,
        AntiTamper = true,
        VerifyIntegrity = true,
        IntegrityCheckInterval = 30, -- seconds
        
        -- Honeypots
        CreateHoneypots = false,
        HoneypotCount = 5,
        HoneypotNames = {
            "GetPlayerData",
            "AdminCommand",
            "GiveCurrency",
            "SetValue",
            "Debug",
        },
        
        -- Pattern Detection
        EnableSpeedCheck = true,
        SpeedThreshold = 100, -- studs/second
        EnableValueCheck = true,
        MaxAllowedValue = 1e10,
        EnableFrequencyCheck = true,
        FrequencyThreshold = 20, -- calls/second per remote
        
        -- Actions
        AutoKick = false,
        AutoBan = false,
        LogToConsole = true,
        SendWebhook = false,
        WebhookURL = "",
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    EXPORT SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Export = {
        -- Format: "JSON", "CSV", "XML", "MessagePack"
        DefaultFormat = "JSON",
        
        -- Options
        PrettyPrint = true,
        IncludeMetadata = true,
        IncludeStatistics = true,
        IncludeConfig = false,
        Compress = true,
        
        -- Limits
        MaxFileSize = 50 * 1024 * 1024, -- 50MB
        SplitLargeExports = true,
        
        -- File Naming
        FileNameTemplate = "RemoteSpy_%DATE%_%TIME%.%FORMAT%",
        DateFormat = "%Y%m%d",
        TimeFormat = "%H%M%S",
        
        -- Auto Export
        AutoExport = false,
        AutoExportInterval = 600, -- seconds
        AutoExportFormat = "JSON",
        AutoExportPath = "RemoteSpy/Exports/",
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    LOGGING SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Logging = {
        -- Console Logging
        LogToConsole = true,
        LogLevel = "Info", -- Debug, Info, Warning, Error
        ColoredOutput = true,
        
        -- File Logging
        LogToFile = false,
        LogFilePath = "RemoteSpy/Logs/",
        MaxLogFileSize = 10 * 1024 * 1024, -- 10MB
        RotateLogs = true,
        MaxLogFiles = 5,
        
        -- Remote Logging
        RemoteLogging = false,
        RemoteEndpoint = "",
        BatchRemoteLogs = true,
        RemoteBatchSize = 100,
        
        -- Debug Options
        DebugMode = false,
        VerboseLogging = false,
        TraceHooks = false,
        ProfilePerformance = false,
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    NOTIFICATION SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Notifications = {
        -- General
        Enabled = true,
        Position = "TopRight", -- TopRight, TopLeft, BottomRight, BottomLeft
        Duration = 3, -- seconds
        
        -- Types
        ShowInfo = true,
        ShowWarnings = true,
        ShowErrors = true,
        ShowExploitAlerts = true,
        
        -- Sounds
        PlaySounds = true,
        SoundVolume = 0.5,
        SoundIds = {
            Info = "rbxassetid://9914397506",
            Warning = "rbxassetid://9914397506",
            Error = "rbxassetid://9914397506",
            Exploit = "rbxassetid://9914397506",
        },
        
        -- Rate Limiting
        MaxNotificationsPerMinute = 10,
        GroupSimilar = true,
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    INTEGRATION SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Integration = {
        -- Webhooks
        Discord = {
            Enabled = false,
            WebhookURL = "",
            SendInterval = 60, -- seconds
            IncludeStatistics = true,
            IncludeFlagged = true,
            RichEmbeds = true,
        },
        
        -- APIs
        CustomAPI = {
            Enabled = false,
            Endpoint = "",
            APIKey = "",
            Method = "POST",
            Headers = {},
        },
        
        -- Database
        Database = {
            Enabled = false,
            Type = "SQLite", -- SQLite, MySQL, PostgreSQL
            ConnectionString = "",
            TablePrefix = "remotepy_",
        },
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    EXPERIMENTAL FEATURES
    -- ═══════════════════════════════════════════════════════════
    
    Experimental = {
        -- Machine Learning
        MachineLearning = {
            Enabled = false,
            ModelPath = "",
            TrainingMode = false,
            AutoTrain = false,
            TrainingInterval = 3600, -- seconds
        },
        
        -- Replay System
        Replay = {
            Enabled = false,
            RecordActions = false,
            MaxReplayBuffer = 1000,
        },
        
        -- Prediction
        Prediction = {
            Enabled = false,
            PredictNextCall = false,
            PredictionConfidence = 0.8,
        },
        
        -- Network Analysis
        NetworkAnalysis = {
            Enabled = false,
            BuildCallGraph = false,
            DetectBottlenecks = false,
        },
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    PLUGIN SETTINGS
    -- ═══════════════════════════════════════════════════════════
    
    Plugins = {
        Enabled = true,
        AutoLoad = true,
        PluginDirectory = "RemoteSpy/Plugins/",
        Sandboxed = true,
        AllowedAPIs = {
            "DataStore",
            "Utils",
            "HookEngine",
        },
    },
    
    -- ═══════════════════════════════════════════════════════════
    --                    DEVELOPER OPTIONS
    -- ═══════════════════════════════════════════════════════════
    
    Developer = {
        DevMode = false,
        ShowDebugInfo = false,
        EnableHotReload = false,
        ExposeAPI = false,
        AllowRemoteControl = false,
        CustomScriptPath = "",
    },
}

-- ═══════════════════════════════════════════════════════════════
--                    PRESET CONFIGURATIONS
-- ═══════════════════════════════════════════════════════════════

AdvancedConfig.Presets = {
    -- High Performance (minimal logging, maximum speed)
    HighPerformance = {
        Capture = {
            SamplingRate = 50,
            DeepCopy = false,
            CaptureStack = false,
            MaxBuffer = 5000,
        },
        Performance = {
            UseCompression = false,
            LazyLoad = true,
            BackgroundProcessing = true,
        },
        UI = {
            UpdateInterval = 0.5,
            MaxVisibleLogs = 50,
            Animations = false,
        },
    },
    
    -- Maximum Detail (capture everything)
    MaxDetail = {
        Capture = {
            SamplingRate = 100,
            DeepCopy = true,
            CaptureStack = true,
            CaptureMetadata = true,
            MaxBuffer = 50000,
        },
        Security = {
            DetectExploits = true,
            EnableSpeedCheck = true,
            EnableValueCheck = true,
            EnableFrequencyCheck = true,
        },
    },
    
    -- Security Focus (maximum detection)
    SecurityFocus = {
        Security = {
            DetectExploits = true,
            AutoFlag = true,
            CreateHoneypots = true,
            EnableSpeedCheck = true,
            EnableValueCheck = true,
            EnableFrequencyCheck = true,
        },
        Notifications = {
            ShowExploitAlerts = true,
            PlaySounds = true,
        },
    },
    
    -- Minimal (basic logging only)
    Minimal = {
        Capture = {
            Mode = "Selective",
            SamplingRate = 25,
            DeepCopy = false,
            CaptureStack = false,
            MaxBuffer = 1000,
        },
        Security = {
            DetectExploits = false,
        },
        UI = {
            CompactMode = true,
            Animations = false,
        },
    },
}

-- ═══════════════════════════════════════════════════════════════
--                    VALIDATION & HELPERS
-- ═══════════════════════════════════════════════════════════════

function AdvancedConfig:Validate()
    -- Validate configuration values
    assert(self.Capture.SamplingRate >= 1 and self.Capture.SamplingRate <= 100, 
        "SamplingRate must be between 1 and 100")
    assert(self.Capture.MaxBuffer > 0, "MaxBuffer must be positive")
    assert(self.Performance.MaxCallsPerSecond > 0, "MaxCallsPerSecond must be positive")
    
    return true
end

function AdvancedConfig:ApplyPreset(presetName)
    local preset = self.Presets[presetName]
    if not preset then
        warn("Preset not found:", presetName)
        return false
    end
    
    -- Deep merge preset into config
    local function merge(target, source)
        for k, v in pairs(source) do
            if type(v) == "table" and type(target[k]) == "table" then
                merge(target[k], v)
            else
                target[k] = v
            end
        end
    end
    
    merge(self, preset)
    print("Applied preset:", presetName)
    return true
end

function AdvancedConfig:Save(filename)
    filename = filename or "RemoteSpyConfig.lua"
    local HttpService = game:GetService("HttpService")
    local data = HttpService:JSONEncode(self)
    writefile(filename, data)
    print("Configuration saved to:", filename)
end

function AdvancedConfig:Load(filename)
    filename = filename or "RemoteSpyConfig.lua"
    if not isfile(filename) then
        warn("Configuration file not found:", filename)
        return false
    end
    
    local HttpService = game:GetService("HttpService")
    local data = readfile(filename)
    local loaded = HttpService:JSONDecode(data)
    
    for k, v in pairs(loaded) do
        self[k] = v
    end
    
    print("Configuration loaded from:", filename)
    return true
end

-- ═══════════════════════════════════════════════════════════════
--                    USAGE EXAMPLES
-- ═══════════════════════════════════════════════════════════════

--[[
-- Apply a preset
AdvancedConfig:ApplyPreset("HighPerformance")

-- Modify specific settings
AdvancedConfig.UI.Theme = "Ocean"
AdvancedConfig.Security.DetectExploits = true

-- Validate config
AdvancedConfig:Validate()

-- Save config
AdvancedConfig:Save("MyConfig.lua")

-- Load config
AdvancedConfig:Load("MyConfig.lua")
]]

return AdvancedConfig
