-- ╔══════════════════════════════════════════════════════════════╗
-- ║        PREMIUM HUB UI v3 — CoiledTom                        ║
-- ║  Icons.lua | Mobile Button | Fixed Sliders | Search Live     ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players         = game:GetService("Players")
local UIS             = game:GetService("UserInputService")
local TweenService    = game:GetService("TweenService")
local RunService      = game:GetService("RunService")
local CoreGui         = game:GetService("CoreGui")

local LP  = Players.LocalPlayer
local Mou = LP:GetMouse()

-- ══════════════════════════════════════════════
-- ICONS (embutido — cola seu Icons.lua acima
-- ou carrega via loadstring/require se preferir)
-- ══════════════════════════════════════════════
local Icons = {}
Icons.Map = {
    Home="rbxassetid://10723418816",Settings="rbxassetid://10709810948",
    Player="rbxassetid://10747373176",Players="rbxassetid://10747373426",
    Combat="rbxassetid://10709769508",Shield="rbxassetid://10747344282",
    Eye="rbxassetid://10723346959",EyeOff="rbxassetid://10723346871",
    Star="rbxassetid://10747344524",Crosshair="rbxassetid://10709818534",
    Target="rbxassetid://10747364539",Gamepad="rbxassetid://10723395457",
    Sword="rbxassetid://10747364168",Zap="rbxassetid://10747385083",
    Flame="rbxassetid://10723376114",Crown="rbxassetid://10709818626",
    Bomb="rbxassetid://10709781460",Close="rbxassetid://10747384394",
    CloseCircle="rbxassetid://10747383819",Check="rbxassetid://10709790644",
    CheckCircle="rbxassetid://10709790387",Plus="rbxassetid://10747318400",
    Minus="rbxassetid://10747257869",Edit="rbxassetid://10734883598",
    Copy="rbxassetid://10709812159",Trash="rbxassetid://10747364810",
    Save="rbxassetid://10747340064",Download="rbxassetid://10723344270",
    Search="rbxassetid://10747341119",RefreshCw="rbxassetid://10747327103",
    Lock="rbxassetid://10747249327",Unlock="rbxassetid://10747366027",
    Key="rbxassetid://10723418959",Power="rbxassetid://10747319779",
    PowerOff="rbxassetid://10747319563",ArrowUp="rbxassetid://10709768939",
    ArrowDown="rbxassetid://10709767827",ChevronUp="rbxassetid://10709791523",
    ChevronDown="rbxassetid://10709790948",ChevronLeft="rbxassetid://10709791281",
    ChevronRight="rbxassetid://10709791437",ChevronsUpDown="rbxassetid://10709797508",
    Info="rbxassetid://10723419156",AlertCircle="rbxassetid://10709752996",
    Bell="rbxassetid://10709775704",BellOff="rbxassetid://10709775320",
    Sliders="rbxassetid://10747343494",SlidersH="rbxassetid://10747343325",
    Dashboard="rbxassetid://10723419420",Maximize="rbxassetid://10747254756",
    Minimize="rbxassetid://10747255073",Menu="rbxassetid://10747255467",
    Palette="rbxassetid://10747316827",Keyboard="rbxassetid://10723419295",
    Terminal="rbxassetid://10747364313",Code="rbxassetid://10709810463",
    Wrench="rbxassetid://10747383470",Cpu="rbxassetid://10709813383",
    Activity="rbxassetid://10709752035",Radar="rbxassetid://10747322877",
    Gauge="rbxassetid://10723395708",Navigation="rbxassetid://10747261479",
    Globe="rbxassetid://10723404278",Clock="rbxassetid://10709805144",
    Award="rbxassetid://10709769406",Trophy="rbxassetid://10747365063",
    Tag="rbxassetid://10747363934",MessageSquare="rbxassetid://10747256154",
    Bot="rbxassetid://10709782230",Wand2="rbxassetid://10747376349",
    Fingerprint="rbxassetid://10723375250",Dumbbell="rbxassetid://18273453053",
    EyeDropper="rbxassetid://104794806183086",Grid="rbxassetid://10723404459",
}
function Icons.Get(n) return Icons.Map[n] or Icons.Map["Info"] end
function Icons.Make(parent, name, size, color)
    local img = Instance.new("ImageLabel")
    img.Name="Icon_"..name; img.Size=UDim2.new(0,size or 16,0,size or 16)
    img.BackgroundTransparency=1; img.Image=Icons.Get(name)
    img.ImageColor3=color or Color3.fromRGB(200,200,220)
    img.ScaleType=Enum.ScaleType.Fit; img.Parent=parent
    return img
end

-- ══════════════════════════════════════════════
-- TEMA
-- ══════════════════════════════════════════════
local T = {
    Bg          = Color3.fromRGB(10,10,13),
    BgAlt       = Color3.fromRGB(14,14,19),
    Card        = Color3.fromRGB(17,17,24),
    CardHov     = Color3.fromRGB(22,20,32),
    Border      = Color3.fromRGB(32,32,48),
    Accent      = Color3.fromRGB(110,70,255),
    AccentBr    = Color3.fromRGB(150,100,255),
    AccentSoft  = Color3.fromRGB(70,45,160),
    Cyan        = Color3.fromRGB(55,215,255),
    Success     = Color3.fromRGB(55,210,110),
    Danger      = Color3.fromRGB(255,65,65),
    Warning     = Color3.fromRGB(255,195,55),
    TxtPri      = Color3.fromRGB(235,235,255),
    TxtSec      = Color3.fromRGB(140,140,175),
    TxtMut      = Color3.fromRGB(70,70,100),
    Sidebar     = Color3.fromRGB(11,11,16),
    SideB       = Color3.fromRGB(28,28,44),
    Topbar      = Color3.fromRGB(9,9,13),
    TogOff      = Color3.fromRGB(38,38,54),
    TogOn       = Color3.fromRGB(110,70,255),
    SlBg        = Color3.fromRGB(24,24,36),
    InBg        = Color3.fromRGB(15,15,21),
    InBorder    = Color3.fromRGB(42,42,62),
    Scroll      = Color3.fromRGB(48,48,72),
}

-- ══════════════════════════════════════════════
-- UTILITÁRIOS
-- ══════════════════════════════════════════════
local function Tw(o,p,d,s,dir)
    TweenService:Create(o,TweenInfo.new(d or .2,s or Enum.EasingStyle.Quart,dir or Enum.EasingDirection.Out),p):Play()
