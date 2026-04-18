-- ╔══════════════════════════════════════════════════════════════╗
-- ║           PREMIUM HUB UI - CoiledTom Style                  ║
-- ║     Futuristic Dark Theme | Neon Glow | Full Components      ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ══════════════════════════════════════════════
--              CONFIGURAÇÃO DE TEMA
-- ══════════════════════════════════════════════
local Theme = {
    Background      = Color3.fromRGB(10, 10, 12),
    BackgroundAlt   = Color3.fromRGB(14, 14, 18),
    Card            = Color3.fromRGB(18, 18, 24),
    CardHover       = Color3.fromRGB(22, 22, 30),
    Border          = Color3.fromRGB(35, 35, 50),
    Accent          = Color3.fromRGB(120, 80, 255),    -- Neon roxo
    AccentSoft      = Color3.fromRGB(80, 50, 180),
    AccentGlow      = Color3.fromRGB(150, 100, 255),
    Accent2         = Color3.fromRGB(60, 220, 255),    -- Neon ciano
    Success         = Color3.fromRGB(60, 220, 120),
    Warning         = Color3.fromRGB(255, 200, 60),
    Danger          = Color3.fromRGB(255, 70, 70),
    TextPrimary     = Color3.fromRGB(240, 240, 255),
    TextSecondary   = Color3.fromRGB(150, 150, 180),
    TextMuted       = Color3.fromRGB(80, 80, 110),
    Sidebar         = Color3.fromRGB(12, 12, 16),
    SidebarBorder   = Color3.fromRGB(30, 30, 45),
    Topbar          = Color3.fromRGB(10, 10, 14),
    ToggleOff       = Color3.fromRGB(40, 40, 55),
    ToggleOn        = Color3.fromRGB(120, 80, 255),
    SliderBg        = Color3.fromRGB(25, 25, 38),
    SliderFill      = Color3.fromRGB(120, 80, 255),
    InputBg         = Color3.fromRGB(16, 16, 22),
    InputBorder     = Color3.fromRGB(45, 45, 65),
    Scrollbar       = Color3.fromRGB(50, 50, 75),
}

-- ══════════════════════════════════════════════
--              UTILITÁRIOS
-- ══════════════════════════════════════════════
local function Tween(obj, props, dur, style, dir)
    local info = TweenInfo.new(dur or 0.2, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local function AddGlow(obj, color, size)
    local glow = Instance.new("UIStroke")
    glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glow.Color = color or Theme.Accent
    glow.Thickness = size or 1.5
    glow.Transparency = 0.3
    glow.Parent = obj
    return glow
end

local function RoundCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = obj
    return corner
end

local function Padding(obj, top, right, bottom, left)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop    = UDim.new(0, top    or 8)
    pad.PaddingRight  = UDim.new(0, right  or 8)
    pad.PaddingBottom = UDim.new(0, bottom or 8)
    pad.PaddingLeft   = UDim.new(0, left   or 8)
    pad.Parent        = obj
    return pad
end

local function ListLayout(obj, dir, spacing, align)
    local layout = Instance.new("UIListLayout")
    layout.FillDirection      = dir     or Enum.FillDirection.Vertical
    layout.Padding            = UDim.new(0, spacing or 8)
    layout.HorizontalAlignment = align  or Enum.HorizontalAlignment.Left
    layout.SortOrder          = Enum.SortOrder.LayoutOrder
    layout.Parent             = obj
    return layout
end

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" and k ~= "Children" then
            obj[k] = v
        end
    end
    if props.Parent then obj.Parent = props.Parent end
    return obj
end

local function HoverEffect(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = hoverColor}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = normalColor}, 0.15)
    end)
end

-- ══════════════════════════════════════════════
--              ESTRUTURA PRINCIPAL
-- ══════════════════════════════════════════════
-- Limpa instâncias anteriores
pcall(function()
    if CoreGui:FindFirstChild("PremiumHub") then
        CoreGui.PremiumHub:Destroy()
    end
end)

local ScreenGui = Create("ScreenGui", {
    Name            = "PremiumHub",
    ResetOnSpawn    = false,
    ZIndexBehavior  = Enum.ZIndexBehavior.Sibling,
    Parent          = (syn and syn.protect_gui) and syn.protect_gui(Instance.new("ScreenGui")) or CoreGui,
})
if not pcall(function() ScreenGui.Parent = CoreGui end) then
    ScreenGui.Parent = LocalPlayer.PlayerGui
end
ScreenGui.Name = "PremiumHub"

-- ── JANELA PRINCIPAL ──────────────────────────
local MainWindow = Create("Frame", {
    Name            = "MainWindow",
    Size            = UDim2.new(0, 760, 0, 500),
    Position        = UDim2.new(0.5, -380, 0.5, -250),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent          = ScreenGui,
})
RoundCorner(MainWindow, 16)
AddGlow(MainWindow, Theme.Accent, 2)

-- Gradiente lateral neon
local GradientFrame = Create("Frame", {
    Size            = UDim2.new(1, 0, 0, 2),
    Position        = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = Theme.Accent,
    BorderSizePixel = 0,
    ZIndex          = 10,
    Parent          = MainWindow,
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent),
        ColorSequenceKeypoint.new(0.5, Theme.Accent2),
        ColorSequenceKeypoint.new(1, Theme.Accent),
    }),
    Parent = GradientFrame,
})

-- Entrada animada
MainWindow.Position = UDim2.new(0.5, -380, 0.5, -270)
MainWindow.BackgroundTransparency = 1
Tween(MainWindow, {
    Position = UDim2.new(0.5, -380, 0.5, -250),
    BackgroundTransparency = 0,
}, 0.4, Enum.EasingStyle.Quart)

