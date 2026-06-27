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

task.wait(10.9)

-- ==================== ОСНОВНОЙ СКРИПТ ====================
local START_BACKGROUND = "https://create.roblox.com/store/asset/6395708472/Black-Hole"
local START_PANEL_TRANSPARENCY = 0.5
local START_IMAGE_TRANSPARENCY = 0.05

local S = {
    jumppower = false, speed = false, autofarm = false, autofarmv2 = false,
    autododge = false, autoskill = false,
    esp = false, antiafk = false, noclip = false,
    aura = false, spinbot = false, reset = false, rainbowesp = false, musicplayer = false,
    snowEffect = false,
    jumpVal = 100, speedVal = 50, tpY = 80,
    auraText = "John Doe",
    musicID = "rbxassetid://1842801835", spinSpeed = 10, theme = "Cosmic",
    bgTransparency = math.floor(START_PANEL_TRANSPARENCY * 100), dodgeDistance = 15, dodgeCooldown = 0.3
}

local Themes = {
    Blood = { ACCENT = Color3.fromRGB(255,0,0), ACCENT2 = Color3.fromRGB(0,0,0), BG = Color3.fromRGB(20,5,5), BG2 = Color3.fromRGB(30,8,8), BG3 = Color3.fromRGB(45,12,12), TXT = Color3.fromRGB(255,240,240), SUB = Color3.fromRGB(200,150,150), Stroke = Color3.fromRGB(120,15,15), SwitchOff = Color3.fromRGB(45,12,12), TitleGrad1 = Color3.fromRGB(255,0,0), TitleGrad2 = Color3.fromRGB(0,0,0), ByGrad1 = Color3.fromRGB(255,80,80), ByGrad2 = Color3.fromRGB(0,0,0) },
    Ocean = { ACCENT = Color3.fromRGB(0,100,255), ACCENT2 = Color3.fromRGB(0,0,40), BG = Color3.fromRGB(5,8,20), BG2 = Color3.fromRGB(8,12,30), BG3 = Color3.fromRGB(12,18,45), TXT = Color3.fromRGB(235,240,255), SUB = Color3.fromRGB(140,160,200), Stroke = Color3.fromRGB(15,40,120), SwitchOff = Color3.fromRGB(12,18,45), TitleGrad1 = Color3.fromRGB(0,150,255), TitleGrad2 = Color3.fromRGB(0,0,50), ByGrad1 = Color3.fromRGB(0,180,255), ByGrad2 = Color3.fromRGB(0,0,50) },
    Midnight = { ACCENT = Color3.fromRGB(140,0,255), ACCENT2 = Color3.fromRGB(5,0,20), BG = Color3.fromRGB(8,5,20), BG2 = Color3.fromRGB(14,8,30), BG3 = Color3.fromRGB(22,12,45), TXT = Color3.fromRGB(240,235,255), SUB = Color3.fromRGB(160,140,200), Stroke = Color3.fromRGB(50,10,120), SwitchOff = Color3.fromRGB(22,12,45), TitleGrad1 = Color3.fromRGB(170,50,255), TitleGrad2 = Color3.fromRGB(10,0,30), ByGrad1 = Color3.fromRGB(180,80,255), ByGrad2 = Color3.fromRGB(10,0,30) },
    Forest = { ACCENT = Color3.fromRGB(0,200,50), ACCENT2 = Color3.fromRGB(0,15,0), BG = Color3.fromRGB(5,15,5), BG2 = Color3.fromRGB(8,22,8), BG3 = Color3.fromRGB(12,32,12), TXT = Color3.fromRGB(235,255,235), SUB = Color3.fromRGB(140,200,140), Stroke = Color3.fromRGB(15,80,15), SwitchOff = Color3.fromRGB(12,32,12), TitleGrad1 = Color3.fromRGB(0,255,80), TitleGrad2 = Color3.fromRGB(0,20,0), ByGrad1 = Color3.fromRGB(50,255,100), ByGrad2 = Color3.fromRGB(0,20,0) },
    Sunset = { ACCENT = Color3.fromRGB(255,120,0), ACCENT2 = Color3.fromRGB(20,3,0), BG = Color3.fromRGB(18,8,3), BG2 = Color3.fromRGB(28,12,5), BG3 = Color3.fromRGB(42,18,8), TXT = Color3.fromRGB(255,245,235), SUB = Color3.fromRGB(200,160,120), Stroke = Color3.fromRGB(100,30,5), SwitchOff = Color3.fromRGB(42,18,8), TitleGrad1 = Color3.fromRGB(255,150,30), TitleGrad2 = Color3.fromRGB(30,5,0), ByGrad1 = Color3.fromRGB(255,170,50), ByGrad2 = Color3.fromRGB(30,5,0) },
    System = { ACCENT = Color3.fromRGB(0,200,200), ACCENT2 = Color3.fromRGB(0,20,20), BG = Color3.fromRGB(3,15,15), BG2 = Color3.fromRGB(5,22,22), BG3 = Color3.fromRGB(8,32,32), TXT = Color3.fromRGB(220,255,255), SUB = Color3.fromRGB(130,200,200), Stroke = Color3.fromRGB(10,80,80), SwitchOff = Color3.fromRGB(8,32,32), TitleGrad1 = Color3.fromRGB(0,255,255), TitleGrad2 = Color3.fromRGB(0,30,30), ByGrad1 = Color3.fromRGB(50,255,255), ByGrad2 = Color3.fromRGB(0,30,30) },
    Cosmic = { ACCENT = Color3.fromRGB(180,130,255), ACCENT2 = Color3.fromRGB(0,0,0), BG = Color3.fromRGB(5,3,12), BG2 = Color3.fromRGB(10,5,22), BG3 = Color3.fromRGB(18,10,35), TXT = Color3.fromRGB(245,240,255), SUB = Color3.fromRGB(170,155,210), Stroke = Color3.fromRGB(80,50,140), SwitchOff = Color3.fromRGB(18,10,35), TitleGrad1 = Color3.fromRGB(200,150,255), TitleGrad2 = Color3.fromRGB(30,10,60), ByGrad1 = Color3.fromRGB(210,170,255), ByGrad2 = Color3.fromRGB(30,10,60) }
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

local bg = Instance.new("ImageLabel")
bg.Name = "SM1LE_WorkingBackground"; bg.BackgroundTransparency = 1; bg.BorderSizePixel = 0
bg.Position = UDim2.fromScale(0,0); bg.Size = UDim2.fromScale(1,1)
bg.Image = toImageContent(START_BACKGROUND); bg.ScaleType = Enum.ScaleType.Crop
bg.ImageTransparency = START_IMAGE_TRANSPARENCY; bg.ZIndex = 1; bg.Parent = main; corner(bg,16)

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
local pVisuals = makeTab("Visuals","👁️")
local pFun = makeTab("Fun","🎵")
local pSettings = makeTab("Settings","⚙️")

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

makeToggle(pVisuals,"ESP Players","See players through walls","esp")
makeToggle(pVisuals,"Rainbow ESP","Rainbow colored highlights","rainbowesp")
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
local alive = true
local lastAutofarmPos = nil

local function findBalls()
    local balls = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj:GetAttribute("IsBall")) then
            table.insert(balls, obj)
        end
    end
    return balls