end
local function Corner(o,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 10);c.Parent=o;return c end
local function Stroke(o,col,thick,transp)
    local s=Instance.new("UIStroke");s.Color=col or T.Border;s.Thickness=thick or 1;s.Transparency=transp or 0;s.Parent=o;return s
end
local function Pad(o,t,r,b,l)
    local p=Instance.new("UIPadding")
    p.PaddingTop=UDim.new(0,t or 8);p.PaddingRight=UDim.new(0,r or 8)
    p.PaddingBottom=UDim.new(0,b or 8);p.PaddingLeft=UDim.new(0,l or 8)
    p.Parent=o;return p
end
local function List(o,dir,sp,align)
    local l=Instance.new("UIListLayout")
    l.FillDirection=dir or Enum.FillDirection.Vertical
    l.Padding=UDim.new(0,sp or 8)
    l.HorizontalAlignment=align or Enum.HorizontalAlignment.Left
    l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=o;return l
end
local function Mk(cls,props)
    local o=Instance.new(cls)
    for k,v in pairs(props) do if k~="Parent" then o[k]=v end end
    if props.Parent then o.Parent=props.Parent end
    return o
end
local function GradV(o,ca,cb)
    local g=Instance.new("UIGradient");g.Rotation=90
    g.Color=ColorSequence.new(ca,cb);g.Parent=o;return g
end
local function GradH(o,seq)
    local g=Instance.new("UIGradient");g.Color=seq;g.Parent=o;return g
end

