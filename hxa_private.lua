--// ================== ANTI DOUBLE EXEC ==================
if getgenv().HXA_LOADED then return end
getgenv().HXA_LOADED = true

--// ================== SERVICES ==================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// ================== OWNER / WHITELIST ==================
local OWNER_ID = 10440238844 -- TOI SEUL

local Whitelist = {
    [OWNER_ID] = true,
    [8761695710] = true,
}

if not Whitelist[player.UserId] then
    player:Kick("❌ Accès refusé (non whitelist)")
    return
end

--// ================== GUI ==================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HXA_GUI"
gui.ResetOnSpawn = false

-- mémoire position
local savedPos = UDim2.fromScale(0.4,0.4)

--// ================== HUB FRAME ==================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(400,250)
main.Position = savedPos
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- animation apparition
main.Size = UDim2.fromOffset(0,0)
TweenService:Create(
    main,
    TweenInfo.new(0.4, Enum.EasingStyle.Back),
    {Size = UDim2.fromOffset(400,250)}
):Play()

--// ================== CLOSE BUTTON ==================
local close = Instance.new("TextButton", main)
close.Size = UDim2.fromOffset(30,30)
close.Position = UDim2.fromOffset(360,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(180,50,50)

--// ================== MINI HXA BUTTON ==================
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(50,50)
mini.Position = savedPos
mini.Text = "HXA"
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(30,30,30)
mini.BorderSizePixel = 0
mini.Active = true
mini.Draggable = true
mini.TextScaled = true
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

--// ================== CLOSE ACTION ==================
close.MouseButton1Click:Connect(function()
    savedPos = main.Position
    TweenService:Create(
        main,
        TweenInfo.new(0.3),
        {Size = UDim2.fromOffset(0,0)}
    ):Play()
    task.wait(0.3)
    main.Visible = false
    mini.Position = savedPos
    mini.Visible = true
end)

--// ================== OPEN ACTION ==================
mini.MouseButton1Click:Connect(function()
    main.Position = mini.Position
    main.Visible = true
    mini.Visible = false
    main.Size = UDim2.fromOffset(0,0)
    TweenService:Create(
        main,
        TweenInfo.new(0.4, Enum.EasingStyle.Back),
        {Size = UDim2.fromOffset(400,250)}
    ):Play()
end)

--// ================== OWNER FUNCTIONS ==================
local function addToWhitelist(id)
    if player.UserId ~= OWNER_ID then return end
    Whitelist[id] = true
end

local function removeFromWhitelist(id)
    if player.UserId ~= OWNER_ID then return end
    Whitelist[id] = nil
end

--// ================== RELOAD / UNLOAD ==================
local function unload()
    getgenv().HXA_LOADED = false
    gui:Destroy()
end

local function reload()
    unload()
    loadstring(game:HttpGet("TON_RAW_GITHUB_ICI"))()
end

--// ================== LOCK WHITELIST ==================
table.freeze(Whitelist)