end

local function getPlayerTeam(p)
    if p.Team then return p.Team.Name end
    return p:GetAttribute("Team") or p:GetAttribute("team")
end

local function getNearestTeammate()
    local myTeam = getPlayerTeam(lp)
    if not myTeam then return nil end
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = char.HumanoidRootPart.Position
    local nearest, minDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if getPlayerTeam(p) == myTeam then
                local d = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
                if d < minDist then minDist = d; nearest = p end
            end
        end
    end
    return nearest
end

-- JUMP POWER & SPEED
RunService.Heartbeat:Connect(function()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if S.jumppower then hum.JumpPower = S.jumpVal end
    if S.speed then hum.WalkSpeed = S.speedVal end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if not S.noclip then return end
    local char = lp.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- AUTO FARM
RunService.Heartbeat:Connect(function()
    if not S.autofarm then
        if lastAutofarmPos then
            local char = lp.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then hum.PlatformStand = false end
            end
            lastAutofarmPos = nil
        end
        return
    end
    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local target = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            target = p; break
        end
    end
    if target then
        local tr = target.Character.HumanoidRootPart
        local behind = -tr.CFrame.LookVector
        local targetPos = tr.Position + behind * S.tpY + Vector3.new(0, 2, 0)
        local moveDir = (targetPos - root.Position)
        if moveDir.Magnitude > 1 then
            root.Velocity = moveDir.Unit * 50
        else
            root.Velocity = Vector3.new(0, 0.5, 0)
        end
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = true end
        lastAutofarmPos = targetPos
    else
        root.Velocity = Vector3.new(0, 0.5, 0)
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = true end
    end
end)

-- AUTO FARM V2
RunService.Heartbeat:Connect(function()
    if not S.autofarmv2 then return end
    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local team = getPlayerTeam(lp)
    if team and not team:lower():find("lobby") then
        local nearest = nil
        local minDist = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pt = getPlayerTeam(p)
                if pt == team then
                    local d = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    if d < minDist then minDist = d; nearest = p end
                end
            end
        end
        if nearest then
            root.CFrame = CFrame.new(nearest.Character.HumanoidRootPart.Position.X, -5, nearest.Character.HumanoidRootPart.Position.Z)
        end
    end
    root.Velocity = Vector3.zero
end)

-- AUTO DODGE (телепорт x6)
local lastDashTime = 0
task.spawn(function() while alive do if S.autododge and tick() - lastDashTime >= S.dodgeCooldown then
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local pos = root.Position
        local side = nil
        local nearDist = S.dodgeDistance
        for _, v in ipairs(findBalls()) do
            pcall(function()
                if v and v.Parent and v.Velocity.Magnitude > 2 then
                    local fp = v.Position + v.Velocity * 0.25
                    if (fp - pos).Magnitude < 6 and (v.Position - pos).Magnitude < nearDist then
                        nearDist = (v.Position - pos).Magnitude
                        local cr = (v.Position - pos).Unit:Cross(Vector3.new(0,1,0))
                        side = cr:Dot(root.CFrame.RightVector) > 0 and "right" or "left"
                    end
                end
            end)
        end
        if side then
            local dashDir = side == "right" and -root.CFrame.RightVector or root.CFrame.RightVector
            root.CFrame = root.CFrame + dashDir * 6
            lastDashTime = tick()
        end
    end
end task.wait(0.03) end end)

-- SPINBOT
task.spawn(function() while alive do if S.spinbot then
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(S.spinSpeed), 0)
    end
end task.wait(0.01) end end)

