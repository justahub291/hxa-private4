--// HXA PRIVATE HUB - FULL ALL-IN-ONE (Xeno)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local tpExecuted = false
local hubVisible = true

-- ======================
-- GUI
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "HXAPRIVATE"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ======================
-- 🌠 STARS BACKGROUND
-- ======================
local starsFolder = Instance.new("Folder", gui)
local stars = {}

for i = 1,140 do
    local star = Instance.new("Frame")
    local size = math.random(1,2)
    star.Size = UDim2.new(0,size,0,size)
    star.Position = UDim2.new(math.random(),0,math.random(),0)
    star.BackgroundColor3 = Color3.fromRGB(230,230,255)
    star.BackgroundTransparency = math.random(3,6)/10
    star.BorderSizePixel = 0
    star.Parent = starsFolder
    stars[star] = math.random(6,20)/1000
end

RunService.RenderStepped:Connect(function()
    for star,speed in pairs(stars) do
        local y = star.Position.Y.Scale + speed
        if y > 1.05 then
            star.Position = UDim2.new(math.random(),0,-0.05,0)
        else
            star.Position = UDim2.new(star.Position.X.Scale,0,y,0)
        end
    end
end)

-- ======================
-- 🔔 CUSTOM NOTIFICATION
-- ======================
local function notify(title, text)
    local notif = Instance.new("Frame", gui)
    notif.Size = UDim2.new(0,260,0,70)
    notif.Position = UDim2.new(1,-280,1,100)
    notif.BackgroundColor3 = Color3.fromRGB(30,20,60)
    notif.BorderSizePixel = 0
    notif.AnchorPoint = Vector2.new(0,1)

    Instance.new("UICorner", notif).CornerRadius = UDim.new(0,18)
    local stroke = Instance.new("UIStroke", notif)
    stroke.Color = Color3.fromRGB(140,90,255)
    stroke.Transparency = 0.2

    local t = Instance.new("TextLabel", notif)
    t.Size = UDim2.new(1,-20,0,30)
    t.Position = UDim2.new(0,10,0,5)
    t.BackgroundTransparency = 1
    t.Text = title
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextColor3 = Color3.fromRGB(220,200,255)
    t.TextXAlignment = Enum.TextXAlignment.Left

    local d = Instance.new("TextLabel", notif)
    d.Size = UDim2.new(1,-20,0,25)
    d.Position = UDim2.new(0,10,0,35)
    d.BackgroundTransparency = 1
    d.Text = text
    d.Font = Enum.Font.Gotham
    d.TextSize = 14
    d.TextColor3 = Color3.fromRGB(200,200,220)
    d.TextXAlignment = Enum.TextXAlignment.Left

    notif:TweenPosition(
        UDim2.new(1,-280,1,-20),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.4,
        true
    )

    task.delay(3,function()
        notif:TweenPosition(
            UDim2.new(1,-280,1,100),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quart,
            0.4,
            true
        )
        task.delay(0.5,function()
            notif:Destroy()
        end)
    end)
end

-- ======================
-- 🌌 MAIN FRAME
-- ======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,400)
main.Position = UDim2.new(0.5,-210,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(14,10,30)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,30)

-- ======================
-- 🔝 TOP BAR (DRAG)
-- ======================
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,60)
top.BackgroundTransparency = 1
top.Active = true

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE"
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(215,195,255)

local dragging, dragStart, startPos
top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
top.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ======================
-- 🔍 SEARCH BAR
-- ======================
local searchBox = Instance.new("TextBox", main)
searchBox.Size = UDim2.new(1,-40,0,36)
searchBox.Position = UDim2.new(0,20,0,70)
searchBox.PlaceholderText = "Search..."
searchBox.ClearTextOnFocus = false
searchBox.Text = ""
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.TextColor3 = Color3.new(1,1,1)
searchBox.PlaceholderColor3 = Color3.fromRGB(170,170,190)
searchBox.BackgroundColor3 = Color3.fromRGB(25,18,50)
searchBox.BorderSizePixel = 0
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,14)

-- ======================
-- 📜 SCROLL
-- ======================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-140)
scroll.Position = UDim2.new(0,10,0,115)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ======================
-- 🔘 BUTTON CREATOR
-- ======================
local function createButton(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9,0,0,48)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(85,45,170)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,24)
    b.Parent = scroll
    b.MouseButton1Click:Connect(callback)
end

-- ======================
-- 🔎 SEARCH LOGIC
-- ======================
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(searchBox.Text)
    for _,c in ipairs(scroll:GetChildren()) do
        if c:IsA("TextButton") then
            c.Visible = q == "" or string.find(string.lower(c.Text), q)
        end
    end
end)

-- ======================
-- 🔘 BUTTONS
-- ======================
createButton("🚀 TP BLOCK", function()
    if tpExecuted then return end
    tpExecuted = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp",true))()
    notify("TP Block","Loaded ✔")
end)

createButton("🌶️ Chilli Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",true))()
    notify("Chilli Hub","Loaded ✔")
end)

createButton("🌀 Nameless Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr",true))()
    notify("Nameless Hub","Loaded ✔")
end)

createButton("✨ Illusion Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1",true))()
    notify("Illusion Hub","Loaded ✔")
end)

createButton("🧿 Miranda Hub", function()
    loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw",true))()
    notify("Miranda Hub","Loaded ✔")
end)

createButton("🟢 Kurd Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub",true))()
    notify("Kurd Hub","Loaded ✔")
end)

createButton("🔒 Auto Block After Steal", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e51d9174e080752c62ce754bb72ad183.lua",true))()
    notify("Auto Block","Loaded ✔")
end)

createButton("🤪 Silly Booster", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GEnDVifW",true))()
    notify("Silly Booster","Loaded ✔")
end)

createButton("⚡ AP Spammer", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua",true))()
    notify("AP Spammer","Loaded ✔")
end)

createButton("🔓 Allow / Disallow", function()
    loadstring(game:HttpGet("https://pastefy.app/wcNjuW3Z/raw",true))()
    notify("Allow / Disallow","Loaded ✔")
end)

-- ======================
-- 🔵 FLOATING HXA BUTTON
-- ======================
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0,60,0,60)
reopenBtn.Position = UDim2.new(1,-80,0,20)
reopenBtn.Text = "HXA"
reopenBtn.Font = Enum.Font.GothamBlack
reopenBtn.TextSize = 18
reopenBtn.TextColor3 = Color3.fromRGB(230,200,255)
reopenBtn.BackgroundColor3 = Color3.fromRGB(90,55,170)
reopenBtn.BorderSizePixel = 0
reopenBtn.Visible = false
reopenBtn.Active = true
reopenBtn.Draggable = true
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(1,0)

reopenBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    reopenBtn.Visible = false
end)

-- ======================
-- ❌ CLOSE
-- ======================
createButton("❌ Close", function()
    main.Visible = false
    reopenBtn.Visible = true
end)

-- ======================
-- ⌨️ KEYBIND ALT
-- ======================
UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.LeftAlt or i.KeyCode == Enum.KeyCode.RightAlt then
        hubVisible = not hubVisible
        main.Visible = hubVisible
        reopenBtn.Visible = not hubVisible
    end
end)

-- ======================
-- 🎬 OPEN ANIMATION
-- ======================
main.Size = UDim2.new(0,0,0,0)
main:TweenSize(
    UDim2.new(0,420,0,400),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Back,
    0.6,
    true
)