-- ══════════════════════════════════════════════
--                   DRAG
-- ══════════════════════════════════════════════
local dragging, dragStart, startPos = false, nil, nil
local Topbar -- declarado aqui para o drag

local function StartDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging  = true
        dragStart = input.Position
        startPos  = MainWindow.Position
    end
end

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainWindow.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ══════════════════════════════════════════════
--                  TOPBAR
-- ══════════════════════════════════════════════
Topbar = Create("Frame", {
    Name            = "Topbar",
    Size            = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Theme.Topbar,
    BorderSizePixel = 0,
    ZIndex          = 5,
    Parent          = MainWindow,
})
Topbar.InputBegan:Connect(StartDrag)

-- Logo / título
local LogoContainer = Create("Frame", {
    Size            = UDim2.new(0, 200, 1, 0),
    BackgroundTransparency = 1,
    Parent          = Topbar,
})
ListLayout(LogoContainer, Enum.FillDirection.Horizontal, 8)
Padding(LogoContainer, 0, 0, 0, 16)

local LogoDot = Create("Frame", {
    Size            = UDim2.new(0, 10, 0, 10),
    BackgroundColor3 = Theme.Accent,
    BorderSizePixel = 0,
    Parent          = LogoContainer,
})
LogoDot.Position = UDim2.new(0, 16, 0.5, -5)
RoundCorner(LogoDot, 5)
-- pulse no logo dot
spawn(function()
    while MainWindow and MainWindow.Parent do
        Tween(LogoDot, {BackgroundColor3 = Theme.Accent2}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        wait(1)
        Tween(LogoDot, {BackgroundColor3 = Theme.Accent}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        wait(1)
    end
end)

Create("TextLabel", {
    Size            = UDim2.new(0, 160, 1, 0),
    Position        = UDim2.new(0, 34, 0, 0),
    BackgroundTransparency = 1,
    Text            = "PREMIUM  HUB",
    Font            = Enum.Font.GothamBold,
    TextSize        = 15,
    TextColor3      = Theme.TextPrimary,
    TextXAlignment  = Enum.TextXAlignment.Left,
    Parent          = Topbar,
})

Create("TextLabel", {
    Size            = UDim2.new(0, 80, 1, 0),
    Position        = UDim2.new(0, 195, 0, 0),
    BackgroundTransparency = 1,
    Text            = "v2.0",
    Font            = Enum.Font.Gotham,
    TextSize        = 11,
    TextColor3      = Theme.Accent,
    TextXAlignment  = Enum.TextXAlignment.Left,
    Parent          = Topbar,
})

-- Botões de controle
local function TopbarBtn(icon, color, xOff, callback)
    local btn = Create("TextButton", {
        Size            = UDim2.new(0, 28, 0, 28),
        Position        = UDim2.new(1, xOff, 0.5, -14),
        BackgroundColor3 = Color3.fromRGB(28, 28, 38),
        Text            = icon,
        Font            = Enum.Font.GothamBold,
        TextSize        = 13,
        TextColor3      = color,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        ZIndex          = 6,
        Parent          = Topbar,
    })
    RoundCorner(btn, 8)
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = color, TextColor3 = Color3.fromRGB(255,255,255)}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = Color3.fromRGB(28,28,38), TextColor3 = color}, 0.15)
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

TopbarBtn("✕", Theme.Danger, -14, function()
    Tween(MainWindow, {BackgroundTransparency = 1, Position = UDim2.new(0.5, -380, 0.5, -230)}, 0.3)
    wait(0.31)
    ScreenGui:Destroy()
end)

local minimized = false
TopbarBtn("—", Theme.Warning, -50, function()
    minimized = not minimized
    if minimized then
        Tween(MainWindow, {Size = UDim2.new(0, 760, 0, 48)}, 0.3, Enum.EasingStyle.Quart)
    else
        Tween(MainWindow, {Size = UDim2.new(0, 760, 0, 500)}, 0.3, Enum.EasingStyle.Quart)
    end
end)

-- ══════════════════════════════════════════════
--                   SIDEBAR
-- ══════════════════════════════════════════════
local Sidebar = Create("Frame", {
    Name            = "Sidebar",
    Size            = UDim2.new(0, 64, 1, -48),
    Position        = UDim2.new(0, 0, 0, 48),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
    Parent          = MainWindow,
})

-- Borda direita sidebar
Create("Frame", {
    Size            = UDim2.new(0, 1, 1, 0),
    Position        = UDim2.new(1, -1, 0, 0),
    BackgroundColor3 = Theme.SidebarBorder,
    BorderSizePixel = 0,
    Parent          = Sidebar,
})

local SidebarList = Create("ScrollingFrame", {
    Size            = UDim2.new(1, 0, 1, -8),
    Position        = UDim2.new(0, 0, 0, 8),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent          = Sidebar,
})
ListLayout(SidebarList, Enum.FillDirection.Vertical, 4)

-- Área de conteúdo principal
local ContentArea = Create("Frame", {
    Name            = "ContentArea",
    Size            = UDim2.new(1, -64, 1, -48),
    Position        = UDim2.new(0, 64, 0, 48),
    BackgroundColor3 = Theme.BackgroundAlt,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent          = MainWindow,
})

-- ══════════════════════════════════════════════
--              SISTEMA DE ABAS
-- ══════════════════════════════════════════════
local Tabs = {}
local ActiveTab = nil

