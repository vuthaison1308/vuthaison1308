repeat wait() until game:IsLoaded()
if getgenv().MyMultiScriptV2 then return end
getgenv().MyMultiScriptV2 = true

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local placeId = game.PlaceId
local TimeHop = 300

local savedData = {
    lastKnownBonds = "N/A"
}
local dataFileName = localPlayer.Name .. "_TheaugHubData.json"

pcall(function()
    if isfile and isfile(dataFileName) then
        local fileContent = readfile(dataFileName)
        local decodedData = httpService:JSONDecode(fileContent)
        if decodedData and decodedData.lastKnownBonds then
            savedData = decodedData
        end
    end
end)

game:GetService("RunService"):Set3dRenderingEnabled(false)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local BlackFrame = Instance.new("Frame")
BlackFrame.Parent = ScreenGui
BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackFrame.BorderSizePixel = 0
BlackFrame.Size = UDim2.new(1, 0, 1, 0)
BlackFrame.Position = UDim2.new(0, 0, 0, 0)
BlackFrame.ZIndex = -1

pcall(function()
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    for _, gui in pairs(localPlayer.PlayerGui:GetChildren()) do
        if gui ~= ScreenGui and gui.Name ~= "x2zu [FREE]" then
            gui.Enabled = false
        end
    end
    for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
        pcall(function()
            gui.Enabled = false
        end)
    end
end)

local LogoFrame = Instance.new("Frame")
LogoFrame.Parent = ScreenGui
LogoFrame.BackgroundTransparency = 1
LogoFrame.Size = UDim2.new(0, 600, 0, 180) 
LogoFrame.Position = UDim2.new(0.5, -300, 0.5, -90)
LogoFrame.ZIndex = 10

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = LogoFrame
MainTitle.BackgroundTransparency = 1
MainTitle.Size = UDim2.new(1, 0, 0.5, 0)
MainTitle.Position = UDim2.new(0, 0, 0, 0)
MainTitle.Text = "Theaug Hub"
MainTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
MainTitle.TextScaled = true
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextStrokeTransparency = 0
MainTitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.ZIndex = 11

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = LogoFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Size = UDim2.new(1, 0, 0.20, 0)
SubTitle.Position = UDim2.new(0, 0, 0.5, 0)
SubTitle.Text = "Dead Rails"
SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.ZIndex = 11

local BondsLabel = Instance.new("TextLabel")
BondsLabel.Parent = LogoFrame
BondsLabel.BackgroundTransparency = 1
BondsLabel.Size = UDim2.new(1, 0, 0.23, 0)
BondsLabel.Position = UDim2.new(0, 0, 0.7, 10)
BondsLabel.Text = "Bonds: " .. savedData.lastKnownBonds
BondsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BondsLabel.Font = Enum.Font.Gotham
BondsLabel.TextScaled = true
BondsLabel.ZIndex = 11

task.spawn(function()
    local success, err = pcall(function()
        local bondDisplayGui = localPlayer.PlayerGui:WaitForChild("BondDisplay", 10)
        local bondInfoFrame = bondDisplayGui:WaitForChild("BondInfo", 10)
        local sourceBondCountLabel = bondInfoFrame:WaitForChild("BondCount", 10)
        
        local function updateBondsDisplay()
            local currentBonds = sourceBondCountLabel.Text
            BondsLabel.Text = "Bonds: " .. currentBonds
            
            savedData.lastKnownBonds = currentBonds
            local json_data = httpService:JSONEncode(savedData)
            pcall(writefile, dataFileName, json_data)
        end
        
        updateBondsDisplay()
        sourceBondCountLabel:GetPropertyChangedSignal("Text"):Connect(updateBondsDisplay)
    end)
end)

if placeId == 70876832253163 or placeId == 98018823628597 then
    
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/vuthaison1308/vuthaison1308/refs/heads/main/DR.lua"))()
        end)
    end)

    task.spawn(function()
        local playerToTeleport = localPlayer
        local targetPlaceId = 116495829188952
        task.wait(TimeHop)
        pcall(function()
            teleportService:Teleport(targetPlaceId, playerToTeleport)
        end)
    end)

elseif placeId == 116495829188952 then

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    task.spawn(function()
        local coordinates = {
            Vector3.new(38, 7, 100), Vector3.new(38, 7, 115),
            Vector3.new(38, 7, 130), Vector3.new(38, 7, 145)
        }
        while true do
            for _, pos in ipairs(coordinates) do
                if rootPart then rootPart.CFrame = CFrame.new(pos) end
                task.wait(1.5)
            end
        end
    end)

    task.spawn(function()
        while true do
            local args = {
            {
                isPrivate = true,
                maxMembers = 1,
                trainId = "default",
                gameMode = "Normal"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Network"):WaitForChild("RemoteEvent"):WaitForChild("CreateParty"):FireServer(unpack(args))
        end
    end)
end
