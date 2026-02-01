--// ===================== HXA PRIVATE HUB - FINAL =====================
--// Anti double execution (global)
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// ===================== OWNER / WHITELIST =====================
local OWNER_ID = 10440238844 -- TOI SEUL (owner)
local Whitelist = {
	[OWNER_ID] = true,
	[8761695710] = true, -- autre user autorisé
}

if not Whitelist[player.UserId] then
	player:Kick("❌ Accès refusé (non whitelist)")
	return
end

--// ===================== BLACKLIST (scripts déjà chargés) =====================
getgenv().HXA_BLACKLIST = getgenv().HXA_BLACKLIST or {}
local function safeLoad(id, url)
	if getgenv().HXA_BLACKLIST[id] then
		return
	end
	getgenv().HXA_BLACKLIST[id] = true
	loadstring(game:HttpGet(url, true))()
end

--// ===================== GUI ROOT =====================
local gui = Instance.new("ScreenGui")
gui.Name = "HXAPRIVATE"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// ===================== STARS BACKGROUND =====================
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

--// ===================== NOTIFICATION =====================
local function notify(title, text)
	local notif = Instance.new("Frame", gui)
	notif.Size = UDim2.new(0,260,0,70)
	notif.Position = UDim2.new(1,-280,1,100)
	notif.BackgroundColor3 = Color3.fromRGB(30,20,60)
	notif.BorderSizePixel = 0
	notif.AnchorPoint = Vector2.new(0,1)
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0,18)

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

	notif:TweenPosition(UDim2.new(1,-280,1,-20), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
	task.delay(3,function()
		notif:TweenPosition(UDim2.new(1,-280,1,100), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.4, true)
		task.delay(0.5,function() notif:Destroy() end)
	end)
end

--// ===================== MAIN FRAME =====================
local savedPos = UDim2.fromScale(0.5,0.5)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,400)
main.Position = UDim2.new(0.5,-210,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(14,10,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,30)

-- open anim
main.Size = UDim2.new(0,0,0,0)
TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0,420,0,400)}):Play()

--// ===================== TOP BAR =====================
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

--// ===================== SEARCH =====================
local searchBox = Instance.new("TextBox", main)
searchBox.Size = UDim2.new(1,-40,0,36)
searchBox.Position = UDim2.new(0,20,0,70)
searchBox.PlaceholderText = "Search..."
searchBox.ClearTextOnFocus = false
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.TextColor3 = Color3.new(1,1,1)
searchBox.PlaceholderColor3 = Color3.fromRGB(170,170,190)
searchBox.BackgroundColor3 = Color3.fromRGB(25,18,50)
searchBox.BorderSizePixel = 0
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,14)

--// ===================== SCROLL =====================
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-140)
scroll.Position = UDim2.new(0,10,0,115)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// ===================== BUTTON CREATOR =====================
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
	b.MouseButton1Click:Connect(function()
		if b:GetAttribute("LOCK") then return end
		b:SetAttribute("LOCK", true)
		callback()
		task.delay(0.5, function() b:SetAttribute("LOCK", false) end)
	end)
	return b
end

-- search logic
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local q = string.lower(searchBox.Text)
	for _,c in ipairs(scroll:GetChildren()) do
		if c:IsA("TextButton") then
			c.Visible = (q == "" or string.find(string.lower(c.Text), q))
		end
	end
end)

--// ===================== BUTTONS =====================
createButton("🚀 TP BLOCK", function()
	safeLoad("tpblock","https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp")
	notify("TP Block","Loaded ✔")
end)

createButton("🌶️ Chilli Hub", function()
	safeLoad("chilli","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
	notify("Chilli Hub","Loaded ✔")
end)

createButton("🌀 Nameless Hub", function()
	safeLoad("nameless","https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
	notify("Nameless Hub","Loaded ✔")
end)

createButton("✨ Illusion Hub", function()
	safeLoad("illusion","https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1")
	notify("Illusion Hub","Loaded ✔")
end)

createButton("🧿 Miranda Hub", function()
	safeLoad("miranda","https://pastefy.app/JJVhs3rK/raw")
	notify("Miranda Hub","Loaded ✔")
end)

createButton("🟢 Kurd Hub", function()
	safeLoad("kurd","https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub")
	notify("Kurd Hub","Loaded ✔")
end)

createButton("🔒 Auto Block After Steal", function()
	safeLoad("autoblock","https://api.luarmor.net/files/v3/loaders/e51d9174e080752c62ce754bb72ad183.lua")
	notify("Auto Block","Loaded ✔")
end)

createButton("🤪 Silly Booster", function()
	safeLoad("silly","https://pastebin.com/raw/GEnDVifW")
	notify("Silly Booster","Loaded ✔")
end)

createButton("⚡ AP Spammer", function()
	safeLoad("ap","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua")
	notify("AP Spammer","Loaded ✔")
end)

createButton("☀️ Sun Hub", function()
	safeLoad("sun","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua")
	notify("Sun Hub","Loaded ✔")
end)

-- unload / reload (owner only)
createButton("♻️ Reload Hub (Owner)", function()
	if player.UserId ~= OWNER_ID then return end
	getgenv().HXA_LOADED = false
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/justahub291/hxa-private4/refs/heads/main/hxa_private.lua", true))()
end)

createButton("🗑️ Unload Hub", function()
	getgenv().HXA_LOADED = false
	gui:Destroy()
end)

--// ===================== MINI HXA BUTTON =====================
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
	main.Position = savedPos
	main.Visible = true
	reopenBtn.Visible = false
	main.Size = UDim2.new(0,0,0,0)
	TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0,420,0,400)}):Play()
end)

-- close
createButton("❌ Close", function()
	savedPos = main.Position
	TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
	task.wait(0.3)
	main.Visible = false
	reopenBtn.Position = savedPos
	reopenBtn.Visible = true
end)

-- keybind ALT
UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.LeftAlt or i.KeyCode == Enum.KeyCode.RightAlt then
		if main.Visible then
			savedPos = main.Position
			main.Visible = false
			reopenBtn.Position = savedPos
			reopenBtn.Visible = true
		else
			main.Position = savedPos
			main.Visible = true
			reopenBtn.Visible = false
		end
	end
end)