local function CreateTab(icon, name, order)
    -- Botão sidebar
    local SideBtn = Create("TextButton", {
        Size            = UDim2.new(1, -8, 0, 48),
        BackgroundColor3 = Color3.fromRGB(16, 16, 22),
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        LayoutOrder     = order,
        Parent          = SidebarList,
    })
    RoundCorner(SideBtn, 10)
    Padding(SideBtn, 4, 4, 4, 4)

    local SideIcon = Create("TextLabel", {
        Size            = UDim2.new(1, 0, 0, 22),
        Position        = UDim2.new(0, 0, 0, 4),
        BackgroundTransparency = 1,
        Text            = icon,
        Font            = Enum.Font.GothamBold,
        TextSize        = 18,
        TextColor3      = Theme.TextMuted,
        Parent          = SideBtn,
    })
    local SideName = Create("TextLabel", {
        Size            = UDim2.new(1, 0, 0, 14),
        Position        = UDim2.new(0, 0, 1, -18),
        BackgroundTransparency = 1,
        Text            = name,
        Font            = Enum.Font.Gotham,
        TextSize        = 9,
        TextColor3      = Theme.TextMuted,
        Parent          = SideBtn,
    })

    -- Indicador ativo (linha esquerda)
    local Indicator = Create("Frame", {
        Size            = UDim2.new(0, 3, 0.6, 0),
        Position        = UDim2.new(0, -4, 0.2, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Parent          = SideBtn,
    })
    RoundCorner(Indicator, 3)

    -- Página de conteúdo
    local Page = Create("ScrollingFrame", {
        Name            = name,
        Size            = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Scrollbar,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible         = false,
        Parent          = ContentArea,
    })
    Padding(Page, 16, 16, 16, 16)
    ListLayout(Page, Enum.FillDirection.Vertical, 12)

    local tab = {
        Button    = SideBtn,
        Icon      = SideIcon,
        Label     = SideName,
        Indicator = Indicator,
        Page      = Page,
        Name      = name,
    }

    SideBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            Tween(t.Button, {BackgroundColor3 = Color3.fromRGB(16,16,22)}, 0.2)
            Tween(t.Icon, {TextColor3 = Theme.TextMuted}, 0.2)
            Tween(t.Label, {TextColor3 = Theme.TextMuted}, 0.2)
            Tween(t.Indicator, {BackgroundTransparency = 1}, 0.2)
        end
        tab.Page.Visible = true
        ActiveTab = tab
        Tween(SideBtn, {BackgroundColor3 = Color3.fromRGB(22,18,40)}, 0.2)
        Tween(SideIcon, {TextColor3 = Theme.Accent}, 0.2)
        Tween(SideName, {TextColor3 = Theme.AccentGlow}, 0.2)
        Tween(Indicator, {BackgroundTransparency = 0}, 0.2)
    end)

    table.insert(Tabs, tab)
    return tab
end

-- ══════════════════════════════════════════════
--            COMPONENTES REUTILIZÁVEIS
-- ══════════════════════════════════════════════

-- ── CARD CONTAINER ──
local function CreateCard(parent, title, order)
    local card = Create("Frame", {
        Name            = title or "Card",
        Size            = UDim2.new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })
    RoundCorner(card, 12)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Border
    stroke.Thickness = 1
    stroke.Transparency = 0
    stroke.Parent = card

    local inner = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent          = card,
    })
    Padding(inner, 14, 14, 14, 14)
    ListLayout(inner, Enum.FillDirection.Vertical, 10)

    if title then
        local header = Create("Frame", {
            Size            = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            LayoutOrder     = -1,
            Parent          = inner,
        })
        Create("Frame", {
            Size            = UDim2.new(0, 3, 0.8, 0),
            Position        = UDim2.new(0, 0, 0.1, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Parent          = header,
        }).Parent = header
        RoundCorner(header:FindFirstChildOfClass("Frame"), 3)
        Create("TextLabel", {
            Size            = UDim2.new(1, -12, 1, 0),
            Position        = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text            = title:upper(),
            Font            = Enum.Font.GothamBold,
            TextSize        = 11,
            TextColor3      = Theme.TextSecondary,
            TextXAlignment  = Enum.TextXAlignment.Left,
            Parent          = header,
        })
        -- Linha separadora
        Create("Frame", {
            Size            = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = Theme.Border,
            BorderSizePixel = 0,
            LayoutOrder     = 0,
            Parent          = inner,
        })
    end

    return card, inner
end

-- ── LABEL ──
local function CreateLabel(parent, text, subtext, order)
    local row = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })
    Create("TextLabel", {
        Size            = UDim2.new(0.6, 0, 0, 20),
        Position        = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = row,
    })
    if subtext then
        Create("TextLabel", {
            Size            = UDim2.new(0.6, 0, 0, 16),
            Position        = UDim2.new(0, 0, 0, 20),
            BackgroundTransparency = 1,
            Text            = subtext,
            Font            = Enum.Font.Gotham,
            TextSize        = 10,
            TextColor3      = Theme.TextMuted,
            TextXAlignment  = Enum.TextXAlignment.Left,
            Parent          = row,
        })
    end
    return row
end

-- ── BUTTON ──
local function CreateButton(parent, text, style, callback, order)
    style = style or "primary"
    local bgColor = style == "primary" and Theme.Accent
        or style == "success" and Theme.Success
        or style == "danger"  and Theme.Danger
        or Theme.Card

    local btn = Create("TextButton", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = bgColor,
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })
    RoundCorner(btn, 10)

    -- Gradiente no botão
    local grad = Instance.new("UIGradient")
    grad.Rotation = 90
    if style == "primary" then
        grad.Color = ColorSequence.new(Theme.Accent, Theme.AccentSoft)
    else
        grad.Color = ColorSequence.new(bgColor, bgColor)
    end
    grad.Parent = btn

    Create("TextLabel", {
        Size            = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.GothamBold,
        TextSize        = 13,
        TextColor3      = Color3.fromRGB(255, 255, 255),
        Parent          = btn,
    })

    -- Ripple effect
    btn.MouseButton1Click:Connect(function()
        Tween(btn, {BackgroundTransparency = 0.3}, 0.08)
        Tween(btn, {BackgroundTransparency = 0}, 0.15)
        if callback then callback() end
    end)

    local hover = style == "primary" and Theme.AccentGlow or bgColor
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = hover}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = bgColor}, 0.15)
    end)

    return btn
