--==================================================================
-- 🏃 DODGE HUB v5.3 — Оптимизированная версия
-- RightCtrl hides, — minimizes, ✕ closes.
--==================================================================
if _G.DodgeHub and _G.DodgeHub.Destroy then pcall(_G.DodgeHub.Destroy) end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local lp = Players.LocalPlayer

local S = {
    godmode = false,
    jumppower = false,
    speed = false,
    autofarm = false,
    freezetime = false,
    perfecttime = false,
    deleteball = false,
    autoskill = false,
    esp = false,
    espballs = false,
    antiafk = false,
    noclip = false,
    hitboxview = false,
    aura = false,
    ballpet = false,
    perfectring = false,
    reset = false,
    jumpVal = 100,
    speedVal = 50,
    freezeStr = 2,
    tpY = 80,
    perfectRange = 10,
    petRange = 8,
    auraText = "John Doe"
}

local ACCENT = Color3.fromRGB(255, 80, 80)
local ACCENT2 = Color3.fromRGB(255, 160, 60)
local BG = Color3.fromRGB(18, 19, 24)
local BG2 = Color3.fromRGB(26, 28, 35)
local BG3 = Color3.fromRGB(34, 37, 46)
local TXT = Color3.fromRGB(236, 238, 243)
local SUB = Color3.fromRGB(150, 155, 168)

local function corner(p, r) local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, r) c.Parent = p return c end
local function pad(p, t, b, l, r) local u = Instance.new("UIPadding") u.PaddingTop = UDim.new(0, t) u.PaddingBottom = UDim.new(0, b) u.PaddingLeft = UDim.new(0, l) u.PaddingRight = UDim.new(0, r) u.Parent = p return u end
local function gradient(p, c1, c2, rot) local g = Instance.new("UIGradient") g.Color = ColorSequence.new(c1, c2) g.Rotation = rot or 0 g.Parent = p return g end

local parent = (gethui and gethui()) or game:GetService("CoreGui")
local gui = Instance.new("ScreenGui")
gui.Name = "DodgeHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.Parent = parent

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(520, 440)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
corner(main, 16)

local mst = Instance.new("UIStroke", main)
mst.Color = Color3.fromRGB(60, 64, 76)
mst.Thickness = 1
mst.Transparency = 0.2

local shadow = Instance.new("ImageLabel")
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.45
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(23, 23, 277, 277)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.fromOffset(-20, -16)
shadow.ZIndex = 0
shadow.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 56)
header.BackgroundColor3 = BG2
header.BorderSizePixel = 0
header.Parent = main
corner(header, 16)
local hfix = Instance.new("Frame")
hfix.Size = UDim2.new(1, 0, 0, 16)
hfix.Position = UDim2.new(0, 0, 1, -16)
hfix.BackgroundColor3 = BG2
hfix.BorderSizePixel = 0
hfix.Parent = header

local logo = Instance.new("TextLabel")
logo.Size = UDim2.fromOffset(40, 40)
logo.Position = UDim2.fromOffset(14, 8)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.Text = "🏃"
logo.TextSize = 28
logo.Parent = header

local titleC = Instance.new("TextLabel")
titleC.Size = UDim2.fromOffset(200, 22)
titleC.Position = UDim2.fromOffset(58, 11)
titleC.BackgroundTransparency = 1
titleC.Font = Enum.Font.GothamBold
titleC.TextSize = 19
titleC.TextColor3 = TXT
titleC.Text = "Dodge Hub v5.3"
titleC.TextXAlignment = Enum.TextXAlignment.Left
titleC.Parent = header
gradient(titleC, ACCENT2, ACCENT, 0)

local byLabel = Instance.new("TextLabel")
byLabel.Size = UDim2.fromOffset(100, 12)
byLabel.Position = UDim2.fromOffset(58, 30)
byLabel.BackgroundTransparency = 1
byLabel.Font = Enum.Font.GothamMedium
byLabel.TextSize = 10
byLabel.TextColor3 = ACCENT2
byLabel.Text = "by Ender01"
byLabel.TextXAlignment = Enum.TextXAlignment.Left
byLabel.Parent = header

