--// ===================== HXA HUB - FULL FINAL ALL-IN-ONE =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

--// SAFE LOAD (anti double load)
getgenv().HXA_LOADED_SCRIPTS = getgenv().HXA_LOADED_SCRIPTS or {}
local function safeLoad(id, url)
	if getgenv().HXA_LOADED_SCRIPTS[id] then return end
	getgenv().HXA_LOADED_SCRIPTS[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// GUI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "HXA_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,440)
main.Position = UDim2.new(0.5,-210,0.5,-220)
main.BackgroundColor3 = Color3.fromRGB(15,10,35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,28)

--// TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,55)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(215,195,255)

--// SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-75)
scroll.Position = UDim2.new(0,10,0,60)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 5
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// BUTTON CREATOR
local function createButton(text, callback)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1,0,0,44)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(95,60,180)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,20)
	b.MouseButton1Click:Connect(callback)
end

--// ===================== ALL BUTTONS =====================

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

createButton("⚡ AP Spammer", function()
	safeLoad("apspammer","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
end)

createButton("🔓 Allow / Disallow", function()
	safeLoad("allow","https://pastefy.app/wcNjuW3Z/raw")
end)

createButton("☀️ Sun Hub", function()
	safeLoad("sunhub","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
end)

createButton("🎯 AIMBOT HXA", function()
	safeLoad("aimbothxa","https://raw.githubusercontent.com/justahub291/hxa-private4/main/hxa_private.lua")
end)

createButton("⚡ Semi Instant Steal", function()
	safeLoad("semi","https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/refs/heads/main/Artfull")
end)

createButton("🧬 DESYNC", function()
	safeLoad("desync","https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw/e07bf6acc7f5e411e98f40f49c947bc5aaea9dbb/CorruptedDesync")
end)

--// CLOSE
createButton("❌ Close", function()
	main.Visible = false
	reopen.Visible = true
end)

--// REOPEN BUTTON
reopen = Instance.new("TextButton", gui)
reopen.Size = UDim2.new(0,55,0,55)
reopen.Position = UDim2.new(1,-75,0,20)
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

--// ALT KEYBIND
UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.LeftAlt or i.KeyCode == Enum.KeyCode.RightAlt then
		main.Visible = not main.Visible
		reopen.Visible = not main.Visible
	end
end)
