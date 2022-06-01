spawn(function()
    while wait() do
        if _G.Farm then
            pcall(function()
                if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    Check()
                    repeat wait()
                    Tween(CFrameQuest)
                    until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 1
                    wait(.1)
                    local args = {
                        [1] = "StartQuest",
                        [2] = NaemQuest,
                        [3] = LevelQuest
                    }
                        
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    Tween(CFrame.new(4914.91113, 669.927673, 23.8101196, -0.87213403, 4.64109107e-08, 0.489267021, 1.01547881e-08, 1, -7.67568054e-08, -0.489267021, -6.19738216e-08, -0.87213403))
                end
                if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    BringMon()
                end
            end)
        end
    end
end)

function BringMon()
    Check()
    local mob = game:GetService("Workspace").Enemies:GetChildren()
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    for i,v in pairs(mob) do
        for l,e in pairs(mob) do
            if v.Name == Ms then
                if e.Name == Ms then
                    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                    end
                    e.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                    if sethiddenproperty then
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  10000)
                    end
                    AutoClick()
                    EquipMelee()
                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                    e.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(20,20,20)
                    e.HumanoidRootPart.Size = Vector3.new(20,20,20)
                end
            end
        end
    end
end

function Tween(P1)
    Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 50 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P1
    elseif Distance > 1000 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
    Clip = true
    wait(Distance/Speed)
    Clip = false
end

function Check()
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    if MyLevel >= 1650 then
        Ms = "Giant Islander [Lv. 1650]"
        NaemQuest = "AmazonQuest2"
        LevelQuest = 2
        NameMon = "Giant Islander"
        CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
        PosQuest = Vector3.new(5448.86133, 601.516174, 751.130676)
        CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
        PosMon = Vector3.new(4530.3540039063, 656.75695800781, -131.60952758789)
    end
end

    function EquipMelee()
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" then
                if v.ToolTip == "Melee" then
                    if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                        local ToolSe = tostring(v.Name)
                        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
                        wait(.1)
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                end
            end
        end
    end

    function AutoClick()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
    end