local statusL = Instance.new("TextLabel")
statusL.Size = UDim2.fromOffset(280, 16)
statusL.Position = UDim2.fromOffset(58, 42)
statusL.BackgroundTransparency = 1
statusL.Font = Enum.Font.GothamMedium
statusL.TextSize = 11
statusL.TextColor3 = SUB
statusL.Text = "🏟️ Dodge or Die"
statusL.TextXAlignment = Enum.TextXAlignment.Left
statusL.Parent = header

local function hbtn(txt, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(28, 28)
    b.Position = UDim2.new(1, x, 0, 14)
    b.BackgroundColor3 = BG3
    b.Text = txt
    b.TextColor3 = TXT
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    b.AutoButtonColor = true
    b.Parent = header
    corner(b, 8)
    return b
end
local closeB = hbtn("✕", -40)
local minB = hbtn("—", -74)

local body = Instance.new("Frame")
body.Size = UDim2.new(1, 0, 1, -56)
body.Position = UDim2.fromOffset(0, 56)
body.BackgroundTransparency = 1
body.Parent = main

local side = Instance.new("Frame")
side.Size = UDim2.new(0, 140, 1, 0)
side.BackgroundColor3 = BG2
side.BorderSizePixel = 0
side.Parent = body
pad(side, 12, 12, 10, 10)
local sl = Instance.new("UIListLayout", side)
sl.Padding = UDim.new(0, 6)
sl.SortOrder = Enum.SortOrder.LayoutOrder

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -140, 1, 0)
content.Position = UDim2.fromOffset(140, 0)
content.BackgroundTransparency = 1
content.Parent = body

local tabs = {}
local pages = {}
local activeTab = nil

local function selectTab(name)
    activeTab = name
    for n, m in pairs(tabs) do
        local on = (n == name)
        TweenService:Create(m.btn, TweenInfo.new(0.18), { BackgroundColor3 = on and BG3 or BG2 }):Play()
        m.accent.Visible = on
        m.lbl.TextColor3 = on and TXT or SUB
    end
    for n, p in pairs(pages) do
        p.Visible = (n == name)
    end
end

local tabOrder = 0
local function makeTab(name, icon)
    tabOrder += 1
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = BG2
    b.AutoButtonColor = false
    b.Text = ""
    b.LayoutOrder = tabOrder
    b.Parent = side
    corner(b, 10)

    local acc = Instance.new("Frame")
    acc.Size = UDim2.fromOffset(3, 20)
    acc.Position = UDim2.fromOffset(0, 10)
    acc.BackgroundColor3 = ACCENT
    acc.BorderSizePixel = 0
    acc.Visible = false
    acc.Parent = b
    corner(acc, 2)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.fromOffset(14, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13.5
    lbl.TextColor3 = SUB
    lbl.Text = icon .. "  " .. name
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = b

    tabs[name] = { btn = b, accent = acc, lbl = lbl }

    b.MouseEnter:Connect(function()
        if activeTab ~= name then b.BackgroundColor3 = BG3 end
    end)
    b.MouseLeave:Connect(function()
        if activeTab ~= name then b.BackgroundColor3 = BG2 end
    end)
    b.MouseButton1Click:Connect(function()
        selectTab(name)
    end)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = false
    page.Parent = content
    pad(page, 14, 14, 16, 14)

    local pl = Instance.new("UIListLayout", page)
    pl.Padding = UDim.new(0, 9)
    pl.SortOrder = Enum.SortOrder.LayoutOrder

    pages[name] = page
    return page
end

local rowOrder = 0

local function makeToggle(page, label, desc, key, callback)
    rowOrder += 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 46)
    row.BackgroundColor3 = BG2
    row.BorderSizePixel = 0
    row.LayoutOrder = rowOrder
    row.Parent = page
    corner(row, 10)

    local st = Instance.new("UIStroke", row)
    st.Color = Color3.fromRGB(46, 49, 60)
    st.Thickness = 1
    st.Transparency = 0.4

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -70, 0, 18)
    t.Position = UDim2.fromOffset(12, 6)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamMedium
    t.TextSize = 13.5
    t.TextColor3 = TXT
    t.Text = label
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = row

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1, -70, 0, 13)
    d.Position = UDim2.fromOffset(12, 25)
    d.BackgroundTransparency = 1
    d.Font = Enum.Font.Gotham
    d.TextSize = 10.5
    d.TextColor3 = SUB
    d.Text = desc
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.Parent = row

    local sw = Instance.new("Frame")
    sw.Size = UDim2.fromOffset(44, 24)
    sw.Position = UDim2.new(1, -56, 0.5, -12)
    sw.BackgroundColor3 = BG3
    sw.BorderSizePixel = 0
    sw.Parent = row
    corner(sw, 12)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(18, 18)
    knob.Position = UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = Color3.fromRGB(245, 246, 250)
    knob.BorderSizePixel = 0
    knob.Parent = sw
    corner(knob, 9)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = row

    local function render()
        local on = S[key]
        TweenService:Create(sw, TweenInfo.new(0.18), { BackgroundColor3 = on and ACCENT or BG3 }):Play()
        TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Back), { Position = on and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3) }):Play()
        TweenService:Create(st, TweenInfo.new(0.18), { Color = on and ACCENT or Color3.fromRGB(46, 49, 60) }):Play()
    end

    btn.MouseButton1Click:Connect(function()
        S[key] = not S[key]
        render()
        if callback then callback(S[key]) end
    end)
    render()
