-- Configuration
local WEBHOOK_URL = "https://discord.com/api/webhooks/1285595386529976364/pIk2UzKRgIOGg3jHql6HkxG7NEdJUN1YG2dk7W5xPCQqH3PWUHySxcnb2jv2XrlTD9my"
local MIN_GENERATION = 100

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Data
local BrainrotData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Brainrots"))
local Synchronizer = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Synchronizer"))

-- State
local notifiedPets = {}
local activeConnections = {}

-- Webhook function using request (client-side)
local function sendWebhook(player, petName, generation, mutation)
    local playerCount = #Players:GetPlayers()
    local jobId = game.JobId
    local placeId = game.PlaceId

    local mutationText = mutation and (" (" .. mutation .. ")") or ""
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🔥 High Generation Pet Detected!",
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "👤 Player",
                    ["value"] = "`" .. player.Name .. "` (ID: " .. player.UserId .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "🐾 Pet Name",
                    ["value"] = "**" .. petName .. mutationText .. "**",
                    ["inline"] = true
                },
                {
                    ["name"] = "⚡ Generation",
                    ["value"] = "**" .. tostring(generation) .. "**",
                    ["inline"] = false
                },
                {
                    ["name"] = "🌐 Server Info",
                    ["value"] = string.format("`%d/8` players", playerCount),
                    ["inline"] = true
                },
                {
                    ["name"] = "🆔 Job ID",
                    ["value"] = "```" .. jobId .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "📜 Join Script",
                    ["value"] = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(" .. placeId .. ", '" .. jobId .. "', game.Players.LocalPlayer)\n```",
                    ["inline"] = false
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S"),
            ["footer"] = {
                ["text"] = "Brainrot Scanner v1.0"
            }
        }}
    }

    local success, err = pcall(function()
        local response = request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })
        
        if response.StatusCode ~= 204 then
            warn("Webhook failed with status:", response.StatusCode)
        end
    end)
    
    if not success then
        warn("Failed to send webhook:", err)
    end
end

-- Check single pet
local function checkPet(pet, owner)
    if type(pet) ~= "table" or not pet.Index or pet.Index == "Empty" then
        return
    end

    local petInfo = BrainrotData[pet.Index]
    
    if not petInfo or not petInfo.Generation then
        return
    end

    local generation = petInfo.Generation
    local uniqueKey = owner.UserId .. "-" .. (pet.UUID or pet.Index)
    
    -- Check if meets generation requirement and not already notified
    if generation >= MIN_GENERATION and not notifiedPets[uniqueKey] then
        notifiedPets[uniqueKey] = true
        print(string.format("[Scanner] Found: %s (Gen: %d) - Owner: %s", 
            pet.Index, generation, owner.Name))
        sendWebhook(owner, pet.Index, generation, pet.Mutation)
    end
end

-- Check all pets for a player
local function checkPlayerPets(channelData)
    if not channelData.CacheTable then
        return
    end
    
    local animalList = channelData.CacheTable.AnimalList
    local owner = channelData.CacheTable.Owner
    
    if not animalList or not owner then
        return
    end

    for _, pet in ipairs(animalList) do
        checkPet(pet, owner)
    end
end

-- Monitor a channel for changes
local function monitorChannel(channel)
    local channelId = channel.Index
    
    -- Skip if already monitoring
    if activeConnections[channelId] then
        return
    end

    -- Initial scan
    checkPlayerPets(channel)
    
    -- Monitor AnimalList changes
    if channel.Signals and channel.Signals.Changed and channel.Signals.Changed.AnimalList then
        local connection = channel.Signals.Changed.AnimalList:Connect(function()
            task.wait(0.5) -- Small delay to ensure data is updated
            checkPlayerPets(channel)
        end)
        
        activeConnections[channelId] = connection
        print("[Scanner] Monitoring channel:", channelId)
    end
end

-- Initial scan of all existing channels
local function scanExistingChannels()
    local allChannels = Synchronizer:GetAllChannels()
    
    for channelId, channelData in pairs(allChannels) do
        if channelData.CacheTable and channelData.CacheTable.Owner then
            monitorChannel(channelData)
        end
    end
    
    print("[Scanner] Scanned", #allChannels, "existing channels")
end

-- Monitor for new channels (new players joining)
local function setupChannelMonitoring()
    if Synchronizer.OnChannelCreated then
        Synchronizer.OnChannelCreated:Connect(function(channel)
            print("[Scanner] New channel created:", channel.Index)
            task.wait(1) -- Wait for data to populate
            monitorChannel(channel)
        end)
    end
end

-- Cleanup on player leave
local function setupCleanup()
    Players.PlayerRemoving:Connect(function(player)
        local channelId = tostring(player.UserId)
        if activeConnections[channelId] then
            activeConnections[channelId]:Disconnect()
            activeConnections[channelId] = nil
            print("[Scanner] Stopped monitoring:", player.Name)
        end
    end)
end

-- Periodic rescan as backup (every 30 seconds)
local function startPeriodicScan()
    task.spawn(function()
        while task.wait(30) do
            scanExistingChannels()
        end
    end)
end

-- Main initialization
print("[Scanner] Starting Brainrot Scanner...")
print("[Scanner] Min Generation:", MIN_GENERATION)

-- Wait for game to fully load
task.wait(5)

-- Setup monitoring
setupChannelMonitoring()
setupCleanup()

-- Initial scan
scanExistingChannels()

-- Start periodic backup scan
startPeriodicScan()

print("[Scanner] Scanner active and monitoring!")
