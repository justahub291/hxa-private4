--// ===================== HXA PRIVATE HUB - ULTRA MINI MOBILE =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
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
chooser.Size = UDim2.new(0,240,0,140)
chooser.Position = UDim2.new(0.5,-120,0.5,-70)
chooser.BackgroundColor3 = Color3.fromRGB(18,14,35)
chooser.BorderSizePixel = 0
Instance.new("UICorner", chooser).CornerRadius = UDim.new(0,18)

local ct = Instance.new("TextLabel", chooser)
ct.Size = UDim2.new(1,0,0,40)
ct.BackgroundTransparency = 1
ct.Text = "Choisir version"
ct.Font = Enum.Font.GothamBlack
ct.TextSize = 18
ct.TextColor3 = Color3.fromRGB(220,200,255)

local isMobile = false

local function choose(txt, y, cb)
	local b = Instance.new("TextButton", chooser)
	b.Size = UDim2.new(0.88,0,0,32)
	b.Position = UDim2.new(0.06,0,y,0)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,55,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
	b.MouseButton1Click:Connect(cb)
end

choose("🖥️ PC", 0.42, function()
	isMobile = false
	chooser:Destroy()
end)

choose("📱 Mobile", 0.68, function()
	isMobile = true
	chooser:Destroy()
end)

repeat task.wait() until not chooser.Parent

--// ===================== MAIN FRAME =====================
local mainSize =
	isMobile and UDim2.new(0,220,0,235)
	or UDim2.new(0,420,0,400)

local main = Instance.new("Frame", gui)
main.Size = mainSize
main.Position = UDim2.new(0.5,-mainSize.X.Offset/2,0.5,-mainSize.Y.Offset/2)
main.BackgroundColor3 = Color3.fromRGB(12,9,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,22)

main.Size = UDim2.new(0,0,0,0)
TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = mainSize}):Play()

--// ===================== TITLE =====================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,34)
title.BackgroundTransparency = 1
title.Text = "HXA"
title.Font = Enum.Font.GothamBlack
title.TextSize = isMobile and 15 or 28
title.TextColor3 = Color3.fromRGB(215,195,255)

--// ===================== SCROLL =====================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-12,1,-46)
scroll.Position = UDim2.new(0,6,0,38)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 3
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = isMobile and UDim.new(0,4) or UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// ===================== BUTTON CREATOR =====================
local function createButton(text, callback)
	local b = Instance.new("TextButton", scroll)
	b.Size =
		isMobile and UDim2.new(0.98,0,0,28)
		or UDim2.new(0.9,0,0,45)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = isMobile and 11 or 15
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(85,45,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,16)
	b.MouseButton1Click:Connect(callback)
end

--// ===================== BUTTONS =====================
createButton("🚀 TP BLOCK", function()
	safeLoad("tpblock","https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp")
end)

createButton("🌶️ Chilli", function()
	safeLoad("chilli","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
end)

createButton("🌀 Nameless", function()
	safeLoad("nameless","https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
end)

createButton("✨ Illusion", function()
	safeLoad("illusion","https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1")
end)

createButton("🧿 Miranda", function()
	safeLoad("miranda","https://pastefy.app/JJVhs3rK/raw")
end)

createButton("🟢 Kurd", function()
	safeLoad("kurd","https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub")
end)

createButton("🔒 Auto Block", function()
	safeLoad("autoblock","https://api.luarmor.net/files/v3/loaders/e51d9174e080752c62ce754bb72ad183.lua")
end)

createButton("🤪 Silly", function()
	safeLoad("silly","https://pastebin.com/raw/GEnDVifW")
end)

createButton("⚡ AP Spam", function()
	safeLoad("ap","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
end)

createButton("☀️ Sun Hub", function()
	safeLoad("sun","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
end)

if player.UserId == OWNER_ID then
	createButton("♻️ Reload", function()
		getgenv().HXA_LOADED = false
		gui:Destroy()
	end)
end

--// ===================== REOPEN BUTTON =====================
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0,48,0,48)
reopenBtn.Position = UDim2.new(1,-60,0,16)
reopenBtn.Text = "HXA"
reopenBtn.Font = Enum.Font.GothamBlack
reopenBtn.TextSize = 14
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