end

local function makeSlider(page, label, desc, key, min, max, default)
    S[key] = S[key] or default
    rowOrder += 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 70)
    row.BackgroundColor3 = BG2
    row.BorderSizePixel = 0
    row.LayoutOrder = rowOrder
    row.Parent = page
    corner(row, 10)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -70, 0, 18)
    t.Position = UDim2.fromOffset(12, 8)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamMedium
    t.TextSize = 13.5
    t.TextColor3 = TXT
    t.Text = label
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = row

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.fromOffset(60, 18)
    valLabel.Position = UDim2.new(1, -72, 0, 8)
    valLabel.BackgroundTransparency = 1
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextSize = 13
    valLabel.TextColor3 = ACCENT
    valLabel.Text = tostring(S[key] or default)
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.Parent = row

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1, -24, 0, 13)
    d.Position = UDim2.fromOffset(12, 28)
    d.BackgroundTransparency = 1
    d.Font = Enum.Font.Gotham
    d.TextSize = 10.5
    d.TextColor3 = SUB
    d.Text = desc
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.Parent = row

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 8)
    bar.Position = UDim2.fromOffset(12, 48)
    bar.BackgroundColor3 = BG3
    bar.BorderSizePixel = 0
    bar.Parent = row
    corner(bar, 4)

    local fill = Instance.new("Frame")
    local ratio = ((S[key] or default) - min) / (max - min)
    fill.Size = UDim2.fromScale(ratio, 1)
    fill.BackgroundColor3 = ACCENT
    fill.BorderSizePixel = 0
    fill.Parent = bar
    corner(fill, 4)

    local dot = Instance.new("TextButton")
    dot.Size = UDim2.fromOffset(16, 16)
    dot.Position = UDim2.new(ratio, -8, 0.5, -8)
    dot.BackgroundColor3 = TXT
    dot.Text = ""
    dot.Parent = bar
    corner(dot, 8)
    dot.ZIndex = 2

    local hitArea = Instance.new("TextButton")
    hitArea.Size = UDim2.new(1, 0, 1, 0)
    hitArea.BackgroundTransparency = 1
    hitArea.Text = ""
    hitArea.Parent = bar

    local dragging = false
    local inputConnection

    local function updateSlider(input)
        local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = min + math.floor((max - min) * relX + 0.5)
        S[key] = val
        fill.Size = UDim2.fromScale(relX, 1)
        dot.Position = UDim2.new(relX, -8, 0.5, -8)
        valLabel.Text = tostring(val)
    end

    local function startDrag(input)
        dragging = true
        if inputConnection then inputConnection:Disconnect() end
        inputConnection = UserInputService.InputChanged:Connect(function(input2)
            if dragging and (input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input2)
            end
        end)
        updateSlider(input)
    end

    local function stopDrag()
        dragging = false
        if inputConnection then
            inputConnection:Disconnect()
            inputConnection = nil
        end
    end

    hitArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)

    hitArea.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            stopDrag()
        end
    end)

    dot.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)

    dot.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            stopDrag()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded) and dragging then
            stopDrag()
        end
    end)
