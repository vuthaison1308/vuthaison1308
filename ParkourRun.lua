getgenv().HopDelay = nil -- nhap thoi gian delay hop
getgenv().Hop = true
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
if getgenv().HopDelay == nil then
    getgenv().HopDelay = 2
end
spawn(function()
	for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
    		if v.Name ~= "CurrentStages" and v.Name ~= "Lobby" then
        		v:Destroy()
    		end
	end
end)
spawn(function()
    while wait() do
        while wait() do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").CurrentStages.RunEnd.EndWall.Position)
        end
    end
end)
spawn(function()
    wait(getgenv().HopDelay)
    if getgenv().Hop then
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/vuthaison1308/vuthaison1308/main/hopserver.lua")()
        module:Teleport(game.PlaceId)
    end
end)
