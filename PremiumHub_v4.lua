-- ╔══════════════════════════════════════════════════════════╗
-- ║  PREMIUM HUB v4 · CoiledTom · Compact Mobile Edition   ║
-- ╚══════════════════════════════════════════════════════════╝
-- • FAB arrastável com ícone
-- • Notificações automáticas (intocáveis, exceto confirm)
-- • Abas com 2 painéis lado a lado
-- • Botões com descrição abaixo
-- • Topbar: logo | nome | autor | versão | "Premium"
-- • Sliders: notificação ao soltar
-- • Search funcional em tempo real

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local CoreGui      = game:GetService("CoreGui")
local LP           = Players.LocalPlayer
local Mouse        = LP:GetMouse()

-- ──────────────────────────────────────────────
-- ICONS (embutido)
-- ──────────────────────────────────────────────
local ICO = {
    Home="rbxassetid://10723418816",Settings="rbxassetid://10709810948",
    Player="rbxassetid://10747373176",Players="rbxassetid://10747373426",
    Shield="rbxassetid://10747344282",Eye="rbxassetid://10723346959",
    EyeOff="rbxassetid://10723346871",Star="rbxassetid://10747344524",
    Crosshair="rbxassetid://10709818534",Target="rbxassetid://10747364539",
    Sword="rbxassetid://10747364168",Zap="rbxassetid://10747385083",
    Flame="rbxassetid://10723376114",Crown="rbxassetid://10709818626",
    Close="rbxassetid://10747384394",CloseCircle="rbxassetid://10747383819",
    Check="rbxassetid://10709790644",CheckCircle="rbxassetid://10709790387",
    Plus="rbxassetid://10747318400",Minus="rbxassetid://10747257869",
    Edit="rbxassetid://10734883598",Copy="rbxassetid://10709812159",
    Trash="rbxassetid://10747364810",Save="rbxassetid://10747340064",
    Download="rbxassetid://10723344270",Search="rbxassetid://10747341119",
    RefreshCw="rbxassetid://10747327103",Lock="rbxassetid://10747249327",
    Key="rbxassetid://10723418959",Power="rbxassetid://10747319779",
    PowerOff="rbxassetid://10747319563",ChevronDown="rbxassetid://10709790948",
    ChevronUp="rbxassetid://10709791523",ChevronsUpDown="rbxassetid://10709797508",
    Info="rbxassetid://10723419156",Bell="rbxassetid://10709775704",
    AlertCircle="rbxassetid://10709752996",Sliders="rbxassetid://10747343494",
    SlidersH="rbxassetid://10747343325",Dashboard="rbxassetid://10723419420",
    Maximize="rbxassetid://10747254756",Minimize="rbxassetid://10747255073",
    Menu="rbxassetid://10747255467",Palette="rbxassetid://10747316827",
    Keyboard="rbxassetid://10723419295",Code="rbxassetid://10709810463",
    Wrench="rbxassetid://10747383470",Activity="rbxassetid://10709752035",
    Radar="rbxassetid://10747322877",Gauge="rbxassetid://10723395708",
    Navigation="rbxassetid://10747261479",Clock="rbxassetid://10709805144",
    Award="rbxassetid://10709769406",MessageSquare="rbxassetid://10747256154",
    Bot="rbxassetid://10709782230",Wand2="rbxassetid://10747376349",
    Grid="rbxassetid://10723404459",Tag="rbxassetid://10747363934",
    Fingerprint="rbxassetid://10723375250",EyeDropper="rbxassetid://104794806183086",
    Dumbbell="rbxassetid://18273453053",Globe="rbxassetid://10723404278",
    Gamepad="rbxassetid://10723395457",Bomb="rbxassetid://10709781460",
}
local function Ico(parent,name,sz,col)
    local i=Instance.new("ImageLabel")
    i.Name="Ic_"..name;i.Size=UDim2.new(0,sz or 14,0,sz or 14)
    i.BackgroundTransparency=1;i.Image=ICO[name] or ICO["Info"]
    i.ImageColor3=col or Color3.fromRGB(190,190,215);i.ScaleType=Enum.ScaleType.Fit
    i.Parent=parent;return i
end

-- ──────────────────────────────────────────────
-- TEMA
-- ──────────────────────────────────────────────
local C={
    Bg=Color3.fromRGB(9,9,12),BgAlt=Color3.fromRGB(12,12,17),
    Card=Color3.fromRGB(16,16,22),CardH=Color3.fromRGB(20,18,30),
    Border=Color3.fromRGB(30,30,46),
    Acc=Color3.fromRGB(108,68,255),AccBr=Color3.fromRGB(148,98,255),
    AccSoft=Color3.fromRGB(65,42,155),Cyan=Color3.fromRGB(52,210,255),
    Ok=Color3.fromRGB(50,205,100),Err=Color3.fromRGB(255,60,60),
    Warn=Color3.fromRGB(255,190,50),
    T1=Color3.fromRGB(232,232,252),T2=Color3.fromRGB(135,135,170),T3=Color3.fromRGB(65,65,95),
    TogOff=Color3.fromRGB(36,36,52),SBar=Color3.fromRGB(45,45,68),
    InBg=Color3.fromRGB(14,14,20),InBd=Color3.fromRGB(40,40,60),
}

-- ──────────────────────────────────────────────
-- UTILS
-- ──────────────────────────────────────────────
local function Tw(o,p,d,s,dr)
    TweenService:Create(o,TweenInfo.new(d or .18,s or Enum.EasingStyle.Quart,dr or Enum.EasingDirection.Out),p):Play()
end
local function Rnd(o,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 8);c.Parent=o;return c end
local function Strk(o,col,th) local s=Instance.new("UIStroke");s.Color=col or C.Border;s.Thickness=th or 1;s.Parent=o;return s end
local function Pad(o,t,r,b,l)
    local p=Instance.new("UIPadding")
    p.PaddingTop=UDim.new(0,t or 6);p.PaddingRight=UDim.new(0,r or 6)
    p.PaddingBottom=UDim.new(0,b or 6);p.PaddingLeft=UDim.new(0,l or 6)
    p.Parent=o
end
local function VList(o,sp)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Vertical
    l.Padding=UDim.new(0,sp or 6);l.SortOrder=Enum.SortOrder.LayoutOrder
    l.HorizontalAlignment=Enum.HorizontalAlignment.Left;l.Parent=o;return l
