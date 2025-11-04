repeat wait() until game:IsLoaded() 
wait(2)

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local BuyLucky = true
local AutoSell = true
local Hop = true

local PriorityItems = {
    "Lucky Arrow",
    "Lucky Stone Mask",
    "Green Candy",
    "Red Candy",
    "Blue Candy",
    "Yellow Candy"
}

local SellItems = {
    ["Gold Coin"] = true,
    ["Rokakaka"] = true,
    ["Pure Rokakaka"] = true,
    ["Mysterious Arrow"] = true,
    ["Diamond"] = true,
    ["Ancient Scroll"] = true,
    ["Caesar's Headband"] = true,
    ["Stone Mask"] = true,
    ["Rib Cage of The Saint's Corpse"] = true,
    ["Quinton's Glove"] = true,
    ["Zeppeli's Hat"] = true,
    ["Lucky Arrow"] = false,
    ["Lucky Stone Mask"] = false,
    ["Clackers"] = true,
    ["Steel Ball"] = true,
    ["Dio's Diary"] = true,
    ["Green Candy"] = false,
    ["Red Candy"] = false,
    ["Blue Candy"] = false,
    ["Yellow Candy"] = false
}

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function CountLuckyArrows()
    local Count = 0
    for _, Tool in pairs(Player.Backpack:GetChildren()) do
        if Tool.Name == "Lucky Arrow" then
            Count += 1
        end
    end
    return Count
end

if getgenv().MyYBAScriptUI then return end
getgenv().MyYBAScriptUI = true

if _G.Disable3DRender then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local BlackFrame = Instance.new("Frame")
BlackFrame.Parent = ScreenGui
BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackFrame.BorderSizePixel = 0
BlackFrame.Size = UDim2.new(1, 0, 1, 0)
BlackFrame.Position = UDim2.new(0, 0, 0, 0)
BlackFrame.ZIndex = -1
BlackFrame.Visible = _G.Disable3DRender

local function cleanupOtherUIs()
    pcall(function()
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        for _, gui in pairs(PlayerGui:GetChildren()) do
            if gui ~= ScreenGui then
                gui.Enabled = false
            end
        end
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            pcall(function()
                gui.Enabled = false
            end)
        end
    end)
end

if _G.CleanupOtherUIs then
    cleanupOtherUIs()
    
    spawn(function()
        while true do
            wait(1)
            cleanupOtherUIs()
        end
    end)
end

local LogoFrame = Instance.new("Frame")
LogoFrame.Parent = ScreenGui
LogoFrame.BackgroundTransparency = 1
LogoFrame.Size = UDim2.new(0, 600, 0, 180)
LogoFrame.Position = UDim2.new(0.5, -300, 0.5, -90)
LogoFrame.ZIndex = 10
LogoFrame.Visible = _G.Disable3DRender

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = LogoFrame
MainTitle.BackgroundTransparency = 1
MainTitle.Size = UDim2.new(1, 0, 0.4, 0)
MainTitle.Position = UDim2.new(0, 0, 0, 0)
MainTitle.Text = "Lucky Arrows: 0"
MainTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
MainTitle.TextScaled = true
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextStrokeTransparency = 0
MainTitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.ZIndex = 11

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = LogoFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Size = UDim2.new(1, 0, 0.20, 0)
SubTitle.Position = UDim2.new(0, 0, 0.45, 0)
SubTitle.Text = "Your Bizarre Adventure"
SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.ZIndex = 11

local MoneyLabel = Instance.new("TextLabel")
MoneyLabel.Parent = LogoFrame
MoneyLabel.BackgroundTransparency = 1
MoneyLabel.Size = UDim2.new(1, 0, 0.20, 0)
MoneyLabel.Position = UDim2.new(0, 0, 0.65, 0)
MoneyLabel.Text = "Money: Loading..."
MoneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MoneyLabel.Font = Enum.Font.Gotham
MoneyLabel.TextScaled = true
MoneyLabel.ZIndex = 11

