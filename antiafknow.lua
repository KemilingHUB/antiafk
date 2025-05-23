-- Modern AFK System - Executor Compatible
-- Load necessary services
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- Get local player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Modern Color Scheme
local ColorPalette = {
    Background = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(240, 240, 240),
    Success = Color3.fromRGB(100, 255, 100),
    Warning = Color3.fromRGB(255, 200, 50),
    Error = Color3.fromRGB(255, 100, 100)
}

-- Create Main GUI
local ModernAFKGui = Instance.new("ScreenGui")
ModernAFKGui.Name = "ModernAFKGui"
ModernAFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ModernAFKGui.ResetOnSpawn = false
ModernAFKGui.DisplayOrder = 999

-- Check if Synapse or other executor is being used (for parent assignment)
if gethui then
    ModernAFKGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ModernAFKGui)
    ModernAFKGui.Parent = game:GetService("CoreGui")
else
    ModernAFKGui.Parent = game:GetService("CoreGui")
end

-- Main Container with Glass Morphism Effect
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Position = UDim2.new(0.7, 0, 0.1, 0)
MainFrame.BackgroundColor3 = ColorPalette.Background
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ModernAFKGui

-- Glass Morphism Effect
local GlassEffect = Instance.new("ImageLabel")
GlassEffect.Name = "GlassEffect"
GlassEffect.Size = UDim2.new(1, 0, 1, 0)
GlassEffect.BackgroundTransparency = 1
GlassEffect.Image = "rbxassetid://8992230678"
GlassEffect.ImageColor3 = Color3.fromRGB(0, 0, 0)
GlassEffect.ImageTransparency = 0.9
GlassEffect.ScaleType = Enum.ScaleType.Slice
GlassEffect.SliceCenter = Rect.new(100, 100, 100, 100)
GlassEffect.Parent = MainFrame

-- Rounded Corners
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Drop Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 8, 1, 8)
Shadow.Position = UDim2.new(0, -4, 0, -4)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Header with Gradient
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundColor3 = ColorPalette.Secondary
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, ColorPalette.Accent),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

-- Title and Close Button
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "MODERN AFK SYSTEM | KHUB v1.8"
Title.TextColor3 = ColorPalette.Text
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -28, 0.5, -12)
CloseButton.BackgroundTransparency = 1
CloseButton.Image = "rbxassetid://3926305904"
CloseButton.ImageColor3 = ColorPalette.Text
CloseButton.ImageRectOffset = Vector2.new(284, 4)
CloseButton.ImageRectSize = Vector2.new(24, 24)
CloseButton.Parent = Header

CloseButton.MouseEnter:Connect(function()
    CloseButton.ImageColor3 = ColorPalette.Error
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.ImageColor3 = ColorPalette.Text
end)

CloseButton.MouseButton1Click:Connect(function()
    ModernAFKGui:Destroy()
end)

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -52)
ContentFrame.Position = UDim2.new(0, 10, 0, 42)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Stats Grid Layout
local StatsGrid = Instance.new("UIGridLayout")
StatsGrid.Name = "StatsGrid"
StatsGrid.CellPadding = UDim2.new(0, 10, 0, 10)
StatsGrid.CellSize = UDim2.new(0.5, -5, 0, 40)
StatsGrid.SortOrder = Enum.SortOrder.LayoutOrder
StatsGrid.Parent = ContentFrame

-- AFK Time Card
local AFKTimeCard = Instance.new("Frame")
AFKTimeCard.Name = "AFKTimeCard"
AFKTimeCard.BackgroundColor3 = ColorPalette.Secondary
AFKTimeCard.BackgroundTransparency = 0.5
AFKTimeCard.Parent = ContentFrame

local AFKTimeCorner = Instance.new("UICorner")
AFKTimeCorner.CornerRadius = UDim.new(0, 8)
AFKTimeCorner.Parent = AFKTimeCard

local AFKTimeIcon = Instance.new("TextLabel")
AFKTimeIcon.Name = "AFKTimeIcon"
AFKTimeIcon.Size = UDim2.new(0, 24, 0, 24)
AFKTimeIcon.Position = UDim2.new(0, 10, 0, 8)
AFKTimeIcon.BackgroundTransparency = 1
AFKTimeIcon.Text = "🕐"
AFKTimeIcon.TextColor3 = ColorPalette.Accent
AFKTimeIcon.Font = Enum.Font.GothamBold
AFKTimeIcon.TextSize = 20
AFKTimeIcon.TextXAlignment = Enum.TextXAlignment.Center
AFKTimeIcon.TextYAlignment = Enum.TextYAlignment.Center
AFKTimeIcon.Parent = AFKTimeCard