end

local function makeTextbox(page, label, desc, key, default)
    rowOrder += 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 60)
    row.BackgroundColor3 = BG2
    row.BorderSizePixel = 0
    row.LayoutOrder = rowOrder
    row.Parent = page
    corner(row, 10)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -24, 0, 18)
    t.Position = UDim2.fromOffset(12, 6)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamMedium
    t.TextSize = 13.5
    t.TextColor3 = TXT
    t.Text = label
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = row

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1, -24, 0, 13)
    d.Position = UDim2.fromOffset(12, 24)
    d.BackgroundTransparency = 1
    d.Font = Enum.Font.Gotham
    d.TextSize = 10.5
    d.TextColor3 = SUB
    d.Text = desc
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.Parent = row

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -24, 0, 24)
    box.Position = UDim2.fromOffset(12, 38)
    box.BackgroundColor3 = BG3
    box.TextColor3 = TXT
    box.Font = Enum.Font.GothamBold
    box.TextSize = 12
    box.Text = S[key] or default
    box.PlaceholderText = "Enter text..."
    box.PlaceholderColor3 = SUB
    box.Parent = row
    corner(box, 8)

    box.FocusLost:Connect(function(enterPressed)
        S[key] = box.Text
        if enterPressed then box.Text = S[key] end
    end)
end

local function sectionInfo(page, text)
    rowOrder += 1
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 0)
    l.AutomaticSize = Enum.AutomaticSize.Y
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 11.5
    l.TextColor3 = SUB
    l.TextWrapped = true
    l.RichText = true
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = text
    l.LayoutOrder = rowOrder
    l.Parent = page
end

--============================================================================
-- TABS
--============================================================================

local pPlayer = makeTab("Player", "🏃")
makeToggle(pPlayer, "God Mode", "Wall shield that pushes balls away", "godmode")
makeToggle(pPlayer, "Jump Power", "Super high jumps", "jumppower")
makeToggle(pPlayer, "Speed Boost", "Move faster than everyone", "speed")
makeToggle(pPlayer, "Noclip", "Walk through walls & obstacles", "noclip")
makeToggle(pPlayer, "AURA Title", "Floating text above your head", "aura")
makeTextbox(pPlayer, "AURA Text", "Customize your title text", "auraText", "John Doe")
makeSlider(pPlayer, "Jump Height", "Set custom jump power", "jumpVal", 50, 300, 100)
makeSlider(pPlayer, "Speed Value", "Set walk speed", "speedVal", 16, 200, 50)
makeToggle(pPlayer, "Reset", "Kill yourself to respawn", "reset", function(on)
    if on and lp.Character then
        lp.Character:BreakJoints()
        task.wait(0.1)
        S.reset = false
    end
end)

local pFarm = makeTab("Farm", "🤖")
makeToggle(pFarm, "Auto Farm (AFK)", "Hang safely behind random player", "autofarm")
makeToggle(pFarm, "Auto Skill", "Auto-use all inventory abilities", "autoskill")
makeSlider(pFarm, "Distance Behind", "How far behind player to hang", "tpY", 30, 200, 80)