end

-- ── TOGGLE ──
local function CreateToggle(parent, text, default, callback, order)
    local state = default or false
    local row = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, -56, 1, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = row,
    })

    local track = Create("TextButton", {
        Size            = UDim2.new(0, 46, 0, 24),
        Position        = UDim2.new(1, -46, 0.5, -12),
        BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff,
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent          = row,
    })
    RoundCorner(track, 12)

    local thumb = Create("Frame", {
        Size            = UDim2.new(0, 18, 0, 18),
        Position        = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent          = track,
    })
    RoundCorner(thumb, 9)

    track.MouseButton1Click:Connect(function()
        state = not state
        Tween(track, {BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
        Tween(thumb, {Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)}, 0.2, Enum.EasingStyle.Back)
        if callback then callback(state) end
    end)

    return row, function() return state end
end

-- ── SLIDER ──
local function CreateSlider(parent, text, min, max, default, suffix, callback, order)
    min = min or 0; max = max or 100; default = default or min
    local value = default
    local draggingSlider = false

    local container = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 56),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })

    local topRow = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        Parent          = container,
    })
    Create("TextLabel", {
        Size            = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = topRow,
    })
    local valLabel = Create("TextLabel", {
        Size            = UDim2.new(0.3, 0, 1, 0),
        Position        = UDim2.new(0.7, 0, 0, 0),
        BackgroundTransparency = 1,
        Text            = tostring(default) .. (suffix or ""),
        Font            = Enum.Font.GothamBold,
        TextSize        = 12,
        TextColor3      = Theme.Accent,
        TextXAlignment  = Enum.TextXAlignment.Right,
        Parent          = topRow,
    })

    local track = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 6),
        Position        = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = Theme.SliderBg,
        BorderSizePixel = 0,
        Parent          = container,
    })
    RoundCorner(track, 4)

    local pct = (value - min) / (max - min)
    local fill = Create("Frame", {
        Size            = UDim2.new(pct, 0, 1, 0),
        BackgroundColor3 = Theme.SliderFill,
        BorderSizePixel = 0,
        Parent          = track,
    })
    RoundCorner(fill, 4)
    Create("UIGradient", {
        Color = ColorSequence.new(Theme.Accent, Theme.Accent2),
        Parent = fill,
    })

    local knob = Create("Frame", {
        Size            = UDim2.new(0, 14, 0, 14),
        Position        = UDim2.new(pct, -7, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 0,
        ZIndex          = 2,
        Parent          = track,
    })
    RoundCorner(knob, 7)

    local function UpdateSlider(pos)
        local rel = math.clamp((pos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * rel)
        valLabel.Text = tostring(value) .. (suffix or "")
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
        if callback then callback(value) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
            UpdateSlider(input.Position)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input.Position)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = false
        end
    end)

    return container, function() return value end
end

