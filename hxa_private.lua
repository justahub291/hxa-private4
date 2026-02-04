--// HXA PRIVATE HUB - FULL ALL-IN-ONE (NO WHITELIST)

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
-- 🔔 NOTIFICATION
-- ======================
local function notify(title,text)
    local f = Instance.new("Frame",gui)
    f.Size = UDim2.new(0,260,0,70)
    f.Position = UDim2.new(1,-280,1,100)
    f.AnchorPoint = Vector2.new(0,1)
    f.BackgroundColor3 = Color3.fromRGB(30,20,60)
    f.BorderSizePixel = 0
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,18)

    local t = Instance.new("TextLabel",f)
    t.Size = UDim2.new(1,-20,0,30)
    t.Position = UDim2.new(0,10,0,5)
    t.BackgroundTransparency = 1
    t.Text = title
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextColor3 = Color3.fromRGB(220,200,255)
    t.TextXAlignment = Enum.TextXAlignment.Left

    local d = Instance.new("TextLabel",f)
    d.Size = UDim2.new(1,-20,0,25)
    d.Position = UDim2.new(0,10,0,35)
    d.BackgroundTransparency = 1
    d.Text = text
    d.Font = Enum.Font.Gotham
    d.TextSize = 14
    d.TextColor3 = Color3.fromRGB(200,200,220)
    d.TextXAlignment = Enum.TextXAlignment.Left

    f:TweenPosition(UDim2.new(1,-280,1,-20),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.4,true)
    task.delay(3,function()
        f:TweenPosition(UDim2.new(1,-280,1,100),Enum.EasingDirection.In,Enum.EasingStyle.Quart,0.4,true)
        task.delay(0.5,function() f:Destroy() end)
    end)
end

-- ======================
-- 🌌 MAIN
-- ======================
local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,420,0,400)
main.Position = UDim2.new(0.5,-210,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(14,10,30)
main.BorderSizePixel = 0
Instance.new("UICorner",main).CornerRadius = UDim.new(0,30)

-- ======================
-- TOP BAR DRAG
-- ======================
local top = Instance.new("Frame",main)
top.Size = UDim2.new(1,0,0,60)
top.BackgroundTransparency = 1
top.Active = true

local title = Instance.new("TextLabel",top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE"
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(215,195,255)

local drag,ds,sp
top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag=true ds=i.Position sp=main.Position
    end
end)
top.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UIS.InputChanged:Connect(function(i)
    if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
        local d=i.Position-ds
        main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)

-- ======================
-- SEARCH BAR
-- ======================
local search = Instance.new("TextBox",main)
search.Size = UDim2.new(1,-40,0,36)
search.Position = UDim2.new(0,20,0,70)
search.PlaceholderText="Search..."
search.ClearTextOnFocus=false
search.Font=Enum.Font.Gotham
search.TextSize=14
search.TextColor3=Color3.new(1,1,1)
search.BackgroundColor3=Color3.fromRGB(25,18,50)
search.BorderSizePixel=0
Instance.new("UICorner",search).CornerRadius=UDim.new(0,14)

-- ======================
-- SCROLL
-- ======================
local scroll = Instance.new("ScrollingFrame",main)
scroll.Size=UDim2.new(1,-20,1,-140)
scroll.Position=UDim2.new(0,10,0,115)
scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
scroll.ScrollBarThickness=6
scroll.BackgroundTransparency=1

local layout=Instance.new("UIListLayout",scroll)
layout.Padding=UDim.new(0,12)
layout.HorizontalAlignment=Enum.HorizontalAlignment.Center

local function btn(txt,cb)
    local b=Instance.new("TextButton",scroll)
    b.Size=UDim2.new(0.9,0,0,48)
    b.Text=txt
    b.Font=Enum.Font.GothamBold
    b.TextSize=16
    b.TextColor3=Color3.new(1,1,1)
    b.BackgroundColor3=Color3.fromRGB(85,45,170)
    b.BorderSizePixel=0
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,24)
    b.MouseButton1Click:Connect(cb)
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=string.lower(search.Text)
    for _,c in ipairs(scroll:GetChildren()) do
        if c:IsA("TextButton") then
            c.Visible=q=="" or string.find(string.lower(c.Text),q)
        end
    end
end)

-- ======================
-- BUTTONS (NO WHITELIST)
-- ======================
btn("🚀 TP BLOCK",function()
    if tpExecuted then return end
    tpExecuted=true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp"))()
    notify("TP Block","Loaded ✔")
end)

btn("🌶️ Chilli Hub",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    notify("Chilli Hub","Loaded ✔")
end)

btn("🌀 Nameless Hub",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))()
    notify("Nameless Hub","Loaded ✔")
end)

btn("✨ Illusion Hub",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1"))()
    notify("Illusion Hub","Loaded ✔")
end)

btn("🧿 Miranda Hub",function()
    loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw"))()
    notify("Miranda Hub","Loaded ✔")
end)

btn("🟢 Kurd Hub",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub"))()
    notify("Kurd Hub","Loaded ✔")
end)

btn("☀️ Sun Hub",function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua"))()
    notify("Sun Hub","Loaded ✔")
end)

btn("❌ Close",function()
    main.Visible=false
    reopen.Visible=true
end)

-- ======================
-- FLOAT BUTTON
-- ======================
reopen=Instance.new("TextButton",gui)
reopen.Size=UDim2.new(0,60,0,60)
reopen.Position=UDim2.new(1,-80,0,20)
reopen.Text="HXA"
reopen.Font=Enum.Font.GothamBlack
reopen.TextSize=18
reopen.TextColor3=Color3.fromRGB(230,200,255)
reopen.BackgroundColor3=Color3.fromRGB(90,55,170)
reopen.BorderSizePixel=0
reopen.Visible=false
reopen.Draggable=true
Instance.new("UICorner",reopen).CornerRadius=UDim.new(1,0)

reopen.MouseButton1Click:Connect(function()
    main.Visible=true
    reopen.Visible=false
end)

UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode==Enum.KeyCode.LeftAlt or i.KeyCode==Enum.KeyCode.RightAlt then
        hubVisible=not hubVisible
        main.Visible=hubVisible
        reopen.Visible=not hubVisible
    end
end)

main.Size=UDim2.new(0,0,0,0)
main:TweenSize(UDim2.new(0,420,0,400),Enum.EasingDirection.Out,Enum.EasingStyle.Back,0.6,true)