local pBall = makeTab("Ball", "⚽")
makeToggle(pBall, "Freeze Time", "Slow down ALL balls (big zone)", "freezetime")
makeToggle(pBall, "Perfect Time", "Precision slow zone near you", "perfecttime")
makeToggle(pBall, "Perfect Ring", "Show flat circle range indicator", "perfectring")
makeToggle(pBall, "Ball Pet", "Balls get stuck in your shield", "ballpet")
makeToggle(pBall, "Delete Ball V2", "Mega-push balls at max speed", "deleteball")
makeSlider(pBall, "Freeze Strength", "How much to slow the ball (1-10)", "freezeStr", 1, 10, 2)
makeSlider(pBall, "Perfect Range", "Range of perfect time circle", "perfectRange", 5, 30, 10)
makeSlider(pBall, "Pet Range", "How close ball must be to get trapped", "petRange", 4, 20, 8)

local pVisuals = makeTab("Visuals", "👁️")
makeToggle(pVisuals, "ESP Players", "See players through walls", "esp")
makeToggle(pVisuals, "ESP Balls", "See balls through walls", "espballs")
makeToggle(pVisuals, "Hitbox Viewer", "See god mode & freeze zones", "hitboxview")
makeToggle(pVisuals, "Anti AFK", "Never get kicked for idling", "antiafk")

local stats = Instance.new("TextLabel")
stats.Size = UDim2.new(1, 0, 0, 0)
stats.AutomaticSize = Enum.AutomaticSize.Y
stats.BackgroundTransparency = 1
stats.Font = Enum.Font.Code
stats.TextSize = 12
stats.TextColor3 = ACCENT
stats.TextXAlignment = Enum.TextXAlignment.Left
stats.RichText = true
stats.LayoutOrder = 99
stats.Text = ""
stats.Parent = pVisuals
sectionInfo(pVisuals, "<font color='#8A8F9C'>RightCtrl hides the menu  •  drag the header to move</font>")

selectTab("Player")

--============================================================================
-- DRAGGING
--============================================================================
do
    local drag, sp, si
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            sp = main.Position
            si = i.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local dd = i.Position - si
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dd.X, sp.Y.Scale, sp.Y.Offset + dd.Y)
        end
    end)
end

local mini = false
minB.MouseButton1Click:Connect(function()
    mini = not mini
    TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = mini and UDim2.fromOffset(520, 56) or UDim2.fromOffset(520, 440)
    }):Play()
    body.Visible = not mini
end)

UserInputService.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.KeyCode == Enum.KeyCode.RightControl then
        main.Visible = not main.Visible
    end
end)

--============================================================================
-- ОПТИМИЗИРОВАННЫЕ ФУНКЦИИ
--============================================================================
local alive = true
local lastAutofarmPos = nil

-- КЭШИРОВАНИЕ ШАРОВ (обновляется раз в 0.2 сек, а не каждый кадр)
local cachedBalls = {}
local lastBallCache = 0

local function getBalls()
    if tick() - lastBallCache > 0.2 then
        cachedBalls = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj:GetAttribute("IsBall")) then
                table.insert(cachedBalls, obj)
            end
        end
        lastBallCache = tick()
    end
    return cachedBalls
end

local function findNearestBall(pos)
    local nearest = nil
    local minDist = math.huge
    for _, ball in ipairs(getBalls()) do
        if ball and ball.Parent then
            local dist = (ball.Position - pos).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = ball
            end
        end
    end
    return nearest, minDist
end