-- ── DROPDOWN ──
local function CreateDropdown(parent, text, options, default, callback, order)
    local selected = default or options[1] or ""
    local open = false

    local container = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        ClipsDescendants = false,
        ZIndex          = 3,
        Parent          = parent,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 11,
        TextColor3      = Theme.TextMuted,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = container,
    })

    local selectBtn = Create("TextButton", {
        Size            = UDim2.new(1, 0, 0, 34),
        Position        = UDim2.new(0, 0, 0, 4),
        BackgroundColor3 = Theme.InputBg,
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex          = 4,
        Parent          = container,
    })
    RoundCorner(selectBtn, 8)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.InputBorder
    stroke.Thickness = 1
    stroke.Parent = selectBtn

    local selLabel = Create("TextLabel", {
        Size            = UDim2.new(1, -32, 1, 0),
        Position        = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text            = selected,
        Font            = Enum.Font.Gotham,
        TextSize        = 12,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        ZIndex          = 5,
        Parent          = selectBtn,
    })

    local arrow = Create("TextLabel", {
        Size            = UDim2.new(0, 20, 1, 0),
        Position        = UDim2.new(1, -28, 0, 0),
        BackgroundTransparency = 1,
        Text            = "▾",
        Font            = Enum.Font.GothamBold,
        TextSize        = 12,
        TextColor3      = Theme.Accent,
        ZIndex          = 5,
        Parent          = selectBtn,
    })

    local dropList = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, #options * 32 + 8),
        Position        = UDim2.new(0, 0, 0, 42),
        BackgroundColor3 = Color3.fromRGB(16, 16, 24),
        BorderSizePixel = 0,
        Visible         = false,
        ZIndex          = 10,
        Parent          = container,
    })
    RoundCorner(dropList, 8)
    AddGlow(dropList, Theme.Accent, 1)
    Padding(dropList, 4, 4, 4, 4)
    ListLayout(dropList, Enum.FillDirection.Vertical, 2)

    for _, opt in ipairs(options) do
        local item = Create("TextButton", {
            Size            = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Color3.fromRGB(20, 20, 30),
            Text            = opt,
            Font            = Enum.Font.Gotham,
            TextSize        = 12,
            TextColor3      = Theme.TextPrimary,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            ZIndex          = 11,
            Parent          = dropList,
        })
        RoundCorner(item, 6)
        item.MouseEnter:Connect(function()
            Tween(item, {BackgroundColor3 = Color3.fromRGB(30, 22, 50)}, 0.1)
        end)
        item.MouseLeave:Connect(function()
            Tween(item, {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}, 0.1)
        end)
        item.MouseButton1Click:Connect(function()
            selected = opt
            selLabel.Text = opt
            open = false
            dropList.Visible = false
            Tween(selectBtn, {BackgroundColor3 = Theme.InputBg}, 0.15)
            if callback then callback(opt) end
        end)
    end

    selectBtn.MouseButton1Click:Connect(function()
        open = not open
        dropList.Visible = open
        Tween(stroke, {Color = open and Theme.Accent or Theme.InputBorder}, 0.15)
        Tween(arrow, {Rotation = open and 180 or 0}, 0.2)
        container.Size = open and UDim2.new(1, 0, 0, 42 + #options * 34) or UDim2.new(1, 0, 0, 38)
    end)

    return container, function() return selected end
end

-- ── MULTI DROPDOWN ──
local function CreateMultiDropdown(parent, text, options, callback, order)
    local selected = {}
    local open = false

    local container = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        ClipsDescendants = false,
        ZIndex          = 2,
        Parent          = parent,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text            = text .. "  (multi)",
        Font            = Enum.Font.Gotham,
        TextSize        = 11,
        TextColor3      = Theme.TextMuted,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = container,
    })

    local selectBtn = Create("TextButton", {
        Size            = UDim2.new(1, 0, 0, 34),
        Position        = UDim2.new(0, 0, 0, 4),
        BackgroundColor3 = Theme.InputBg,
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex          = 3,
        Parent          = container,
    })
    RoundCorner(selectBtn, 8)
    local strokeM = Instance.new("UIStroke")
    strokeM.Color = Theme.InputBorder; strokeM.Thickness = 1
    strokeM.Parent = selectBtn

    local selLabel = Create("TextLabel", {
        Size            = UDim2.new(1, -32, 1, 0),
        Position        = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text            = "Nenhum selecionado",
        Font            = Enum.Font.Gotham,
        TextSize        = 11,
        TextColor3      = Theme.TextMuted,
        TextXAlignment  = Enum.TextXAlignment.Left,
        ZIndex          = 4,
        Parent          = selectBtn,
    })

    Create("TextLabel", {
        Size            = UDim2.new(0, 20, 1, 0),
        Position        = UDim2.new(1, -28, 0, 0),
        BackgroundTransparency = 1,
        Text            = "▾",
        Font            = Enum.Font.GothamBold,
        TextSize        = 12,
        TextColor3      = Theme.Accent2,
        ZIndex          = 4,
        Parent          = selectBtn,
    })

    local dropList = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, #options * 32 + 8),
        Position        = UDim2.new(0, 0, 0, 42),
        BackgroundColor3 = Color3.fromRGB(14, 14, 22),
        BorderSizePixel = 0,
        Visible         = false,
        ZIndex          = 9,
        Parent          = container,
    })
    RoundCorner(dropList, 8)
    AddGlow(dropList, Theme.Accent2, 1)
    Padding(dropList, 4, 4, 4, 4)
    ListLayout(dropList, Enum.FillDirection.Vertical, 2)

    local function UpdateLabel()
        if #selected == 0 then
            selLabel.Text = "Nenhum selecionado"
            selLabel.TextColor3 = Theme.TextMuted
        else
            selLabel.Text = table.concat(selected, ", ")
            selLabel.TextColor3 = Theme.TextPrimary
        end
    end

    for _, opt in ipairs(options) do
        local checked = false
        local row = Create("TextButton", {
            Size            = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Color3.fromRGB(18, 18, 28),
            Text            = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            ZIndex          = 10,
            Parent          = dropList,
        })
        RoundCorner(row, 6)

        local checkBox = Create("Frame", {
            Size            = UDim2.new(0, 16, 0, 16),
            Position        = UDim2.new(0, 8, 0.5, -8),
            BackgroundColor3 = Theme.ToggleOff,
            BorderSizePixel = 0,
            ZIndex          = 11,
            Parent          = row,
        })
        RoundCorner(checkBox, 4)

        local checkMark = Create("TextLabel", {
            Size            = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text            = "✓",
            Font            = Enum.Font.GothamBold,
            TextSize        = 11,
            TextColor3      = Color3.fromRGB(255,255,255),
            Visible         = false,
            ZIndex          = 12,
            Parent          = checkBox,
        })

        Create("TextLabel", {
            Size            = UDim2.new(1, -36, 1, 0),
            Position        = UDim2.new(0, 32, 0, 0),
            BackgroundTransparency = 1,
            Text            = opt,
            Font            = Enum.Font.Gotham,
            TextSize        = 12,
            TextColor3      = Theme.TextPrimary,
            TextXAlignment  = Enum.TextXAlignment.Left,
            ZIndex          = 11,
            Parent          = row,
        })

        row.MouseButton1Click:Connect(function()
            checked = not checked
            if checked then
                table.insert(selected, opt)
                Tween(checkBox, {BackgroundColor3 = Theme.Accent2}, 0.15)
                checkMark.Visible = true
            else
                for i, v in ipairs(selected) do
                    if v == opt then table.remove(selected, i) break end
                end
                Tween(checkBox, {BackgroundColor3 = Theme.ToggleOff}, 0.15)
                checkMark.Visible = false
            end
            UpdateLabel()
            if callback then callback(selected) end
        end)
        row.MouseEnter:Connect(function() Tween(row, {BackgroundColor3 = Color3.fromRGB(25, 22, 40)}, 0.1) end)
        row.MouseLeave:Connect(function() Tween(row, {BackgroundColor3 = Color3.fromRGB(18, 18, 28)}, 0.1) end)
    end

    selectBtn.MouseButton1Click:Connect(function()
        open = not open
        dropList.Visible = open
        Tween(strokeM, {Color = open and Theme.Accent2 or Theme.InputBorder}, 0.15)
        container.Size = open and UDim2.new(1,0,0,42 + #options*34) or UDim2.new(1,0,0,38)
    end)

    return container, function() return selected end
end

-- ── TEXTBOX ──
local function CreateTextbox(parent, placeholder, callback, order)
    local container = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })

    local box = Create("TextBox", {
        Size            = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.InputBg,
        Text            = "",
        PlaceholderText = placeholder or "Digite aqui...",
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        PlaceholderColor3 = Theme.TextMuted,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        ZIndex          = 2,
        Parent          = container,
    })
    RoundCorner(box, 8)
    Padding(box, 0, 0, 0, 12)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.InputBorder; stroke.Thickness = 1
    stroke.Parent = box

    box.Focused:Connect(function()
        Tween(stroke, {Color = Theme.Accent}, 0.15)
        Tween(box, {BackgroundColor3 = Color3.fromRGB(20, 18, 32)}, 0.15)
    end)
    box.FocusLost:Connect(function()
        Tween(stroke, {Color = Theme.InputBorder}, 0.15)
        Tween(box, {BackgroundColor3 = Theme.InputBg}, 0.15)
        if callback then callback(box.Text) end
    end)

    return container, box
