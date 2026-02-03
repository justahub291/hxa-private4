--// ===================== HXA PRIVATE HUB - FINAL =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// ===================== OWNER / WHITELIST =====================
local OWNER_ID = 10440238844
local Whitelist = {
	[OWNER_ID] = true,
	[8761695710] = true,
	[9907212367] = true,
}

if not Whitelist[player.UserId] then
	player:Kick("❌ Accès refusé (non whitelist)")
	return
end

--// ===================== BLACKLIST =====================
getgenv().HXA_BLACKLIST = getgenv().HXA_BLACKLIST or {}
local function safeLoad(id, url)
	if getgenv().HXA_BLACKLIST[id] then return end
	getgenv().HXA_BLACKLIST[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// ===================== GUI ROOT =====================
local gui = Instance.new("ScreenGui")
gui.Name = "HXAPRIVATE"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// ===================== VERSION CHOOSER =====================
local chooser = Instance.new("Frame", gui)
chooser.Size = UDim2.new(0,260,0,160)
chooser.Position = UDim2.new(0.5,-130,0.5,-80)
chooser.BackgroundColor3 = Color3.fromRGB(20,15,40)
chooser.BorderSizePixel = 0
Instance.new("UICorner", chooser).CornerRadius = UDim.new(0,20)

local titleC = Instance.new("TextLabel", chooser)
titleC.Size = UDim2.new(1,0,0,45)
titleC.BackgroundTransparency = 1
titleC.Text = "Choisir la version"
titleC.Font = Enum.Font.GothamBlack
titleC.TextSize = 20
titleC.TextColor3 = Color3.fromRGB(220,200,255)

local isMobile = false

local function choice(txt, y, cb)
	local b = Instance.new("TextButton", chooser)
	b.Size = UDim2.new(0.85,0,0,38)
	b.Position = UDim2.new(0.075,0,y,0)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,55,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,16)
	b.MouseButton1Click:Connect(cb)
end

choice("🖥️ Version PC", 0.38, function()
	isMobile = false
	chooser:Destroy()
end)

choice("📱 Version Mobile", 0.65, function()
	isMobile = true
	chooser:Destroy()
end)

repeat task.wait() until chooser.Parent == nil

--// ===================== MAIN FRAME =====================
local mainSize = isMobile and UDim2.new(0,260,0,280) or UDim2.new(0,420,0,400)

local main = Instance.new("Frame", gui)
main.Size = mainSize
main.Position = UDim2.new(0.5,-mainSize.X.Offset/2,0.5,-mainSize.Y.Offset/2)
main.BackgroundColor3 = Color3.fromRGB(14,10,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,26)

main.Size = UDim2.new(0,0,0,0)
TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Size = mainSize}):Play()

--// ===================== TITLE =====================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,42)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE"
title.Font = Enum.Font.GothamBlack
title.TextSize = isMobile and 18 or 28
title.TextColor3 = Color3.fromRGB(215,195,255)

--// ===================== SCROLL =====================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-16,1,-58)
scroll.Position = UDim2.new(0,8,0,50)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = isMobile and UDim.new(0,6) or UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// ===================== BUTTON CREATOR =====================
local function createButton(text, callback)
	local b = Instance.new("TextButton", scroll)
	b.Size = isMobile and UDim2.new(0.96,0,0,34) or UDim2.new(0.9,0,0,45)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = isMobile and 13 or 15
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(85,45,170)
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

createButton("🔒 Auto Block After Steal", function()
	safeLoad("autoblock","https://api.luarmor.net/files/v3/loaders/e51d9174e080752c62ce754bb72ad183.lua")
end)

createButton("🤪 Silly Booster", function()
	safeLoad("silly","https://pastebin.com/raw/GEnDVifW")
end)

createButton("⚡ AP Spammer", function()
	safeLoad("ap","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
end)

createButton("☀️ Sun Hub", function()
	safeLoad("sun","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
end)

if player.UserId == OWNER_ID then
	createButton("♻️ Reload Hub (Owner)", function()
		getgenv().HXA_LOADED = false
		gui:Destroy()
	end)
end

--// ===================== REOPEN BUTTON =====================
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0,56,0,56)
reopenBtn.Position = UDim2.new(1,-70,0,20)
reopenBtn.Text = "HXA"
reopenBtn.Font = Enum.Font.GothamBlack
reopenBtn.TextSize = 16
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

createButton("❌ Close", function()
	main.Visible = false
	reopenBtn.Visible = true
end)