--============================================================================
-- GOD MODE (оптимизирован)
--============================================================================
local godPart
RunService.Heartbeat:Connect(function()
    if not S.godmode then
        if godPart then godPart:Destroy(); godPart = nil end
        return
    end

    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not godPart or not godPart.Parent then
        if godPart then godPart:Destroy() end
        godPart = Instance.new("Part")
        godPart.Name = "GodShield"
        godPart.Size = Vector3.new(10, 10, 10)
        godPart.Transparency = S.hitboxview and 0.6 or 1
        godPart.Color = Color3.fromRGB(255, 0, 0)
        godPart.Material = Enum.Material.ForceField
        godPart.CanCollide = false
        godPart.Anchored = true
        godPart.Parent = workspace
    end
    
    godPart.CFrame = root.CFrame
    godPart.Transparency = S.hitboxview and 0.6 or 1

    -- Используем кэшированные шары
    local balls = getBalls()
    for _, ball in ipairs(balls) do
        if ball and ball.Parent then
            local dist = (ball.Position - godPart.Position).Magnitude
            if dist < 8 then
                local dir = (ball.Position - godPart.Position).Unit
                if dir.Magnitude < 0.1 then dir = Vector3.new(0, 1, 0) end
                ball.Velocity = dir * 25
                ball.AssemblyLinearVelocity = dir * 25
            end
        end
    end
end)

--============================================================================
-- DELETE BALL V2 — отбрасывает шары на максимальной скорости
--============================================================================
local deletePart
RunService.Heartbeat:Connect(function()
    if not S.deleteball then
        if deletePart then deletePart:Destroy(); deletePart = nil end
        return
    end

    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not deletePart or not deletePart.Parent then
        if deletePart then deletePart:Destroy() end
        deletePart = Instance.new("Part")
        deletePart.Name = "DeleteShield"
        deletePart.Size = Vector3.new(12, 12, 12)
        deletePart.Transparency = S.hitboxview and 0.5 or 1
        deletePart.Color = Color3.fromRGB(255, 0, 0)
        deletePart.Material = Enum.Material.ForceField
        deletePart.CanCollide = false
        deletePart.Anchored = true
        deletePart.Parent = workspace
    end

    deletePart.CFrame = root.CFrame
    deletePart.Transparency = S.hitboxview and 0.5 or 1

    local balls = getBalls()
    for _, ball in ipairs(balls) do
        if ball and ball.Parent then
            local dist = (ball.Position - deletePart.Position).Magnitude
            if dist < 10 then
                local dir = (ball.Position - deletePart.Position).Unit
                if dir.Magnitude < 0.1 then dir = Vector3.new(math.random(-1, 1), 1, math.random(-1, 1)).Unit end
                local maxSpeed = 500 -- максимальная скорость отброса
                ball.Velocity = dir * maxSpeed
                ball.AssemblyLinearVelocity = dir * maxSpeed
            end
        end
    end
end)

--============================================================================
-- BALL PET (оптимизирован)
--============================================================================
local trappedBalls = {}
RunService.Heartbeat:Connect(function()
    if not S.ballpet then
        for ball, _ in pairs(trappedBalls) do
            if ball and ball.Parent then ball.Anchored = false end
        end
        table.clear(trappedBalls)
        return
    end

    local char = lp.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local balls = getBalls()
    for _, ball in ipairs(balls) do
        if ball and ball.Parent then
            local dist = (ball.Position - root.Position).Magnitude
            if dist < S.petRange then
                if not trappedBalls[ball] then trappedBalls[ball] = true end
                ball.Anchored = false
                ball.Velocity = Vector3.zero
                ball.AssemblyLinearVelocity = Vector3.zero
                local dir = (ball.Position - root.Position).Unit
                if dir.Magnitude < 0.1 then dir = Vector3.new(1, 0, 0) end
                ball.Position = root.Position + dir * S.petRange
            end
        end
    end
end)

--============================================================================
-- JUMP POWER & SPEED (оставлен в Heartbeat, лёгкий)
--============================================================================
RunService.Heartbeat:Connect(function()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if S.jumppower then hum.JumpPower = S.jumpVal end
    if S.speed then hum.WalkSpeed = S.speedVal end
end)