end

-- ── KEYBIND ──
local function CreateKeybind(parent, text, default, callback, order)
    local currentKey = default or Enum.KeyCode.F
    local listening = false

    local row = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        Parent          = parent,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, -90, 1, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = row,
    })

    local keyBtn = Create("TextButton", {
        Size            = UDim2.new(0, 80, 0, 28),
        Position        = UDim2.new(1, -80, 0.5, -14),
        BackgroundColor3 = Theme.InputBg,
        Text            = "[" .. currentKey.Name .. "]",
        Font            = Enum.Font.GothamBold,
        TextSize        = 11,
        TextColor3      = Theme.Accent,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent          = row,
    })
    RoundCorner(keyBtn, 6)
    local kStroke = Instance.new("UIStroke")
    kStroke.Color = Theme.InputBorder; kStroke.Thickness = 1
    kStroke.Parent = keyBtn

    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
        keyBtn.TextColor3 = Theme.Warning
        Tween(kStroke, {Color = Theme.Warning}, 0.15)
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            currentKey = input.KeyCode
            keyBtn.Text = "[" .. currentKey.Name .. "]"
            keyBtn.TextColor3 = Theme.Accent
            Tween(kStroke, {Color = Theme.InputBorder}, 0.15)
            if callback then callback(currentKey) end
        end
    end)

    return row, function() return currentKey end
end

-- ── COLOR PICKER ──
local function CreateColorPicker(parent, text, default, callback, order)
    local color = default or Color3.fromRGB(120, 80, 255)
    local pickerOpen = false

    local container = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder     = order or 0,
        ClipsDescendants = false,
        Parent          = parent,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, -56, 1, 0),
        BackgroundTransparency = 1,
        Text            = text,
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        Parent          = container,
    })

    local preview = Create("TextButton", {
        Size            = UDim2.new(0, 44, 0, 26),
        Position        = UDim2.new(1, -44, 0.5, -13),
        BackgroundColor3 = color,
        Text            = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent          = container,
    })
    RoundCorner(preview, 8)
    AddGlow(preview, color, 1)

    -- Picker panel simples (H/S/V sliders)
    local pickerPanel = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 130),
        Position        = UDim2.new(0, 0, 0, 42),
        BackgroundColor3 = Color3.fromRGB(16, 16, 24),
        BorderSizePixel = 0,
        Visible         = false,
        ZIndex          = 8,
        Parent          = container,
    })
    RoundCorner(pickerPanel, 10)
    AddGlow(pickerPanel, Theme.Accent, 1)
    Padding(pickerPanel, 10, 10, 10, 10)
    ListLayout(pickerPanel, Enum.FillDirection.Vertical, 8)

    local h, s, v = color:ToHSV()

    local function RebuildColor()
        color = Color3.fromHSV(h, s, v)
        preview.BackgroundColor3 = color
        local glow = preview:FindFirstChildOfClass("UIStroke")
        if glow then glow.Color = color end
        if callback then callback(color) end
    end

    local function CPSlider(label, val, gradA, gradB)
        local cRow = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            ZIndex = 9,
            Parent = pickerPanel,
        })
        Create("TextLabel", {
            Size = UDim2.new(0, 14, 1, 0),
            BackgroundTransparency = 1,
            Text = label,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = Theme.TextSecondary,
            ZIndex = 9,
            Parent = cRow,
        })
        local sTrack = Create("Frame", {
            Size = UDim2.new(1, -18, 0, 8),
            Position = UDim2.new(0, 18, 0.5, -4),
            BackgroundColor3 = gradA,
            BorderSizePixel = 0,
            ZIndex = 9,
            Parent = cRow,
        })
        RoundCorner(sTrack, 4)
        Create("UIGradient", {
            Color = ColorSequence.new(gradA, gradB),
            Parent = sTrack,
        })
        local sKnob = Create("Frame", {
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(val, -6, 0.5, -6),
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BorderSizePixel = 0,
            ZIndex = 10,
            Parent = sTrack,
        })
        RoundCorner(sKnob, 6)

        local draggingCP = false
        sTrack.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingCP = true
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if draggingCP and inp.UserInputType == Enum.UserInputType.MouseMovement then
                local rel = math.clamp((inp.X - sTrack.AbsolutePosition.X) / sTrack.AbsoluteSize.X, 0, 1)
                sKnob.Position = UDim2.new(rel, -6, 0.5, -6)
                return rel
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingCP = false end
        end)

        return sKnob, sTrack
    end

    CPSlider("H", h, Color3.fromRGB(255,0,0), Color3.fromRGB(255,0,255))
    CPSlider("S", s, Color3.fromRGB(220,220,220), Color3.fromRGB(120,80,255))
    CPSlider("V", v, Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255))

    preview.MouseButton1Click:Connect(function()
        pickerOpen = not pickerOpen
        pickerPanel.Visible = pickerOpen
        container.Size = pickerOpen and UDim2.new(1,0,0,174) or UDim2.new(1,0,0,38)
    end)

    return container, function() return color end
