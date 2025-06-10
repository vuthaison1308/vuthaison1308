if getgenv().fpslock == nil then getgenv().fpslock = 60 end
if getgenv().whitescreen == nil then getgenv().whitescreen = false end

local sg = game:GetService("CoreGui")
local rs = game:GetService("RunService")

local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local fps = Instance.new("TextBox")
local ws = Instance.new("TextButton")

gui.Parent = sg
frame.Parent = gui
frame.Size = UDim2.new(0,120,0,60)
frame.Position = UDim2.new(0,10,0,100)
frame.BackgroundColor3 = Color3.new(0,0,0)
frame.BorderSizePixel = 0

fps.Parent = frame
fps.Size = UDim2.new(1,0,0.5,0)
fps.Position = UDim2.new(0,0,0,0)
fps.Text = tostring(getgenv().fpslock)
fps.PlaceholderText = "FPS Lock"
fps.TextColor3 = Color3.new(1,1,1)
fps.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
fps.BorderSizePixel = 0

ws.Parent = frame
ws.Size = UDim2.new(1,0,0.5,0)
ws.Position = UDim2.new(0,0,0.5,0)
ws.Text = "WS: " .. tostring(getgenv().whitescreen)
ws.TextColor3 = Color3.new(1,1,1)
ws.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
ws.BorderSizePixel = 0

if getgenv().whitescreen then
    rs:Set3dRenderingEnabled(false)
end

setfpscap(getgenv().fpslock)

spawn(function()
    while wait(0.1) do
        local val = tonumber(fps.Text)
        if val and val > 0 and val ~= getgenv().fpslock then
            getgenv().fpslock = val
            setfpscap(getgenv().fpslock)
        end
    end
end)

ws.MouseButton1Click:Connect(function()
    getgenv().whitescreen = not getgenv().whitescreen
    rs:Set3dRenderingEnabled(not getgenv().whitescreen)
    ws.Text = "WS: " .. tostring(getgenv().whitescreen)
end)
