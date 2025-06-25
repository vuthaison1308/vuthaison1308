local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera
-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrainToFightGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Frame chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 460) -- Giữ nguyên height để chứa tính năng mới
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Train To Fight - By Theaug"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -50, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = TitleBar

-- Container cho người chơi
local PlayersScrollFrame = Instance.new("ScrollingFrame")
PlayersScrollFrame.Name = "PlayersScrollFrame"
PlayersScrollFrame.Size = UDim2.new(1, -10, 0, 160) -- Giữ nguyên kích thước
PlayersScrollFrame.Position = UDim2.new(0, 5, 0, 30)
PlayersScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayersScrollFrame.BorderSizePixel = 0
PlayersScrollFrame.ScrollBarThickness = 6
PlayersScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
PlayersScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayersScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayersScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = PlayersScrollFrame

-- Auto Teleport Settings
local AutoTeleportFrame = Instance.new("Frame")
AutoTeleportFrame.Name = "AutoTeleportFrame"
AutoTeleportFrame.Size = UDim2.new(1, -10, 0, 40)
AutoTeleportFrame.Position = UDim2.new(0, 5, 0, 195)
AutoTeleportFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoTeleportFrame.BorderSizePixel = 0
AutoTeleportFrame.Parent = MainFrame

local AutoTeleportLabel = Instance.new("TextLabel")
AutoTeleportLabel.Name = "AutoTeleportLabel"
AutoTeleportLabel.Size = UDim2.new(0.6, 0, 1, 0)
AutoTeleportLabel.BackgroundTransparency = 1
AutoTeleportLabel.Text = "Auto Teleport:"
AutoTeleportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTeleportLabel.TextSize = 14
AutoTeleportLabel.Font = Enum.Font.SourceSans
AutoTeleportLabel.Parent = AutoTeleportFrame

local AutoTeleportButton = Instance.new("TextButton")
AutoTeleportButton.Name = "AutoTeleportButton"
AutoTeleportButton.Size = UDim2.new(0.4, -5, 1, -10)
AutoTeleportButton.Position = UDim2.new(0.6, 0, 0, 5)
AutoTeleportButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
AutoTeleportButton.Text = "OFF"
AutoTeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTeleportButton.TextSize = 14
AutoTeleportButton.Font = Enum.Font.SourceSansBold
AutoTeleportButton.Parent = AutoTeleportFrame

-- Auto Teleport Nearest Player Settings
local AutoTeleportNearestFrame = Instance.new("Frame")
AutoTeleportNearestFrame.Name = "AutoTeleportNearestFrame"
AutoTeleportNearestFrame.Size = UDim2.new(1, -10, 0, 40)
AutoTeleportNearestFrame.Position = UDim2.new(0, 5, 0, 240)
AutoTeleportNearestFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoTeleportNearestFrame.BorderSizePixel = 0
AutoTeleportNearestFrame.Parent = MainFrame

local AutoTeleportNearestLabel = Instance.new("TextLabel")
AutoTeleportNearestLabel.Name = "AutoTeleportNearestLabel"
AutoTeleportNearestLabel.Size = UDim2.new(0.6, 0, 1, 0)
AutoTeleportNearestLabel.BackgroundTransparency = 1
AutoTeleportNearestLabel.Text = "Auto TP Nearest:"
AutoTeleportNearestLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTeleportNearestLabel.TextSize = 14
AutoTeleportNearestLabel.Font = Enum.Font.SourceSans
AutoTeleportNearestLabel.Parent = AutoTeleportNearestFrame

local AutoTeleportNearestButton = Instance.new("TextButton")
AutoTeleportNearestButton.Name = "AutoTeleportNearestButton"
AutoTeleportNearestButton.Size = UDim2.new(0.4, -5, 1, -10)
AutoTeleportNearestButton.Position = UDim2.new(0.6, 0, 0, 5)
AutoTeleportNearestButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
AutoTeleportNearestButton.Text = "OFF"
AutoTeleportNearestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTeleportNearestButton.TextSize = 14
AutoTeleportNearestButton.Font = Enum.Font.SourceSansBold
AutoTeleportNearestButton.Parent = AutoTeleportNearestFrame