--============================================================================
-- NOCLIP
--============================================================================
RunService.Stepped:Connect(function()
    if not S.noclip then return end
    local char = lp.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

--============================================================================
-- AUTO FARM
--============================================================================
RunService.Heartbeat:Connect(function()
    if not S.autofarm then
        if lastAutofarmPos then
            local char = lp.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local nearestBall = findNearestBall(root.Position)
                    if nearestBall then
                        root.CFrame = CFrame.new(nearestBall.Position + Vector3.new(0, 15, 0))
                        root.Velocity = Vector3.zero
                    end
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then hum.PlatformStand = false end
                end
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

--============================================================================
-- FREEZE TIME (оптимизирован — задержка увеличена)
--============================================================================
local freezePart
task.spawn(function()
    while alive do
        if S.freezetime then
            if not freezePart or not freezePart.Parent then
                freezePart = Instance.new("Part")
                freezePart.Name = "FreezeZone"
                freezePart.Size = Vector3.new(300, 300, 300)
                freezePart.Transparency = S.hitboxview and 0.6 or 1
                freezePart.Color = Color3.fromRGB(0, 150, 255)
                freezePart.Anchored = true
                freezePart.CanCollide = false
                freezePart.Parent = workspace
            end
            freezePart.CFrame = CFrame.new(0, 150, 0)
            freezePart.Transparency = S.hitboxview and 0.6 or 1

            local slow = 1 - (S.freezeStr / 10)
            local balls = getBalls()
            for _, ball in ipairs(balls) do
                if ball and ball.Parent then
                    ball.Velocity *= slow
                    ball.AssemblyLinearVelocity *= slow
                end
            end
        else
            if freezePart then freezePart:Destroy(); freezePart = nil end
        end
        task.wait(0.1) -- увеличено с 0 до 0.1 сек
    end
end)

--============================================================================
-- PERFECT TIME (оптимизирован)
--============================================================================
local perfectPart, perfectRing
task.spawn(function()
    while alive do
        if S.perfecttime then
            local char = lp.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    if not perfectPart or not perfectPart.Parent then
                        perfectPart = Instance.new("Part")
                        perfectPart.Name = "PerfectZone"
                        perfectPart.Anchored = true
                        perfectPart.CanCollide = false
                        perfectPart.Parent = workspace
                    end
                    perfectPart.Size = Vector3.new(S.perfectRange * 2, S.perfectRange * 2, S.perfectRange * 2)
                    perfectPart.CFrame = root.CFrame
                    perfectPart.Transparency = S.hitboxview and 0.7 or 1
                    perfectPart.Color = Color3.fromRGB(255, 200, 0)

                    if S.perfectring then
                        if not perfectRing or not perfectRing.Parent then
                            if perfectRing then perfectRing:Destroy() end
                            perfectRing = Instance.new("Part")
                            perfectRing.Name = "PerfectRing"
                            perfectRing.Shape = Enum.PartType.Cylinder
                            perfectRing.Anchored = true
                            perfectRing.CanCollide = false
                            perfectRing.Material = Enum.Material.Neon
                            perfectRing.Parent = workspace
                        end
                        perfectRing.Size = Vector3.new(S.perfectRange * 2, 0.3, S.perfectRange * 2)
                        perfectRing.CFrame = CFrame.new(root.Position)
                        perfectRing.Transparency = S.hitboxview and 0.6 or 1
                        perfectRing.Color = Color3.fromRGB(255, 200, 0)
                    else
                        if perfectRing then perfectRing:Destroy(); perfectRing = nil end
                    end

                    local balls = getBalls()
                    for _, ball in ipairs(balls) do
                        if ball and ball.Parent then
                            if (ball.Position - root.Position).Magnitude < S.perfectRange then
                                ball.Velocity *= 0.01
                                ball.AssemblyLinearVelocity *= 0.01
                            end
                        end
                    end
                end
            end
        else
            if perfectPart then perfectPart:Destroy(); perfectPart = nil end
            if perfectRing then perfectRing:Destroy(); perfectRing = nil end
        end
        task.wait(0.1) -- увеличено
    end
end)

--============================================================================
-- AUTO SKILL
--============================================================================
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

--============================================================================
-- AURA TITLE
--============================================================================
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
                        auraText.TextColor3 = Color3.fromRGB(255, 0, 0)
                        auraText.Size = UDim2.new(1, 0, 1, 0)

                        local stroke1 = Instance.new("UIStroke", auraText)
                        stroke1.Color = Color3.new(0, 0, 0)
                        stroke1.Thickness = 3

                        local stroke2 = Instance.new("UIStroke", auraText)
                        stroke2.Color = Color3.fromRGB(255, 255, 255)
                        stroke2.Thickness = 1

                        auraText.Parent = auraBillboard
                    end

                    if math.random(0, 100) < 10 then
                        local texts = {"NOHOPE", "GIVEUP", "BURNINHELL"}
                        auraText.Text = texts[math.random(1, 3)]
                    else
                        auraText.Text = S.auraText
                    end

                    auraText.Position = UDim2.new(0, math.random(-3, 3), 0, math.random(-3, 3))
                end
            end
        else
            if auraBillboard then
                auraBillboard:Destroy()
                auraBillboard = nil
                auraText = nil
            end
        end
        task.wait(0.05)
    end
end)

--============================================================================
-- ESP
--============================================================================
local espObjects = {}
task.spawn(function()
    while alive do
        if S.esp then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    local hum = player.Character:FindFirstChild("Humanoid")
                    if head and hum and hum.Health > 0 then
                        if not espObjects[player] then
                            local h = Instance.new("Highlight")
                            h.FillColor = Color3.fromRGB(255, 80, 80)
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

        if S.espballs then
            local balls = getBalls()
            for _, ball in ipairs(balls) do
                if ball and ball.Parent and not ball:FindFirstChild("BallESP") then
                    local h = Instance.new("Highlight")
                    h.Name = "BallESP"
                    h.FillColor = Color3.fromRGB(255, 255, 0)
                    h.OutlineColor = Color3.fromRGB(255, 0, 0)
                    h.FillTransparency = 0.5
                    h.Parent = ball
                end
            end
        else
            local balls = getBalls()
            for _, ball in ipairs(balls) do
                local esp = ball and ball:FindFirstChild("BallESP")
                if esp then esp:Destroy() end
            end
        end

        task.wait(0.5)
    end
end)

--============================================================================
-- ANTI AFK
--============================================================================
lp.Idled:Connect(function()
    if S.antiafk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

--============================================================================
-- STATS
--============================================================================
task.spawn(function()
    while alive do
        local char = lp.Character
        local hp = "?"
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hp = math.floor(hum.Health) end
        end
        local tc = 0
        for _ in pairs(trappedBalls) do tc += 1 end
        stats.Text = string.format("HP: %s | Balls: %d | Trapped: %d\nGod: %s | Freeze: %s | Pet: %s | Delete: %s",
            hp, #getBalls(), tc,
            S.godmode and "✅" or "❌",
            S.freezetime and "✅" or "❌",
            S.ballpet and "✅" or "❌",
            S.deleteball and "✅" or "❌")
        task.wait(0.5)
    end
end)

--============================================================================
-- CLOSE & DESTROY
--============================================================================
closeB.MouseButton1Click:Connect(function()
    if _G.DodgeHub then _G.DodgeHub.Destroy() end
end)

_G.DodgeHub = {
    Destroy = function()
        alive = false
        for k in pairs(S) do if type(S[k]) == "boolean" then S[k] = false end end
        if gui then gui:Destroy() end
        if godPart then godPart:Destroy() end
        if deletePart then deletePart:Destroy() end
        if freezePart then freezePart:Destroy() end
        if perfectPart then perfectPart:Destroy() end
        if perfectRing then perfectRing:Destroy() end
        if auraBillboard then auraBillboard:Destroy() end
        for _, v in pairs(espObjects) do pcall(function() v:Destroy() end) end
        for ball in pairs(trappedBalls) do if ball and ball.Parent then ball.Anchored = false end end
        table.clear(espObjects)
        table.clear(trappedBalls)
        _G.DodgeHub = nil
    end
}

print("[🏃 Dodge Hub v5.3] Loaded — v5.2 + Smooth Auto Farm + Delete Ball V2. RightCtrl hides.")
