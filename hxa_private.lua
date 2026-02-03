--// ===================== HXA PRIVATE HUB - FINAL =====================
--// Anti double execution
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ===================== SERVICES =====================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// ===================== PLATFORM SELECT =====================
getgenv().HXA_PLATFORM = nil

local selectGui = Instance.new("ScreenGui")
selectGui.Name = "HXA_PLATFORM_SELECT"
selectGui.ResetOnSpawn = false
selectGui.Parent = player:WaitForChild("PlayerGui")

local box = Instance.new("Frame", selectGui)
box.Size = UDim2.new(0,300,0,180)
box.Position = UDim2.new(0.5,-150,0.5,-90)
box.BackgroundColor3 = Color3.fromRGB(18,12,40)
box.BorderSizePixel = 0
Instance.new("UICorner", box).CornerRadius = UDim.new(0,24)

local titleSelect = Instance.new("TextLabel", box)
titleSelect.Size = UDim2.new(1,0,0,50)
titleSelect.BackgroundTransparency = 1
titleSelect.Text = "Choose Version"
titleSelect.Font = Enum.Font.GothamBlack
titleSelect.TextSize = 22
titleSelect.TextColor3 = Color3.fromRGB(220,200,255)

local function platformButton(text, y, value)
	local b = Instance.new("TextButton", box)
	b.Size = UDim2.new(0.8,0,0,40)
	b.Position = UDim2.new(0.1,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(90,55,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,20)
	b.MouseButton1Click:Connect(function()
		getgenv().HXA_PLATFORM = value
		selectGui:Destroy()
	end)
end

platformButton("🖥️ PC Version",70,"PC")
platformButton("📱 Mobile Version",120,"MOBILE")

repeat task.wait() until getgenv().HXA_PLATFORM
local isMobile = getgenv().HXA_PLATFORM == "MOBILE"

--// ===================== OWNER / WHITELIST =====================
local OWNER_ID = 10440238844
local Whitelist = {
	[OWNER_ID] = true,
	[8761695710] = true,
}
if not Whitelist[player.UserId] then
	player:Kick("❌ Accès refusé (non whitelist)")
	return
end

--// ===================== BLACKLIST =====================
getgenv().HXA_BLACKLIST = getgenv().HXA_BLACKLIST or {}
local function safeLoad(id,url)
	if getgenv().HXA_BLACKLIST[id] then return end
	getgenv().HXA_BLACKLIST[id] = true
	loadstring(game:HttpGet(url,true))()
end

--// ===================== GUI ROOT =====================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HXAPRIVATE"
gui.ResetOnSpawn = false

--// ===================== STARS BACKGROUND =====================
local starsFolder = Instance.new("Folder", gui)
local stars = {}
for i=1,140 do
	local s = Instance.new("Frame", starsFolder)
	local size = math.random(1,2)
	s.Size = UDim2.new(0,size,0,size)
	s.Position = UDim2.new(math.random(),0,math.random(),0)
	s.BackgroundColor3 = Color3.fromRGB(230,230,255)
	s.BackgroundTransparency = math.random(3,6)/10
	s.BorderSizePixel = 0
	stars[s] = math.random(6,20)/1000
end
RunService.RenderStepped:Connect(function()
	for s,spd in pairs(stars) do
		local y = s.Position.Y.Scale + spd
		if y > 1.05 then
			s.Position = UDim2.new(math.random(),0,-0.05,0)
		else
			s.Position = UDim2.new(s.Position.X.Scale,0,y,0)
		end
	end
end)

--// ===================== MAIN FRAME =====================
local mainSize = isMobile and UDim2.new(0,340,0,330) or UDim2.new(0,420,0,400)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,0,0,0)
main.Position = UDim2.new(0.5,-mainSize.X.Offset/2,0.5,-mainSize.Y.Offset/2)
main.BackgroundColor3 = Color3.fromRGB(14,10,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,30)

TweenService:Create(main,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Size=mainSize}):Play()

--// ===================== TOP BAR =====================
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,60)
top.BackgroundTransparency = 1

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "HXA PRIVATE"
title.Font = Enum.Font.GothamBlack
title.TextSize = isMobile and 24 or 30
title.TextColor3 = Color3.fromRGB(215,195,255)

--// ===================== SEARCH =====================
local searchBox = Instance.new("TextBox", main)
searchBox.Size = isMobile and UDim2.new(1,-30,0,32) or UDim2.new(1,-40,0,36)
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
local function createButton(text,callback)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(0.9,0,0,isMobile and 42 or 48)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(85,45,170)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,24)
	b.MouseButton1Click:Connect(callback)
end

--// ===================== ALL BUTTONS =====================
createButton("🚀 TP BLOCK",function() safeLoad("tpblock","https://raw.githubusercontent.com/rookieiscute/rookiescripts/refs/heads/main/RookieTp") end)
createButton("🌶️ Chilli Hub",function() safeLoad("chilli","https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua") end)
createButton("🌀 Nameless Hub",function() safeLoad("nameless","https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr") end)
createButton("✨ Illusion Hub",function() safeLoad("illusion","https://raw.githubusercontent.com/fdellacortw-svg/Website/refs/heads/main/config1") end)
createButton("🧿 Miranda Hub",function() safeLoad("miranda","https://pastefy.app/JJVhs3rK/raw") end)
createButton("🟢 Kurd Hub",function() safeLoad("kurd","https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub") end)
createButton("🔒 Auto Block After Steal",function() safeLoad("autoblock","https://api.luarmor.net/files/v3/loaders/e51d9174e080752c62ce754bb72ad183.lua") end)
createButton("🤪 Silly Booster",function() safeLoad("silly","https://pastebin.com/raw/GEnDVifW") end)
createButton("⚡ AP Spammer",function() safeLoad("ap","https://api.luarmor.net/files/v3/loaders/ede7ef9c404dba463a6103aeb3cc321a.lua") end)
createButton("☀️ Sun Hub",function() safeLoad("sun","https://api.luarmor.net/files/v4/loaders/623c61e59524bc04f458c6f6dd2c3f8b.lua") end)

createButton("♻️ Reload Hub (Owner)",function()
	if player.UserId ~= OWNER_ID then return end
	getgenv().HXA_LOADED = false
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/justahub291/hxa-private4/refs/heads/main/hxa_private.lua",true))()
end)

--// ===================== REOPEN BUTTON =====================
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
	main.Visible = true
	reopenBtn.Visible = false
	TweenService:Create(main,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Size=mainSize}):Play()
end)

createButton("❌ Close",function()
	main.Visible = false
	reopenBtn.Visible = true
end)

--// ===================== ALT TOGGLE (PC) =====================
UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if not isMobile and (i.KeyCode==Enum.KeyCode.LeftAlt or i.KeyCode==Enum.KeyCode.RightAlt) then
		main.Visible = not main.Visible
		reopenBtn.Visible = not main.Visible
	end
end)