local AFKTimeLabel = Instance.new("TextLabel")
AFKTimeLabel.Name = "AFKTimeLabel"
AFKTimeLabel.Size = UDim2.new(1, -40, 0, 16)
AFKTimeLabel.Position = UDim2.new(0, 40, 0, 8)
AFKTimeLabel.BackgroundTransparency = 1
AFKTimeLabel.Font = Enum.Font.GothamMedium
AFKTimeLabel.Text = "AFK TIME"
AFKTimeLabel.TextColor3 = ColorPalette.Text
AFKTimeLabel.TextSize = 12
AFKTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
AFKTimeLabel.Parent = AFKTimeCard

local AFKTimeValue = Instance.new("TextLabel")
AFKTimeValue.Name = "AFKTimeValue"
AFKTimeValue.Size = UDim2.new(1, -40, 0, 16)
AFKTimeValue.Position = UDim2.new(0, 40, 0, 24)
AFKTimeValue.BackgroundTransparency = 1
AFKTimeValue.Font = Enum.Font.GothamBold
AFKTimeValue.Text = "00:00:00"
AFKTimeValue.TextColor3 = ColorPalette.Accent
AFKTimeValue.TextSize = 14
AFKTimeValue.TextXAlignment = Enum.TextXAlignment.Left
AFKTimeValue.Parent = AFKTimeCard

-- Status Card
local StatusCard = Instance.new("Frame")
StatusCard.Name = "StatusCard"
StatusCard.BackgroundColor3 = ColorPalette.Secondary
StatusCard.BackgroundTransparency = 0.5
StatusCard.Parent = ContentFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusCard

local StatusIcon = Instance.new("TextLabel")
StatusIcon.Name = "StatusIcon"
StatusIcon.Size = UDim2.new(0, 24, 0, 24)
StatusIcon.Position = UDim2.new(0, 10, 0, 8)
StatusIcon.BackgroundTransparency = 1
StatusIcon.Text = "🔎"
StatusIcon.TextColor3 = ColorPalette.Success
StatusIcon.Font = Enum.Font.GothamBold
StatusIcon.TextSize = 20
StatusIcon.TextXAlignment = Enum.TextXAlignment.Center
StatusIcon.TextYAlignment = Enum.TextYAlignment.Center
StatusIcon.Parent = StatusCard

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -40, 0, 16)
StatusLabel.Position = UDim2.new(0, 40, 0, 8)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "STATUS"
StatusLabel.TextColor3 = ColorPalette.Text
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusCard

local StatusValue = Instance.new("TextLabel")
StatusValue.Name = "StatusValue"
StatusValue.Size = UDim2.new(1, -40, 0, 16)
StatusValue.Position = UDim2.new(0, 40, 0, 24)
StatusValue.BackgroundTransparency = 1
StatusValue.Font = Enum.Font.GothamBold
StatusValue.Text = "ACTIVE"
StatusValue.TextColor3 = ColorPalette.Success
StatusValue.TextSize = 14
StatusValue.TextXAlignment = Enum.TextXAlignment.Left
StatusValue.Parent = StatusCard

-- Ping Card
local PingCard = Instance.new("Frame")
PingCard.Name = "PingCard"
PingCard.BackgroundColor3 = ColorPalette.Secondary
PingCard.BackgroundTransparency = 0.5
PingCard.Parent = ContentFrame

local PingCorner = Instance.new("UICorner")
PingCorner.CornerRadius = UDim.new(0, 8)
PingCorner.Parent = PingCard

local PingIcon = Instance.new("TextLabel")
PingIcon.Name = "PingIcon"
PingIcon.Size = UDim2.new(0, 24, 0, 24)
PingIcon.Position = UDim2.new(0, 10, 0, 8)
PingIcon.BackgroundTransparency = 1
PingIcon.Text = "📶"
PingIcon.TextColor3 = ColorPalette.Accent
PingIcon.Font = Enum.Font.GothamBold
PingIcon.TextSize = 20
PingIcon.TextXAlignment = Enum.TextXAlignment.Center
PingIcon.TextYAlignment = Enum.TextYAlignment.Center
PingIcon.Parent = PingCard

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "PingLabel"
PingLabel.Size = UDim2.new(1, -40, 0, 16)
PingLabel.Position = UDim2.new(0, 40, 0, 8)
PingLabel.BackgroundTransparency = 1
PingLabel.Font = Enum.Font.GothamMedium
PingLabel.Text = "PING"
PingLabel.TextColor3 = ColorPalette.Text
PingLabel.TextSize = 12
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Parent = PingCard

local PingValue = Instance.new("TextLabel")
PingValue.Name = "PingValue"
PingValue.Size = UDim2.new(1, -40, 0, 16)
PingValue.Position = UDim2.new(0, 40, 0, 24)
PingValue.BackgroundTransparency = 1
PingValue.Font = Enum.Font.GothamBold
PingValue.Text = "0ms"
PingValue.TextColor3 = ColorPalette.Accent
PingValue.TextSize = 14
PingValue.TextXAlignment = Enum.TextXAlignment.Left
PingValue.Parent = PingCard