end
local function HList(o,sp)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Horizontal
    l.Padding=UDim.new(0,sp or 6);l.SortOrder=Enum.SortOrder.LayoutOrder
    l.VerticalAlignment=Enum.VerticalAlignment.Center;l.Parent=o;return l
end
local function Mk(cls,props)
    local o=Instance.new(cls)
    for k,v in pairs(props) do if k~="Parent" then o[k]=v end end
    if props.Parent then o.Parent=props.Parent end;return o
end
local function GradV(o,a,b)
    local g=Instance.new("UIGradient");g.Rotation=90;g.Color=ColorSequence.new(a,b);g.Parent=o
end
local function GradH(o,seq)
    local g=Instance.new("UIGradient");g.Color=seq;g.Parent=o
end

-- Press bounce
local function Bounce(btn,w,h)
    btn.MouseButton1Down:Connect(function()
        Tw(btn,{Size=UDim2.new(0,w-4,0,h-3)},.07,Enum.EasingStyle.Quad)
    end)
    btn.MouseButton1Up:Connect(function()
        Tw(btn,{Size=UDim2.new(0,w,0,h)},.13,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    end)
end

-- ──────────────────────────────────────────────
-- SCREENGU
-- ──────────────────────────────────────────────
pcall(function() if CoreGui:FindFirstChild("PHv4") then CoreGui.PHv4:Destroy() end end)
local SG=Mk("ScreenGui",{Name="PHv4",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
pcall(function() SG.Parent=CoreGui end)
if SG.Parent~=CoreGui then SG.Parent=LP.PlayerGui end
SG.Name="PHv4"

-- ──────────────────────────────────────────────
-- SISTEMA DE NOTIFICAÇÕES
-- ──────────────────────────────────────────────
local notifY = -10  -- offset empilhamento
local NOTIF_QUEUE = {}

local function Notif(icon, title, msg, kind, dur, onAccept, onDecline)
    -- kind: "info"|"ok"|"warn"|"err"|"confirm"
    local accentCol = kind=="ok" and C.Ok or kind=="err" and C.Err or kind=="warn" and C.Warn or C.Acc
    local isConfirm = kind=="confirm"
    local hNotif = isConfirm and 78 or 58

    local nx = Mk("Frame",{
        Size=UDim2.new(0,260,0,hNotif),
        Position=UDim2.new(1,10,0,10),
        BackgroundColor3=Color3.fromRGB(13,13,20),
        BorderSizePixel=0,ZIndex=50,Parent=SG,
    })
    Rnd(nx,10);Strk(nx,accentCol,1)
    -- barra lateral colorida
    Mk("Frame",{Size=UDim2.new(0,3,0.7,0),Position=UDim2.new(0,0,0.15,0),
        BackgroundColor3=accentCol,BorderSizePixel=0,ZIndex=51,Parent=nx})
    -- ícone
    local ic=Ico(nx,icon or "Bell",14,accentCol);ic.Position=UDim2.new(0,12,0,10)
    -- título
    Mk("TextLabel",{Size=UDim2.new(1,-38,0,18),Position=UDim2.new(0,32,0,8),
        BackgroundTransparency=1,Text=title,Font=Enum.Font.GothamBold,TextSize=12,
        TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=51,Parent=nx})
    -- mensagem
    Mk("TextLabel",{Size=UDim2.new(1,-38,0,14),Position=UDim2.new(0,32,0,26),
        BackgroundTransparency=1,Text=msg,Font=Enum.Font.Gotham,TextSize=10,
        TextColor3=C.T2,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=51,Parent=nx})

    if isConfirm then
        -- Botões aceitar / recusar
        local bOk=Mk("TextButton",{Size=UDim2.new(0,80,0,22),Position=UDim2.new(0,10,0,50),
            BackgroundColor3=C.Ok,Text="Aceitar",Font=Enum.Font.GothamBold,TextSize=11,
            TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false,BorderSizePixel=0,ZIndex=52,Parent=nx})
        Rnd(bOk,6)
        local bNo=Mk("TextButton",{Size=UDim2.new(0,80,0,22),Position=UDim2.new(0.5,-10,0,50),
            BackgroundColor3=C.Err,Text="Recusar",Font=Enum.Font.GothamBold,TextSize=11,
            TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false,BorderSizePixel=0,ZIndex=52,Parent=nx})
        Rnd(bNo,6)
        bOk.MouseButton1Click:Connect(function()
            if onAccept then onAccept() end
            Tw(nx,{Position=UDim2.new(1,10,0,10)},.2)
            task.delay(.22,function() pcall(function() nx:Destroy() end) end)
        end)
        bNo.MouseButton1Click:Connect(function()
            if onDecline then onDecline() end
            Tw(nx,{Position=UDim2.new(1,10,0,10)},.2)
            task.delay(.22,function() pcall(function() nx:Destroy() end) end)
        end)
    else
        -- NÃO INTERATIVA: ignora input
        nx.Active=false;nx.Selectable=false
    end

    -- entrada deslizando da direita
    Tw(nx,{Position=UDim2.new(1,-270,0,10)},.3,Enum.EasingStyle.Back)
    if not isConfirm then
        task.delay(dur or 2.5,function()
            Tw(nx,{Position=UDim2.new(1,10,0,10)},.22)
            task.delay(.24,function() pcall(function() nx:Destroy() end) end)
        end)
    end
    return nx
end

-- ──────────────────────────────────────────────
-- FAB — ARRASTÁVEL
-- ──────────────────────────────────────────────
local FAB=Mk("TextButton",{
    Name="FAB",Size=UDim2.new(0,48,0,48),
    Position=UDim2.new(1,-62,1,-70),
    BackgroundColor3=C.Acc,Text="",AutoButtonColor=false,
    BorderSizePixel=0,ZIndex=40,Parent=SG,
})
Rnd(FAB,24);Strk(FAB,C.AccBr,1)
GradV(FAB,C.AccBr,C.AccSoft)
local fabIco=Ico(FAB,"Menu",20,Color3.fromRGB(255,255,255))
fabIco.Position=UDim2.new(0.5,-10,0.5,-10)

-- pulsing
spawn(function()
    while FAB and FAB.Parent do
        Tw(FAB,{BackgroundColor3=C.AccBr},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.8)
        Tw(FAB,{BackgroundColor3=C.AccSoft},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.8)
    end
end)

-- Drag FAB
local fabDrag,fabDragStart,fabDragPos=false,nil,nil
FAB.InputBegan:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
        fabDrag=false;fabDragStart=inp.Position
        fabDragPos=FAB.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch)
    and fabDragStart then
        local d=inp.Position-fabDragStart
        if math.abs(d.X)>4 or math.abs(d.Y)>4 then
            fabDrag=true
            FAB.Position=UDim2.new(fabDragPos.X.Scale,fabDragPos.X.Offset+d.X,fabDragPos.Y.Scale,fabDragPos.Y.Offset+d.Y)
        end
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
        fabDragStart=nil
    end
end)

-- ──────────────────────────────────────────────
-- JANELA PRINCIPAL (compacta)
-- ──────────────────────────────────────────────
local WIN=Mk("Frame",{
    Name="Win",Size=UDim2.new(0,680,0,460),
    Position=UDim2.new(0.5,-340,0.5,-240),
    BackgroundColor3=C.Bg,BorderSizePixel=0,
    ClipsDescendants=true,Visible=false,ZIndex=2,Parent=SG,
})
Rnd(WIN,14);Strk(WIN,C.Acc,1)

-- linha topo gradiente
local tl=Mk("Frame",{Size=UDim2.new(1,0,0,2),BackgroundColor3=C.Acc,BorderSizePixel=0,ZIndex=10,Parent=WIN})
GradH(tl,ColorSequence.new({ColorSequenceKeypoint.new(0,C.Acc),ColorSequenceKeypoint.new(.5,C.Cyan),ColorSequenceKeypoint.new(1,C.Acc)}))

local hubOpen=false
local function ToggleWin()
    hubOpen=not hubOpen
    if hubOpen then
        WIN.BackgroundTransparency=1;WIN.Visible=true
        WIN.Position=UDim2.new(0.5,-340,0.5,-220)
        Tw(WIN,{BackgroundTransparency=0,Position=UDim2.new(0.5,-340,0.5,-230)},.3,Enum.EasingStyle.Quart)
        fabIco.Image=ICO["Close"]
    else
        Tw(WIN,{BackgroundTransparency=1,Position=UDim2.new(0.5,-340,0.5,-210)},.22,Enum.EasingStyle.Quart)
        task.delay(.24,function() WIN.Visible=false end)
        fabIco.Image=ICO["Menu"]
    end
end

FAB.MouseButton1Click:Connect(function()
    if fabDrag then return end
    Tw(FAB,{Size=UDim2.new(0,42,0,42)},.07,Enum.EasingStyle.Quad)
    task.delay(.08,function() Tw(FAB,{Size=UDim2.new(0,48,0,48)},.13,Enum.EasingStyle.Back) end)
    ToggleWin()
end)

-- ──────────────────────────────────────────────
-- TOPBAR
-- ──────────────────────────────────────────────
local TB=Mk("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.BgAlt,BorderSizePixel=0,ZIndex=5,Parent=WIN})

-- Drag via topbar
local wDrag,wDragStart,wDragPos=false,nil,nil
TB.InputBegan:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 then
        wDrag=true;wDragStart=inp.Position;wDragPos=WIN.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if wDrag and inp.UserInputType==Enum.UserInputType.MouseMovement then
        local d=inp.Position-wDragStart
        WIN.Position=UDim2.new(wDragPos.X.Scale,wDragPos.X.Offset+d.X,wDragPos.Y.Scale,wDragPos.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 then wDrag=false end
end)

-- logo dot
local dot=Mk("Frame",{Size=UDim2.new(0,7,0,7),Position=UDim2.new(0,12,0.5,-3),BackgroundColor3=C.Acc,BorderSizePixel=0,ZIndex=6,Parent=TB})
Rnd(dot,4)
spawn(function()
    while WIN and WIN.Parent do
        Tw(dot,{BackgroundColor3=C.Cyan},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.8)
        Tw(dot,{BackgroundColor3=C.Acc},.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut);wait(.8)
    end
end)

-- título
Mk("TextLabel",{Size=UDim2.new(0,110,0,18),Position=UDim2.new(0,24,0,6),BackgroundTransparency=1,
    Text="PREMIUM HUB",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.T1,
    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=TB})

-- badge "Premium"
local badge=Mk("Frame",{Size=UDim2.new(0,58,0,16),Position=UDim2.new(0,134,0,8),BackgroundColor3=C.Acc,BorderSizePixel=0,ZIndex=6,Parent=TB})
Rnd(badge,8)
GradV(badge,C.AccBr,C.AccSoft)
Mk("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="Premium",Font=Enum.Font.GothamBold,
    TextSize=9,TextColor3=Color3.fromRGB(255,255,255),ZIndex=7,Parent=badge})

-- v4 pequeno
Mk("TextLabel",{Size=UDim2.new(0,24,0,14),Position=UDim2.new(0,196,0,10),BackgroundTransparency=1,
    Text="v4",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.Acc,ZIndex=6,Parent=TB})

-- autor (editável — mude aqui)
local AUTHOR_NAME = "CoiledTom"
-- ícone do autor (pequeno bot ao lado)
local authorIcon=Ico(TB,"Bot",11,C.T3);authorIcon.Position=UDim2.new(0,222,0.5,-5)
Mk("TextLabel",{Size=UDim2.new(0,80,0,13),Position=UDim2.new(0,236,0.5,-6),BackgroundTransparency=1,
    Text=AUTHOR_NAME,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.T3,
    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=TB})

-- botões topbar direita
local function TBBtn(ico,col,xOff,cb)
    local b=Mk("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,xOff,0.5,-13),
        BackgroundColor3=Color3.fromRGB(22,22,32),Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=7,Parent=TB})
    Rnd(b,7)
    local ic=Ico(b,ico,13,col);ic.Position=UDim2.new(0.5,-6,0.5,-6)
    b.MouseEnter:Connect(function() Tw(b,{BackgroundColor3=col},.12);ic.ImageColor3=Color3.fromRGB(255,255,255) end)
    b.MouseLeave:Connect(function() Tw(b,{BackgroundColor3=Color3.fromRGB(22,22,32)},.12);ic.ImageColor3=col end)
    b.MouseButton1Click:Connect(cb);return b