local HopTimerLabel = Instance.new("TextLabel")
HopTimerLabel.Parent = LogoFrame
HopTimerLabel.BackgroundTransparency = 1
HopTimerLabel.Size = UDim2.new(1, 0, 0.20, 0)
HopTimerLabel.Position = UDim2.new(0, 0, 0.90, 0)
HopTimerLabel.Text = "Forced Hop: Disabled"
HopTimerLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
HopTimerLabel.Font = Enum.Font.GothamBold
HopTimerLabel.TextScaled = true
HopTimerLabel.ZIndex = 11
HopTimerLabel.Visible = true

local RenderButton = Instance.new("TextButton")
RenderButton.Parent = ScreenGui
RenderButton.Size = UDim2.new(0, 80, 0, 80)
RenderButton.Position = UDim2.new(0, 50, 0.5, -40)
RenderButton.BackgroundColor3 = _G.Disable3DRender and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(0, 150, 0)
RenderButton.BorderSizePixel = 2
RenderButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
RenderButton.Text = _G.Disable3DRender and "3D\nOFF" or "3D\nON"
RenderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RenderButton.TextScaled = true
RenderButton.Font = Enum.Font.GothamBold
RenderButton.ZIndex = 12

local isUIVisible = _G.Disable3DRender
RenderButton.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    
    if isUIVisible then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
        BlackFrame.Visible = true
        LogoFrame.Visible = true
        RenderButton.Text = "3D\nOFF"
        RenderButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    else
        game:GetService("RunService"):Set3dRenderingEnabled(true)
        BlackFrame.Visible = false
        LogoFrame.Visible = false
        RenderButton.Text = "3D\nON"
        RenderButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

task.spawn(function()
    while true do
        local success, err = pcall(function()
            local luckyCount = CountLuckyArrows()
            MainTitle.Text = "Lucky Arrows: " .. tostring(luckyCount)
            
            if Player.PlayerStats and Player.PlayerStats.Money then
                local currentMoney = Player.PlayerStats.Money.Value or 0
                MoneyLabel.Text = "Money: $" .. tostring(currentMoney)
            end
        end)
        
        if not success then
            MoneyLabel.Text = "Money: Error"
        end
        
        wait(1)
    end
end)

task.spawn(function()
    while true do
        if _G.ForcedHopEnable then
            for i = _G.HopWaitTime, 0, -1 do
                if not _G.ForcedHopEnable then break end
                
                local minutes = math.floor(i / 60)
                local seconds = i % 60
                HopTimerLabel.Text = string.format("Forced Hop in: %02d:%02d", minutes, seconds)
                HopTimerLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                
                wait(1)
            end
        else
            HopTimerLabel.Text = "Forced Hop: Disabled"
            HopTimerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            wait(1)
        end
    end
end)

game:GetService("CoreGui").DescendantAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        local GrabError = child:FindFirstChild("ErrorMessage", true)
        repeat task.wait() until GrabError.Text ~= "Label"
        local Reason = GrabError.Text
        if Reason:match("kick") or Reason:match("You") or Reason:match("conn") or Reason:match("rejoin") then
            game:GetService("TeleportService"):Teleport(2809202155, Player)
        end
    end
end)

local Has2x = MarketplaceService:UserOwnsGamePassAsync(Player.UserId, 14597778)

local oldMagnitude
oldMagnitude = hookmetamethod(Vector3.new(), "__index", newcclosure(function(self, index)
    local CallingScript = tostring(getcallingscript())
    if not checkcaller() and index == "magnitude" and CallingScript == "ItemSpawn" then
        return 0
    end
    return oldMagnitude(self, index)
end))

local ItemSpawnFolder = Workspace:WaitForChild("Item_Spawns"):WaitForChild("Items")

local function GetCharacter(Part)
    if Player.Character then
        if not Part then
            return Player.Character
        elseif typeof(Part) == "string" then
            return Player.Character:FindFirstChild(Part) or nil
        end
    end
    return nil
end

local function TeleportTo(Position)
    local HumanoidRootPart = GetCharacter("HumanoidRootPart")
    if HumanoidRootPart then
        local PositionType = typeof(Position)
        if PositionType == "CFrame" then
            HumanoidRootPart.CFrame = Position
        end
    end
