--==================================================================
-- 🏃 SM1LE HUB v2.0 — Dodge or Die ONLY
-- RightCtrl hides, — minimizes, ✕ closes.
--==================================================================

if game.PlaceId ~= 131794278839305 then return end
if _G.Sm1leHub and _G.Sm1leHub.Destroy then pcall(_G.Sm1leHub.Destroy) end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local lp = Players.LocalPlayer

-- ==================== ФУНКЦИИ РАННЕГО ДОСТУПА ====================
local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
    return c
end

-- ==================== ИНТРО (10.9s) ====================
local introGui = Instance.new("ScreenGui")
introGui.Name = "Sm1leIntro"
introGui.ResetOnSpawn = false
introGui.IgnoreGuiInset = true
introGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
introFrame.BorderSizePixel = 0
introFrame.Parent = introGui

local snowflakesIntro = {}
for i = 1, 60 do
    local flake = Instance.new("Frame")
    local size = math.random(2, 5)
    flake.Size = UDim2.fromOffset(size, size)
    flake.Position = UDim2.fromScale(math.random(), math.random() * -1)
    flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flake.BackgroundTransparency = math.random() * 0.5 + 0.3
    flake.BorderSizePixel = 0
    flake.Parent = introFrame
    corner(flake, size / 2)
    
    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Thickness = 1
    glow.Transparency = 0.6
    glow.Parent = flake
    
    snowflakesIntro[i] = {
        dot = flake, glow = glow,
        x = flake.Position.X.Scale, y = flake.Position.Y.Scale,
        speed = math.random() * 0.35 + 0.15,
        wind = math.random() * 0.08 - 0.04,
        twinkle = math.random() * 10,
    }
end

local introTitle = Instance.new("TextLabel")
introTitle.Size = UDim2.new(0, 600, 0, 80)
introTitle.Position = UDim2.new(0.5, -300, 0.5, -130)
introTitle.BackgroundTransparency = 1
introTitle.Text = "SM1LE HUB"
introTitle.Font = Enum.Font.GothamBlack
introTitle.TextSize = 56
introTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
introTitle.TextTransparency = 1
introTitle.Parent = introFrame

local introTitleGlow = Instance.new("UIStroke")
introTitleGlow.Color = Color3.fromRGB(255, 255, 255)
introTitleGlow.Thickness = 2
introTitleGlow.Transparency = 1
introTitleGlow.Parent = introTitle

local introTitleGrad = Instance.new("UIGradient")
introTitleGrad.Parent = introTitle

local introSubtitle = Instance.new("TextLabel")
introSubtitle.Size = UDim2.new(0, 400, 0, 35)
introSubtitle.Position = UDim2.new(0.5, -200, 0.5, -40)
introSubtitle.BackgroundTransparency = 1
introSubtitle.Text = "DODGE OR DIE"
introSubtitle.Font = Enum.Font.GothamMedium
introSubtitle.TextSize = 24
introSubtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
introSubtitle.TextTransparency = 1
introSubtitle.Parent = introFrame

local introSubGlow = Instance.new("UIStroke")
introSubGlow.Color = Color3.fromRGB(255, 255, 255)
introSubGlow.Thickness = 1.5
introSubGlow.Transparency = 1
introSubGlow.Parent = introSubtitle

local introSubGrad = Instance.new("UIGradient")
introSubGrad.Parent = introSubtitle

local introAuthor = Instance.new("TextLabel")
introAuthor.Size = UDim2.new(0, 300, 0, 25)
introAuthor.Position = UDim2.new(0.5, -150, 0.5, 5)
introAuthor.BackgroundTransparency = 1
introAuthor.Text = "by SM1LER"
introAuthor.Font = Enum.Font.Gotham
introAuthor.TextSize = 16
introAuthor.TextColor3 = Color3.fromRGB(255, 255, 255)
introAuthor.TextTransparency = 1
introAuthor.Parent = introFrame

local introAuthorGlow = Instance.new("UIStroke")
introAuthorGlow.Color = Color3.fromRGB(255, 255, 255)
introAuthorGlow.Thickness = 1
introAuthorGlow.Transparency = 1
introAuthorGlow.Parent = introAuthor

local introAuthorGrad = Instance.new("UIGradient")
introAuthorGrad.Parent = introAuthor

local introLine = Instance.new("Frame")
introLine.Size = UDim2.fromOffset(0, 1)
introLine.Position = UDim2.new(0.5, -100, 0.5, 35)
introLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
introLine.BorderSizePixel = 0
introLine.BackgroundTransparency = 1
introLine.Parent = introFrame

local introLineGlow = Instance.new("UIStroke")
introLineGlow.Color = Color3.fromRGB(255, 255, 255)
introLineGlow.Thickness = 1.5
introLineGlow.Transparency = 1
introLineGlow.Parent = introLine

local introLineGrad = Instance.new("UIGradient")
introLineGrad.Parent = introLine

-- Анимация интро
local introClock = 0
local introConn
introConn = RunService.Heartbeat:Connect(function(dt)
    introClock += dt
    
    for _, flake in ipairs(snowflakesIntro) do
        flake.y = flake.y + flake.speed * dt
        flake.x = flake.x + flake.wind * dt + math.sin(introClock * 1.2 + flake.twinkle) * 0.001
        if flake.y > 1.1 then flake.y = -0.05; flake.x = math.random() end
        if flake.x > 1.05 then flake.x = -0.05 end
        if flake.x < -0.05 then flake.x = 1.05 end
        flake.dot.Position = UDim2.fromScale(flake.x, flake.y)
        local brightness = math.sin(introClock * 2.5 + flake.twinkle) * 0.15 + 0.85
        flake.dot.BackgroundTransparency = 1 - brightness * 0.5
        flake.glow.Transparency = 1 - brightness * 0.3
    end
    
    local wave = math.sin(introClock * 0.8) * 0.15
    local whitePos = 0.55 + wave
    local gradSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(whitePos - 0.05, Color3.fromRGB(180, 180, 180)),
        ColorSequenceKeypoint.new(whitePos + 0.05, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })
    introTitleGrad.Color = gradSequence
    introSubGrad.Color = gradSequence
    introAuthorGrad.Color = gradSequence
    introLineGrad.Color = gradSequence
    
    local glowPulse = math.sin(introClock * 1.5) * 0.08 + 0.92
    introTitleGlow.Transparency = introTitle.TextTransparency + (1 - glowPulse)
    introSubGlow.Transparency = introSubtitle.TextTransparency + (1 - glowPulse)
    introAuthorGlow.Transparency = introAuthor.TextTransparency + (1 - glowPulse)
    introLineGlow.Transparency = introLine.BackgroundTransparency + (1 - glowPulse)
end)

