if not game:IsLoaded() then
	game.Loaded:Wait()
	print("Ready to do all your dirty work :/")
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local ActiveMission = ReplicatedStorage:WaitForChild("ActiveMission")
local StartRaid = ReplicatedStorage.Shared.Teleport:WaitForChild("StartRaid")
local MissionFinished = ReplicatedStorage.Shared.Missions:WaitForChild("MissionFinished")
local LeaveChoice = ReplicatedStorage.Shared.Missions:WaitForChild("LeaveChoice")
local NotifyReadyToLeave = ReplicatedStorage.Shared.Missions:WaitForChild("NotifyReadyToLeave")

local missionID = ActiveMission.Value
local level = ReplicatedStorage.Profiles[Player].Level.Value
    
local function autoLevel()
    -- Automatically ready up and choose to repeat dungeon in case of party leader change. (Used if you're being carried by a max level acc)
    LeaveChoice:FireServer("true")
    NotifyReadyToLeave:FireServer()

    -- Detect if player matches a new dungeon level threshold. If tp to new dungeon else repeat current dungeon
    if level == 100 then
        return
    elseif level == 90 then
        StartRaid:FireServer(27)
    elseif level == 75 then
        StartRaid:FireServer(25, 1)
    elseif level == 60 then
        StartRaid:FireServer(21)
    elseif level == 55 then
        StartRaid:FireServer(18, 1)
    elseif level == 50 then
        StartRaid:FireServer(19, 1)
    elseif level == 45 then
        StartRaid:FireServer(20, 1)
    elseif level == 40 then
        StartRaid:FireServer(16, 1)
    elseif level == 35 then
        StartRaid:FireServer(15, 1)
    elseif level == 30 then
        StartRaid:FireServer(14, 1)
    elseif level == 26 then
        StartRaid:FireServer(7, 1)
    elseif level == 22 then
        StartRaid:FireServer(13, 1)
    elseif level == 18 then
        StartRaid:FireServer(12, 1)
    elseif level == 15 then
        StartRaid:FireServer(11, 1)
    elseif level == 12 then
        StartRaid:FireServer(6, 1)
    elseif level == 10 then
        StartRaid:FireServer(4, 1)
    elseif level == 7 then
        StartRaid:FireServer(2, 1)
    elseif level == 4 then
        StartRaid:FireServer(3, 1)
    else
        -- 21 and 27 are towers. Don't fire with difficulty parameter in case of tower
        if missionID == 21 or missionID == 27 then
            StartRaid:FireServer(missionID)
        else
            StartRaid:FireServer(missionID, 1)
        end
    end
end

-- Run function when dungeon finishes
MissionFinished.OnClientEvent:Connect(function()
    autoLevel()
end)

-- Run function when tower finishes
if missionID == 21 or missionID == 27 then
    local TowerFinished = ReplicatedStorage.MissionScripts[missionID]:WaitForChild("TowerFinished")

    TowerFinished.OnClientEvent:Connect(function()
        autoLevel()
    end)
end