-- Teleport Distance Settings
local TeleportDistanceFrame = Instance.new("Frame")
TeleportDistanceFrame.Name = "TeleportDistanceFrame"
TeleportDistanceFrame.Size = UDim2.new(1, -10, 0, 40)
TeleportDistanceFrame.Position = UDim2.new(0, 5, 0, 285)
TeleportDistanceFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TeleportDistanceFrame.BorderSizePixel = 0
TeleportDistanceFrame.Parent = MainFrame

local TeleportDistanceLabel = Instance.new("TextLabel")
TeleportDistanceLabel.Name = "TeleportDistanceLabel"
TeleportDistanceLabel.Size = UDim2.new(1, 0, 0, 20)
TeleportDistanceLabel.BackgroundTransparency = 1
TeleportDistanceLabel.Text = "Teleport Distance: 5"
TeleportDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportDistanceLabel.TextSize = 14
TeleportDistanceLabel.Font = Enum.Font.SourceSans
TeleportDistanceLabel.Parent = TeleportDistanceFrame

local TeleportDistanceMinus = Instance.new("TextButton")
TeleportDistanceMinus.Name = "Minus"
TeleportDistanceMinus.Size = UDim2.new(0, 30, 0, 20)
TeleportDistanceMinus.Position = UDim2.new(0, 0, 0, 20)
TeleportDistanceMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TeleportDistanceMinus.Text = "-"
TeleportDistanceMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportDistanceMinus.TextSize = 16
TeleportDistanceMinus.Font = Enum.Font.SourceSansBold
TeleportDistanceMinus.Parent = TeleportDistanceFrame

local TeleportDistanceValue = Instance.new("TextLabel")
TeleportDistanceValue.Name = "Value"
TeleportDistanceValue.Size = UDim2.new(1, -60, 0, 20)
TeleportDistanceValue.Position = UDim2.new(0, 30, 0, 20)
TeleportDistanceValue.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TeleportDistanceValue.Text = "5"
TeleportDistanceValue.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportDistanceValue.TextSize = 14
TeleportDistanceValue.Font = Enum.Font.SourceSans
TeleportDistanceValue.Parent = TeleportDistanceFrame

local TeleportDistancePlus = Instance.new("TextButton")
TeleportDistancePlus.Name = "Plus"
TeleportDistancePlus.Size = UDim2.new(0, 30, 0, 20)
TeleportDistancePlus.Position = UDim2.new(1, -30, 0, 20)
TeleportDistancePlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TeleportDistancePlus.Text = "+"
TeleportDistancePlus.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportDistancePlus.TextSize = 16
TeleportDistancePlus.Font = Enum.Font.SourceSansBold
TeleportDistancePlus.Parent = TeleportDistanceFrame

-- WalkSpeed Settings (đã sửa đổi)
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Size = UDim2.new(1, -10, 0, 40) -- Đã giảm chiều cao vì bỏ nút update
WalkSpeedFrame.Position = UDim2.new(0, 5, 0, 330)
WalkSpeedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
WalkSpeedFrame.BorderSizePixel = 0
WalkSpeedFrame.Parent = MainFrame

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Name = "WalkSpeedLabel"
WalkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "WalkSpeed: Default"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.Font = Enum.Font.SourceSans
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedMinus = Instance.new("TextButton")
WalkSpeedMinus.Name = "Minus"
WalkSpeedMinus.Size = UDim2.new(0, 30, 0, 20)
WalkSpeedMinus.Position = UDim2.new(0, 0, 0, 20)
WalkSpeedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WalkSpeedMinus.Text = "-"
WalkSpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedMinus.TextSize = 16
WalkSpeedMinus.Font = Enum.Font.SourceSansBold
WalkSpeedMinus.Parent = WalkSpeedFrame