task.spawn(function()
    TweenService:Create(introTitle, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
    TweenService:Create(introTitleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {Transparency = 0.8}):Play()
    task.wait(0.7)
    TweenService:Create(introSubtitle, TweenInfo.new(0.9, Enum.EasingStyle.Quint), {TextTransparency = 0.1}):Play()
    TweenService:Create(introSubGlow, TweenInfo.new(0.9, Enum.EasingStyle.Quint), {Transparency = 0.8}):Play()
    task.wait(0.6)
    TweenService:Create(introAuthor, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
    TweenService:Create(introAuthorGlow, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0.8}):Play()
    TweenService:Create(introLine, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(200, 1), BackgroundTransparency = 0.6}):Play()
    TweenService:Create(introLineGlow, TweenInfo.new(0.9, Enum.EasingStyle.Quad), {Transparency = 0.7}):Play()
    task.wait(1.7)
    TweenService:Create(introTitle, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 60}):Play()
    TweenService:Create(introTitleGlow, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {Thickness = 3.5, Transparency = 0.6}):Play()
    task.wait(0.7)
    TweenService:Create(introTitle, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {TextSize = 56}):Play()
    TweenService:Create(introTitleGlow, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {Thickness = 2, Transparency = 0.8}):Play()
    task.wait(3.5)
    if introConn then introConn:Disconnect() end
    TweenService:Create(introTitle, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    TweenService:Create(introTitleGlow, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
    TweenService:Create(introSubtitle, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    TweenService:Create(introSubGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
    TweenService:Create(introAuthor, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    TweenService:Create(introAuthorGlow, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
    TweenService:Create(introLine, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Size = UDim2.fromOffset(0, 1), BackgroundTransparency = 1}):Play()
    TweenService:Create(introLineGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
    for _, flake in ipairs(snowflakesIntro) do
        TweenService:Create(flake.dot, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
        TweenService:Create(flake.glow, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
    end
    TweenService:Create(introFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
    task.wait(0.8)
    introGui:Destroy()
end)

-- Ждём завершения интро перед созданием GUI
task.wait(10.9)

-- ==================== ОСНОВНОЙ СКРИПТ ====================
local START_BACKGROUND = "https://create.roblox.com/store/asset/6395708472/Black-Hole"
local START_PANEL_TRANSPARENCY = 0.5
local START_IMAGE_TRANSPARENCY = 0.05

local S = {
    godmode = false, jumppower = false, speed = false, autofarm = false, autofarmv2 = false,
    autododge = false, freezetime = false, perfecttime = false, deleteball = false, autoskill = false,
    esp = false, espballs = false, antiafk = false, noclip = false,
    hitboxview = false, aura = false, spinbot = false, ballpet = false,
    perfectring = false, reset = false, rainbowesp = false, musicplayer = false,
    ballredirect = false, snowEffect = false,
    jumpVal = 100, speedVal = 50, freezeStr = 2, tpY = 80,
    perfectRange = 10, petRange = 8, auraText = "John Doe",
    musicID = "rbxassetid://1842801835", spinSpeed = 10, theme = "Cosmic",
    bgTransparency = math.floor(START_PANEL_TRANSPARENCY * 100), dodgeDistance = 15, dodgeCooldown = 0.3
}

local Themes = {
    Blood = {
        ACCENT = Color3.fromRGB(255,0,0), ACCENT2 = Color3.fromRGB(0,0,0),
        BG = Color3.fromRGB(20,5,5), BG2 = Color3.fromRGB(30,8,8), BG3 = Color3.fromRGB(45,12,12),
        TXT = Color3.fromRGB(255,240,240), SUB = Color3.fromRGB(200,150,150),
        Stroke = Color3.fromRGB(120,15,15), SwitchOff = Color3.fromRGB(45,12,12),
        TitleGrad1 = Color3.fromRGB(255,0,0), TitleGrad2 = Color3.fromRGB(0,0,0),
        ByGrad1 = Color3.fromRGB(255,80,80), ByGrad2 = Color3.fromRGB(0,0,0)
    },
    Ocean = {
        ACCENT = Color3.fromRGB(0,100,255), ACCENT2 = Color3.fromRGB(0,0,40),
        BG = Color3.fromRGB(5,8,20), BG2 = Color3.fromRGB(8,12,30), BG3 = Color3.fromRGB(12,18,45),
        TXT = Color3.fromRGB(235,240,255), SUB = Color3.fromRGB(140,160,200),
        Stroke = Color3.fromRGB(15,40,120), SwitchOff = Color3.fromRGB(12,18,45),
        TitleGrad1 = Color3.fromRGB(0,150,255), TitleGrad2 = Color3.fromRGB(0,0,50),
        ByGrad1 = Color3.fromRGB(0,180,255), ByGrad2 = Color3.fromRGB(0,0,50)
    },
    Midnight = {
        ACCENT = Color3.fromRGB(140,0,255), ACCENT2 = Color3.fromRGB(5,0,20),
        BG = Color3.fromRGB(8,5,20), BG2 = Color3.fromRGB(14,8,30), BG3 = Color3.fromRGB(22,12,45),
        TXT = Color3.fromRGB(240,235,255), SUB = Color3.fromRGB(160,140,200),
        Stroke = Color3.fromRGB(50,10,120), SwitchOff = Color3.fromRGB(22,12,45),
        TitleGrad1 = Color3.fromRGB(170,50,255), TitleGrad2 = Color3.fromRGB(10,0,30),
        ByGrad1 = Color3.fromRGB(180,80,255), ByGrad2 = Color3.fromRGB(10,0,30)
    },
    Forest = {
        ACCENT = Color3.fromRGB(0,200,50), ACCENT2 = Color3.fromRGB(0,15,0),
        BG = Color3.fromRGB(5,15,5), BG2 = Color3.fromRGB(8,22,8), BG3 = Color3.fromRGB(12,32,12),
        TXT = Color3.fromRGB(235,255,235), SUB = Color3.fromRGB(140,200,140),
        Stroke = Color3.fromRGB(15,80,15), SwitchOff = Color3.fromRGB(12,32,12),
        TitleGrad1 = Color3.fromRGB(0,255,80), TitleGrad2 = Color3.fromRGB(0,20,0),
        ByGrad1 = Color3.fromRGB(50,255,100), ByGrad2 = Color3.fromRGB(0,20,0)
    },
    Sunset = {
        ACCENT = Color3.fromRGB(255,120,0), ACCENT2 = Color3.fromRGB(20,3,0),
        BG = Color3.fromRGB(18,8,3), BG2 = Color3.fromRGB(28,12,5), BG3 = Color3.fromRGB(42,18,8),
        TXT = Color3.fromRGB(255,245,235), SUB = Color3.fromRGB(200,160,120),
        Stroke = Color3.fromRGB(100,30,5), SwitchOff = Color3.fromRGB(42,18,8),
        TitleGrad1 = Color3.fromRGB(255,150,30), TitleGrad2 = Color3.fromRGB(30,5,0),
        ByGrad1 = Color3.fromRGB(255,170,50), ByGrad2 = Color3.fromRGB(30,5,0)
    },
    System = {
        ACCENT = Color3.fromRGB(0,200,200), ACCENT2 = Color3.fromRGB(0,20,20),
        BG = Color3.fromRGB(3,15,15), BG2 = Color3.fromRGB(5,22,22), BG3 = Color3.fromRGB(8,32,32),
        TXT = Color3.fromRGB(220,255,255), SUB = Color3.fromRGB(130,200,200),
        Stroke = Color3.fromRGB(10,80,80), SwitchOff = Color3.fromRGB(8,32,32),
        TitleGrad1 = Color3.fromRGB(0,255,255), TitleGrad2 = Color3.fromRGB(0,30,30),
        ByGrad1 = Color3.fromRGB(50,255,255), ByGrad2 = Color3.fromRGB(0,30,30)
    },
    Cosmic = {
        ACCENT = Color3.fromRGB(180,130,255), ACCENT2 = Color3.fromRGB(0,0,0),
        BG = Color3.fromRGB(5,3,12), BG2 = Color3.fromRGB(10,5,22), BG3 = Color3.fromRGB(18,10,35),
        TXT = Color3.fromRGB(245,240,255), SUB = Color3.fromRGB(170,155,210),
        Stroke = Color3.fromRGB(80,50,140), SwitchOff = Color3.fromRGB(18,10,35),
        TitleGrad1 = Color3.fromRGB(200,150,255), TitleGrad2 = Color3.fromRGB(30,10,60),
        ByGrad1 = Color3.fromRGB(210,170,255), ByGrad2 = Color3.fromRGB(30,10,60)
    }
}

local currentTheme = Themes[S.theme]
local ACCENT = currentTheme.ACCENT; local ACCENT2 = currentTheme.ACCENT2
local BG = currentTheme.BG; local BG2 = currentTheme.BG2; local BG3 = currentTheme.BG3
local TXT = currentTheme.TXT; local SUB = currentTheme.SUB

local function pad(p,t,b,l,r) local u=Instance.new("UIPadding") u.PaddingTop=UDim.new(0,t) u.PaddingBottom=UDim.new(0,b) u.PaddingLeft=UDim.new(0,l) u.PaddingRight=UDim.new(0,r) u.Parent=p return u end
local function gradient(p,c1,c2,rot) local g=Instance.new("UIGradient") g.Color=ColorSequence.new(c1,c2) g.Rotation=rot or 0 g.Parent=p return g end

local function getAssetId(input)
    local text = tostring(input or "")
    return text:match("rbxassetid://(%d+)") or text:match("asset/(%d+)") or text:match("library/(%d+)") or text:match("[?&]id=(%d+)") or text:match("^(%d+)$")
end

local function toImageContent(input)
    local id = getAssetId(input)
    if id then return "rbxthumb://type=Asset&id=" .. id .. "&w=420&h=420" end
    return tostring(input or "")
end

local parent = (gethui and gethui()) or game:GetService("CoreGui")
local gui = Instance.new("ScreenGui")
gui.Name = "Sm1leHub"; gui.ResetOnSpawn = false; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true; gui.Parent = parent

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(520,440); main.Position = UDim2.fromScale(0.5,0.5); main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG; main.BorderSizePixel = 0; main.ClipsDescendants = true; main.Parent = gui; corner(main,16)
main.BackgroundTransparency = 1

local mst = Instance.new("UIStroke",main); mst.Color = currentTheme.Stroke; mst.Thickness = 1.5; mst.Transparency = 0

-- ФОН
local bg = Instance.new("ImageLabel")
bg.Name = "SM1LE_WorkingBackground"; bg.BackgroundTransparency = 1; bg.BorderSizePixel = 0
bg.Position = UDim2.fromScale(0,0); bg.Size = UDim2.fromScale(1,1)
bg.Image = toImageContent(START_BACKGROUND); bg.ScaleType = Enum.ScaleType.Crop
bg.ImageTransparency = START_IMAGE_TRANSPARENCY; bg.ZIndex = 1; bg.Parent = main; corner(bg,16)

-- СНЕГ В ОКНЕ
local snowContainer = Instance.new("Frame")
snowContainer.Name = "SnowContainer"; snowContainer.Size = UDim2.new(1,0,1,0)
snowContainer.Position = UDim2.fromScale(0,0); snowContainer.BackgroundTransparency = 1
snowContainer.BorderSizePixel = 0; snowContainer.ZIndex = 2; snowContainer.Visible = false; snowContainer.Parent = main

local windowSnowflakes = {}
for i = 1, 30 do
    local flake = Instance.new("Frame")
    local size = math.random(2, 4)
    flake.Size = UDim2.fromOffset(size, size)
    flake.Position = UDim2.fromScale(math.random(), math.random() * -1)
    flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flake.BackgroundTransparency = math.random() * 0.5 + 0.3
    flake.BorderSizePixel = 0
    flake.Parent = snowContainer
    corner(flake, size / 2)
    
    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Thickness = 1
    glow.Transparency = 0.6
    glow.Parent = flake
    
    windowSnowflakes[i] = {
        dot = flake, glow = glow,
        x = flake.Position.X.Scale, y = flake.Position.Y.Scale,
        speed = math.random() * 0.35 + 0.15,
        wind = math.random() * 0.08 - 0.04,
        twinkle = math.random() * 10,
    }
end

local snowClock = 0
local snowConn
local function startSnow()
    if snowConn then snowConn:Disconnect() end
    snowContainer.Visible = true
    snowClock = 0
    snowConn = RunService.Heartbeat:Connect(function(dt)
        snowClock += dt
        for _, flake in ipairs(windowSnowflakes) do
            flake.y = flake.y + flake.speed * dt
            flake.x = flake.x + flake.wind * dt + math.sin(snowClock * 1.2 + flake.twinkle) * 0.001
            if flake.y > 1.1 then flake.y = -0.05; flake.x = math.random() end
            if flake.x > 1.05 then flake.x = -0.05 end
            if flake.x < -0.05 then flake.x = 1.05 end
            flake.dot.Position = UDim2.fromScale(flake.x, flake.y)
            local brightness = math.sin(snowClock * 2.5 + flake.twinkle) * 0.15 + 0.85
            flake.dot.BackgroundTransparency = 1 - brightness * 0.5
            flake.glow.Transparency = 1 - brightness * 0.3
        end
    end)
end

local function stopSnow()
    if snowConn then snowConn:Disconnect(); snowConn = nil end
    snowContainer.Visible = false
end

local function pushUiAboveBackground()
    for _, object in ipairs(main:GetDescendants()) do
        if object:IsA("GuiObject") and object ~= bg and object ~= snowContainer and object.ZIndex <= bg.ZIndex then
            object.ZIndex = bg.ZIndex + 1
        end
    end
end

local function applyPanelTransparency(value)
    value = math.clamp(value, 0, 0.9)
    main.BackgroundTransparency = 1
    for _, object in ipairs(main:GetDescendants()) do
        if object ~= bg and object ~= snowContainer and not object:IsDescendantOf(snowContainer) and (object:IsA("Frame") or object:IsA("TextButton") or object:IsA("TextBox")) then
            if object.BackgroundTransparency < 1 then
                object.BackgroundTransparency = value
            end
        end
    end
end

pushUiAboveBackground()

main.DescendantAdded:Connect(function(object)
    if object:IsA("GuiObject") and object ~= bg and object ~= snowContainer and not object:IsDescendantOf(snowContainer) and object.ZIndex <= bg.ZIndex then
        object.ZIndex = bg.ZIndex + 1
    end
end)

-- HEADER
local header = Instance.new("Frame"); header.Size = UDim2.new(1,0,0,56); header.BackgroundColor3 = BG2; header.BorderSizePixel = 0; header.Parent = main; corner(header,16)
header.BackgroundTransparency = START_PANEL_TRANSPARENCY
local hfix = Instance.new("Frame"); hfix.Size = UDim2.new(1,0,0,16); hfix.Position = UDim2.new(0,0,1,-16); hfix.BackgroundColor3 = BG2; hfix.BorderSizePixel = 0; hfix.Parent = header
hfix.BackgroundTransparency = START_PANEL_TRANSPARENCY

local logo = Instance.new("TextLabel"); logo.Size = UDim2.fromOffset(40,40); logo.Position = UDim2.fromOffset(14,8)
logo.BackgroundTransparency = 1; logo.Font = Enum.Font.GothamBold; logo.Text = "🏃"; logo.TextSize = 28; logo.Parent = header

local titleC = Instance.new("TextLabel"); titleC.Size = UDim2.fromOffset(200,22); titleC.Position = UDim2.fromOffset(58,11)
titleC.BackgroundTransparency = 1; titleC.Font = Enum.Font.GothamBold; titleC.TextSize = 19; titleC.TextColor3 = TXT
titleC.Text = "SM1LE HUB v2.0"; titleC.TextXAlignment = Enum.TextXAlignment.Left; titleC.Parent = header
gradient(titleC, currentTheme.TitleGrad1, currentTheme.TitleGrad2, 0)

local byLabel = Instance.new("TextLabel"); byLabel.Size = UDim2.fromOffset(100,16); byLabel.Position = UDim2.fromOffset(58,29)
byLabel.BackgroundTransparency = 1; byLabel.Font = Enum.Font.GothamBlack; byLabel.TextSize = 11; byLabel.TextColor3 = TXT
byLabel.Text = "by SM1LER"; byLabel.TextXAlignment = Enum.TextXAlignment.Left; byLabel.Parent = header
gradient(byLabel, currentTheme.ByGrad1, currentTheme.ByGrad2, 0)

local statusL = Instance.new("TextLabel"); statusL.Size = UDim2.fromOffset(280,14); statusL.Position = UDim2.fromOffset(58,44)
statusL.BackgroundTransparency = 1; statusL.Font = Enum.Font.GothamMedium; statusL.TextSize = 9; statusL.TextColor3 = SUB
statusL.Text = "🏟️ Dodge or Die"; statusL.TextXAlignment = Enum.TextXAlignment.Left; statusL.Parent = header

local function hbtn(txt,x) local b=Instance.new("TextButton"); b.Size=UDim2.fromOffset(28,28); b.Position=UDim2.new(1,x,0,14)
b.BackgroundColor3=BG3; b.Text=txt; b.TextColor3=TXT; b.Font=Enum.Font.GothamBold; b.TextSize=15; b.AutoButtonColor=true; b.Parent=header; corner(b,8); return b end
local closeB = hbtn("✕",-40); local minB = hbtn("—",-74)

local body = Instance.new("Frame"); body.Size = UDim2.new(1,0,1,-56); body.Position = UDim2.fromOffset(0,56); body.BackgroundTransparency = 1; body.Parent = main
local side = Instance.new("Frame"); side.Size = UDim2.new(0,140,1,0); side.BackgroundColor3 = BG2; side.BorderSizePixel = 0; side.Parent = body; pad(side,12,12,10,10)
side.BackgroundTransparency = START_PANEL_TRANSPARENCY
local sl = Instance.new("UIListLayout",side); sl.Padding = UDim.new(0,6); sl.SortOrder = Enum.SortOrder.LayoutOrder
local content = Instance.new("Frame"); content.Size = UDim2.new(1,-140,1,0); content.Position = UDim2.fromOffset(140,0); content.BackgroundTransparency = 1; content.Parent = body

local tabs = {}; local pages = {}; local activeTab = nil

local function selectTab(name)
    activeTab = name
    for n,m in pairs(tabs) do 
        local on=(n==name)
        TweenService:Create(m.btn,TweenInfo.new(0.18),{BackgroundColor3=on and BG3 or BG2}):Play()
        m.accent.Visible=on; m.lbl.TextColor3=on and TXT or SUB
    end
    for n,p in pairs(pages) do p.Visible=(n==name); if p.Visible then p.CanvasPosition = Vector2.new(0, 0) end end
end

local tabOrder = 0
local function makeTab(name,icon)
    tabOrder+=1; local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,40); b.BackgroundColor3=BG2; b.AutoButtonColor=false; b.Text=""; b.LayoutOrder=tabOrder; b.Parent=side; corner(b,10)
    b.BackgroundTransparency = START_PANEL_TRANSPARENCY
    local acc=Instance.new("Frame"); acc.Size=UDim2.fromOffset(3,20); acc.Position=UDim2.fromOffset(0,10); acc.BackgroundColor3=ACCENT; acc.BorderSizePixel=0; acc.Visible=false; acc.Parent=b; corner(acc,2)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-16,1,0); lbl.Position=UDim2.fromOffset(14,0); lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.GothamMedium; lbl.TextSize=13.5; lbl.TextColor3=SUB; lbl.Text=icon.."  "..name; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=b
    tabs[name]={btn=b,accent=acc,lbl=lbl}
    b.MouseEnter:Connect(function() if activeTab~=name then b.BackgroundColor3=BG3 end end)
    b.MouseLeave:Connect(function() if activeTab~=name then b.BackgroundColor3=BG2 end end)
    b.MouseButton1Click:Connect(function() selectTab(name) end)
    local page=Instance.new("ScrollingFrame"); page.Size=UDim2.new(1,0,1,0); page.BackgroundTransparency=1; page.BorderSizePixel=0; page.ScrollBarThickness=3; page.ScrollBarImageColor3=ACCENT; page.CanvasSize=UDim2.new(0,0,0,0); page.AutomaticCanvasSize=Enum.AutomaticSize.Y; page.ScrollingDirection=Enum.ScrollingDirection.Y; page.Visible=false; page.Parent=content; pad(page,14,50,16,14)
    page.BottomImage = ""; page.TopImage = ""; page.ScrollBarImageTransparency = 0
    local pl=Instance.new("UIListLayout",page); pl.Padding=UDim.new(0,9); pl.SortOrder=Enum.SortOrder.LayoutOrder
    pages[name]=page; return page
end

local rowOrder = 0
local allRows = {}

local function makeToggle(page,label,desc,key,callback)
    rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,46); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = START_PANEL_TRANSPARENCY
    local st=Instance.new("UIStroke",row); st.Color=currentTheme.Stroke; st.Thickness=1; st.Transparency=0.3
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-70,0,18); t.Position=UDim2.fromOffset(12,6); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-70,0,13); d.Position=UDim2.fromOffset(12,25); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local sw=Instance.new("Frame"); sw.Size=UDim2.fromOffset(44,24); sw.Position=UDim2.new(1,-56,0.5,-12); sw.BackgroundColor3=currentTheme.SwitchOff; sw.BorderSizePixel=0; sw.Parent=row; corner(sw,12)
    local knob=Instance.new("Frame"); knob.Size=UDim2.fromOffset(18,18); knob.Position=UDim2.fromOffset(3,3); knob.BackgroundColor3=TXT; knob.BorderSizePixel=0; knob.Parent=sw; corner(knob,9)
    local btn=Instance.new("TextButton"); btn.Size=UDim2.fromScale(1,1); btn.BackgroundTransparency=1; btn.Text=""; btn.Parent=row
    local function render() 
        local on=S[key]
        TweenService:Create(sw,TweenInfo.new(0.18),{BackgroundColor3=on and ACCENT or currentTheme.SwitchOff}):Play()
        TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back),{Position=on and UDim2.fromOffset(23,3) or UDim2.fromOffset(3,3)}):Play()
        TweenService:Create(st,TweenInfo.new(0.18),{Color=on and ACCENT or currentTheme.Stroke}):Play()
    end
    btn.MouseButton1Click:Connect(function() S[key]=not S[key]; render(); if callback then callback(S[key]) end end)
    render()
    table.insert(allRows, {type="toggle", row=row, st=st, t=t, d=d, sw=sw, knob=knob, key=key, page=page})
end

local function makeSlider(page,label,desc,key,min,max,default,callback)
    S[key]=S[key] or default; rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,70); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = START_PANEL_TRANSPARENCY
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-70,0,18); t.Position=UDim2.fromOffset(12,8); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local valLabel=Instance.new("TextLabel"); valLabel.Size=UDim2.fromOffset(60,18); valLabel.Position=UDim2.new(1,-72,0,8); valLabel.BackgroundTransparency=1; valLabel.Font=Enum.Font.GothamBold; valLabel.TextSize=13; valLabel.TextColor3=ACCENT; valLabel.Text=tostring(S[key] or default); valLabel.TextXAlignment=Enum.TextXAlignment.Right; valLabel.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-24,0,13); d.Position=UDim2.fromOffset(12,28); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local bar=Instance.new("Frame"); bar.Size=UDim2.new(1,-24,0,8); bar.Position=UDim2.fromOffset(12,48); bar.BackgroundColor3=BG3; bar.BorderSizePixel=0; bar.Parent=row; corner(bar,4)
    local fill=Instance.new("Frame"); local ratio=((S[key] or default)-min)/(max-min); fill.Size=UDim2.fromScale(ratio,1); fill.BackgroundColor3=ACCENT; fill.BorderSizePixel=0; fill.Parent=bar; corner(fill,4)
    local dot=Instance.new("TextButton"); dot.Size=UDim2.fromOffset(16,16); dot.Position=UDim2.new(ratio,-8,0.5,-8); dot.BackgroundColor3=TXT; dot.Text=""; dot.Parent=bar; corner(dot,8); dot.ZIndex=2
    local hitArea=Instance.new("TextButton"); hitArea.Size=UDim2.new(1,0,1,0); hitArea.BackgroundTransparency=1; hitArea.Text=""; hitArea.Parent=bar
    local dragging=false; local inputConnection
    local function updateSlider(input) local relX=math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); local val=min+math.floor((max-min)*relX+0.5); S[key]=val; fill.Size=UDim2.fromScale(relX,1); dot.Position=UDim2.new(relX,-8,0.5,-8); valLabel.Text=tostring(val); if callback then callback(val) end end
    local function startDrag(input) dragging=true; if inputConnection then inputConnection:Disconnect() end; inputConnection=UserInputService.InputChanged:Connect(function(input2) if dragging and (input2.UserInputType==Enum.UserInputType.MouseMovement or input2.UserInputType==Enum.UserInputType.Touch) then updateSlider(input2) end end); updateSlider(input) end
    local function stopDrag() dragging=false; if inputConnection then inputConnection:Disconnect(); inputConnection=nil end end
    hitArea.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then startDrag(input) end end)
    hitArea.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then stopDrag() end end)
    dot.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then startDrag(input) end end)
    dot.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then stopDrag() end end)
    UserInputService.InputEnded:Connect(function(input) if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.TouchEnded) and dragging then stopDrag() end end)
    table.insert(allRows, {type="slider", row=row, t=t, valLabel=valLabel, d=d, bar=bar, fill=fill, dot=dot, key=key, page=page})