end
TBBtn("Close",C.Err,-10,function() ToggleWin() end)
TBBtn("Minimize",C.Warn,-42,function()
    if WIN.Size.Y.Offset>50 then Tw(WIN,{Size=UDim2.new(0,680,0,44)},.25,Enum.EasingStyle.Quart)
    else Tw(WIN,{Size=UDim2.new(0,680,0,460)},.25,Enum.EasingStyle.Quart) end
end)

-- ──────────────────────────────────────────────
-- SIDEBAR (ícones estreitos)
-- ──────────────────────────────────────────────
local SB=Mk("Frame",{Size=UDim2.new(0,54,1,-44),Position=UDim2.new(0,0,0,44),BackgroundColor3=Color3.fromRGB(10,10,14),BorderSizePixel=0,Parent=WIN})
Mk("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=C.Border,BorderSizePixel=0,Parent=SB})
local SBList=Mk("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=SB})
VList(SBList,3)

-- Content area
local CA=Mk("Frame",{Size=UDim2.new(1,-54,1,-44),Position=UDim2.new(0,54,0,44),BackgroundColor3=C.BgAlt,BorderSizePixel=0,ClipsDescendants=true,Parent=WIN})

-- Search bar (acima das abas) — dentro de CA
local SearchFrame=Mk("Frame",{Size=UDim2.new(1,0,0,34),Position=UDim2.new(0,0,0,0),BackgroundColor3=C.InBg,BorderSizePixel=0,ZIndex=10,Parent=CA})
Strk(SearchFrame,C.Border,1)
local sfIco=Ico(SearchFrame,"Search",13,C.T3);sfIco.Position=UDim2.new(0,9,0.5,-6)
local SearchBox=Mk("TextBox",{Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,28,0,0),BackgroundTransparency=1,
    Text="",PlaceholderText="Pesquisar...",Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.T1,
    PlaceholderColor3=C.T3,BorderSizePixel=0,ClearTextOnFocus=false,ZIndex=11,Parent=SearchFrame})
SearchBox.Focused:Connect(function() Strk(SearchFrame,C.Acc,1) end)
SearchBox.FocusLost:Connect(function() Strk(SearchFrame,C.Border,1) end)
local ClearBtn=Mk("ImageButton",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(1,-26,0.5,-8),
    BackgroundTransparency=1,Image=ICO["CloseCircle"],ImageColor3=C.T3,Visible=false,ZIndex=12,Parent=SearchFrame})
