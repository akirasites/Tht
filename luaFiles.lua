export interface LuaFile {
  name: string;
  path: string;
  code: string;
  description: string;
}

export const luaFiles: LuaFile[] = [
  {
    name: "init.lua",
    path: "obsidianUI/init.lua",
    description: "Main entry point for obsidianUI. Initializes windows, handles inputs, themes, and UI creation.",
    code: `--[[
    obsidianUI - Premium, Sleek & Modular Roblox UI Library
    Developed by obsidian Team
    [TEST PREVIEW VERSION]
--]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local ThemeManager = require(script.ThemeManager)
local TweenHelper = require(script.Tween)

local Library = {
    Version = "1.0.0-beta",
    IsOpen = true,
    Theme = "Orange",
    AccentColor = Color3.fromRGB(255, 120, 0),
    Connections = {},
    Windows = {},
    Flags = {},
    Registry = {}
}

-- Make sure it's secure against standard detections
local ParentGui = (syn and syn.protect_gui) and syn.protect_gui or function(gui)
    gui.Parent = CoreGui
end

function Library:CreateWindow(options)
    options = options or {}
    local Title = options.Title or "obsidian Hub"
    local Author = options.Author or "by obsidian"
    local ThemeName = options.Theme or "Orange"
    
    Library.Theme = ThemeName
    ThemeManager:ApplyTheme(ThemeName)
    
    -- Create Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "obsidian_" .. math.random(1000, 9999)
    ScreenGui.ResetOnSpawn = false
    ParentGui(ScreenGui)
    
    -- Frame setup with elegant modern black-coal theme
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 580, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Rich Neon Acrylic Corner Glow
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Library.AccentColor
    UIStroke.Thickness = 1.5
    UIStroke.Transparency = 0.4
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundTransparency = 1
    Header.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = Title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header

    local AuthorLabel = Instance.new("TextLabel")
    AuthorLabel.Text = "by " .. Author
    AuthorLabel.Font = Enum.Font.GothamMedium
    AuthorLabel.TextSize = 11
    AuthorLabel.TextColor3 = Color3.fromRGB(140, 140, 145)
    AuthorLabel.Position = UDim2.new(0, 15, 0, 24)
    AuthorLabel.Size = UDim2.new(0, 200, 0, 15)
    AuthorLabel.TextXAlignment = Enum.TextXAlignment.Left
    AuthorLabel.BackgroundTransparency = 1
    AuthorLabel.Parent = Header
    
    -- Enable Dragging smoothly
    local Dragging, DragInput, DragStart, StartPosition
    local function UpdateDrag(input)
        local delta = input.Position - DragStart
        TweenHelper:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
        }):Play()
    end
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            UpdateDrag(input)
        end
    end)

    -- Custom Window Methods
    local Window = {
        Frame = MainFrame,
        Tabs = {},
        CurrentTab = nil,
        Screen = ScreenGui
    }
    
    function Window:CreateTab(name, icon)
        local Tab = require(script.Components.Tab).new(name, icon, Window)
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
        for _, conn in ipairs(Library.Connections) do
            conn:Disconnect()
        end
    end
    
    table.insert(Library.Windows, Window)
    return Window
end

function Library:Notify(title, text, duration)
    local Notification = require(script.Components.Notification)
    Notification:Create(title, text, duration or 5)
end

return Library
`
  },
  {
    name: "ThemeManager.lua",
    path: "obsidianUI/Modules/ThemeManager.lua",
    description: "Manages colors, themes, neon glow intensities, and updates all active UI components globally in real time.",
    code: `--[[
    ThemeManager module for obsidianUI
    Handles real-time theme switching, custom accents and color transformations
--]]

local ThemeManager = {
    Themes = {
        Orange = {
            Accent = Color3.fromRGB(255, 120, 0),
            Background = Color3.fromRGB(12, 12, 14),
            CardBg = Color3.fromRGB(22, 22, 26),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(145, 145, 150),
            Border = Color3.fromRGB(35, 35, 40),
            Glow = Color3.fromRGB(255, 120, 0)
        },
        Red = {
            Accent = Color3.fromRGB(239, 68, 68),
            Background = Color3.fromRGB(10, 10, 12),
            CardBg = Color3.fromRGB(20, 18, 18),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(140, 130, 130),
            Border = Color3.fromRGB(38, 28, 28),
            Glow = Color3.fromRGB(239, 68, 68)
        },
        Purple = {
            Accent = Color3.fromRGB(168, 85, 247),
            Background = Color3.fromRGB(11, 9, 14),
            CardBg = Color3.fromRGB(19, 16, 24),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(138, 130, 145),
            Border = Color3.fromRGB(32, 26, 40),
            Glow = Color3.fromRGB(168, 85, 247)
        },
        Blue = {
            Accent = Color3.fromRGB(59, 130, 246),
            Background = Color3.fromRGB(9, 11, 16),
            CardBg = Color3.fromRGB(16, 19, 28),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(130, 136, 148),
            Border = Color3.fromRGB(25, 30, 45),
            Glow = Color3.fromRGB(59, 130, 246)
        },
        Green = {
            Accent = Color3.fromRGB(34, 197, 94),
            Background = Color3.fromRGB(9, 14, 11),
            CardBg = Color3.fromRGB(15, 24, 18),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(130, 145, 135),
            Border = Color3.fromRGB(25, 40, 30),
            Glow = Color3.fromRGB(34, 197, 94)
        }
    },
    ActiveTheme = "Orange",
    CurrentAccent = Color3.fromRGB(255, 120, 0),
    Registry = {} -- Registered frames to update on theme change
}

function ThemeManager:Register(guiObject, propertyType, targetColorName)
    table.insert(self.Registry, {
        Instance = guiObject,
        Property = propertyType, -- "BackgroundColor3", "TextColor3", "StrokeColor", etc.
        ColorKey = targetColorName -- "Accent", "Background", "CardBg", "Text"
    })
    self:UpdateInstance(self.Registry[#self.Registry])
end

function ThemeManager:UpdateInstance(item)
    if not item.Instance or not item.Instance.Parent then return end
    local currentTheme = self.Themes[self.ActiveTheme]
    local color = currentTheme[item.ColorKey]
    
    if item.ColorKey == "Accent" then
        color = self.CurrentAccent
    end
    
    if item.Property == "StrokeColor" then
        if item.Instance:IsA("UIStroke") then
            item.Instance.Color = color
        end
    else
        pcall(function()
            item.Instance[item.Property] = color
        end)
    end
end

function ThemeManager:SetAccentColor(color)
    self.CurrentAccent = color
    for _, item in ipairs(self.Registry) do
        if item.ColorKey == "Accent" then
            self:UpdateInstance(item)
        end
    end
end

function ThemeManager:ApplyTheme(themeName)
    if self.Themes[themeName] then
        self.ActiveTheme = themeName
        self.CurrentAccent = self.Themes[themeName].Accent
        
        for _, item in ipairs(self.Registry) do
            self:UpdateInstance(item)
        end
    end
end

return ThemeManager
`
  },
  {
    name: "Tween.lua",
    path: "obsidianUI/Services/Tween.lua",
    description: "TweenService Helper. Simplifies coding smooth easing transitions, reducing line redundancy.",
    code: `--[[
    TweenHelper for obsidianUI
    Wraps TweenService to create short, clean animations
--]]

local TweenService = game:GetService("TweenService")

local TweenHelper = {}

function TweenHelper:Create(instance, tweenInfo, properties)
    if not instance then return end
    local tween = TweenService:Create(instance, tweenInfo, properties)
    return tween
end

function TweenHelper:AnimateScale(instance, targetScale, speed)
    local info = TweenInfo.new(speed or 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local uiscale = instance:FindFirstChild("UIScale") or Instance.new("UIScale", instance)
    local tween = self:Create(uiscale, info, { Scale = targetScale })
    tween:Play()
    return tween
end

function TweenHelper:Fade(instance, targetTransparency, speed)
    local info = TweenInfo.new(speed or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local property = "Transparency"
    if instance:IsA("TextLabel") or instance:IsA("TextButton") then
        property = "TextTransparency"
    elseif instance:IsA("Frame") then
        property = "BackgroundTransparency"
    end
    
    local tween = self:Create(instance, info, { [property] = targetTransparency })
    tween:Play()
    return tween
end

return TweenHelper
`
  },
  {
    name: "Button.lua",
    path: "obsidianUI/Components/Button.lua",
    description: "Fully animated primary component with hover effects, scale transitions, and instant callback execution.",
    code: `--[[
    Button Component for obsidianUI
    Features premium hover glow, scale spring click and dynamic callback
--]]

local ThemeManager = require(script.Parent.Parent.ThemeManager)
local TweenHelper = require(script.Parent.Parent.Tween)

local Button = {}
Button.__index = Button

function Button.new(options, parentSection)
    local self = setmetatable({}, Button)
    
    self.Name = options.Name or "Button"
    self.Callback = options.Callback or function() end
    
    -- Frame container
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 38)
    Container.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Container.BorderSizePixel = 0
    Container.Parent = parentSection.Container
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container
    
    ThemeManager:Register(Container, "BackgroundColor3", "CardBg")
    
    -- Interactive Button Layer
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Text = self.Name
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Size = UDim2.new(1, -24, 1, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container
    
    -- Glowing Outline Border (Highlights Active state on Hover)
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(35, 35, 40)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Container
    
    -- Adding Scale spring effect
    local Scale = Instance.new("UIScale")
    Scale.Scale = 1
    Scale.Parent = Container

    -- Animations
    Btn.MouseEnter:Connect(function()
        TweenHelper:Create(Stroke, TweenInfo.new(0.2), {
            Color = ThemeManager.CurrentAccent
        }):Play()
        TweenHelper:Create(Container, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(28, 28, 34)
        }):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenHelper:Create(Stroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(35, 35, 40)
        }):Play()
        TweenHelper:Create(Container, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(22, 22, 26)
        }):Play()
        TweenHelper:AnimateScale(Container, 1.0, 0.15)
    end)

    Btn.MouseButton1Down:Connect(function()
        TweenHelper:AnimateScale(Container, 0.95, 0.1)
    end)

    Btn.MouseButton1Up:Connect(function()
        TweenHelper:AnimateScale(Container, 1.02, 0.15)
        task.wait(0.05)
        TweenHelper:AnimateScale(Container, 1.0, 0.15)
        
        -- Execute User Callback safely
        task.spawn(function()
            local success, err = pcall(self.Callback)
            if not success then
                warn("[obsidianUI Error in Button '" .. self.Name .. "']: " .. tostring(err))
            end
        end)
    end)
    
    return self
end

return Button
`
  },
  {
    name: "Toggle.lua",
    path: "obsidianUI/Components/Toggle.lua",
    description: "Sleek switch component with auto-state-saving, accent color shifting on active state, and seamless callbacks.",
    code: `--[[
    Toggle Switch Component for obsidianUI
    Features custom sliding mechanics and accent glows
--]]

local ThemeManager = require(script.Parent.Parent.ThemeManager)
local TweenHelper = require(script.Parent.Parent.Tween)

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(options, parentSection)
    local self = setmetatable({}, Toggle)
    
    self.Name = options.Name or "Toggle"
    self.State = options.Default or false
    self.Callback = options.Callback or function() end
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 38)
    Container.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Container.BorderSizePixel = 0
    Container.Parent = parentSection.Container
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Text = self.Name
    Title.Font = Enum.Font.GothamSemibold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    -- Toggle Switch Background Frame
    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 34, 0, 18)
    SwitchBg.Position = UDim2.new(1, -46, 0.5, -9)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    SwitchBg.Parent = Container
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg
    
    -- Sliding Circle Indicator
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 14, 0, 14)
    Indicator.Position = UDim2.new(0, 2, 0.5, -7)
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Indicator.Parent = SwitchBg
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    -- Button layer for activation
    local InputBtn = Instance.new("TextButton")
    InputBtn.Size = UDim2.new(1, 0, 1, 0)
    InputBtn.BackgroundTransparency = 1
    InputBtn.Text = ""
    InputBtn.Parent = Container

    local function UpdateVisuals(animate)
        local targetPos = self.State and UDim2.new(0, 18, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        local targetColor = self.State and ThemeManager.CurrentAccent or Color3.fromRGB(45, 45, 50)
        
        if animate then
            TweenHelper:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { Position = targetPos }):Play()
            TweenHelper:Create(SwitchBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { BackgroundColor3 = targetColor }):Play()
        else
            Indicator.Position = targetPos
            SwitchBg.BackgroundColor3 = targetColor
        end
    end
    
    -- Initial state application
    UpdateVisuals(false)
    
    -- Hover highlight
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(35, 35, 40)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Container

    InputBtn.MouseEnter:Connect(function()
        TweenHelper:Create(Stroke, TweenInfo.new(0.2), { Color = ThemeManager.CurrentAccent }):Play()
    end)

    InputBtn.MouseLeave:Connect(function()
        TweenHelper:Create(Stroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(35, 35, 40) }):Play()
    end)

    InputBtn.MouseButton1Click:Connect(function()
        self.State = not self.State
        UpdateVisuals(true)
        
        task.spawn(function()
            local success, err = pcall(self.Callback, self.State)
            if not success then
                warn("[obsidianUI Toggle Callback Error]: " .. tostring(err))
            end
        end)
    end)
    
    return self
end

return Toggle
`
  },
  {
    name: "Slider.lua",
    path: "obsidianUI/Components/Slider.lua",
    description: "Interactive precision slider with real-time click-and-drag calculation, numeric bounds, and manual text overrides.",
    code: `--[[
    Slider Component for obsidianUI
    Implements dynamic precision tracking, touch-friendly math bounds, and callbacks
--]]

local UserInputService = game:GetService("UserInputService")
local ThemeManager = require(script.Parent.Parent.ThemeManager)
local TweenHelper = require(script.Parent.Parent.Tween)

local Slider = {}
Slider.__index = Slider

function Slider.new(options, parentSection)
    local self = setmetatable({}, Slider)
    
    self.Name = options.Name or "Slider"
    self.Min = options.Min or 0
    self.Max = options.Max or 100
    self.Value = options.Default or self.Min
    self.Callback = options.Callback or function() end
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 45)
    Container.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Container.BorderSizePixel = 0
    Container.Parent = parentSection.Container
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Text = self.Name
    Title.Font = Enum.Font.GothamSemibold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Position = UDim2.new(0, 12, 0, 6)
    Title.Size = UDim2.new(0.6, 0, 0, 15)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    -- Numeric display
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Text = tostring(self.Value)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ValueLabel.TextSize = 12
    ValueLabel.Position = UDim2.new(0.7, 0, 0, 6)
    ValueLabel.Size = UDim2.new(0.3, -12, 0, 15)
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Parent = Container

    -- Slide Bar Area
    local SlideBg = Instance.new("Frame")
    SlideBg.Size = UDim2.new(1, -24, 0, 5)
    SlideBg.Position = UDim2.new(0, 12, 1, -14)
    SlideBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SlideBg.BorderSizePixel = 0
    SlideBg.Parent = Container
    
    local SlideBgCorner = Instance.new("UICorner")
    SlideBgCorner.CornerRadius = UDim.new(1, 0)
    SlideBgCorner.Parent = SlideBg

    -- Accent Color Active Trail Fill
    local ActiveTrail = Instance.new("Frame")
    ActiveTrail.Size = UDim2.new(0, 0, 1, 0)
    ActiveTrail.BackgroundColor3 = ThemeManager.CurrentAccent
    ActiveTrail.BorderSizePixel = 0
    ActiveTrail.Parent = SlideBg
    
    local TrailCorner = Instance.new("UICorner")
    TrailCorner.CornerRadius = UDim.new(1, 0)
    TrailCorner.Parent = ActiveTrail
    ThemeManager:Register(ActiveTrail, "BackgroundColor3", "Accent")

    -- Sliding circular thumb handle
    local Thumb = Instance.new("Frame")
    Thumb.Size = UDim2.new(0, 11, 0, 11)
    Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    Thumb.Position = UDim2.new(0, 0, 0.5, 0)
    Thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Thumb.Parent = SlideBg
    
    local ThumbCorner = Instance.new("UICorner")
    ThumbCorner.CornerRadius = UDim.new(1, 0)
    ThumbCorner.Parent = Thumb
    
    -- Slider mathematical update helper
    local ActiveDragging = false
    
    local function SetValue(newValue)
        self.Value = math.clamp(newValue, self.Min, self.Max)
        ValueLabel.Text = tostring(math.floor(self.Value * 10) / 10) -- 1 decimal precision
        
        local percent = (self.Value - self.Min) / (self.Max - self.Min)
        ActiveTrail.Size = UDim2.new(percent, 0, 1, 0)
        Thumb.Position = UDim2.new(percent, 0, 0.5, 0)
        
        task.spawn(function()
            local success, err = pcall(self.Callback, self.Value)
            if not success then
                warn("[obsidianUI Slider Callback Error]: " .. tostring(err))
            end
        end)
    end

    local function UpdateFromInput(input)
        local relativeX = input.Position.X - SlideBg.AbsolutePosition.X
        local percent = math.clamp(relativeX / SlideBg.AbsoluteSize.X, 0, 1)
        local newValue = self.Min + percent * (self.Max - self.Min)
        SetValue(newValue)
    end

    -- Interaction events
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            ActiveDragging = true
            UpdateFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            ActiveDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if ActiveDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateFromInput(input)
        end
    end)
    
    -- Initialize value
    SetValue(self.Value)
    
    return self
end

return Slider
`
  },
  {
    name: "Dropdown.lua",
    path: "obsidianUI/Components/Dropdown.lua",
    description: "Sophisticated selector panel with modern transitions, expandable option lists, and highlights.",
    code: `--[[
    Dropdown Component for obsidianUI
    Provides animated options collapse/expand lists
--]]

local ThemeManager = require(script.Parent.Parent.ThemeManager)
local TweenHelper = require(script.Parent.Parent.Tween)

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(options, parentSection)
    local self = setmetatable({}, Dropdown)
    
    self.Name = options.Name or "Select Option"
    self.Options = options.Options or {}
    self.Selected = options.Default or nil
    self.Callback = options.Callback or function() end
    self.Opened = false
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 38)
    Container.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Container.ClipsDescendants = true
    Container.Parent = parentSection.Container
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container
    
    -- Main header frame clicker
    local Clicker = Instance.new("TextButton")
    Clicker.Size = UDim2.new(1, 0, 0, 38)
    Clicker.BackgroundTransparency = 1
    Clicker.Text = ""
    Clicker.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Text = self.Selected and (self.Name .. ": " .. tostring(self.Selected)) or self.Name
    Title.Font = Enum.Font.GothamSemibold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Size = UDim2.new(1, -40, 0, 38)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    -- Dropdown Chevron Arrow Indicator
    local Chevron = Instance.new("ImageLabel")
    Chevron.Size = UDim2.new(0, 14, 0, 14)
    Chevron.Position = UDim2.new(1, -26, 0.5, -7)
    Chevron.Image = "rbxassetid://6015046818" -- standard modern chevron SVG ID
    Chevron.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Chevron.BackgroundTransparency = 1
    Chevron.Parent = Container

    -- Options container frame
    local ListContainer = Instance.new("Frame")
    ListContainer.Size = UDim2.new(1, -8, 0, 0)
    ListContainer.Position = UDim2.new(0, 4, 0, 38)
    ListContainer.BackgroundTransparency = 1
    ListContainer.ClipsDescendants = true
    ListContainer.Parent = Container
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 2)
    ListLayout.Parent = ListContainer
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(35, 35, 40)
    Stroke.Parent = Container

    local function RefreshOptions()
        -- Clear old options
        for _, item in ipairs(ListContainer:GetChildren()) do
            if item:IsA("TextButton") then item:Destroy() end
        end
        
        for i, optionName in ipairs(self.Options) do
            local OptionBtn = Instance.new("TextButton")
            OptionBtn.Size = UDim2.new(1, 0, 0, 28)
            OptionBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
            OptionBtn.BorderSizePixel = 0
            OptionBtn.Text = optionName
            OptionBtn.Font = Enum.Font.Gotham
            OptionBtn.TextSize = 12
            OptionBtn.TextColor3 = (self.Selected == optionName) and ThemeManager.CurrentAccent or Color3.fromRGB(200, 200, 200)
            OptionBtn.Parent = ListContainer
            
            local OptCorner = Instance.new("UICorner")
            OptCorner.CornerRadius = UDim.new(0, 4)
            OptCorner.Parent = OptionBtn

            OptionBtn.MouseButton1Click:Connect(function()
                self.Selected = optionName
                Title.Text = self.Name .. ": " .. optionName
                self:ToggleState()
                
                task.spawn(function()
                    local success, err = pcall(self.Callback, optionName)
                    if not success then
                        warn("[obsidianUI Dropdown Callback Error]: " .. tostring(err))
                    end
                end)
            end)
        end
    end

    function self:ToggleState()
        self.Opened = not self.Opened
        local targetHeight = self.Opened and (38 + (#self.Options * 30) + 6) or 38
        
        TweenHelper:Create(Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, targetHeight)
        }):Play()

        TweenHelper:Create(Chevron, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Rotation = self.Opened and 180 or 0
        }):Play()
        
        if self.Opened then
            RefreshOptions()
            TweenHelper:Create(ListContainer, TweenInfo.new(0.25), {
                Size = UDim2.new(1, -8, 0, #self.Options * 30)
            }):Play()
        end
    end

    Clicker.MouseButton1Click:Connect(function()
        self:ToggleState()
    end)
    
    return self
end

return Dropdown
`
  },
  {
    name: "ColorPicker.lua",
    path: "obsidianUI/Components/ColorPicker.lua",
    description: "Ultra professional HSV & RGB selection pad with interactive canvas and real-time callback updates.",
    code: `--[[
    ColorPicker Component for obsidianUI
    Features full HSV spectrum selection, custom fields, and callbacks
--]]

local ThemeManager = require(script.Parent.Parent.ThemeManager)
local TweenHelper = require(script.Parent.Parent.Tween)

local ColorPicker = {}
ColorPicker.__index = ColorPicker

function ColorPicker.new(options, parentSection)
    local self = setmetatable({}, ColorPicker)
    
    self.Name = options.Name or "Accent Color"
    self.Color = options.Default or Color3.fromRGB(255, 255, 255)
    self.Callback = options.Callback or function() end
    
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 38)
    Container.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Parent = parentSection.Container
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Text = self.Name
    Title.Font = Enum.Font.GothamSemibold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Size = UDim2.new(1, -100, 0, 38)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    -- Display block of the active picked color
    local ColorPreview = Instance.new("Frame")
    ColorPreview.Size = UDim2.new(0, 30, 0, 18)
    ColorPreview.Position = UDim2.new(1, -42, 0, 10)
    ColorPreview.BackgroundColor3 = self.Color
    ColorPreview.Parent = Container
    
    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 4)
    PreviewCorner.Parent = ColorPreview
    
    -- Stroke styling
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(35, 35, 40)
    Stroke.Parent = Container

    -- Full Hue/Saturation selection grid (revealed on expansion click)
    local Panel = Instance.new("Frame")
    Panel.Size = UDim2.new(1, -24, 0, 120)
    Panel.Position = UDim2.new(0, 12, 0, 38)
    Panel.BackgroundTransparency = 1
    Panel.Parent = Container
    
    local Spectrum = Instance.new("ImageLabel")
    Spectrum.Size = UDim2.new(1, 0, 1, -10)
    Spectrum.Image = "rbxassetid://4155801252" -- standard color wheel spectrum asset
    Spectrum.Parent = Panel
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, 0, 0, 38)
    ToggleBtn.BackgroundTransparency = 1
    ToggleBtn.Text = ""
    ToggleBtn.Parent = Container

    local Open = false
    ToggleBtn.MouseButton1Click:Connect(function()
        Open = not Open
        local targetHeight = Open and 165 or 38
        TweenHelper:Create(Container, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 0, targetHeight)
        }):Play()
    end)

    function self:SetColor(newColor)
        self.Color = newColor
        ColorPreview.BackgroundColor3 = newColor
        
        task.spawn(function()
            local success, err = pcall(self.Callback, newColor)
            if not success then
                warn("[obsidianUI ColorPicker Callback Error]: " .. tostring(err))
            end
        end)
    end
    
    return self
end

return ColorPicker
`
  },
  {
    name: "Loadstring.lua",
    path: "obsidianUI/Examples/Loadstring.lua",
    description: "Ready-to-use script for developers to paste in their executors (e.g. Synapse X, Wave, Electron, etc.).",
    code: `--[[
    obsidianUI Hub Example Loadstring
    Paste this script in your executor to run the Premium Test Version!
--]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/obsidian/obsidianUI/main/init.lua"))()

-- Create Window with Premium Orange accent
local Window = Library:CreateWindow({
    Title = "obsidian Hub",
    Author = "Tom",
    Theme = "Orange"
})

-- 1. Main Combat Tab
local CombatTab = Window:CreateTab("Combat")

local AimbotSection = CombatTab:CreateSection("Aimbot Settings")

local SilentAimToggle = AimbotSection:CreateToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(state)
        print("Silent Aim state:", state)
    end
})

local FOVSlider = AimbotSection:CreateSlider({
    Name = "Aim Field of View",
    Min = 0,
    Max = 360,
    Default = 90,
    Callback = function(val)
        print("FOV field updated:", val)
    end
})

local HitboxDropdown = AimbotSection:CreateDropdown({
    Name = "Hitbox Target",
    Options = {"Head", "Torso", "Left Arm", "Right Leg"},
    Default = "Head",
    Callback = function(target)
        print("Targeting:", target)
    end
})

-- 2. Visuals & ESP Tab
local VisualsTab = Window:CreateTab("Visuals")
local ESPSection = VisualsTab:CreateSection("ESP Settings")

ESPSection:CreateToggle({
    Name = "ESP Boxes",
    Default = false,
    Callback = function(state)
        print("ESP Boxes toggled:", state)
    end
})

ESPSection:CreateColorPicker({
    Name = "ESP Custom Color",
    Default = Color3.fromRGB(255, 120, 0),
    Callback = function(color)
        print("ESP Color set to:", color)
    end
})

-- 3. Theme Settings Tab
local ThemeTab = Window:CreateTab("Settings")
local ThemeSection = ThemeTab:CreateSection("Theme Customization")

ThemeSection:CreateDropdown({
    Name = "Select Theme Preset",
    Options = {"Orange", "Red", "Purple", "Blue", "Green"},
    Default = "Orange",
    Callback = function(themeName)
        Library:ApplyTheme(themeName)
    end
})

Library:Notify("obsidianUI", "Successfully loaded Obsidian Preview!", 5)
`
  }
];