-- AUTO SKILL
task.spawn(function()
    while alive do
        if S.autoskill then
            local char = lp.Character
            local backpack = lp:FindFirstChild("Backpack")
            if char and backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and alive and S.autoskill then
                        pcall(function() tool.Parent = char; tool:Activate() end)
                    end
                end
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") and alive and S.autoskill then
                        pcall(function() tool:Activate() end)
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)

-- AURA
local auraBillboard, auraText
task.spawn(function()
    while alive do
        if S.aura then
            local char = lp.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    if not auraBillboard or not auraBillboard.Parent then
                        if auraBillboard then auraBillboard:Destroy() end
                        auraBillboard = Instance.new("BillboardGui")
                        auraBillboard.Size = UDim2.new(0, 200, 0, 60)
                        auraBillboard.StudsOffset = Vector3.new(0, 3, 0)
                        auraBillboard.Adornee = head
                        auraBillboard.Parent = char
                        auraText = Instance.new("TextLabel")
                        auraText.BackgroundTransparency = 1
                        auraText.BorderSizePixel = 0
                        auraText.Text = S.auraText
                        auraText.Font = Enum.Font.GothamBlack
                        auraText.TextSize = 28
                        auraText.TextColor3 = ACCENT
                        auraText.Size = UDim2.new(1, 0, 1, 0)
                        local s1 = Instance.new("UIStroke", auraText); s1.Color = Color3.new(0, 0, 0); s1.Thickness = 3
                        local s2 = Instance.new("UIStroke", auraText); s2.Color = Color3.fromRGB(255, 255, 255); s2.Thickness = 1
                        auraText.Parent = auraBillboard
                    end
                    if math.random(0, 100) < 10 then
                        auraText.Text = ({"NOHOPE", "GIVEUP", "BURNINHELL"})[math.random(1, 3)]
                    else
                        auraText.Text = S.auraText
                    end
                    auraText.Position = UDim2.new(0, math.random(-3, 3), 0, math.random(-3, 3))
                end
            end
        else
            if auraBillboard then auraBillboard:Destroy(); auraBillboard = nil; auraText = nil end
        end
        task.wait(0.05)
    end
end)

-- ESP
local espObjects = {}
task.spawn(function()
    while alive do
        if S.esp then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character then
                    local hum = player.Character:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 then
                        if not espObjects[player] then
                            local h = Instance.new("Highlight")
                            h.FillColor = S.rainbowesp and Color3.fromHSV(tick()%5/5,1,1) or Color3.fromRGB(255, 80, 80)
                            h.OutlineColor = Color3.fromRGB(255, 255, 255)
                            h.FillTransparency = 0.4
                            h.Parent = player.Character
                            espObjects[player] = h
                        end
                    end
                end
            end
        else
            for k, v in pairs(espObjects) do
                pcall(function() v:Destroy() end)
                espObjects[k] = nil
            end
        end
        task.wait(0.5)
    end
end)

-- MUSIC PLAYER
local music
task.spawn(function() while alive do if S.musicplayer then
    if not music then
        music = Instance.new("Sound")
        music.SoundId = S.musicID
        music.Looped = true
        music.Volume = 1
        music.Parent = workspace
        music:Play()
    end
else if music then music:Stop(); music:Destroy(); music = nil end end
task.wait(1) end end)

-- ANTI AFK
lp.Idled:Connect(function()
    if S.antiafk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- STATS
task.spawn(function()
    while alive do
        local char = lp.Character
        local hp = "?"
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hp = math.floor(hum.Health) end
        end
        stats.Text = string.format("HP: %s | Balls: %d\nSpeed: %s | Jump: %s | Dodge: %s",
            hp, #findBalls(),
            S.speed and "✅" or "❌",
            S.jumppower and "✅" or "❌",
            S.autododge and "✅" or "❌")
        task.wait(0.5)
    end
end)

closeB.MouseButton1Click:Connect(function()
    if _G.Sm1leHub then _G.Sm1leHub.Destroy() end
end)

_G.Sm1leHub = {
    Destroy = function()
        alive = false
        for k in pairs(S) do if type(S[k]) == "boolean" then S[k] = false end end
        stopSnow()
        if gui then gui:Destroy() end
        if auraBillboard then auraBillboard:Destroy() end
        if music then music:Stop(); music:Destroy() end
        for _, v in pairs(espObjects) do pcall(function() v:Destroy() end) end; table.clear(espObjects)
        _G.Sm1leHub = nil
    end
}