end

-- ── SEARCH BAR ──
local function CreateSearchBar(parent)
    local row = Create("Frame", {
        Size            = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Theme.InputBg,
        BorderSizePixel = 0,
        LayoutOrder     = -10,
        Parent          = parent,
    })
    RoundCorner(row, 10)
    AddGlow(row, Theme.Border, 1)

    Create("TextLabel", {
        Size            = UDim2.new(0, 20, 1, 0),
        Position        = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text            = "🔍",
        Font            = Enum.Font.Gotham,
        TextSize        = 14,
        TextColor3      = Theme.TextMuted,
        Parent          = row,
    })

    local box = Create("TextBox", {
        Size            = UDim2.new(1, -36, 1, 0),
        Position        = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1,
        Text            = "",
        PlaceholderText = "Pesquisar componentes...",
        Font            = Enum.Font.Gotham,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        PlaceholderColor3 = Theme.TextMuted,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        Parent          = row,
    })

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Border; stroke.Thickness = 1
    stroke.Parent = row

    box.Focused:Connect(function()
        Tween(stroke, {Color = Theme.Accent}, 0.15)
    end)
    box.FocusLost:Connect(function()
        Tween(stroke, {Color = Theme.Border}, 0.15)
    end)

    return row, box
end

-- ══════════════════════════════════════════════
--               ABA 1: COMPONENTES
-- ══════════════════════════════════════════════
local Tab1 = CreateTab("⚡", "Main", 1)
Tab1.Page.Visible = true
ActiveTab = Tab1

-- Ativa visualmente
Tween(Tab1.Button, {BackgroundColor3 = Color3.fromRGB(22,18,40)}, 0)
Tween(Tab1.Icon, {TextColor3 = Theme.Accent}, 0)
Tween(Tab1.Label, {TextColor3 = Theme.AccentGlow}, 0)
Tab1.Indicator.BackgroundTransparency = 0

-- Barra de busca no topo
CreateSearchBar(Tab1.Page)

-- ── CARD: BOTÕES ──
local _, btnCard = CreateCard(Tab1.Page, "Botões", 1)
CreateLabel(btnCard, "Ações do Script", "Clique para executar", 0)
CreateButton(btnCard, "▶  Executar Script", "primary", function()
    print("[Hub] Script executado!")
end, 1)
CreateButton(btnCard, "⏹  Parar Tudo", "danger", function()
    print("[Hub] Parado!")
end, 2)
CreateButton(btnCard, "✓  Confirmar", "success", function()
    print("[Hub] Confirmado!")
end, 3)

-- ── CARD: TOGGLES ──
local _, togCard = CreateCard(Tab1.Page, "Toggles", 2)
CreateLabel(togCard, "Funções Ativas", "Ative ou desative recursos", 0)
CreateToggle(togCard, "ESP - Jogadores", false, function(v)
    print("[Hub] ESP:", v)
end, 1)
CreateToggle(togCard, "Aimbot", false, function(v)
    print("[Hub] Aimbot:", v)
end, 2)
CreateToggle(togCard, "God Mode", true, function(v)
    print("[Hub] God Mode:", v)
end, 3)
CreateToggle(togCard, "No Clip", false, function(v)
    print("[Hub] NoClip:", v)
end, 4)

-- ── CARD: SLIDERS ──
local _, sldCard = CreateCard(Tab1.Page, "Sliders", 3)
CreateSlider(sldCard, "FOV do Aimbot", 0, 500, 120, "px", function(v)
    print("[Hub] FOV:", v)
end, 1)
CreateSlider(sldCard, "Walk Speed", 16, 200, 16, "", function(v)
    print("[Hub] Speed:", v)
end, 2)
CreateSlider(sldCard, "Jump Power", 50, 300, 50, "", function(v)
    print("[Hub] Jump:", v)
end, 3)

-- ── CARD: DROPDOWNS ──
local _, ddCard = CreateCard(Tab1.Page, "Dropdowns", 4)
CreateDropdown(ddCard, "Modo ESP", {"Caixas", "Esqueleto", "Chams", "Wireframe"}, "Caixas", function(v)
    print("[Hub] ESP modo:", v)
end, 1)
CreateMultiDropdown(ddCard, "Times Visíveis", {"Time Azul", "Time Vermelho", "Spectators", "NPCs"}, function(v)
    print("[Hub] Times:", table.concat(v, ", "))
end, 2)

-- ══════════════════════════════════════════════
--               ABA 2: CONFIGURAÇÕES
-- ══════════════════════════════════════════════
local Tab2 = CreateTab("⚙", "Config", 2)

-- ── CARD: TEXTBOX + KEYBIND ──
local _, inputCard = CreateCard(Tab2.Page, "Inputs", 1)
CreateLabel(inputCard, "Campos de Entrada", "Configure valores personalizados", 0)
CreateTextbox(inputCard, "Nome do Jogador Alvo...", function(v)
    print("[Hub] Alvo:", v)
end, 1)
CreateTextbox(inputCard, "Endereço do Webhook Discord...", function(v)
    print("[Hub] Webhook:", v)
end, 2)