end

local function makeTextbox(page,label,desc,key,default)
    rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,60); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = START_PANEL_TRANSPARENCY
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-24,0,18); t.Position=UDim2.fromOffset(12,6); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-24,0,13); d.Position=UDim2.fromOffset(12,24); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local box=Instance.new("TextBox"); box.Size=UDim2.new(1,-24,0,24); box.Position=UDim2.fromOffset(12,38); box.BackgroundColor3=BG3; box.TextColor3=TXT; box.Font=Enum.Font.GothamBold; box.TextSize=12; box.Text=S[key] or default; box.PlaceholderText="Enter text..."; box.PlaceholderColor3=SUB; box.Parent=row; corner(box,8)
    box.FocusLost:Connect(function(ep) S[key]=box.Text; if ep then box.Text=S[key] end end)
    table.insert(allRows, {type="textbox", row=row, t=t, d=d, box=box, key=key, page=page})
end

local function sectionInfo(page,text)
    rowOrder+=1; local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,0,0,0); l.AutomaticSize=Enum.AutomaticSize.Y; l.BackgroundTransparency=1; l.Font=Enum.Font.Gotham; l.TextSize=11.5; l.TextColor3=SUB; l.TextWrapped=true; l.RichText=true; l.TextXAlignment=Enum.TextXAlignment.Left; l.Text=text; l.LayoutOrder=rowOrder; l.Parent=page
    table.insert(allRows, {type="section", label=l, page=page})
