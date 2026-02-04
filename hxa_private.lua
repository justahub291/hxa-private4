--// ===================== HXA HUB - FINAL =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

--// ===================== SAFE LOAD =====================
getgenv().HXA_BLACKLIST = getgenv().HXA_BLACKLIST or {}
local function safeLoad(id, url)
	if getgenv().HXA_BLACKLIST[id] then return end
	getgenv().HXA_BLACKLIST[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// ===================== GUI ROOT =====================
local gui = Instance.new("ScreenGui")
gui.Name = "HXA_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// ===================== MODE CHOICE =====================
local modeFrame = Instance.new("Frame", gui)
modeFrame.Size = UDim2.new(0,300,0,160)
modeFrame.Position = UDim2.new(0.5,-150,0.5,-80)
modeFrame.BackgroundColor3 = Color3.fromRGB(20,15,40)
modeFrame.BorderSizePixel = 0
Instance.new("UICorner", modeFrame).CornerRadius = UDim.new(0,24)

local title = Instance.new("TextLabel", modeFrame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "HXA HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(220,200,255)

local function choiceButton(text, pos, callback)
	local b = Instance.new("TextButton", modeFrame)
	b.Size = UDim2.new(0.8,0,0,42)
	b.Position = pos
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,55,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,20)
	b.MouseButton1Click:Connect(callback)
end

choiceButton("🖥️ PC VERSION", UDim2.new(0.1,0,0.45,0), function()
	getgenv().HXA_MODE = "PC"
	modeFrame:Destroy()
end)

choiceButton("📱 MOBILE VERSION", UDim2.new(0.1,0,0.72,0), function()
	getgenv().HXA_MODE = "MOBILE"
	modeFrame:Destroy()
end)

repeat task.wait() until getgenv().HXA_MODE

--// ===================== MAIN FRAME =====================
local main = Instance.new("Frame", gui)
main.BackgroundColor3 = Color3.fromRGB(15,10,35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,28)

if getgenv().HXA_MODE == "PC" then
	main.Size = UDim2.new(0,420,0,420)
else
	main.Size = UDim2.new(0,260,0,360) -- ULTRA MINI MOBILE
end

main.Position = UDim2.new(0.5,-main.Size.X.Offset/2,0.5,-main.Size.Y.Offset/2)

--// ===================== TITLE =====================
local top = Instance.new("TextLabel", main)
top.Size = UDim2.new(1,0,0,50)
top.BackgroundTransparency = 1
top.Text = "HXA"
top.Font = Enum.Font.GothamBlack
top.TextSize = 26
top.TextColor3 = Color3.fromRGB(215,195,255)

--// ===================== SCROLL =====================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-70)
scroll.Position = UDim2.new(0,10,0,60)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// ===================== BUTTON CREATOR =====================
local function createButton(text, callback)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1,0,0,42)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(95,60,180)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,20)
	b.MouseButton1Click:Connect(callback)
end

--// ===================== BUTTONS =====================
createButton("🚀 TP BLOCK", function()
	safeLoad("tpblock","https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp")
end)

createButton("🌶️ Chilli Hub", function()
	safeLoad("chilli","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
end)

createButton("🌀 Nameless Hub", function()
	safeLoad("nameless","https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
end)

createButton("✨ Illusion Hub", function()
	safeLoad("illusion","https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1")
end)

createButton("🧿 Miranda Hub", function()
	safeLoad("miranda","https://pastefy.app/JJVhs3rK/raw")
end)

createButton("🟢 Kurd Hub", function()
	safeLoad("kurd","https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub")
end)

createButton("⚡ Semi Instant Steal", function()
	safeLoad("semiinsta","https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/refs/heads/main/Artfull")
end)

createButton("🧬 DESYNC", function()
	safeLoad("desync","https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw/e07bf6acc7f5e411e98f40f49c947bc5aaea9dbb/CorruptedDesync")
end)

createButton("❌ Close", function()
	main.Visible = false
	reopen.Visible = true
end)

--// ===================== REOPEN BUTTON =====================
reopen = Instance.new("TextButton", gui)
reopen.Size = UDim2.new(0,52,0,52)
reopen.Position = UDim2.new(1,-70,0,20)
reopen.Text = "HXA"
reopen.Font = Enum.Font.GothamBlack
reopen.TextSize = 16
reopen.TextColor3 = Color3.new(1,1,1)
reopen.BackgroundColor3 = Color3.fromRGB(95,60,180)
reopen.BorderSizePixel = 0
reopen.Visible = false
reopen.Active = true
reopen.Draggable = true
Instance.new("UICorner", reopen).CornerRadius = UDim.new(1,0)

reopen.MouseButton1Click:Connect(function()
	main.Visible = true
	reopen.Visible = false
end)