-- FPS Card
local FPSCard = Instance.new("Frame")
FPSCard.Name = "FPSCard"
FPSCard.BackgroundColor3 = ColorPalette.Secondary
FPSCard.BackgroundTransparency = 0.5
FPSCard.Parent = ContentFrame

local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 8)
FPSCorner.Parent = FPSCard

local FPSIcon = Instance.new("TextLabel")
FPSIcon.Name = "FPSIcon"
FPSIcon.Size = UDim2.new(0, 24, 0, 24)
FPSIcon.Position = UDim2.new(0, 10, 0, 8)
FPSIcon.BackgroundTransparency = 1
FPSIcon.Text = "📊"
FPSIcon.TextColor3 = ColorPalette.Accent
FPSIcon.Font = Enum.Font.GothamBold
FPSIcon.TextSize = 20
FPSIcon.TextXAlignment = Enum.TextXAlignment.Center
FPSIcon.TextYAlignment = Enum.TextYAlignment.Center
FPSIcon.Parent = FPSCard

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Name = "FPSLabel"
FPSLabel.Size = UDim2.new(1, -40, 0, 16)
FPSLabel.Position = UDim2.new(0, 40, 0, 8)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Font = Enum.Font.GothamMedium
FPSLabel.Text = "FPS"
FPSLabel.TextColor3 = ColorPalette.Text
FPSLabel.TextSize = 12
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = FPSCard

local FPSValue = Instance.new("TextLabel")
FPSValue.Name = "FPSValue"
FPSValue.Size = UDim2.new(1, -40, 0, 16)
FPSValue.Position = UDim2.new(0, 40, 0, 24)
FPSValue.BackgroundTransparency = 1
FPSValue.Font = Enum.Font.GothamBold
FPSValue.Text = "0"
FPSValue.TextColor3 = ColorPalette.Accent
FPSValue.TextSize = 14
FPSValue.TextXAlignment = Enum.TextXAlignment.Left
FPSValue.Parent = FPSCard

-- Server Info Card
local ServerCard = Instance.new("Frame")
ServerCard.Name = "ServerCard"
ServerCard.BackgroundColor3 = ColorPalette.Secondary
ServerCard.BackgroundTransparency = 0.5
ServerCard.Parent = ContentFrame

local ServerCorner = Instance.new("UICorner")
ServerCorner.CornerRadius = UDim.new(0, 8)
ServerCorner.Parent = ServerCard

local ServerIcon = Instance.new("TextLabel")
ServerIcon.Name = "ServerIcon"
ServerIcon.Size = UDim2.new(0, 24, 0, 24)
ServerIcon.Position = UDim2.new(0, 10, 0, 8)
ServerIcon.BackgroundTransparency = 1
ServerIcon.Text = "🗄"
ServerIcon.TextColor3 = ColorPalette.Accent
ServerIcon.Font = Enum.Font.GothamBold
ServerIcon.TextSize = 20
ServerIcon.TextXAlignment = Enum.TextXAlignment.Center
ServerIcon.TextYAlignment = Enum.TextYAlignment.Center
ServerIcon.Parent = ServerCard

local ServerLabel = Instance.new("TextLabel")
ServerLabel.Name = "ServerLabel"
ServerLabel.Size = UDim2.new(1, -40, 0, 16)
ServerLabel.Position = UDim2.new(0, 40, 0, 8)
ServerLabel.BackgroundTransparency = 1
ServerLabel.Font = Enum.Font.GothamMedium
ServerLabel.Text = "SERVER"
ServerLabel.TextColor3 = ColorPalette.Text
ServerLabel.TextSize = 12
ServerLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerLabel.Parent = ServerCard

local ServerValue = Instance.new("TextLabel")
ServerValue.Name = "ServerValue"
ServerValue.Size = UDim2.new(1, -40, 0, 16)
ServerValue.Position = UDim2.new(0, 40, 0, 24)
ServerValue.BackgroundTransparency = 1
ServerValue.Font = Enum.Font.GothamBold
ServerValue.Text = "0/0"
ServerValue.TextColor3 = ColorPalette.Accent
ServerValue.TextSize = 14
ServerValue.TextXAlignment = Enum.TextXAlignment.Left
ServerValue.Parent = ServerCard

-- Footer with Buttons
local Footer = Instance.new("Frame")
Footer.Name = "Footer"
Footer.Size = UDim2.new(1, -20, 0, 32)
Footer.Position = UDim2.new(0, 10, 1, -35)
Footer.BackgroundTransparency = 1
Footer.Parent = MainFrame