-- Ripple / scale press animation
local function AnimPress(btn)
    btn.MouseButton1Down:Connect(function()
        Tw(btn,{Size=UDim2.new(btn.Size.X.Scale,btn.Size.X.Offset-4,btn.Size.Y.Scale,btn.Size.Y.Offset-2)},0.07,Enum.EasingStyle.Quad)
    end)
    btn.MouseButton1Up:Connect(function()
        Tw(btn,{Size=UDim2.new(btn.Size.X.Scale,btn.Size.X.Offset+4,btn.Size.Y.Scale,btn.Size.Y.Offset+2)},0.12,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    end)
end

-- ══════════════════════════════════════════════
-- SCREENGU + CLEANUP
-- ══════════════════════════════════════════════
pcall(function() if CoreGui:FindFirstChild("PHubV3") then CoreGui.PHubV3:Destroy() end end)

local SG = Mk("ScreenGui",{Name="PHubV3",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
pcall(function() SG.Parent=CoreGui end)
if not SG.Parent or SG.Parent~=CoreGui then SG.Parent=LP.PlayerGui end
SG.Name="PHubV3"

-- ══════════════════════════════════════════════
-- BOTÃO FLUTUANTE (abrir/fechar) — MOBILE
-- ══════════════════════════════════════════════
local FAB = Mk("TextButton",{
    Name="FAB",Size=UDim2.new(0,52,0,52),
    Position=UDim2.new(1,-68,1,-80),
    BackgroundColor3=T.Accent,Text="",AutoButtonColor=false,
    BorderSizePixel=0,ZIndex=30,Parent=SG,
})
Corner(FAB,26)
Stroke(FAB,T.AccentBr,1.5,0.2)
GradV(FAB,T.AccentBr,T.AccentSoft)
local fabIcon = Icons.Make(FAB,"Menu",22,Color3.fromRGB(255,255,255))
fabIcon.Position=UDim2.new(0.5,-11,0.5,-11)
-- Pulsing glow no FAB
spawn(function()
    while FAB and FAB.Parent do
        Tw(FAB,{BackgroundColor3=T.AccentBr},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
        wait(.8)
        Tw(FAB,{BackgroundColor3=T.AccentSoft},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
        wait(.8)
    end
end)

-- ══════════════════════════════════════════════
-- JANELA PRINCIPAL
-- ══════════════════════════════════════════════
local WIN = Mk("Frame",{
    Name="Window",Size=UDim2.new(0,740,0,500),
    Position=UDim2.new(0.5,-370,0.5,-260),
    BackgroundColor3=T.Bg,BorderSizePixel=0,
    ClipsDescendants=true,ZIndex=2,
    BackgroundTransparency=1,Parent=SG,
})
Corner(WIN,16)
Stroke(WIN,T.Accent,1.5,.4)

-- Linha topo gradiente
local topLine=Mk("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,0,0),BackgroundColor3=T.Accent,BorderSizePixel=0,ZIndex=10,Parent=WIN})
GradH(topLine,ColorSequence.new({
    ColorSequenceKeypoint.new(0,T.Accent),
    ColorSequenceKeypoint.new(.5,T.Cyan),
    ColorSequenceKeypoint.new(1,T.Accent),
}))

local hubVisible = false
local function ToggleHub()
    hubVisible = not hubVisible
    if hubVisible then
        WIN.BackgroundTransparency=1
        WIN.Position=UDim2.new(0.5,-370,0.5,-240)
        WIN.Visible=true
        Tw(WIN,{BackgroundTransparency=0,Position=UDim2.new(0.5,-370,0.5,-250)},.35,Enum.EasingStyle.Quart)
        fabIcon.Image=Icons.Get("Close")
    else
        Tw(WIN,{BackgroundTransparency=1,Position=UDim2.new(0.5,-370,0.5,-230)},.25,Enum.EasingStyle.Quart)
        task.delay(.26,function() WIN.Visible=false end)
        fabIcon.Image=Icons.Get("Menu")
    end
end
WIN.Visible=false

FAB.MouseButton1Click:Connect(function()
    Tw(FAB,{Size=UDim2.new(0,44,0,44)},.07,Enum.EasingStyle.Quad)
    task.delay(.08,function() Tw(FAB,{Size=UDim2.new(0,52,0,52)},.15,Enum.EasingStyle.Back) end)
    ToggleHub()
end)

-- ══════════════════════════════════════════════
-- DRAG NA TOPBAR
-- ══════════════════════════════════════════════
local dragOn,dragStart,dragPos0=false,nil,nil
local Topbar -- forward

-- ══════════════════════════════════════════════
-- TOPBAR
-- ══════════════════════════════════════════════
Topbar = Mk("Frame",{
    Size=UDim2.new(1,0,0,46),BackgroundColor3=T.Topbar,BorderSizePixel=0,ZIndex=5,Parent=WIN,
})
Topbar.InputBegan:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 then
        dragOn=true;dragStart=inp.Position;dragPos0=WIN.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if dragOn and inp.UserInputType==Enum.UserInputType.MouseMovement then
        local d=inp.Position-dragStart
        WIN.Position=UDim2.new(dragPos0.X.Scale,dragPos0.X.Offset+d.X,dragPos0.Y.Scale,dragPos0.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragOn=false end
end)

-- logo dot pulsante
local dot=Mk("Frame",{Size=UDim2.new(0,8,0,8),Position=UDim2.new(0,16,0.5,-4),BackgroundColor3=T.Accent,BorderSizePixel=0,ZIndex=6,Parent=Topbar})
Corner(dot,4)
spawn(function()
    while WIN and WIN.Parent do
        Tw(dot,{BackgroundColor3=T.Cyan},.9,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.9)
        Tw(dot,{BackgroundColor3=T.Accent},.9,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.9)
    end
end)

Mk("TextLabel",{Size=UDim2.new(0,160,1,0),Position=UDim2.new(0,30,0,0),BackgroundTransparency=1,
    Text="PREMIUM  HUB",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Topbar})
Mk("TextLabel",{Size=UDim2.new(0,40,1,0),Position=UDim2.new(0,193,0,0),BackgroundTransparency=1,
    Text="v3",Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.Accent,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Topbar})

-- Botão fechar (topbar)
local function TBtn(iconName,color,xOff,cb)
    local b=Mk("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,xOff,0.5,-14),
        BackgroundColor3=Color3.fromRGB(26,26,36),Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=7,Parent=Topbar})
    Corner(b,8)
    local ic=Icons.Make(b,iconName,14,color);ic.Position=UDim2.new(0.5,-7,0.5,-7)
    b.MouseEnter:Connect(function() Tw(b,{BackgroundColor3=color},0.15) ic.ImageColor3=Color3.fromRGB(255,255,255) end)
    b.MouseLeave:Connect(function() Tw(b,{BackgroundColor3=Color3.fromRGB(26,26,36)},0.15) ic.ImageColor3=color end)
    b.MouseButton1Click:Connect(cb)
    return b
end
TBtn("Close",T.Danger,-14,function() ToggleHub() end)
TBtn("Minimize",T.Warning,-50,function()
    -- mini/restore
    if WIN.Size.Y.Offset>60 then
        Tw(WIN,{Size=UDim2.new(0,740,0,46)},.3,Enum.EasingStyle.Quart)
    else
        Tw(WIN,{Size=UDim2.new(0,740,0,500)},.3,Enum.EasingStyle.Quart)
    end
end)

-- ══════════════════════════════════════════════
-- SIDEBAR
-- ══════════════════════════════════════════════
local SB=Mk("Frame",{Size=UDim2.new(0,60,1,-46),Position=UDim2.new(0,0,0,46),BackgroundColor3=T.Sidebar,BorderSizePixel=0,Parent=WIN})
Mk("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=T.SideB,BorderSizePixel=0,Parent=SB})

local SBScroll=Mk("ScrollingFrame",{Size=UDim2.new(1,0,1,-8),Position=UDim2.new(0,0,0,8),
    BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,
    AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=SB})
List(SBScroll,Enum.FillDirection.Vertical,4)

-- CONTEÚDO
local CA=Mk("Frame",{Size=UDim2.new(1,-60,1,-46),Position=UDim2.new(0,60,0,46),BackgroundColor3=T.BgAlt,BorderSizePixel=0,ClipsDescendants=true,Parent=WIN})

-- ══════════════════════════════════════════════
-- SISTEMA DE ABAS
-- ══════════════════════════════════════════════
local Tabs={};local ActiveTab=nil

-- Tabela: nome de todos os componentes (para busca)
local AllComponents={}   -- {frame=, text=, page=}

local function RegSearch(frame,text,page)
    table.insert(AllComponents,{frame=frame,text=text:lower(),page=page})
end

local function CreateTab(iconName,label,order)
    local sb=Mk("TextButton",{Size=UDim2.new(1,-8,0,52),BackgroundColor3=Color3.fromRGB(15,15,21),
        Text="",AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=order,Parent=SBScroll})
    Corner(sb,10)

    local ic=Icons.Make(sb,iconName,20,T.TxtMut);ic.Position=UDim2.new(0.5,-10,0,7)
    local lbl=Mk("TextLabel",{Size=UDim2.new(1,0,0,13),Position=UDim2.new(0,0,1,-16),
        BackgroundTransparency=1,Text=label,Font=Enum.Font.Gotham,TextSize=9,
        TextColor3=T.TxtMut,ZIndex=2,Parent=sb})

    local ind=Mk("Frame",{Size=UDim2.new(0,3,0.6,0),Position=UDim2.new(0,-4,0.2,0),
        BackgroundColor3=T.Accent,BorderSizePixel=0,BackgroundTransparency=1,Parent=sb})
    Corner(ind,3)

    local page=Mk("ScrollingFrame",{Name=label,Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,
        ScrollBarImageColor3=T.Scroll,AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=false,Parent=CA})
    Pad(page,14,14,14,14)
    List(page,Enum.FillDirection.Vertical,10)

    local tab={Btn=sb,Icon=ic,Lbl=lbl,Ind=ind,Page=page,Name=label}
    sb.MouseButton1Click:Connect(function()
        for _,t in pairs(Tabs) do
            t.Page.Visible=false
            Tw(t.Btn,{BackgroundColor3=Color3.fromRGB(15,15,21)},.2)
            Tw(t.Icon,{ImageColor3=T.TxtMut},.2)
            Tw(t.Lbl,{TextColor3=T.TxtMut},.2)
            Tw(t.Ind,{BackgroundTransparency=1},.2)
        end
        tab.Page.Visible=true;ActiveTab=tab
        Tw(sb,{BackgroundColor3=Color3.fromRGB(20,16,38)},.2)
        Tw(ic,{ImageColor3=T.Accent},.2)
        Tw(lbl,{TextColor3=T.AccentBr},.2)
        Tw(ind,{BackgroundTransparency=0},.2)
    end)
    table.insert(Tabs,tab)
    return tab
end

-- ══════════════════════════════════════════════
-- COMPONENTES
-- ══════════════════════════════════════════════

-- CARD
local function Card(parent,title,order)
    local c=Mk("Frame",{Name=title or "Card",Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundColor3=T.Card,BorderSizePixel=0,LayoutOrder=order or 0,Parent=parent})
    Corner(c,12);Stroke(c,T.Border,1,0)
    local inner=Mk("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundTransparency=1,Parent=c})
    Pad(inner,12,12,12,12);List(inner,Enum.FillDirection.Vertical,8)
    if title then
        local hdr=Mk("Frame",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,LayoutOrder=-1,Parent=inner})
        local bar=Mk("Frame",{Size=UDim2.new(0,3,0.8,0),Position=UDim2.new(0,0,0.1,0),BackgroundColor3=T.Accent,BorderSizePixel=0,Parent=hdr})
        Corner(bar,3)
        Mk("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,
            Text=title:upper(),Font=Enum.Font.GothamBold,TextSize=10,TextColor3=T.TxtSec,
            TextXAlignment=Enum.TextXAlignment.Left,Parent=hdr})
        Mk("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=T.Border,BorderSizePixel=0,LayoutOrder=0,Parent=inner})
    end
    return c,inner
end

-- ROW BASE (icon + texto à esquerda, widget à direita)
local function Row(parent,iconName,text,height,order)
    local r=Mk("Frame",{Size=UDim2.new(1,0,0,height or 38),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local ix=Icons.Make(r,iconName,15,T.TxtMut);ix.Position=UDim2.new(0,0,0.5,-7)
    Mk("TextLabel",{Size=UDim2.new(0.55,0,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.Gotham,TextSize=13,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,Parent=r})
    return r
end

-- LABEL
local function Label(parent,iconName,text,sub,order)
    local r=Row(parent,iconName,text,sub and 40 or 30,order)
    if sub then
        Mk("TextLabel",{Size=UDim2.new(0.55,0,0,14),Position=UDim2.new(0,22,0,20),BackgroundTransparency=1,
            Text=sub,Font=Enum.Font.Gotham,TextSize=10,TextColor3=T.TxtMut,TextXAlignment=Enum.TextXAlignment.Left,Parent=r})
    end
    return r
end

-- BUTTON
local function Button(parent,iconName,text,style,cb,order)
    local bgc=style=="primary" and T.Accent or style=="success" and T.Success or style=="danger" and T.Danger or T.Card
    local btn=Mk("TextButton",{Size=UDim2.new(1,0,0,38),BackgroundColor3=bgc,Text="",
        AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=order or 0,Parent=parent})
    Corner(btn,10)
    if style=="primary" then GradV(btn,T.AccentBr,T.AccentSoft) end

    local cont=Mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Parent=btn})
    local ix=Icons.Make(cont,iconName,15,Color3.fromRGB(255,255,255));ix.Position=UDim2.new(0,14,0.5,-7)
    Mk("TextLabel",{Size=UDim2.new(1,-38,1,0),Position=UDim2.new(0,34,0,0),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),
        TextXAlignment=Enum.TextXAlignment.Left,Parent=cont})

    -- hover
    btn.MouseEnter:Connect(function() Tw(btn,{BackgroundColor3=Color3.fromRGB(bgc.R*255+15,bgc.G*255+10,bgc.B*255+20)},.15) end)
    btn.MouseLeave:Connect(function() Tw(btn,{BackgroundColor3=bgc},.15) end)
    -- press animation
    btn.MouseButton1Down:Connect(function()
        Tw(btn,{Size=UDim2.new(1,-6,0,34)},0.07,Enum.EasingStyle.Quad)
    end)
    btn.MouseButton1Up:Connect(function()
        Tw(btn,{Size=UDim2.new(1,0,0,38)},0.14,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    end)
    btn.MouseButton1Click:Connect(function() if cb then cb() end end)

    RegSearch(btn,text,nil)
    return btn
end

-- TOGGLE
local function Toggle(parent,iconName,text,default,cb,order)
    local state=default or false
    local r=Row(parent,iconName,text,36,order)

    local track=Mk("TextButton",{Size=UDim2.new(0,44,0,22),Position=UDim2.new(1,-44,0.5,-11),
        BackgroundColor3=state and T.TogOn or T.TogOff,Text="",AutoButtonColor=false,BorderSizePixel=0,Parent=r})
    Corner(track,11)

    local thumb=Mk("Frame",{Size=UDim2.new(0,16,0,16),
        Position=state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
        BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=track})
    Corner(thumb,8)

    track.MouseButton1Click:Connect(function()
        state=not state
        Tw(track,{BackgroundColor3=state and T.TogOn or T.TogOff},.2)
        Tw(thumb,{Position=state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)},.2,Enum.EasingStyle.Back)
        if cb then cb(state) end
    end)
    RegSearch(r,text,nil)
    return r,function() return state end
end

-- ══════════════════════════════════════════════
-- SLIDER — CORRIGIDO (RunService drag)
-- ══════════════════════════════════════════════
local function Slider(parent,iconName,text,min,max,def,suffix,cb,order)
    min=min or 0;max=max or 100;def=def or min
    local val=def
    local dragging=false

    local cont=Mk("Frame",{Size=UDim2.new(1,0,0,56),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})

    -- linha topo: icon + label + valor
    local top=Mk("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Parent=cont})
    local ix=Icons.Make(top,iconName,14,T.TxtMut);ix.Position=UDim2.new(0,0,0.5,-7)
    Mk("TextLabel",{Size=UDim2.new(0.65,0,1,0),Position=UDim2.new(0,20,0,0),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.Gotham,TextSize=13,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,Parent=top})
    local valLbl=Mk("TextLabel",{Size=UDim2.new(0.35,0,1,0),Position=UDim2.new(0.65,0,0,0),BackgroundTransparency=1,
        Text=tostring(def)..(suffix or ""),Font=Enum.Font.GothamBold,TextSize=12,TextColor3=T.Accent,
        TextXAlignment=Enum.TextXAlignment.Right,Parent=top})

    -- track
    local track=Mk("Frame",{Size=UDim2.new(1,0,0,6),Position=UDim2.new(0,0,0,34),
        BackgroundColor3=T.SlBg,BorderSizePixel=0,Parent=cont})
    Corner(track,4)

    local pct=(val-min)/(max-min)
    local fill=Mk("Frame",{Size=UDim2.new(pct,0,1,0),BackgroundColor3=T.Accent,BorderSizePixel=0,Parent=track})
    Corner(fill,4)
    GradH(fill,ColorSequence.new(T.Accent,T.Cyan))

    local knob=Mk("Frame",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(pct,-8,0.5,-8),
        BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=3,Parent=track})
    Corner(knob,8)
    Stroke(knob,T.Accent,1.5,.2)

    -- hit area maior (mobile friendly)
    local hit=Mk("TextButton",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0.5,-14),
        BackgroundTransparency=1,Text="",BorderSizePixel=0,ZIndex=4,Parent=track})

    local function SetSlider(absX)
        local rel=math.clamp((absX-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
        val=math.floor(min+(max-min)*rel)
        valLbl.Text=tostring(val)..(suffix or "")
        Tw(fill,{Size=UDim2.new(rel,0,1,0)},0.05)
        Tw(knob,{Position=UDim2.new(rel,-8,0.5,-8)},0.05)
        if cb then cb(val) end
    end

    hit.MouseButton1Down:Connect(function(x,y)
        dragging=true
        SetSlider(x)
        Tw(knob,{Size=UDim2.new(0,20,0,20),Position=UDim2.new(knob.Position.X.Scale,-10,0.5,-10)},0.1,Enum.EasingStyle.Back)
    end)
    hit.TouchLongPress:Connect(function(pos)
        dragging=true
    end)
    hit.TouchPan:Connect(function(pos,delta,vel,state)
        if state==Enum.UserInputState.Change then
            SetSlider(pos[1].X)
        end
        if state==Enum.UserInputState.End then
            dragging=false
            Tw(knob,{Size=UDim2.new(0,16,0,16)},0.1)
        end
    end)

    -- usar RunService para drag suave no PC
    local conn
    hit.MouseButton1Down:Connect(function()
        dragging=true
        Tw(knob,{Size=UDim2.new(0,20,0,20)},0.1,Enum.EasingStyle.Back)
        conn=RunService.RenderStepped:Connect(function()
            if not dragging then conn:Disconnect();return end
            SetSlider(Mou.X)
        end)
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 and dragging then
            dragging=false
            Tw(knob,{Size=UDim2.new(0,16,0,16)},0.1)
            if conn then conn:Disconnect() end
        end
    end)

    RegSearch(cont,text,nil)
    return cont,function() return val end
end

-- DROPDOWN
local function Dropdown(parent,iconName,text,opts,def,cb,order)
    local sel=def or opts[1] or ""
    local open=false
    local h0=38

    local cont=Mk("Frame",{Size=UDim2.new(1,0,0,h0),BackgroundTransparency=1,
        LayoutOrder=order or 0,ClipsDescendants=false,ZIndex=3,Parent=parent})

    local btn=Mk("TextButton",{Size=UDim2.new(1,0,0,36),BackgroundColor3=T.InBg,
        Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=4,Parent=cont})
    Corner(btn,8)
    local bStroke=Stroke(btn,T.InBorder,1,0)

    -- icon + label
    local bix=Icons.Make(btn,iconName,14,T.TxtMut);bix.Position=UDim2.new(0,10,0.5,-7)
    Mk("TextLabel",{Size=UDim2.new(0.45,0,1,0),Position=UDim2.new(0,30,0,0),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.TxtMut,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=btn})
    local selLbl=Mk("TextLabel",{Size=UDim2.new(0.4,0,1,0),Position=UDim2.new(0.48,0,0,0),BackgroundTransparency=1,
        Text=sel,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=btn})
    local arrow=Icons.Make(btn,"ChevronDown",13,T.Accent);arrow.Position=UDim2.new(1,-22,0.5,-6)

    local dList=Mk("Frame",{Size=UDim2.new(1,0,0,#opts*30+8),Position=UDim2.new(0,0,0,40),
        BackgroundColor3=Color3.fromRGB(15,15,23),BorderSizePixel=0,Visible=false,ZIndex=9,Parent=cont})
    Corner(dList,8);Stroke(dList,T.Accent,1,.3)
    Pad(dList,4,4,4,4);List(dList,Enum.FillDirection.Vertical,2)

    for _,opt in ipairs(opts) do
        local item=Mk("TextButton",{Size=UDim2.new(1,0,0,26),BackgroundColor3=Color3.fromRGB(20,18,30),
            Text=opt,Font=Enum.Font.Gotham,TextSize=12,TextColor3=T.TxtPri,
            AutoButtonColor=false,BorderSizePixel=0,ZIndex=10,Parent=dList})
        Corner(item,6)
        item.MouseEnter:Connect(function() Tw(item,{BackgroundColor3=Color3.fromRGB(30,22,50)},.1) end)
        item.MouseLeave:Connect(function() Tw(item,{BackgroundColor3=Color3.fromRGB(20,18,30)},.1) end)
        item.MouseButton1Click:Connect(function()
            sel=opt;selLbl.Text=opt;open=false;dList.Visible=false
            Tw(bStroke,{Color=T.InBorder},.15)
            Tw(arrow,{Rotation=0},.2)
            cont.Size=UDim2.new(1,0,0,h0)
            if cb then cb(opt) end
        end)
    end

    btn.MouseButton1Click:Connect(function()
        open=not open;dList.Visible=open
        Tw(bStroke,{Color=open and T.Accent or T.InBorder},.15)
        Tw(arrow,{Rotation=open and 180 or 0},.2)
        Tw(cont,{Size=UDim2.new(1,0,0,open and h0+#opts*32 or h0)},.2,Enum.EasingStyle.Quart)
    end)

    AnimPress(btn)
    RegSearch(cont,text,nil)
    return cont,function() return sel end
end

-- MULTI DROPDOWN
local function MultiDropdown(parent,iconName,text,opts,cb,order)
    local selected={}
    local open=false
    local h0=38

    local cont=Mk("Frame",{Size=UDim2.new(1,0,0,h0),BackgroundTransparency=1,
        LayoutOrder=order or 0,ClipsDescendants=false,ZIndex=2,Parent=parent})

    local btn=Mk("TextButton",{Size=UDim2.new(1,0,0,36),BackgroundColor3=T.InBg,
        Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=3,Parent=cont})
    Corner(btn,8)
    local bStroke=Stroke(btn,T.InBorder,1,0)

    local bix=Icons.Make(btn,iconName,14,T.Cyan);bix.Position=UDim2.new(0,10,0.5,-7)
    Mk("TextLabel",{Size=UDim2.new(0.42,0,1,0),Position=UDim2.new(0,30,0,0),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.TxtMut,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=btn})
    local selLbl=Mk("TextLabel",{Size=UDim2.new(0.43,0,1,0),Position=UDim2.new(0.46,0,0,0),BackgroundTransparency=1,
        Text="Nenhum",Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.TxtMut,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=btn})
    local arrow2=Icons.Make(btn,"ChevronsUpDown",12,T.Cyan);arrow2.Position=UDim2.new(1,-22,0.5,-6)

    local dList=Mk("Frame",{Size=UDim2.new(1,0,0,#opts*30+8),Position=UDim2.new(0,0,0,40),
        BackgroundColor3=Color3.fromRGB(14,14,21),BorderSizePixel=0,Visible=false,ZIndex=8,Parent=cont})
    Corner(dList,8);Stroke(dList,T.Cyan,1,.4)
    Pad(dList,4,4,4,4);List(dList,Enum.FillDirection.Vertical,2)

    local function UpdLabel()
        if #selected==0 then selLbl.Text="Nenhum";selLbl.TextColor3=T.TxtMut
        else selLbl.Text=table.concat(selected,", ");selLbl.TextColor3=T.TxtPri end
    end

    for _,opt in ipairs(opts) do
        local chk=false
        local row=Mk("TextButton",{Size=UDim2.new(1,0,0,26),BackgroundColor3=Color3.fromRGB(18,16,28),
            Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=9,Parent=dList})
        Corner(row,6)
        local box=Mk("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,6,0.5,-7),
            BackgroundColor3=T.TogOff,BorderSizePixel=0,ZIndex=10,Parent=row})
        Corner(box,4)
        local chkIc=Icons.Make(box,"Check",10,Color3.fromRGB(255,255,255))
        chkIc.Position=UDim2.new(0.5,-5,0.5,-5);chkIc.Visible=false
        Mk("TextLabel",{Size=UDim2.new(1,-28,1,0),Position=UDim2.new(0,26,0,0),BackgroundTransparency=1,
            Text=opt,Font=Enum.Font.Gotham,TextSize=12,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=10,Parent=row})
        row.MouseEnter:Connect(function() Tw(row,{BackgroundColor3=Color3.fromRGB(26,20,40)},.1) end)
        row.MouseLeave:Connect(function() Tw(row,{BackgroundColor3=Color3.fromRGB(18,16,28)},.1) end)
        row.MouseButton1Click:Connect(function()
            chk=not chk
            if chk then table.insert(selected,opt);Tw(box,{BackgroundColor3=T.Cyan},.15);chkIc.Visible=true
            else for i,v in ipairs(selected) do if v==opt then table.remove(selected,i);break end end
                Tw(box,{BackgroundColor3=T.TogOff},.15);chkIc.Visible=false
            end
            UpdLabel();if cb then cb(selected) end
        end)
    end

    btn.MouseButton1Click:Connect(function()
        open=not open;dList.Visible=open
        Tw(bStroke,{Color=open and T.Cyan or T.InBorder},.15)
        Tw(cont,{Size=UDim2.new(1,0,0,open and h0+#opts*32 or h0)},.2,Enum.EasingStyle.Quart)
    end)

    AnimPress(btn)
    RegSearch(cont,text,nil)
    return cont,function() return selected end
end

-- TEXTBOX
local function Textbox(parent,iconName,placeholder,cb,order)
    local r=Mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local box=Mk("TextBox",{Size=UDim2.new(1,0,1,0),BackgroundColor3=T.InBg,Text="",
        PlaceholderText=placeholder or "Digite...",Font=Enum.Font.Gotham,TextSize=13,
        TextColor3=T.TxtPri,PlaceholderColor3=T.TxtMut,BorderSizePixel=0,ClearTextOnFocus=false,ZIndex=2,Parent=r})
    Corner(box,8)
    Pad(box,0,0,0,36)
    local s=Stroke(box,T.InBorder,1,0)
    local ix=Icons.Make(box,iconName,14,T.TxtMut);ix.Position=UDim2.new(0,10,0.5,-7)
    box.Focused:Connect(function() Tw(s,{Color=T.Accent},.15) end)
    box.FocusLost:Connect(function() Tw(s,{Color=T.InBorder},.15);if cb then cb(box.Text) end end)
    RegSearch(r,placeholder or "",nil)
    return r,box
end

-- KEYBIND
local function Keybind(parent,iconName,text,default,cb,order)
    local key=default or Enum.KeyCode.F
    local listening=false
    local r=Row(parent,iconName,text,36,order)

    local kbtn=Mk("TextButton",{Size=UDim2.new(0,82,0,26),Position=UDim2.new(1,-82,0.5,-13),
        BackgroundColor3=T.InBg,Text="["..key.Name.."]",Font=Enum.Font.GothamBold,TextSize=11,
        TextColor3=T.Accent,AutoButtonColor=false,BorderSizePixel=0,Parent=r})
    Corner(kbtn,6)
    local ks=Stroke(kbtn,T.InBorder,1,0)

    kbtn.MouseButton1Click:Connect(function()
        listening=true;kbtn.Text="...";kbtn.TextColor3=T.Warning;Tw(ks,{Color=T.Warning},.15)
    end)
    UIS.InputBegan:Connect(function(inp,gpe)
        if listening and inp.UserInputType==Enum.UserInputType.Keyboard then
            listening=false;key=inp.KeyCode
            kbtn.Text="["..key.Name.."]";kbtn.TextColor3=T.Accent;Tw(ks,{Color=T.InBorder},.15)
            if cb then cb(key) end
        end
    end)
    AnimPress(kbtn)
    RegSearch(r,text,nil)
    return r,function() return key end
end

-- COLOR PICKER simples
local function ColorPicker(parent,iconName,text,default,cb,order)
    local color=default or T.Accent
    local open=false

    local cont=Mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundTransparency=1,
        LayoutOrder=order or 0,ClipsDescendants=false,Parent=parent})

    local r=Row(cont,iconName,text,38,0)

    local prev=Mk("TextButton",{Size=UDim2.new(0,38,0,24),Position=UDim2.new(1,-38,0.5,-12),
        BackgroundColor3=color,Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=3,Parent=r})
    Corner(prev,8);Stroke(prev,color,1.5,.2)
    AnimPress(prev)

    -- Painel de pickers H/S/V
    local panel=Mk("Frame",{Size=UDim2.new(1,0,0,118),Position=UDim2.new(0,0,0,40),
        BackgroundColor3=Color3.fromRGB(14,14,22),BorderSizePixel=0,Visible=false,ZIndex=7,Parent=cont})
    Corner(panel,10);Stroke(panel,T.Accent,1,.3)
    Pad(panel,8,8,8,8);List(panel,Enum.FillDirection.Vertical,6)

    local h,s,v=color:ToHSV()

    local function Rebuild()
        color=Color3.fromHSV(h,s,v)
        prev.BackgroundColor3=color
        local ps=prev:FindFirstChildOfClass("UIStroke")
        if ps then ps.Color=color end
        if cb then cb(color) end
    end

    local function CPRow(label,initVal,gradA,gradB,setter)
        local row=Mk("Frame",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,ZIndex=8,Parent=panel})
        Mk("TextLabel",{Size=UDim2.new(0,12,1,0),BackgroundTransparency=1,Text=label,
            Font=Enum.Font.GothamBold,TextSize=9,TextColor3=T.TxtSec,ZIndex=8,Parent=row})
        local trk=Mk("Frame",{Size=UDim2.new(1,-16,0,6),Position=UDim2.new(0,16,0.5,-3),
            BackgroundColor3=gradA,BorderSizePixel=0,ZIndex=8,Parent=row})
        Corner(trk,3)
        GradH(trk,ColorSequence.new(gradA,gradB))
        local kn=Mk("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(initVal,-6,0.5,-6),
            BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=9,Parent=trk})
        Corner(kn,6);Stroke(kn,Color3.fromRGB(180,180,220),1,.3)

        local hit2=Mk("TextButton",{Size=UDim2.new(1,0,0,22),Position=UDim2.new(0,0,0.5,-11),
            BackgroundTransparency=1,Text="",BorderSizePixel=0,ZIndex=10,Parent=trk})

        local cpDrag=false
        local cpConn
        hit2.MouseButton1Down:Connect(function()
            cpDrag=true
            cpConn=RunService.RenderStepped:Connect(function()
                if not cpDrag then cpConn:Disconnect();return end
                local rel=math.clamp((Mou.X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X,0,1)
                kn.Position=UDim2.new(rel,-6,0.5,-6)
                setter(rel);Rebuild()
            end)
        end)
        UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 and cpDrag then
                cpDrag=false;if cpConn then cpConn:Disconnect() end
            end
        end)
    end

    CPRow("H",h,Color3.fromRGB(255,0,0),Color3.fromRGB(0,0,255),function(r) h=r end)
    CPRow("S",s,Color3.fromRGB(200,200,200),T.Accent,function(r) s=r end)
    CPRow("V",v,Color3.fromRGB(0,0,0),Color3.fromRGB(255,255,255),function(r) v=r end)

    prev.MouseButton1Click:Connect(function()
        open=not open;panel.Visible=open
        cont.Size=open and UDim2.new(1,0,0,160) or UDim2.new(1,0,0,38)
    end)

    RegSearch(cont,text,nil)
    return cont,function() return color end
end

-- ══════════════════════════════════════════════
-- SEARCH BAR (funcional — filtra AllComponents)
-- ══════════════════════════════════════════════
local function SearchBar(parent)
    local sb=Mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=T.InBg,BorderSizePixel=0,
        LayoutOrder=-99,Parent=parent})
    Corner(sb,10)
    local s=Stroke(sb,T.Border,1,0)
    local ix=Icons.Make(sb,"Search",15,T.TxtMut);ix.Position=UDim2.new(0,10,0.5,-7)
    local box=Mk("TextBox",{Size=UDim2.new(1,-42,1,0),Position=UDim2.new(0,32,0,0),
        BackgroundTransparency=1,Text="",PlaceholderText="Pesquisar...",
        Font=Enum.Font.Gotham,TextSize=13,TextColor3=T.TxtPri,PlaceholderColor3=T.TxtMut,
        BorderSizePixel=0,ClearTextOnFocus=false,Parent=sb})
    -- botão limpar
    local clrBtn=Icons.Make(sb,"CloseCircle",14,T.TxtMut);clrBtn.Position=UDim2.new(1,-26,0.5,-7)
    clrBtn.Visible=false
    -- makebutton
    local clrIB=Mk("ImageButton",{Size=UDim2.new(0,20,0,20),Position=UDim2.new(1,-24,0.5,-10),
        BackgroundTransparency=1,Image=Icons.Get("CloseCircle"),ImageColor3=T.TxtMut,Parent=sb})
    clrIB.Visible=false
    clrIB.MouseButton1Click:Connect(function()
        box.Text=""
        for _,c in pairs(AllComponents) do c.frame.Visible=true end
        clrIB.Visible=false
    end)

    box.Focused:Connect(function() Tw(s,{Color=T.Accent},.15) end)
    box.FocusLost:Connect(function() Tw(s,{Color=T.Border},.15) end)

    box:GetPropertyChangedSignal("Text"):Connect(function()
        local q=box.Text:lower()
        clrIB.Visible=#q>0
        if #q==0 then
            for _,c in pairs(AllComponents) do c.frame.Visible=true end
            return
        end
        for _,c in pairs(AllComponents) do
            local match=c.text:find(q,1,true)~=nil
            c.frame.Visible=match
        end
    end)

    return sb,box
end

-- ══════════════════════════════════════════════
-- ABAS + CONTEÚDO
-- ══════════════════════════════════════════════
local Tab1=CreateTab("Dashboard","Main",1)
local Tab2=CreateTab("Sliders","Config",2)
local Tab3=CreateTab("Palette","Visual",3)
local Tab4=CreateTab("Info","Info",4)

-- Activa aba 1
Tab1.Page.Visible=true;ActiveTab=Tab1
Tw(Tab1.Btn,{BackgroundColor3=Color3.fromRGB(20,16,38)},0)
Tw(Tab1.Icon,{ImageColor3=T.Accent},0)
Tw(Tab1.Lbl,{TextColor3=T.AccentBr},0)
Tab1.Ind.BackgroundTransparency=0

-- ─── ABA 1: MAIN ────────────────────────────
SearchBar(Tab1.Page)

local _,btnCard=Card(Tab1.Page,"Botões",1)
Label(btnCard,"Zap","Ações do Script","Botões com animação de clique",0)
Button(btnCard,"Power","Executar Script","primary",function() print("[Hub] Executado!") end,1)
Button(btnCard,"PowerOff","Parar Tudo","danger",function() print("[Hub] Parado!") end,2)
Button(btnCard,"Check","Confirmar","success",function() print("[Hub] Confirmado!") end,3)
Button(btnCard,"Copy","Copiar Chave","primary",function() print("[Hub] Copiado!") end,4)

local _,togCard=Card(Tab1.Page,"Toggles",2)
Label(togCard,"Activity","Funções Ativas","Ative ou desative recursos",0)
Toggle(togCard,"Eye","ESP Jogadores",false,function(v) print("[Hub] ESP:",v) end,1)
Toggle(togCard,"Crosshair","Aimbot",false,function(v) print("[Hub] Aimbot:",v) end,2)
Toggle(togCard,"Shield","God Mode",true,function(v) print("[Hub] GodMode:",v) end,3)
Toggle(togCard,"Navigation","No Clip",false,function(v) print("[Hub] Noclip:",v) end,4)
Toggle(togCard,"Gauge","Fly",false,function(v) print("[Hub] Fly:",v) end,5)

local _,ddCard=Card(Tab1.Page,"Dropdowns",3)
Label(ddCard,"Menu","Seleções","Dropdowns simples e múltiplos",0)
Dropdown(ddCard,"Grid","Modo ESP",{"Caixas","Esqueleto","Chams","Wireframe"},"Caixas",function(v) print("[Hub] ESP:",v) end,1)
MultiDropdown(ddCard,"Players","Times Visíveis",{"Time Azul","Time Vermelho","Spectators","NPCs"},function(v) print("[Hub] Times:",table.concat(v,", ")) end,2)

-- ─── ABA 2: CONFIG ──────────────────────────
local _,sldCard=Card(Tab2.Page,"Sliders",1)
Label(sldCard,"SlidersH","Valores Numéricos","Arraste para ajustar",0)
Slider(Tab2.Page,"Crosshair","FOV do Aimbot",0,500,120,"px",function(v) print("[Hub] FOV:",v) end,1)
Slider(Tab2.Page,"Gauge","Walk Speed",16,250,16,"",function(v) print("[Hub] Speed:",v) end,2)
Slider(Tab2.Page,"Zap","Jump Power",50,400,50,"",function(v) print("[Hub] Jump:",v) end,3)
Slider(Tab2.Page,"Bomb","Hit Multiplier",1,10,1,"x",function(v) print("[Hub] HitMul:",v) end,4)

local _,inputCard=Card(Tab2.Page,"Inputs",2)
Label(inputCard,"Edit","Campos de Texto","Textbox + Keybinds",0)
Textbox(inputCard,"Search","Nome do Alvo...",function(v) print("[Hub] Alvo:",v) end,1)
Textbox(inputCard,"Link","Webhook Discord...",function(v) print("[Hub] Hook:",v) end,2)

local _,kbCard=Card(Tab2.Page,"Keybinds",3)
Label(kbCard,"Keyboard","Teclas de Atalho","Clique no botão e pressione a tecla",0)
Keybind(kbCard,"Menu","Abrir/Fechar UI",Enum.KeyCode.RightShift,function(k) print("[Hub] UIKey:",k.Name) end,1)
Keybind(kbCard,"Crosshair","Toggle Aimbot",Enum.KeyCode.V,function(k) print("[Hub] AimKey:",k.Name) end,2)
Keybind(kbCard,"Navigation","Toggle Fly",Enum.KeyCode.G,function(k) print("[Hub] FlyKey:",k.Name) end,3)

-- ─── ABA 3: VISUAL ──────────────────────────
local _,colCard=Card(Tab3.Page,"Color Picker",1)
Label(colCard,"Palette","Cores dos Elementos","Clique na cor para abrir o picker",0)
ColorPicker(Tab3.Page,"Eye","Cor do ESP",T.Cyan,function(c) print("[Hub] ESPColor:",c) end,1)
ColorPicker(Tab3.Page,"Crosshair","Cor do FOV Circle",T.Accent,function(c) print("[Hub] FOVColor:",c) end,2)
ColorPicker(Tab3.Page,"Shield","Cor do Chams",T.Danger,function(c) print("[Hub] ChamsColor:",c) end,3)

local _,thCard=Card(Tab3.Page,"Tema",2)
Label(thCard,"Wand2","Aparência da UI","Visual e transparência",0)
Toggle(thCard,"Star","Neon Intenso",true,function(v) print("[Hub] Neon:",v) end,1)
Toggle(thCard,"Grid","Mostrar FPS",false,function(v) print("[Hub] FPS:",v) end,2)
Slider(Tab3.Page,"Minimize","Transparência da UI",0,90,10,"%",function(v) print("[Hub] Transp:",v) end,3)
Dropdown(Tab3.Page,"Palette","Esquema de Cores",{"Roxo Neon","Ciano Neon","Verde Neon","Vermelho"},"Roxo Neon",function(v) print("[Hub] Theme:",v) end,4)

-- ─── ABA 4: INFO ────────────────────────────
local _,abCard=Card(Tab4.Page,"Sobre o Hub",1)
Label(abCard,"Crown","Premium Hub v3","Interface avançada CoiledTom",0)
Label(abCard,"Code","Build","Roblox Executor UI — Luau",1)
Label(abCard,"Bot","Autor","CoiledTom",2)
Label(abCard,"Globe","Discord","discord.gg/coiledtom",3)
Label(abCard,"Clock","Status","Online",4)

local _,actCard=Card(Tab4.Page,"Ações",2)
Button(actCard,"RefreshCw","Verificar Atualizações","primary",function() print("[Hub] Check update") end,1)
Button(actCard,"Copy","Copiar Discord","success",function() print("[Hub] Discord copiado!") end,2)
Button(actCard,"Trash","Resetar Configs","danger",function() print("[Hub] Reset configs") end,3)

-- ══════════════════════════════════════════════
-- NOTIFICAÇÃO
-- ══════════════════════════════════════════════
local function Notify(iconName,title,msg,dur)
    local n=Mk("Frame",{Size=UDim2.new(0,270,0,62),Position=UDim2.new(1,10,1,-80),
        BackgroundColor3=Color3.fromRGB(15,15,23),BorderSizePixel=0,ZIndex=25,Parent=SG})
    Corner(n,12);Stroke(n,T.Accent,1.5,.2)
    Mk("Frame",{Size=UDim2.new(0,3,0.7,0),Position=UDim2.new(0,0,0.15,0),BackgroundColor3=T.Accent,BorderSizePixel=0,ZIndex=26,Parent=n})
    local ic2=Icons.Make(n,iconName,16,T.Accent);ic2.Position=UDim2.new(0,14,0.5,-14)
    Mk("TextLabel",{Size=UDim2.new(1,-40,0,22),Position=UDim2.new(0,36,0,8),BackgroundTransparency=1,
        Text=title,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=T.TxtPri,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=26,Parent=n})
    Mk("TextLabel",{Size=UDim2.new(1,-40,0,16),Position=UDim2.new(0,36,0,30),BackgroundTransparency=1,
        Text=msg,Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.TxtSec,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=26,Parent=n})
    Tw(n,{Position=UDim2.new(1,-282,1,-80)},.35,Enum.EasingStyle.Back)
    task.delay(dur or 3,function()
        Tw(n,{Position=UDim2.new(1,10,1,-80)},.25)
        task.delay(.28,function() pcall(function() n:Destroy() end) end)
    end)
end

task.delay(.6,function()
    Notify("CheckCircle","Premium Hub","UI carregada com sucesso!",4)
end)

print("[PremiumHub v3] Carregado!")