end

local function ToggleNoclip(Value)
    local Character = GetCharacter()
    if Character then
        for _, Child in pairs(Character:GetDescendants()) do
            if Child:IsA("BasePart") and Child.CanCollide == not Value then
                Child.CanCollide = Value
            end
        end
    end
end

local MaxItemAmounts = {
    ["Gold Coin"] = 45,
    ["Rokakaka"] = 25,
    ["Pure Rokakaka"] = 10,
    ["Mysterious Arrow"] = 25,
    ["Diamond"] = 30,
    ["Ancient Scroll"] = 10,
    ["Caesar's Headband"] = 10,
    ["Stone Mask"] = 10,
    ["Rib Cage of The Saint's Corpse"] = 20,
    ["Quinton's Glove"] = 10,
    ["Zeppeli's Hat"] = 10,
    ["Lucky Arrow"] = 15,
    ["Lucky Stone Mask"] = 10,
    ["Clackers"] = 10,
    ["Steel Ball"] = 10,
    ["Dio's Diary"] = 10,
    ["Green Candy"] = 45,
    ["Red Candy"] = 45,
    ["Blue Candy"] = 45,
    ["Yellow Candy"] = 45
}

if Has2x then
    for Index, Max in pairs(MaxItemAmounts) do
        MaxItemAmounts[Index] = Max * 2
    end
end

local function HasMaxItem(Item)
    local Count = 0
    for _, Tool in pairs(Player.Backpack:GetChildren()) do
        if Tool.Name == Item then
            Count += 1
        end
    end
    if MaxItemAmounts[Item] then
        return Count >= MaxItemAmounts[Item]
    else
        return false
    end
end

local function HasLuckyArrows()
    local Count = 0
    for _, Tool in pairs(Player.Backpack:GetChildren()) do
        if Tool.Name == "Lucky Arrow" then
            Count += 1
        end
    end
    return Count >= 9
end

local function IsPriorityItem(ItemName)
    for _, PriorityName in pairs(PriorityItems) do
        if ItemName == PriorityName then
            return true
        end
    end
    return false
end

local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/rinqedd/pub_rblx/main/ServerHop", true))

local function GetItemInfo(Model)
    if Model and Model:IsA("Model") and Model.Parent and Model.Parent.Name == "Items" then
        local PrimaryPart = Model.PrimaryPart
        if not PrimaryPart then return nil end
        local Position = PrimaryPart.Position
        local ProximityPrompt
        for _, ItemInstance in pairs(Model:GetChildren()) do
            if ItemInstance:IsA("ProximityPrompt") and ItemInstance.MaxActivationDistance == 8 then
                ProximityPrompt = ItemInstance
            end
        end
        if ProximityPrompt then
            return {
                ["Name"] = ProximityPrompt.ObjectText,
                ["ProximityPrompt"] = ProximityPrompt,
                ["Position"] = Position,
                ["IsPriority"] = IsPriorityItem(ProximityPrompt.ObjectText)
            }
        end
    end
    return nil
end

getgenv().SpawnedItems = {}

ItemSpawnFolder.ChildAdded:Connect(function(Model)
    task.wait(1)
    if Model:IsA("Model") then
        local ItemInfo = GetItemInfo(Model)
        if ItemInfo then
            table.insert(getgenv().SpawnedItems, ItemInfo)
        end
    end
end)

local UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe = "  ___XP DE KEY"

local oldNc
oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    if not checkcaller() and rawequal(self.Name, "Returner") and rawequal(Args[1], "idklolbrah2de") then
        return UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe
    end
    return oldNc(self, ...)
end))

task.wait(1)

if not PlayerGui:FindFirstChild("HUD") then
    local HUD = ReplicatedStorage.Objects.HUD:Clone()
    HUD.Parent = PlayerGui
end

task.spawn(function()
    pcall(function()
        PlayerGui:WaitForChild("LoadingScreen1"):Destroy()
    end)
    task.wait(.5)
    pcall(function()
        PlayerGui:WaitForChild("LoadingScreen"):Destroy()
    end)
    pcall(function()
        workspace.LoadingScreen.Song:Destroy()
    end)
end)