local WalkSpeedValue = Instance.new("TextLabel")
WalkSpeedValue.Name = "Value"
WalkSpeedValue.Size = UDim2.new(1, -60, 0, 20)
WalkSpeedValue.Position = UDim2.new(0, 30, 0, 20)
WalkSpeedValue.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
WalkSpeedValue.Text = "Default"
WalkSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedValue.TextSize = 14
WalkSpeedValue.Font = Enum.Font.SourceSans
WalkSpeedValue.Parent = WalkSpeedFrame

local WalkSpeedPlus = Instance.new("TextButton")
WalkSpeedPlus.Name = "Plus"
WalkSpeedPlus.Size = UDim2.new(0, 30, 0, 20)
WalkSpeedPlus.Position = UDim2.new(1, -30, 0, 20)
WalkSpeedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WalkSpeedPlus.Text = "+"
WalkSpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedPlus.TextSize = 16
WalkSpeedPlus.Font = Enum.Font.SourceSansBold
WalkSpeedPlus.Parent = WalkSpeedFrame

-- NEW: Auto Click Settings
local AutoClickFrame = Instance.new("Frame")
AutoClickFrame.Name = "AutoClickFrame"
AutoClickFrame.Size = UDim2.new(1, -10, 0, 40)
AutoClickFrame.Position = UDim2.new(0, 5, 0, 375) -- Vị trí mới dưới WalkSpeedFrame
AutoClickFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoClickFrame.BorderSizePixel = 0
AutoClickFrame.Parent = MainFrame

local AutoClickLabel = Instance.new("TextLabel")
AutoClickLabel.Name = "AutoClickLabel"
AutoClickLabel.Size = UDim2.new(0.6, 0, 1, 0)
AutoClickLabel.BackgroundTransparency = 1
AutoClickLabel.Text = "Auto Click:"
AutoClickLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickLabel.TextSize = 14
AutoClickLabel.Font = Enum.Font.SourceSans
AutoClickLabel.Parent = AutoClickFrame

local AutoClickButton = Instance.new("TextButton")
AutoClickButton.Name = "AutoClickButton"
AutoClickButton.Size = UDim2.new(0.4, -5, 1, -10)
AutoClickButton.Position = UDim2.new(0.6, 0, 0, 5)
AutoClickButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
AutoClickButton.Text = "OFF"
AutoClickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickButton.TextSize = 14
AutoClickButton.Font = Enum.Font.SourceSansBold
AutoClickButton.Parent = AutoClickFrame

-- Current Target Display
local CurrentTargetFrame = Instance.new("Frame")
CurrentTargetFrame.Name = "CurrentTargetFrame"
CurrentTargetFrame.Size = UDim2.new(1, -10, 0, 40)
CurrentTargetFrame.Position = UDim2.new(0, 5, 0, 420) -- Điều chỉnh vị trí xuống dưới AutoClickFrame
CurrentTargetFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CurrentTargetFrame.BorderSizePixel = 0
CurrentTargetFrame.Parent = MainFrame

local CurrentTargetLabel = Instance.new("TextLabel")
CurrentTargetLabel.Name = "CurrentTargetLabel"
CurrentTargetLabel.Size = UDim2.new(0.3, 0, 1, 0)
CurrentTargetLabel.BackgroundTransparency = 1
CurrentTargetLabel.Text = "Target:"
CurrentTargetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentTargetLabel.TextSize = 14
CurrentTargetLabel.Font = Enum.Font.SourceSans
CurrentTargetLabel.Parent = CurrentTargetFrame

local CurrentTargetValue = Instance.new("TextLabel")
CurrentTargetValue.Name = "Value"
CurrentTargetValue.Size = UDim2.new(0.7, 0, 1, 0)
CurrentTargetValue.Position = UDim2.new(0.3, 0, 0, 0)
CurrentTargetValue.BackgroundTransparency = 1
CurrentTargetValue.Text = "None"
CurrentTargetValue.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentTargetValue.TextSize = 14
CurrentTargetValue.Font = Enum.Font.SourceSans
CurrentTargetValue.Parent = CurrentTargetFrame