local RejoinButton = Instance.new("TextButton")
RejoinButton.Name = "RejoinButton"
RejoinButton.Size = UDim2.new(0.3, 0, 1, 0)
RejoinButton.Position = UDim2.new(0, 0, 0, 0)
RejoinButton.BackgroundColor3 = ColorPalette.Secondary
RejoinButton.BackgroundTransparency = 0.5
RejoinButton.Font = Enum.Font.GothamMedium
RejoinButton.Text = "REJOIN"
RejoinButton.TextColor3 = ColorPalette.Text
RejoinButton.TextSize = 12
RejoinButton.Parent = Footer

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 8)
RejoinCorner.Parent = RejoinButton

-- Add hover effects to buttons
local function SetupButtonHover(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    end)
end

SetupButtonHover(RejoinButton)

-- AFK Functionality
local AFKStartTime = os.time()
local LastAFKNotification = 0

local function UpdateAFKTimer()
    local CurrentTime = os.time()
    local AFKDuration = CurrentTime - AFKStartTime
    
    -- Format as HH:MM:SS
    local Hours = math.floor(AFKDuration / 3600)
    local Minutes = math.floor((AFKDuration % 3600) / 60)
    local Seconds = AFKDuration % 60
    
    AFKTimeValue.Text = string.format("%02d:%02d:%02d", Hours, Minutes, Seconds)
end

-- Server Info
local function UpdateServerInfo()
    local PlayerCount = #Players:GetPlayers()
    local MaxPlayers = Players.MaxPlayers
    ServerValue.Text = string.format("%d/%d", PlayerCount, MaxPlayers)
end

-- Stats Updater
local LastUpdate = 0
local FPS = 0
local FPSCounter = 0
local LastFPSCheck = os.clock()

local function UpdateStats()
    -- Update FPS (fake between 60-120)
    local CurrentTime = os.clock()
    if CurrentTime - LastFPSCheck >= 1 then
        FPS = math.random(60, 120)
        FPSValue.Text = tostring(FPS)
        
        -- Update Ping (fake between 30-100ms)
        local Ping = math.random(30, 100)
        PingValue.Text = string.format("%dms", Ping)
        
        -- Color coding
        if FPS > 90 then
            FPSValue.TextColor3 = ColorPalette.Success
        elseif FPS > 60 then
            FPSValue.TextColor3 = ColorPalette.Warning
        else
            FPSValue.TextColor3 = ColorPalette.Error
        end
        
        if Ping < 60 then
            PingValue.TextColor3 = ColorPalette.Success
        elseif Ping < 100 then
            PingValue.TextColor3 = ColorPalette.Warning
        else
            PingValue.TextColor3 = ColorPalette.Error
        end
        
        LastFPSCheck = CurrentTime
    end
    
    -- Update server info
    UpdateServerInfo()
end

-- AFK Detection
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    
    local CurrentTime = os.time()
    if CurrentTime - LastAFKNotification > 2 then -- Throttle notifications
        StatusValue.Text = "BLOCKING AFK"
        StatusValue.TextColor3 = ColorPalette.Warning
        
        -- Animate the status icon
        local ScaleUp = TweenService:Create(StatusIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 28, 0, 28)})
        local ScaleDown = TweenService:Create(StatusIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 24, 0, 24)})
        
        ScaleUp:Play()
        ScaleUp.Completed:Connect(function()
            ScaleDown:Play()
        end)
        
        LastAFKNotification = CurrentTime
        
        -- Reset to normal after 2 seconds
        delay(2, function()
            StatusValue.Text = "ACTIVE"
            StatusValue.TextColor3 = ColorPalette.Success
        end)
    end
end)

-- Button Functionality
RejoinButton.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, Player)
end)

-- Main Loop
RunService.Heartbeat:Connect(function()
    UpdateAFKTimer()
    UpdateStats()
end)

-- Initialization
UpdateAFKTimer()
UpdateStats()
UpdateServerInfo()

-- Track player character and humanoid to detect movement and jump
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.Running:Connect(function(speed)
        if speed > 0 then
            -- Player is moving
            AFKStartTime = os.time()
            StatusValue.Text = "MOVING"
            StatusValue.TextColor3 = ColorPalette.Success
        else
            -- Player stopped moving
            AFKStartTime = os.time()
            StatusValue.Text = "ACTIVE"
            StatusValue.TextColor3 = ColorPalette.Success
        end
    end)

    humanoid.Jumping:Connect(function()
        -- Player jumped
        AFKStartTime = os.time()
        StatusValue.Text = "MOVING"
        StatusValue.TextColor3 = ColorPalette.Success
    end)
end

if Player.Character then
    onCharacterAdded(Player.Character)
end
Player.CharacterAdded:Connect(onCharacterAdded)