repeat task.wait() until GetCharacter() and GetCharacter("RemoteEvent")

task.spawn(function()
    pcall(function()
        while wait(.1) do
            GetCharacter("RemoteEvent"):FireServer("PressedPlay")
        end
    end)
end)

TeleportTo(CFrame.new(978, -42, -49))

task.wait(5)

local function SortItems()
    table.sort(getgenv().SpawnedItems, function(a, b)
        if a.IsPriority and not b.IsPriority then
            return true
        elseif not a.IsPriority and b.IsPriority then
            return false
        else
            return false
        end
    end)
end

task.spawn(function()
    while wait(_G.HopWaitTime) do
        if _G.ForcedHopEnable then
            while wait(5) do
                local success = pcall(function()
                    Teleport()
                end)
                
                if success then
                    break
                end
            end
        end
    end
end)

while true do
    local Money = Player.PlayerStats.Money
    if Money.Value >= 1000000 then
        MoneyLabel.Text = "Money: $" .. tostring(Money.Value) .. " - STOPPED"
        break
    end
    
    if #getgenv().SpawnedItems > 0 then
        SortItems()
        
        for Index = #getgenv().SpawnedItems, 1, -1 do
            local ItemInfo = getgenv().SpawnedItems[Index]
            local HumanoidRootPart = GetCharacter("HumanoidRootPart")
            
            if HumanoidRootPart and ItemInfo then
                local Name = ItemInfo.Name
                local HasMax = HasMaxItem(Name)
                
                if not HasMax then
                    local ProximityPrompt = ItemInfo.ProximityPrompt
                    local Position = ItemInfo.Position
                    
                    if ProximityPrompt and ProximityPrompt.Parent then
                        table.remove(getgenv().SpawnedItems, Index)
                        
                        local BodyVelocity = Instance.new("BodyVelocity")
                        BodyVelocity.Parent = HumanoidRootPart
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                        
                        ToggleNoclip(true)
                        TeleportTo(CFrame.new(Position.X, Position.Y - 12, Position.Z))
                        task.wait(.5)
                        
                        pcall(function()
                            fireproximityprompt(ProximityPrompt)
                        end)
                        
                        task.wait(.5)
                        BodyVelocity:Destroy()
                        ToggleNoclip(false)
                        TeleportTo(CFrame.new(978, -42, -49))
                    else
                        table.remove(getgenv().SpawnedItems, Index)
                    end
                else
                    table.remove(getgenv().SpawnedItems, Index)
                end
            end
        end
    end
    
    if #getgenv().SpawnedItems == 0 then
        local Money = Player.PlayerStats.Money
        
        if AutoSell then
            for Item, Sell in pairs(SellItems) do
                if Sell and Player.Backpack and Player.Backpack:FindFirstChild(Item) then
                    local Character = GetCharacter()
                    if Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("RemoteEvent") then
                        Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild(Item))
                        task.wait(.1)
                        Character.RemoteEvent:FireServer("EndDialogue", {
                            ["NPC"] = "Merchant",
                            ["Dialogue"] = "Dialogue5",
                            ["Option"] = "Option2"
                        })
                        task.wait(.2)
                    end
                end
            end
        end
        
        local Money = Player.PlayerStats.Money
        
        if BuyLucky and not HasLuckyArrows() then
            while Money.Value >= 75000 do
                local Character = GetCharacter()
                if Character and Character:FindFirstChild("RemoteEvent") then
                    Character.RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Lucky Arrow"})
                    task.wait(.1)
                else
                    break
                end
            end
        end
        
        if Hop and #getgenv().SpawnedItems == 0 then
            local ShouldHop = true
            if BuyLucky and not HasLuckyArrows() and Money.Value >= 50000 then
                ShouldHop = false
            end
            
            if ShouldHop then
                pcall(function()
                    Teleport()
                end)
                task.wait(3)
            else
                task.wait(5)
            end
        else
            task.wait(5)
        end
    else
        task.wait(1)
    end
end
