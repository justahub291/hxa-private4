--// ===================== HXA HUB - FINAL MOBILE =====================

--// SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

--// GUI SAFE
if getgenv().HXA_GUI then
	getgenv().HXA_GUI:Destroy()
end

--// FILE SYSTEM (AUTO LOAD)
local FILE = "HXA_autoload.json"
local AutoLoad = {}

local function readAutoLoad()
	if readfile and isfile and isfile(FILE) then
		local ok, data = pcall(function()
			return HttpService:JSONDecode(readfile(FILE))
		end)
		if ok and type(data) == "table" then
			AutoLoad = data
		end
	end
end

local function saveAutoLoad()
	if writefile then
		writefile(FILE, HttpService:JSONEncode(AutoLoad))
	end
end

readAutoLoad()

--// SAFE LOAD
getgenv().HXA_LOADED_SCRIPTS = getgenv().HXA_LOADED_SCRIPTS or {}
local function safeLoad(id, url)
	if getgenv().HXA_LOADED_SCRIPTS[id] then return end
	getgenv().HXA_LOADED_SCRIPTS[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// STATES
local selectingAuto = false
local removingAuto = false

--// GUI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "HXA_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
getgenv().HXA_GUI = gui

--// MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,340,0,430)
main.Position = UDim2.new(0.5,-170,0.5,-215)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(200,80,200)
stroke.Thickness = 2

--// TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "— HXA Hub —"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(220,120,220)

--// STATUS
local status = Instance.new("TextLabel", main)
status.Position = UDim2.new(0,0,0,45)
status.Size = UDim2.new(1,0,0,35)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextColor3 = Color3.fromRGB(200,200,200)

local function updateStatus()
	local c = 0
	for _ in pairs(AutoLoad) do c += 1 end
	status.Text = "Ready.\nAuto-load: "..c.." script(s)"
end
updateStatus()

--// TOP BUTTONS
local function topBtn(text, x)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0.45,0,0,36)
	b.Position = UDim2.new(x,0,0,90)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,40,120)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
	return b
end

local autoBtn    = topBtn("SET AS AUTO LOAD", 0.03)
local confirmBtn = topBtn("CONFIRM",          0.52)

--// SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Position = UDim2.new(0,12,0,140)
scroll.Size = UDim2.new(1,-24,0,190)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,8)

--// SCRIPTS
local Scripts = {
	tpblock = {"🚀 TP BLOCK","https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp"},
	chilli  = {"🌶️ Chilli Hub","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"},
	nameless={"🌀 Nameless Hub","https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"},
	illusion={"✨ Illusion Hub","https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1"},
	miranda={"🧿 Miranda Hub","https://pastefy.app/JJVhs3rK/raw"},
	kurd    = {"🟢 Kurd Hub","https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub"},
	ap      = {"⚡ AP Spammer","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua"},
	allow   = {"🔓 Allow / Disallow","https://pastefy.app/wcNjuW3Z/raw"},
	sun     = {"☀️ Sun Hub","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua"},
	aimbot  = {"🎯 AIMBOT HXA","AIMBOT"},
	semi    = {"⚡ Semi Instant Steal","https://raw.githubusercontent.com/Solaratfr/SemiInstaSteal/refs/heads/main/Artfull"},
	desync  = {"🧬 DESYNC","https://gist.githubusercontent.com/corruptedhub901/d9198a32ccb024d3a709fc79181d45af/raw/e07bf6acc7f5e411e98f40f49c947bc5aaea9dbb/CorruptedDesync"}
}

local function createButton(id, text, url)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(1,0,0,38)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = text
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)

	local function refresh()
		b.BackgroundColor3 = AutoLoad[id] and Color3.fromRGB(40,160,80) or Color3.fromRGB(40,40,50)
	end

	b.MouseButton1Click:Connect(function()
		if selectingAuto then
			AutoLoad[id] = url ~= "AIMBOT" and url or "AIMBOT"
		elseif removingAuto then
			AutoLoad[id] = nil
		else
			if url == "AIMBOT" then
				loadstring(game:HttpGet(
					"https://raw.githubusercontent.com/justahub291/hxa-private3/main/player-targeting-ui.lua",
					true
				))()
			else
				safeLoad(id,url)
			end
		end
		refresh()
	end)

	refresh()
end

for id,data in pairs(Scripts) do
	createButton(id,data[1],data[2])
end

--// BOTTOM BUTTONS
local function bottomBtn(text,y)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0.9,0,0,36)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(80,40,120)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
	return b
end

local removeBtn = bottomBtn("REMOVE AUTO LOAD", 350)
local closeBtn  = bottomBtn("CLOSE", 390)

--// LOGIC
autoBtn.MouseButton1Click:Connect(function()
	selectingAuto, removingAuto = true, false
end)

removeBtn.MouseButton1Click:Connect(function()
	removingAuto, selectingAuto = true, false
end)

confirmBtn.MouseButton1Click:Connect(function()
	saveAutoLoad()
	selectingAuto, removingAuto = false, false
	updateStatus()
	for id,url in pairs(AutoLoad) do
		if url == "AIMBOT" then
			loadstring(game:HttpGet(
				"https://raw.githubusercontent.com/justahub291/hxa-private3/main/player-targeting-ui.lua",
				true
			))()
		else
			safeLoad(id,url)
		end
	end
end)

--// CLOSE / REOPEN BUTTON
local reopen = Instance.new("TextButton", gui)
reopen.Size = UDim2.new(0,50,0,50)
reopen.Position = UDim2.new(1,-70,0,20)
reopen.Text = "HXA"
reopen.Font = Enum.Font.GothamBlack
reopen.TextSize = 16
reopen.TextColor3 = Color3.new(1,1,1)
reopen.BackgroundColor3 = Color3.fromRGB(120,60,180)
reopen.Visible = false
reopen.Active = true
reopen.Draggable = true
Instance.new("UICorner", reopen).CornerRadius = UDim.new(1,0)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
	main.Visible = true
	reopen.Visible = false
end)

--// AUTO EXECUTE ON START
for id,url in pairs(AutoLoad) do
	if url == "AIMBOT" then
		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/justahub291/hxa-private3/main/player-targeting-ui.lua",
			true
		))()
	else
		safeLoad(id,url)
	end
end