end

local function applyTransparency(transp)
    applyPanelTransparency(transp)
    header.BackgroundTransparency = transp
    hfix.BackgroundTransparency = transp
    side.BackgroundTransparency = transp
    for _, data in ipairs(allRows) do
        if data.type == "toggle" or data.type == "slider" or data.type == "textbox" then
            data.row.BackgroundTransparency = transp
        end
    end
    for name, tabData in pairs(tabs) do
        tabData.btn.BackgroundTransparency = transp
    end
end

local function applyTheme(themeName)
    S.theme = themeName; currentTheme = Themes[themeName]
    ACCENT = currentTheme.ACCENT; ACCENT2 = currentTheme.ACCENT2
    BG = currentTheme.BG; BG2 = currentTheme.BG2; BG3 = currentTheme.BG3
    TXT = currentTheme.TXT; SUB = currentTheme.SUB
    local transp = S.bgTransparency / 100
    main.BackgroundColor3 = BG; main.BackgroundTransparency = 1; mst.Color = currentTheme.Stroke
    header.BackgroundColor3 = BG2; header.BackgroundTransparency = transp
    hfix.BackgroundColor3 = BG2; hfix.BackgroundTransparency = transp
    side.BackgroundColor3 = BG2; side.BackgroundTransparency = transp
    if titleC:FindFirstChildOfClass("UIGradient") then titleC:FindFirstChildOfClass("UIGradient"):Destroy() end
    gradient(titleC, currentTheme.TitleGrad1, currentTheme.TitleGrad2, 0); titleC.TextColor3 = TXT
    if byLabel:FindFirstChildOfClass("UIGradient") then byLabel:FindFirstChildOfClass("UIGradient"):Destroy() end
    gradient(byLabel, currentTheme.ByGrad1, currentTheme.ByGrad2, 0); byLabel.TextColor3 = TXT
    statusL.TextColor3 = SUB; closeB.BackgroundColor3 = BG3; closeB.TextColor3 = TXT; minB.BackgroundColor3 = BG3; minB.TextColor3 = TXT
    for name, tabData in pairs(tabs) do
        local on = (activeTab == name)
        tabData.btn.BackgroundColor3 = on and BG3 or BG2; tabData.btn.BackgroundTransparency = transp
        tabData.accent.BackgroundColor3 = ACCENT; tabData.lbl.TextColor3 = on and TXT or SUB
    end
    for _, page in pairs(pages) do page.ScrollBarImageColor3 = ACCENT end
    for _, data in ipairs(allRows) do
        if data.type == "toggle" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.st.Color = currentTheme.Stroke; data.t.TextColor3 = TXT; data.d.TextColor3 = SUB
            data.sw.BackgroundColor3 = S[data.key] and ACCENT or currentTheme.SwitchOff; data.knob.BackgroundColor3 = TXT
        elseif data.type == "slider" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.t.TextColor3 = TXT; data.valLabel.TextColor3 = ACCENT; data.d.TextColor3 = SUB
            data.bar.BackgroundColor3 = BG3; data.fill.BackgroundColor3 = ACCENT; data.dot.BackgroundColor3 = TXT
        elseif data.type == "textbox" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.t.TextColor3 = TXT; data.d.TextColor3 = SUB
            data.box.BackgroundColor3 = BG3; data.box.TextColor3 = TXT; data.box.PlaceholderColor3 = SUB
        elseif data.type == "section" then data.label.TextColor3 = SUB end
    end
    applyPanelTransparency(transp)
