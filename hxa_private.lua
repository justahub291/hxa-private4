--// ===================== HXA PRIVATE HUB - FINAL =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

--// ===================== WHITELIST =====================
local OWNER_ID = 10440238844
local Whitelist = {
	[OWNER_ID] = true,
	[8761695710] = true,
	[9907212367] = true,
}

if not Whitelist[player.UserId] then
	player:Kick("❌ Accès refusé")
	return
end

--// ===================== SAFE LOAD =====================
getgenv().HXA_BLACKLIST = getgenv().HXA_BLACKLIST or {}
local function safeLoad(id, url)
	if getgenv().HXA_BLACKLIST[id] then return end
	getgenv().HXA_BLACKLIST[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// ===================== GUI ROOT =====================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HXAPRIVATE"
gui.ResetOnSpawn = false

--// ===================== VERSION CHOOSER =====================
local chooser = Instance.new("Frame", gui)
chooser.Size = UDim2.fromScale(0.45,0.32)
chooser.Position = UDim2.fromScale(0.275,0.34)
chooser.BackgroundColor3 = Color3.fromRGB(18,14,35)
chooser.BorderSizePixel = 0
Instance.new("UICorner", chooser).CornerRadius = UDim.new(0,22)

local ct = Instance.new("TextLabel", chooser)
ct.Size = UDim2.new(1,0,0.3,0)
ct.BackgroundTransparency = 1
ct.Text = "Choisir version"
ct.Font = Enum.Font.GothamBlack
ct.TextScaled = true
ct.TextColor3 = Color3.fromRGB(220,200,255)

local isMobile = false
local function choice(txt,y,cb)
	local b = Instance.new("TextButton", chooser)
	b.Size = UDim2.new(0.85,0,0.28,0)
	b.Position = UDim2.new(0.075,0,y,0)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,55,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,16)
	b.MouseButton1Click:Connect(cb)
end

choice("🖥️ PC",0.38,function()
	isMobile = false
	chooser:Destroy()
end)

choice("📱 Mobile",0.68,function()
	isMobile = true
	chooser:Destroy()
end)

repeat task.wait() until not chooser.Parent

--// ===================== MAIN HUB =====================
local main = Instance.new("Frame", gui)

if isMobile then
	main.Size = UDim2.fromScale(0.36,0.72)
	main.Position = UDim2.fromScale(0.32,0.14)
else
	main.Size = UDim2.new(0,420,0,400)
	main.Position = UDim2.new(0.5,-210,0.5,-200)
end

main.BackgroundColor3 = Color3.fromRGB(18,14,35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = not isMobile
Instance.new("UICorner", main).CornerRadius = UDim.new(0,32)

-- open animation
local endSize = main.Size
main.Size = UDim2.new(0,0,0,0)
TweenService:Create(main,TweenInfo.new(0.45,Enum.EasingStyle.Back),{
	Size = endSize
}):Play()

--// ===================== TITLE =====================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,42)
title.BackgroundTransparency = 1
title.Text = "HXA"
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(220,200,255)

--// ===================== SCROLL =====================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-12,1,-60)
scroll.Position = UDim2.new(0,6,0,50)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 2
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0,8)

--// ===================== BUTTON CREATOR =====================
local function createButton(text, callback)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(0.94,0,0,34)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(95,60,180)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	b.MouseButton1Click:Connect(callback)
end

--// ===================== HUB BUTTONS =====================
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

createButton("🤪 Silly Booster", function()
	safeLoad("silly","https://pastebin.com/raw/GEnDVifW")
end)

createButton("⚡ AP Spammer", function()
	safeLoad("ap","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
end)

createButton("☀️ Sun Hub", function()
	safeLoad("sun","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
end)

createButton("🟣 Semi Instant Steal", function()
	safeLoad(
		"semiinstasteal",
		"https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/refs/heads/main/Artfull"
	)
end)

createButton("🔀 DESYNC", function()
	safeLoad(
		"desync",
		"https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw/e07bf6acc7f5e411e98f40f49c947bc5aaea9dbb/CorruptedDesync"
	)
end)

--// ===================== CLOSE + REOPEN =====================
local reopen = Instance.new("TextButton", gui)
reopen.Size = UDim2.fromScale(0.14,0.08)
reopen.Position = UDim2.fromScale(0.82,0.03)
reopen.Text = "HXA"
reopen.Font = Enum.Font.GothamBlack
reopen.TextScaled = true
reopen.TextColor3 = Color3.fromRGB(230,200,255)
reopen.BackgroundColor3 = Color3.fromRGB(95,60,180)
reopen.BorderSizePixel = 0
reopen.Visible = false
Instance.new("UICorner", reopen).CornerRadius = UDim.new(1,0)

reopen.MouseButton1Click:Connect(function()
	main.Visible = true
	reopen.Visible = false
end)

createButton("❌ Close", function()
	main.Visible = false
	reopen.Visible = true
end)

-- PC keybind
UIS.InputBegan:Connect(function(i,gp)
	if gp or isMobile then return end
	if i.KeyCode == Enum.KeyCode.LeftAlt then
		main.Visible = not main.Visible
		reopen.Visible = not main.Visible
	end
end)

