--// ===================== HXA HUB - FINAL AUTOLOAD FIX =====================
getgenv().HXA_AUTOLOAD = getgenv().HXA_AUTOLOAD or {}

--// SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// CLEAN GUI
if getgenv().HXA_GUI then
	getgenv().HXA_GUI:Destroy()
end

--// EXEC SCRIPT
local function runScript(url)
	loadstring(game:HttpGet(url))()
end

--// AUTO EXECUTE (ON SCRIPT START)
for _,url in pairs(getgenv().HXA_AUTOLOAD) do
	task.spawn(function()
		runScript(url)
	end)
end

--// GUI ROOT
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HXA_HUB"
gui.ResetOnSpawn = false
getgenv().HXA_GUI = gui

--// MAIN (2x smaller)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,170,0,255)
main.Position = UDim2.new(0.5,-85,0.5,-128)
main.BackgroundColor3 = Color3.fromRGB(15,10,35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

--// TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,26)
title.BackgroundTransparency = 1
title.Text = "HXA HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(215,195,255)

--// MODE
local mode = "NORMAL"
local selected = {}

--// TOP BUTTONS
local autoBtn = Instance.new("TextButton", main)
autoBtn.Size = UDim2.new(0,26,0,18)
autoBtn.Position = UDim2.new(0,5,0,5)
autoBtn.Text = "+"
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.BackgroundColor3 = Color3.fromRGB(90,70,170)
autoBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", autoBtn)

local confirmBtn = autoBtn:Clone()
confirmBtn.Parent = main
confirmBtn.Position = UDim2.new(1,-31,0,5)
confirmBtn.Text = "✓"

--// SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-10,1,-78)
scroll.Position = UDim2.new(0,5,0,30)
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 3

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// BUTTON CREATOR
local function createButton(text,id,url)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1,0,0,24)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(95,60,180)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

	b.MouseButton1Click:Connect(function()
		if mode ~= "NORMAL" then
			selected[id] = {url=url,button=b}
			b.BackgroundColor3 = Color3.fromRGB(0,170,0)
			return
		end
		runScript(url)
	end)
end

--// ===== ALL BUTTONS =====
createButton("🚀 TP BLOCK","tpblock","https://raw.githubusercontent.com/rookieiscute/rookiescripts/main/RookieTp")
createButton("⚡ FLASH TP","flashtp","https://api.luarmor.net/files/v4/loaders/0b5aa751f72560035e687cd879a5a1df.lua")
createButton("🌶️ Chilli Hub","chilli","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
createButton("🌀 Nameless Hub","nameless","https://raw.githubusercontent.com/ily123950/Vulkan/main/Tr")
createButton("✨ Illusion Hub","illusion","https://raw.githubusercontent.com/fdellacortw-svg/Website/main/config1")
createButton("🧿 Miranda Hub","miranda","https://pastefy.app/JJVhs3rK/raw")
createButton("🟢 Kurd Hub","kurd","https://raw.githubusercontent.com/Ninja10908/S4/main/Kurdhub")
createButton("⚡ AP Spammer","apspammer","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
createButton("🔓 Allow / Disallow","allow","https://pastefy.app/wcNjuW3Z/raw")
createButton("☀️ Sun Hub","sunhub","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
createButton("🎯 AIMBOT HXA","aimbot","https://raw.githubusercontent.com/justahub291/hxa-private3/main/player-targeting-ui.lua")
createButton("⚡ Semi Instant Steal","semi","https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/main/Artfull")
createButton("🧬 DESYNC","desync","https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw")

--// BOTTOM BUTTONS
local removeBtn = Instance.new("TextButton", main)
removeBtn.Size = UDim2.new(1,-20,0,20)
removeBtn.Position = UDim2.new(0,10,1,-46)
removeBtn.Text = "Remove as Auto Load"
removeBtn.Font = Enum.Font.GothamBold
removeBtn.TextSize = 9
removeBtn.BackgroundColor3 = Color3.fromRGB(130,60,60)
removeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", removeBtn)

local closeBtn = removeBtn:Clone()
closeBtn.Parent = main
closeBtn.Position = UDim2.new(0,10,1,-24)
closeBtn.Text = "Close"

--// MODE SWITCH
autoBtn.MouseButton1Click:Connect(function()
	mode = "AUTO"
	selected = {}
end)

removeBtn.MouseButton1Click:Connect(function()
	mode = "REMOVE"
	selected = {}
end)

--// CONFIRM (FIXED)
confirmBtn.MouseButton1Click:Connect(function()
	if mode == "AUTO" then
		for id,data in pairs(selected) do
			getgenv().HXA_AUTOLOAD[id] = data.url
			runScript(data.url) -- 🔥 EXEC IMMEDIATELY
			data.button.BackgroundColor3 = Color3.fromRGB(95,60,180)
		end
	elseif mode == "REMOVE" then
		for id,data in pairs(selected) do
			getgenv().HXA_AUTOLOAD[id] = nil
			data.button.BackgroundColor3 = Color3.fromRGB(95,60,180)
		end
	end
	mode = "NORMAL"
	selected = {}
end)

--// CLOSE + REOPEN
local reopen = Instance.new("TextButton", gui)
reopen.Size = UDim2.new(0,38,0,38)
reopen.Position = UDim2.new(1,-48,0,10)
reopen.Text = "HXA"
reopen.Font = Enum.Font.GothamBlack
reopen.TextSize = 11
reopen.Visible = false
reopen.Active = true
reopen.Draggable = true
reopen.BackgroundColor3 = Color3.fromRGB(95,60,180)
reopen.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", reopen).CornerRadius = UDim.new(1,0)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
	main.Visible = true
	reopen.Visible = false
end)