end

applyTransparency(START_PANEL_TRANSPARENCY)
applyPanelTransparency(START_PANEL_TRANSPARENCY)

local pPlayer = makeTab("Player","🏃")
local pFarm = makeTab("Farm","🤖")
local pBall = makeTab("Ball","⚽")
local pVisuals = makeTab("Visuals","👁️")
local pFun = makeTab("Fun","🎵")
local pSettings = makeTab("Settings","⚙️")

makeToggle(pPlayer,"God Mode","Wall shield that pushes balls away","godmode")
makeToggle(pPlayer,"Jump Power","Super high jumps","jumppower")
makeToggle(pPlayer,"Speed Boost","Move faster than everyone","speed")
makeToggle(pPlayer,"Noclip","Walk through walls & obstacles","noclip")
makeToggle(pPlayer,"AURA Title","Floating text above your head","aura")
makeToggle(pPlayer,"SpinBot","Spin around like crazy","spinbot")
makeTextbox(pPlayer,"AURA Text","Customize your title text","auraText","John Doe")
makeSlider(pPlayer,"Jump Height","Set custom jump power","jumpVal",50,300,100)
makeSlider(pPlayer,"Speed Value","Set walk speed","speedVal",16,200,50)
makeSlider(pPlayer,"Spin Speed","Rotation speed","spinSpeed",1,50,10)
makeToggle(pPlayer,"Reset","Kill yourself to respawn","reset",function(on) if on and lp.Character then lp.Character:BreakJoints() task.wait(0.1) S.reset=false end end)

makeToggle(pFarm,"Auto Farm (AFK)","Hang safely behind random player","autofarm")
makeToggle(pFarm,"Auto Farm V2","Under map follow teammate, idle in lobby","autofarmv2")
makeToggle(pFarm,"Auto Dodge","Auto dodge incoming balls (Q/E)","autododge")
makeToggle(pFarm,"Auto Skill","Auto-use all inventory abilities","autoskill")
makeSlider(pFarm,"Distance Behind","How far behind player to hang","tpY",30,200,80)
makeSlider(pFarm,"Dodge Distance","How close ball must be to dodge","dodgeDistance",5,30,15)

makeToggle(pBall,"Freeze Time","FREEZE all balls completely","freezetime")
makeToggle(pBall,"Perfect Time","Precision slow zone near you","perfecttime")
makeToggle(pBall,"Perfect Ring","Show flat circle range indicator","perfectring")
makeToggle(pBall,"Ball Pet","Balls get stuck in your shield","ballpet")
makeToggle(pBall,"Delete Ball V2","Mega-push balls at max speed","deleteball")
makeToggle(pBall,"Ball Redirect","Push balls to nearest player","ballredirect")
makeSlider(pBall,"Freeze Strength","How much to slow the ball (1-10)","freezeStr",1,10,2)
makeSlider(pBall,"Perfect Range","Range of perfect time circle","perfectRange",5,30,10)
makeSlider(pBall,"Pet Range","How close ball must be to get trapped","petRange",4,20,8)

makeToggle(pVisuals,"ESP Players","See players through walls","esp")
makeToggle(pVisuals,"Rainbow ESP","Rainbow colored highlights","rainbowesp")
makeToggle(pVisuals,"ESP Balls","See balls through walls","espballs")
makeToggle(pVisuals,"Hitbox Viewer","See god mode & freeze zones","hitboxview")
makeToggle(pVisuals,"Anti AFK","Never get kicked for idling","antiafk")

makeToggle(pFun,"Music Player","Play music in background","musicplayer")
makeTextbox(pFun,"Music ID","Roblox audio asset ID","musicID","rbxassetid://1842801835")
makeToggle(pFun,"Snow Effect","❄️ Falling snow inside the window","snowEffect",function(on) if on then startSnow() else stopSnow() end end)

sectionInfo(pSettings,"Choose UI Theme:")
for themeName,_ in pairs(Themes) do 
    makeToggle(pSettings, themeName, "Apply "..themeName.." theme", "theme_"..themeName:lower(), function(on)
        if on then
            applyTheme(themeName)
            for otherName,_ in pairs(Themes) do
                if otherName ~= themeName then S["theme_"..otherName:lower()] = false end
            end
        end
    end)
end

-- BACKGROUND SETTINGS
local function findSettingsPage()
    for _, object in ipairs(main:GetDescendants()) do
        if object:IsA("ScrollingFrame") then
            for _, child in ipairs(object:GetDescendants()) do
                if child:IsA("TextLabel") and tostring(child.Text):find("Choose UI Theme") then
                    return object
                end
            end
        end
    end
end