ClearBtn.MouseButton1Click:Connect(function() SearchBox.Text="";ClearBtn.Visible=false end)

-- Conteúdo real (abaixo da search)
local CAPages=Mk("Frame",{Size=UDim2.new(1,0,1,-34),Position=UDim2.new(0,0,0,34),BackgroundTransparency=1,ClipsDescendants=true,Parent=CA})

-- ──────────────────────────────────────────────
-- SISTEMA ABAS
-- ──────────────────────────────────────────────
local Tabs={};local ActiveTab=nil
local AllItems={}  -- {frame, text} para search

local function RegSearch(f,t)
    table.insert(AllItems,{frame=f,text=t:lower()})
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q=SearchBox.Text:lower()
    ClearBtn.Visible=#q>0
    for _,e in pairs(AllItems) do
        e.frame.Visible=(#q==0 or e.text:find(q,1,true)~=nil)
    end
end)

local function MakeTab(icoName,label,order)
    local sb=Mk("TextButton",{Size=UDim2.new(1,-6,0,50),BackgroundColor3=Color3.fromRGB(13,13,18),
        Text="",AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=order,Parent=SBList})
    Rnd(sb,8)
    local ic=Ico(sb,icoName,18,C.T3);ic.Position=UDim2.new(0.5,-9,0,7)
    local lbl=Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-15),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.T3,ZIndex=2,Parent=sb})
    local ind=Mk("Frame",{Size=UDim2.new(0,3,0.55,0),Position=UDim2.new(0,-3,0.225,0),BackgroundColor3=C.Acc,BorderSizePixel=0,BackgroundTransparency=1,Parent=sb})
    Rnd(ind,3)

    -- Página = ScrollFrame que ocupa CAPages
    local page=Mk("ScrollingFrame",{Name=label,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.SBar,
        AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false,Parent=CAPages})
    Pad(page,8,8,8,8)
    VList(page,8)

    local tab={Btn=sb,Icon=ic,Lbl=lbl,Ind=ind,Page=page,Name=label}
    sb.MouseButton1Click:Connect(function()
        for _,t in pairs(Tabs) do
            t.Page.Visible=false
            Tw(t.Btn,{BackgroundColor3=Color3.fromRGB(13,13,18)},.15)
            Tw(t.Icon,{ImageColor3=C.T3},.15)
            Tw(t.Lbl,{TextColor3=C.T3},.15)
            Tw(t.Ind,{BackgroundTransparency=1},.15)
        end
        tab.Page.Visible=true;ActiveTab=tab
        Tw(sb,{BackgroundColor3=Color3.fromRGB(18,14,34)},.15)
        Tw(ic,{ImageColor3=C.Acc},.15)
        Tw(lbl,{TextColor3=C.AccBr},.15)
        Tw(ind,{BackgroundTransparency=0},.15)
    end)
    table.insert(Tabs,tab)
    return tab
end

