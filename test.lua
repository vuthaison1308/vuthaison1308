local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

local TELEPORT_DISTANCE = 2.5
local CLICK_DELAY = 0.05  -- Giảm delay click xuống
local TARGET_SWITCH_DELAY = 2
local SAFE_HEIGHT = 300  -- Độ cao bay lên khi máu thấp

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
       return
   end
   
   pcall(function()
       EquipRemote:FireServer(unpack(EquipArgs))
       local newTool = backpack:WaitForChild(WEAPON_NAME, 3)
       if newTool and humanoid then
           humanoid:EquipTool(newTool)
       end
   end)
end

local function getMyHealthPercent()
   local character = LocalPlayer.Character
   if not character then return 0 end
   local humanoid = character:FindFirstChildOfClass("Humanoid")
   if not humanoid then return 0 end
   return (humanoid.Health / humanoid.MaxHealth) * 100
end

local function teleportBehindPlayer(player)
   if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
       return
   end
   
   local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
   if not myHRP then return end

   local targetHRP = player.Character.HumanoidRootPart
   local myHealthPercent = getMyHealthPercent()
   
   local teleportPosition
   
   if myHealthPercent < 40 then
       -- Bay lên đầu mục tiêu 300 stud khi máu dưới 40%
       teleportPosition = targetHRP.Position + Vector3.new(0, SAFE_HEIGHT, 0)
       myHRP.CFrame = CFrame.new(teleportPosition, targetHRP.Position)
   else
       -- Teleport bình thường phía sau
       local lookVector = targetHRP.CFrame.LookVector
       teleportPosition = targetHRP.Position - (lookVector * TELEPORT_DISTANCE)
       local lookAt = CFrame.new(teleportPosition, targetHRP.Position)
       myHRP.CFrame = lookAt
   end
end

local function attackOnce()
   local screenSize = cam.ViewportSize
   local centerX = screenSize.X / 2
   local centerY = screenSize.Y / 2
   
   VIM:SendMouseButtonEvent(centerX, centerY, 0, true, nil, 0)
   VIM:SendMouseButtonEvent(centerX, centerY, 0, false, nil, 0)
end

local function isTargetValid(player)
   if not player or player == LocalPlayer then return false end
   if not player.Character or not player.Character:FindFirstChild("Humanoid") then return false end
   
   local targetHumanoid = player.Character.Humanoid
   if targetHumanoid.Health <= 0 then return false end
   
   -- Skip nếu player đang ngồi
   if targetHumanoid.Sit then return false end
   
   -- Skip nếu máu target <= 1%
   local healthPercent = (targetHumanoid.Health / targetHumanoid.MaxHealth) * 100
   if healthPercent <= 1 then return false end
   
   return true
end

-- Tele liên tục với RunService
local teleportConnection
local currentTarget

local function startTeleporting(target)
   if teleportConnection then
       teleportConnection:Disconnect()
   end
   
   currentTarget = target
   teleportConnection = RunService.Heartbeat:Connect(function()
       if isTargetValid(currentTarget) then
           pcall(function()
               teleportBehindPlayer(currentTarget)
           end)
       end
   end)
end

local function stopTeleporting()
   if teleportConnection then
       teleportConnection:Disconnect()
       teleportConnection = nil
   end
   currentTarget = nil
end

task.spawn(function()
   while true do
       local allPlayers = Players:GetPlayers()
       
       for _, targetPlayer in ipairs(allPlayers) do
           
           if isTargetValid(targetPlayer) then
               startTeleporting(targetPlayer)  -- Bắt đầu tele liên tục
               
               while isTargetValid(targetPlayer) do
                   pcall(function()
                       ensureWeaponEquipped()
                       
                       if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(WEAPON_NAME) then
                           attackOnce()
                       end
                   end)
                   
                   task.wait(CLICK_DELAY)
               end
               
               stopTeleporting()  -- Dừng tele khi target không còn valid
               task.wait(TARGET_SWITCH_DELAY)
           end
       end
       
       task.wait(0.05)
   end
end)