local settingsPage = findSettingsPage()
if settingsPage then
    local t1 = Instance.new("TextLabel"); t1.LayoutOrder = 900; t1.Size = UDim2.new(1,0,0,0); t1.AutomaticSize = Enum.AutomaticSize.Y
    t1.BackgroundTransparency = 1; t1.Font = Enum.Font.GothamBold; t1.TextSize = 12; t1.TextColor3 = ACCENT; t1.TextWrapped = true
    t1.TextXAlignment = Enum.TextXAlignment.Left; t1.Text = "Background Image:"; t1.Parent = settingsPage

    local row = Instance.new("Frame"); row.LayoutOrder = 901; row.Size = UDim2.new(1,0,0,72); row.BackgroundColor3 = BG2
    row.BackgroundTransparency = START_PANEL_TRANSPARENCY; row.BorderSizePixel = 0; row.Parent = settingsPage; corner(row,10)
    local rs = Instance.new("UIStroke",row); rs.Color = currentTheme.Stroke; rs.Transparency = 0.25
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1,-24,0,16); lbl.Position = UDim2.fromOffset(12,7)
    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 12; lbl.TextColor3 = TXT
    lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Text = "Roblox background ID / URL"; lbl.Parent = row
    local box = Instance.new("TextBox"); box.Size = UDim2.new(1,-24,0,26); box.Position = UDim2.fromOffset(12,28)
    box.BackgroundColor3 = BG3; box.BackgroundTransparency = START_PANEL_TRANSPARENCY; box.TextColor3 = TXT
    box.PlaceholderColor3 = SUB; box.Font = Enum.Font.Code; box.TextSize = 11; box.TextXAlignment = Enum.TextXAlignment.Left
    box.ClearTextOnFocus = false; box.Text = START_BACKGROUND; box.PlaceholderText = "6395708472 or Roblox asset link"
    box.Parent = row; corner(box,8)
    local hint = Instance.new("TextLabel"); hint.Size = UDim2.new(1,-24,0,12); hint.Position = UDim2.fromOffset(12,56)
    hint.BackgroundTransparency = 1; hint.Font = Enum.Font.Gotham; hint.TextSize = 9; hint.TextColor3 = SUB
    hint.TextXAlignment = Enum.TextXAlignment.Left; hint.Text = "Use Roblox IDs/links. External JPG/PNG URLs usually do not load in ImageLabel."
    hint.Parent = row
    box.FocusLost:Connect(function() bg.Image = toImageContent(box.Text) end)

    local sRow = Instance.new("Frame"); sRow.LayoutOrder = 902; sRow.Size = UDim2.new(1,0,0,70); sRow.BackgroundColor3 = BG2
    sRow.BackgroundTransparency = START_PANEL_TRANSPARENCY; sRow.BorderSizePixel = 0; sRow.Parent = settingsPage; corner(sRow,10)
    local ss = Instance.new("UIStroke",sRow); ss.Color = currentTheme.Stroke; ss.Transparency = 0.25
    local sT = Instance.new("TextLabel"); sT.Size = UDim2.new(1,-82,0,18); sT.Position = UDim2.fromOffset(12,8)
    sT.BackgroundTransparency = 1; sT.Font = Enum.Font.GothamMedium; sT.TextSize = 12; sT.TextColor3 = TXT
    sT.TextXAlignment = Enum.TextXAlignment.Left; sT.Text = "Background Image Transparency"; sT.Parent = sRow
    local pct = Instance.new("TextLabel"); pct.Size = UDim2.fromOffset(58,18); pct.Position = UDim2.new(1,-70,0,8)
    pct.BackgroundTransparency = 1; pct.Font = Enum.Font.GothamBold; pct.TextSize = 12; pct.TextColor3 = ACCENT
    pct.TextXAlignment = Enum.TextXAlignment.Right; pct.Parent = sRow
    local bar = Instance.new("Frame"); bar.Size = UDim2.new(1,-24,0,8); bar.Position = UDim2.fromOffset(12,44)
    bar.BackgroundColor3 = BG3; bar.BorderSizePixel = 0; bar.Parent = sRow; corner(bar,4)
    local fill = Instance.new("Frame"); fill.BackgroundColor3 = ACCENT; fill.BorderSizePixel = 0; fill.Parent = bar; corner(fill,4)
    local knob = Instance.new("TextButton"); knob.Size = UDim2.fromOffset(16,16); knob.BackgroundColor3 = TXT; knob.Text = ""; knob.Parent = bar; corner(knob,8)
    local hit = Instance.new("TextButton"); hit.Size = UDim2.fromScale(1,1); hit.BackgroundTransparency = 1; hit.Text = ""; hit.Parent = bar
    local dragging = false
    local function setPercent(percent)
        percent = math.clamp(math.floor(percent+0.5),0,90)
        local ratio = percent/90
        fill.Size = UDim2.fromScale(ratio,1); knob.Position = UDim2.new(ratio,-8,0.5,-8)
        pct.Text = tostring(percent).."%"; bg.ImageTransparency = percent/100
    end
    local function updateFromInput(input)
        local ratio = math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        setPercent(ratio*90)
    end
    hit.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true; updateFromInput(input) end end)
    knob.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true; updateFromInput(input) end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then updateFromInput(input) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
    setPercent(math.floor(START_IMAGE_TRANSPARENCY*100))
end

sectionInfo(pSettings,"Panel Transparency:")
makeSlider(pSettings,"BG Transparency","0 = solid, 100 = invisible","bgTransparency",0,90,math.floor(START_PANEL_TRANSPARENCY*100), function(val) applyTransparency(val/100) end)

S["theme_cosmic"] = true

local stats = Instance.new("TextLabel"); stats.Size=UDim2.new(1,0,0,0); stats.AutomaticSize=Enum.AutomaticSize.Y; stats.BackgroundTransparency=1; stats.Font=Enum.Font.Code; stats.TextSize=12; stats.TextColor3=ACCENT; stats.TextXAlignment=Enum.TextXAlignment.Left; stats.RichText=true; stats.LayoutOrder=99; stats.Text=""; stats.Parent=pVisuals
sectionInfo(pVisuals,"<font color='#B48C8C'>RightCtrl hides the menu  •  drag the header to move</font>")
selectTab("Player")

do local drag,sp,si; header.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true; sp=main.Position; si=i.Position; i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end) end end)
UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local dd=i.Position-si; main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dd.X,sp.Y.Scale,sp.Y.Offset+dd.Y) end end) end

local mini=false; minB.MouseButton1Click:Connect(function() mini=not mini; TweenService:Create(main,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{Size=mini and UDim2.fromOffset(520,56) or UDim2.fromOffset(520,440)}):Play(); body.Visible=not mini end)
UserInputService.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.KeyCode==Enum.KeyCode.RightControl then main.Visible=not main.Visible end end)

-- ==================== ИГРОВЫЕ ФИЧИ ====================
local alive = true; local lastAutofarmPos = nil
local cachedBalls = {}; local lastBallCache = 0

local function getBalls()
    if tick()-lastBallCache>0.05 then cachedBalls={}
        for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj:GetAttribute("IsBall")) then table.insert(cachedBalls,obj) end end
        lastBallCache=tick()
    end
    return cachedBalls
end

local function findNearestBall(pos)
    local nearest=nil; local minDist=math.huge
    for _,ball in ipairs(getBalls()) do if ball and ball.Parent then local dist=(ball.Position-pos).Magnitude; if dist<minDist then minDist=dist; nearest=ball end end end
    return nearest,minDist
end

local function getPlayerTeam(player)
    local team = player.Team; if team then return team.Name end
    local char = player.Character; if not char then return nil end
    for _, child in ipairs(char:GetChildren()) do if child:IsA("Folder") and child.Name:lower():find("team") then return child.Name end end
    local teamAttr = player:GetAttribute("Team") or player:GetAttribute("team")
    if teamAttr then return teamAttr end
    return nil
end

local function getNearestTeammate()
    local myTeam = getPlayerTeam(lp); if not myTeam then return nil end
    local nearest = nil; local minDist = math.huge
    local char = lp.Character; if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = char.HumanoidRootPart.Position
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerTeam = getPlayerTeam(player)
            if playerTeam == myTeam then
                local dist = (player.Character.HumanoidRootPart.Position - myPos).Magnitude
                if dist < minDist then minDist = dist; nearest = player end
            end
        end
    end
    return nearest
end

local function getNearestPlayer()
    local nearest = nil; local minDist = math.huge
    local char = lp.Character; if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return nil end
    local myPos = root.Position
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < minDist then minDist = dist; nearest = p end
        end
    end
    return nearest
end

local function pressKey(keyCode, isDown)
    pcall(function() VIM:SendKeyEvent(isDown, keyCode, false, nil) end)
end

local function stopAllMovement()
    pressKey(Enum.KeyCode.W, false); pressKey(Enum.KeyCode.A, false)
    pressKey(Enum.KeyCode.S, false); pressKey(Enum.KeyCode.D, false)
    pressKey(Enum.KeyCode.LeftShift, false)
end

local function performDash(direction)
    local key = direction == "left" and Enum.KeyCode.Q or Enum.KeyCode.E
    pressKey(key, true); task.wait(0.02); pressKey(key, false)
    return true
end

RunService.Heartbeat:Connect(function()
    if not S.spinbot then return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    root.CFrame=root.CFrame*CFrame.Angles(0,math.rad(S.spinSpeed),0)
    local hum=char:FindFirstChild("Humanoid"); if hum then hum.AutoRotate=false end
end)

local godPart
RunService.Heartbeat:Connect(function()
    if not S.godmode then if godPart then godPart:Destroy(); godPart=nil end return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    if not godPart or not godPart.Parent then if godPart then godPart:Destroy() end
        godPart=Instance.new("Part"); godPart.Name="GodShield"; godPart.Size=Vector3.new(10,10,10)
        godPart.Transparency=S.hitboxview and 0.6 or 1; godPart.Color=Color3.fromRGB(255,0,0)
        godPart.Material=Enum.Material.ForceField; godPart.CanCollide=false; godPart.Anchored=true; godPart.Parent=workspace
    end
    godPart.CFrame=root.CFrame; godPart.Transparency=S.hitboxview and 0.6 or 1
    local balls=getBalls()
    for _,ball in ipairs(balls) do if ball and ball.Parent and (ball.Position-godPart.Position).Magnitude<8 then
        local dir=(ball.Position-godPart.Position).Unit; if dir.Magnitude<0.1 then dir=Vector3.new(0,1,0) end
        ball.Velocity=dir*25; ball.AssemblyLinearVelocity=dir*25
    end end
end)