-- ──────────────────────────────────────────────
-- DUAL PANEL (2 colunas dentro de uma aba)
-- ──────────────────────────────────────────────
-- Retorna (leftCol, rightCol) — adicione componentes em cada um
local function DualPanel(page,order)
    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundTransparency=1,LayoutOrder=order or 0,Parent=page})
    HList(wrap,6)
    local L=Mk("Frame",{Size=UDim2.new(0.5,-3,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundTransparency=1,Parent=wrap})
    VList(L,6)
    local R=Mk("Frame",{Size=UDim2.new(0.5,-3,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundTransparency=1,Parent=wrap})
    VList(R,6)
    return L,R
end

-- ──────────────────────────────────────────────
-- COMPONENTES COMPACTOS
-- ──────────────────────────────────────────────

-- CARD compacto
local function Card(parent,title,icoName,order)
    local c=Mk("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundColor3=C.Card,BorderSizePixel=0,LayoutOrder=order or 0,Parent=parent})
    Rnd(c,10);Strk(c,C.Border,1)
    local inner=Mk("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=c})
    Pad(inner,8,10,8,10);VList(inner,6)
    if title then
        local hdr=Mk("Frame",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,LayoutOrder=-1,Parent=inner})
        if icoName then
            local hi=Ico(hdr,icoName,12,C.Acc);hi.Position=UDim2.new(0,0,0.5,-6)
        end
        local xOff=icoName and 18 or 0
        Mk("TextLabel",{Size=UDim2.new(1,-xOff,1,0),Position=UDim2.new(0,xOff,0,0),BackgroundTransparency=1,
            Text=title:upper(),Font=Enum.Font.GothamBold,TextSize=9,TextColor3=C.T2,
            TextXAlignment=Enum.TextXAlignment.Left,Parent=hdr})
        Mk("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=C.Border,BorderSizePixel=0,LayoutOrder=0,Parent=inner})
    end
    return c,inner
end

-- BUTTON com descrição abaixo
local function Button(parent,icoName,label,desc,style,cb,order)
    local bgc=style=="primary" and C.Acc or style=="ok" and C.Ok or style=="err" and C.Err or C.Card
    local hBtn=desc and 46 or 34

    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,hBtn),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local btn=Mk("TextButton",{Size=UDim2.new(1,0,0,30),BackgroundColor3=bgc,Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=2,Parent=wrap})
    Rnd(btn,8)
    if style=="primary" then GradV(btn,C.AccBr,C.AccSoft) end

    if icoName then
        local bi=Ico(btn,icoName,12,Color3.fromRGB(255,255,255));bi.Position=UDim2.new(0,10,0.5,-6)
    end
    local tOff=icoName and 28 or 10
    Mk("TextLabel",{Size=UDim2.new(1,-tOff-6,1,0),Position=UDim2.new(0,tOff,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),
        TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3,Parent=btn})

    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,0,32),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end

    -- press bounce
    btn.MouseButton1Down:Connect(function() Tw(btn,{Size=UDim2.new(1,-4,0,27)},.07,Enum.EasingStyle.Quad) end)
    btn.MouseButton1Up:Connect(function() Tw(btn,{Size=UDim2.new(1,0,0,30)},.12,Enum.EasingStyle.Back) end)
    btn.MouseEnter:Connect(function() Tw(btn,{BackgroundColor3=C.AccBr},.12) end)
    btn.MouseLeave:Connect(function() Tw(btn,{BackgroundColor3=bgc},.12) end)
    btn.MouseButton1Click:Connect(function() if cb then cb() end end)

    RegSearch(wrap,label)
    return wrap
end

-- TOGGLE com descrição opcional
local function Toggle(parent,icoName,label,desc,default,cb,order)
    local state=default or false
    local h=desc and 46 or 34

    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local row=Mk("Frame",{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Parent=wrap})

    if icoName then local ri=Ico(row,icoName,13,C.T2);ri.Position=UDim2.new(0,0,0.5,-6) end
    local xo=icoName and 18 or 0
    Mk("TextLabel",{Size=UDim2.new(1,-(xo+50),1,0),Position=UDim2.new(0,xo,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})

    local track=Mk("TextButton",{Size=UDim2.new(0,40,0,20),Position=UDim2.new(1,-40,0.5,-10),
        BackgroundColor3=state and C.Acc or C.TogOff,Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=2,Parent=row})
    Rnd(track,10)
    local thumb=Mk("Frame",{Size=UDim2.new(0,14,0,14),
        Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7),
        BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=3,Parent=track})
    Rnd(thumb,7)

    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,xo,0,31),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end

    track.MouseButton1Click:Connect(function()
        state=not state
        Tw(track,{BackgroundColor3=state and C.Acc or C.TogOff},.18)
        Tw(thumb,{Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)},.18,Enum.EasingStyle.Back)
        local ico=state and "CheckCircle" or "EyeOff"
        Notif("Activity",label,state and "Ativado" or "Desativado","info",2)
        if cb then cb(state) end
    end)

    RegSearch(wrap,label)
    return wrap,function() return state end
end