-- Minimize state
local isMinimized = false
local originalFrameSize = MainFrame.Size

-- Variables
local teleportDistance = 5
local defaultWalkSpeed = 16 -- Sẽ được thay thế bằng giá trị mặc định thực tế của game
local walkSpeed = defaultWalkSpeed
local isAutoTeleportEnabled = false
local isAutoTeleportNearestEnabled = false
local isAutoClickEnabled = false -- Biến mới cho auto click
local selectedPlayer = nil
local teleportConnection = nil
local nearestTeleportConnection = nil
local autoClickConnection = nil -- Connection mới cho auto click

-- Functions
local function updateTeleportDistanceLabel()
    TeleportDistanceLabel.Text = "Teleport Distance: " .. teleportDistance
    TeleportDistanceValue.Text = tostring(teleportDistance)
end

local function updateWalkSpeedLabel()
    if walkSpeed == defaultWalkSpeed then
        WalkSpeedLabel.Text = "WalkSpeed: Default"
        WalkSpeedValue.Text = "Default"
    else
        WalkSpeedLabel.Text = "WalkSpeed: " .. walkSpeed
        WalkSpeedValue.Text = tostring(walkSpeed)
    end
end

local function updateCurrentTargetLabel()
    if selectedPlayer then
        CurrentTargetValue.Text = selectedPlayer.Name
    else
        CurrentTargetValue.Text = "None"
    end
end

-- Function to get default walkspeed
local function getDefaultWalkSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character.Humanoid.WalkSpeed
    end
    return 16 -- Fallback nếu không tìm thấy
end

-- Lấy giá trị walkspeed mặc định khi script bắt đầu
local function initializeDefaultWalkSpeed()
    defaultWalkSpeed = getDefaultWalkSpeed()
    walkSpeed = defaultWalkSpeed
    updateWalkSpeedLabel()
end