local deletePart
RunService.Heartbeat:Connect(function()
    if not S.deleteball then if deletePart then deletePart:Destroy(); deletePart=nil end return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    if not deletePart or not deletePart.Parent then if deletePart then deletePart:Destroy() end
        deletePart=Instance.new("Part"); deletePart.Name="DeleteShield"; deletePart.Size=Vector3.new(14,14,14)
        deletePart.Transparency=S.hitboxview and 0.5 or 1; deletePart.Color=Color3.fromRGB(255,0,0)
        deletePart.Material=Enum.Material.ForceField; deletePart.CanCollide=false; deletePart.Anchored=true; deletePart.Parent=workspace
    end
    deletePart.CFrame=root.CFrame; deletePart.Transparency=S.hitboxview and 0.5 or 1
    for _,ball in ipairs(getBalls()) do if ball and ball.Parent and (ball.Position-deletePart.Position).Magnitude<10 then
        local dir=(ball.Position-deletePart.Position).Unit
        if dir.Magnitude<0.1 then dir=Vector3.new(math.random(-1,1),1,math.random(-1,1)).Unit end
        ball.Velocity=dir*2000; ball.AssemblyLinearVelocity=dir*2000
    end end
end)

local redirectPart
RunService.Heartbeat:Connect(function()
    if not S.ballredirect then if redirectPart then redirectPart:Destroy(); redirectPart=nil end return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    if not redirectPart or not redirectPart.Parent then if redirectPart then redirectPart:Destroy() end
        redirectPart=Instance.new("Part"); redirectPart.Name="RedirectShield"; redirectPart.Size=Vector3.new(16,16,16)
        redirectPart.Transparency=S.hitboxview and 0.5 or 1; redirectPart.Color=Color3.fromRGB(255,0,255)
        redirectPart.Material=Enum.Material.ForceField; redirectPart.CanCollide=false; redirectPart.Anchored=true; redirectPart.Parent=workspace
    end
    redirectPart.CFrame=root.CFrame; redirectPart.Transparency=S.hitboxview and 0.5 or 1
    local target = getNearestPlayer()
    for _,ball in ipairs(getBalls()) do
        if ball and ball.Parent and (ball.Position-redirectPart.Position).Magnitude<12 then
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = target.Character.HumanoidRootPart.Position
                local dir = (targetPos - ball.Position).Unit
                ball.Velocity = dir * 500; ball.AssemblyLinearVelocity = dir * 500
            else
                local dir = (ball.Position - redirectPart.Position).Unit
                if dir.Magnitude < 0.1 then dir = Vector3.new(0, 1, 0) end
                ball.Velocity = dir * 500; ball.AssemblyLinearVelocity = dir * 500
            end
        end
    end
end)

local trappedBalls = {}
RunService.Heartbeat:Connect(function()
    if not S.ballpet then
        for ball,_ in pairs(trappedBalls) do pcall(function() if ball and ball.Parent then ball.Anchored=false; ball.Velocity=Vector3.new(math.random(-50,50),math.random(50,100),math.random(-50,50)) end end) end
        table.clear(trappedBalls); return
    end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    for _,ball in ipairs(getBalls()) do if ball and ball.Parent and (ball.Position-root.Position).Magnitude<S.petRange then trappedBalls[ball]=true; ball.Anchored=true; ball.Velocity=Vector3.zero; ball.AssemblyLinearVelocity=Vector3.zero end end
    for ball,_ in pairs(trappedBalls) do pcall(function() if ball and ball.Parent then if (ball.Position-root.Position).Magnitude>S.petRange+3 then ball.Anchored=false; trappedBalls[ball]=nil else ball.Anchored=true; ball.Velocity=Vector3.zero; ball.AssemblyLinearVelocity=Vector3.zero end else trappedBalls[ball]=nil end end) end
end)

RunService.Heartbeat:Connect(function()
    local char=lp.Character; if not char then return end
    local hum=char:FindFirstChild("Humanoid"); if not hum then return end
    if S.jumppower then hum.JumpPower=S.jumpVal end
    if S.speed then hum.WalkSpeed=S.speedVal end
end)

RunService.Stepped:Connect(function()
    if not S.noclip then return end
    local char=lp.Character; if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
end)

RunService.Heartbeat:Connect(function()
    if not S.autofarm then if lastAutofarmPos then local char=lp.Character; if char then local root=char:FindFirstChild("HumanoidRootPart"); if root then local nearestBall=findNearestBall(root.Position); if nearestBall then root.CFrame=CFrame.new(nearestBall.Position+Vector3.new(0,15,0)); root.Velocity=Vector3.zero end; local hum=char:FindFirstChild("Humanoid"); if hum then hum.PlatformStand=false end end end; lastAutofarmPos=nil end; return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local target=nil; for _,p in ipairs(Players:GetPlayers()) do if p~=lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then target=p; break end end
    if target then local tr=target.Character.HumanoidRootPart; local behind=-tr.CFrame.LookVector; local targetPos=tr.Position+behind*S.tpY+Vector3.new(0,2,0)
        local moveDir=(targetPos-root.Position); if moveDir.Magnitude>1 then root.Velocity=moveDir.Unit*50 else root.Velocity=Vector3.new(0,0.5,0) end
        local hum=char:FindFirstChild("Humanoid"); if hum then hum.PlatformStand=true end; lastAutofarmPos=targetPos
    else root.Velocity=Vector3.new(0,0.5,0); local hum=char:FindFirstChild("Humanoid"); if hum then hum.PlatformStand=true end end
end)

RunService.Heartbeat:Connect(function()
    if not S.autofarmv2 then return end
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum=char:FindFirstChild("Humanoid")
    local myTeam=getPlayerTeam(lp)
    if not myTeam or myTeam:lower():find("lobby") then
        if hum then hum.PlatformStand=false end
        root.Velocity=Vector3.zero; root.RotVelocity=Vector3.zero; return
    end
    local teammate=getNearestTeammate()
    if teammate and teammate.Character and teammate.Character:FindFirstChild("HumanoidRootPart") then
        local tr=teammate.Character.HumanoidRootPart
        root.CFrame=CFrame.new(Vector3.new(tr.Position.X,-5,tr.Position.Z))
        root.Velocity=Vector3.zero; root.RotVelocity=Vector3.zero
        if hum then hum.PlatformStand=true; hum.AutoRotate=false end
    else
        root.CFrame=CFrame.new(Vector3.new(root.Position.X,-10,root.Position.Z))
        root.Velocity=Vector3.zero; root.RotVelocity=Vector3.zero
        if hum then hum.PlatformStand=true end
    end
end)

local lastDashTime=0; local lastScanTime=0
RunService.Heartbeat:Connect(function()
    if not S.autododge then stopAllMovement(); return end
    if tick()-lastDashTime<S.dodgeCooldown then return end
    if tick()-lastScanTime<0.05 then return end
    lastScanTime=tick()
    local char=lp.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum=char:FindFirstChild("Humanoid"); if not hum or hum.Health<=0 then return end
    local myPos=root.Position
    local nearestBall=nil; local nearestDist=S.dodgeDistance; local nearestCrossSide=nil
    for _,ball in ipairs(getBalls()) do
        if ball and ball.Parent and ball.Velocity.Magnitude>5 then
            local ballPos=ball.Position; local dist=(ballPos-myPos).Magnitude
            local futurePos=ballPos+ball.Velocity*0.2; local futureDist=(futurePos-myPos).Magnitude
            if futureDist<4.0 and dist<nearestDist then
                nearestDist=dist; nearestBall=ball
                local toBall=(ballPos-myPos).Unit
                local cross=toBall:Cross(Vector3.new(0,1,0))
                nearestCrossSide=cross:Dot(root.CFrame.RightVector)>0 and "right" or "left"
            end
        end
    end
    if nearestBall then
        if nearestCrossSide=="right" then performDash("left") else performDash("right") end
        lastDashTime=tick()
    else stopAllMovement() end
end)

local freezePart
task.spawn(function() while alive do
    if S.freezetime then
        if not freezePart or not freezePart.Parent then freezePart=Instance.new("Part"); freezePart.Name="FreezeZone"; freezePart.Size=Vector3.new(300,300,300)
            freezePart.Transparency=S.hitboxview and 0.4 or 1; freezePart.Color=Color3.fromRGB(0,150,255)
            freezePart.Anchored=true; freezePart.CanCollide=false; freezePart.Parent=workspace end
        freezePart.CFrame=CFrame.new(0,150,0); freezePart.Transparency=S.hitboxview and 0.4 or 1
        for _,ball in ipairs(getBalls()) do if ball and ball.Parent then ball.Velocity=Vector3.zero; ball.AssemblyLinearVelocity=Vector3.zero end end
    else if freezePart then freezePart:Destroy(); freezePart=nil end end
    task.wait(0.05)
end end)