-- SLIDER corrigido + notificação ao soltar
local function Slider(parent,icoName,label,desc,mn,mx,def,sfx,cb,order)
    mn=mn or 0;mx=mx or 100;def=def or mn
    local val=def;local slDrag=false;local slConn=nil

    local h=desc and 60 or 48
    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})

    -- top row
    local top=Mk("Frame",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Parent=wrap})
    if icoName then local si=Ico(top,icoName,12,C.T2);si.Position=UDim2.new(0,0,0.5,-6) end
    local xo2=icoName and 18 or 0
    Mk("TextLabel",{Size=UDim2.new(0.65,0,1,0),Position=UDim2.new(0,xo2,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,Parent=top})
    local valLbl=Mk("TextLabel",{Size=UDim2.new(0.35,-4,1,0),Position=UDim2.new(0.65,0,0,0),BackgroundTransparency=1,
        Text=tostring(def)..(sfx or ""),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.Acc,
        TextXAlignment=Enum.TextXAlignment.Right,Parent=top})

    -- track
    local trk=Mk("Frame",{Size=UDim2.new(1,0,0,5),Position=UDim2.new(0,0,0,24),BackgroundColor3=C.InBg,BorderSizePixel=0,Parent=wrap})
    Rnd(trk,4)

    local pct=(val-mn)/(mx-mn)
    local fill=Mk("Frame",{Size=UDim2.new(pct,0,1,0),BackgroundColor3=C.Acc,BorderSizePixel=0,Parent=trk})
    Rnd(fill,4);GradH(fill,ColorSequence.new(C.Acc,C.Cyan))

    local knob=Mk("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(pct,-7,0.5,-7),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=3,Parent=trk})
    Rnd(knob,7);Strk(knob,C.Acc,1)

    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,11),Position=UDim2.new(0,0,0,34),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end

    -- hit area grande (mobile)
    local hit=Mk("TextButton",{Size=UDim2.new(1,0,0,26),Position=UDim2.new(0,0,0.5,-13),
        BackgroundTransparency=1,Text="",BorderSizePixel=0,ZIndex=4,Parent=trk})

    local function SetVal(ax)
        local rel=math.clamp((ax-trk.AbsolutePosition.X)/trk.AbsoluteSize.X,0,1)
        val=math.floor(mn+(mx-mn)*rel)
        valLbl.Text=tostring(val)..(sfx or "")
        fill.Size=UDim2.new(rel,0,1,0)
        knob.Position=UDim2.new(rel,-7,0.5,-7)
        if cb then cb(val) end
    end

    hit.MouseButton1Down:Connect(function()
        slDrag=true
        Tw(knob,{Size=UDim2.new(0,18,0,18)},.1,Enum.EasingStyle.Back)
        SetVal(Mouse.X)
        slConn=RunService.RenderStepped:Connect(function()
            if not slDrag then slConn:Disconnect();return end
            SetVal(Mouse.X)
        end)
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 and slDrag then
            slDrag=false
            Tw(knob,{Size=UDim2.new(0,14,0,14)},.1)
            if slConn then slConn:Disconnect() end
            Notif("SlidersH",label,"Valor: "..tostring(val)..(sfx or ""),"info",2)
        end
    end)
    -- touch
    hit.TouchPan:Connect(function(pos,_,_,state)
        if state==Enum.UserInputState.Begin or state==Enum.UserInputState.Change then
            SetVal(pos[1].X)
        end
        if state==Enum.UserInputState.End then
            Notif("SlidersH",label,"Valor: "..tostring(val)..(sfx or ""),"info",2)
        end
    end)

    RegSearch(wrap,label)
    return wrap,function() return val end
end

-- DROPDOWN compacto
local function Dropdown(parent,icoName,label,opts,def,cb,order)
    local sel=def or opts[1] or "";local open=false;local H0=32
    local cont=Mk("Frame",{Size=UDim2.new(1,0,0,H0),BackgroundTransparency=1,LayoutOrder=order or 0,ClipsDescendants=false,ZIndex=3,Parent=parent})
    local btn=Mk("TextButton",{Size=UDim2.new(1,0,0,H0),BackgroundColor3=C.InBg,Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=4,Parent=cont})
    Rnd(btn,7);local bs=Strk(btn,C.InBd,1)
    if icoName then local di=Ico(btn,icoName,12,C.T2);di.Position=UDim2.new(0,8,0.5,-6) end
    local xo3=icoName and 24 or 8
    Mk("TextLabel",{Size=UDim2.new(0.42,0,1,0),Position=UDim2.new(0,xo3,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.T2,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=btn})
    local selLbl=Mk("TextLabel",{Size=UDim2.new(0.42,0,1,0),Position=UDim2.new(0.46,0,0,0),BackgroundTransparency=1,
        Text=sel,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5,Parent=btn})
    local arr=Ico(btn,"ChevronDown",11,C.Acc);arr.Position=UDim2.new(1,-20,0.5,-5)

    local dList=Mk("Frame",{Size=UDim2.new(1,0,0,#opts*26+6),Position=UDim2.new(0,0,0,H0+2),
        BackgroundColor3=Color3.fromRGB(12,12,20),BorderSizePixel=0,Visible=false,ZIndex=9,Parent=cont})
    Rnd(dList,7);Strk(dList,C.Acc,1);Pad(dList,3,3,3,3);VList(dList,2)

    for _,opt in ipairs(opts) do
        local it=Mk("TextButton",{Size=UDim2.new(1,0,0,22),BackgroundColor3=Color3.fromRGB(18,16,26),
            Text=opt,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.T1,AutoButtonColor=false,BorderSizePixel=0,ZIndex=10,Parent=dList})
        Rnd(it,5)
        it.MouseEnter:Connect(function() Tw(it,{BackgroundColor3=Color3.fromRGB(26,20,44)},.1) end)
        it.MouseLeave:Connect(function() Tw(it,{BackgroundColor3=Color3.fromRGB(18,16,26)},.1) end)
        it.MouseButton1Click:Connect(function()
            sel=opt;selLbl.Text=opt;open=false;dList.Visible=false
            Tw(bs,{Color=C.InBd},.12);Tw(arr,{Rotation=0},.15)
            Tw(cont,{Size=UDim2.new(1,0,0,H0)},.18,Enum.EasingStyle.Quart)
            Notif("Grid",label,"Selecionado: "..opt,"info",2)
            if cb then cb(opt) end
        end)
    end
    btn.MouseButton1Click:Connect(function()
        open=not open;dList.Visible=open
        Tw(bs,{Color=open and C.Acc or C.InBd},.12);Tw(arr,{Rotation=open and 180 or 0},.15)
        Tw(cont,{Size=UDim2.new(1,0,0,open and H0+#opts*28 or H0)},.18,Enum.EasingStyle.Quart)
    end)
    btn.MouseButton1Down:Connect(function() Tw(btn,{BackgroundColor3=Color3.fromRGB(18,16,30)},.08) end)
    btn.MouseButton1Up:Connect(function() Tw(btn,{BackgroundColor3=C.InBg},.12) end)
    RegSearch(cont,label)
    return cont,function() return sel end
end

-- TEXTBOX compacto
local function Textbox(parent,icoName,placeholder,desc,cb,order)
    local h=desc and 46 or 32
    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local box=Mk("TextBox",{Size=UDim2.new(1,0,0,30),BackgroundColor3=C.InBg,Text="",
        PlaceholderText=placeholder or "Digite...",Font=Enum.Font.Gotham,TextSize=12,
        TextColor3=C.T1,PlaceholderColor3=C.T3,BorderSizePixel=0,ClearTextOnFocus=false,ZIndex=2,Parent=wrap})
    Rnd(box,7)
    if icoName then local ti=Ico(box,icoName,12,C.T3);ti.Position=UDim2.new(0,8,0.5,-6) end
    local xo4=icoName and 26 or 8
    Pad(box,0,6,0,xo4)
    local bs2=Strk(box,C.InBd,1)
    box.Focused:Connect(function() Tw(bs2,{Color=C.Acc},.12) end)
    box.FocusLost:Connect(function() Tw(bs2,{Color=C.InBd},.12);if cb then cb(box.Text) end end)
    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,0,32),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end
    RegSearch(wrap,placeholder or "")
    return wrap,box
end

-- KEYBIND compacto
local function Keybind(parent,icoName,label,desc,default,cb,order)
    local key=default or Enum.KeyCode.F;local listening=false
    local h=desc and 46 or 32
    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    local row=Mk("Frame",{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Parent=wrap})
    if icoName then local ki=Ico(row,icoName,12,C.T2);ki.Position=UDim2.new(0,0,0.5,-6) end
    local xo5=icoName and 18 or 0
    Mk("TextLabel",{Size=UDim2.new(1,-(xo5+72),1,0),Position=UDim2.new(0,xo5,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
    local kbtn=Mk("TextButton",{Size=UDim2.new(0,68,0,22),Position=UDim2.new(1,-68,0.5,-11),
        BackgroundColor3=C.InBg,Text="["..key.Name.."]",Font=Enum.Font.GothamBold,TextSize=10,
        TextColor3=C.Acc,AutoButtonColor=false,BorderSizePixel=0,ZIndex=2,Parent=row})
    Rnd(kbtn,6);local ks=Strk(kbtn,C.InBd,1)
    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,xo5,0,32),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end
    kbtn.MouseButton1Click:Connect(function()
        listening=true;kbtn.Text="...";kbtn.TextColor3=C.Warn;Tw(ks,{Color=C.Warn},.12)
    end)
    UIS.InputBegan:Connect(function(inp,gpe)
        if listening and inp.UserInputType==Enum.UserInputType.Keyboard then
            listening=false;key=inp.KeyCode
            kbtn.Text="["..key.Name.."]";kbtn.TextColor3=C.Acc;Tw(ks,{Color=C.InBd},.12)
            Notif("Keyboard",label,"Tecla: "..key.Name,"ok",2)
            if cb then cb(key) end
        end
    end)
    Bounce(kbtn,68,22)
    RegSearch(wrap,label)
    return wrap,function() return key end
end

-- COLOR PICKER compacto
local function ColorPicker(parent,icoName,label,desc,default,cb,order)
    local col=default or C.Acc;local cpOpen=false
    local h=desc and 46 or 32

    local wrap=Mk("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,LayoutOrder=order or 0,ClipsDescendants=false,Parent=parent})
    local row=Mk("Frame",{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Parent=wrap})
    if icoName then local ci=Ico(row,icoName,12,C.T2);ci.Position=UDim2.new(0,0,0.5,-6) end
    local xo6=icoName and 18 or 0
    Mk("TextLabel",{Size=UDim2.new(1,-(xo6+44),1,0),Position=UDim2.new(0,xo6,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
    local prev=Mk("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-38,0.5,-11),
        BackgroundColor3=col,Text="",AutoButtonColor=false,BorderSizePixel=0,ZIndex=3,Parent=row})
    Rnd(prev,7);Strk(prev,col,1)
    Bounce(prev,38,22)
    if desc then
        Mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,xo6,0,32),BackgroundTransparency=1,
            Text=desc,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.T3,TextXAlignment=Enum.TextXAlignment.Left,Parent=wrap})
    end

    local panel=Mk("Frame",{Size=UDim2.new(1,0,0,108),Position=UDim2.new(0,0,0,h+4),
        BackgroundColor3=Color3.fromRGB(12,12,20),BorderSizePixel=0,Visible=false,ZIndex=7,Parent=wrap})
    Rnd(panel,8);Strk(panel,C.Acc,1);Pad(panel,6,6,6,6);VList(panel,6)

    local hv,sv,vv=col:ToHSV()
    local function Rebuild()
        col=Color3.fromHSV(hv,sv,vv)
        prev.BackgroundColor3=col
        local s2=prev:FindFirstChildOfClass("UIStroke");if s2 then s2.Color=col end
        if cb then cb(col) end
    end

    local function CPRow2(lbl2,iv,setter)
        local rw=Mk("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,ZIndex=8,Parent=panel})
        Mk("TextLabel",{Size=UDim2.new(0,10,1,0),BackgroundTransparency=1,Text=lbl2,Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.T2,ZIndex=8,Parent=rw})
        local t2=Mk("Frame",{Size=UDim2.new(1,-14,0,5),Position=UDim2.new(0,14,0.5,-2),BackgroundColor3=C.InBg,BorderSizePixel=0,ZIndex=8,Parent=rw})
        Rnd(t2,3)
        local k2=Mk("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(iv,-6,0.5,-6),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=9,Parent=t2})
        Rnd(k2,6);Strk(k2,C.Acc,1)
        local h2=Mk("TextButton",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,-10),BackgroundTransparency=1,Text="",BorderSizePixel=0,ZIndex=10,Parent=t2})
        local drag2=false;local c2
        h2.MouseButton1Down:Connect(function() drag2=true;c2=RunService.RenderStepped:Connect(function()
            if not drag2 then c2:Disconnect();return end
            local r2=math.clamp((Mouse.X-t2.AbsolutePosition.X)/t2.AbsoluteSize.X,0,1)
            k2.Position=UDim2.new(r2,-6,0.5,-6);setter(r2);Rebuild()
        end) end)
        UIS.InputEnded:Connect(function(i2) if i2.UserInputType==Enum.UserInputType.MouseButton1 and drag2 then drag2=false end end)
    end
    CPRow2("H",hv,function(r) hv=r end)
    CPRow2("S",sv,function(r) sv=r end)
    CPRow2("V",vv,function(r) vv=r end)

    prev.MouseButton1Click:Connect(function()
        cpOpen=not cpOpen;panel.Visible=cpOpen
        wrap.Size=cpOpen and UDim2.new(1,0,0,h+112) or UDim2.new(1,0,0,h)
        if not cpOpen then Notif("EyeDropper",label,"Cor alterada","ok",2) end
    end)
    RegSearch(wrap,label)
    return wrap,function() return col end
end

-- LABEL info simples
local function LabelInfo(parent,icoName,label,val,order)
    local r=Mk("Frame",{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,LayoutOrder=order or 0,Parent=parent})
    if icoName then local li=Ico(r,icoName,12,C.T3);li.Position=UDim2.new(0,0,0.5,-6) end
    local xo7=icoName and 18 or 0
    Mk("TextLabel",{Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0,xo7,0,0),BackgroundTransparency=1,
        Text=label,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.T2,TextXAlignment=Enum.TextXAlignment.Left,Parent=r})
    Mk("TextLabel",{Size=UDim2.new(0.5,-xo7,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundTransparency=1,
        Text=val,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.T1,TextXAlignment=Enum.TextXAlignment.Right,Parent=r})
    return r
end

-- ──────────────────────────────────────────────
-- ABAS
-- ──────────────────────────────────────────────
local Tab1=MakeTab("Dashboard","Main",1)
local Tab2=MakeTab("SlidersH","Config",2)
local Tab3=MakeTab("Palette","Visual",3)
local Tab4=MakeTab("Info","Info",4)

-- Ativa tab 1
Tab1.Page.Visible=true;ActiveTab=Tab1
Tw(Tab1.Btn,{BackgroundColor3=Color3.fromRGB(18,14,34)},0)
Tw(Tab1.Icon,{ImageColor3=C.Acc},0)
Tw(Tab1.Lbl,{TextColor3=C.AccBr},0)
Tab1.Ind.BackgroundTransparency=0

-- ══════════════════════════════════════════════
-- ABA 1 · MAIN  — 2 painéis lado a lado
-- ══════════════════════════════════════════════
-- Painel Superior: BOTÕES (esq) | TOGGLES (dir)
local L1,R1=DualPanel(Tab1.Page,1)

local _,bC=Card(L1,"Botões","Zap",1)
Button(bC,"Power","Executar","Roda o script principal","primary",function()
    Notif("CheckCircle","Executar","Script executado com sucesso!","ok",3)
end,1)
Button(bC,"PowerOff","Parar","Para todos os loops","err",function()
    Notif("AlertCircle","Parar","Todos os módulos parados.","err",3)
end,2)
Button(bC,"RefreshCw","Reiniciar","Reinicia o hub","primary",function()
    Notif("RefreshCw","Reiniciar","Hub reiniciado.","info",2)
end,3)
Button(bC,"Copy","Copiar Key","Copia sua chave","ok",function()
    Notif("Copy","Chave","Copiada para a área!","ok",2)
end,4)

local _,tC=Card(R1,"Funções","Activity",1)
Toggle(tC,"Eye","ESP","Mostra jogadores",false,function(v)
    -- notif já disparada internamente
end,1)
Toggle(tC,"Crosshair","Aimbot","Mira automática",false,function(v) end,2)
Toggle(tC,"Shield","God Mode","Invulnerabilidade",false,function(v) end,3)
Toggle(tC,"Navigation","Fly","Voar pelo mapa",false,function(v) end,4)
Toggle(tC,"Gauge","Speed","Velocidade extra",false,function(v) end,5)
Toggle(tC,"Bomb","Hitbox","Expande hitbox",false,function(v) end,6)

-- Painel Inferior: DROPDOWNS (esq) | TEXTBOX (dir)
local L2,R2=DualPanel(Tab1.Page,2)

local _,ddC=Card(L2,"Seleção","Grid",1)
Dropdown(ddC,"Eye","Modo ESP",{"Caixas","Esqueleto","Chams","Wireframe"},"Caixas",function(v) end,1)
Dropdown(ddC,"Grid","Time",{"Todos","Inimigos","Aliados"},"Todos",function(v) end,2)

local _,txC=Card(R2,"Inputs","Edit",1)
Textbox(txC,"Player","Alvo...","Nome do jogador alvo",function(v)
    if v~="" then Notif("Target","Alvo","Definido: "..v,"info",2) end
end,1)
Textbox(txC,"Key","Key...","Cole a chave do hub",function(v) end,2)

-- ══════════════════════════════════════════════
-- ABA 2 · CONFIG — 2 painéis
-- ══════════════════════════════════════════════
local LS,RS=DualPanel(Tab2.Page,1)

local _,slC=Card(LS,"Sliders","SlidersH",1)
Slider(slC,"Crosshair","FOV","Raio do aimbot",0,500,120,"px",function(v) end,1)
Slider(slC,"Gauge","Speed","Velocidade",16,250,16,"",function(v) end,2)
Slider(slC,"Zap","Jump","Força do pulo",50,400,50,"",function(v) end,3)
Slider(slC,"Bomb","Hitbox","Tamanho",1,10,1,"x",function(v) end,4)

local _,kbC=Card(RS,"Keybinds","Keyboard",1)
Keybind(kbC,"Menu","Abrir UI","Tecla para toggle",Enum.KeyCode.RightShift,function(k) end,1)
Keybind(kbC,"Crosshair","Aimbot","Liga/desliga aim",Enum.KeyCode.V,function(k) end,2)
Keybind(kbC,"Navigation","Fly","Liga/desliga fly",Enum.KeyCode.G,function(k) end,3)
Keybind(kbC,"Eye","ESP","Liga/desliga ESP",Enum.KeyCode.H,function(k) end,4)

-- ══════════════════════════════════════════════
-- ABA 3 · VISUAL — 2 painéis
-- ══════════════════════════════════════════════
local LV,RV=DualPanel(Tab3.Page,1)

local _,cpC=Card(LV,"Cores","Palette",1)
ColorPicker(cpC,"Eye","Cor ESP","Cor das caixas ESP",C.Cyan,function(c) end,1)
ColorPicker(cpC,"Crosshair","Cor FOV","Círculo do aimbot",C.Acc,function(c) end,2)
ColorPicker(cpC,"Shield","Cor Chams","Cor dos chams",C.Err,function(c) end,3)

local _,thC=Card(RV,"Tema","Wand2",1)
Toggle(thC,"Star","Neon Intenso","Brilho neon nos elementos",true,function(v) end,1)
Toggle(thC,"Grid","Mostrar FPS","Contador de FPS",false,function(v) end,2)
Slider(thC,"Minimize","Opacidade","Transparência da UI",0,90,10,"%",function(v) end,3)
Dropdown(thC,"Palette","Esquema",{"Roxo Neon","Ciano","Verde","Vermelho"},"Roxo Neon",function(v) end,4)

-- ══════════════════════════════════════════════
-- ABA 4 · INFO — 2 painéis
-- ══════════════════════════════════════════════
local LI,RI=DualPanel(Tab4.Page,1)

local _,abC=Card(LI,"Sobre","Crown",1)
LabelInfo(abC,"Crown","Hub","Premium Hub v4",1)
LabelInfo(abC,"Code","Versão","4.0.0",2)
LabelInfo(abC,"Bot","Autor",AUTHOR_NAME,3)
LabelInfo(abC,"Globe","Discord","discord.gg/coiledtom",4)
LabelInfo(abC,"Clock","Status","Online",5)

local _,acC=Card(RI,"Ações","Wrench",1)
Button(acC,"RefreshCw","Atualizar","Verifica por updates","primary",function()
    Notif("RefreshCw","Atualizar","Verificando... v4.0.0 é a mais recente.","info",3)
end,1)
Button(acC,"Copy","Copiar Discord","Copia o link","ok",function()
    Notif("Copy","Discord","Link copiado!","ok",2)
end,2)
Button(acC,"Trash","Reset Configs","Volta ao padrão","err",function()
    Notif("AlertCircle","Reset","Tem certeza?  — Usando botão confirm abaixo.","warn",2)
    task.delay(2.6,function()
        Notif("Trash","Resetar Configs?","Isso apaga tudo!","confirm",nil,
            function() Notif("CheckCircle","Reset","Configs resetadas!","ok",3) end,
            function() Notif("CloseCircle","Reset","Cancelado.","err",2) end)
    end)
end,3)

-- ──────────────────────────────────────────────
-- NOTIF DE BOAS-VINDAS
-- ──────────────────────────────────────────────
task.delay(.5,function()
    Notif("CheckCircle","Premium Hub","UI carregada com sucesso!","ok",4)
end)

print("[PHv4] Loaded!")