-- Find nearest player function
local function findNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = math.huge
    
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local myPosition = LocalPlayer.Character.HumanoidRootPart.Position
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health ~= 0 then
            local distance = (myPosition - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    return nearestPlayer
end

-- Teleport to player function
local function teleportBehindPlayer(player)
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local targetHRP = player.Character.HumanoidRootPart
    
    -- Teleport sau lưng người chơi với khoảng cách đã chọn
    local lookVector = targetHRP.CFrame.LookVector
    local teleportPosition = targetHRP.Position - (lookVector * teleportDistance)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        -- Giữ hướng nhìn về phía người chơi mục tiêu
        local lookAt = CFrame.new(teleportPosition, targetHRP.Position)
        LocalPlayer.Character.HumanoidRootPart.CFrame = lookAt
    end
end

-- Start Auto Teleport
local function startAutoTeleport()
    if teleportConnection then
        teleportConnection:Disconnect()
    end
    
    if not selectedPlayer then
        return
    end
    
    teleportConnection = RunService.Heartbeat:Connect(function()
        teleportBehindPlayer(selectedPlayer)
    end)
end

-- Stop Auto Teleport
local function stopAutoTeleport()
    if teleportConnection then
        teleportConnection:Disconnect()
        teleportConnection = nil
    end
end

-- Toggle Auto Teleport
local function toggleAutoTeleport()
    isAutoTeleportEnabled = not isAutoTeleportEnabled
    
    if isAutoTeleportEnabled then
        -- Turn off auto teleport nearest if it was enabled
        if isAutoTeleportNearestEnabled then
            isAutoTeleportNearestEnabled = false
            AutoTeleportNearestButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            AutoTeleportNearestButton.Text = "OFF"
            if nearestTeleportConnection then
                nearestTeleportConnection:Disconnect()
                nearestTeleportConnection = nil
            end
        end
        
        AutoTeleportButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        AutoTeleportButton.Text = "ON"
        startAutoTeleport()
    else
        AutoTeleportButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        AutoTeleportButton.Text = "OFF"
        stopAutoTeleport()
    end
end

-- Start Auto Teleport Nearest
local function startAutoTeleportNearest()
    if nearestTeleportConnection then
        nearestTeleportConnection:Disconnect()
    end
    
    nearestTeleportConnection = RunService.Heartbeat:Connect(function()
        local nearest = findNearestPlayer()
        if nearest then
            selectedPlayer = nearest
            updateCurrentTargetLabel()
            teleportBehindPlayer(nearest)
        end
    end)
end

-- Stop Auto Teleport Nearest
local function stopAutoTeleportNearest()
    if nearestTeleportConnection then
        nearestTeleportConnection:Disconnect()
        nearestTeleportConnection = nil
    end
end

-- Toggle Auto Teleport Nearest
local function toggleAutoTeleportNearest()
    isAutoTeleportNearestEnabled = not isAutoTeleportNearestEnabled
    
    if isAutoTeleportNearestEnabled then
        -- Turn off regular auto teleport if it was enabled
        if isAutoTeleportEnabled then
            isAutoTeleportEnabled = false
            AutoTeleportButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            AutoTeleportButton.Text = "OFF"
            stopAutoTeleport()
        end
        
        AutoTeleportNearestButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        AutoTeleportNearestButton.Text = "ON"
        startAutoTeleportNearest()
    else
        AutoTeleportNearestButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        AutoTeleportNearestButton.Text = "OFF"
        stopAutoTeleportNearest()
    end
end

-- NEW: Auto Click Functions
local function simulateMouseClick()
    -- Lấy kích thước màn hình
    local screenSize = cam.ViewportSize
    local centerX = screenSize.X / 2
    local centerY = screenSize.Y / 2
    
    -- Click xuống tại điểm chính giữa màn hình
    VIM:SendMouseButtonEvent(
        centerX,
        centerY,
        0, -- Nút chuột trái
        true, -- Bấm xuống
        nil,
        0
    )
    
    -- Nhấc nút chuột lên sau một khoảng thời gian ngắn
    task.wait(0.05)
    
    VIM:SendMouseButtonEvent(
        centerX,
        centerY,
        0, -- Nút chuột trái
        false, -- Nhấc lên
        nil,
        0
    )
end

-- NEW: Start Auto Click
local function startAutoClick()
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
    
    -- Sử dụng spawn thay vì Heartbeat để không block luồng chính
    autoClickConnection = task.spawn(function()
        while isAutoClickEnabled do
            simulateMouseClick()
            -- Đợi 1 giây giữa các lần click
            task.wait(0.25)
        end
    end)
end

-- NEW: Stop Auto Click
local function stopAutoClick()
    if autoClickConnection then
        task.cancel(autoClickConnection)
        autoClickConnection = nil
    end
end

-- NEW: Toggle Auto Click
local function toggleAutoClick()
    isAutoClickEnabled = not isAutoClickEnabled
    
    if isAutoClickEnabled then
        AutoClickButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        AutoClickButton.Text = "ON"
        startAutoClick()
    else
        AutoClickButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        AutoClickButton.Text = "OFF"
        stopAutoClick()
    end
end

-- Create player button
local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Name = player.Name
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = player.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.SourceSans
    button.Parent = PlayersScrollFrame
    
    button.MouseButton1Click:Connect(function()
        -- Highlight selected player
        for _, otherButton in pairs(PlayersScrollFrame:GetChildren()) do
            if otherButton:IsA("TextButton") then
                otherButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
        end
        button.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        
        -- Set selected player
        selectedPlayer = player
        updateCurrentTargetLabel()
        
        -- Single teleport
        teleportBehindPlayer(player)
        
        -- Update auto teleport if enabled
        if isAutoTeleportEnabled then
            stopAutoTeleport()
            startAutoTeleport()
        end
    end)
end

-- Make GUI draggable
local isDragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) and isDragging then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        updateDrag(input)
    end
end)

