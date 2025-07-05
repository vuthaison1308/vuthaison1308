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

game:GetService("RunService"):Set3dRenderingEnabled(true)

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
            
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Network"):WaitForChild("RemoteEvent"):WaitForChild("CreateParty"):FireServer(unpack(args))
            end)
            
            task.wait(0.5)
        end
    end)
end