-- ── CARD: KEYBINDS ──
local _, kbCard = CreateCard(Tab2.Page, "Keybinds", 2)
CreateLabel(kbCard, "Teclas de Atalho", "Clique para redefinir a tecla", 0)
CreateKeybind(kbCard, "Abrir/Fechar UI", Enum.KeyCode.RightShift, function(k)
    print("[Hub] UI Key:", k.Name)
end, 1)
CreateKeybind(kbCard, "Ativar Aimbot", Enum.KeyCode.V, function(k)
    print("[Hub] Aimbot Key:", k.Name)
end, 2)
CreateKeybind(kbCard, "NoClip Toggle", Enum.KeyCode.N, function(k)
    print("[Hub] Noclip Key:", k.Name)
end, 3)

-- ── CARD: CORES ──
local _, colorCard = CreateCard(Tab2.Page, "Cores do Hub", 3)
CreateLabel(colorCard, "Personalização Visual", "Clique na cor para abrir o picker", 0)
CreateColorPicker(colorCard, "Cor do ESP", Color3.fromRGB(60, 220, 255), function(c)
    print("[Hub] Cor ESP:", c)
end, 1)
CreateColorPicker(colorCard, "Cor do Aimbot FOV", Color3.fromRGB(120, 80, 255), function(c)
    print("[Hub] Cor Aimbot:", c)
end, 2)
CreateColorPicker(colorCard, "Cor do Chams", Color3.fromRGB(255, 70, 70), function(c)
    print("[Hub] Cor Chams:", c)
end, 3)

-- ── CARD: LABELS INFORMATIVOS ──
local _, infoCard = CreateCard(Tab2.Page, "Informações", 4)
CreateLabel(infoCard, "Versão", "Premium Hub v2.0", 1)
CreateLabel(infoCard, "Executor", "Suporte Universal", 2)
CreateLabel(infoCard, "Autor", "CoiledTom", 3)
CreateLabel(infoCard, "Discord", "discord.gg/coiledtom", 4)

-- ══════════════════════════════════════════════
--               ABA 3: VISUAL
-- ══════════════════════════════════════════════
local Tab3 = CreateTab("🎨", "Visual", 3)

local _, themeCard = CreateCard(Tab3.Page, "Tema", 1)
CreateLabel(themeCard, "Aparência da UI", "Personalize o visual do hub", 0)
CreateToggle(themeCard, "Modo Neon Intenso", true, function(v)
    print("[Hub] Neon:", v)
end, 1)
CreateToggle(themeCard, "Blur no Fundo", false, function(v)
    print("[Hub] Blur:", v)
end, 2)
CreateSlider(themeCard, "Transparência da UI", 0, 100, 10, "%", function(v)
    print("[Hub] Transparência:", v)
end, 3)
CreateDropdown(themeCard, "Esquema de Cor", {"Roxo Neon", "Ciano Neon", "Verde Neon", "Vermelho"}, "Roxo Neon", function(v)
    print("[Hub] Tema:", v)
end, 4)

-- ══════════════════════════════════════════════
--               ABA 4: SOBRE
-- ══════════════════════════════════════════════
local Tab4 = CreateTab("ℹ", "Info", 4)

local _, aboutCard = CreateCard(Tab4.Page, "Sobre o Hub", 1)
CreateLabel(aboutCard, "Premium Hub", "Interface avançada para Roblox", 0)
CreateLabel(aboutCard, "🔑 Versão", "v2.0 — Build 2025", 1)
CreateLabel(aboutCard, "👤 Desenvolvedor", "CoiledTom", 2)
CreateLabel(aboutCard, "💬 Suporte", "Discord da comunidade", 3)
CreateButton(aboutCard, "📋  Copiar Discord", "primary", function()
    print("[Hub] Discord copiado!")
end, 4)
CreateButton(aboutCard, "🔄  Verificar Atualizações", "success", function()
    print("[Hub] Verificando updates...")
end, 5)

-- ══════════════════════════════════════════════
--          NOTIFICAÇÃO DE BOAS-VINDAS
-- ══════════════════════════════════════════════
local function Notify(title, msg, duration)
    local notif = Create("Frame", {
        Size            = UDim2.new(0, 280, 0, 64),
        Position        = UDim2.new(1, 10, 1, -74),
        BackgroundColor3 = Color3.fromRGB(16, 16, 24),
        BorderSizePixel = 0,
        ZIndex          = 20,
        Parent          = ScreenGui,
    })
    RoundCorner(notif, 12)
    AddGlow(notif, Theme.Accent, 1.5)

    Create("Frame", {
        Size            = UDim2.new(0, 3, 0.7, 0),
        Position        = UDim2.new(0, 0, 0.15, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex          = 21,
        Parent          = notif,
    })

    Create("TextLabel", {
        Size            = UDim2.new(1, -20, 0, 24),
        Position        = UDim2.new(0, 14, 0, 8),
        BackgroundTransparency = 1,
        Text            = title,
        Font            = Enum.Font.GothamBold,
        TextSize        = 13,
        TextColor3      = Theme.TextPrimary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        ZIndex          = 21,
        Parent          = notif,
    })
    Create("TextLabel", {
        Size            = UDim2.new(1, -20, 0, 18),
        Position        = UDim2.new(0, 14, 0, 30),
        BackgroundTransparency = 1,
        Text            = msg,
        Font            = Enum.Font.Gotham,
        TextSize        = 11,
        TextColor3      = Theme.TextSecondary,
        TextXAlignment  = Enum.TextXAlignment.Left,
        ZIndex          = 21,
        Parent          = notif,
    })

    Tween(notif, {Position = UDim2.new(1, -290, 1, -74)}, 0.3, Enum.EasingStyle.Back)
    wait(duration or 3)
    Tween(notif, {Position = UDim2.new(1, 10, 1, -74)}, 0.25)
    wait(0.3)
    notif:Destroy()
end

-- Exibe notificação inicial
spawn(function()
    wait(0.5)
    Notify("✅ Premium Hub", "Carregado com sucesso!", 4)
end)

print("[PremiumHub] UI carregada com sucesso!")
