local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

local TELEPORT_DISTANCE = 5
local CLICK_DELAY = 0.25
local TARGET_SWITCH_DELAY = 2

local EquipRemote = ReplicatedStorage:WaitForChild("KnitPackages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("InventoryService"):WaitForChild("RE"):WaitForChild("updateInventory")
local EquipArgs = {"eue", "PhongLon"}
local WEAPON_NAME = "PhongLon"

local function ensureWeaponEquipped()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer.Backpack

    if not (character and humanoid and humanoid.Health > 0) then return end

    if character:FindFirstChild(WEAPON_NAME) then
        return
    end

    local toolInBackpack = backpack:FindFirstChild(WEAPON_NAME)
    if toolInBackpack then
        humanoid:EquipTool(toolInBackpack)
        task.wait(0.2)
        return
    end
    
    pcall(function()
        EquipRemote:FireServer(unpack(EquipArgs))
        local newTool = backpack:WaitForChild(WEAPON_NAME, 5)
        if newTool and humanoid then
            humanoid:EquipTool(newTool)
            task.wait(0.2)
        end
    end)
end

local function teleportBehindPlayer(player)
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    local targetHRP = player.Character.HumanoidRootPart
    
    local lookVector = targetHRP.CFrame.LookVector
    local teleportPosition = targetHRP.Position - (lookVector * TELEPORT_DISTANCE)
    
    local lookAt = CFrame.new(teleportPosition, targetHRP.Position)
    myHRP.CFrame = lookAt
end

local function attackOnce()
    local screenSize = cam.ViewportSize
    local centerX = screenSize.X / 2
    local centerY = screenSize.Y / 2
    
    VIM:SendMouseButtonEvent(centerX, centerY, 0, true, nil, 0)
    task.wait(0.05)
    VIM:SendMouseButtonEvent(centerX, centerY, 0, false, nil, 0)
end

local function isTargetValid(player)
    return player and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

task.spawn(function()
    while true do
        local allPlayers = Players:GetPlayers()
        
        for _, targetPlayer in ipairs(allPlayers) do
            
            if isTargetValid(targetPlayer) then
                
                while isTargetValid(targetPlayer) do
                    pcall(function()
                        ensureWeaponEquipped()
                        
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(WEAPON_NAME) then
                            teleportBehindPlayer(targetPlayer)
                            attackOnce()
                        end
                    end)
                    
                    task.wait(CLICK_DELAY)
                end
                
                task.wait(TARGET_SWITCH_DELAY)
            end
        end
        
        task.wait(1)
    end
end)