-- Event handlers
CloseButton.MouseButton1Click:Connect(function()
    stopAutoTeleport()
    stopAutoTeleportNearest()
    stopAutoClick() -- Thêm: đảm bảo dừng auto click khi đóng GUI
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame.Size = originalFrameSize
        MinimizeButton.Text = "-"
        PlayersScrollFrame.Visible = true
        AutoTeleportFrame.Visible = true
        AutoTeleportNearestFrame.Visible = true
        TeleportDistanceFrame.Visible = true
        WalkSpeedFrame.Visible = true
        AutoClickFrame.Visible = true -- Thêm mới
        CurrentTargetFrame.Visible = true
    else
        originalFrameSize = MainFrame.Size
        MainFrame.Size = UDim2.new(0, 250, 0, 25)
        MinimizeButton.Text = "+"
        PlayersScrollFrame.Visible = false
        AutoTeleportFrame.Visible = false
        AutoTeleportNearestFrame.Visible = false
        TeleportDistanceFrame.Visible = false
        WalkSpeedFrame.Visible = false
        AutoClickFrame.Visible = false -- Thêm mới
        CurrentTargetFrame.Visible = false
    end
    
    isMinimized = not isMinimized
end)

AutoTeleportButton.MouseButton1Click:Connect(toggleAutoTeleport)
AutoTeleportNearestButton.MouseButton1Click:Connect(toggleAutoTeleportNearest)
AutoClickButton.MouseButton1Click:Connect(toggleAutoClick) -- Kết nối nút mới

TeleportDistanceMinus.MouseButton1Click:Connect(function()
    if teleportDistance > 1 then
        teleportDistance = teleportDistance - 1
        updateTeleportDistanceLabel()
    end
end)

TeleportDistancePlus.MouseButton1Click:Connect(function()
    if teleportDistance < 20 then
        teleportDistance = teleportDistance + 1
        updateTeleportDistanceLabel()
    end
end)

-- Chỉnh sửa các chức năng WalkSpeed để cập nhật ngay lập tức
WalkSpeedMinus.MouseButton1Click:Connect(function()
    if walkSpeed > defaultWalkSpeed - 10 then
        walkSpeed = walkSpeed - 5
        updateWalkSpeedLabel()
        
        -- Update WalkSpeed ngay lập tức
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    end
end)

WalkSpeedPlus.MouseButton1Click:Connect(function()
    if walkSpeed < 200 then
        walkSpeed = walkSpeed + 5
        updateWalkSpeedLabel()
        
        -- Update WalkSpeed ngay lập tức
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    end
end)

-- Populate player list
local function populatePlayerList()
    for _, button in pairs(PlayersScrollFrame:GetChildren()) do
        if button:IsA("TextButton") then
            button:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createPlayerButton(player)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local button = PlayersScrollFrame:FindFirstChild(player.Name)
    if button then
        button:Destroy()
    end
    
    -- Stop auto teleport if the selected player left
    if selectedPlayer and selectedPlayer == player then
        selectedPlayer = nil
        updateCurrentTargetLabel()
        
        if isAutoTeleportEnabled then
            stopAutoTeleport()
            isAutoTeleportEnabled = false
            AutoTeleportButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            AutoTeleportButton.Text = "OFF"
        end
    end
end)

-- Auto-update WalkSpeed khi character respawn
LocalPlayer.CharacterAdded:Connect(function(character)
    -- Tìm giá trị walkspeed mặc định của character mới
    local humanoid = character:WaitForChild("Humanoid")
    if humanoid then
        defaultWalkSpeed = humanoid.WalkSpeed
        
        -- Nếu đang set walkspeed tùy chỉnh, áp dụng cho character mới
        if walkSpeed ~= defaultWalkSpeed then
            humanoid.WalkSpeed = walkSpeed
        else
            walkSpeed = defaultWalkSpeed
        end
        
        updateWalkSpeedLabel()
    end
end)

-- Initialize
initializeDefaultWalkSpeed() -- Lấy giá trị walkspeed mặc định khi khởi động
populatePlayerList()
updateTeleportDistanceLabel()
updateCurrentTargetLabel()