local perfectPart, perfectRing
task.spawn(function() while alive do
    if S.perfecttime then
        local char=lp.Character; if char then local root=char:FindFirstChild("HumanoidRootPart"); if root then
            if not perfectPart or not perfectPart.Parent then perfectPart=Instance.new("Part"); perfectPart.Name="PerfectZone"; perfectPart.Anchored=true; perfectPart.CanCollide=false; perfectPart.Parent=workspace end
            perfectPart.Size=Vector3.new(S.perfectRange*2,S.perfectRange*2,S.perfectRange*2); perfectPart.CFrame=root.CFrame; perfectPart.Transparency=S.hitboxview and 0.4 or 1; perfectPart.Color=Color3.fromRGB(255,200,0)
            if S.perfectring then
                if not perfectRing or not perfectRing.Parent then if perfectRing then perfectRing:Destroy() end; perfectRing=Instance.new("Part"); perfectRing.Name="PerfectRing"; perfectRing.Shape=Enum.PartType.Cylinder; perfectRing.Anchored=true; perfectRing.CanCollide=false; perfectRing.Material=Enum.Material.Neon; perfectRing.Parent=workspace end
                perfectRing.Size=Vector3.new(S.perfectRange*2,0.3,S.perfectRange*2); perfectRing.CFrame=CFrame.new(root.Position); perfectRing.Transparency=S.hitboxview and 0.4 or 1; perfectRing.Color=Color3.fromRGB(255,200,0)
            else if perfectRing then perfectRing:Destroy(); perfectRing=nil end end
            for _,ball in ipairs(getBalls()) do if ball and ball.Parent and (ball.Position-root.Position).Magnitude<S.perfectRange then ball.Velocity=ball.Velocity*0.01; ball.AssemblyLinearVelocity=ball.AssemblyLinearVelocity*0.01 end end
        end end
    else if perfectPart then perfectPart:Destroy(); perfectPart=nil end; if perfectRing then perfectRing:Destroy(); perfectRing=nil end end
    task.wait(0.05)
end end)

task.spawn(function() while alive do if S.autoskill then local char=lp.Character; local backpack=lp:FindFirstChild("Backpack")
    if char and backpack then for _,tool in ipairs(backpack:GetChildren()) do if tool:IsA("Tool") and alive and S.autoskill then pcall(function() tool.Parent=char; tool:Activate() end) end end
    for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") and alive and S.autoskill then pcall(function() tool:Activate() end) end end end end
    task.wait(0.3)
end end)

local auraBillboard, auraText
task.spawn(function() while alive do if S.aura then local char=lp.Character; if char then local head=char:FindFirstChild("Head"); if head then
    if not auraBillboard or not auraBillboard.Parent then if auraBillboard then auraBillboard:Destroy() end
        auraBillboard=Instance.new("BillboardGui"); auraBillboard.Size=UDim2.new(0,200,0,60); auraBillboard.StudsOffset=Vector3.new(0,3,0); auraBillboard.Adornee=head; auraBillboard.Parent=char
        auraText=Instance.new("TextLabel"); auraText.BackgroundTransparency=1; auraText.BorderSizePixel=0; auraText.Text=S.auraText; auraText.Font=Enum.Font.GothamBlack; auraText.TextSize=28; auraText.TextColor3=ACCENT; auraText.Size=UDim2.new(1,0,1,0)
        Instance.new("UIStroke",auraText).Color=Color3.new(0,0,0); auraText:FindFirstChildOfClass("UIStroke").Thickness=3
        local s2=Instance.new("UIStroke",auraText); s2.Color=Color3.fromRGB(255,255,255); s2.Thickness=1
        auraText.Parent=auraBillboard
    end
    if math.random(0,100)<10 then auraText.Text=({"NOHOPE","GIVEUP","BURNINHELL"})[math.random(1,3)] else auraText.Text=S.auraText end
    auraText.Position=UDim2.new(0,math.random(-3,3),0,math.random(-3,3))
end end
else if auraBillboard then auraBillboard:Destroy(); auraBillboard=nil; auraText=nil end end
task.wait(0.05) end end)

local espObjects = {}
task.spawn(function() local rainbowHue=0
while alive do if S.esp then rainbowHue=(rainbowHue+0.01)%1
    for _,player in ipairs(Players:GetPlayers()) do if player~=lp and player.Character then local hum=player.Character:FindFirstChild("Humanoid"); if hum and hum.Health>0 then
        if not espObjects[player] then local h=Instance.new("Highlight"); h.FillColor=Color3.fromRGB(255,80,80); h.OutlineColor=Color3.fromRGB(255,255,255); h.FillTransparency=0.4; h.Parent=player.Character; espObjects[player]=h end
        if S.rainbowesp and espObjects[player] then local hue=(rainbowHue+player.UserId%100/100)%1; espObjects[player].FillColor=Color3.fromHSV(hue,1,1); espObjects[player].OutlineColor=Color3.fromHSV((hue+0.5)%1,1,1)
        elseif not S.rainbowesp and espObjects[player] then espObjects[player].FillColor=Color3.fromRGB(255,80,80); espObjects[player].OutlineColor=Color3.fromRGB(255,255,255) end
    end end end
else for k,v in pairs(espObjects) do pcall(function() v:Destroy() end); espObjects[k]=nil end end
if S.espballs then for _,ball in ipairs(getBalls()) do if ball and ball.Parent and not ball:FindFirstChild("BallESP") then local h=Instance.new("Highlight"); h.Name="BallESP"; h.FillColor=Color3.fromRGB(255,255,0); h.OutlineColor=Color3.fromRGB(255,0,0); h.FillTransparency=0.5; h.Parent=ball end
    if S.rainbowesp then local ballEsp=ball:FindFirstChild("BallESP"); if ballEsp then local hue=(rainbowHue+#ball.Name%10/10)%1; ballEsp.FillColor=Color3.fromHSV(hue,1,1); ballEsp.OutlineColor=Color3.fromHSV((hue+0.5)%1,1,1) end end end
else for _,ball in ipairs(getBalls()) do local esp=ball and ball:FindFirstChild("BallESP"); if esp then esp:Destroy() end end end
task.wait(0.05) end end)

local musicSound
task.spawn(function() while alive do if S.musicplayer then if not musicSound or not musicSound.Parent then if musicSound then musicSound:Destroy() end
    musicSound=Instance.new("Sound"); musicSound.Name="MusicPlayer"; musicSound.SoundId=S.musicID; musicSound.Looped=true; musicSound.Volume=1; musicSound.Parent=workspace; musicSound:Play()
elseif musicSound.SoundId~=S.musicID then musicSound.SoundId=S.musicID; musicSound:Play() end
else if musicSound then musicSound:Stop(); musicSound:Destroy(); musicSound=nil end end
task.wait(1) end end)

lp.Idled:Connect(function() if S.antiafk then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end end)

task.spawn(function() while alive do local char=lp.Character; local hp="?"; if char then local hum=char:FindFirstChild("Humanoid"); if hum then hp=math.floor(hum.Health) end end
local tc=0; for _ in pairs(trappedBalls) do tc+=1 end
stats.Text=string.format("HP: %s | Balls: %d | Trapped: %d\nGod: %s | Freeze: %s | Pet: %s | Delete: %s | Redirect: %s | Dodge: %s | ❄️Snow: %s",
    hp,#getBalls(),tc, S.godmode and "✅" or "❌", S.freezetime and "✅" or "❌", S.ballpet and "✅" or "❌", S.deleteball and "✅" or "❌", S.ballredirect and "✅" or "❌", S.autododge and "✅" or "❌", S.snowEffect and "✅" or "❌")
task.wait(0.5) end end)

closeB.MouseButton1Click:Connect(function() if _G.Sm1leHub then _G.Sm1leHub.Destroy() end end)

_G.Sm1leHub = {
    Destroy = function()
        alive=false; for k in pairs(S) do if type(S[k])=="boolean" then S[k]=false end end
        stopAllMovement(); stopSnow()
        if gui then gui:Destroy() end
        if godPart then godPart:Destroy() end
        if deletePart then deletePart:Destroy() end
        if redirectPart then redirectPart:Destroy() end
        if freezePart then freezePart:Destroy() end
        if perfectPart then perfectPart:Destroy() end
        if perfectRing then perfectRing:Destroy() end
        if auraBillboard then auraBillboard:Destroy() end
        if musicSound then musicSound:Stop(); musicSound:Destroy() end
        for ball,_ in pairs(trappedBalls) do pcall(function() if ball and ball.Parent then ball.Anchored=false end end) end
        table.clear(trappedBalls)
        for _,v in pairs(espObjects) do pcall(function() v:Destroy() end) end; table.clear(espObjects)
        _G.Sm1leHub=nil
    end
}
