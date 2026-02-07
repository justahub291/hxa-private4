--// ===================== HXA HUB - FINAL AUTO ADD / REMOVE =====================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

--// SAFE LOAD
getgenv().HXA_LOADED_SCRIPTS = getgenv().HXA_LOADED_SCRIPTS or {}
local function safeLoad(id, url)
	if getgenv().HXA_LOADED_SCRIPTS[id] then return end
	getgenv().HXA_LOADED_SCRIPTS[id] = true
	task.spawn(function()
		loadstring(game:HttpGet(url, true))()
	end)
end

--// AUTO LOAD SAVE
local FILE = "HXA_AutoLoad.json"
local AutoLoad = {}

pcall(function()
	if readfile then
		AutoLoad = HttpService:JSONDecode(readfile(FILE))
	end
end)

local function saveAuto()
	if writefile then
		writefile(FILE, HttpService:JSONEncode(AutoLoad))
	end
end

--// SCRIPT LIST
local Scripts = {
	tpblock  = {"🚀 TP BLOCK", "https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp"},
	chilli   = {"🌶️ Chilli Hub", "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"},
	nameless = {"🌀 Nameless Hub", "https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"},
	illusion = {"✨ Illusion Hub", "https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1"},
	miranda  = {"🧿 Miranda Hub", "https://pastefy.app/JJVhs3rK/raw"},
	kurd     = {"🟢 Kurd Hub", "https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub"},
	ap       = {"⚡ AP Spammer", "https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua"},
	allow    = {"🔓 Allow / Disallow", "https://pastefy.app/wcNjuW3Z/raw"},
	sun      = {"☀️ Sun Hub", "https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua"},
	aimbot   = {"🎯 AIMBOT HXA", "https://raw.githubusercontent.com/justahub291/hxa-private3/main/player-targeting-ui.lua"},
	semi     = {"⚡ Semi Instant Steal", "https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/refs/heads/main/Artfull"},
	desync   = {"🧬 DESYNC", "https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw/CorruptedDesync"}
}

--// GUI ROOT
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HXA_HUB"
gui.ResetOnSpawn = false

--// MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,500)
main.Position = UDim2.new(0.5,-210,0.5,-250)
main.BackgroundColor3 = Color3.fromRGB(15,10,35)
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,28)

--// TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(215,195,255)

--// TOP BAR
local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1,-20,0,40)
topBar.Position = UDim2.new(0,10,0,55)
topBar.BackgroundTransparency = 1

local autoBtn = Instance.new("TextButton", topBar)
autoBtn.Size = UDim2.new(0,190,1,0)
autoBtn.Text = "⚙️ SET AS AUTO LOAD"
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 13
autoBtn.TextColor3 = Color3.new(1,1,1)
autoBtn.BackgroundColor3 = Color3.fromRGB(80,60,160)
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0,14)

local confirmBtn = Instance.new("TextButton", topBar)
confirmBtn.Size = UDim2.new(0,120,1,0)
confirmBtn.Position = UDim2.new(1,-120,0,0)
confirmBtn.Text = "✅ CONFIRM"
confirmBtn.Font = Enum.Font.GothamBold
confirmBtn.TextSize = 13
confirmBtn.TextColor3 = Color3.new(1,1,1)
confirmBtn.BackgroundColor3 = Color3.fromRGB(60,180,120)
Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0,14)

--// SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Position = UDim2.new(0,10,0,105)
scroll.Size = UDim2.new(1,-20,1,-215)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 5
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// BOTTOM REMOVE
local removeBtn = Instance.new("TextButton", main)
removeBtn.Size = UDim2.new(1,-40,0,36)
removeBtn.Position = UDim2.new(0,20,1,-90)
removeBtn.Text = "🗑️ REMOVE AS AUTO LOAD"
removeBtn.Font = Enum.Font.GothamBold
removeBtn.TextSize = 13
removeBtn.TextColor3 = Color3.new(1,1,1)
removeBtn.BackgroundColor3 = Color3.fromRGB(120,60,60)
Instance.new("UICorner", removeBtn).CornerRadius = UDim.new(0,14)

--// STATE
local mode = "normal" -- normal / add / remove
local pendingRemove = {}
local refreshers = {}

--// BUTTONS
for id,data in pairs(Scripts) do
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1,0,0,42)
	b.Text = data[1]
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,20)

	local function refresh()
		if mode == "add" and AutoLoad[id] then
			b.BackgroundColor3 = Color3.fromRGB(60,180,120)
		elseif mode == "remove" and AutoLoad[id] and pendingRemove[id] then
			b.BackgroundColor3 = Color3.fromRGB(180,60,60)
		else
			b.BackgroundColor3 = Color3.fromRGB(95,60,180)
		end
	end
	refresh()

	b.MouseButton1Click:Connect(function()
		if mode == "add" then
			AutoLoad[id] = AutoLoad[id] and nil or data[2]
			refresh()

		elseif mode == "remove" then
			if AutoLoad[id] then
				pendingRemove[id] = not pendingRemove[id]
				refresh()
			end

		else
			safeLoad(id, data[2])
		end
	end)

	refreshers[#refreshers+1] = refresh
end

--// SET MODE ADD
autoBtn.MouseButton1Click:Connect(function()
	mode = mode == "add" and "normal" or "add"
	pendingRemove = {}
	autoBtn.BackgroundColor3 = mode == "add" and Color3.fromRGB(180,120,60) or Color3.fromRGB(80,60,160)
	for _,r in ipairs(refreshers) do r() end
end)

--// SET MODE REMOVE
removeBtn.MouseButton1Click:Connect(function()
	mode = mode == "remove" and "normal" or "remove"
	pendingRemove = {}
	for _,r in ipairs(refreshers) do r() end
end)

--// CONFIRM
confirmBtn.MouseButton1Click:Connect(function()
	if mode == "remove" then
		for id in pairs(pendingRemove) do
			AutoLoad[id] = nil
		end
	end

	saveAuto()

	for id,url in pairs(AutoLoad) do
		safeLoad(id,url)
	end

	mode = "normal"
	pendingRemove = {}
	autoBtn.BackgroundColor3 = Color3.fromRGB(80,60,160)
	for _,r in ipairs(refreshers) do r() end
end)

--// AUTO EXECUTE AFTER GUI
task.defer(function()
	for id,url in pairs(AutoLoad) do
		safeLoad(id,url)
	end
end)
